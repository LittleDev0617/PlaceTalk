from requests import post, get, Session
import json

url = 'http://localhost:3000/api/'
s = Session()
r = s.get(url+'users/auth?token=0')
# print(r.cookies)

r = s.get(url+f'users/place')
print(r.text)

def add_place(name, start, end, latitude, longitude):
    hot_place = {
        'placeName' : 'hot_place2',
        'description'  : 'description for hot_place2',
        'state'     : 0,
        'startDate' : '2023-08-15 12:00:00',
        'endDate'   : '2023-08-16 12:00:00',
        'latitude'  : 56.78,
        'longitude' : 32.45
    }

    r = s.post(url+f'places/add', json=hot_place)
    print(r.text)


# add_place(1,2,3,4,5)
r = s.get(url+f'places/1')
print(r.text)

r = s.get(url+f'places')
print(r.text)