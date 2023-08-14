const proj4 = require('proj4');

const multer = require('multer');
const uuid4 = require('uuid4');
const path = require('path');
const { UnauthorizedError } = require('./error');

const upload = multer({
    storage: multer.diskStorage({
        filename(req, file, done) {
            var ext = path.extname(file.originalname);
            done(null, uuid4() + ext);
        },
        destination(req, file, done) {
            done(null, __dirname + '/../images');
        },
    }),
});

module.exports = {
    // https://velog.io/@neity16/NodeJS-거리구하기위도-경도
    getDistance : function (lat1, lon1, lat2, lon2) {
        if ((lat1 == lat2) && (lon1 == lon2))
            return 0;
    
        var radLat1 = Math.PI * lat1 / 180;
        var radLat2 = Math.PI * lat2 / 180;
        var theta = lon1 - lon2;
        var radTheta = Math.PI * theta / 180;
        var dist = Math.sin(radLat1) * Math.sin(radLat2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.cos(radTheta);
        if (dist > 1)
            dist = 1;
    
        dist = Math.acos(dist);
        dist = dist * 180 / Math.PI;
        dist = dist * 60 * 1.1515 * 1.609344 * 1000;
        if (dist < 100) dist = Math.round(dist / 10) * 10;
        else dist = Math.round(dist / 100) * 100;
    
        return dist;
    },
    upload
};