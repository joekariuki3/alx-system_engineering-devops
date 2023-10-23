#!/usr/bin/python3
"""
Script to that takes an integer sa an
id and gets data from a API
"""
if __name__ == '__main__':
    import json
    import requests
    import sys

    file_name = 'todo_all_employees.json'
    url_users = f'https://jsonplaceholder.typicode.com/users'
    response_users = requests.get(url_users)
    users_data = response_users.json()
    url = 'https://jsonplaceholder.typicode.com/todos/'
    response = requests.get(url)
    all_to_do = response.json()
    row = []
    all_data = {}
    for user_data in users_data:
        # loop through each user
        user = user_data.get('username')
        user_id = user_data.get('id')
        for to_do in all_to_do:
            # check each to_do n match it to current user
            if user_id == to_do.get('userId'):
                status = to_do.get('completed')
                task = str(to_do.get('title'))
                obj = {"task": task,
                       "completed": status,
                       "username": user
                       }
                row.append(obj)
        # dictionary
        all_data[str(user_id)] = row
        row = []
        # json object
        json_data = json.dumps(all_data)
        with open(file_name, 'w', encoding='utf-8') as jsonfile:
            json.dump(all_data, jsonfile)
