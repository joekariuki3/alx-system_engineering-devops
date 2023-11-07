#!/usr/bin/python3
"""funtions that gets the top 10 subreddit title"""

import requests


def top_ten(subreddit):
    """return 10 tiles of subreddit"""
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0'}
    resp = requests.get(url, headers)
    if resp.status_code == 200:
        alldata = resp.json()
        alldata = alldata['data']['children']
        for data in alldata:
            post = data['data']
            title = post['title']
            print(title)
    else:
        print(None)
