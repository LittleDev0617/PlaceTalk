from requests import post, get, Session
from naver_parser import link2lat_lon
import json
import string

HOST_API = 'http://localhost:80/api/'

# for line in open('../README.md', 'r', encoding='utf-8').readlines():
#     if 'GET' in line or 'POST' in line:
#         api = line[4:].rstrip()
#         method, url = api.split()
#         print(f'[{method}\t{url}](#{"".join(filter(lambda x: x in string.ascii_lowercase + string.digits + " _", api.lower())).replace(" ", "-")})  ')
    
    
# exit()

s = Session()
r = s.get(HOST_API+'users/auth?token=0')

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
        

# add_place()

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
        r = s.post(HOST_API+f'places/1/booth', data=myBooth, files=images)
        print(r.text)

add_booth()

r = s.get(HOST_API+f'places/1/booth')
print(r.text)

def add_feed():
    global s

    feed_session = [Session() for _ in range(3)]
    feed_author = ['경영대 주막', '총학생회', '사범대 주막']
    feed_data = [
        {
            'content' : '안녕하세요. 경영대에서 안내드립니다.\n금일 경영대 주막 10시부터 개시합니다.'
        }, 
        {
            'content' : '이번 축제 행사는 정말 열심히 준비했습니다\n열심히 준비한만큼 다들 즐겨주셨으면 좋겠습니다\n행사당일날 뵙겠습니다^^'
        },
        {
            'content' : '사범대 주막에서 오코노미야끼, 야끼소바 판매합니다.\n맛은 보장드리오니 많이들 와주세요.'
        }
    ]

    for i in range(3):
        r = feed_session[i].get(HOST_API+f'users/auth?token={i+1}')

    for i in range(3):
        r = s.get(HOST_API+f'users/grant-org?user_id={i+1}&place_id=1')
        r = s.get(HOST_API+f'users/set-nickname?nickname={feed_author[i]}&user_id={i+1}&place_id=1')         

        booth_images = [['image1.png', 'image2.png', 'image3.png'], ['image4.png'], ['image5.png'], ['image6.png'], ['image7.png']]

        images = []

        for image in booth_images[i]:
            images.append(('images', (image, open('media/' + image, 'rb').read())))

        r = feed_session[i].post(HOST_API+f'places/1/feed', data=feed_data[i], files=images)
        print(r.text)

    
# add_feed()
    
r = s.get(HOST_API+f'places/1/feed')
print(r.text)

def add_info():
    global s

    txt = open("./info_list.txt", 'r', encoding='utf-8').read()
    infos = txt.split('\n------------------------------------------------\n')
    for info in infos:        
        data = info.split('\n')
        myInfo = {}        
        myInfo['title'] = data[0]
        myInfo['content'] = '\n'.join(data[1:])
        myInfo['is_schedule'] = myInfo['title'] == '일정표'        
        
        r = s.post(HOST_API+f'places/1/info', json=myInfo)
        print(r.text)
    
# add_info()
    
r = s.get(HOST_API+f'places/1/info')
print(r.text)
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