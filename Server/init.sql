CREATE TABLE `tb_user` (
	`user_id`	int	NOT NULL,
	`place_id`	int	NOT NULL,
	`level`	int	NULL
);

CREATE TABLE `tb_place` (
	`place_id`	int	NOT NULL,
	`name`	varchar(40)	NOT NULL,
	`start_date`	datetime	NOT NULL,
	`end_dated`	datetime	NOT NULL,
	`latitude`	double	NOT NULL	DEFAULT 0,
	`longitude`	double	NOT NULL	DEFAULT 0
);

CREATE TABLE `tb_board` (
	`board_id`	int	NOT NULL,
	`place_id`	int	NOT NULL
);

CREATE TABLE `tb_comment` (
	`comment_id`	int	NOT NULL,
	`post_id`	int	NOT NULL,
	`is_reply`	tinyint	NOT NULL	DEFAULT 0	COMMENT '대댓',
	`reply_id`	int	NULL	DEFAULT comment_id	COMMENT '대댓 참조 댓글'
);

CREATE TABLE `tb_post` (
	`post_id`	int	NOT NULL,
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
	`info_id`	int	NOT NULL	DEFAULT 0,
	`place_id`	int	NOT NULL,
	`title`	varchar(50)	NOT NULL,
	`content`	varchar(1000)	NOT NULL
);

CREATE TABLE `tb_image` (
	`image_id`	int	NOT NULL	DEFAULT 0,
	`booth_id`	int	NOT NULL	DEFAULT 0,
	`info_id`	int	NOT NULL	DEFAULT 0,
	`order`	int	NULL	DEFAULT 0
);

CREATE TABLE `tb_booth` (
	`booth_id`	int	NOT NULL	DEFAULT 0,
	`place_id`	int	NOT NULL,
	`latitude`	double	NULL	DEFAULT 0,
	`longitude`	double	NULL	DEFAULT 0,
	`name`	varchar(20)	NULL,
	`content`	varchar(100)	NULL
);

ALTER TABLE `tb_user` ADD CONSTRAINT `PK_TB_USER` PRIMARY KEY (
	`user_id`
);

ALTER TABLE `tb_place` ADD CONSTRAINT `PK_TB_PLACE` PRIMARY KEY (
	`place_id`
);

ALTER TABLE `tb_board` ADD CONSTRAINT `PK_TB_BOARD` PRIMARY KEY (
	`board_id`,
	`place_id`
);

ALTER TABLE `tb_comment` ADD CONSTRAINT `PK_TB_COMMENT` PRIMARY KEY (
	`comment_id`
);

ALTER TABLE `tb_post` ADD CONSTRAINT `PK_TB_POST` PRIMARY KEY (
	`post_id`
);

ALTER TABLE `tb_info` ADD CONSTRAINT `PK_TB_INFO` PRIMARY KEY (
	`info_id`
);

ALTER TABLE `tb_image` ADD CONSTRAINT `PK_TB_IMAGE` PRIMARY KEY (
	`image_id`
);

ALTER TABLE `tb_booth` ADD CONSTRAINT `PK_TB_BOOTH` PRIMARY KEY (
	`booth_id`
);

ALTER TABLE `tb_board` ADD CONSTRAINT `FK_tb_place_TO_tb_board_1` FOREIGN KEY (
	`place_id`
)
REFERENCES `tb_place` (
	`place_id`
);
