# 

import aiohttp
import json

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
                callback(data)
            except aiohttp.EofStream:
                break
        response.close()
