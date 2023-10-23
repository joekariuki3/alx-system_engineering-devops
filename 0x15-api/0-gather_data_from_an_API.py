#!/usr/bin/python3
"""
Script to that takes an integer sa an
id and gets data from a API
"""
if __name__ == '__main__':
    import requests
    import sys

    if len(sys.argv) > 1:
        user_id = sys.argv[1]
        if user_id.isdigit():
            user_id = int(user_id)
            url_user = f'https://jsonplaceholder.typicode.com/users/{user_id}'
            response_user = requests.get(url_user)
            user_data = response_user.json()
            user = user_data.get('name')
            url = 'https://jsonplaceholder.typicode.com/todos/'
            response = requests.get(url)
            all_to_do = response.json()
            not_done = 0
            done_to_do = []
            for to_do in all_to_do:
                if user_id == to_do.get('userId'):
                    if not to_do.get('completed'):
                        not_done += 1
                    else:
                        done_to_do.append(to_do.get('title'))
            d_len = len(done_to_do)
            total = d_len + not_done
            print(f"Employee {user} is done with tasks({d_len}/{total}):")
            for to_do in done_to_do:
                print(f"\t {to_do}")
