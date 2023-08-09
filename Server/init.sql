drop database placetalk;
create database placetalk;
use placetalk;
CREATE TABLE `tb_user` (
	`user_id`	int PRIMARY KEY	NOT NULL,
	`level`	int	NULL
);

CREATE TABLE `tb_place` (
	`place_id`	int PRIMARY KEY auto_increment	NOT NULL,
	`name`	varchar(40)	NOT NULL,
	`description`	varchar(200)	NULL,
	`state`	int	NULL	DEFAULT 0,
	`start_date`	datetime	NOT NULL,
	`end_date`	datetime	NOT NULL,
	`latitude`	double	NOT NULL	DEFAULT 0,
	`longitude`	double	NOT NULL	DEFAULT 0
);

CREATE TABLE `tb_board` (
	`board_id`	int PRIMARY KEY auto_increment	NOT NULL,
	`place_id`	int	NOT NULL
);

CREATE TABLE `tb_comment` (
	`comment_id`	int PRIMARY KEY auto_increment	NOT NULL,
	`post_id`	int	NOT NULL,
	`is_reply`	tinyint	NOT NULL	DEFAULT 0	COMMENT '대댓',
	`reply_id`	int	NULL	DEFAULT 0	COMMENT '대댓 참조 댓글',
	`create_date`	datetime	NULL,
	`Field`	VARCHAR(255)	NULL
);

CREATE TABLE `tb_post` (
	`post_id`	int PRIMARY KEY auto_increment	NOT NULL,
	`user_id`	int	NOT NULL,
	`board_id`	int	NOT NULL,
	`place_id`	int	NOT NULL,
	`create_date`	datetime	NULL,
	`title`	varchar(50)	NULL,
	`content`	varchar(1000)	NOT NULL,
	`view`	int	NOT NULL	DEFAULT 0,
	`likes`	int	NOT NULL	DEFAULT 0
);

CREATE TABLE `tb_info` (
	`info_id`	int PRIMARY KEY auto_increment	NOT NULL,
	`place_id`	int	NOT NULL,
	`title`	varchar(50)	NOT NULL,
	`content`	varchar(1000)	NOT NULL
);

CREATE TABLE `tb_image` (
	`image_id`	int PRIMARY KEY auto_increment	NOT NULL,
	`booth_id`	int	NOT NULL	DEFAULT 0,
	`info_id`	int	NOT NULL	DEFAULT 0,
	`order`	int	NULL	DEFAULT 0
);

CREATE TABLE `tb_booth` (
	`booth_id`	int PRIMARY KEY auto_increment	NOT NULL,
	`place_id`	int	NOT NULL,
	`latitude`	double	NULL	DEFAULT 0,
	`longitude`	double	NULL	DEFAULT 0,
	`name`	varchar(20)	NULL,
	`content`	varchar(100)	NULL,
	`detail`	varchar(20)	NULL
);

CREATE TABLE `tb_join` (
	`user_id`	int	NOT NULL,
	`place_id`	int	NOT NULL
);


ALTER TABLE `tb_board` ADD CONSTRAINT `FK_tb_place_TO_tb_board_1` FOREIGN KEY (
	`place_id`
)
REFERENCES `tb_place` (
	`place_id`
);

ALTER TABLE `tb_comment` ADD CONSTRAINT `FK_tb_post_TO_tb_comment_1` FOREIGN KEY (
	`post_id`
)
REFERENCES `tb_post` (
	`post_id`
);

ALTER TABLE `tb_post` ADD CONSTRAINT `FK_tb_user_TO_tb_post_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `tb_user` (
	`user_id`
);

ALTER TABLE `tb_post` ADD CONSTRAINT `FK_tb_board_TO_tb_post_1` FOREIGN KEY (
	`board_id`
)
REFERENCES `tb_board` (
	`board_id`
);

ALTER TABLE `tb_post` ADD CONSTRAINT `FK_tb_board_TO_tb_post_2` FOREIGN KEY (
	`place_id`
)
REFERENCES `tb_board` (
	`place_id`
);

ALTER TABLE `tb_info` ADD CONSTRAINT `FK_tb_place_TO_tb_info_1` FOREIGN KEY (
	`place_id`
)
REFERENCES `tb_place` (
	`place_id`
);

ALTER TABLE `tb_image` ADD CONSTRAINT `FK_tb_booth_TO_tb_image_1` FOREIGN KEY (
	`booth_id`
)
REFERENCES `tb_booth` (
	`booth_id`
);

ALTER TABLE `tb_image` ADD CONSTRAINT `FK_tb_info_TO_tb_image_1` FOREIGN KEY (
	`info_id`
)
REFERENCES `tb_info` (
	`info_id`
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
INSERT INTO tb_user VALUES(0,0);