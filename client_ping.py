#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
@date: 2017-01-18
@author: Shell.Xu
@copyright: 2017, Eleme <zhixiang.xu@ele.me>
@license: MIT
'''
from __future__ import absolute_import, division,\
    print_function, unicode_literals
import time
import requests

BASEURL = 'http://localhost:6666'


def once():
    resp = requests.post(BASEURL+'/ping')
    print(resp.status_code)
    print(resp.content)


def main():
    once()


if __name__ == '__main__':
    main()
