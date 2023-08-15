from requests import post, get, Session
from naver_parser import link2lat_lon
import json
from random import randint

HOST_API = 'http://localhost:3000/api/'

# for line in open('API.md', 'r', encoding='utf-8').readlines():
#     if 'GET' in line or 'POST' in line:
#         api = line[4:].rstrip()
#         method, url = api.split()
#         print(f'[{method}\t{url}](#{"".join(filter(lambda x: x in string.ascii_lowercase + string.digits + " _", api.lower())).replace(" ", "-")})  ')
    
    
# exit()
ADMIN_TOKEN = int(open('./utils/admin.token', 'r').read())
s = Session()
r = s.get(HOST_API+f'users/auth?token={ADMIN_TOKEN}')

# 링크 검사
# import re
# txt = open("./naver_map_list.txt", 'r', encoding='utf-8').read()

# for m in re.findall('https://naver.me/.*\n', txt):    
#     print(m.rstrip())
#     lat, lon = link2lat_lon(m.rstrip())

# exit()

def add_place():
    global s
    txt = open("./naver_map_list.txt", 'r', encoding='utf-8').read()
    places = txt.split('\n\n')
    for place in places:
        name = place.split('\n')[0]
        kind = place.split('\n')[1]
        category = place.split('\n')[2]
        myPlace = { 'placeName' : name, 'category' : category, 'state' : ['핫플', '행사'].index(kind), 'locations' : [] }

        start, end = place.split('\n')[3:5]
        links = place.split('\n')[5:]
        myPlace['startDate'] = start
        myPlace['endDate'] = end
        
        
        for link in links:            
            loc_name, url = link.split(' ')
            lat, lon = link2lat_lon(url)
            myPlace['locations'].append({'loc_name' : loc_name, 'lat' : lat, 'lon' : lon })

        r = s.post(HOST_API+f'places', json=myPlace)
        print(r.text)
        

add_place()

# r = s.get(HOST_API+f'places/20/join')
# print(r.text)

r = s.get(HOST_API+f'users/place')
print(r.text)

r = s.get(HOST_API+f'places/1')
print(r.text)


lat, lon = link2lat_lon('https://naver.me/x0GsZ73h')
r = s.get(HOST_API+f'places?lat={lat}&lon={lon}&dist=1')
print(r.text)



def add_booth():
    global s
    #  name, content, on_time, loc_name, lat, lon 
    naver_link = ['https://naver.me/x3qUn8vB', 'https://naver.me/xq5mz4jK']
    # booth_data = [
    #     {
    #         "name": "경영대 주막",
    #         "on_time": "10:00 ~ 18:00",
    #         "content": "황소상 앞에서 경영대 주막을 오픈했습니다.",
    #         "location": {
    #             "loc_name": "황소상 앞",
    #             "lat": 123,
    #             "lon": 23
    #         }
    #     },
    #     {
    #         "name": "사범대 주막",
    #         "on_time": "10:00 ~ 18:00",
    #         "content": "사범대 주막 설명입니다.",
    #         "location": {
    #             "loc_name": "교육과학관 앞",
    #             "lat": 124,
    #             "lon": 22
    #         }
    #     }
    # ]

    booth_images = [['image1.png', 'image2.png', 'image3.png'], ['image4.png'], ['image5.png'], ['image6.png'], ['image7.png']]
    
    txt = open("./booth_list.txt", 'r', encoding='utf-8').read()
    booths = txt.split('\n\n')
    for i, booth in enumerate(booths):        
        
        data = booth.split('\n')
        myBooth = {}        
        myBooth['location_id'] = 1
        myBooth['name'] = data[0]
        myBooth['on_time'] = data[1]
        myBooth['content'] = '\n'.join(data[4:])
        myBooth['location'] = {}
        myBooth['location']['loc_name'] = data[2]
        myBooth['location']['lat'], myBooth['location']['lon'] = link2lat_lon(data[3])
        
        images = []

        for image in booth_images[i]:
            images.append(('images', (image, open('media/' + image, 'rb').read())))
        
        myBooth['location'] = json.dumps(myBooth['location'])
        r = s.post(HOST_API+f'booths', data=myBooth, files=images)
        print(r.text)

add_booth()

r = s.get(HOST_API+f'booths/1')
print(r.text)

import glob
def add_feed():
    global s

    files = list(glob.glob('./media/feed/*.png'))
    files.sort(key=lambda x: int(x.split('\\')[1].split('.')[0]))

    fileIndex = 0
    feeds = open('feed_list.txt', 'r', encoding='utf-8').read().split('\n\n')
    
    for i, feed in enumerate(feeds):
        data = feed.split('\n')
        placeName, author, date, imageCnt = data[:4]
        content = '\n'.join(data[4:])
        imageCnt = int(imageCnt)
        date += ' 18:00:00'

        feed_session = Session()
        feed_session.get(HOST_API+f'users/auth?token={i+1}')

        r = s.get(HOST_API+f'places?name={placeName}')
        place_id = json.loads(r.text)[0]['place_id']

        r = s.get(HOST_API+f'users/grant-org?user_id={i+1}&place_id={place_id}')
        r = s.get(HOST_API+f'users/change-nickname?nickname={author}&user_id={i+1}&place_id={place_id}')  

        images = []
        for image in files[fileIndex:fileIndex+imageCnt]:
            images.append(('images', (image, open(image, 'rb').read())))
        
        feed = { 'content': content, 'date':date, 'place_id':place_id }
        # print(i,feed)
        r = feed_session.post(HOST_API+f'feeds', data=feed, files=images)
        print(r.text)

        fileIndex += imageCnt



    
add_feed()
    
r = s.get(HOST_API+f'feeds/1')
print(r.text)

def add_info():
    global s

    txt = open("./info_list.txt", 'r', encoding='utf-8').read()
    infos = txt.split('\n------------------------------------------------\n')
    for info in infos:        
        data = info.split('\n')
        myInfo = { 'place_id': 1 }
        myInfo['title'] = data[0]
        myInfo['content'] = '\n'.join(data[1:])
        myInfo['is_schedule'] = myInfo['title'] == '일정표'        
        
        r = s.post(HOST_API+f'infos', json=myInfo)
        print(r.text)
    
add_info()
    
r = s.get(HOST_API+f'infos?place_id=1')
print(r.text)


r = s.get(HOST_API+f'users/join/12')
print(r.text)

r = s.get(HOST_API+f'users/join/33')
print(r.text)

r = s.get(HOST_API+f'users/join/5')
print(r.text)

def add_post():
    global s
    txt = open("./post_list.txt", 'r', encoding='utf-8').read()
    
    for posts in reversed(txt.split('\n\n')):
        data = posts.split("\n")
        placeName = data[0]
        nickname = data[1]
        content = '\n'.join(data[2:])

        place_id = json.loads(s.get(HOST_API+f'places?name={placeName}').text)[0]['place_id']

        myPost = { 'place_id' : place_id, 'content': content }

        post_session = Session()
        post_session.get(HOST_API+f'users/auth?token={randint(30,1000000000)}&nickname={nickname}')
        post_session.get(HOST_API+f'users/join/{place_id}')
        r = post_session.post(HOST_API+'posts', json=myPost)
        print(r.text)

add_post()

def add_top10():
    global s
    txt = open("./top10_list.txt", 'r', encoding='utf-8').read()
    
    for placeName in txt.splitlines():
        place_id = json.loads(s.get(HOST_API+f'places?name={placeName}').text)[0]['place_id']
        r = s.post(HOST_API+f'places/top10', json={'place_id':place_id})
        print(r.text)


# add_top10()


exit()
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