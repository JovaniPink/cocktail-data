# -*- coding: utf-8 -*-
# TODO:
# 1. Look into opening JSON files...
# Docs: https://docs.python.org/3/library/json.html?highlight=json
# 
# 
# 

import json
import os
import typing


temp_dict = {}


def map_values(obj, fn):
    ret = {}
    for key in obj.keys():
        ret[key] = fn(obj[key])
    return ret


def json_extract(obj, key):
    """Recursively fetch values from nested JSON."""
    arr = {}

    def extract(obj, arr, key):
        """Recursively search for values of key in JSON tree."""
        if isinstance(obj, dict):
            for k, v in obj.items():
                if isinstance(v, (dict, list)) and k != key:
                    extract(v, arr, key)
                elif k == key:
                    arr[obj["id"]] = obj[key]
        elif isinstance(obj, list):
            for item in obj:
                extract(item, arr, key)
        return arr

    values = extract(obj, arr, key)
    return values

# def double_check_dict(dict):
#    return(key, value in dict.items() if value == val)

def find_keys(dict, val):
   return list(key for key, value in dict.items() if value == val and isinstance(value, (dict, list)))

file_to_load = os.path.join("data/cocktails.json")

with open(file_to_load, "r") as cocktail_data:
    cocktail_data_loaded = json.load(cocktail_data)
    # json.dump(json_extract(cocktail_data_loaded, "ingredients"), open("out.json", "w"))
    temp_dict = find_keys(json_extract(cocktail_data_loaded, "ingredients"), "Cranberry Juice")

print(temp_dict)