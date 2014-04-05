# 

import urllib
import aiohttp
import json
import datetime as dt


class Docker:
    def __init__(self, url):
        self.url = url

    def _endpoint(self, path, **kwargs):
        string = "/".join([self.url, path])
        if kwargs:
            string += "?" + urllib.parse.urlencode(kwargs)
        return string

    def _query(self, path, **kwargs):
        response = yield from aiohttp.request(
            'GET', self._endpoint(path, **kwargs))
        chunk = yield from response.content.read()  # XXX: Correct?
        print(chunk)
        return json.loads(chunk.decode('utf-8'))

    def events(self, callback):
        response = yield from aiohttp.request('GET', self._endpoint('events'))
        while True:
            try:
                chunk = yield from response.content.read()  # XXX: Correct?
                data = json.loads(chunk.decode('utf-8'))
                if 'time' in data:
                    data['time'] = dt.datetime.fromtimestamp(data['time'])
                callback(data)
            except aiohttp.EofStream:
                break
        response.close()
