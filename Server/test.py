from requests import post, get, Session
from naver_parser import link2lat_lon
import json
import string

url = 'http://localhost:3000/api/'

for line in open('../README.md', 'r', encoding='utf-8').readlines():
    if 'GET' in line or 'POST' in line:
        api = line[4:].rstrip()
        method, url = api.split()
        print(f'[{method}\t{url}](#{"".join(filter(lambda x: x in string.ascii_lowercase + string.digits + " _", api.lower())).replace(" ", "-")})  ')
    
    
exit()


def add_place():
    '''
    https://naver.me/Gh846DFX
    >>> r.history[1].url
        'https://map.naver.com/v5?summaryCard=14146210.138743695%7C4516139.686555475%7Cplace%7C31949741'
    '''
    txt = open("./naver_map_list.txt", 'r', encoding='utf-8').read()
    places = txt.split('\n\n')
    for place in places:
        name = place.split('\n')[0]
        for link in place.split('\n')[1:]:
            r = get(link)
            lat, lon = link2lat_lon(r.history[1].url)
            print(lat, lon)

add_place()
exit()
s = Session()
r = s.get(url+'users/auth?token=0')
# print(r.cookies)

r = s.get(url+f'users/place')
print(r.text)

# def add_place(name, start, end, latitude, longitude):
#     hot_place = {
#         'placeName' : '건국대 X 세종대 축제',
#         'category'  : '대학축제',
#         'state'     : 1,
#         'startDate' : '2023-08-15 12:00:00',
#         'endDate'   : '2023-08-16 12:00:00',
#         'locations' :
#             [
#                 {
#                     'lat'  : 37.54388829908806,
#                     'lon' : 127.07595459999982
#                 },
#                 {
#                     'lat'  : 37.55147059908805,
#                     'lon' : 127.0738839999998
#                 }
#             ]
#     }

#     r = s.post(url+f'places', json=hot_place)
#     print(r.text)


# add_place(1,2,3,4,5)

# import time

# time.sleep(1)

r = s.get(url+f'places/1/join')
print(r.text)


r = s.get(url+f'places?lat=')
print(r.text)