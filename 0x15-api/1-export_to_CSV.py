#!/usr/bin/python3
"""
Script to that takes an integer sa an
id and gets data from a API
"""
if __name__ == '__main__':
    import csv
    import requests
    import sys

    if len(sys.argv) > 1:
        user_id = sys.argv[1]
        if user_id.isdigit():
            user_id = int(user_id)
            url_user = f'https://jsonplaceholder.typicode.com/users/{user_id}'
            response_user = requests.get(url_user)
            user_data = response_user.json()
            user = user_data.get('username')
            url = 'https://jsonplaceholder.typicode.com/todos/'
            response = requests.get(url)
            all_to_do = response.json()
            not_done = 0
            row = []
            all_data = []
            for to_do in all_to_do:
                if user_id == to_do.get('userId'):
                    row.append(str(user_id))
                    row.append(user)
                    status = to_do.get('completed')
                    row.append(str(status))
                    task = to_do.get('title')
                    row.append(task)
                    all_data.append(row)
                    row = []
            with open(f'{user_id}.csv', 'w', encoding='utf-8') as csvfile:
                writter = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
                writter.writerows(all_data)
