tests = {
    "not_present": {
        "data" : {"x":{"y":{"z": {"u":"a"}}}},
        "key" : "a"
        },
    "interim_key_in_nest": {
        "data" : {"x":{"y":{"z": {"u":"a"}}}},
        "key" : "z"
        },
    "last_key_in_nest": {
        "data" : {"x":{"y":{"z": {"u":"a"}}}},
        "key" : "u"
        },
    "first_key_in_nest": {
        "data" : {"x":{"y":{"z": {"u":"a"}}}},
        "key" : "x"
        },
    "complex_nesting": {
        "data" : {"x":
                  {"y":
                   {"z":
                    {"u":"a",
                    "v":"s"}
                    }
                    }
                    },
        "key" : "z"
        }
}

def get_final_key(data):
    key = list(data.keys())[0]
    if len(list(data.keys())) >1:
        print("Multiple key value at same nest level detected")
    while type(data) == dict:
        data = data[key]
        if type(data) != dict:
            break
        else:
            if len(list(data.keys())) >1:
                print("Multiple key value at same nest level detected, will choose the first")
            key = list(data.keys())[0]
    return(data)

def traverse(data, key):
    if type(data) is not dict:
        print("Reached the end of dict, key not found")
    elif key in data.keys():
        print(get_final_key(data))
        raise Exception("Stop")
    else:
        nestedkey = list(data.keys())[0]
        return(traverse(data[nestedkey],key))
try:
    print("Testing for : not_present ")
    traverse(tests["not_present"]["data"],tests["not_present"]["key"])
except Exception as e:
    print(e)
    pass
try:
    print("Testing for : interim_key_in_nest ")
    traverse(tests["interim_key_in_nest"]["data"],tests["interim_key_in_nest"]["key"])
except Exception as e:
    print(e)
    pass
try:
    print("Testing for : last_key_in_nest ")
    traverse(tests["last_key_in_nest"]["data"],tests["last_key_in_nest"]["key"])
except Exception as e:
    print(e)
    pass
try:
    print("Testing for : first_key_in_nest ")
    traverse(tests["first_key_in_nest"]["data"],tests["first_key_in_nest"]["key"])
except Exception as e:
    print(e)
    pass
try:
    print("Testing for : complex_nesting ")
    traverse(tests["complex_nesting"]["data"],tests["complex_nesting"]["key"])
except Exception as e:
    print(e)
    pass
