const conn = require("../utils/db");
const { getLocations } = require("./location");

// filter : booth_id | feed_id
async function getImages(filter) {
    return await conn.query(`SELECT image_id, \`order\` FROM tb_image WHERE ${filter.id} = ?`, [filter.value]);
}
async function createImage(filter, name, order) {
    conn.query(`INSERT INTO tb_image(image_id, ${filter.id}, \`order\`) VALUES(?,?,?)`,
								[name, filter.value, order]);
}
async function editImage() {
    
}
async function deleteImage() {
    
}

module.exports = {
    getImages, createImage, editImage, deleteImage
};