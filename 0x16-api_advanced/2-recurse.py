#!/usr/bin/bash
"""function to return a list of all titles of a subreddit"""

import requests


def recurse(subreddit, hot_list=[], after=None):
    """return titles  of subreddit
    or none if subreddit does not exist"""
    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0'}
    params = {'after': after} if after else {}
    response = requests.get(url, headers=headers, params=params)

    if response.status_code == 200:
        data = response.json()
        posts = data['data']['children']
        after = data['data']['after']

        for post in posts:
            hot_list.append(post['data']['title'])

        if after:
            """Recursively call the function with the 'after' parameter"""
            return recurse(subreddit, hot_list, after)
        else:
            """If there are no more pages, return the final hot_list"""
            return hot_list
    else:
        """If the subreddit is invalid or there is an error, return None"""
        return None
