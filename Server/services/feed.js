const conn = require("../utils/db");
const { getImages, createImage } = require("./image");
const { getLocations, createLocation } = require("./location");
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
        
        const images = await getImages({ id: 'feed_id', value: feed.feed_id });
        Object.assign(feed.images, images);

        feed.nickname = (await getNickname(feed.user_id, feed.place_id))[0].nickname;        

        res.push(feed);
    }
    return res;
}

// feed : nickname, content
async function createFeed(feedInfo, place_id, user_id) {
    const { content, images } = feedInfo;

    const feed_id = (await conn.query('INSERT INTO tb_feed(place_id, user_id, content, write_time) VALUES(?, ?, ?, NOW())', [place_id, user_id, content])).insertId;
    
    if(images) {
        for (let i = 0; i < images.length; i++) {
            createImage({ id: 'feed_id', value: feed_id }, images[i].file_name, i);
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