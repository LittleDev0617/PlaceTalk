from requests import post, get, Session
from naver_parser import link2lat_lon
import json
from random import randint
import glob
HOST_API = 'http://localhost:3000/api/'

# for line in open('API.md', 'r', encoding='utf-8').readlines():
#     if 'GET' in line or 'POST' in line:
#         api = line[4:].rstrip()
#         method, url = api.split()
#         print(f'[{method}\t{url}](#{"".join(filter(lambda x: x in string.ascii_lowercase + string.digits + " _", api.lower())).replace(" ", "-")})  ')
    
    
# exit()
ADMIN_TOKEN = int(open('./utils/admin.token', 'r').read())
admin = Session()
r = admin.get(HOST_API+f'users/auth?token={ADMIN_TOKEN}')

front = Session()
r = front.get(HOST_API+f'users/auth?token={2955408317}')
# 링크 검사
# import re
# txt = open("./naver_map_list.txt", 'r', encoding='utf-8').read()

# for m in re.findall('https://naver.me/.*\n', txt):    
#     print(m.rstrip())
#     lat, lon = link2lat_lon(m.rstrip())

# exit()

def searchPlace(name):
    return json.loads(admin.get(HOST_API+f'places?name={name}').text)[0]

def searchPost(content):
    return json.loads(admin.get(HOST_API+f'posts?content={content}').text)[0]


def add_place():
    global admin
    txt = open("./naver_map_list.txt", 'r', encoding='utf-8').read()
    places = txt.split('\n\n')
    top10List = open("./top10_list.txt", 'r', encoding='utf-8').read().split('\n')    

    tmp = ['리얼월드 성수', '페더 엘리아스 내한공연', '플라츠2', '플라츠S', '충주 다이브 페스티벌']

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

        myPlace['locations'] = json.dumps(myPlace['locations'])

        if name in top10List:
            files = glob.glob('media/top10/*.png')
            image = files[top10List.index(name)]
            images = {'image' : (image, open(image, 'rb'))}
            
            print(name)
            r = admin.post(HOST_API+f'places', data=myPlace, files=images)            
        elif name in tmp:
            files = glob.glob('media/place/*')            
            image = files[tmp.index(name)]
            images = {'image' : (image, open(image, 'rb'))}
            
            print(name)
            r = admin.post(HOST_API+f'places', data=myPlace, files=images)            
        else:
            r = admin.post(HOST_API+f'places', json=myPlace)
        print(r.text)
        
# add_place()

# r = admin.get(HOST_API+f'places/20/join')
# print(r.text)

r = admin.get(HOST_API+f'users/place')
print(r.text)

r = admin.get(HOST_API+f'places/1')
print(r.text)


lat, lon = link2lat_lon('https://naver.me/x0GsZ73h')
r = admin.get(HOST_API+f'places?lat={lat}&lon={lon}&dist=1')
print(r.text)



def add_booth():
    global admin
    #  name, content, on_time, loc_name, lat, lon

    txt = open("./booth_list.txt", 'r', encoding='utf-8').read()
    for place in txt.split('\n-----------------------------------------------\n'):
        placeName = place.split('\n')[0]
        location_id = searchPlace(placeName)['locations'][0]['location_id']
        booths = '\n'.join(place.split('\n')[1:]).split('\n\n')

        files = list(glob.glob(f'./media/booth/{placeName}/*.png'))
        print(files)
        files.sort(key=lambda x: int(x.split('\\image')[1].split('.')[0]))

        fileIndex = 0

        for i, booth in enumerate(booths):
            data = booth.split('\n')
            myBooth = {}        
            myBooth['location_id'] = location_id
            myBooth['name'] = data[0]
            myBooth['on_time'] = data[1]
            myBooth['content'] = '\n'.join(data[5:])
            myBooth['location'] = {}
            myBooth['location']['loc_name'] = data[2]
            myBooth['location']['lat'], myBooth['location']['lon'] = link2lat_lon(data[3])
            
            images = []
            imageCnt = int(data[4])

            for image in files[fileIndex:fileIndex+imageCnt]:
                images.append(('images', (image, open(image, 'rb').read())))
            
            myBooth['location'] = json.dumps(myBooth['location'])
            r = admin.post(HOST_API+f'booths', data=myBooth, files=images)
            print(r.text)
            fileIndex += imageCnt
# add_booth()

r = admin.get(HOST_API+f'booths/1')
print(r.text)

def add_feed():
    global admin

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

        place_id = searchPlace(placeName)['place_id']

        r = admin.get(HOST_API+f'users/grant-org?user_id={i+1}&place_id={place_id}')
        r = admin.get(HOST_API+f'users/change-nickname?nickname={author}&user_id={i+1}&place_id={place_id}')  
        
        images = []
        for image in files[fileIndex:fileIndex+imageCnt]:
            images.append(('images', (image, open(image, 'rb').read())))
        
        feed = { 'content': content, 'date':date, 'place_id':place_id }
        # print(i,feed)
        r = feed_session.post(HOST_API+f'feeds', data=feed, files=images)
        print(r.text)

        fileIndex += imageCnt



# add_feed()
    
r = admin.get(HOST_API+f'feeds/1')
print(r.text)

def add_info():
    global admin

    txt = open("./info_list.txt", 'r', encoding='utf-8').read()
    infos = txt.split('\n------------------------------------------------------------------------------------------------\n')
    for info in infos:        
        data = info.split('\n')
        placeName = data[0]
        place_id = searchPlace(placeName)['place_id']
        myInfo = { 'place_id': place_id }

        contents = '\n'.join(data[1:]).split('\n------------------------------------------------\n')
        
        for content in contents:
            data2 = content.split('\n')            
            myInfo['title'] = data2[0]            
            myInfo['content'] = '\n'.join(data2[1:])
            myInfo['is_schedule'] = int(myInfo['title'] == '일정표')
        
            r = admin.post(HOST_API+f'infos', json=myInfo)
            print(r.text)
# add_info()

    
r = admin.get(HOST_API+f'infos?place_id=1')
print(r.text)

r = front.get(HOST_API+f'places/1/join')
print(r.text)

r = front.get(HOST_API+f'places/12/join')
print(r.text)

r = front.get(HOST_API+f'places/33/join')
print(r.text)

r = front.get(HOST_API+f'places/13/join')
print(r.text)

front.get(HOST_API+f'places/33/exit')

def add_post():
    global admin
    txt = open("./post_list.txt", 'r', encoding='utf-8').read()
    
    for posts in reversed(txt.split('\n\n')):
        data = posts.split("\n")
        placeName = data[0]
        nickname = data[1]
        content = '\n'.join(data[2:])

        place_id = searchPlace(placeName)['place_id']

        myPost = { 'place_id' : place_id, 'content': content }

        post_session = Session()
        post_session.get(HOST_API+f'users/auth?token={randint(30,1000000000)}&nickname={nickname}')
        post_session.get(HOST_API+f'users/join/{place_id}')
        r = post_session.post(HOST_API+'posts', json=myPost)
        print(r.text)

def add_comment():
    global admin
    txt = open("./comment_list.txt", 'r', encoding='utf-8').read()
    
    for comments in reversed(txt.split('\n\n')):
        data = comments.split("\n")
        placeName, post_content, nickname = data[:3]        

        content = '\n'.join(data[3:])

        post_id = searchPost(post_content)['post_id']

        mycomment = { 'post_id' : post_id, 'content': content, 'is_reply': 0, 'reply_id': 0 }

        comment_session = Session()
        comment_session.get(HOST_API+f'users/auth?token={randint(300,1000000000)}&nickname={nickname}')
        # comment_session.get(HOST_API+f'users/join/{post_id}')
        r = comment_session.post(HOST_API+'comments', json=mycomment)
        print(r.text)

# myPost = { 'place_id' : 1, 'content': input() }
# test = Session()
# test.get(HOST_API+f'users/auth?token={636228018}')
# test.get(HOST_API+f'users/join/{1}')
# r = test.put(HOST_API+'posts/12')

# myPost = { 'place_id' : 1, 'content': input() }

# test = Session()
# test.get(HOST_API+f'users/auth?token={636228018}')
# test.get(HOST_API+f'users/join/{1}')
# r = test.post(HOST_API+'posts', json=myPost)
# add_post()

def add_top10():
    global admin
    txt = open("./top10_list.txt", 'r', encoding='utf-8').read()
    
    for i, placeName in enumerate(txt.splitlines()):
        place_id = searchPlace(placeName)['place_id']
        r = admin.post(HOST_API+f'places/top10', json={'place_id':place_id, 'order':i+1})
        print(r.text)

# add_top10()

# add_place()
# add_booth()
# add_feed()
# add_info()
# add_top10()
# add_post()
# add_comment()

# 게시글 좋아요
# for i in range(42):
#     test = Session()
#     test.get(HOST_API+f'users/auth?token={353452+i}')
#     test.get(HOST_API+f'users/join/{1}')
#     test.get(HOST_API+f'posts/{(randint(1,1000) % 9) + 1}/like')

test = Session()
test.get(HOST_API+f'users/auth?token=2966688008')
test.get(HOST_API+f'places/1/join')
test.get(HOST_API+f'places/31/join')
test.get(HOST_API+f'places/32/join')
test.get(HOST_API+f'places/35/join')
test.get(HOST_API+f'places/34/join')
test.get(HOST_API+f'places/36/join')
# exit()
# print(r.cookies)

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

#     r = admin.post(url+f'places', json=hot_place)
#     print(r.text)

add_place(1,2,3,4,5)

# import time

# time.sleep(1)

r = admin.get(url+f'places/1/join')
print(r.text)


r = admin.get(url+f'places?lat=')
print(r.text)