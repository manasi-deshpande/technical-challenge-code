import requests

key = input("Enter the metadata key : ")
headers = {
    'X-aws-ec2-metadata-token-ttl-seconds': '21600',
}
print("Getting the token")
response = requests.put('http://169.254.169.254/latest/api/token', headers=headers)
TOKEN = response.text
print("Getting the metdata - ")

headers = {
    'X-aws-ec2-metadata-token': TOKEN,
}
response = requests.get('http://169.254.169.254/latest/meta-data/' + str(key), headers=headers)
print(response.text)
