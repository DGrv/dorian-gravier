import datetime
import os.path
import re
import csv
import json
import pprint
pp = pprint.PrettyPrinter(depth=4)
import urllib.request, json 

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

# If modifying these scopes, delete the file token.json.
# All info here : https://developers.google.com/calendar/api/quickstart/python
SCOPES = ["https://www.googleapis.com/auth/calendar"]

# calendar ID
cID="c68b1567d9cb7dcf87bd496cfdde9e473ea36c74499bc78db7ac1f653ba00865@group.calendar.google.com"

# json api
apijsonrr = "https://api.raceresult.com/370831/ANPSEOUEK8L69XG3IRBDMQKV4SGIRHUN"


def main():
  """Shows basic usage of the Google Calendar API.
  Prints the start and name of the next 10 events on the user's calendar.
  """
  creds = None
  # The file token.json stores the user's access and refresh tokens, and is
  # created automatically when the authorization flow completes for the first
  # time.
  credipath = "C:\\Users\\doria\\Downloads\\secret\\credi.json"
  tokenpath = "C:\\Users\\doria\\Downloads\\secret\\tokenDori.json"

  if os.path.exists(tokenpath):
    creds = Credentials.from_authorized_user_file(tokenpath, SCOPES)
  # If there are no (valid) credentials available, let the user log in.
  if not creds or not creds.valid:
    if creds and creds.expired and creds.refresh_token:
      creds.refresh(Request())
    else:
      flow = InstalledAppFlow.from_client_secrets_file(
          credipath, SCOPES
      )
      creds = flow.run_local_server(port=0)
    # Save the credentials for the next run
    with open(tokenpath, "w") as token:
      token.write(creds.to_json())

  try:
    # need to set it global in order to use it outside the function
    global service
    service = build("calendar", "v3", credentials=creds)

    # Call the Calendar API
    # now = datetime.datetime.utcnow().isoformat() + "Z"  # 'Z' indicates UTC time
    # print("Getting the upcoming 10 events")
    events_result = (
        service.events()
        .list(
            calendarId=cID,
            # timeMin=now,
            # maxResults=100,
            singleEvents=True,
            orderBy="startTime",
            showDeleted=True # need this to update deleted ones
        )
        .execute()
    )
    global events
    events = events_result.get("items", [])

    # if not events:
    #   print("No upcoming events found.")
    #   return

    # Prints the start and name of the next 10 events
    # for event in events:
    #   start = event["start"].get("dateTime", event["start"].get("date"))
    #   print(start, event["summary"])
  
  except HttpError as error:
    print(f"An error occurred: {error}")
    

# Refer to the Python quickstart on how to setup the environment:
# https://developers.google.com/calendar/quickstart/python
# Change the scope to 'https://www.googleapis.com/auth/calendar' and delete any
# stored credentials.
   
if __name__ == "__main__":
  main()





# # if you need to delete all from this calendar do this
# pp.pprint(events)
# for i in range(0, len(events)):
#   try:
#     service.events().delete(calendarId=cID, eventId=events[i].get("id")).execute()
#   except HttpError as error:
#     # fail if id exist to avoid duplicates
#     print(f"An error occurred: {error}")







# get the api from RR
with urllib.request.urlopen(apijsonrr) as url:
    json_object = json.load(url)

# pretty print
datav=json.dumps(json_object, indent=1)
# transform in dict python
data=json.loads(json.dumps(json_object))

# create empty dict
ndata={}

for i in range(0, len(data)): 
  # reformat the date
  # all info here https://developers.google.com/calendar/api/v3/reference/events/import
  startdate = re.sub(r"(\d\d)/(\d\d)/(\d\d\d\d)", r"\3", data[i].get("Start Date")) + "-" + re.sub(r"(\d\d)/(\d\d)/(\d\d\d\d)", r"\2", data[i].get("Start Date")) + "-" + re.sub(r"(\d\d)/(\d\d)/(\d\d\d\d)", r"\1", data[i].get("Start Date"))
  enddate = re.sub(r"(\d\d)/(\d\d)/(\d\d\d\d)", r"\3", data[i].get("End Date")) + "-" + re.sub(r"(\d\d)/(\d\d)/(\d\d\d\d)", r"\2", data[i].get("End Date")) + "-" + re.sub(r"(\d\d)/(\d\d)/(\d\d\d\d)", r"\1", data[i].get("End Date"))

  ndata[i]={"summary": data[i].get("Subject"), 
    "description": data[i].get("Description"),
    "location": data[i].get("Location"),
    "start": {"date": startdate},
    "end": {"date": enddate},
    # id have 5 character minimum, use the bib from the event
    "id": "{:05d}".format(data[i].get("Bib")),
    'reminders': {
      'useDefault': False,
      'overrides': [
        {'method': 'popup', 'minutes': 24 * 60 * 7},
        {'method': 'popup', 'minutes': 24*60*7*3},
      ],
    }
  }


# debug print
# pp.pprint(data)
# print(ndata)
pp.pprint(ndata)
# ndata[0]
eventsids = [events[i].get("id") for i in range(0,len(events))]
print("Events ids:")
print("\n".join(eventsids))

for i in range(0, len(ndata)):
  print("Event from json, id:"+ndata[i].get("id"))
  try:
    # https://stackoverflow.com/questions/67483927/google-calendar-api-deleting-a-event-does-not-delete-an-event-id
    if ndata[i].get("id") in eventsids:
      print("\tEvend id exist ---> update")
      service.events().update(calendarId=cID, eventId=ndata[i].get("id"), body=ndata[i]).execute()
    else:
      print("\tEvend id created")
      service.events().insert(calendarId=cID, body=ndata[i]).execute()
  except HttpError as error:
    # fail if id exist to avoid duplicates
    print(f"An error occurred: {error}")



