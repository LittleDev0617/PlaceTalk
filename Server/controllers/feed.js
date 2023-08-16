const conn = require("../utils/db");
const { getImages, createImage } = require("./image");
const { getLocations, createLocation } = require("./location");
const { getPlaces } = require("./place");
const { isOrganizerOfPlace, getNickname } = require("./user");

async function getFeeds(options) {
    const { offset, feedPerPage } = options;

    let query = 'SELECT * FROM tb_feed WHERE 1=1';
    let obj = [];

    if(options.place_id) {
        query += ' AND place_id = ?';
        obj.push(options.place_id);
    }

    if(options.feed_id) {
        query += ' AND feed_id = ?';
        obj.push(options.feed_id);
    }    

    query += ' ORDER BY write_time DESC LIMIT ?, ?';
    obj.push(offset);
    obj.push(feedPerPage);

    const feeds = await conn.query(query, obj);
    let res = [];

    for(let feed of feeds) {
        feed.images = [];
        
        const place = await getPlaces({ place_id: feed.place_id });
        // feed.place = { place_id: place[0].place_id, name: place[0].name };

        const images = await getImages({ id: 'feed_id', value: feed.feed_id });
        Object.assign(feed.images, images);

        // 전체 피드 조회시 장소 이름. 아니면 게시자 닉네임
        feed.nickname = obj.length == 2 ? place[0].name : (await getNickname(feed.user_id))[0].nickname;        

        res.push(feed);
    }
    return res;
}

// feed : nickname, content
async function createFeed(feedInfo, place_id, user_id) {
    const { content,date, images } = feedInfo;

    const feed_id = (await conn.query('INSERT INTO tb_feed(place_id, user_id, content, write_time) VALUES(?, ?, ?, ?)', [place_id, user_id, content, date])).insertId;

    if(images) {
        for (let i = 0; i < images.length; i++) {
            await createImage({ id: 'feed_id', value: feed_id }, images[i].filename, i);
        }
    }
}

// TODO: Edit
async function editFeed(feedInfo) {    
    const { content, feed_id } = feedInfo;
    
    return await conn.query('UPDATE tb_feed SET content = ? WHERE feed_id = ?', [content, feed_id]);
}

async function deleteFeed(feedInfo) {
    const { feed_id } = feedInfo;
    return await conn.query('DELETE FROM tb_feed WHERE feed_id = ?', [feed_id]);
}

module.exports = {
    getFeeds, createFeed, editFeed, deleteFeed
};