#!/usr/bin/env python

from ConfigParser import SafeConfigParser

import vk

config = SafeConfigParser()
config.read('/home/illan/.illan.cnf')

access_token = config.get('vk', 'access_token')

session = vk.Session(access_token=access_token)
api = vk.API(session, v='5.60')

messages = api.messages.getDialogs(unread=True)

print messages.get('count')

