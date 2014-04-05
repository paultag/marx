# 

import aiohttp
import json
import datetime as dt

class Docker:
    def __init__(self, url):
        self.url = url

    def _endpoint(self, path):
        return "/".join([self.url, path])

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
