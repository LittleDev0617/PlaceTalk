# PlaceTalk

DB erd : https://www.erdcloud.com/d/eD3zQ8h4hSHC4ivWs

# User

user_id : kakao token
level : access level

- 0 : admin
- 1 : organizer
- 2 : guest

# SERVER API

바로가기

- User  
  [GET /api/users/place](#get-apiusersplace)  
  [GET /api/users/post](#get-apiuserspost)

- Place  
  [GET /api/places](#get-apiplaces)  
  [POST /api/places](#post-apiplaces)  
  [GET /api/places/:place_id](#get-apiplacesplace_id)  
  [GET /api/places/:place_id/join](#get-apiplacesplace_idjoin)

- Booth  
  [GET /api/booths](#get-apibooths)  
  [GET /api/booths/:location_id](#get-apiboothslocation_id)  
  [POST /api/booths](#post-apibooths)

- Feed  
  [GET /api/feeds](#get-apifeeds)  
  [GET /api/feeds/feed_id](#get-apifeedsfeed_id)  
  [POST /api/feeds](#post-apifeeds)

- Info  
  [GET /api/infos](#get-apiinfos)  
  [GET /api/infos/:info_id](#get-apiinfosinfo_id)  
  [POST /api/infos](#post-apiinfos)

- Post  
  [GET /api/posts](#get-apiposts)  
  [POST /api/posts](#post-apiposts)  
  [GET /api/posts/:post_id](#get-apipostspost_id)  
  [GET /api/posts/:post_id/like](#get-apipostspost_idlike)

- Comment  
  [GET /api/comments](#get-apicomments)  
  [POST /api/comments](#post-apicomments)  
  [GET /api/comments/:comment_id/like](#get-apicommentscomment_idlike)

## User

```c
{
  "user_id" : int,
  "nickname" : string,
  "email" : string
}
```

### GET /api/users/mypage

유저의 정보를 조회합니다.

### Response

```json
{
  "user_id": 1,
  "nickname": "관리자",
  "email": "test@example.com"
}
```




### GET /api/users/post

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

- name : 이름 필터
- user_id : 필터
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

특정 핫플레이스 조회

#### Request

\*place_id - path parameter

#### Response

- `Place`  
  place_id 에 해당하는 place 에 대한 정보를 반환합니다.

```json
[
  {
    "place_id": 1,
    "name": "건국대 X 세종대 축제",
    "category": "대학 축제",
    "state": 1,
    "start_date": "2023-09-14 00:00:00",
    "end_date": "2023-09-16 00:00:00",
    "count": 0,
    "locations": [
      {
        "location_id": 1,
        "loc_name": "건국대",
        "lat": 37.54388829908806,
        "lon": 127.07595459999982
      },
      {
        "location_id": 2,
        "loc_name": "세종대",
        "lat": 37.55147059908805,
        "lon": 127.0738839999998
      }
    ]
  }
]
```

### GET /api/places/:place_id/join

place_id 에 참가합니다.

#### Request

\*place_id - path parameter

#### Response

<hr />

### GET /api/places/:place_id/exit

place_id 에서 나옵니다.

#### Request

\*place_id - path parameter

#### Response

<hr />

### GET /api/places/top10

top10 place 조회

#### Request

#### Response

- `List<Place>`  
  운영진이 설정한 top 10 핫플/행사를 반환합니다.

```json
[
  {
    "place_id": 1,
    "name": "건국대 X 세종대 축제",
    "category": "대학 축제",
    "state": 1,
    "start_date": "2023-09-14 00:00:00",
    "end_date": "2023-09-16 00:00:00",
    "top10": 1,
    "count": 0,
    "locations": [
      {
        "location_id": 1,
        "loc_name": "건국대",
        "lat": 37.54388829908806,
        "lon": 127.07595459999982
      },
      {
        "location_id": 2,
        "loc_name": "세종대",
        "lat": 37.55147059908805,
        "lon": 127.0738839999998
      }
    ],
    "images": []
  },
  {
    "place_id": 11,
    "name": "광주 충장축제",
    "category": "지역 축제",
    "state": 1,
    "start_date": "2023-10-05 00:00:00",
    "end_date": "2023-10-10 00:00:00",
    "top10": 1,
    "count": 0,
    "locations": [
      {
        "location_id": 14,
        "loc_name": "",
        "lat": 35.146081810230456,
        "lon": 126.9232859315818
      }
    ],
    "images": []
  },
  {
    "place_id": 16,
    "name": "현대카드 다빈치모텔",
    "category": "콘서트",
    "state": 1,
    "start_date": "2023-10-14 00:00:00",
    "end_date": "2023-10-17 00:00:00",
    "top10": 1,
    "count": 0,
    "locations": [
      {
        "location_id": 19,
        "loc_name": "",
        "lat": 37.53669429999992,
        "lon": 127.00067419999976
      }
    ],
    "images": []
  }
  ...
]
```

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

### GET /api/booths

부스 조회

#### Request

\*location_id : 필터링

#### Response

- `List<Booth>`  
  location_id 에 등록된 모든 부스 정보를 반환합니다.

```json
// /api/booths?location_id=1
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
  }
]
```

<hr />

### GET /api/booths/:booth_id

특정 부스 조회

#### Request

\*booth_id

#### Response

- `List<Booth>`  
  booth_id 부스 정보를 반환합니다.

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
  }
]
```

<hr />

### POST /api/booths

부스 추가

#### Request

- \*location_id
- \*name : 부스 이름
- \*content : 부스 설명
- \*on_time : "18:00 ~ 20:00" 과 같은 문자열
- \*location
- images : 이미지 파일 배열

#### Response

location_id 에 해당하는 행사 에 부스를 등록합니다.

<hr />

## Feed

```c
{
    "feed_id" : int,
    "place_id" : int,
    "user_id" : int,
    "content" : string,
    "nickname" : string,  // 전체 조회시(필터링 X) 해당 장소 이름. 아니면 게시자 닉네임
    "write_time" : datetime,
    "images" : List<Image>
}
```

### GET /api/feeds

핫플/행사 피드 조회

#### Request

- place_id : 설정 시 place_id 핫플 피드 조회
- offset
- feedPerPage

#### Response

- `List<Feed>`

```json
// /api/feeds
[
  {
    "feed_id": 67,
    "place_id": 16,
    "user_id": 1,
    "content": "지성과 감성의 콜라보레이션 스테이 '현대카드 다빈치모텔'이 돌아왔습니다. 10월 14일(금)부터 16일(일)까지 개최..",
    "write_time": "2023-09-30 18:00:00",
    "images": [
      { "image_id": "181093cb-93d0-45fd-b493-657d2ff96714.png", "order": 0 },
      { "image_id": "3789f396-e896-4e21-8372-0ba9f1f9f07c.png", "order": 1 },
      { "image_id": "90bc2dfd-7327-4172-a600-fc9c124a1ad8.png", "order": 2 },
      { "image_id": "979d2f62-3afd-4940-98eb-3e512a2bc928.png", "order": 3 },
      { "image_id": "2c9fe8b9-35dc-4f98-890e-cb19a3690afc.png", "order": 4 }
    ],
    "nickname": "현대카드 다빈치모텔"
  },
  {
    "feed_id": 76,
    "place_id": 1,
    "user_id": 10,
    "content": "이번 축제 행사는 정말 열심히 준비했습니다.\n열심히 준비한만큼 다들 즐겨주셨으면 좋겠습니다.\n행사 당일날 뵙겠습니다^^",
    "write_time": "2023-09-12 18:00:00",
    "images": [
      { "image_id": "cba931f5-58c6-406a-971d-42732aebf59c.png", "order": 0 },
      { "image_id": "dd31deb6-78fa-4a33-bf5f-1b34f79b6b05.png", "order": 1 },
      { "image_id": "b3372ecb-9979-4c50-b4f7-7bd091c92471.png", "order": 2 }
    ],
    "nickname": "건국대 X 세종대 축제"
  },
  {
    "feed_id": 68,
    "place_id": 11,
    "user_id": 2,
    "content": "지난해 코로나 확산 우려에 의해 취소되었던 광주충장 축제가 올해 10월 5일 개최됩니다. 사회적..",
    "write_time": "2023-09-11 18:00:00",
    "images": [
      { "image_id": "cc264559-adab-47af-a90d-17c2205f60d9.png", "order": 0 },
      { "image_id": "7cc13e3e-1cc2-40d1-88a7-1aa19e2fd3c8.png", "order": 1 },
      { "image_id": "09acb4a1-d176-40df-9bd4-e53ab3269933.png", "order": 2 }
    ],
    "nickname": "광주 충장축제"
  }
]
```

<hr />

### GET /api/feeds/feed_id

특정 피드 조회

#### Request

\*feed_id - path parameter

- offset
- feedPerPage

#### Response

- `List<Feed>`

```json
// /api/feeds/33
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

### POST /api/feeds

장소 피드 추가

#### Request

- \*place_id : 등록할 장소
- \*title
- \*content
- images

#### Response

해당 장소에 피드를 등록합니다.

<hr />

### PUT /api/feeds/:feed_id

### DELETE /api/feeds/:feed_id

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

### GET /api/infos

행사 정보 조회

#### Request

- place_id : 필터링
- is_schdule : 일정표면 1로 설정

#### Response

- `List<Info>`

/api/infos

```json
[
  {
    "info_id": 1,
    "place_id": 1,
    "title": "공연 안내",
    "content": "**공연명**      건국대학교 x 세종대학교 축제  \n**행사 일정**   2023년 9월 12일 ~ 9월 14일  \n**공연장**      건국대학교 서울캠퍼스 대강당  ",
    "is_schedule": 0
  },
  {
    "info_id": 2,
    "place_id": 1,
    "title": "초청 가수",
    "content": "### 9월 12일 (1일 차)\n비비(BIBI), 우원재  \n  \n### 9월 13일 (2일 차)\n에스파(aespa), 박재범, 데이식스, 효린  \n  \n### 9월 14일 (3일 차)\n볼빨간사춘기, 뉴진스(New jeans)  ",
    "is_schedule": 0
  }
]
```

<hr />

### GET /api/infos/:info_id

특정 행사 정보 조회

#### Request

- info_id

#### Response

- `List<Info>`

/api/infos/1

```json
[
  {
    "info_id": 1,
    "title": "공연 안내",
    "content": "**공연명**      건국대학교 x 세종대학교 축제  \n**행사 일정**   2023년 9월 12일 ~ 9월 14일  \n**공연장**      건국대학교 서울캠퍼스 대강당  "
  }
]
```

<hr />

### POST /api/infos

장소 행사 정보 추가

#### Request

- \*place_id
- \*title
- \*content
- is_schdule - 일정표면 1로 설정

#### Response

해당 장소에 행사 정보를 등록합니다.

<hr />

### PUT /api/infos/:info_id

### DELETE /api/infos/:info_id

<hr />

## Post - 게시글

```c
{
  "post_id": int,
  "user": User,
  "place_id": int,
  "create_date": datetime,
  "content": string,
  "likes": int,
  "commentCnt" : int
}
```

### GET /api/posts

post 조회

#### Request

- place_id : 필터링
- offset
- postPerPage
- likeOrder : 시간순 정렬(0) / 좋아요 정렬(1)

#### Response

offset \* postPerPage 부터 postPerPage 개수만큼 post 를 조회합니다.  
ex) offset - 2 / postPerPage - 5 / likeOrder - 0  
시간순으로 11번째 게시글부터 15번째 게시글을 불러옵니다.

Post List

/api/posts

```json
[
  {
    "post_id": 1,
    "create_date": "2023-08-15 18:15:06",
    "content": "오늘 비안오죠? 비오면 안되ㄴ는딩",
    "likes": 0,
    "commentCnt": 0,
    "user": {
      "user_id": 894316236,
      "nickname": "비둘기야밥먹자구구구",
      "email": "test@example.com"
    }
  },
  {
    "post_id": 2,
    "create_date": "2023-08-15 18:15:06",
    "content": "오늘 축제 몇시까지해여",
    "likes": 0,
    "commentCnt": 0,
    "user": {
      "user_id": 976218958,
      "nickname": "마감요정",
      "email": "test@example.com"
    }
  },
  {
    "post_id": 3,
    "create_date": "2023-08-15 18:15:06",
    "content": "황소상앞에 부스 괜찬나염",
    "likes": 0,
    "commentCnt": 0,
    "user": {
      "user_id": 752424328,
      "nickname": "glaemfdjdy",
      "email": "test@example.com"
    }
  },
  {
    "post_id": 4,
    "create_date": "2023-08-15 18:15:06",
    "content": "축제 음식 맛있나??",
    "likes": 0,
    "commentCnt": 0,
    "user": {
      "user_id": 51514446,
      "nickname": "팡팡파라파라팡팡팡",
      "email": "test@example.com"
    }
  }
]
```

<hr />

### GET /api/posts/:post_id

특정 post 조회

#### Request

- \*post_id

#### Response

- `Post`

```json
[
  {
    "post_id": 2,
    "create_date": "2023-08-15 18:15:06",
    "content": "오늘 축제 몇시까지해여",
    "likes": 0,
    "commentCnt": 0,
    "user": {
      "user_id": 976218958,
      "nickname": "마감요정",
      "email": "test@example.com"
    }
  }
]
```

<hr />

### POST /api/posts

post 생성

#### Request

- \*place_id
- \*title
- \*content

#### Response

place_id 에 해당하는 핫플레이스에 게시글을 추가합니다.

<hr />

### PUT /api/posts/:post_id

post 수정

#### Request

- \*post_id
- \*title
- \*content

#### Response

post_id 에 해당하는 게시글 내용을 수정합니다.

<hr />

### DELETE /api/posts/:post_id

post 삭제

#### Request

- \*post_id

#### Response

post_id 에 해당하는 게시글 내용을 삭제합니다.

<hr />

### GET /api/posts/:post_id/like

좋아요 추가 / 해제

#### Request

- \*post_id

#### Response

좋아요를 누른 상태이면 해제, 안 누른 상태면 등록합니다.

<hr />

## Comment

```c
{
  "comment_id" : int,
  "place_id" : int,
  "user" : User,
  "is_reply" : int, // 0 or 1
  "reply_id" : int, // comment_id
  "likes" : int,
  "content" : string,
  "create_date" : datetime
}
```

### GET /api/comments

한 게시글의 댓글 조회

#### REQUEST

- \*post_id

#### Response

게시글 작성자가 작성한 댓글의 user_id 는 0 입니다.  
이외의 댓글은 날짜순으로 1 2 3.. 으로 설정됩니다.

<hr />

### POST /api/comments

댓글 등록

#### Request

- \*post_id
- \*is_reply : 대댓인지 여부 0 or 1
- \*reply_id : 대댓이면 대댓 단 원 댓글 comment_id
- \*content : 댓글 내용

#### Response

<hr />

### DELETE /api/comments/:comment_id

댓글 삭제

#### Request

- \*post_id
- \*comment_id

#### Response

<hr />

### GET /api/comments/:comment_id/like

댓글 좋아요 추가 / 해제

#### Request

- \*comment_id

#### Response

좋아요를 누른 상태이면 해제, 안 누른 상태면 등록합니다.

<hr />
