#!/usr/bin/python3
"""function that queries the Reddit API, parses the title
of all hot articles, and prints a sorted count of
given keywords (case-insensitive, delimited by spaces"""

import requests


def count_words(subreddit, word_list, after=None, count={}):
    """return count of word in the wordlist how many times
    they appear in all tles of subredit"""

    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0'}
    params = {'after': after} if after else {}
    response = requests.get(url, headers=headers, params=params)

    if response.status_code == 200:
        data = response.json()
        posts = data['data']['children']
        after = data['data']['after']

        for post in posts:
            title = post['data']['title'].split(" ")
            for word in word_list:
                word = word.lower()
                for string in title:
                    string = string.lower()
                    if string == word:
                        if word in count:
                            w = word
                            count['{}'.format(w)] = count['{}'.format(w)] + 1
                        else:
                            count['{}'.format(word)] = 1

        if after:
            """Recursively call the function with the 'after' parameter"""
            return count_words(subreddit, word_list, after, count)
        else:
            """If there are no more pages, return the final count"""
            sc = dict(sorted(count.items(), key=lambda x: x[1], reverse=True))
            for key, value in sc.items():
                print("{}: {}".format(key, value))
    else:
        """If the subreddit is invalid or there is an error, return None"""
        return None
