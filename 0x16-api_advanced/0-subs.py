#!/usr/bin/python3
"""script to query Redit API and return a subscribers for a given subreddit"""

import requests


def number_of_subscribers(subreddit):
    """return subscribers of given subredit"""
    headers = {'User-Agent': 'Mozilla/5.0'}
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    result = requests.get(url, headers)
    if result.status_code == 200:
        jsondata = result.json()
        subscribers = jsondata['data']['subscribers']
        return subscribers
    return 0
