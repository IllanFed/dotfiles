#!/usr/bin/env python

import os
import httplib2

from apiclient import discovery
from oauth2client import client
from oauth2client import tools
from oauth2client.file import Storage

try:
    import argparse
    flags = argparse.ArgumentParser(parents=[tools.argparser]).parse_args()
except ImportError:
    flags = None

CLIENT_SECRET_FILE = 'gmail_checker_secret.json'
CLIENT_STORAGE_FILE = 'gmail_checker_storage.json'
SCOPE = 'https://www.googleapis.com/auth/gmail.labels'
APP_NAME = 'gmail_checker'
EMAIL = 'illanfed@gmail.com'

def get_credentials():
    home_dir = os.path.expanduser('~')
    credential_dir = os.path.join(home_dir, '.credentials')
    credential_path = os.path.join(credential_dir, CLIENT_STORAGE_FILE)
    client_secret_path = os.path.join(credential_dir, CLIENT_SECRET_FILE)

    store = Storage(credential_path)
    credentials = store.get()
    if not credentials or credentials.invalid:
        flow = client.flow_from_clientsecrets(client_secret_path, SCOPE)
	flow.user_agent = APP_NAME
	if flags:
	    credentials = tools.run_flow(flow, store, flags)
	else:
	    credentials = tools.run(flow, store)

    return credentials

credentials = get_credentials()
http = credentials.authorize(httplib2.Http())
gmail_service = discovery.build('gmail', 'v1', http=http)

labels_api = gmail_service.users().labels
personal = labels_api().get(userId=EMAIL, id='CATEGORY_PERSONAL').execute()
social = labels_api().get(userId=EMAIL, id='CATEGORY_SOCIAL').execute()

total_unread = personal.get('messagesUnread') + social.get('messagesUnread')

print total_unread

