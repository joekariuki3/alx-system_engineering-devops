#!/usr/bin/python3
"""
Script to that takes an integer sa an
id and gets data from a API
"""

import requests
import sys


if len(sys.argv) > 1:
    user_id = sys.argv[1]
    if user_id.isdigit():
        user_id = int(user_id)
        url_user = f'https://jsonplaceholder.typicode.com/users/{user_id}'
        response_user = requests.get(url_user)
        user_data = response_user.json()
        user_name = user_data.get('name')
        url = 'https://jsonplaceholder.typicode.com/todos/'
        response = requests.get(url)
        all_to_do = response.json()
        ad_length = len(all_to_do)
        finished_to_do = 0
        done_to_do = []
        for to_do in all_to_do:
            if user_id == to_do.get('userId'):
                if to_do.get('completed'):
                    finished_to_do += 1
                    done_to_do.append(to_do.get('title'))
        d_len = len(done_to_do)
        print(f'Employee {user_name} is done with tasks({d_len}/{ad_length}):')
        for to_do in done_to_do:
            print(f"\t{to_do}")
