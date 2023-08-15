drop database placetalk;
create database placetalk;
use placetalk;

CREATE TABLE `tb_user` (
	`user_id`	int PRIMARY KEY	NOT NULL,
	`nickname` varchar(30),
	`email` varchar(30)
);

CREATE TABLE `tb_place` (
	`place_id`	int auto_increment PRIMARY KEY	NOT NULL,
	`name`	varchar(40)	NOT NULL,
	`category`	varchar(20)	NULL,
	`state`	int	NULL	DEFAULT 0,
	`start_date`	datetime,
	`end_date`	datetime,
	`top10` int DEFAULT 0
);


CREATE TABLE `tb_comment` (
	`comment_id`	int auto_increment PRIMARY KEY	NOT NULL,
	`post_id`	int	NOT NULL,
	`user_id`	int	NOT NULL,
	`content` varchar(100) NOT NULL,
	`is_reply`	tinyint	NOT NULL	DEFAULT 0	COMMENT '대댓',
	`reply_id`	int	NULL	DEFAULT 0	COMMENT '대댓 참조 댓글',
	`create_date`	datetime	NULL,
	`likes`	int	DEFAULT 0
);

CREATE TABLE `tb_post` (
	`post_id`	int auto_increment PRIMARY KEY	NOT NULL,
	`user_id`	int	NOT NULL,
	`place_id`	int	NOT NULL,
	`create_date`	datetime	NULL,
	`title`	varchar(50)	NULL,
	`content`	varchar(1000)	NOT NULL,
	`likes`	int	NOT NULL	DEFAULT 0
);

CREATE TABLE `tb_feed` (
	`feed_id`	int auto_increment PRIMARY KEY	NOT NULL,
	`place_id`	int	NOT NULL,
	`user_id`	int	NOT NULL,
	`content`	varchar(1000)	NOT NULL,
	`write_time` datetime NOT NULL
);

CREATE TABLE `tb_image` (
	`image_id`	varchar(40)	NOT NULL,
	`booth_id`	int,
	`feed_id`	int,
	`place_id`	int,
	`order`	int	DEFAULT 0
);

CREATE TABLE `tb_booth` (
	`booth_id`	int auto_increment PRIMARY KEY	NOT NULL,
	`location_id` int NOT NULL,
	`place_id`	int,
	`name`	varchar(20)	NULL,
	`content`	varchar(100)	NULL,
	`on_time`	varchar(100)	NULL	
);

CREATE TABLE `tb_join` (
	`user_id`	int	NOT NULL,
	`place_id`	int	NOT NULL
);

CREATE TABLE `tb_organizer` (
	`place_id`	int	NOT NULL,
	`user_id`	int	NOT NULL
);

CREATE TABLE `tb_comment_likes` (
	`comment_id`	int	NOT NULL,
	`user_id`	int	NOT NULL
);

CREATE TABLE `tb_post_likes` (
	`post_id`	int	NOT NULL,
	`user_id`	int	NOT NULL
);

CREATE TABLE `tb_location` (
	`location_id` int auto_increment PRIMARY KEY NOT NULL,
	`booth_id`	int,
	`place_id`	int,
	`loc_name` varchar(20),
	`lat`	double,
	`lon`	double
);

CREATE TABLE `tb_info` (
	`info_id`	int auto_increment PRIMARY KEY	NOT NULL,
	`place_id`	int	NOT NULL,
	`title`	varchar(20)	NULL,
	`content`	varchar(300)	NULL,
	`is_schedule` int DEFAULT 0 NOT NULL
);

ALTER TABLE `tb_image` ADD CONSTRAINT `FK_tb_place_TO_tb_image_1` FOREIGN KEY (
	`place_id`
)
REFERENCES `tb_place` (
	`place_id`
);

ALTER TABLE `tb_booth` ADD CONSTRAINT `FK_tb_location_TO_tb_booth_1` FOREIGN KEY (
	`location_id`
)
REFERENCES `tb_location` (
	`location_id`
);

ALTER TABLE `tb_booth` ADD CONSTRAINT `FK_tb_place_TO_tb_booth_1` FOREIGN KEY (
	`place_id`
)
REFERENCES `tb_place` (
	`place_id`
);

ALTER TABLE `tb_join` ADD CONSTRAINT `FK_tb_user_TO_tb_join_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `tb_user` (
	`user_id`
);

ALTER TABLE `tb_join` ADD CONSTRAINT `FK_tb_place_TO_tb_join_1` FOREIGN KEY (
	`place_id`
)
REFERENCES `tb_place` (
	`place_id`
);

ALTER TABLE `tb_organizer` ADD CONSTRAINT `FK_tb_place_TO_tb_organizer_1` FOREIGN KEY (
	`place_id`
)
REFERENCES `tb_place` (
	`place_id`
);

ALTER TABLE `tb_organizer` ADD CONSTRAINT `FK_tb_user_TO_tb_organizer_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `tb_user` (
	`user_id`
);

ALTER TABLE `tb_post_likes` ADD CONSTRAINT `FK_tb_post_TO_tb_post_likes_1` FOREIGN KEY (
	`post_id`
)
REFERENCES `tb_post` (
	`post_id`
);

ALTER TABLE `tb_post_likes` ADD CONSTRAINT `FK_tb_user_TO_tb_post_likes_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `tb_user` (
	`user_id`
);

ALTER TABLE `tb_location` ADD CONSTRAINT `FK_tb_booth_TO_tb_location_1` FOREIGN KEY (
	`booth_id`
)
REFERENCES `tb_booth` (
	`booth_id`
);

ALTER TABLE `tb_location` ADD CONSTRAINT `FK_tb_place_TO_tb_location_1` FOREIGN KEY (
	`place_id`
)
REFERENCES `tb_place` (
	`place_id`
);

ALTER TABLE `tb_info` ADD CONSTRAINT `FK_tb_place_TO_tb_info_1` FOREIGN KEY (
	`place_id`
)
REFERENCES `tb_place` (
	`place_id`
);

ALTER TABLE `tb_comment_likes` ADD CONSTRAINT `FK_tb_comment_TO_tb_comment_likes_1` FOREIGN KEY (
	`comment_id`
)
REFERENCES `tb_comment` (
	`comment_id`
);

ALTER TABLE `tb_comment_likes` ADD CONSTRAINT `FK_tb_user_TO_tb_comment_likes_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `tb_user` (
	`user_id`
);



INSERT INTO tb_user VALUES(0, 'Admin', 'admin@admin.com');