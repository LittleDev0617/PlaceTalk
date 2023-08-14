# PlaceTalk

DB erd : https://www.erdcloud.com/d/eD3zQ8h4hSHC4ivWs

# User

user_id : kakao token
level : access level

- 0 : admin
- 1 : organizer
- 2 : guest

# SERVER API

[GET /api/users/place](#get-apiusersplace)  
[GET /api/places](#get-apiplaces)  
[POST /api/places](#post-apiplaces)  
[GET /api/places/:place_id](#get-apiplacesplace_id)  
[GET /api/places/:place_id/join](#get-apiplacesplace_idjoin)  
[GET /api/places/:place_id/booth](#get-apiplacesplace_idbooth)  
[POST /api/places/:place_id/booth](#post-apiplacesplace_idbooth)  
[GET /api/places/feed](#get-apiplacesfeed)  
[GET /api/places/:place_id/feed](#get-apiplacesplace_idfeed)  
[POST /api/places/:place_id/feed](#post-apiplacesplace_idfeed)  
[GET /api/places/:place_id/info](#get-apiplacesplace_idinfo)  
[POST /api/places/:place_id/info](#post-apiplacesplace_idinfo)  
[GET /api/posts/:place_id](#get-apipostsplace_id)  
[POST /api/posts/:place_id](#post-apipostsplace_id)  
[GET /api/posts/:place_id/:post_id](#get-apipostsplace_idpost_id)  
[GET /api/posts/:post_id/like](#get-apipostspost_idlike)  
[GET /api/posts/:post_id/comments](#get-apipostspost_idcomments)  
[POST /api/posts/:post_id/comments](#post-apipostspost_idcomments)

## User

### GET /api/users/place

#### Request

#### Response

## Place - 핫플레이스

### TYPE STRUCTURE

#### Place

```c
{
    "place_id"      : int,
    "name"          : string,
    "category"      : string,
    "state"         : int,    // 0 : 핫플 / 1 : 행사
    "start_date"    : datetime,
    "end_date"      : datetime,
    "locations"     : List<Location>
}
```

#### Location

```c
{
    "location_id" : int,
    "loc_name" : string,
    "lat"   : double,   // 위도
    "lon"   : double    // 경도
}
```

#### Image

```c
{
    "image_id" : string,  // http://server_address/images/image_id 로 이미지 url 사용
    "order" : int // 이미지 순서
}
```

<hr />

### GET /api/places

핫플레이스 조회

#### Request

1. 카테고리별 조회
2. 현재 위치 반경 n km 이내 조회
3. date 이후의 행사들 조회

- category : 카테고리 필터
- lat / lon / dist => 반경 n km 이내 조회 시 사용
  - lat : 사용자 위치 위도
  - lon : 사용자 위치 경도
  - dist : 거리(km)
- date : date 이후의 행사들 조회 (YYYY-mm-dd 형식)

#### Response

`List<Place>`  
조건에 만족하는 place 들에 대한 정보를 반환합니다.

```json
[
  {
    "place_id": 1,
    "name": "단국대 축제",
    "category": "대학 축제",
    "state": 1,
    "start_date": "2023-09-21 00:00:00",
    "end_date": "2023-09-23 00:00:00",
    "count": 1,
    "locations": [
      {
        "location_id": 1,
        "loc_name": "",
        "lat": 37.32072779909,
        "lon": 127.12768109999979
      }
    ]
  },
  {
    "place_id": 2,
    "name": "성균관대 축제",
    "category": "대학 축제",
    "state": 1,
    "start_date": "2023-09-29 00:00:00",
    "end_date": "2023-10-01 00:00:00",
    "count": 0,
    "locations": [
      {
        "location_id": 2,
        "loc_name": "인문",
        "lat": 37.58795349999993,
        "lon": 126.99215939999974
      },
      {
        "location_id": 3,
        "loc_name": "자연",
        "lat": 37.293363799090244,
        "lon": 126.97465449999983
      }
    ]
  }
]
```

<hr />

### POST /api/places

핫플레이스 추가

#### Request

place_id - path parameter

- \*description : 핫플 설명
- \*state : 상시 핫플(0) / 일시 핫플(1)
- \*locations : List<Location>

#### Response

새로운 place를 등록합니다.

<hr />

### GET /api/places/:place_id

핫플레이스 조회

#### Request

\*place_id - path parameter

#### Response

- `Place`  
  place_id 에 해당하는 place 에 대한 정보를 반환합니다.

```json
[
  {
    "place_id": 1,
    "name": "hot_place1",
    "description": "description for hot_place1",
    "state": 0,
    "start_date": "2023-08-12 12:00:00",
    "end_date": "2023-08-13 12:00:00",
    "locations": [
      {
        "lat": 56.78,
        "lon": 43.43
      }
    ],
    "count": 0
  }
]
```

### GET /api/places/:place_id/join

핫플레이스 참가

#### Request

\*place_id - path parameter

#### Response

place_id 에 해당하는 place 에 현재 사용자가 참여합니다.

<hr />

## Booth

```c
{
    "booth_id" : int,
    "name" : string,
    "content" : string,
    "on_time" : string,
    "locations": List<Location>,
    "images" : List<Image>
}
```

### GET /api/places/:place_id/booth

부스 조회

#### Request

\*location_id - path parameter

#### Response

- `List<Booth>`  
  location_id 에 등록된 모든 부스 정보를 반환합니다.

```json
[
  {
    "booth_id": 11,
    "name": "경영대 주막",
    "content": "황소상 앞에서 경영대 주막을 오픈했습니다.\n이경영 배우의 컨셉을 빌려 재밌는 행사를 기획했습니다.",
    "on_time": "10:00 ~ 18:00",
    "locations": [
      {
        "location_id": 62,
        "loc_name": "황소상 앞",
        "lat": 37.54318850007482,
        "lon": 127.0760683998827
      }
    ],
    "images": [
      {
        "image_id": "5678-qwer.png",
        "order": 0
      }
    ]
  },
  {
    "booth_id": 12,
    "name": "사범대  주막",
    "content": "교육과학관 앞에서 사범대 주막을 오픈했습니다.",
    "on_time": "10:00 ~ 18:00",
    "locations": [
      {
        "location_id": 63,
        "loc_name": "교육과학관 앞",
        "lat": 37.54403999999994,
        "lon": 127.07421419999974
      }
    ],
    "images": [
      {
        "image_id": "5678-qwer.png",
        "order": 0
      }
    ]
  },
  {
    "booth_id": 13,
    "name": "동물생명대 주막",
    "content": "청심대 옆에서 동물생명대 주막을 오픈했습니다.",
    "on_time": "10:00 ~ 18:00",
    "locations": [
      {
        "location_id": 64,
        "loc_name": "청심 대 옆",
        "lat": 37.54241209999992,
        "lon": 127.0768532999997
      }
    ],
    "images": [
      {
        "image_id": "5678-qwer.png",
        "order": 0
      }
    ]
  }
]
```

<hr />

### POST /api/places/:place_id/booth

부스 추가

#### Request

\*place_id - path parameter

- \*name : 부스 이름
- \*content : 부스 설명
- \*on_time : "18:00 ~ 20:00" 과 같은 문자열
- \*location
- images : 이미지 파일 배열

#### Response

place_id 에 해당하는 place 에 부스를 등록합니다.

<hr />

## Feed

```c
{
    "feed_id" : int,
    "place_id" : int,
    "user_id" : int,
    "content" : string,
    "nickname" : string,
    "write_time" : datetime,
    "images" : List<Image>
}
```

### GET /api/places/feed

모든 핫플/행사 피드 조회

#### Request

- offset
- feedPerPage

#### Response

- `List<Feed>`
```json
[
  {
    "feed_id": 26,
    "place_id": 16,
    "user_id": 1,
    "content": "이 돌아왔습니다. 10월 14일(금)부터 16일(일)까지 개최..",
    "write_time": "2023-09-30 18:00:00",
    "images": [
      { "image_id": "9cbb6ffc-58b0-4bda-aaa3-c69c62d7ab62.png", "order": 0 },
      { "image_id": "2dd98d88-657c-4895-addb-b25848316f2a.png", "order": 1 },
      { "image_id": "aba8e48c-4bbb-4a71-991e-981992d06987.png", "order": 2 },
      { "image_id": "2bff558a-f422-4caf-a98d-add9dfa158ea.png", "order": 3 },
      { "image_id": "619f00e4-62c2-486c-b53f-1170710fbc58.png", "order": 4 }
    ],
    "nickname": "관리자"
  },
  {
    "feed_id": 35,
    "place_id": 1,
    "user_id": 10,
    "content": "열심히 준비한만큼 다들 즐겨주셨으면 좋겠습니다.\n행사 당일날 뵙겠습니다^^",
    "write_time": "2023-09-12 18:00:00",
    "images": [
      { "image_id": "4252991c-71ef-4fdb-a5f1-da0b5a154cdd.png", "order": 0 },
      { "image_id": "5cf51577-20a6-4e97-8d53-e7b9dfc83b11.png", "order": 1 },
      { "image_id": "9ed49e02-1fe8-4526-ae16-9880f1f13c52.png", "order": 2 }
    ],
    "nickname": "경영대 주점"
  },
  {
    "feed_id": 27,
    "place_id": 11,
    "user_id": 2,
    "content": "축제가 올해 10월 5일 개최됩니다. 사회적..",
    "write_time": "2023-09-11 18:00:00",
    "images": [
      { "image_id": "d1b96bde-a150-4858-a365-54f5dce093bd.png", "order": 0 },
      { "image_id": "fbaf46c4-5132-43c6-b9b9-3d71cf3f3399.png", "order": 1 },
      { "image_id": "7e8b4f6a-db4a-4f9d-908c-7482f2dfca19.png", "order": 2 }
    ],
    "nickname": "관리자"
  }
]

```
<hr />

### GET /api/places/:place_id/feed

특정 장소 피드 조회

#### Request

\*place_id - path parameter

- offset
- feedPerPage

#### Response

- `List<Feed>`
```json
[
  {
    "feed_id": 33,
    "place_id": 31,
    "user_id": 8,
    "content": "설레임! 1km구간에 걸쳐 펼쳐진 서핑 전용 해변과 스위..",
    "write_time": "2023-06-28 18:00:00",
    "images": [
      { "image_id": "12708d6f-ba0a-43ab-a27e-da7f53b2dcf6.png", "order": 0 },
      { "image_id": "3bf7d85c-b7d2-46ab-9e44-90466783a40f.png", "order": 1 },
      { "image_id": "ba9c3673-8899-49c3-bf61-98a11b98747e.png", "order": 2 }
    ],
    "nickname": "관리자"
  }
]
```
<hr />

### POST /api/places/:place_id/feed

장소 피드 추가

#### Request

\*place_id - path parameter

- \*title
- \*content
- images

#### Response

해당 장소에 피드를 등록합니다.

<hr />

### PUT /api/places/:place_id/feed/:feed_id

장소 피드 수정

#### Request

\*place_id - path parameter  
\*feed_id - path parameter

- \*content

#### Response

해당 장소에 피드를 등록합니다.

<hr />

### DELETE /api/places/:place_id/feed/:feed_id

장소 피드 삭제

#### Request

\*place_id - path parameter  
\*feed_id - path parameter

#### Response

해당 장소에 피드를 등록합니다.

<hr />

## Info

```c
{
    "info_id" : int,
    "place_id" : int,
    "title" : string,
    "content" : string,
    "is_schedule" : int // 0 : 행사정보 / 1: 일정표
}
```

### GET /api/places/:place_id/info

특정 장소 행사 정보 조회

#### Request

\*place_id - path parameter

- is_schdule : 일정표면 1로 설정

#### Response

- `List<Info>`

<hr />

### POST /api/places/:place_id/info

장소 행사 정보 추가

#### Request

\*place_id - path parameter

- \*title
- \*content
- is_schdule - 일정표면 1로 설정

#### Response

해당 장소에 행사 정보를 등록합니다.

<hr />

### PUT /api/places/:place_id/info/:info_id

장소 행사 정보 수정

#### Request

\*place_id - path parameter  
\*info_id - path parameter

- \*title
- \*content

#### Response

해당 장소에 행사 정보를 등록합니다.

<hr />

### DELETE /api/places/:place_id/info/:info_id

장소 행사 정보 삭제

#### Request

\*place_id - path parameter  
\*feed_id - path parameter

#### Response

해당 장소에 행사 정보를 등록합니다.

<hr />

## Post - 게시글

### GET /api/posts/:place_id

post 조회

#### Request

- \*place_id
- offset
- postPerPage
- likeOrder : 시간순 정렬(0) / 좋아요 정렬(1)

#### Response

offset \* postPerPage 부터 postPerPage 개수만큼 post 를 조회합니다.  
ex) offset - 2 / postPerPage - 5 / likeOrder - 0  
시간순으로 11번째 게시글부터 15번째 게시글을 불러옵니다.

Post List

```json

```

<hr />

### POST /api/posts/:place_id

post 생성

#### Request

- \*place_id
- \*title
- \*content

#### Response

place_id 에 해당하는 핫플레이스에 게시글을 추가합니다.

<hr />

### GET /api/posts/:place_id/:post_id

post 조회

#### Request

- \*place_id
- \*post_id

#### Response

place_id 핫플레이스의 post_id post 를 조회합니다.

Post

```json
[{}]
```

<hr />

### PUT /api/posts/:post_id

post 수정

#### Request

- \*post_id

#### Response

post_id 에 해당하는 게시글 내용을 수정합니다.

<hr />

### DELETE /api/posts/:post_id

post 삭제

#### Request

- \*post_id

#### Response

post_id 에 해당하는 게시글 내용을 수정합니다.

<hr />

### GET /api/posts/:post_id/like

좋아요 추가 / 해제

#### Request

- \*post_id

#### Response

좋아요를 누른 상태이면 해제, 안 누른 상태면 등록합니다.

<hr />

## Comment

### GET /api/posts/:post_id/comments

post_id 게시글의 댓글 모두 조회

#### REQUEST

- \*post_id

#### Response

게시글 작성자가 작성한 댓글의 user_id 는 0 입니다.  
이외의 댓글은 날짜순으로 1 2 3.. 으로 설정됩니다.

<hr />

### POST /api/posts/:post_id/comments

댓글 등록

#### Request

- \*post_id
- \*is_reply : 대댓인지 여부 0 or 1
- \*reply_id : 대댓이면 대댓 단 원 댓글 comment_id

#### Response

post_id 에 해당하는 게시글 내용을 수정합니다.

<hr />

### DELETE /api/posts/:post_id/comments/:comment_id

댓글 삭제

#### Request

- \*post_id
- \*comment_id

#### Response

post_id 에 해당하는 게시글 내용을 수정합니다.

<hr />
