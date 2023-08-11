# PlaceTalk

DB erd : https://www.erdcloud.com/d/eD3zQ8h4hSHC4ivWs

# User

user_id : kakao token
level : access level

- 0 : admin
- 1 : organizer
- 2 : guest

# SERVER API

## User

## Place - 핫플레이스

### TYPE STRUCTURE

#### Place

```c
{
    "place_id"      : int,
    "name"          : string,
    "description"   : string,
    "state"         : int,
    "start_date"    : datetime,
    "end_date"      : datetime,
    "latitude"      : double,   // 위도
    "longitude"     : double    // 경도
}
```

<hr />

### GET /api/places
모든 핫플레이스 조회  

#### Request

#### Response

모든 place 들에 대한 정보를 반환합니다.

```json
[
  {
    "place_id": 1,
    "name": "hot_place1",
    "description": "description for hot_place1",
    "state": 0,
    "start_date": "2023-08-12 12:00:00",
    "end_date": "2023-08-13 12:00:00",
    "latitude": 34.43,
    "longitude": 12.34,
    "count": 0
  },
  {
    "place_id": 2,
    "name": "hot_place2",
    "description": "description for hot_place2",
    "state": 0,
    "start_date": "2023-08-15 12:00:00",
    "end_date": "2023-08-16 12:00:00",
    "latitude": 56.78,
    "longitude": 32.45,
    "count": 0
  }
]
```

<hr />

### POST /api/places/
핫플레이스 추가  

#### Request

place_id - path parameter

- \*placeName : 핫플 이름
- \*description : 핫플 설명
- \*state : 상시 핫플(0) / 일시 핫플(1)
- \*latitude : 위도
- \*longitude : 경도

#### Response

새로운 place를 등록합니다.

<hr />

### GET /api/places/:place_id
핫플레이스 조회  

#### Request

\*place_id - path parameter

#### Response

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
    "latitude": 34.43,
    "longitude": 12.34,
    "count": 0
  }
]
```

<hr />

### GET /api/places/:place_id/booth
부스 조회  

#### Request

\*place_id - path parameter

#### Response

place_id 에 해당하는 place 의 여러 부스들을 조회합니다.

<hr />

### POST /api/places/:place_id/booth
부스 추가  

#### Request

\*place_id - path parameter

- \*name : 부스 이름
- \*content : 부스 설명
- \*detail : 부스 위치 ex) 예대 앞
- \*latitude : 위도
- \*longitude : 경도

#### Response

place_id 에 해당하는 place 에 부스를 등록합니다.

<hr />

### POST /api/places/:place_id/join
핫플레이스 참가  

#### Request

\*place_id - path parameter

#### Response

place_id 에 해당하는 place 에 현재 사용자가 참여합니다.

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
[
	{

	}
]
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
- \*is_reply  : 대댓인지 여부  0 or 1
- \*reply_id  : 대댓이면 대댓 단 원 댓글 comment_id

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

