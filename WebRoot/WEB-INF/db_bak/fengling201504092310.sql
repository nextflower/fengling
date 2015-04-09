/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50622
Source Host           : localhost:3306
Source Database       : fengling

Target Server Type    : MYSQL
Target Server Version : 50622
File Encoding         : 65001

Date: 2015-04-09 23:10:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `jc_acquisition`
-- ----------------------------
DROP TABLE IF EXISTS `jc_acquisition`;
CREATE TABLE `jc_acquisition` (
  `acquisition_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `acq_name` varchar(50) NOT NULL COMMENT '采集名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '停止时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '当前状态(0:静止;1:采集;2:暂停)',
  `curr_num` int(11) NOT NULL DEFAULT '0' COMMENT '当前号码',
  `curr_item` int(11) NOT NULL DEFAULT '0' COMMENT '当前条数',
  `total_item` int(11) NOT NULL DEFAULT '0' COMMENT '每页总条数',
  `pause_time` int(11) NOT NULL DEFAULT '0' COMMENT '暂停时间(毫秒)',
  `page_encoding` varchar(20) NOT NULL DEFAULT 'GBK' COMMENT '页面编码',
  `plan_list` longtext COMMENT '采集列表',
  `dynamic_addr` varchar(255) DEFAULT NULL COMMENT '动态地址',
  `dynamic_start` int(11) DEFAULT NULL COMMENT '页码开始',
  `dynamic_end` int(11) DEFAULT NULL COMMENT '页码结束',
  `linkset_start` varchar(255) DEFAULT NULL COMMENT '内容链接区开始',
  `linkset_end` varchar(255) DEFAULT NULL COMMENT '内容链接区结束',
  `link_start` varchar(255) DEFAULT NULL COMMENT '内容链接开始',
  `link_end` varchar(255) DEFAULT NULL COMMENT '内容链接结束',
  `title_start` varchar(255) DEFAULT NULL COMMENT '标题开始',
  `title_end` varchar(255) DEFAULT NULL COMMENT '标题结束',
  `keywords_start` varchar(255) DEFAULT NULL COMMENT '关键字开始',
  `keywords_end` varchar(255) DEFAULT NULL COMMENT '关键字结束',
  `description_start` varchar(255) DEFAULT NULL COMMENT '描述开始',
  `description_end` varchar(255) DEFAULT NULL COMMENT '描述结束',
  `content_start` varchar(255) DEFAULT NULL COMMENT '内容开始',
  `content_end` varchar(255) DEFAULT NULL COMMENT '内容结束',
  `pagination_start` varchar(255) DEFAULT NULL COMMENT '内容分页开始',
  `pagination_end` varchar(255) DEFAULT NULL COMMENT '内容分页结束',
  `queue` int(11) NOT NULL DEFAULT '0' COMMENT '队列',
  `repeat_check_type` varchar(20) NOT NULL DEFAULT 'NONE' COMMENT '重复类型',
  `img_acqu` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否采集图片',
  `content_prefix` varchar(255) DEFAULT NULL COMMENT '内容地址补全url',
  `img_prefix` varchar(255) DEFAULT NULL COMMENT '图片地址补全url',
  `view_start` varchar(255) DEFAULT NULL COMMENT '浏览量开始',
  `view_end` varchar(255) DEFAULT NULL COMMENT '浏览量结束',
  `view_id_start` varchar(255) DEFAULT NULL COMMENT 'id前缀',
  `view_id_end` varchar(255) DEFAULT NULL COMMENT 'id后缀',
  `view_link` varchar(255) DEFAULT NULL COMMENT '浏览量动态访问地址',
  `releaseTime_start` varchar(255) DEFAULT NULL COMMENT '发布时间开始',
  `releaseTime_end` varchar(255) DEFAULT NULL COMMENT '发布时间结束',
  `author_start` varchar(255) DEFAULT NULL COMMENT '作者开始',
  `author_end` varchar(255) DEFAULT NULL COMMENT '作者结束',
  `origin_start` varchar(255) DEFAULT NULL COMMENT '来源开始',
  `origin_end` varchar(255) DEFAULT NULL COMMENT '来源结束',
  `releaseTime_format` varchar(255) DEFAULT NULL COMMENT '发布时间格式',
  PRIMARY KEY (`acquisition_id`),
  KEY `fk_jc_acquisition_channel` (`channel_id`),
  KEY `fk_jc_acquisition_contenttype` (`type_id`),
  KEY `fk_jc_acquisition_site` (`site_id`),
  KEY `fk_jc_acquisition_user` (`user_id`),
  CONSTRAINT `fk_jc_acquisition_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_acquisition_contenttype` FOREIGN KEY (`type_id`) REFERENCES `jc_content_type` (`type_id`),
  CONSTRAINT `fk_jc_acquisition_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_acquisition_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS采集表';

-- ----------------------------
-- Records of jc_acquisition
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_acquisition_history`
-- ----------------------------
DROP TABLE IF EXISTS `jc_acquisition_history`;
CREATE TABLE `jc_acquisition_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_url` varchar(255) NOT NULL DEFAULT '' COMMENT '栏目地址',
  `content_url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容地址',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `description` varchar(20) NOT NULL DEFAULT '' COMMENT '描述',
  `acquisition_id` int(11) DEFAULT NULL COMMENT '采集源',
  `content_id` int(11) DEFAULT NULL COMMENT '内容',
  PRIMARY KEY (`history_id`),
  KEY `fk_acquisition_history_acquisition` (`acquisition_id`),
  CONSTRAINT `fk_jc_history_acquisition` FOREIGN KEY (`acquisition_id`) REFERENCES `jc_acquisition` (`acquisition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集历史记录表';

-- ----------------------------
-- Records of jc_acquisition_history
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_acquisition_temp`
-- ----------------------------
DROP TABLE IF EXISTS `jc_acquisition_temp`;
CREATE TABLE `jc_acquisition_temp` (
  `temp_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `channel_url` varchar(255) NOT NULL DEFAULT '' COMMENT '栏目地址',
  `content_url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容地址',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `finish_percent` int(3) NOT NULL DEFAULT '0' COMMENT '百分比',
  `description` varchar(20) NOT NULL DEFAULT '' COMMENT '描述',
  `seq` int(3) NOT NULL DEFAULT '0' COMMENT '顺序',
  PRIMARY KEY (`temp_id`),
  KEY `fk_jc_temp_site` (`site_id`),
  CONSTRAINT `fk_jc_temp_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集进度临时表';

-- ----------------------------
-- Records of jc_acquisition_temp
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_advertising`
-- ----------------------------
DROP TABLE IF EXISTS `jc_advertising`;
CREATE TABLE `jc_advertising` (
  `advertising_id` int(11) NOT NULL AUTO_INCREMENT,
  `adspace_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `ad_name` varchar(100) NOT NULL COMMENT '广告名称',
  `category` varchar(50) NOT NULL COMMENT '广告类型',
  `ad_code` longtext COMMENT '广告代码',
  `ad_weight` int(11) NOT NULL DEFAULT '1' COMMENT '广告权重',
  `display_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '展现次数',
  `click_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '点击次数',
  `start_time` date DEFAULT NULL COMMENT '开始时间',
  `end_time` date DEFAULT NULL COMMENT '结束时间',
  `is_enabled` char(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  PRIMARY KEY (`advertising_id`),
  KEY `fk_jc_advertising_site` (`site_id`),
  KEY `fk_jc_space_advertising` (`adspace_id`),
  CONSTRAINT `fk_jc_advertising_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_space_advertising` FOREIGN KEY (`adspace_id`) REFERENCES `jc_advertising_space` (`adspace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='CMS广告表';

-- ----------------------------
-- Records of jc_advertising
-- ----------------------------
INSERT INTO `jc_advertising` VALUES ('1', '1', '1', 'banner', 'image', null, '1', '130', '0', null, null, '1');
INSERT INTO `jc_advertising` VALUES ('2', '2', '1', '通栏广告1', 'image', null, '1', '123', '2', null, null, '1');
INSERT INTO `jc_advertising` VALUES ('3', '3', '1', '视频广告上', 'image', null, '1', '0', '0', null, null, '1');
INSERT INTO `jc_advertising` VALUES ('4', '4', '1', '视频广告下', 'image', null, '1', '0', '0', null, null, '1');
INSERT INTO `jc_advertising` VALUES ('5', '5', '1', '留言板本周热点广告', 'image', null, '1', '0', '0', '2014-07-19', '2014-07-01', '1');

-- ----------------------------
-- Table structure for `jc_advertising_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_advertising_attr`;
CREATE TABLE `jc_advertising_attr` (
  `advertising_id` int(11) NOT NULL,
  `attr_name` varchar(50) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_params_advertising` (`advertising_id`),
  CONSTRAINT `fk_jc_params_advertising` FOREIGN KEY (`advertising_id`) REFERENCES `jc_advertising` (`advertising_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS广告属性表';

-- ----------------------------
-- Records of jc_advertising_attr
-- ----------------------------
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_title', '查看fengling官方网站');
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_url', '/v6/u/cms/www/201404/30140543hzlx.gif');
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_target', '_blank');
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_link', 'http://www.fengling.com');
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_width', '735');
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_height', '70');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_title', 'fengling官方网站');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_url', '/r/cms/www/red/img/banner1.jpg');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_target', '_blank');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_link', 'http://www.fengling.com');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_width', '960');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_height', '60');
INSERT INTO `jc_advertising_attr` VALUES ('3', 'image_height', '89');
INSERT INTO `jc_advertising_attr` VALUES ('3', 'image_link', 'http://');
INSERT INTO `jc_advertising_attr` VALUES ('3', 'image_target', '_blank');
INSERT INTO `jc_advertising_attr` VALUES ('3', 'image_url', '/u/cms/www/201112/17144805im1p.jpg');
INSERT INTO `jc_advertising_attr` VALUES ('3', 'image_width', '980');
INSERT INTO `jc_advertising_attr` VALUES ('4', 'image_height', '90');
INSERT INTO `jc_advertising_attr` VALUES ('4', 'image_link', 'http://');
INSERT INTO `jc_advertising_attr` VALUES ('4', 'image_target', '_blank');
INSERT INTO `jc_advertising_attr` VALUES ('4', 'image_url', '/u/cms/www/201112/17145028j3bj.jpg');
INSERT INTO `jc_advertising_attr` VALUES ('4', 'image_width', '980');
INSERT INTO `jc_advertising_attr` VALUES ('5', 'image_height', '109');
INSERT INTO `jc_advertising_attr` VALUES ('5', 'image_link', 'http://3x.fengling.com');
INSERT INTO `jc_advertising_attr` VALUES ('5', 'image_target', '_blank');
INSERT INTO `jc_advertising_attr` VALUES ('5', 'image_url', '/u/cms/www/201112/18155751wi1k.gif');
INSERT INTO `jc_advertising_attr` VALUES ('5', 'image_width', '215');

-- ----------------------------
-- Table structure for `jc_advertising_space`
-- ----------------------------
DROP TABLE IF EXISTS `jc_advertising_space`;
CREATE TABLE `jc_advertising_space` (
  `adspace_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `ad_name` varchar(100) NOT NULL COMMENT '名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `is_enabled` char(1) NOT NULL COMMENT '是否启用',
  PRIMARY KEY (`adspace_id`),
  KEY `fk_jc_adspace_site` (`site_id`),
  CONSTRAINT `fk_jc_adspace_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='CMS广告版位表';

-- ----------------------------
-- Records of jc_advertising_space
-- ----------------------------
INSERT INTO `jc_advertising_space` VALUES ('1', '1', '页头banner', '全站页头banner', '1');
INSERT INTO `jc_advertising_space` VALUES ('2', '1', '通栏广告', '页面中间通栏广告', '1');
INSERT INTO `jc_advertising_space` VALUES ('3', '1', '视频广告上', '', '1');
INSERT INTO `jc_advertising_space` VALUES ('4', '1', '视频广告下', '', '1');
INSERT INTO `jc_advertising_space` VALUES ('5', '1', '留言板本周热点广告', '留言板本周热点广告', '1');
INSERT INTO `jc_advertising_space` VALUES ('6', '1', '顶上撒的', '顶上撒的', '0');

-- ----------------------------
-- Table structure for `jc_channel`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel`;
CREATE TABLE `jc_channel` (
  `channel_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL COMMENT '模型ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `parent_id` int(11) DEFAULT NULL COMMENT '父栏目ID',
  `channel_path` varchar(30) DEFAULT NULL COMMENT '访问路径',
  `lft` int(11) NOT NULL DEFAULT '1' COMMENT '树左边',
  `rgt` int(11) NOT NULL DEFAULT '2' COMMENT '树右边',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `has_content` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有内容',
  `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  PRIMARY KEY (`channel_id`),
  KEY `fk_jc_channel_model` (`model_id`),
  KEY `fk_jc_channel_parent` (`parent_id`),
  KEY `fk_jc_channel_site` (`site_id`),
  CONSTRAINT `fk_jc_channel_model` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`),
  CONSTRAINT `fk_jc_channel_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_channel_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COMMENT='CMS栏目表';

-- ----------------------------
-- Records of jc_channel
-- ----------------------------
INSERT INTO `jc_channel` VALUES ('1', '1', '1', null, 'Skill', '29', '28', '1', '1', '1');
INSERT INTO `jc_channel` VALUES ('70', '1', '1', null, 'Share', '29', '36', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('71', '1', '1', null, 'Collect', '37', '46', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('72', '1', '1', null, 'Time', '47', '48', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('73', '1', '1', null, 'About', '49', '50', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('74', '1', '1', null, 'Guestbook', '51', '52', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('75', '1', '1', '1', 'Linux', '0', '1', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('76', '1', '1', '1', 'database', '2', '3', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('77', '1', '1', '1', 'Spring', '4', '5', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('78', '1', '1', '1', 'Hibernate', '6', '7', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('79', '1', '1', '1', 'JavaScript', '8', '9', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('80', '1', '1', '1', 'fronts', '10', '11', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('81', '1', '1', '1', 'freemarker', '12', '13', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('82', '1', '1', '1', 'qwjs', '14', '15', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('83', '1', '1', '1', 'maven', '16', '17', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('84', '1', '1', '1', 'cwcl', '18', '19', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('85', '1', '1', '1', 'kfgj', '20', '21', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('86', '1', '1', '1', 'sjtj', '22', '23', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('87', '1', '1', '1', 'bcsw', '24', '25', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('88', '1', '1', '1', 'mbdm', '26', '27', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('89', '1', '1', '70', 'codeshare', '30', '31', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('90', '1', '1', '70', 'backup', '32', '33', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('91', '1', '1', '71', '72star', '38', '39', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('92', '1', '1', '71', '8tool', '40', '41', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('93', '1', '1', '71', 'enjoy', '42', '43', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('94', '1', '1', '71', 'charactor', '44', '45', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('95', '1', '1', '70', 'career', '34', '35', '10', '1', '1');

-- ----------------------------
-- Table structure for `jc_channel_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_attr`;
CREATE TABLE `jc_channel_attr` (
  `channel_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_channel` (`channel_id`),
  CONSTRAINT `fk_jc_attr_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目扩展属性表';

-- ----------------------------
-- Records of jc_channel_attr
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_channel_count`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_count`;
CREATE TABLE `jc_channel_count` (
  `channel_id` int(11) NOT NULL,
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '总访问数',
  `views_month` int(11) NOT NULL DEFAULT '0' COMMENT '月访问数',
  `views_week` int(11) NOT NULL DEFAULT '0' COMMENT '周访问数',
  `views_day` int(11) NOT NULL DEFAULT '0' COMMENT '日访问数',
  PRIMARY KEY (`channel_id`),
  CONSTRAINT `fk_jc_count_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目访问量计数表';

-- ----------------------------
-- Records of jc_channel_count
-- ----------------------------
INSERT INTO `jc_channel_count` VALUES ('1', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('70', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('71', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('72', '14', '14', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('73', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('74', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('75', '41', '41', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('76', '3', '3', '1', '1');
INSERT INTO `jc_channel_count` VALUES ('77', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('78', '6', '6', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('79', '6', '6', '2', '2');
INSERT INTO `jc_channel_count` VALUES ('80', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('81', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('82', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('83', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('84', '5', '5', '1', '1');
INSERT INTO `jc_channel_count` VALUES ('85', '19', '19', '11', '6');
INSERT INTO `jc_channel_count` VALUES ('86', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('87', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('88', '3', '3', '1', '1');
INSERT INTO `jc_channel_count` VALUES ('89', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('90', '5', '5', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('91', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('92', '0', '0', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('93', '22', '22', '18', '2');
INSERT INTO `jc_channel_count` VALUES ('94', '8', '8', '0', '0');
INSERT INTO `jc_channel_count` VALUES ('95', '2', '2', '1', '0');

-- ----------------------------
-- Table structure for `jc_channel_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_ext`;
CREATE TABLE `jc_channel_ext` (
  `channel_id` int(11) NOT NULL,
  `channel_name` varchar(100) NOT NULL COMMENT '名称',
  `final_step` tinyint(4) DEFAULT '2' COMMENT '终审级别',
  `after_check` tinyint(4) DEFAULT NULL COMMENT '审核后(1:不能修改删除;2:修改后退回;3:修改后不变)',
  `is_static_channel` char(1) NOT NULL DEFAULT '0' COMMENT '是否栏目静态化',
  `is_static_content` char(1) NOT NULL DEFAULT '0' COMMENT '是否内容静态化',
  `is_access_by_dir` char(1) NOT NULL DEFAULT '1' COMMENT '是否使用目录访问',
  `is_list_child` char(1) NOT NULL DEFAULT '0' COMMENT '是否使用子栏目列表',
  `page_size` int(11) NOT NULL DEFAULT '20' COMMENT '每页多少条记录',
  `channel_rule` varchar(150) DEFAULT NULL COMMENT '栏目页生成规则',
  `content_rule` varchar(150) DEFAULT NULL COMMENT '内容页生成规则',
  `link` varchar(255) DEFAULT NULL COMMENT '外部链接',
  `tpl_channel` varchar(100) DEFAULT NULL COMMENT '栏目页模板',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '内容页模板',
  `title_img` varchar(100) DEFAULT NULL COMMENT '缩略图',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图',
  `has_title_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内容是否有缩略图',
  `has_content_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内容是否有内容图',
  `title_img_width` int(11) NOT NULL DEFAULT '139' COMMENT '内容标题图宽度',
  `title_img_height` int(11) NOT NULL DEFAULT '139' COMMENT '内容标题图高度',
  `content_img_width` int(11) NOT NULL DEFAULT '310' COMMENT '内容内容图宽度',
  `content_img_height` int(11) NOT NULL DEFAULT '310' COMMENT '内容内容图高度',
  `comment_control` int(11) NOT NULL DEFAULT '0' COMMENT '评论(0:匿名;1:会员;2:关闭)',
  `allow_updown` tinyint(1) NOT NULL DEFAULT '1' COMMENT '顶踩(true:开放;false:关闭)',
  `is_blank` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否新窗口打开',
  `title` varchar(255) DEFAULT NULL COMMENT 'TITLE',
  `keywords` varchar(255) DEFAULT NULL COMMENT 'KEYWORDS',
  `description` varchar(255) DEFAULT NULL COMMENT 'DESCRIPTION',
  `allow_share` tinyint(1) NOT NULL DEFAULT '0' COMMENT '分享(true:开放;false:关闭)',
  `allow_score` tinyint(1) NOT NULL DEFAULT '0' COMMENT '评分(true:开放;false:关闭)',
  PRIMARY KEY (`channel_id`),
  CONSTRAINT `fk_jc_ext_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目内容表';

-- ----------------------------
-- Records of jc_channel_ext
-- ----------------------------
INSERT INTO `jc_channel_ext` VALUES ('1', '聚沙成塔', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/t/cms/blog/default/channel/news_skill.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '技术积累', '技术积累', '技术积累', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('70', '它山之石', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/blog/default/channel/news_share.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '它山之石', '它山之石', '它山之石', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('71', '包罗万象', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/blog/default/channel/news_collect.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('72', '岁月如梭', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/blog/default/channel/news_time.html', null, null, null, '0', '0', '139', '139', '310', '310', '2', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('73', '关于本站', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/blog/default/channel/news_about.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('74', '留言版', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/blog/default/channel/news_guestbook.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('75', 'Linux', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', 'Linux', 'Linux', 'Linux相关技术学习与介绍。', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('76', '数据库', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '数据库', '数据库', '数据库', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('77', 'Spring', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('78', 'Hibernate', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('79', 'JavaScript', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('80', 'HTML/CSS/JSP', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('81', 'Freemarker', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('82', '全文检索', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('83', 'Maven', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('84', '错误处理', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('85', '开发工具', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('86', '书籍推荐', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('87', '编程思维', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('88', '模板代码', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('89', '代码分享', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('90', '收藏备忘', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('91', '七十二颗星', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('92', '8Tool', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('93', '娱乐休闲', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('94', '咬文嚼字', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('95', '职业生涯', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');

-- ----------------------------
-- Table structure for `jc_channel_model`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_model`;
CREATE TABLE `jc_channel_model` (
  `channel_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL COMMENT '模型id',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '内容模板',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  PRIMARY KEY (`channel_id`,`priority`),
  KEY `fk_jc_model_channel_m` (`model_id`),
  CONSTRAINT `fk_jc_channel_model_c` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_model_channel_m` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='栏目可选内容模型表';

-- ----------------------------
-- Records of jc_channel_model
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_channel_txt`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_txt`;
CREATE TABLE `jc_channel_txt` (
  `channel_id` int(11) NOT NULL,
  `txt` longtext COMMENT '栏目内容',
  `txt1` longtext COMMENT '扩展内容1',
  `txt2` longtext COMMENT '扩展内容2',
  `txt3` longtext COMMENT '扩展内容3',
  PRIMARY KEY (`channel_id`),
  CONSTRAINT `fk_jc_txt_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目文本表';

-- ----------------------------
-- Records of jc_channel_txt
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_channel_user`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_user`;
CREATE TABLE `jc_channel_user` (
  `channel_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`user_id`),
  KEY `fk_jc_channel_user` (`user_id`),
  CONSTRAINT `fk_jc_channel_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目用户关联表';

-- ----------------------------
-- Records of jc_channel_user
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_chnl_group_contri`
-- ----------------------------
DROP TABLE IF EXISTS `jc_chnl_group_contri`;
CREATE TABLE `jc_chnl_group_contri` (
  `channel_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`group_id`),
  KEY `fk_jc_channel_group_c` (`group_id`),
  CONSTRAINT `fk_jc_channel_group_c` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_channel_c` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目投稿会员组关联表';

-- ----------------------------
-- Records of jc_chnl_group_contri
-- ----------------------------
INSERT INTO `jc_chnl_group_contri` VALUES ('1', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('70', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('71', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('72', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('73', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('74', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('75', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('76', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('77', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('78', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('79', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('80', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('81', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('82', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('83', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('84', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('85', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('86', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('87', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('88', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('89', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('90', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('91', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('92', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('93', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('94', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('95', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('1', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('70', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('71', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('72', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('73', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('74', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('75', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('76', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('77', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('78', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('79', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('80', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('81', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('82', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('83', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('84', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('85', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('86', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('87', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('88', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('89', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('90', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('91', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('92', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('93', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('94', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('95', '2');

-- ----------------------------
-- Table structure for `jc_chnl_group_view`
-- ----------------------------
DROP TABLE IF EXISTS `jc_chnl_group_view`;
CREATE TABLE `jc_chnl_group_view` (
  `channel_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`group_id`),
  KEY `fk_jc_channel_group_v` (`group_id`),
  CONSTRAINT `fk_jc_channel_group_v` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_channel_v` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目浏览会员组关联表';

-- ----------------------------
-- Records of jc_chnl_group_view
-- ----------------------------
INSERT INTO `jc_chnl_group_view` VALUES ('1', '1');

-- ----------------------------
-- Table structure for `jc_comment`
-- ----------------------------
DROP TABLE IF EXISTS `jc_comment`;
CREATE TABLE `jc_comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_user_id` int(11) DEFAULT NULL COMMENT '评论用户ID',
  `reply_user_id` int(11) DEFAULT NULL COMMENT '回复用户ID',
  `content_id` int(11) NOT NULL COMMENT '内容ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `create_time` datetime NOT NULL COMMENT '评论时间',
  `reply_time` datetime DEFAULT NULL COMMENT '回复时间',
  `ups` smallint(6) NOT NULL DEFAULT '0' COMMENT '支持数',
  `downs` smallint(6) NOT NULL DEFAULT '0' COMMENT '反对数',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `is_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核',
  `score` int(11) DEFAULT NULL COMMENT '评分',
  PRIMARY KEY (`comment_id`),
  KEY `fk_jc_comment_content` (`content_id`),
  KEY `fk_jc_comment_reply` (`reply_user_id`),
  KEY `fk_jc_comment_site` (`site_id`),
  KEY `fk_jc_comment_user` (`comment_user_id`),
  CONSTRAINT `fk_jc_comment_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_comment_reply` FOREIGN KEY (`reply_user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_comment_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_comment_user` FOREIGN KEY (`comment_user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS评论表';

-- ----------------------------
-- Records of jc_comment
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_comment_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_comment_ext`;
CREATE TABLE `jc_comment_ext` (
  `comment_id` int(11) NOT NULL,
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `text` longtext COMMENT '评论内容',
  `reply` longtext COMMENT '回复内容',
  KEY `fk_jc_ext_comment` (`comment_id`),
  CONSTRAINT `fk_jc_ext_comment` FOREIGN KEY (`comment_id`) REFERENCES `jc_comment` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS评论扩展表';

-- ----------------------------
-- Records of jc_comment_ext
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_config`
-- ----------------------------
DROP TABLE IF EXISTS `jc_config`;
CREATE TABLE `jc_config` (
  `config_id` int(11) NOT NULL,
  `context_path` varchar(20) DEFAULT '/fengling' COMMENT '部署路径',
  `servlet_point` varchar(20) DEFAULT NULL COMMENT 'Servlet挂载点',
  `port` int(11) DEFAULT NULL COMMENT '端口',
  `db_file_uri` varchar(50) NOT NULL DEFAULT '/dbfile.svl?n=' COMMENT '数据库附件访问地址',
  `is_upload_to_db` tinyint(1) NOT NULL DEFAULT '0' COMMENT '上传附件至数据库',
  `def_img` varchar(255) NOT NULL DEFAULT '/fengling/r/cms/www/default/no_picture.gif' COMMENT '图片不存在时默认图片',
  `login_url` varchar(255) NOT NULL DEFAULT '/login.jspx' COMMENT '登录地址',
  `process_url` varchar(255) DEFAULT NULL COMMENT '登录后处理地址',
  `mark_on` tinyint(1) NOT NULL DEFAULT '1' COMMENT '开启图片水印',
  `mark_width` int(11) NOT NULL DEFAULT '120' COMMENT '图片最小宽度',
  `mark_height` int(11) NOT NULL DEFAULT '120' COMMENT '图片最小高度',
  `mark_image` varchar(100) DEFAULT '/r/cms/www/watermark.png' COMMENT '图片水印',
  `mark_content` varchar(100) NOT NULL DEFAULT 'www.fengling.com' COMMENT '文字水印内容',
  `mark_size` int(11) NOT NULL DEFAULT '20' COMMENT '文字水印大小',
  `mark_color` varchar(10) NOT NULL DEFAULT '#FF0000' COMMENT '文字水印颜色',
  `mark_alpha` int(11) NOT NULL DEFAULT '50' COMMENT '水印透明度（0-100）',
  `mark_position` int(11) NOT NULL DEFAULT '1' COMMENT '水印位置(0-5)',
  `mark_offset_x` int(11) NOT NULL DEFAULT '0' COMMENT 'x坐标偏移量',
  `mark_offset_y` int(11) NOT NULL DEFAULT '0' COMMENT 'y坐标偏移量',
  `count_clear_time` date NOT NULL COMMENT '计数器清除时间',
  `count_copy_time` datetime NOT NULL COMMENT '计数器拷贝时间',
  `download_code` varchar(32) NOT NULL DEFAULT 'fengling' COMMENT '下载防盗链md5混淆码',
  `download_time` int(11) NOT NULL DEFAULT '12' COMMENT '下载有效时间（小时）',
  `email_host` varchar(50) DEFAULT NULL COMMENT '邮件发送服务器',
  `email_encoding` varchar(20) DEFAULT NULL COMMENT '邮件发送编码',
  `email_username` varchar(100) DEFAULT NULL COMMENT '邮箱用户名',
  `email_password` varchar(100) DEFAULT NULL COMMENT '邮箱密码',
  `email_personal` varchar(100) DEFAULT NULL COMMENT '邮箱发件人',
  `email_validate` tinyint(1) DEFAULT '0' COMMENT '开启邮箱验证',
  `view_only_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '只有终审才能浏览内容页',
  `solr_path` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS配置表';

-- ----------------------------
-- Records of jc_config
-- ----------------------------
INSERT INTO `jc_config` VALUES ('1', '/fengling', null, '8080', '/dbfile.svl?n=', '0', '/r/cms/www/no_picture.gif', '/login.jspx', null, '0', '120', '120', '', 'www.fenglingdukou.com', '40', '#FF0000', '100', '1', '0', '0', '2015-04-09', '2015-04-09 22:01:02', 'fengling', '12', null, null, null, null, null, '1', '0', 'http://localhost:8080/Solr/fengling');

-- ----------------------------
-- Table structure for `jc_config_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_config_attr`;
CREATE TABLE `jc_config_attr` (
  `config_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_config` (`config_id`),
  CONSTRAINT `fk_jc_attr_config` FOREIGN KEY (`config_id`) REFERENCES `jc_config` (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS配置属性表';

-- ----------------------------
-- Records of jc_config_attr
-- ----------------------------
INSERT INTO `jc_config_attr` VALUES ('1', 'password_min_len', '3');
INSERT INTO `jc_config_attr` VALUES ('1', 'username_reserved', '');
INSERT INTO `jc_config_attr` VALUES ('1', 'register_on', 'true');
INSERT INTO `jc_config_attr` VALUES ('1', 'member_on', 'true');
INSERT INTO `jc_config_attr` VALUES ('1', 'username_min_len', '3');
INSERT INTO `jc_config_attr` VALUES ('1', 'version', 'fengling-v6');
INSERT INTO `jc_config_attr` VALUES ('1', 'user_img_height', '98');
INSERT INTO `jc_config_attr` VALUES ('1', 'user_img_width', '143');
INSERT INTO `jc_config_attr` VALUES ('1', 'check_on', 'false');
INSERT INTO `jc_config_attr` VALUES ('1', 'new_picture', '/r/cms/www/new.gif');
INSERT INTO `jc_config_attr` VALUES ('1', 'day', '3');
INSERT INTO `jc_config_attr` VALUES ('1', 'preview', 'false');
INSERT INTO `jc_config_attr` VALUES ('1', 'qqEnable', 'true');
INSERT INTO `jc_config_attr` VALUES ('1', 'sinaKey', '2c64512a12f2e7f6a5cfb5f5b5d8b128');
INSERT INTO `jc_config_attr` VALUES ('1', 'sinaEnable', 'true');
INSERT INTO `jc_config_attr` VALUES ('1', 'qqID', '101139646');
INSERT INTO `jc_config_attr` VALUES ('1', 'qqKey', '13f23bebda25f9f26c5c082d017f74ee');
INSERT INTO `jc_config_attr` VALUES ('1', 'sinaID', '2510334929');
INSERT INTO `jc_config_attr` VALUES ('1', 'qqWeboEnable', 'true');
INSERT INTO `jc_config_attr` VALUES ('1', 'qqWeboKey', 'c6b0a6d1ce972f6be1a9113c3afbea2f');
INSERT INTO `jc_config_attr` VALUES ('1', 'qqWeboID', '801526383');
INSERT INTO `jc_config_attr` VALUES ('1', 'weixinEnable', 'false');
INSERT INTO `jc_config_attr` VALUES ('1', 'weixinKey', 'b442bcedc2ab8508caaa63841e33686e');
INSERT INTO `jc_config_attr` VALUES ('1', 'weixinID', 'wxfc9f068ff05339f1');

-- ----------------------------
-- Table structure for `jc_config_item`
-- ----------------------------
DROP TABLE IF EXISTS `jc_config_item`;
CREATE TABLE `jc_config_item` (
  `modelitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) NOT NULL,
  `field` varchar(50) NOT NULL COMMENT '字段',
  `item_label` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '70' COMMENT '排列顺序',
  `def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `opt_value` varchar(255) DEFAULT NULL COMMENT '可选项',
  `text_size` varchar(20) DEFAULT NULL COMMENT '长度',
  `area_rows` varchar(3) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(3) DEFAULT NULL COMMENT '文本列数',
  `help` varchar(255) DEFAULT NULL COMMENT '帮助信息',
  `help_position` varchar(1) DEFAULT NULL COMMENT '帮助位置',
  `data_type` int(11) NOT NULL DEFAULT '1' COMMENT '数据类型 "1":"字符串文本","2":"整型文本","3":"浮点型文本","4":"文本区","5":"日期","6":"下拉列表","7":"复选框","8":"单选框"',
  `is_required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否必填',
  `category` int(11) NOT NULL DEFAULT '1' COMMENT '模型项目所属分类（1注册模型）',
  PRIMARY KEY (`modelitem_id`),
  KEY `fk_jc_item_config` (`config_id`),
  CONSTRAINT `fk_jc_item_config` FOREIGN KEY (`config_id`) REFERENCES `jc_config` (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='CMS配置模型项表';

-- ----------------------------
-- Records of jc_config_item
-- ----------------------------
INSERT INTO `jc_config_item` VALUES ('1', '1', 'realname', '真实姓名', '1', '', '', '', '3', '30', '', '', '1', '0', '1');
INSERT INTO `jc_config_item` VALUES ('2', '1', 'phone', '手机号码', '2', null, null, null, '3', '30', null, null, '1', '0', '1');
INSERT INTO `jc_config_item` VALUES ('3', '1', 'xingqu', '兴趣标签', '3', '', '新闻,娱乐,房产,生活,文化,体育,财经,时尚,汽车,IT', '', '3', '30', '', '', '7', '0', '1');

-- ----------------------------
-- Table structure for `jc_content`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content`;
CREATE TABLE `jc_content` (
  `content_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) NOT NULL COMMENT '栏目ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `type_id` int(11) NOT NULL COMMENT '属性ID',
  `model_id` int(11) NOT NULL COMMENT '模型ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `sort_date` datetime NOT NULL COMMENT '排序日期',
  `top_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '固顶级别',
  `has_title_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有标题图',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `status` tinyint(4) NOT NULL DEFAULT '2' COMMENT '状态(0:草稿;1:审核中;2:审核通过;3:回收站；4:投稿)',
  `views_day` int(11) NOT NULL DEFAULT '0' COMMENT '日访问数',
  `comments_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日评论数',
  `downloads_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日下载数',
  `ups_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日顶数',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '得分',
  `root_channel_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`),
  KEY `fk_jc_content_site` (`site_id`),
  KEY `fk_jc_content_type` (`type_id`),
  KEY `fk_jc_content_user` (`user_id`),
  KEY `fk_jc_contentchannel` (`channel_id`),
  KEY `fk_jc_content_model` (`model_id`),
  CONSTRAINT `fk_jc_content_model` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`),
  CONSTRAINT `fk_jc_content_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_content_type` FOREIGN KEY (`type_id`) REFERENCES `jc_content_type` (`type_id`),
  CONSTRAINT `fk_jc_content_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_contentchannel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=598 DEFAULT CHARSET=utf8 COMMENT='CMS内容表';

-- ----------------------------
-- Records of jc_content
-- ----------------------------
INSERT INTO `jc_content` VALUES ('567', '93', '1', '1', '1', '1', '2015-03-29 21:55:36', '0', '0', '0', '2', '0', '0', '0', '0', '0', '71');
INSERT INTO `jc_content` VALUES ('568', '94', '1', '1', '1', '1', '2015-03-29 22:57:53', '0', '0', '0', '2', '0', '0', '0', '0', '0', '71');
INSERT INTO `jc_content` VALUES ('569', '94', '1', '1', '1', '1', '2015-03-29 23:07:34', '0', '0', '0', '2', '0', '0', '0', '0', '0', '71');
INSERT INTO `jc_content` VALUES ('570', '94', '1', '1', '1', '1', '2015-03-29 23:09:56', '0', '0', '0', '2', '0', '0', '0', '0', '0', '71');
INSERT INTO `jc_content` VALUES ('571', '94', '1', '1', '1', '1', '2015-03-29 23:12:35', '0', '0', '0', '2', '0', '0', '0', '0', '0', '71');
INSERT INTO `jc_content` VALUES ('572', '94', '1', '1', '1', '1', '2015-03-29 23:13:18', '0', '0', '0', '2', '0', '0', '0', '0', '0', '71');
INSERT INTO `jc_content` VALUES ('573', '94', '1', '1', '1', '1', '2015-03-29 23:14:22', '0', '0', '0', '2', '0', '0', '0', '0', '0', '71');
INSERT INTO `jc_content` VALUES ('574', '94', '1', '1', '1', '1', '2015-03-29 23:15:18', '0', '0', '0', '2', '0', '0', '0', '0', '0', '71');
INSERT INTO `jc_content` VALUES ('575', '94', '1', '1', '1', '1', '2015-03-29 23:17:04', '0', '0', '0', '2', '0', '0', '0', '0', '0', '71');
INSERT INTO `jc_content` VALUES ('576', '93', '1', '1', '1', '1', '2015-03-30 20:28:35', '0', '0', '0', '2', '0', '0', '0', '0', '0', '71');
INSERT INTO `jc_content` VALUES ('577', '84', '1', '1', '1', '1', '2015-03-30 20:31:20', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('578', '84', '1', '1', '1', '1', '2015-03-30 20:37:59', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('579', '78', '1', '1', '1', '1', '2015-03-30 20:44:35', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('580', '79', '1', '1', '1', '1', '2015-03-30 20:50:14', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('581', '72', '1', '5', '1', '1', '2015-03-31 22:19:12', '0', '0', '0', '2', '0', '0', '0', '0', '0', '72');
INSERT INTO `jc_content` VALUES ('582', '90', '1', '1', '1', '1', '2015-03-31 22:23:22', '0', '0', '0', '2', '0', '0', '0', '0', '0', '70');
INSERT INTO `jc_content` VALUES ('583', '90', '1', '1', '1', '1', '2015-03-31 22:26:42', '0', '0', '0', '2', '0', '0', '0', '0', '0', '70');
INSERT INTO `jc_content` VALUES ('584', '78', '1', '1', '1', '1', '2015-03-31 22:29:30', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('585', '76', '1', '1', '1', '1', '2015-03-31 22:33:21', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('586', '78', '1', '1', '1', '1', '2015-04-01 20:32:28', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('587', '85', '1', '1', '1', '1', '2015-04-01 20:34:38', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('588', '85', '1', '1', '1', '1', '2015-04-01 20:35:58', '0', '0', '0', '2', '2', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('589', '88', '1', '1', '1', '1', '2015-04-01 20:39:28', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('590', '88', '1', '1', '1', '1', '2015-04-01 20:42:42', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('591', '93', '1', '1', '1', '1', '2015-04-01 20:44:20', '0', '0', '0', '2', '2', '0', '0', '0', '0', '71');
INSERT INTO `jc_content` VALUES ('592', '95', '1', '1', '1', '1', '2015-04-02 21:59:04', '0', '0', '0', '2', '1', '0', '0', '0', '0', '70');
INSERT INTO `jc_content` VALUES ('593', '85', '1', '1', '1', '1', '2015-04-02 22:01:51', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('594', '85', '1', '1', '1', '1', '2015-04-02 22:05:09', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('595', '85', '1', '1', '1', '1', '2015-04-02 22:08:09', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('596', '79', '1', '1', '1', '1', '2015-04-02 22:10:31', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1');
INSERT INTO `jc_content` VALUES ('597', '85', '1', '1', '1', '1', '2015-04-02 22:11:48', '0', '0', '0', '2', '3', '0', '0', '0', '0', '1');

-- ----------------------------
-- Table structure for `jc_contenttag`
-- ----------------------------
DROP TABLE IF EXISTS `jc_contenttag`;
CREATE TABLE `jc_contenttag` (
  `content_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  KEY `fk_jc_content_tag` (`tag_id`),
  KEY `fk_jc_tag_content` (`content_id`),
  CONSTRAINT `fk_jc_content_tag` FOREIGN KEY (`tag_id`) REFERENCES `jc_content_tag` (`tag_id`),
  CONSTRAINT `fk_jc_tag_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容标签关联表';

-- ----------------------------
-- Records of jc_contenttag
-- ----------------------------
INSERT INTO `jc_contenttag` VALUES ('567', '12', '0');
INSERT INTO `jc_contenttag` VALUES ('567', '13', '1');
INSERT INTO `jc_contenttag` VALUES ('567', '14', '2');
INSERT INTO `jc_contenttag` VALUES ('567', '15', '3');
INSERT INTO `jc_contenttag` VALUES ('567', '16', '4');
INSERT INTO `jc_contenttag` VALUES ('568', '17', '0');
INSERT INTO `jc_contenttag` VALUES ('568', '18', '1');
INSERT INTO `jc_contenttag` VALUES ('568', '19', '2');
INSERT INTO `jc_contenttag` VALUES ('569', '20', '0');
INSERT INTO `jc_contenttag` VALUES ('569', '21', '1');
INSERT INTO `jc_contenttag` VALUES ('569', '22', '2');
INSERT INTO `jc_contenttag` VALUES ('570', '23', '0');
INSERT INTO `jc_contenttag` VALUES ('570', '21', '1');
INSERT INTO `jc_contenttag` VALUES ('570', '22', '2');
INSERT INTO `jc_contenttag` VALUES ('571', '24', '0');
INSERT INTO `jc_contenttag` VALUES ('571', '25', '1');
INSERT INTO `jc_contenttag` VALUES ('571', '26', '2');
INSERT INTO `jc_contenttag` VALUES ('571', '27', '3');
INSERT INTO `jc_contenttag` VALUES ('572', '24', '0');
INSERT INTO `jc_contenttag` VALUES ('572', '25', '1');
INSERT INTO `jc_contenttag` VALUES ('572', '28', '2');
INSERT INTO `jc_contenttag` VALUES ('572', '27', '3');
INSERT INTO `jc_contenttag` VALUES ('573', '24', '0');
INSERT INTO `jc_contenttag` VALUES ('573', '25', '1');
INSERT INTO `jc_contenttag` VALUES ('573', '29', '2');
INSERT INTO `jc_contenttag` VALUES ('573', '27', '3');
INSERT INTO `jc_contenttag` VALUES ('574', '24', '0');
INSERT INTO `jc_contenttag` VALUES ('574', '25', '1');
INSERT INTO `jc_contenttag` VALUES ('574', '30', '2');
INSERT INTO `jc_contenttag` VALUES ('574', '27', '3');
INSERT INTO `jc_contenttag` VALUES ('575', '24', '0');
INSERT INTO `jc_contenttag` VALUES ('575', '25', '1');
INSERT INTO `jc_contenttag` VALUES ('575', '31', '2');
INSERT INTO `jc_contenttag` VALUES ('575', '27', '3');
INSERT INTO `jc_contenttag` VALUES ('576', '32', '0');
INSERT INTO `jc_contenttag` VALUES ('576', '33', '1');
INSERT INTO `jc_contenttag` VALUES ('576', '34', '2');
INSERT INTO `jc_contenttag` VALUES ('576', '35', '3');
INSERT INTO `jc_contenttag` VALUES ('576', '36', '4');
INSERT INTO `jc_contenttag` VALUES ('576', '37', '5');
INSERT INTO `jc_contenttag` VALUES ('576', '38', '6');
INSERT INTO `jc_contenttag` VALUES ('576', '39', '7');
INSERT INTO `jc_contenttag` VALUES ('577', '40', '0');
INSERT INTO `jc_contenttag` VALUES ('577', '41', '1');
INSERT INTO `jc_contenttag` VALUES ('577', '42', '2');
INSERT INTO `jc_contenttag` VALUES ('577', '43', '3');
INSERT INTO `jc_contenttag` VALUES ('577', '44', '4');
INSERT INTO `jc_contenttag` VALUES ('577', '45', '5');
INSERT INTO `jc_contenttag` VALUES ('578', '46', '0');
INSERT INTO `jc_contenttag` VALUES ('578', '47', '1');
INSERT INTO `jc_contenttag` VALUES ('578', '48', '2');
INSERT INTO `jc_contenttag` VALUES ('578', '49', '3');
INSERT INTO `jc_contenttag` VALUES ('578', '50', '4');
INSERT INTO `jc_contenttag` VALUES ('578', '51', '5');
INSERT INTO `jc_contenttag` VALUES ('578', '52', '6');
INSERT INTO `jc_contenttag` VALUES ('579', '53', '0');
INSERT INTO `jc_contenttag` VALUES ('579', '47', '1');
INSERT INTO `jc_contenttag` VALUES ('579', '54', '2');
INSERT INTO `jc_contenttag` VALUES ('579', '55', '3');
INSERT INTO `jc_contenttag` VALUES ('579', '56', '4');
INSERT INTO `jc_contenttag` VALUES ('579', '57', '5');
INSERT INTO `jc_contenttag` VALUES ('579', '58', '6');
INSERT INTO `jc_contenttag` VALUES ('579', '59', '7');
INSERT INTO `jc_contenttag` VALUES ('579', '60', '8');
INSERT INTO `jc_contenttag` VALUES ('579', '61', '9');
INSERT INTO `jc_contenttag` VALUES ('579', '62', '10');
INSERT INTO `jc_contenttag` VALUES ('579', '63', '11');
INSERT INTO `jc_contenttag` VALUES ('580', '64', '0');
INSERT INTO `jc_contenttag` VALUES ('580', '65', '1');
INSERT INTO `jc_contenttag` VALUES ('580', '66', '2');
INSERT INTO `jc_contenttag` VALUES ('580', '67', '3');
INSERT INTO `jc_contenttag` VALUES ('582', '68', '0');
INSERT INTO `jc_contenttag` VALUES ('582', '69', '1');
INSERT INTO `jc_contenttag` VALUES ('582', '70', '2');
INSERT INTO `jc_contenttag` VALUES ('582', '71', '3');
INSERT INTO `jc_contenttag` VALUES ('582', '72', '4');
INSERT INTO `jc_contenttag` VALUES ('582', '73', '5');
INSERT INTO `jc_contenttag` VALUES ('583', '74', '0');
INSERT INTO `jc_contenttag` VALUES ('583', '75', '1');
INSERT INTO `jc_contenttag` VALUES ('583', '76', '2');
INSERT INTO `jc_contenttag` VALUES ('583', '77', '3');
INSERT INTO `jc_contenttag` VALUES ('583', '78', '4');
INSERT INTO `jc_contenttag` VALUES ('583', '79', '5');
INSERT INTO `jc_contenttag` VALUES ('583', '80', '6');
INSERT INTO `jc_contenttag` VALUES ('584', '53', '0');
INSERT INTO `jc_contenttag` VALUES ('584', '81', '1');
INSERT INTO `jc_contenttag` VALUES ('584', '82', '2');
INSERT INTO `jc_contenttag` VALUES ('584', '83', '3');
INSERT INTO `jc_contenttag` VALUES ('584', '84', '4');
INSERT INTO `jc_contenttag` VALUES ('585', '85', '0');
INSERT INTO `jc_contenttag` VALUES ('585', '86', '1');
INSERT INTO `jc_contenttag` VALUES ('585', '87', '2');
INSERT INTO `jc_contenttag` VALUES ('585', '88', '3');
INSERT INTO `jc_contenttag` VALUES ('585', '89', '4');
INSERT INTO `jc_contenttag` VALUES ('586', '53', '0');
INSERT INTO `jc_contenttag` VALUES ('586', '90', '1');
INSERT INTO `jc_contenttag` VALUES ('586', '91', '2');
INSERT INTO `jc_contenttag` VALUES ('587', '92', '0');
INSERT INTO `jc_contenttag` VALUES ('587', '93', '1');
INSERT INTO `jc_contenttag` VALUES ('587', '94', '2');
INSERT INTO `jc_contenttag` VALUES ('587', '95', '3');
INSERT INTO `jc_contenttag` VALUES ('587', '96', '4');
INSERT INTO `jc_contenttag` VALUES ('587', '97', '5');
INSERT INTO `jc_contenttag` VALUES ('587', '98', '6');
INSERT INTO `jc_contenttag` VALUES ('587', '99', '7');
INSERT INTO `jc_contenttag` VALUES ('587', '100', '8');
INSERT INTO `jc_contenttag` VALUES ('588', '101', '0');
INSERT INTO `jc_contenttag` VALUES ('588', '102', '1');
INSERT INTO `jc_contenttag` VALUES ('588', '103', '2');
INSERT INTO `jc_contenttag` VALUES ('588', '104', '3');
INSERT INTO `jc_contenttag` VALUES ('589', '105', '0');
INSERT INTO `jc_contenttag` VALUES ('589', '106', '1');
INSERT INTO `jc_contenttag` VALUES ('589', '79', '2');
INSERT INTO `jc_contenttag` VALUES ('589', '107', '3');
INSERT INTO `jc_contenttag` VALUES ('590', '108', '0');
INSERT INTO `jc_contenttag` VALUES ('590', '109', '1');
INSERT INTO `jc_contenttag` VALUES ('590', '110', '2');
INSERT INTO `jc_contenttag` VALUES ('590', '103', '3');
INSERT INTO `jc_contenttag` VALUES ('590', '111', '4');
INSERT INTO `jc_contenttag` VALUES ('591', '112', '0');
INSERT INTO `jc_contenttag` VALUES ('591', '113', '1');
INSERT INTO `jc_contenttag` VALUES ('591', '114', '2');
INSERT INTO `jc_contenttag` VALUES ('591', '115', '3');
INSERT INTO `jc_contenttag` VALUES ('591', '116', '4');
INSERT INTO `jc_contenttag` VALUES ('592', '108', '0');
INSERT INTO `jc_contenttag` VALUES ('592', '117', '1');
INSERT INTO `jc_contenttag` VALUES ('592', '118', '2');
INSERT INTO `jc_contenttag` VALUES ('592', '119', '3');
INSERT INTO `jc_contenttag` VALUES ('592', '120', '4');
INSERT INTO `jc_contenttag` VALUES ('593', '92', '0');
INSERT INTO `jc_contenttag` VALUES ('593', '121', '1');
INSERT INTO `jc_contenttag` VALUES ('593', '122', '2');
INSERT INTO `jc_contenttag` VALUES ('593', '123', '3');
INSERT INTO `jc_contenttag` VALUES ('594', '124', '0');
INSERT INTO `jc_contenttag` VALUES ('594', '125', '1');
INSERT INTO `jc_contenttag` VALUES ('594', '93', '2');
INSERT INTO `jc_contenttag` VALUES ('594', '126', '3');
INSERT INTO `jc_contenttag` VALUES ('594', '127', '4');
INSERT INTO `jc_contenttag` VALUES ('594', '128', '5');
INSERT INTO `jc_contenttag` VALUES ('594', '48', '6');
INSERT INTO `jc_contenttag` VALUES ('594', '129', '7');
INSERT INTO `jc_contenttag` VALUES ('595', '92', '0');
INSERT INTO `jc_contenttag` VALUES ('595', '130', '1');
INSERT INTO `jc_contenttag` VALUES ('595', '131', '2');
INSERT INTO `jc_contenttag` VALUES ('595', '132', '3');
INSERT INTO `jc_contenttag` VALUES ('596', '133', '0');
INSERT INTO `jc_contenttag` VALUES ('596', '134', '1');
INSERT INTO `jc_contenttag` VALUES ('596', '135', '2');
INSERT INTO `jc_contenttag` VALUES ('596', '136', '3');
INSERT INTO `jc_contenttag` VALUES ('596', '137', '4');
INSERT INTO `jc_contenttag` VALUES ('596', '138', '5');
INSERT INTO `jc_contenttag` VALUES ('596', '139', '6');
INSERT INTO `jc_contenttag` VALUES ('596', '140', '7');
INSERT INTO `jc_contenttag` VALUES ('597', '141', '0');
INSERT INTO `jc_contenttag` VALUES ('597', '142', '1');
INSERT INTO `jc_contenttag` VALUES ('597', '55', '2');
INSERT INTO `jc_contenttag` VALUES ('597', '143', '3');

-- ----------------------------
-- Table structure for `jc_content_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_attachment`;
CREATE TABLE `jc_content_attachment` (
  `content_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL COMMENT '排列顺序',
  `attachment_path` varchar(255) NOT NULL COMMENT '附件路径',
  `attachment_name` varchar(100) NOT NULL COMMENT '附件名称',
  `filename` varchar(100) DEFAULT NULL COMMENT '文件名',
  `download_count` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  KEY `fk_jc_attachment_content` (`content_id`),
  CONSTRAINT `fk_jc_attachment_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容附件表';

-- ----------------------------
-- Records of jc_content_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_content_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_attr`;
CREATE TABLE `jc_content_attr` (
  `content_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_content` (`content_id`),
  CONSTRAINT `fk_jc_attr_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容扩展属性表';

-- ----------------------------
-- Records of jc_content_attr
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_content_channel`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_channel`;
CREATE TABLE `jc_content_channel` (
  `channel_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`content_id`),
  KEY `fk_jc_channel_content` (`content_id`),
  CONSTRAINT `fk_jc_channel_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_content_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容栏目关联表';

-- ----------------------------
-- Records of jc_content_channel
-- ----------------------------
INSERT INTO `jc_content_channel` VALUES ('93', '567');
INSERT INTO `jc_content_channel` VALUES ('94', '568');
INSERT INTO `jc_content_channel` VALUES ('94', '569');
INSERT INTO `jc_content_channel` VALUES ('94', '570');
INSERT INTO `jc_content_channel` VALUES ('94', '571');
INSERT INTO `jc_content_channel` VALUES ('94', '572');
INSERT INTO `jc_content_channel` VALUES ('94', '573');
INSERT INTO `jc_content_channel` VALUES ('94', '574');
INSERT INTO `jc_content_channel` VALUES ('94', '575');
INSERT INTO `jc_content_channel` VALUES ('93', '576');
INSERT INTO `jc_content_channel` VALUES ('84', '577');
INSERT INTO `jc_content_channel` VALUES ('84', '578');
INSERT INTO `jc_content_channel` VALUES ('78', '579');
INSERT INTO `jc_content_channel` VALUES ('79', '580');
INSERT INTO `jc_content_channel` VALUES ('72', '581');
INSERT INTO `jc_content_channel` VALUES ('90', '582');
INSERT INTO `jc_content_channel` VALUES ('90', '583');
INSERT INTO `jc_content_channel` VALUES ('78', '584');
INSERT INTO `jc_content_channel` VALUES ('76', '585');
INSERT INTO `jc_content_channel` VALUES ('78', '586');
INSERT INTO `jc_content_channel` VALUES ('85', '587');
INSERT INTO `jc_content_channel` VALUES ('85', '588');
INSERT INTO `jc_content_channel` VALUES ('88', '589');
INSERT INTO `jc_content_channel` VALUES ('88', '590');
INSERT INTO `jc_content_channel` VALUES ('93', '591');
INSERT INTO `jc_content_channel` VALUES ('95', '592');
INSERT INTO `jc_content_channel` VALUES ('85', '593');
INSERT INTO `jc_content_channel` VALUES ('85', '594');
INSERT INTO `jc_content_channel` VALUES ('85', '595');
INSERT INTO `jc_content_channel` VALUES ('79', '596');
INSERT INTO `jc_content_channel` VALUES ('85', '597');

-- ----------------------------
-- Table structure for `jc_content_check`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_check`;
CREATE TABLE `jc_content_check` (
  `content_id` int(11) NOT NULL,
  `check_step` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核步数',
  `check_opinion` varchar(255) DEFAULT NULL COMMENT '审核意见',
  `is_rejected` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否退回',
  `reviewer` int(11) DEFAULT NULL COMMENT '终审者',
  `check_date` datetime DEFAULT NULL COMMENT '终审时间',
  PRIMARY KEY (`content_id`),
  KEY `fk_jc_content_check_user` (`reviewer`),
  CONSTRAINT `fk_jc_check_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_content_check_user` FOREIGN KEY (`reviewer`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容审核信息表';

-- ----------------------------
-- Records of jc_content_check
-- ----------------------------
INSERT INTO `jc_content_check` VALUES ('567', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('568', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('569', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('570', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('571', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('572', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('573', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('574', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('575', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('576', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('577', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('578', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('579', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('580', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('581', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('582', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('583', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('584', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('585', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('586', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('587', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('588', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('589', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('590', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('591', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('592', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('593', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('594', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('595', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('596', '3', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('597', '3', null, '0', null, null);

-- ----------------------------
-- Table structure for `jc_content_count`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_count`;
CREATE TABLE `jc_content_count` (
  `content_id` int(11) NOT NULL,
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '总访问数',
  `views_month` int(11) NOT NULL DEFAULT '0' COMMENT '月访问数',
  `views_week` int(11) NOT NULL DEFAULT '0' COMMENT '周访问数',
  `views_day` int(11) NOT NULL DEFAULT '0' COMMENT '日访问数',
  `comments` int(11) NOT NULL DEFAULT '0' COMMENT '总评论数',
  `comments_month` int(11) NOT NULL DEFAULT '0' COMMENT '月评论数',
  `comments_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周评论数',
  `comments_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日评论数',
  `downloads` int(11) NOT NULL DEFAULT '0' COMMENT '总下载数',
  `downloads_month` int(11) NOT NULL DEFAULT '0' COMMENT '月下载数',
  `downloads_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周下载数',
  `downloads_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日下载数',
  `ups` int(11) NOT NULL DEFAULT '0' COMMENT '总顶数',
  `ups_month` int(11) NOT NULL DEFAULT '0' COMMENT '月顶数',
  `ups_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周顶数',
  `ups_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日顶数',
  `downs` int(11) NOT NULL DEFAULT '0' COMMENT '总踩数',
  PRIMARY KEY (`content_id`),
  CONSTRAINT `fk_jc_count_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容计数表';

-- ----------------------------
-- Records of jc_content_count
-- ----------------------------
INSERT INTO `jc_content_count` VALUES ('567', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('568', '3', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('569', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('570', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('571', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('572', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('573', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('574', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('575', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('576', '3', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('577', '4', '1', '4', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('578', '2', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('579', '5', '0', '5', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('580', '2', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('581', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('582', '3', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('583', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('584', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('585', '2', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('586', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('587', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('588', '2', '2', '2', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('589', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('590', '2', '2', '2', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('591', '2', '2', '2', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('592', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('593', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('595', '2', '2', '2', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('596', '2', '2', '2', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('597', '8', '8', '8', '8', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `jc_content_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_ext`;
CREATE TABLE `jc_content_ext` (
  `content_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL COMMENT '标题',
  `short_title` varchar(150) DEFAULT NULL COMMENT '简短标题',
  `author` varchar(100) DEFAULT NULL COMMENT '作者',
  `origin` varchar(100) DEFAULT NULL COMMENT '来源',
  `origin_url` varchar(255) DEFAULT NULL COMMENT '来源链接',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `release_date` datetime NOT NULL COMMENT '发布日期',
  `media_path` varchar(255) DEFAULT NULL COMMENT '媒体路径',
  `media_type` varchar(20) DEFAULT NULL COMMENT '媒体类型',
  `title_color` varchar(10) DEFAULT NULL COMMENT '标题颜色',
  `is_bold` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否加粗',
  `title_img` varchar(100) DEFAULT NULL COMMENT '标题图片',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图片',
  `type_img` varchar(100) DEFAULT NULL COMMENT '类型图片',
  `link` varchar(255) DEFAULT NULL COMMENT '外部链接',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '指定模板',
  `need_regenerate` tinyint(1) NOT NULL DEFAULT '1' COMMENT '需要重新生成静态页',
  PRIMARY KEY (`content_id`),
  CONSTRAINT `fk_jc_ext_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容扩展表';

-- ----------------------------
-- Records of jc_content_ext
-- ----------------------------
INSERT INTO `jc_content_ext` VALUES ('567', '风陵渡口博客开通了，欢迎访问。', null, '于辰', null, null, '风陵渡口博客开通了，欢迎访问。', '2015-03-29 21:55:36', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('568', '姓名学笔画大全', null, null, null, null, null, '2015-03-29 22:57:53', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('569', '女孩常用名', null, null, null, null, null, '2015-03-29 23:07:34', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('570', '男孩常用名', null, null, null, null, null, '2015-03-29 23:09:56', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('571', '五行属木的汉字', null, null, null, null, null, '2015-03-29 23:12:35', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('572', '五行属火的汉字', null, null, null, null, null, '2015-03-29 23:13:18', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('573', '五行属土的汉字', null, null, null, null, null, '2015-03-29 23:14:22', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('574', '五行属金的汉字', null, null, null, null, null, '2015-03-29 23:15:18', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('575', '五行属水的汉字', null, null, null, null, null, '2015-03-29 23:17:04', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('576', 'QQ升到9个太阳需要58年左右时间! ', null, null, null, null, null, '2015-03-30 20:28:35', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('577', 'Null value was assigned to a property of primitive type setter of 的原因与解决方案', null, null, null, null, null, '2015-03-30 20:31:20', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('578', '实体类注解错误：Could not determine type for: com.xxx.entity.Site', null, null, null, null, null, '2015-03-30 20:37:59', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('579', 'hibernate 注解方式配置OneToMany（一对多）连接查询（非外键）', null, null, null, null, null, '2015-03-30 20:44:35', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('580', 'CSRF 攻击的应对之道', null, null, null, null, null, '2015-03-30 20:50:14', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('581', '2015-03-31', null, null, null, null, null, '2015-03-31 22:19:12', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('582', 'Windows查看端口占用及杀掉进程', null, null, null, null, null, '2015-03-31 22:23:22', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('583', 'spring mvc @PathVariable绑定URI模板变量值', null, '于辰', null, null, null, '2015-03-31 22:26:42', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('584', 'No Hibernate Session bound to thread, and configuration does not allow creation ', null, null, null, null, null, '2015-03-31 22:29:30', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('585', 'Mysql复制表结构、表数据', null, null, null, null, null, '2015-03-31 22:33:21', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('586', 'hibernate cascade解释', null, null, null, null, null, '2015-04-01 20:32:28', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('587', 'myeclipse 配合tomcat启动导致虚拟机崩溃解决方法No shared spaces configured.', null, null, null, null, null, '2015-04-01 20:34:38', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('588', 'jdk6版本下载地址', null, null, null, null, null, '2015-04-01 20:35:58', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('589', 'jquery ajax 模板代码', null, null, null, null, null, '2015-04-01 20:39:28', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('590', 'java servlet中通知以流的方式下载文件', null, null, null, null, null, '2015-04-01 20:42:42', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('591', '百度贴吧等级经验对照表', null, null, null, null, null, '2015-04-01 20:44:20', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('592', 'java程序员职业发展路线图', null, null, null, null, null, '2015-04-02 21:59:04', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('593', 'Errors occurred during the build.  Errors running builder \'JavaScript Validator\'', null, null, null, null, null, '2015-04-02 22:01:51', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('594', 'Error staring Tomcat Cannot connect to VM错误解决办法', null, null, null, null, null, '2015-04-02 22:05:09', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('595', 'MyEclipse中更改SVN密码  ', null, null, null, null, null, '2015-04-02 22:08:09', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('596', '页面加载完毕后滚动到指定位置', null, null, null, null, null, '2015-04-02 22:10:31', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('597', 'Nginx Location配置总结', null, null, null, null, null, '2015-04-02 22:11:48', null, null, null, '0', null, null, null, null, null, '1');

-- ----------------------------
-- Table structure for `jc_content_group_view`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_group_view`;
CREATE TABLE `jc_content_group_view` (
  `content_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`,`group_id`),
  KEY `fk_jc_content_group_v` (`group_id`),
  CONSTRAINT `fk_jc_content_group_v` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_content_v` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容浏览会员组关联表';

-- ----------------------------
-- Records of jc_content_group_view
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_content_picture`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_picture`;
CREATE TABLE `jc_content_picture` (
  `content_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL COMMENT '排列顺序',
  `img_path` varchar(100) NOT NULL COMMENT '图片地址',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`content_id`,`priority`),
  CONSTRAINT `fk_jc_picture_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容图片表';

-- ----------------------------
-- Records of jc_content_picture
-- ----------------------------
INSERT INTO `jc_content_picture` VALUES ('567', '0', '/fengling/u/cms/blog/201503/29224424x3ii.jpg', '');
INSERT INTO `jc_content_picture` VALUES ('593', '0', '/fengling/u/cms/blog/201504/02220126w4yu.png', '');
INSERT INTO `jc_content_picture` VALUES ('594', '0', '/fengling/u/cms/blog/201504/02220434rrl2.png', '');
INSERT INTO `jc_content_picture` VALUES ('594', '1', '/fengling/u/cms/blog/201504/02220434vdq5.png', '');
INSERT INTO `jc_content_picture` VALUES ('595', '0', '/fengling/u/cms/blog/201504/02220751well.png', '');

-- ----------------------------
-- Table structure for `jc_content_tag`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_tag`;
CREATE TABLE `jc_content_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(50) NOT NULL COMMENT 'tag名称',
  `ref_counter` int(11) NOT NULL DEFAULT '1' COMMENT '被引用的次数',
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `ak_tag_name` (`tag_name`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8 COMMENT='CMS内容TAG表';

-- ----------------------------
-- Records of jc_content_tag
-- ----------------------------
INSERT INTO `jc_content_tag` VALUES ('12', '风陵渡口', '1');
INSERT INTO `jc_content_tag` VALUES ('13', '博客', '1');
INSERT INTO `jc_content_tag` VALUES ('14', '开通', '1');
INSERT INTO `jc_content_tag` VALUES ('15', '欢迎', '1');
INSERT INTO `jc_content_tag` VALUES ('16', '访问', '1');
INSERT INTO `jc_content_tag` VALUES ('17', '姓名学', '1');
INSERT INTO `jc_content_tag` VALUES ('18', '笔画', '1');
INSERT INTO `jc_content_tag` VALUES ('19', '大全', '1');
INSERT INTO `jc_content_tag` VALUES ('20', '女孩', '1');
INSERT INTO `jc_content_tag` VALUES ('21', '常用', '2');
INSERT INTO `jc_content_tag` VALUES ('22', '名', '2');
INSERT INTO `jc_content_tag` VALUES ('23', '男孩', '1');
INSERT INTO `jc_content_tag` VALUES ('24', '五行', '5');
INSERT INTO `jc_content_tag` VALUES ('25', '属', '5');
INSERT INTO `jc_content_tag` VALUES ('26', '木', '1');
INSERT INTO `jc_content_tag` VALUES ('27', '汉字', '5');
INSERT INTO `jc_content_tag` VALUES ('28', '火', '1');
INSERT INTO `jc_content_tag` VALUES ('29', '土', '1');
INSERT INTO `jc_content_tag` VALUES ('30', '金', '1');
INSERT INTO `jc_content_tag` VALUES ('31', '水', '1');
INSERT INTO `jc_content_tag` VALUES ('32', 'qq', '1');
INSERT INTO `jc_content_tag` VALUES ('33', '升到', '1');
INSERT INTO `jc_content_tag` VALUES ('34', '9个', '1');
INSERT INTO `jc_content_tag` VALUES ('35', '太阳', '1');
INSERT INTO `jc_content_tag` VALUES ('36', '需要', '1');
INSERT INTO `jc_content_tag` VALUES ('37', '58年', '1');
INSERT INTO `jc_content_tag` VALUES ('38', '左右', '1');
INSERT INTO `jc_content_tag` VALUES ('39', '时间', '1');
INSERT INTO `jc_content_tag` VALUES ('40', 'null', '1');
INSERT INTO `jc_content_tag` VALUES ('41', 'value', '1');
INSERT INTO `jc_content_tag` VALUES ('42', 'assigned', '1');
INSERT INTO `jc_content_tag` VALUES ('43', 'property', '1');
INSERT INTO `jc_content_tag` VALUES ('44', 'primitive', '1');
INSERT INTO `jc_content_tag` VALUES ('45', '解决方案', '1');
INSERT INTO `jc_content_tag` VALUES ('46', '实体类', '1');
INSERT INTO `jc_content_tag` VALUES ('47', '注解', '2');
INSERT INTO `jc_content_tag` VALUES ('48', '错误', '2');
INSERT INTO `jc_content_tag` VALUES ('49', 'could', '1');
INSERT INTO `jc_content_tag` VALUES ('50', 'determine', '1');
INSERT INTO `jc_content_tag` VALUES ('51', 'type', '1');
INSERT INTO `jc_content_tag` VALUES ('52', 'com.xxx.entity.site', '1');
INSERT INTO `jc_content_tag` VALUES ('53', 'hibernate', '3');
INSERT INTO `jc_content_tag` VALUES ('54', '方式', '1');
INSERT INTO `jc_content_tag` VALUES ('55', '配置', '2');
INSERT INTO `jc_content_tag` VALUES ('56', 'onetomany', '1');
INSERT INTO `jc_content_tag` VALUES ('57', '一对', '1');
INSERT INTO `jc_content_tag` VALUES ('58', '多', '1');
INSERT INTO `jc_content_tag` VALUES ('59', '连接', '1');
INSERT INTO `jc_content_tag` VALUES ('60', '查询', '1');
INSERT INTO `jc_content_tag` VALUES ('61', '非', '1');
INSERT INTO `jc_content_tag` VALUES ('62', '外', '1');
INSERT INTO `jc_content_tag` VALUES ('63', '键', '1');
INSERT INTO `jc_content_tag` VALUES ('64', 'csrf', '1');
INSERT INTO `jc_content_tag` VALUES ('65', '攻击', '1');
INSERT INTO `jc_content_tag` VALUES ('66', '应对', '1');
INSERT INTO `jc_content_tag` VALUES ('67', '之道', '1');
INSERT INTO `jc_content_tag` VALUES ('68', 'windows', '1');
INSERT INTO `jc_content_tag` VALUES ('69', '查看', '1');
INSERT INTO `jc_content_tag` VALUES ('70', '端口', '1');
INSERT INTO `jc_content_tag` VALUES ('71', '占用', '1');
INSERT INTO `jc_content_tag` VALUES ('72', '杀掉', '1');
INSERT INTO `jc_content_tag` VALUES ('73', '进程', '1');
INSERT INTO `jc_content_tag` VALUES ('74', 'spring', '1');
INSERT INTO `jc_content_tag` VALUES ('75', 'mvc', '1');
INSERT INTO `jc_content_tag` VALUES ('76', 'pathvariable', '1');
INSERT INTO `jc_content_tag` VALUES ('77', '绑定', '1');
INSERT INTO `jc_content_tag` VALUES ('78', 'uri', '1');
INSERT INTO `jc_content_tag` VALUES ('79', '模板', '2');
INSERT INTO `jc_content_tag` VALUES ('80', '变量值', '1');
INSERT INTO `jc_content_tag` VALUES ('81', 'session', '1');
INSERT INTO `jc_content_tag` VALUES ('82', 'thread', '1');
INSERT INTO `jc_content_tag` VALUES ('83', 'configuration', '1');
INSERT INTO `jc_content_tag` VALUES ('84', 'creation', '1');
INSERT INTO `jc_content_tag` VALUES ('85', 'mysql', '1');
INSERT INTO `jc_content_tag` VALUES ('86', '复制', '1');
INSERT INTO `jc_content_tag` VALUES ('87', '表结构', '1');
INSERT INTO `jc_content_tag` VALUES ('88', '表', '1');
INSERT INTO `jc_content_tag` VALUES ('89', '数据', '1');
INSERT INTO `jc_content_tag` VALUES ('90', 'cascade', '1');
INSERT INTO `jc_content_tag` VALUES ('91', '解释', '1');
INSERT INTO `jc_content_tag` VALUES ('92', 'myeclipse', '3');
INSERT INTO `jc_content_tag` VALUES ('93', 'tomcat', '2');
INSERT INTO `jc_content_tag` VALUES ('94', '启动', '1');
INSERT INTO `jc_content_tag` VALUES ('95', '导致', '1');
INSERT INTO `jc_content_tag` VALUES ('96', '虚拟机', '1');
INSERT INTO `jc_content_tag` VALUES ('97', '崩溃', '1');
INSERT INTO `jc_content_tag` VALUES ('98', '解决方法', '1');
INSERT INTO `jc_content_tag` VALUES ('99', 'shared', '1');
INSERT INTO `jc_content_tag` VALUES ('100', 'spaces', '1');
INSERT INTO `jc_content_tag` VALUES ('101', 'jdk6', '1');
INSERT INTO `jc_content_tag` VALUES ('102', '版本', '1');
INSERT INTO `jc_content_tag` VALUES ('103', '下载', '2');
INSERT INTO `jc_content_tag` VALUES ('104', '地址', '1');
INSERT INTO `jc_content_tag` VALUES ('105', 'jquery', '1');
INSERT INTO `jc_content_tag` VALUES ('106', 'ajax', '1');
INSERT INTO `jc_content_tag` VALUES ('107', '代码', '1');
INSERT INTO `jc_content_tag` VALUES ('108', 'java', '2');
INSERT INTO `jc_content_tag` VALUES ('109', 'servlet', '1');
INSERT INTO `jc_content_tag` VALUES ('110', '流方式', '1');
INSERT INTO `jc_content_tag` VALUES ('111', '文件', '1');
INSERT INTO `jc_content_tag` VALUES ('112', '百度', '1');
INSERT INTO `jc_content_tag` VALUES ('113', '贴吧', '1');
INSERT INTO `jc_content_tag` VALUES ('114', '等级', '1');
INSERT INTO `jc_content_tag` VALUES ('115', '经验', '1');
INSERT INTO `jc_content_tag` VALUES ('116', '对照表', '1');
INSERT INTO `jc_content_tag` VALUES ('117', '程序员', '1');
INSERT INTO `jc_content_tag` VALUES ('118', '职业', '1');
INSERT INTO `jc_content_tag` VALUES ('119', '发展', '1');
INSERT INTO `jc_content_tag` VALUES ('120', '路线图', '1');
INSERT INTO `jc_content_tag` VALUES ('121', 'errors', '1');
INSERT INTO `jc_content_tag` VALUES ('122', 'javascript', '1');
INSERT INTO `jc_content_tag` VALUES ('123', 'validator', '1');
INSERT INTO `jc_content_tag` VALUES ('124', 'error', '1');
INSERT INTO `jc_content_tag` VALUES ('125', 'staring', '1');
INSERT INTO `jc_content_tag` VALUES ('126', 'cannot', '1');
INSERT INTO `jc_content_tag` VALUES ('127', 'connect', '1');
INSERT INTO `jc_content_tag` VALUES ('128', 'vm', '1');
INSERT INTO `jc_content_tag` VALUES ('129', '解决办法', '1');
INSERT INTO `jc_content_tag` VALUES ('130', '更改', '1');
INSERT INTO `jc_content_tag` VALUES ('131', 'svn', '1');
INSERT INTO `jc_content_tag` VALUES ('132', '密码', '1');
INSERT INTO `jc_content_tag` VALUES ('133', '页面', '1');
INSERT INTO `jc_content_tag` VALUES ('134', '加载', '1');
INSERT INTO `jc_content_tag` VALUES ('135', '完毕', '1');
INSERT INTO `jc_content_tag` VALUES ('136', '后', '1');
INSERT INTO `jc_content_tag` VALUES ('137', '滚', '1');
INSERT INTO `jc_content_tag` VALUES ('138', '动到', '1');
INSERT INTO `jc_content_tag` VALUES ('139', '指定', '1');
INSERT INTO `jc_content_tag` VALUES ('140', '位置', '1');
INSERT INTO `jc_content_tag` VALUES ('141', 'nginx', '1');
INSERT INTO `jc_content_tag` VALUES ('142', 'location', '1');
INSERT INTO `jc_content_tag` VALUES ('143', '总结', '1');

-- ----------------------------
-- Table structure for `jc_content_topic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_topic`;
CREATE TABLE `jc_content_topic` (
  `content_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`,`topic_id`),
  KEY `fk_jc_content_topic` (`topic_id`),
  CONSTRAINT `fk_jc_content_topic` FOREIGN KEY (`topic_id`) REFERENCES `jc_topic` (`topic_id`),
  CONSTRAINT `fk_jc_topic_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS专题内容关联表';

-- ----------------------------
-- Records of jc_content_topic
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_content_txt`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_txt`;
CREATE TABLE `jc_content_txt` (
  `content_id` int(11) NOT NULL,
  `txt` longtext COMMENT '文章内容',
  `txt1` longtext COMMENT '扩展内容1',
  `txt2` longtext COMMENT '扩展内容2',
  `txt3` longtext COMMENT '扩展内容3',
  PRIMARY KEY (`content_id`),
  CONSTRAINT `fk_jc_txt_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容文本表';

-- ----------------------------
-- Records of jc_content_txt
-- ----------------------------
INSERT INTO `jc_content_txt` VALUES ('567', '<p>风陵渡口博客开通了，欢迎访问。</p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('568', '<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">１ 画 一 乙&nbsp;<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	２ 画 二 乃 了 人 入 刀 力 卜 又 几 丁&nbsp;<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	３ 画 三 上 下 久 个 丸 乞 也 于 千 大 子 寸 小 山 川 工 己 匀 女 子&nbsp;<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	４ 画 四 中 丹 之 予 云 井 亢 介 仁 元 公 切 分 化 午 升 友 及 太 天 夫 少 引 心</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">户 支 文 斗 斤 方 日 月 木 火 水比&nbsp;<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	５ 画 五 丘 且 世 丙 主 井 仕 仙 代 令 充 冬 出 加 功 包 北 半 占 卯 右 可 句 叶</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;古 司 只 召 外 本 巧 巨市 布 平 弘 弗 必 戊 旦 正 民 永 玉 瓦 甘 生 用 田 由 甲 申 白 目 石 穴 立<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	６ 画 六 亘 交 仰 任 仲 伏 仔 光 先 兆 全 共 再 列 印 合 吉 向 后 同 名 宇 存 安</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">字 守 州 帆 年 旭 早 有 求 百 弛竹 米 羊 羽 臣 自 至 舟 行 衣 西 回 如 成<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	７ 画 七 亨 吾 均 坐 壮 声 妙 孝 宏 局 希 序 志 戒 改 更 杏 材 村 位 佑 作 伯 伴</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">体 余 克 兑 兔 兵 初 判 利 助 告君 步 江 汗 汝 池 秀 究 良 见 言 谷 豆 赤 车 辰<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	８ 画 八 并 事 亨 京 依 佳 侃 供 侍 使 佩 来 例 免 雨 其 具 典 冒 冽 函 刻 刷 刹</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;制 到 效 协 卓 卷 取 受和 周 命 固 坤 垂 坦 坡 夜 奇 奈 奉 姑 始 妹 枚 板 林 欣</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;武 汲 决 沙 汰 冲 沛 沐沃 汪 炎 炊 版 物 牧 玖 的 直 盲 知 社 空 究 舌 虎 采 金</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;长 昔 明 旺 服 朋 杭 果枝 松 扭 东 门 青 季 孟 宜 官 宗 宙 定 尚 居 岳 岸 岩 岱</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;幸 庚 店 府 弦 征 彼 往快 忽 忠 念 或 所 房 技 承 折 扶 政 放 齐 于 昂 昆 昌 升 昊<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	９ 画 九 亭 亮 系 侠 信 俊 保 便 侣 俞 冒 冠 克 前 则 劲 勉 勃 勇 南 厚 叙 咸 哄 品</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;垠 奎 奏 威 姻 姬 姜 妍姿 客 宣 室 屋 巷 帝 幽 度 回 建 彦 待 律 思 性 易 招 拓<span style=\"background-color: inherit; line-height: 1.5;\">折</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\"><span style=\"background-color: inherit; line-height: 1.5;\">&nbsp;拜 抱 施 映 昨 是 春星 昭 架 柯 查 柴 柔 柘 韦 柱 柏 柄 柳 段 油 泳 沿 河 况</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;注 泉 泰 治 波 泊 法 冷炳 帅 甚 界 皆 皇 盈 看 相 眉 祈 科 秋 秒 穿 突 竿 红 罕</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;美 耐 肖 衍 表 要 计 订贞 军 重 门 面 革 音 风 飞 食 首 香 姣</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">１０ 画 十 乘 倚 幸 仓 修 借 值 倍 仿 表 伦 党 兼 倡 刚 原 员 哥 唐 哲 城 夏 娥 宴</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;家 宫 宰 容 射 展 峡 岛峰 师 席 库 航 般 芽 芹 花 芝 芳 娘 袁 衿 活 洪 洲 ? 洗 洞</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;派 洋 流 烘 烈 特 珂 珊珍 玲 益 真 词 神 祝 组 祚 秦 秤 租 秘 并 竟 级 纱 纯 素 纳</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;纽 纺 纹 翁 者 耘 耿 育股 皋 座 庭 径 徐 恩 恭 恢 恒 恤 息 恬 扇 拾 持 效 料 旁 旅</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;晏 晃 时 晋 书 朔 校 格桂 根 栖 桃 桐 钊 殊 气 记 训 讨 豹 贡 财 起 马 支 高 娟 倩 娜</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">１１ 画 乾 伟 偕 健 偶 侧 停 侦 富 凰 剩 副 勘 动 务 区 卿 参 唯 启 商 唱 珠 般 产 皎</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;尽 眼 婉 研 祥 移 竟 章笛 伏 笙 弦 紫 绅 绍 绊 累 罩 习 翌 者 聊 胡 教 敏 斌 斜 旌</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;旋 族 晤 晨 晚 曹 望 朗梗 梧 梓 梅 梨 梁 毫 球 海 浩 涉 涌 浴 烽 爽 崇 国 基 坚 执</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;堂 培 寅 寄 宿 寂 密 尉寻 将 专 崔 巢 常 带 康 强 张 彩 彤 雕 彬 从 悦 悟 戚 挺 英</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;婕 若 苔 苗 茂 术 袖 许责 赦 近 闭 雪 顷 顶 鹿 麦 麻 佩 闰 闵 雅 雁 集 云 项 须 顺</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;劳 喜 乔 善 单 喻 围 堪 尧 场 堤 报 堡 媒 媚 寒 寓 寻 尊 岚 巽 帽 几 复 惟 情 荀 茜 茶</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;扇 掘 卷 扫 舍 掌 迫 贰量 开 闲 间 添 焰 无 为 犁 猛 球 现 理 番 媛 登 授 捷 敢 散 敦</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;斑 敲 斯 晶 晴 晰 最 替期 朝 棋 棍 栈 森 植 荒 草 接 棠 栋 棒 棉 款 证 注 评 象 贵 贴</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;贸 越 超 迪 茹 旋 茫 众街 词 渊 涯 涵 混 深 淑 清 净 浅 淘 淡 焕 发 盛 砚 稀 稍 税 程</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;窗 竣 童 策 答 筑 筒 等笔 筏 栗 绞 给 吉 绚 絮 绝 统 络 翔 能 舜 黄 黑 备 传 割 胜</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\"><font size=\"3\" style=\"background-color: inherit;\">１２ 画 仅 债 杰 催 惠 伤 舒 倦 传 勤 势 募 嗣 园 圆 块 干 廊 渡 湃 渺 照 煎 媒 炼 爷 琴</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;琢 琵 琶 棱 督 睦 碇 禁禄 禽 稚 坚 绢 义 圣 廉 巢 微 爱 意 惮 荣 感 愚 想 愉 愈 斟 新</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;暑 会 极 楚 楠 枫 椰 榆殿 景 钞 钦 温 港 渠 湖 湘 测 汤 铁 佃 附 雌 雉 聘 肆 琛 唇 脱</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;台 获 莓 莫 蜀 衙 裟 装裕 里 解 咏 夸 詹 资 迹 跳 路 载 农 退 乃 郊 电 赓 雷 颂 顿 预 饮</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;驯 驰 鼎 鼓 雍 经 莆 莎莉 普 创 诏 雄 博 弼 智 贺 皓 凯<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	１３ 画 团 图 境 寿 梦 奖 察 实 对 伪 侨 像 佟 煌 仆 僚 崭 廓 彰 愿 慈 慎 态 搬 业 旗</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;畅 槐 枪 沟 歌 溢 温 溪源 滋 支 溶 熊 雨 犒 猿 狮 瑚 瑟 瑞 鼓 监 尽 廖 硕 祯 福 种 称 竭</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;端 个 算 精 紧 绰 绶 综绯 绵 维 纶 绫 置 翠 翡 靖 晖 台 与 舞 菊 董 华 果 菜 蜻 蜜 裙 裳 诫</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;诰 诲 诚 誓 说 诞 认 貌赈 宾 暄 铃 轻 赵 群 郎 酸 铅 阁 韶 领 饰 饱 仿 魁 魏 诗 试 询 诠 援</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;挥 扬 凰 鸣 鼻 齐 瑛 瑗榕 碌 诱 宁 玮 椿 曾 琳 群 杨 虞 当 盟 酩<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	１４ 画 仪 俭 僻 剧 剑 劈 刘 啸 豪 娇 宽 番 寮 履 帜 广 熙 弹 影 微 彻 慰 慷 醉 锐 锄 锋 阅 院</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;阵 宵 霆 霈 颐 落 蝶 冲褓 复 课 谈 调 谅 论 赐 质 赏 卖 趣 践 辈 轮 替 游 进 邮 部 醇 确 磁 磐</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;稼 稿 谷 稻 穷 箱 节 箭范 篇 糊 纬 缘 缄 绪 线 致 缔 编 练 暑 义 铺 馆 苇 叶 葛 葵 管 萱 著 董</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">慕 虑 掴 摧 摩 数 暂 暴暮 概 乐 槽 樟 枢 标 模 样 楼 欢 毅 演 汉 渐 涨 滞 漫 满 洋 熟 热 荧 瑶</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;玛 郎 几 皓 盘 驾 驻 魄鸦 华 燕 惯 慧 嘉 碧 樊 蒂 颖 块 发 葆 渔 漆 纲 尝 彰 志 赫 辅 造 逍 速</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;逞 途 透 通 逢 连 静 萤阴 银 铜 铭 齐<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	１５ 画 仅 万 冀 剑 进 器 喷 坛 壁 奋 道 岭 憬 憧 抚 怜 战 撮 撤 撰 幢 播 扑 整 德 晕 厉 机 陆 陵</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;鞘 头 余 默 龙 桦 横 桥橇 树 樽 橙 竖 洁 润 泄 贤 增 郭 赋 烨 烧 燃 炖 磷 燎 芦 穆 窥 筛 筑 糖</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;县 罢 翰 举 苍 蒸 席 辉震 墨 卫 衡 亲 谓 谒 诚 谏 谚 诸 豫 蹄 辑 办 运 远 遇 遂 道 达 都 醒 钢</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;锦 铮 锡 钱 总 橡 震 敬慧 磊 庆<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	１６ 画 儒 优 赏 励 壕 壑 岳 应 忆 撼 擒 擎 检 操 擅 择 擂 敛 檄 檀 褒 讲 谦 谢 豁 趋 融 远 乡 键</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;针 钟 锻 阶 队 阳 隆 霜鞠 韩 馆 骏 鲜 黛 点 齐 鸿 荫 襁 激 浓 营 灿 烛 燧 微 响 独 瞰 瞬 禅 簇</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;篷 纵 繁 缝 声 聪 聊 临艰 参 蔗 谅 蔬 篷 莲 赛 璜 燃 兴 学 遥 晓 霖 澄 潮 潜 潭 蓉 蓄 茜 颖 璇</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;蓓 陶 陈 谘 璋 逸 霓 谋<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	１７ 画 戴 搁 拟 擦 断 曜 曛 曙 归 濠 阔 湿 济 涛 爵 获 狞 猎 环 瞻 礼 馈 箫 绣 织 缮 翻 异 职 旧</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;荫 蕊 蕃 蝉 声 讴 谨 丰转 遭 适 鄙 医 锁 镇 锤 镰 聂 鸡 乡 离 雏 额 频 骑 鹃 灿 蕙 鞭 碧 霞 蒲<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	１８ 画 劝 宝 庐 扩 攀 旷 莹 泻 溅 瀑 滨 镜 关 雾 韵 愿 类 鲸 鹊 鹏 麓 兽 猎 祷 稳 获 薄 绳 薪</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;蔷 薇 襟 识 证 赞 赠 辞郑 鞠 丰 题 简<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	１９ 画 还 释 钟 阐 露 飘 馨 璃 龄 宝 迈 怀 悬 胧 沥 献 琼 砾 籍 筹 篮 继 办 罗 麒 藏 萨 籍 薯 觉</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp; z触 译 议 警 赢 面 锈瀚 瀛 烁 蕾 选 辽 遵 迟 臆 臂 膺 荡</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">&nbsp;</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Tahoma, \'Microsoft Yahei\', Simsun;\">２０ 画 顾 翻 饶 驱 莺 鹤 鸡 傈 属 巍 续 缠 腊 护 誉 贴 轰 辩 随 隐 霸 竞 耀 宝<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	２１ 画 艺 俨 巅 摄 权 欢 灌 叠 穰 笼 听 澡 苏 芦 览 赞 读 边 鉴 乡 餐 须 蔺 懿 樱 铁<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	２２ 岩 恋 织 藓 兰 变 矿 显 驿 验 髓 体 乐 麟 龚<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	２３ 画 矗 罐 艳 禳 酿 炉 陇 谒 灵 鹰 鑫<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	２４ 画 听 篱 蛮 观 才&nbsp;<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	２５ 画 湾 瞩 赞 逻 爵 厌<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	２６ 画 锣 銮 缆<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	２７ 画 艳 欢 鹦<br style=\"background-color: inherit;\" />\r\n	<br style=\"background-color: inherit;\" />\r\n	２８ 画 麓</p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('569', '<p><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Verdana, Arial, Tahoma;\">梦琪、忆柳、之桃、慕青、问兰、尔岚、元香、初夏、沛菡、傲珊、曼文、乐菱、痴珊、恨玉、惜文、香寒、新柔、语蓉、海安、夜蓉、涵柏、水桃、醉蓝、春儿、语琴、从彤、傲晴、语兰、又菱、碧彤、元霜、怜梦、紫寒、妙彤、曼易、南莲、紫翠、雨寒、易烟、如萱、若南、寻真、晓亦、向珊、慕灵、以蕊、寻雁、映易、雪柳、孤岚、笑霜、海云、凝天、沛珊、寒云、冰旋、宛儿、绿真、盼儿、晓霜、碧凡、夏菡、曼香、若烟、半梦、雅绿、冰蓝、灵槐、平安、书翠、翠风、香巧、代云、梦曼、幼翠、友巧、听寒、梦柏、醉易、访旋、亦玉、凌萱、访卉、怀亦、笑蓝、春翠、靖柏、夜蕾、冰夏、梦松、书雪、乐枫、念薇、靖雁、寻春、恨山、从寒、忆香、觅波、静曼、凡旋、以亦、念露、芷蕾、千兰、新波、代真、新蕾、雁玉、冷卉、紫山、千琴、恨天、傲芙、盼山、怀蝶、冰兰、山柏、翠萱、恨松、问旋、从南、白易、问筠、如霜、半芹、丹珍、冰彤、亦寒、寒雁、怜云、寻文、乐丹、翠柔、谷山、之瑶、冰露、尔珍、谷雪、乐萱、涵菡、海莲、傲蕾、青槐、冬儿、易梦、惜雪、宛海、之柔、夏青、亦瑶、妙菡、春竹、痴梦、紫蓝、晓巧、幻柏、元风、冰枫、访蕊、南春、芷蕊、凡蕾、凡柔、安蕾、天荷、含玉、书兰、雅琴、书瑶、春雁、从安、夏槐、念芹、怀萍、代曼、幻珊、谷丝、秋翠、白晴、海露、代荷、含玉、书蕾、听白、访琴、灵雁、秋春、雪青、乐瑶、含烟、涵双、平蝶、雅蕊、傲之、灵薇、绿春、含蕾、从梦、从蓉、初丹。听兰、听蓉、语芙、夏彤、凌瑶、忆翠、幻灵、怜菡、紫南、依珊、妙竹、访烟、怜蕾、映寒、友绿、冰萍、惜霜、凌香、芷蕾、雁卉、迎梦、元柏、代萱、紫真、千青、凌寒、紫安、寒安、怀蕊、秋荷、涵雁、以山、凡梅、盼曼、翠彤、谷冬、新巧、冷安、千萍、冰烟、雅阳、友绿、南松、诗云、飞风、寄灵、书芹、幼蓉、以蓝、笑寒、忆寒、秋烟、芷巧、水香、映之、醉波、幻莲、夜山、芷卉、向彤、小玉、幼南、凡梦、尔曼、念波、迎松、青寒、笑天、涵蕾、碧菡、映秋、盼烟、忆山、以寒、寒香、小凡、代亦、梦露、映波、友蕊、寄凡、怜蕾、雁枫、水绿、曼荷、笑珊、寒珊、谷南、慕儿、夏岚、友儿、小萱、紫青、妙菱、冬寒、曼柔、语蝶、青筠、夜安、觅海、问安、晓槐、雅山、访云、翠容、寒凡、晓绿、以菱、冬云、含玉、访枫、含卉、夜白、冷安、灵竹、醉薇、元珊、幻波、盼夏、元瑶、迎曼、水云、访琴、谷波、乐之、笑白、之山、妙海、紫霜、平夏、凌旋、孤丝、怜寒、向萍、凡松、青丝、翠安、如天、凌雪、绮菱、代云、南莲、寻南、春文、香薇、冬灵、凌珍、采绿、天春、沛文、紫槐、幻柏、采文、春梅、雪旋、盼海、映梦、安雁、映容、凝阳、访风、天亦、平绿、盼香、觅风、小霜、雪萍、半雪、山柳、谷雪、靖易、白薇、梦菡、飞绿、如波、又晴、友易、香菱、冬亦、问雁、妙春、海冬、半安、平春、幼柏、秋灵、凝芙、念烟、白山、从灵、尔芙、迎蓉、念寒、翠绿、翠芙、靖儿、妙柏、千凝、小珍、天巧。妙旋、雪枫、夏菡、元绿、痴灵、绮琴、雨双、听枫、觅荷、凡之、晓凡、雅彤、香薇、孤风、从安、绮彤、之玉、雨珍、幻丝、代梅、香波、青亦、元菱、海瑶、飞槐、听露、梦岚、幻竹、新冬、盼翠、谷云、忆霜、水瑶、慕晴、秋双、雨真、觅珍、丹雪、从阳、元枫、痴香、思天、如松、妙晴、谷秋、妙松、晓夏、香柏、巧绿、宛筠、碧琴、盼兰、小夏、安容、青曼、千儿、香春、寻双、涵瑶、冷梅、秋柔、思菱、醉波、醉柳、以寒、迎夏、向雪、香莲、以丹、依凝、如柏、雁菱、凝竹、宛白、初柔、南蕾、书萱、梦槐、香芹、南琴、绿海、沛儿、晓瑶、听春、凝蝶、紫雪、念双、念真、曼寒、凡霜、飞雪、雪兰、雅霜、从蓉、冷雪、靖巧、翠丝、觅翠、凡白、乐蓉、迎波、丹烟、梦旋、书双、念桃、夜天、海桃、青香、恨风、安筠、觅柔、初南、秋蝶、千易、安露、诗蕊、山雁、友菱、香露、晓兰、白卉、语山、冷珍、秋翠、夏柳、如之、忆南、书易、翠桃、寄瑶、如曼、问柳、香梅、幻桃、又菡、春绿、醉蝶、亦绿、诗珊、听芹、新之、易巧、念云、晓灵、静枫、夏蓉、如南、幼丝、秋白、冰安、秋白、南风、醉山、初彤、凝海、紫文、凌晴、香卉、雅琴、傲安、傲之、初蝶、寻桃、代芹、诗霜、春柏、绿夏、碧灵、诗柳、夏柳、采白、慕梅、乐安、冬菱、紫安、宛凝、雨雪、易真、安荷、静竹、代柔、丹秋、绮梅、依白、凝荷、幼珊、忆彤、凌青、之桃、芷荷、听荷、代玉、念珍、梦菲、夜春、千秋、白秋、谷菱、飞松、初瑶、惜灵、恨瑶、梦易、新瑶、曼梅、碧曼、友瑶、雨兰、夜柳、香蝶、盼巧、芷珍、香卉、含芙、夜云、依萱、凝雁、以莲、易容、元柳、安南、幼晴、尔琴、飞阳、白凡、沛萍、雪瑶、向卉、采文、乐珍、寒荷、觅双、白桃、安卉、迎曼、盼雁、乐松、涵山、恨寒、问枫、以柳、含海、秋春、翠曼、忆梅、涵柳、梦香、海蓝、晓曼、代珊、春冬、恨荷、忆丹、静芙、绮兰、梦安、紫丝、千雁、凝珍、香萱、梦容、冷雁、飞柏、天真、翠琴、寄真、秋荷、代珊、初雪、雅柏、怜容、如风、南露、紫易、冰凡、海雪、语蓉、碧玉、翠岚、语风、盼丹、痴旋、凝梦、从雪、白枫、傲云、白梅、念露、慕凝、雅柔、盼柳、半青、从霜、怀柔、怜晴、夜蓉、代双、以南、若菱、芷文、寄春、南晴、恨之、梦寒、初翠、灵波、巧春、问夏、凌春、惜海、亦旋、沛芹、幼萱、白凝、初露、迎海、绮玉、凌香、寻芹、秋柳、尔白、映真、含雁、寒松、友珊、寻雪、忆柏、秋柏、巧风、恨蝶、青烟、问蕊、灵阳、春枫、又儿、雪巧、丹萱、凡双、孤萍、紫菱、寻凝、傲柏、傲儿、友容、灵枫、尔丝、曼凝、若蕊、问丝、思枫、水卉、问梅、念寒、诗双、翠霜、夜香、寒蕾、凡阳、冷玉、平彤、语薇、幻珊、紫夏、凌波、芷蝶、丹南、之双、凡波、思雁、白莲、从菡、如容、采柳、沛岚、惜儿、夜玉、水儿、半凡、语海、听莲、幻枫、念柏、冰珍、思山、凝蕊、天玉、问香、思萱、向梦、笑南、夏旋、之槐、元灵、以彤、采萱、巧曼、绿兰、平蓝、问萍、绿蓉、靖柏。迎蕾、碧曼、思卉、白柏、妙菡、怜阳、雨柏、雁菡、梦之、又莲、乐荷、寒天、凝琴、书南、映天、白梦、初瑶、恨竹、平露、含巧、慕蕊、半莲、醉卉、天菱、青雪、雅旋、巧荷、飞丹、恨云、若灵&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">、</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Verdana, Arial, Tahoma;\">问萍、青蕾、雁云、芷枫、千旋、向梅、含蓝、怀丝、梦文、幼芙、晓云、雨旋、秋安、雁风、碧槐、从海、语雪、幼凡、秋卉、曼蕾、问蕾、访兰、寄莲、紫绿、新雁、恨容、水柳、南云、曼阳、幼蓝、忆巧、灵荷、怜兰、听曼、碧双、忆雁、夜松、映莲、听曼、秋易、绿莲、宛秋、雁安、问旋、以蓝、若亦、幻丝、山凡、南云、寄蕊、绿春、思海、寄天、友秋、紫玉、从筠、雪海、白筠、灵芙、安莲、惜梅、雪蕾、寄容、秋波、冷云、秋儿、怀菱、亦柏、易槐、怀卉、紫桃、向蕊、易青、千蕊、怜露、灵旋、怀梅、天柏、半白、碧安、秋枫、傲丝、春柔、冰岚、雅翠、易白、夜灵、静柔、醉绿、乐蕊、寄蓝、乐彤、迎琴、之亦、雨寒、谷山、凝安、曼萍、碧露、书南、山薇、念珊、芷雁、尔蕾、绮雪、傲萱、新琴、绿蝶、慕旋、怀易、傲云、晓梅、诗菱、灵珊、幻香、若云、如霜、晓晴、灵山、恨桃、梦凝、幻彤、觅波、慕玉、念山、乐桃、语寒、怀海、孤蝶、灵凝、慕蓝、紫青、千兰、孤柔、语曼、问海、寄筠、安露、听晴、冷寒、之翠、碧灵、凡丝、诗波、友芙、寄莲、之蕊、海琴、宛筠、半山、依槐、觅曼、碧菱、半文、访儿、芷珍、绿春、春蝶、怜槐、映露、雨卉、灵亦、惜莲、念菡、南凡、曼桃、笑灵、惜安、凌筠、翠菡、寒雁、以山、秋彤、巧兰、山雪、寒绿、忆易、依萱、如菡、含萱、惜梦、绮莲、翠易、冷筠、乐槐、傲青、幼灵、春柔、恨易、青文、初竹、从旋、沛山、映凝、静柳、雪云、醉蕊、巧荷、思蓝、翠秋&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">、</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Verdana, Arial, Tahoma;\">初双、雪旋、从霜、静萍、之彤、晓筠、含云、思兰、梦之、醉芙、若曼、寻槐、夜梅、访安、以绿、新柏、诗珊、灵青、幻菱、谷双、梦烟、凡烟、寻绿、香之、盼蕊、香筠、怀萱、半蓉、翠安、忆卉、念柏、念之、宛彤、如竹、天雪、念旋、笑萍、海风、小琴、乐海、易南、碧蕊、雁凝、雁风、依霜、天蝶、语凝、之卉、易云、若菡、幼兰、巧曼、以柳、小天、采雁、易莲、笑南、芷雁、觅霜、海柏、凝雪、诗晴、以梅、绮荷、乐山、又梦、听蓝、又彤、向竹、安琴、秋露、如波、尔槐、小易、静云、梦雪、幼凝、慕莲、如薇、静秋、幼柏、谷易、安芙、觅琴、冰槐、诗青、碧秋、从琴、从梦、寻风、凡薇、夜云、幼芙、以彤、怀云、幻柳、芷秋、以菱、靖柳、紫松、凡霜、灵云、采芙、亦露、香风、觅蓉、雨槐、又雪、碧蕾、香松、以亦、芷柔、千曼、友山、惜晴、幼文、寒波、友岚、乐槐、盼蝶、思山、以天、念梦、白桃、映翠、雁柳、翠灵、以竹、听雁、梦丝、冷烟、山露、安易、静霜、天珊、念蓝、书容、半晴、笑薇、孤萱、寄梦、秋蕊、从蝶、晓曼、半槐、绮易、访岚、含丝、慕安、怀雁、傲露、天岚、安寒、寻雪、幻旋、雁彤、天玉、亦珊、迎荷、慕柏、书柳、春海、初柏、绮翠、凝珍、海芙、尔香、问旋、紫之、灵翠、芷波、曼梦、向蕊、笑琴、映丝、妙筠、紫彤、妙曼、以阳、紫筠、易玉、梦蓝、谷露、曼春、寻枫、寻山、慕槐、凝绿、凝梅、醉文、听雪、以珊、友柳、孤珊、山芙、向凡、如巧、从彤、南翠、天凝&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">、</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">芳林 浩岚 静娴 岚霏 岚翠 岚彩 梦凡 梦菲 梦菡 梦露 梦琪 梦秋 梦竹 夏岚 馨荣 雅娴 云梦 云岚 晴岚 景山 乐山 林菁 林芳 林泽 林岚 林怡 林芿 碧琳 璆琳&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">、若云、寒烟、听筠、采梦、凝莲、元彤、觅山、痴瑶、代桃、冷之、盼秋、秋寒、慕蕊、巧夏、海亦、初晴、巧蕊、听安、芷雪、以松、梦槐、寒梅、香岚、寄柔、映冬、孤容、晓蕾、安萱、听枫、夜绿、雪莲、从丹、碧蓉、绮琴、雨文、幼荷、青柏、痴凝、初蓝、忆安、盼晴、寻冬、雪珊、梦寒、迎南、巧香、采南、如彤、春竹、采枫、若雁、翠阳、沛容、幻翠、山兰、芷波、雪瑶、代巧、寄云、慕卉、冷松、涵梅、书白、乐天、雁卉、宛秋、傲旋、新之、凡儿、夏真、静枫、痴柏、恨蕊、乐双、白玉、问玉、寄松、丹蝶、元瑶、冰蝶、访曼、代灵、芷烟、白易、尔阳、怜烟、平卉、丹寒、访梦、绿凝、冰菱、语蕊、痴梅、思烟、忆枫、映菱、访儿、凌兰、曼岚、若枫、傲薇、凡灵、乐蕊、秋灵、谷槐、觅云、水凡、灵秋、代卉、笑天、白夏、又青、冬梅、从珊、又香、雪容、以彤、冷萱、夜卉、念雁、尔阳、水荷、尔真、孤阳、之卉、依薇、妙双、醉巧、痴海、惜筠、从筠、碧白、曼珍、觅晴、寄蓉、慕雁、水丹、幼霜、凝绿、又松、丹山、元旋、怜云、觅丹、向槐、水冬、天青、语丝、怀芹、曼彤、雪绿、从冬、凌春、问风、凌寒、代蓝、幼白、山雁、若薇、芷蓝、寄蓝、谷之、海凡、新柔、靖之。涵桃、怀雁、怀桃、含云、雨凝、幻玉、寄蕾、怜双、诗丹、 凝阳、访风、天亦、平绿、盼香、觅风、小霜、雪萍、半雪、山柳、谷雪、靖易、白薇、梦菡、飞绿、如波、又晴、友易、香菱、冬亦、问雁、妙春、海冬、半安、平春、幼柏、秋灵、凝芙、念烟、白山、从灵、尔芙、迎蓉、念寒、翠绿、翠芙、靖儿、妙柏、千凝、小珍、天巧</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">、</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">妙旋、雪枫、夏菡、元绿、痴灵、绮琴、雨双、听枫、觅荷、凡之、晓凡、雅彤、香薇、孤风、从安、绮彤、之玉、雨珍、幻丝、代梅、香波、青亦、元菱、海瑶、飞槐、听露、梦岚、幻竹、新冬、盼翠、谷云、忆霜、水瑶、慕晴、秋双、雨真、觅珍、丹雪、从阳、元枫、痴香、思天、如松、妙晴、谷秋、妙松、晓夏、香柏、巧绿、宛筠、碧琴、盼兰、小夏、安容、青曼、千儿、香春、寻双、涵瑶、冷梅、秋柔、思菱、醉波、醉柳、以寒、迎夏、向雪、香莲、以丹、依凝、如柏、雁菱、凝竹、宛白、初柔、南蕾、书萱、梦槐、香芹、南琴、绿海、沛儿、晓瑶、听春、凝蝶、紫雪、念双、念真、曼寒、凡霜、飞雪、雪兰、雅霜、从蓉、冷雪、靖巧、翠丝、觅翠、凡白、乐蓉、迎波、丹烟、梦旋、书双、念桃、夜天、海桃、青香、恨风、安筠、觅柔、初南、秋蝶、千易、安露、诗蕊、山雁、友菱、香露、晓兰、白卉、语山、冷珍、秋翠、夏柳、如之、忆南、 书易、翠桃、寄瑶、如曼、问柳、香梅、幻桃、又菡、春绿、醉蝶、亦绿、诗珊、听芹、新之、易巧、念云、晓灵、静枫、夏蓉、如南、幼丝、秋白、冰安、秋白、南风、醉山、初彤、凝海、紫文、凌晴、香卉、雅琴、傲安、傲之、初蝶、寻桃、代芹、诗霜、春柏、绿夏、碧灵、诗柳、夏柳、采白、慕梅、乐安、冬菱、紫安、宛凝、雨雪、易真、安荷、静竹、代柔、丹秋、绮梅、依白、凝荷、幼珊、忆彤、凌青、之桃、芷荷、听荷、代玉、念珍、梦菲、夜春、千秋、白秋、谷菱、飞松、初瑶、惜灵、恨瑶、梦易、新瑶、曼梅、碧曼、友瑶、雨兰、夜柳、香蝶、盼巧、芷珍、香卉、含芙、夜云、依萱、凝雁、以莲、易容、元柳、安南、幼晴、尔琴、飞阳、白凡、沛萍、雪瑶、向卉、采文、乐珍、寒荷、觅双、白桃、安卉、迎曼、盼雁、乐松、涵山、恨寒、问枫、以柳、含海、秋春、翠曼、忆梅、涵柳、梦香、海蓝、晓曼、代</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">珊、春冬、恨荷、忆丹、静芙、绮兰、梦安、紫丝、千雁、凝珍、香萱、梦容、冷雁、飞柏、天真、翠琴、寄真、秋荷、代珊、初雪、雅柏、怜容、如风、南露、紫易、冰凡、海雪、语蓉、碧玉、翠岚、语风、盼丹、痴旋、凝梦、从雪、白枫、傲云、白梅、念露、慕凝、雅柔、盼柳、半青、从霜、怀柔、怜晴、 夜蓉、代双、以南、若菱、芷文、寄春、南晴、恨之、梦寒、初翠、灵波、巧春、问夏、凌春、惜海、亦旋、沛芹、幼萱、白凝、初露、迎海、绮玉、凌香、寻芹、秋柳、尔白、映真、含雁、寒松、友珊、寻雪、忆柏、秋柏、巧风、恨蝶、青烟、问蕊、灵阳、春枫、又儿、雪巧、丹萱、凡双、孤萍、紫菱、寻凝、傲柏、傲儿、友容、灵枫、尔丝、曼凝、若蕊、问丝、思枫、水卉、问梅、念寒、诗双、翠霜、夜香、寒蕾、凡阳、冷玉、平彤、语薇、幻珊、紫夏、凌波、芷蝶、丹南、之双、凡波、思雁、白莲、从菡、如容、采柳、沛岚、惜儿、夜玉、水儿、半凡、语海、听莲、幻枫、念柏、冰珍、思山、凝蕊、天玉、问香、思萱、向梦、笑南、夏旋、之槐、元灵、以彤、采萱、巧曼、绿兰、平蓝、问萍、绿蓉、靖柏。迎蕾、碧曼、思卉、白柏、妙菡、怜阳、雨柏、雁菡、梦之、又莲、乐荷、寒天、凝琴、书南、映天、白梦、初瑶、恨竹、平露、含巧、慕蕊、半莲、醉卉、天菱、青雪、雅旋、巧荷、飞丹、恨云、若灵、尔云、幻天、诗兰、青梦、海菡、灵槐、忆秋、寒凝、凝芙、绮山、静白、尔蓉、尔冬、映萱、白筠、冰双、访彤、绿柏、夏云、笑翠、晓灵、含双、盼波、以云、怜翠、雁风、之卉、平松、问儿、绿柳、如蓉、曼容、 天晴、丹琴、惜天、寻琴、痴春、依瑶、涵易、忆灵、从波、依柔、问兰、山晴、怜珊、之云、飞双、傲白、沛春、雨南、梦之、笑阳、代容、友琴、雁梅、友桃、从露、语柔、傲玉、觅夏、晓蓝、新晴、雨莲、凝旋、绿旋、幻香、觅双、冷亦、忆雪、友卉、幻翠、靖柔、寻菱、丹翠、安阳、雅寒、惜筠、尔安、雁易、飞瑶、夏兰、沛蓝、静丹、山芙、笑晴、新烟、笑旋、雁兰、凌翠、秋莲、书桃、傲松、语儿、映菡、初曼、听云、孤松、初夏、雅香、语雪、初珍、白安、冰薇、诗槐、冷玉、冰巧、之槐、香柳、问春、夏寒、半香、诗筠、新梅、白曼、安波、从阳、含桃、曼卉、笑萍、碧巧、晓露、寻菡、沛白、平灵、水彤、安彤、涵易、乐巧、依风、紫南、亦丝、易蓉、紫萍、惜萱、诗蕾、寻绿、诗双、寻云、孤丹、谷蓝、惜香、谷枫、山灵、幻丝、友梅、从云、雁丝、盼旋、幼旋、尔蓝、沛山、代丝、痴梅、觅松、冰香、依玉、冰之、妙梦、以冬、碧春、曼青、冷菱、雪曼、安白、香桃、安春、千亦、凌蝶、又夏、南烟。靖易、沛凝、翠梅、书文、雪卉、乐儿、傲丝、安青、初蝶、寄灵、惜寒、雨竹、冬莲、绮南、翠柏、平凡、亦玉、孤兰、秋珊、新筠、半芹、夏瑶、念文、晓丝、涵蕾、雁凡、谷兰、灵凡、凝云、曼云、 丹彤、南霜、夜梦、从筠、雁芙、语蝶、依波、晓旋、念之、盼芙、曼安、采珊、盼夏、初柳、迎天、曼安、南珍、妙芙、语柳、含莲、晓筠、夏山、尔容、采春、念梦、傲南、问薇、雨灵、凝安、冰海、初珍、宛菡、冬卉、盼晴、冷荷、寄翠、 幻梅、如凡、语梦、易梦、千柔、向露、梦玉、傲霜、依霜、灵松、诗桃、书蝶、恨真、冰蝶、山槐、以晴、友易、梦桃、香菱、孤云、水蓉、雅容、飞烟、雁荷、代芙、醉易、夏烟、山梅、若南、恨桃、依秋、依波、香巧、紫萱、涵易、忆之、幻巧、水风、安寒、白亦、惜玉、碧春、怜雪、听南、念蕾、梦竹、千</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">凡、寄琴、采波、元冬、思菱、平卉、笑柳、雪卉、南蓉、谷梦、巧兰、绿蝶、飞荷、平安、孤晴、芷荷、曼冬、寻巧、寄波、尔槐、以旋、绿蕊、初夏、依丝、怜南、千山、雨安、水风、寄柔、念巧、幼枫、凡桃、新儿、春翠、夏波、雨琴、静槐、元槐、映阳、飞薇、小凝、映寒、傲菡、谷蕊、笑槐、飞兰、笑卉、迎荷、元冬、书竹、半烟、绮波、小之、觅露、夜雪、春柔、寒梦、尔风、白梅、雨旋、芷珊、山彤、 尔柳、沛柔、灵萱、沛凝、白容、乐蓉、映安、依云、映冬、凡雁、梦秋、醉柳、梦凡、秋巧、若云、元容、怀蕾、灵寒、天薇、白风、访波、亦凝、易绿、夜南</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">、</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">曼凡、亦巧、青易、冰真、白萱、友安、诗翠、雪珍、海之、小蕊、又琴、香彤、语梦、惜蕊、迎彤、沛白、雁山、易蓉、雪晴、诗珊、春冬、又绿、冰绿、半梅、笑容、沛凝、念瑶、天真、含巧、如冬、向真、从蓉、春柔、亦云、向雁、尔蝶、冬易、丹亦、夏山、醉香、盼夏、孤菱、安莲、问凝、冬萱、晓山、雁蓉、梦蕊、山菡、南莲、飞双、凝丝、思萱、怀梦、雨梅、冷霜、向松、迎丝、迎梅、听双、山蝶、夜梅、醉冬、巧云、雨筠、平文、青文、半蕾、幼菱、寻梅、含之、香之、含蕊、亦玉、靖荷、碧萱、寒云、向南、书雁、怀薇、思菱、忆文、翠巧、怀山、若山、向秋、凡白、绮烟、从蕾、天曼、又亦、依琴、曼彤、沛槐、又槐、元绿、安珊、夏之、易槐、宛亦、白翠、丹云、问寒、易文、傲易、青旋、思真、妙之、半双、若翠、初兰、怀曼、惜萍、初之、宛丝、寄南、小萍、幻儿、千风、天蓉、雅青、寄文、代天、春海、惜珊、向薇、冬灵、惜芹、凌青、谷芹、香巧、雁桃、映雁、书兰、盼香、向山、寄风、访烟、绮晴、傲柔、寄容、以珊、紫雪、芷容、书琴、寻桃、涵阳、怀寒、易云、采蓝、代秋、惜梦、尔烟、谷槐、怀莲、涵菱、水蓝、访冬、半兰、又柔、冬卉、安双、冰岚、香薇、语芹、静珊、幻露、访天、静柏、凌丝、小翠、雁卉、访文、凌文、芷云、思柔、巧凡、慕山、依云、千柳、从凝、安梦、香旋、凡巧、映天、安柏、平萱、以筠、忆曼、新竹、绮露、觅儿、碧蓉、白竹、飞兰、曼雁、雁露、凝冬、含灵、初阳、海秋、香天、夏容。傲冬、谷翠、冰双、绿兰、盼易、思松、梦山、友灵、绿竹、灵安、凌柏、秋柔、又蓝、尔竹、香天、天蓝、青枫、问芙、语海、灵珊、凝丹、小蕾、迎夏、水之、飞珍、冰夏、亦竹、飞莲、海白、元蝶、春蕾、芷天、怀绿、尔容、元芹、若云、寒烟、听筠、采梦、凝莲、元彤、觅山、痴瑶、代桃、冷之、盼秋、秋寒、慕蕊、巧夏、海亦、初晴、巧蕊、听安、芷雪、以松、梦槐、寒梅、香岚、寄柔、映冬、孤容、晓蕾、安萱、听枫、夜绿、雪莲、从丹、碧蓉、绮琴、雨文、幼荷、青柏、痴凝、初蓝、忆安、盼晴、寻冬、雪珊、梦寒、迎南、巧香、采南、如彤、春竹、采枫、若雁、翠阳、沛容、幻翠、山兰、芷波、雪瑶、代巧、寄云、慕卉、冷松、涵梅、书白、乐天、雁卉、宛秋、傲旋、新之、凡儿、夏真、静枫、痴柏、恨蕊、乐双、白玉、问玉、寄松、丹蝶、元瑶、冰蝶、访曼、代灵、芷烟、白易、尔阳、怜烟、平卉、丹寒、访梦、绿凝、冰菱、语蕊、痴梅、思烟、忆枫、映菱、访儿、凌兰、 曼岚、若枫、傲薇、凡灵、乐蕊、秋灵、谷槐、觅云、水凡、灵秋、代卉、笑天、白夏、又青、冬梅、从珊、又香、雪容、以彤、冷萱、夜卉、念雁、尔阳、水荷、尔真、孤阳、之卉、依薇、妙双、醉巧、痴海、惜筠、从筠、碧白、曼珍、觅晴、寄蓉、慕雁、水丹、幼霜、凝绿、又松、丹山、元旋、怜云、觅丹、向槐、水冬、天青、语丝、怀芹、曼彤、雪绿、从冬、凌春、问风、凌寒、代蓝、幼白、山雁、若薇、芷蓝、寄蓝、谷之、海凡、新柔、靖之。涵桃、怀雁、怀桃、含云、雨凝、幻玉、寄蕾、怜双、诗丹、亦梅、向露、水竹、雨筠、书凝、紫云、冬雁、翠荷、小凝、念霜、水蕊、友槐、雅柏、青寒、夏兰、迎真、醉芙、以柳、半槐、尔晴</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">、</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">雪凝、如柏、雁菱、凝竹、宛白、初柔、 南蕾、书萱 、梦槐、香芹、南琴、绿海、沛儿、晓瑶、 听春、凝蝶、 紫雪、 念双、念真、曼寒、凡霜、飞雪、 雪兰、雅霜、从蓉 、冷雪、靖巧 、翠丝、 觅翠 、凡白、 乐蓉、迎波、丹烟、梦旋、书双、 念桃、夜天、海桃、 青香、 恨风、安筠、觅柔、初南、秋蝶、千易、安露、 诗蕊、山雁、 友菱、香露、晓兰 、白卉、语山、冷珍、 秋翠、夏柳、如之、忆南 、书易、翠桃、寄瑶、 如曼、 问柳、香梅、幻桃、又菡、春绿、醉蝶 、亦绿、诗珊、 听芹、 新之、 易巧、念&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 1.5; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: Simsun;\">云、晓灵、静枫、夏蓉、如南、 幼丝、秋白、冰安、 秋白、南风、 醉山、 初彤、凝海、 紫文、凌晴 、香卉、雅琴、傲安、傲之、初蝶、 寻桃、 代芹、诗霜、春柏、绿夏、碧灵、诗柳、夏柳、采白、 慕梅、 乐安、冬菱、 紫安、宛凝、雨雪、易真、安荷、 静竹、代柔、丹秋、绮梅、 依白、凝荷、 幼珊、 忆彤、 凌青、之桃、芷荷、听荷、代玉、念珍、梦菲、 夜春、 千秋、 白秋、谷菱、傲云、白梅、 念露、慕凝 、雅柔、盼柳、 半青、 从霜 、怀柔、怜晴 、夜蓉、代双、以南 、若菱、 芷文、 寄春、南晴、恨之、梦寒、初翠、灵波、 巧春 </span></p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('570', '<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">&nbsp; &nbsp; 嘉懿 煜城 懿轩 烨伟 苑博 伟泽 熠彤<span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">　鸿煊 博涛 烨霖 烨华 煜祺 智宸 正豪&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">昊然 明杰 立诚 立轩 立辉 峻熙 弘文</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　熠彤 鸿煊 烨霖 哲瀚 鑫鹏 致远 俊驰&nbsp;<span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">雨泽 烨磊 晟睿 天佑 文昊 修洁 黎昕&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">远航 旭尧 鸿涛 伟祺 荣轩 越泽 浩宇</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　瑾瑜 皓轩 擎苍 擎宇 志泽 睿渊 楷瑞&nbsp;<span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">子轩 弘文 哲瀚 雨泽 鑫磊 修杰 伟诚&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">建辉 晋鹏 天磊 绍辉 泽洋 明轩 健柏</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　鹏煊 昊强 伟宸 博超 君浩 子骞 明辉&nbsp;<span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">鹏涛 炎彬 鹤轩 越彬 风华 靖琪 明诚&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">高格 光华 国源 冠宇 晗昱 涵润 翰飞</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　翰海 昊乾 浩博 和安 弘博 宏恺 鸿朗&nbsp;<span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">华奥 华灿 嘉慕 坚秉 建明 金鑫 锦程&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">瑾瑜 晋鹏 经赋 景同 靖琪 君昊 俊明</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　季同 开济 凯安 康成 乐语 力勤 良哲&nbsp;<span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">理群 茂彦 敏博 明达 朋义 彭泽 鹏举&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">濮存 溥心 璞瑜 浦泽 奇邃 祺祥 荣轩</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　锐达 睿慈 绍祺 圣杰 晟睿 思源 斯年&nbsp;<span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">泰宁 天佑 同巍 奕伟 祺温 文虹 向笛&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">心远 欣德 新翰 兴言 星阑 修为 旭尧</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　炫明 学真 雪风 雅昶 阳曦 烨熠 英韶&nbsp;<span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">永贞 咏德 宇寰 雨泽 玉韵 越彬 蕴和&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">哲彦 振海 正志 子晋 自怡 德赫 君平</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">&nbsp; &nbsp; 浩云 远葸 清瑜 墨晗 龙飞 宗良 维顺 瀚辰 改珍 思敏 长春 红年 孟钰 桐瑞 星月 中源</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　行平 咏棣 作忠 宗佑 钟源 金山 泽中 习涛 宇矾 堂臻 一漪 一澍 永风 京明 彦哲 文嘉</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　书宁 一毅 书乐 昊洲 书林 立立 霏雨 焯勾 岩松 扬菲 卫国 垌菲 喜成 晶林 荔荔 文烨</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　建雄 金金 军生 致齐 书显 建新 金利 力千 轴毛 钊幸 珏珲 先涛 浩宇 小平 建基 琛琛</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　烯冰 璇冰 孟学 韦嵘 宗耀 轺介 惠卿 宗台 茜冰 凤军 佳钰 小明 又仁 锴锐 招新 召营</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　乘昊 永靖 小军 永静 汝君 思彤 汉元 依潼 依凡 欣瑜 逸樊 圣祥 楠楠 传方 欣尉 函珏</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　城瑞 异才 传舫 奕灿 依培 嘉欣 艳秋 传祥 传禄 志强 焕香 志嘉 传 依衡 传荣 映廷</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　东峰 传贵 逸矾 传福 海语 矾逸 文吉 知娴 再香 索娴 任杰 豫坤 留生 策驰 振中 林峰</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　林丰 梁宏 临峰 临锋 传澎 矾豫 晓东 临风 传龙 若然 传鑫 凌风 大为 力仁 允灏 丽明</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　利仁 宝涛 佳明 筱璇 思帅 政翰 宇博 文会 稼傲 佳烈 稼音 稼金 稼辛 稼竹 富豪 辰翔</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　凯岳 敬海 振宇 锦容 锡海 钧玮 庆敏 文龙 逢厅 祚玮 全民 兴碧 乙默 金元 书含 雪容</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　馥凤 璐菲 雨晗 馥毓 子 梦伊 家池 梦菲 梦如 洪娇 羽姗 校国 如姬 红延 记言 科业</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　蕊瑗 定峰 智勇 言卿 羽纯 康庆 志佳 如真 蕊菁 馥连 强强 羽真 雨洋 厚源 厚军 璧宁</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　品言 志楷 伟康 品声 宝影 志勇 容伊 本康 美君 明驿 一赫 绪新 慧峰 坤铎 思君</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　俊采 翔宇 飞菲 雪淇 广欢 泞鹪 庆昌 顺香 梦暄 惟 欣逸 晓坤 广应 其运 淇兴 镜桦</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　季恒 书帛 炀霏 龙斌 玉华 卉霖 玮宏 永明 宇浩 少春 续豪 雁君 誉玮 培杰 绢踏 稀绚</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　德友 英智 双庆 子辰 子芯 蒙蒙 玮檬 牧归 佳龙 靖心 炜航 玉平 江华 兴友 嘉锦</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　天哲 珈慧 茂溪 馨蔓 诵旭 丰源 微云 隆 为民 祥熙 忆轩 俊屹 营宝 姝妤 毓徽 苑涵</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　顺耀 泽伟 明荣 橙 佳乐 晓晴 齐天 希宗 泣涵 和峰 松南 峻凝 连超 衍煊 是羽 弘渝</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　驭轩 子含 訾劾 成秀 艳君 女雯 耀耀 羽茜 玉抒 浩瑞 琰苗 小轩 志波 煜景 格峰</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　思聪 昕瞳 奕杉 孟绅 正光 振武 恩仪 永峻 文京 逸然 国诚 之伦 毅百 龙淼 柘凤</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　云帆 方宁 明惟 庆详 万军 清泉 亦罗 胤历 谢君 嘉玮 丹妮 帅明 竹儿 紫薇 秋宇</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　楠 碛 宝林 世吉 永祺 奕心 培致 修为 伟珍 山东 国邑 春蕴 珂菲 广博 文姝 春刚 宏阳</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　芸仪 倾 佳骐 华宁 雨丹 学宝 继宁 鹏先 浚 震昊 欣澎 栎米 温欣 昭君 永光 宇洋 婉彤</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　佳萸 西西 唐青 红平 壁霰 若彤 一玮 一薄 添睿 海轩 嘉辉 嘉欣 健烨 周华 泰国 月康</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　宾盟 锡明 欣研 天印 琰沣 恒铭 天晴 钧涵 佳宇 梓言 志勇 家乐 珧冬 若木 启波 久宣</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　成宏 欣鑫 如钰 揖 冰月 天宇 一帆 钦泽 鑫嫒 又铭 恒伟 鹭洋 勇清 霈泽 珂佳 遥来</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　 &nbsp;裔圣 裔风 裔璇 裔瑛 政哲 伟华 伟哲 嗣爵 承爵&nbsp;<span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">炫琰 金鑫 柠浩 嘉熙 贝玺 子默 思远 浩轩 语堂 昕宇</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　家宇 宇豪 宇鞅 宇轩 智宸 绍衡 鸿儒 鹏威 君浩 昊东&nbsp;<span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">子骞 博文 鸿飞 尚卿 尚博</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, arial, sans-serif;\">　　昊天 昊阳 昊焜 昊祺 昊磊 保同 保赫 保臣 保治&nbsp;<span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">希诚 希武 伸义&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">巴莫 子赫 子龙&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">彦祾 祺祾 祾祯&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); line-height: 1.5;\">水哲 祾钊 祾钰 祾镇</span></p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('571', '<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_3:巾 久 口 廿 乞 彡 已干 工 弓 丌 及 孑</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_4:亢 孔 木 牛 亓 欠 犬 牙 元 月 匀卞 丐 公 勾 介 今 斤</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_5:卡 可 叩 卯 巧 丘 囚 去 外 未 五 本 尕 甘 功 古 瓜 宄 卉 加 甲 叫 句 巨仡 玉 札</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_6:件 交 臼 伉 考 朽 旭 匡 夼 企 犰 曲 戎 仰朳 朵 尬 各 共 乩 吉 伎 奸 幵 囝 吁 聿 朱 竹</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_7:呙 囯 旱 何 吼 肓 妓 忌 夹 见 角 疖 劫 妗 究 局姖 君 杓 材 岑 杈 床 村 杜 呃 伽 改 杆 杠 告 更 攻 估 谷 庋佧 扛 囥 壳 克 扣 困 伲 你 杞 扦 羌 劬 却 杉 我 吴 吾 扤 杌 匣 吓 杏 言 吟 杖</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_8:虬 屈券 枘 松 枉 卧 析 呷 欣 芎 厓 兖 杳 宜昂 枊 板 杯 杵 东 妸 扼 枋 斧 秆 杲 疙 供 咕 姑 孤 固 呱 乖 官 果 杭 忽 昏 肌 亟 佶 技 季 佳 肩 艽 佼届 卺 京 纠 赳 玖 疚 居 咀 具 卷 咔 咖 抗 肯 空 枕 枝 快 狂 林 枚 杪 艿 呢 杻 杷 枇 其 奇 歧 穹 竺 杼</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_9:柲 柄 柴 柢 芏 俄 枹 尜 肝 柑 竿 疳 肛 缸 纥 革 虼 哏 狗 枸 牯 故 冠 咣 皈 轨 癸 柜 哄 訇 虹 芨 咭 级急 纪 既 枷 叚 架 建 牮 姜 姣 皆 界 疥 蚧 矜 劲 扃 九 韭 拘 狙 拒 军 看 柯 科 咳 客 芝 哐 柃 柳 咯 芒怩 昵 拈 柈 芃 枰 祈 芑 契 恰 芊 俏 俅 酋 畎 芍 柿 柁 柝 芄 玩 侠 狎 柙 相 枵 彦 奕 弈 疫 羿 胤 柚 禺竽 芋 栅 柘 枳 柱 斫 柞</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_10:柩 桕 疽 桔 俱 倨 娟 倦 桊 隽 拷 栲 珂 疴 恪 倥 恐 芤 栩 祗 哭 库 框 括 栝 栳 栗 匿 臬 耙 芘 栖芪 耆 岂 起 气 虔 肷 芡 衾 芩 芹 祛 拳 缺 桑 芟 秫 栓 凇 笋 桃 桐 砼 桅 芴 桉 芭 笆 柏 栢 梆 苄 栟 屙 婀 苊 芳 芬 粉 芙 酐 绀 羔 高 哥 格 鬲 哿 根 耕 哽 肱 恭 蚣 躬 拱 贡 股 骨罟 挂 倌 桄 鬼 桂 衮 核 桁 讧 笏 花 桓 恢 唧 姬 屐 笄 笈 脊 记 珈 家 痂 恝 兼 豇 狡 讦 拮 桀 芥 衿 肼弪 径 奚 哮 校 芯 桠 芽 芫 唁 苡倚 痈 邕 娱 圄 峪 原 纭 芸 笊 芷 桎 株 桌</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_11:苛 氪 啃 寇 许 苦 眶 悝 盔 悃 捆 梱 婪 笠 啉 苓 茅 茆 茂 梅 苠 茉 苜 旎 偶 苤 笸 启 弃 乾 悄 茄 卿 顷筇 蚯 区 蛆 朐 娶 悛 圈 痊 苒 若 啬 苫 梢 苕 笙 倏 梳 术 笥 桫 梭 苔 茇 苞 苯 笨 苾 梐 彬 梣 茬 趁 笞 茌 崔 笪 笛 兜 轭 梵 苻 桴 符 苷 敢 舸 梗 珙 苟 笱 蛄 梏 牿 胍 规 匦国 悍 捍 偈 寄 笳 袈 戛 蛱 胛 徦 假 坚 枧 趼 健 皎 教 秸 婕 堇 近 婧 竟 救 苴 趄 苣 捐 眷 桷 捃 胩 康 梯 笤 梃 桶 偓 梧 悟 晤 狭 厢 枭偕 械 研 厣 眼 悒 挹 翊 茚 英 唷 圉 庾 苑 笮 苎 棁 茁 梓</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_12:蛟 绞 窖 喈街 杰 结 筋 荩 阱 景 痉 窘 啾 厩 掬 椐 莒 讵 距 犋 掘 珺 喀 开 凯 闶 钪 轲 棵 控 椋 植 筐 贶 傀 喟 蛞棱 荔 络 荦 荬 棉 茗 猊 棚 椑 期 欺 祁 棋 掐 掮 茜 嵌 强棒 笔 草 策 茶 枨 茺 楮 篅 荈 棰 茈 茨 答 等 第 棣 迭 栋 筏 棼 茯 尴 皋 胳 袼 给 茛 轱 觚 酤 诂 雇 棺贯 胱 晷 贵 棍 聒 椁 皓 闳 喉 荒 茴 嵇 极 戢 棘 殛 集 几 掎 悸 迦 袷 跏 间 犍 荐 绛 茭 椒 羟 乔 邱 球 诎 蛐 荃 筌 荏 茸 茹 阮 森 筛 耜覃 棠 茼 统 筒 椭 皖 稀 厦 筅 荇 悻 荀 雅 掩 雁 尧 傜 荑 椅 茵 硬 哟 驭 饫 寓 栈 棹 茱 椎 棕 最</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_13:经 茎 睛 胫敬 迥 揪 舅 琚 雎 榉 绢 筠 揩 慨 楷 戡 莰 稞 窠 嗑 筘 廉 楝 窟 夸 蒯 诓 揆 暌 琨 髡 廓 莨 楞 莉 莅 琳莽 莓 楣 娩 募 楠 逆 睨 筢 榀 莆 颀 琦 琪 祺 佥 愆 箝 呛嗄 荸 箅 筴 搽 猹 槎 茝 椿 榱 戥 荻 椴 莪 蛾 愕 枫 莩 该 陔 赅 戤 概 感 幹 筻 嗝 塥 跟 绠 诟 彀 痼 诖琯 诡 跪 嗬 荷 猴 逅 畸 嫉 楫 麂 荚 嫁 拣 笕 减 楗 毽 酱 郊 跤 脚 敫 揭 诘 睫 解 仅 禁 靳 樯 愀 琴 勤 倾 楸 诠 辁 裙 群 嗓 莎 筲 椹 筮竖 颂 荽 莛 荼 莞 莴 斡 珷 皙 暇 莶 苋 楔 歇 莘 楦 靴 筵 罨 杨 椰 业 义 肄 楹 莜 莸 莠 愚 榆 瘐 预 御楂 桢 孳 罪</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_14:菝 榜 菢 菶 萆 菜 菖 苌 尝 篪 椽 菙 萃 萏 菪 凳 摁 菲 榧 菔 嘎 盖 赶 纲 睾 膏 搞 槁 诰 郜 歌 搿 箇 郠构 菇 菰 箍 鼓 褂 管 逛 绲 帼 蜾 菡 赫 瘊 槐 萑 夥 箕 暨 跽 嘉 郏 瘕 笺 菅 搛 戬 僭 降 僬 侥 饺 酵 截竭 诫 骱 紧 廑 菁 腈 兢 僦 裾 菊 矩 皲 菌 郡 忾 犒 裉 箜 榛 筝 骷 酷 筷 魁 睽 匮 愧 莱 榔 菱 榴 杩 樠萌 墓 幕 萘 箄 裴 菩 桤 萋 嘁 萁 旗 綦 绮 葺 搴 歉 枪 敲 侨 诮 箧 轻 箐 逑 赇 巯 蜷 绻 榷 荣 榕 箬 瑟菽 槊 菘 算 榫 榻 萄 萜 菟 菀 伪 萎 菥 箫 榍 榭 菸 厌 酽 疑 瘗 蜴 萤 郢 萸 语 妪 箢 瑗 愿 菑 榨 寨 肇菹</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_15:葆 萹 箯 标 槽 箣 郴 樗 枞 稻 噔 蒂 腭 樊 葑 橄 稿 葛 赓 巩 穀 广 妫 瑰 郭 掴 荭 篌 糇 葫 槲 篁 蝗 叽缉 赍 稽 瘠 挤 稷 葭 价 驾 稼 俭 翦 贱 腱 箭 僵 桨 娇 胶 噍 颉 羯 槿 儆 獍 阄 樛 驹 踞 蒈 慷 靠 颏 瞌蝌 课 缂 抠 萱 箴 侉 侩 宽 款 诳 葵 醌 阃 楼 面 模 耦 葩 篇 葡 槭 葜 悭 椠 庆 穷 茕 萩 蝤 葚 枢 樘 葶葳 苇 蒍 妩 葸 瞎 贤 缃 葙 箱 蝎 样 仪 谊 毅 莹 媵 窳 葬 樟 荮 著 箸 醉</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_16:篘 莼 笃 饿 谔 鄂 阏 萼 遏 噩 蒽 篚 噶 篙 糕 缟 膈 骼 鸪 毂 掼 龟 辊 过 蒿嚆 横 黉 骺 鲎 桦 慌 隍 荤 机 畿 墼 蒺 剂 冀 髻 颊 缣 蒹 谏 踺 彊 耩 犟 挢 徼 缙 噤 颈 憬 橘 举蓓 荜 筚 蓖 篦 蔀 篰 苍 橙 踽 窭鄄 橛 麇 瞰 眍 篥 蓄 蓁 蒸 裤 哙 窥 愦 梦 蒲 朴 器 褰 黔 橇 桥 憔 樵 撬 鞘 亲 擒 檎 螓 檠 磬 遒 鼽 糗趋 鸲 磲 桡 蓉 蓐 穑 树 蒴 蒜 荪 蓑 蓊 樨 县 橡 筱 啸 谐 阎 谚 窑 缢 荫 萦 蓥 嬴 颖 阈 遇 圜 樾 筑 篆嘴 樽</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_17:蒡 蔽 檦 檗 蔡 柽 苁 葱 蔟 簇 档 瞪 懂 蔸 篼 擀 鸽 篝 购 媾 鸹 馆 簋 蝈 馘 癀 桧 豁 击 玑 激 哜 觊 艰鞯 捡 检 謇 讲 蒋 鲛 矫 阶 鲒 鞠 鞫 据 飓 糠 颗 髁 恳 莲 联 敛 蓼 蓿 蔻 挎 狯 亏 栏 檑 檩 蒌 篓 簏 蔓懋 甍 蔑 篾 茑 蓬 蹊 谦 瞧 擎 罄 蕖 阒 篸 蔌 簌 檀 蔚 檄 蓰 辖 罅 芗 魈 蔫 檐 营 狱 岳 箦 蔗 栉 赚桩</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_18:蕤 蕊 蔬 梼 檮 隗 魏 芜 黠 蕈 槟 檫 蒇 槌 箪 簦 簟 蕫 鹅 额 颚 蕃 搁 隔 鲠 遘 觏 鹄 瞽 归 鲧 簧 蟥 蕙 获 犄 蕺 虮 鲫 鲣 睑 裥 简 谫槛 糨 蕉 谨 觐 旧 屦 瞿 鹃 蕨 骒 蒉 篑 聩 拦 瞢 拟 腻 柠 骐 骑 荨 襁 鄡 荞 窍 翘 苘 躯 璩 觑 鬈 荛 绕颜 蝇 鹆 蜮 簪 蕞</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_19:薜 簸 橱 薋 蹬 椟 臌 关 犷 薅 薨 蕻 谎 荟 讥 蓟 缰 缴 轿 醮 襟 馑 鲸 鬏 绔 胯 脍 旷 鲲 扩 蕾 枥 栎 橹麓 难 鲵 攀 麒 髂 签 蔷 跷 缲 黢 醛 萨 薯 薇 蕹 萧 肖 撷 薤 蟹 薪 薛 赝 遗 蚁 薏 蓣 籀</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_20:藊 藏 榇 筹 篡 鹗 鳄 藁 鳇 攉 蠖 籍 继 舰 藉 警 竞 龃 遽 醵 觉 阚 悬 喾 跨 郐 纩 馈 蓝 篮 栊 栌 檬 藐篷 脐 蛴 荠 骞 琼 鳅 劝 薷 薹 牺 献 薰 严 邀 议 橼 黦 槠 橥 纂</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_21:藨 鹘 顾 鳏 颢 饥 鸡 歼 鹣 茧 赆 夔 藜 藕 鞒 驱 饶 薮 藤 嚣 药 艺 龈 莺 樱 蕴</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_22:蔼 龚 瓘 蘅 骄 惧 鱇 邝 籁 苈 蔺 茏 笼 芦 蘑 孽 苹 蕲 氍 权 苏 俨 瘿 龉 鬻</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_23:欑 蘩 蛊 鳜 藿 鹪 惊 鹫 蠲 蔹 兰 椤 蓦 蘖 蘧 癯 藓 鼹 验 驿 鹬 &nbsp; &nbsp; &nbsp; &nbsp;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_24:霭 簖 赣 羁 搅 蓠 篱 酿 衢 龋 魇 鹰 攥</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_25:观 鲚 髋 榄 萝 箩 蘸 缵</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_26: 蠼 躜</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_27:颧 谳</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">木_28:笾 戆 棂</div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('572', '<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_2:刁 丁 二 力 了</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_3:乇 幺 弋 彳 大 孓 之 女 勺 巳丈</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_4:仂 内 日 太 天 屯 午尺 丹 吊 仃 斗 火 井 支 爻 仉 止 中</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_5:丙 代 旦 叨 氐 叮 冬 叻 立 尥 令 另 奶 尼 奴 冉 他 它 田 仝 仗 召 只 左</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_6:老 耒 劣 六 甪 氖 囡 年 吃 弛 打 忉 氘 多 耳 旮 亘 光 尖 匠 她 决 旯乓 全 肉 同 氽 佤 妄 吆 宅 兆 旨 至 仲 自</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_7:卵 免 男 呐 佞 弄 努 求 忐 忑 町 廷 佟 犴 呈 辵 呔 甙 但 低 弟 佃 甸 玎 疔 盯 豆 囤 旰 灸 良 牢 李 利 吝 伶 吕 彤 吞 托 佗 妥 巫 妖 佁 佔 志 豸 住 灼 姊 足</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_8:哎 佰 长 炒 坼 侈 炊 佽 徂 耷 妲 沓 岱 宕 到 的 狄 底 玓 典 店 耵 定 咚 侗 抖 妒 咄 剁 佴 昉 炅 昊 戽 姐 咎 抉 炕 两 争 政 知 直 昆 剌 来 佬 肋 例 戾 冽 囹 呤 侣 仑 旻 奈 呶 妮 念 弩 疟 妾 炔 乳 侍 帑 弢 忝 佻 帖 投 罔 昕 炎 佯 易 找 制 帙 炙 忠 隹 卓</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_9:炳 抶 抽 怛 待 怠 殆 眈 抵 帝 酊 订 段 祋 盹 盾 哆 哚 赴 拐 曷 烀 咴 姞 柬 炯 玦 俊 怜 亮 拉 厘 俚 俐 咧 拎 律 哪 娜 柰 耐 南 怒 虐 炮 炱 泰 炭 畋 殄 亭 突 凃 拖 拓 歪 纨 肟 炫 紃 殃 徉 咬 映 昱 怨 灾 炸 招 昭 者 贞 祉 致 盅 重 纣 胄 炷 籽 秭 耔 奏</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_10:晒 晌 恕 朔 趿 肽 唐 倘 讨 套 特 疼 屉 倜 恬 甜 挑 条 庭 挺 徒 彖 庹 挖 挝 倭 乌 娭 夏 讯 迅 秧 烊 窈 舀 旃 展 站 珍 秩 舯 衷 冢 祝 倬 笫 恣 哧 耻 翀 娖 玳 耽 疸 紞 岛 倒 娣 玷 爹 瓞 冻 恫 蚪 趸 耿 烘 恍 疾 晋 珏 倔 烤 俩 凉 畜 烜 朕 肢 值 朗 烙 哩 娌 料 烈 玲 瓴 凌 留 旅 伦 倮 耄 拿 纳 肭 衲 孬 能 娘 恧 衄 哦 秦 恁 朊 芮 蚋 偌</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_11:捌 豝 胈 败 绊 邦 浜 胞 狈 被 偝 偪 逼 闭 狴 婢 庳 敝 贬 匾 徧 彪 婊 邠 斌 浡 舶 捕 涔 唇 讹 返 贩 访 啡 酚 唪 趺 麸 绂 绋 浮 匐 艴 妇 够 海 酣 浛 毫 浩 盒 痕 珩 唿 唬 扈 瓠 患 凰 悔 彗 晦 婚 货 浸 泾 涓 浚 虚 浪 流 麻 麦 脉 曼 袤 浼 眯 觅 密 冕 喵 苗 敏 眸 涅 徘 胖 脬 袍 匏 胚 旆 烹 啤 偏 殍 票 贫 婆 粕 浦 渠 涩 涉 涑 挲 涕 涂 晚 望 偎 浯 浠 习 涎 消 邪 挟 婞 讻 雪 涌 鱼 雩 浴 浙 浞</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_12:硫 虏 掠 抡 捺 喃 赧 捻 傩 晴 闰 婼 邰 毯 探 掏 啼 腆 掭 祧 迢 贴 婷 痛 饨 跎 酡 惋 惘 喔 窝 幄 寻 循 巽 焱 蛘 轺 轶 媛 哲 蛰 彘 智 痣 轴 粢掰 焙 采 场 焯 掣 程 塍 嗒 傣 贷 单 氮 悼 登 迪 觌 诋 邸 睇 掂 阽 惦 跌 喋 耋 痘 短 惇 敦 掇 迩 焚 钬 焦 接 嗟 晶 就 厥 吭 詈 晾 量 欻 诊 轸 证 焜 啦 喇 琅 稂 劳 犁 喱 理 傈 痢 捩 裂 趔 琉</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_13:暖 逄 稔 塔 痰 逃 绨 提 跳 蜓 艇 退 煺 蜕 脱 驮 陀 顽 脘 畹 煨 炜 蜗 熄 烟 琰 扬 旸 炀 徭 虞 煜 詹 盏 照 罩 蜇 郅 置 雉 追 惴 琢 赀 觜 趑 訾稗 煲 煏 煸 裎 嗤 媸 驰 传 搭 靼 迨 亶 当 砀 嗲 电 殿 揲 牒 鼎 督 煅 顿 躲 惰 跺 烦 觥 煳 焕 煌 晃 幌 诙 迹 煎 炼 煊 睐 啷 廊 酪 诔 傫 愣 蜊 里 赁 零 旒 偻 赂 辂 琭 禄 路 乱 煤 睦 乃 恼 农</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_14:熬 畅 尘 逞 瞅 绰 瘩 捣 嘀 嫡 递 腚 胨 郖 逗 端 对 裰 夺 尔 裹 伙 奖 尽 恺 奁 连 踉 僚 寥 廖 瘌 辣 罱 郎 嫪 嫘 酹 嘞 嫠 粼 绫 领 熘 绺 喽 陋 绿 纶 裸 雒 瑙 嫩 宁 喏 搦 炝 熔 煽 裳 台 态 叹 搪 耥 趟 慆 慝 滕 逖 惕 裼 舔 蜩 通 透 图 团 箨 蜿 绾 腕 诶 鞅 疡 摇 荧 毓 搌 绽 嫜 彰 胀 幛 赵 这 祯 种 逐 缀 缁</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_15:蝻 脑 闹 馁 辇 侬 驽 挪 噢 僻 热 熵 踏 骀 谈 郯 赕 羰 瑭 躺 铽 踢 缇 髫 抟 褪 驼 腽 辋 腰 瑶 熠 熨 暂 摘 獐 账 折 辄 赭 质 觯 肿 驻 缒 禚 辎皑 僾 熛 噌 层 彻 踟 齿 憏 憃 除 褚 踔 逴 辍 腠 褡 逮 儋 弹 德 敌 骶 缔 踮 调 蝶 董 陡 缎 饵 缓 践 瑾 进 噘 练 谅 辆 嘹 寮 阵 鸩 征 诤 赉 阆 唠 乐 黎 厉 撂 刘 瘤 搂 鲁 逯 戮 虑 轮 论 脶 骆 熳 鼐 腩</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_16:憝 吨 炖 遁 踱 燔 积 撅 獗 琏 撩 獠 燎 璇 臻 赖 褴 螂 捞 擂 缡 璃 罹 历 廪 陵 遛 龙 瘘 卢 陆 录 焖 挠 鲇 哝 诺 逎 燃 烧 燊 遂 鲐 昙 糖 螗 绦 撤 陈 撑 鸱 炽 俦 辏 达 殚 掸 惮 导 道 灯 谛 谍 蹀 都 赌 陶 蹄 醍 头 暾 鸵 橐 熹 晓 谑 焰 鸯 晔 燚 燠 璋 瘴 踵 猪 撰 赘 谘 髭</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_17:暧 餲 灿 龀 瞠 骋 丑 黛 担 瘅 挡 蹈 队 鸸 鲕 烩 绩 琎 爵 裢 殓 魉 疗 阑 痨 缧 儡 励 隶 临 瞵 磷 懔 隆 耧 蝼 缕 螺 麋 缪 黏 咛 騃 燧 遢 蹋 饧 膛 螳 醣 誊 嚏 瞳 疃 臀 襄 燮 谣 遥 繇 燥 择 辗 蟑 褶 鸷 膣 螽 烛 纵</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_18:痴 虫 戳 丛 戴 焘 鞮 癜 断 怼 丰 烬 粮 缭 职 醪 耢 釐 礼 鲤 膦 噜 辘 璐 谬 蛲 耨 懦 适 曙 抬 鹈 题 阗 餮 魍 曛 曜 烨 瞻 障 遮 谪 贽 掷 踬 转 骓 擢</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_19:齑 际 谲 蹶 帘 臁 蠊 脸 裣 辽 郑 羸 类 离 丽 呖 邻 遴 辚 鲮 馏 咙 撸 庐 氇 蠃 蟆 撵 脓 庞 曝 蹻 烁 谭 韬 鼗 玺 鄩 绎 赠 鄣 辙 骘 鲻薆 摆 爆 蹭 嘲 蛏 歠 骴 哒 裆 邓 鲷 鸫 胴 蹲</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_20:骝 胧 拢 炉 掳 罗 糯 飘 赡 獭 挞 宝 阐 郸 党 鲽 窦 嚼 矍 懒 黧 醴 疠 龄 腾 龆 鼍 曦 耀 赢 躅</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_21:缠 踌 跻 爝 腊 蜡 癞 斓 览 烂 累 俪 疬 珑 髅 骡 曩 鳎 鲦 鳐 鹞 灶 啭 馔 龇</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_22:癃 窿 胪 舻 孪 囊 摄 赎 傥 颤 龊 籴 叠 读 龛 鲢 邋 粝 躐 鹨 聋 饕 听 弯 鹧</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_23:雠 恋 鹩 蛎 鳞 麟 轳 挛 栾 猡 猱 摊 体 显</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_24:鳢 灵 陇 鹭 让 闼 瘫 螭 鞑 癫 蠹 攫 雳 谰厅 龌 鳣</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_25:叆 纛 揽 鬣 酃 颅 脔 摞 囔</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_26:逦 郦 驴 逻 瘰 攮</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_27:谠 缆 鸬 鲈 骧</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_28:魑 跞 轹</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_29:骊 躏</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">火_30:鹂 鲡 鸾 馕</div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('573', '<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_1:一 乙</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_2:又</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_3:丫 也 尢 于 己 山 土 丸 兀</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_4:引 尤 友 予 曰 允厄 切 王 卬 夭 尹</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_5:永 用 由 右 幼 孕 仔凹 瓦 戊 矽 央 以</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_6:伢 羊 伊 衣 圯 夷 亦 屹 因 有 宇 羽吖 安 充 地 圪 艮 圭 灰 圾 岌 戌 圳 圮 屺 戍 似 吐 圩 仵 伍</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_7:矣 佚 役 邑 吲 甬 攸 卣 佑 余 欤 玙 址岙 岜 坂 坌 辰 坊 坩 均 坎 坑 牡 圻 岐 岍 坍 秃 完 位 圬 氙 岘 呀 岈 延 冶</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_8:忤 亚 奄 肴 夜 依 抑 佾 咏 呦 侑 於 盂 臾 昀 狁艾 坳 垇 坻 坫 矾 附 矸 岣 岵 岬 坷 岢 岫 盱 坤 垃 峁 岷 坭 爬 帕 坢 坯 坪 坡 坦 坨 宛 往 旺 委 岩</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_9:型 峋 押 垭 娅 砑 咽 匽 怏 垚 姚 要 咿 怡 咦 姨 舣 姻 音 垠 俑 勇 幽 疣 羑 囿 宥 纡 舁 禹 垣 爰 约 玥 窀 哀 垵 拗 砭 垞 衩 昶 垤 垌 峒 肚 砘 垛 垩 垡 垓 垢 砍 砉 奎 趴 怕 盆 砒 垧 哇 娃 威 韦 畏 胃 瓮 屋 侮</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_10:埒 埋 砰 破 埔 砌 峭 窃 容 埏 砷 堍 砣 娓 翁 唔 阢 峡 蚜 氩 恹 胭 宴 晏 氧 恙 眙 酏 益 殷 氤 蚓 祐 迂 邘 育 彧 眢 员 袁 砸 砟 砧 肫啊 唉 埃 砹 鹌 俺 按 案 盎 敖 芺 峬 城 埕 砥 峨 恩 砝 砩 个 埂 埚 轩 砬</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_11:崎 畦 牵 眭 堂 窕 眺 婉 唯 帷 伟 尉 迕 捂 牾 硒 崤 硎 琊 崖 哑 讶 迓 崦 焉 偃 痒 野 痍 移 异 埸 翌 狺 寅 迎 茔 庸 恿 悠 蚰 蚴 狳 域 欲 蛭挨 庵 唵 埯 崩 埠 堾 埭 岽 硐 堆 岗 硌 崮 硅 崞 胡 基 崛 崆 勖 峥 埴 堀 崃 硭 埝 鸟 啪 培 堋 埤</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_12:捱 媕 啽 晻 胺 媪 傲 奡 堡 堛 嵖 砗 堤 奠 堞 恶 费 黑 堠 画 黄 堪 跖 喹 岚 塄 嵋 垴 蛙 崴 为 围 帏 惟 喂 硪 婺 痦 翕 硖 翔 硝 砚 堰 揶 掖 猗 壹 诒 迤 贻 胰 喑 堙 喁 釉 嵛 鼋 粤 越 崽</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_13:塌 塘 填 琬 碗 嵬 猥 痿 艉 猬 温 嗡 握 呜 蜈 坞 勋 埙 睚 衙 揠 蜒 爷 揖 饴 诣 意 裔 饮 佣 雍 蛹 犹 猷 瘀 园 圆 援 塬 氲 恽 晕 愠 轾 稚 嵫阿 矮 爱 嗌 揞 暗 嗷 嶅 廒 奥 碑 碚 碘 碉 碇 碓 痱 话 觟 嵴 碱 垲 诩 块 跬 袅 硼 圣 嵊 嵩 塑 碎</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_14:肮 獒 塝 碥 碴 墋 诞 碲 垫 碟 砜 闺 监 碣 境 墚 顼 嘘 墟 逵 壸 嵝 墁 呕 碰 堑 岖 墒 塾 墅 硕 碳 维 玮 诬 误 寤 瑕 鞋 碹 腌 嫣 耶 腋 祎 旖 夤 瑛 墉 踊 诱 与 鸢 冤 猿 殒 翟 崭 嶂 坠 准</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_15:怄 磐 嵚 确 豌 纬 诿 卫 慰 庑 娴 鸦 养 噎 叶 靥 亿 逸 影 慵 忧 邮 鱿 蝣 牖 谀 缘 院 阅 增 磔 腤 鞍 璈 墺 嶓 嶒 墀 磁 磋 嶝 墩 堕 废 坟 磙 嘿 糊 蝴 峤 磕 糈 蝰 崂 磊 嶙 碾 嬲 欧 殴</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_16:嗳 嫒 谙 聱 螯 懊 磅 壁 碜 惯 衡 垦 垮 磨 瓯 碛 墙 融 坛 违 谓 怃 歙 遐 鸭 阉 燕 噫 颐 峄 殪 阴 壅 馀 豫 鸳 螈 运 郓 酝 砖</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_17:阳 嶷 忆 怿 翳 应 婴 膺 拥 优 黝 隅 屿 辕 远 龠 郧癌 隘 闇 鮟 醠 遨 謷 磴 礅 鲑 壕 壑 磺 矶 礁 圹 岭 硗 嵘 闱 鲔 邬 压</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_18:碍 瑷 盫 袄 蹦 璧 础 礓 垒 讴 韪 鄢 医 黟 彝 癔 鄞 鄘 鼬 陨 韫</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_19:爊 礤 坏 疆 坜 垄 垆 稳 鹉 骛 臆 臃 韵</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_20:骜 巉 矿 岿 砾 壤 鼯 鹜 邺 瘾 嘤 罂</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_21:鳌 礴 蠡 砺 砻 碌 礞 巍 撄 誉 跃</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_22:巅 峦 鸥 懿 隐 璎 鳙 饔</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_23:娈 缨</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_24:坝 罐 盐 艳 呓</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_28:鹦</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">土_29:鹳</div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('574', '<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_2:人 入 厶 刀 匕</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_3:刃 小 寸 三 上 才 川 亍 夕 千 叉 士</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_4:殳 仁 什 四 仄 仍 刈 乏 手 兮 氏 冗 爪 戈 心 少</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_5:世 示 生 仟 市 仞 史 失 矢 册冊 石 甩 仕 仙 斥 占 出 刊 尻 玊 乍 司 申 且 正 叱 叼 主</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_6:刎 如 臣 扔 任 守 吸 西 夙 次 舛 早 先 州 吏 舟 凸 此 死 汆 寺 妁 吒 列 匈 旬 在 舌 丢 字 再 曳 丞 而 囟 存 色 式</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_7:辛 判 伸 宋 身 伭 吹 七 走 卮巵 劭 酉 删 赤 坐 作 佐 忒 吻 串 卲 佘 兕 氚 姒 巡 兑兌 助 壮壯 忖 车車 妊 岔 忍 吱 妆妝 皂 孜 成 束 秀 私 佀 吵 伫佇 扱 礽 伺 吮 序</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_8:忱 侃 些 昃 扯 戋戔 刷 抄 刻 忡 金 怎 青 姓 承 取 轧軋 甾 咋 刖 弨 侏 卒 佌 刺 周 妯 侁 呻 侘 咒呪 宙 忮 抒 妻 受 初 叁 孥 事 抓 始 使 刹 宗 升 叔 尚 姃 疝 兔 戕 所 昌 垂 儿兒 姗 刮 舍 社 昔 穸 忪 侄 庚 祀</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_9:咻 甚 舢 刭剄 耏 矧 庥 哂 度 钇釔 宣 页頁 毒 姺 叙 俓 厍厙 砂 首 秋 胥 舡 殂 思 娀 肜 籼 祆 纫紉 叟 帅帥 穿 柔 俗 剃 剞 怵 春 是 牲 省 尸屍 施 食 星 闩閂 室 促 衫 钆釓 削 耍 庠 姝 性 信 枯 峙 拙 眨 肘 姹 昨 昝 咱 俣俁 差 疢 宬 咨 拆 哉 则則 怊 姿 咤 咫 侵 伡俥 俎 怯 前 蚤 拄 臿 俞 查 抻 怔 怍</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_10:剖 掀 狨 轫軔 怪 敇 刚剛 纾紓 唓 耖 晁 殊 倪 拴 眧 狩 脆 酎 衽 书書 哳 紊 息 唏 钌釕 孙孫 钊釗 拯 隼 针針 倩 真 伥倀 索 剜 俶 弱 畛 剐剮 辱 疹 唆 剡 痄 窄 衰 祠 讪訕 借 素 祚 症 指 祟 纸紙 扇 鬯 刬剗 刍芻 倡 纯純 宫 豺 席 宵 修 徐 宰 脩 凋 唑 钋釙 邛 珊 珐 厝 剥剝 眚 訏 殉 射 神 娠 珅 财財 痃 座 乘乗 租 玹 吣唚 钉釘 峻 眩 拾 翅翄 闪閃 持 祖 奘 栽 讱訒 宸 拽 珇 唣 十 笑 挈 疰 蚩 时 酌 师師 哨 仓倉</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_11:栀梔 啥 胝 船舩 捎 商 常 唼 族 匙 奢 钏釧 蛇 訢 绍紹 组組 狻 娼 设設 侧側 着 孰 钒釩 阡 昼晝 曹 彩 售 罡 专專 捏 啐 厕厠 珠 捅 蛀 钎釺 钕釹 赦 得 疵 产産 偲 绅紳 副 粗 瓷甆 众眾 挫 参參 胂 终終 紫 钗釵 玼 趾 胙 徙 琤 宿 酗 剪 做 紬 祭 钓釣 粘 雀 爽 砦 舴 旋 唱 悚 舷 讼訟 羞 馗 蚺 扎紮 邢 袖 祥 偢 细細 巢 蚱 悦悅 唰 偁 旌 瓻 勘 庶 钐釤 问問 欷 圊 寂 偷 绌絀 偰 斜 胗 钍釷 率 豉 氢氫 趻 啜 责責 悉 晨 崇 邤 徜 珮 舂 处處</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_12:盛 禽 述 贮貯 剩 胸 註 貂 掉 舾 钣鈑 痤 钮鈕 嵯 牚 兹 伧傖 钦欽 枣棗 啻 须須 绚絢 竣 诅詛 剀剴 畲 猞 钧鈞 邵 喧 情 堵 氰 稍 钭鈄 裒 尊 胵 喻 甥 胜勝 然 残殘 琇 肾腎 措 惆 裁 矬 跚 婿 痧 絮 猜 钸鈽 绝絕 净淨 散 斯 惜 傒 捶 晰 犀 粞 伞傘 创創 脂 怅悵 殖 俟 孱 粟 轵軹 词詞 诉訴 割 甯 戟 善 掊 童 替 猖 壶壺 挣掙 狰猙 推 帧幀 喘 觇覘 惝 阼 辜 钩鉤 睃 敞 诏詔 飧 掌 贰貳 象 钠鈉 瘦 授 税稅 羡 韧韌 悴 钛鈦 曾 毳 钝鈍 扫掃 嫂 皴 琈 嗏 蛛 钤鈐 视視 钫鈁 钯鈀 钙鈣 酥 诈詐 丝絲 舄 丧喪 嗖 钞鈔 黍 超 顺順 喳 迮 猝 舒 疏 酢 竦 朝 舜 绒絨</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_13:歃 煞 塞 跫 钶 鈳 钜 靖 嗪 惬愜 饪飪 揉 捷 剿勦 铆 鉚 铃 鈴 裟 蜣 钴 鈷 钼鉬 搔 铌鈮 钳鉗 铅鉛 琗 剻 铍鈹 钾鉀 饬飭 蚬蜆 煦 揎 暄 铉 驯馴 愁 傺 稠 铀鈾 絺 愉 揄 脭 蝓 询詢 鼠 跣 睡 详詳 想 绡綃 蜀 嗅 歆 裕 刨鉋、鑤 猩 楚 貅 钿鈿 绣綉 新 铂 瘃 恻惻 庄莊 装 琸 粲 伛傴 睬 诛誅 钹鈸 钵鉢 揍 傶 阻 铋鉍 资資 债債 惺 愈 钺鉞 载載 嗔 琛 插挿 闸閘 邾 斟 钲鉦 睁睜 黹 酯 诧詫 钰鈺 贼賊 嗦 嗍 跐 嗣 肆 蠢惷 揣 岁歲 毹 羧 唢嗩 铊鉈 歂 钽 酮 嫌 搓 伤傷 艄 蛸 诜詵 蜃 脞 琮 邿 暑 势勢 试試 轼軾 瘁 催 睢 诗詩 钷鉕 嗉 媳 肃肅 蜍 剸 郄 搜 送 酰</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_14:铒鉺 铭銘 僝 铰鉸 罚罰 瘥 铵銨 察 粹 陧 翠 嘈 速 铥銩 艑 瞍 愫 说說 铝鋁 睹 诵誦 嗾 綵 阀閥 精 劂 僳 聚 绸綢 僢 铖鋮 铞銱 酲 殠 搐 划劃 搊 铳銃 铪鉿 郝 铐銬 雌 嫦 搋 闾閭 厂厰 觫 怆愴 铫銚 诚誠 慈 铬鉻 裯 铑銠 綝 称稱 玚瑒 劁 僧 誓 碡 寿壽 铯銫 绶綬 帻幘 啧嘖 嗽 造 觋覡 陎 抢搶 禊 瘙 铱銥 署 综綜 搠 需 认認 逍 悫愨 铨銓 绱緔 铢銖 韶 赊賒 蜥 劓 逡 逝 衔銜 慎 蜻 僖 寝 狮獅 帚 赈賑 臧 甄 睻 瑜 睿 慊 铷銣 狲 像 腴 铕銪 戗戧 僔 瑞 铜銅 綮 僮 摭 齐齊 骰 途 银銀 屣 蜘 腙 限 郤 铟銦 损損 搡 酸 腔 酴 粽 铣銑 窬</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_15:鋈 廛 锆鋯 殇殤 铤鋌 瘛 谄諂 锐銳 腮 冲衝 铘鋣 刽劊 锇鋨 锋鋒 傻儍 肠腸 稹 陕陝 毵毿 刿劌 敷 磉 噇 赐賜 咝噝 铺 缌緦 糌 嘶 驷駟 踳 实實 谇誶 醋 摐 疮瘡 漦 琐瑣 諔 锑銻 嘬 恸慟 腿 鋋 摴 赏賞 嘟 厨廚 揸摣 锃鋥 审審 锉銼 熟 锄鋤 驵駔 蚀蝕 驶駛 麨 奭 艏 摧 噪 瞋 嘻 谂諗 靓靚 陷 锈銹 剧劇 锔鋦 谁誰 艖 锕錒 锂鋰 锊鋝 刳 髯 腥 腺 糅 节節 皱皺 锞錁 谆諄 诼諑 怂慫 锒鋃 噙 锓鋟 线線 惨慘 趣 锍鋶 惭慚 请請 幢 翥 踩 陉陘 儇 掺摻 绪緒 缄緘 铗鋏 線 钡鋇 陟 陬 哓嘵 挚摯 销銷 摻 婵嬋 腧 数數 劈 帜幟 摔 诹諏 锌鋅 艘 剑劍 螋</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_16:踹 钱錢 餐 锱錙 锤錘 输輸 穆 鄃 錡 褫 陲 憯 穇 锡錫 撙 雕 觎覦 凭憑 儒 赪 谕諭 缊縕 钔鍆 撕 郰 蛳螄 窗窻 锛錛 锖錆 璁 锬錟 遄 糍 锫錇 逾 锰錳 颓頹 輴 醒 踸 嫱嬙 谌諶 錞 嬗 鋹 阊閶 郮 蹂 锦錦 铮錚 缜縝 整 螅 憎 膳 璀 静靜 羲 绉縐 锢錮 瘳 稣穌 缛縟 褥 锪 辐輻 辑輯 氅 噻 瘵 侪儕 谖諼 憧 钢鋼 幨 髹 铼錸 糙 锟錕 揿撳 鹾 蹉 谒謁 撞 甑 蹅 锨鍁 错錯 舱艙 锭錠 麈 诸諸 瘸 锩錈 锯鋸 锥錐 战戰 锝鍀</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_17:猃獫 帱 幬 瞬 戏戲 憷 翼 痫癇 歜 谢謝 逊 遜 耸聳 馅 餡 蟀 鸺 鵂 锼 鎪 鲜鮮 谿 蟋 膝 谡謖 锺鍾 懆 骏駿 馇餷 锸鍤 键鍵 诌謅 赛賽 蹇 艚 嚅 韔 禅禪 黜 锾鍰 鄏 锅鍋 饯餞 镅鎇 锿鎄 嚓 遣 擦 邹鄒 跄蹌 鍪 锴鍇 镁鎂 螬 总總 縩 锹鍬 链鏈 锲鍥 操 徽 縻 孺 毡氈 聪聰 铡鍘 罾 声聲 鼌鼂 缩縮 独獨 隋 舆 谥諡 虽雖 锶鍶 糟 糁糝 鍼 絷縶 膗 缫繅 斋齋 偿償 擅 锷鍔 锗鍺 锻鍛 镀鍍</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_18:饆 迟 遲 镈鎛 镑鎊 鏊 翱 儭 鎞 膪 艟 繟 蝉蟬 织織 镇鎮 擤 颛顓 遭 缯繒 镒鎰 璨 赜賾 踪蹤 鬃 懤 储儲 镏鎦 鞣 聂聶 镕鎔 缮繕 阙闕 雟 镎鎿 雏雛、鶵 镓鎵 阕闋 啮嚙 钨鎢 镉鎘 铠鎧 婶 觞 鄜 蟮 锁鎖 镐 幮 飕颼 双雙 饩餼 拧擰 燹 劐 窜竄 秽穢 环環 阋鬩 镍鎳 铩鎩 蟓 狞獰 蹙</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_19:蟾 谮譖 辞辭 识識 绳繩 鲳鯧 祷禱 赞贊 牍牘 兽獸 錾鏨 躁 襜 鹊鵲 犊犢 蹴 鲭鯖 镝鏑 璹 摅攄 镜鏡 颠 镞鏃 镛鏞 镖鏢 系 擞擻 畴疇 遵 惩懲 鄯 鲰鯫 镚鏰 馐饈 暹 迁遷 鏖 锘鍩 膻 馊餿 锵鏘 铿鏗 铲鏟 谯譙 颡顙 镗鏜 鎏 镂鏤 骚騷 选選 镘鏝 锚錨 镆鏌 醯 臊 镟鏇 宠寵</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_20:铧鏵 鳃鰓 镡鐔 鳋鰠 馓饊 锎鐦 镤鏷 镨 聍聹 鐏 缱繾 驺騶 镪鏹 鏻 镣鐐 謦 黥 鏸 鐉 鐍 镢鐝 蝾蠑 鐎 锏鐧 钟鐘 襦 繻 蠕 铹鐒 鐇 译譯 犨 续續 释釋 酬醻 铴鐋 镫鐙 镄鐨 鰆 璺 谵譫 馨 孀 触觸 镦鐓 霰 骟騸</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_21:儹 鹚鷀 镌鐫 镯鐲 属屬 铁鐵 燨 谴譴 衬襯 铛鐺 骖驂 镱鐿 隧 镰鐮 蛩 邃 鸧鶬 嗫囁 鏴 镭鐳 随 躇 虿蠆 鐾 险險 搀攙 麝 羼 鄹 韂 铎鐸 呲齜、呲 骢驄 忏懺</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_22:踯躑 摛攡 冁囅 骣驏 躔 慑懾 骁驍 镬鑊 癣癬 袭襲 镲鑔 撺攛 镔鑌 隰 蹰 鉴鑒 铸鑄</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_23:镥鑥 镳鑣 仇讎 纤纖 鱚 鹇鷳 鼷 鳟鱒 鸶鷥 颥顬 髑 黪 髓 銎 脏髒 铄鑠 攒攢 鳝鱔</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_24:谗讒 瓒瓚 瓉 骤驟 蚕蠶 矗 鑫 嘱囑 谶</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_25:蹑躡 齄齇 蹿躥 鑶 镵鑱 钥鑰 璛 赃贓 镶鑲 鲿鱨 衅釁 镧鑭</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_26:跹躚 镊鑷 酾釃 馋饞 镩鑹 骥驥 趱趲 瞩矚</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_27:颞顳 钻鑽 黩黷 锣鑼 銮鑾 凿鑿</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_28:齼</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_29:镙鏍</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">金_30:爨</div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('575', '<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: inherit; line-height: 1.5;\">水_2:勹 卜 乜</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_3:凡 亡 下 子</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_4:毛 爿 匹 片 壬 卅 水 文 毋 勿夫 父 互 户 化 幻</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_5:玄 矛 民 皿 末 母 仫 目 丕 皮 氕 平 叵 仨 兄 穴叭 白 半 包 北 必 弁 卟 布 弗 付 夯 禾 弘 乎 疋 印 匝</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_6:合 冱 回 汁 米 糸 名 牟 仳 牝 乒 收 汀 扒 百 冰 并 凼 伐 帆 氾 犯 仿 妃 份 缶 伏 亥 好危 向刑行凶休 血</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_7:妨 彷 吠 吩 佛 否 呋 孚 甫 汞 佝 含 罕 汗 亨 宏 囫 弧 汲 即 江 戒 况 冷 忙 尨 每 芈 妙 尿 妞 伾 屁 汝 汕 汜 忘 尾 污 汐 希 孝 形 汛吧 夿 弝 伴 贝 伻 皀 佊 吡 妣 庇 别 兵 伯 孛 吥 步 汊 池 汎 妤 妘</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_8:氓 孟 汨 宓 明 命 殁 沫 侔姆沐牧 忸扭 狃 抛 咆 庖 呸 沛 佩 帔 朋 批 沏 汔 汽 沁 沙 沈 汰 汪 味 汶 沃 武 物 弦 冼 享 协 忻 幸汹沂雨 沅 咂沚 岸 八 把 爸 扳 攽 版 扮 姅 孢 卑 屄 沘 彼 畀 忭 抃 汳 汴 表 秉 幷 帛 瓝 沉 沌 泛 房 放 非 氛汾忿奉扶 府 咐 阜 侅 冈 汩 卦 沆 呵 劾 和 佫 呼 虎 或 泐 盲 牦 没 妹 门 状</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_9:计 沮 炬 姥 泪 泠 泖 昴 冒 玫 眉 美 昧 虻 咪 弭 泌 沔 勉 眇 秒 咩 抿 泯 抹 哞 某 拇 泥 拍 哌 泮 叛 盼 狍 泡 疱 怦 抨 披 毗 姘 品 屏 泼匍 柒疤 拔 拜 拌 保 抱 背 祊 甭 泵 毖 扁 窆 拚 便 昪 波 泊 勃 哺 怖 匆 沲 法 畈 飞 沸 狒 玢 风 封 凫 怫 拂 俘 氟 罘 拊 讣 负 泔 沽 哈 孩 河 很 红 泓 侯 后 厚 狐 怙 徊 奂 宦 皇 虺 哕 泣 泅 泉 染 娆 沭 泗 沱 咸 香 巷 泄 卸 泫 泶 妍 沿 泱 盈 泳 油 沾 沼 治 注</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_10:洄 恚 活 洎 浃 津 酒 恤 洫 洌 洛 马 邙 旄 们 勐 洣 敉 秘 眠 眄 珉 秣 毪 亩 纽 俳 派 畔 袢 旁 配 疲 蚍 拼 娉 俜 洴 珀 哱 圃 凄 讫 迄 洽 洳 洒 氨 粑 呗 班 般 舨 豹 趵 倍 倴 畚 秕 俾 舭 毕 珌 髟 俵 病 玻 砵 亳 庯 秤 臭 泚 洞 娥 洱 肪 纺 舫 肥 匪 肺 纷 峰 俸 服 祓 蚨 俯 釜 害 氦 蚶 邗 函 航 耗 盍 狠 恨 哼 恒 洪 候 祜 洹 杀 纱 娑 洮 洼 洧 纹 蚊 务 洗 效 胁 绁 洩 屑 恂 洵 训 衍 洋 洇 耘 拶 洲 洙 浊</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_11:捌 豝 胈 败 绊 邦 浜 胞 狈 被 偝 偪 逼 闭 狴 婢 庳 敝 贬 匾 徧 彪 婊 邠 斌 浡 舶 捕 涔 唇 讹 返 贩 访 啡 酚 唪 趺 麸 绂 绋 浮 匐 艴 妇 够 海 酣 浛 毫 浩 盒 痕 珩 唿 唬 扈 瓠 患 凰 悔 彗 晦 婚 货 浸 泾 涓 浚虚 浪 流 麻 麦 脉 曼 袤 浼 眯 觅 密 冕 喵 苗 敏 眸 涅 徘 胖 脬 袍 匏 胚 旆 烹 啤 偏 殍 票 贫 婆 粕 浦 渠涩 涉 涑 挲 涕 涂 晚 望 偎 浯 浠 习 涎 消 邪 挟 婞 讻 雪 涌 鱼 雩 浴 浙 浞</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_12:寒 喊 琀 绗 淏 诃 喝 涸 訸 贺 惚 淮 唤 徨 蛔 惠 混 耠 惑 渐 荆 涼 涞 淋 淩 渌 沦 傌 买 茫 蛑 贸 帽 媒 媚 寐 扪 闷 猛 脒 幂 黾 描 淼 闵 淖 排 跋 阪 湴 绑 傍 棓 报 悲 邶 备 贲 絣 琫 诐 邲 弼 皕 赑 揙 猋 幖 邴 啵 博 跛 钚 瓿 淳 淙 淬 淡 发 番 饭 邡 防 扉 淝 悱 斐 粪 冯 稃 跗 涪 袱 幅 复 傅 富 淦 蛤 涫 胲 顸 邯 涵牌 跑 彭 捧 邳 痞 胼 评 迫 普 淇 浅 清 脎 深 淑 涮 淞 淌 淘 添 淟 涴 雯 涡 无 淅 喜 闲 现 项 淆 雄 徇 涯 淹 液 淫 淤 淯 渊 云 粥 涿 淄</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_13:靶 颁 斑 斒 稖 雹 陂 琲 迸 哔 愊 愎 痹 辟 閟 惼 飑 禀 摒 脖 渤 补 测 滁 渡 沨 蜂 脯 溉 港 傼 颃 嗥 号 郃 貉 郈 轷 湖 猢 琥 郇 换 涣 豢 惶 湟 挥 晖 汇 会 贿 喙 毁 浑 贾 湔 茳 湫 较 粳 鸠 渴 粱 溆 雷 妈 吗 湄 猸 渼 盟 迷 渺 湣 愍 酩 莫 貊 脲 琶 湃 湓 琵 媲 睥 犏 剽 聘 瓶 裘 惹 绥 汤 湍 微 湋 渭 渥 熙 湘 渫 渲 湮 游 渝 郁 渣 湛 浈 滞 渚 煮</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_14:痪 滉 珲 诲 魂 溷 祸 溘 溧 溴 滥 溜 犸 唛 嘛 幔 髦 瑁 瞀 么 酶 艋 蜢 嘧 蜜 绵 瞄 灭 闽 鸣 冥 溟 暝 嫫 麽 陌 寞 溺 滂 搒 脾 罴 蜱 嘌 嫖 萍 颇搬 蝂 饱 悖 绷 嘣 鼻 币 滗 裨 弊 碧 馝 稨 滮 裱 宾 菠 驳 搏 僰 箔 逋 沧 滀 呆 涤 滇 绯 蜚 腓 翡 偾 疯 逢 凤 孵 郛 福 辅 腑 滏 腐 阁 沟 嘏 寡 滚 嗨 豪 滈 阂 菏 瑚 华 滑 猾 仆 溥 蜞 溱 溶 溽 飒 饲 溲 溯 溻 溏 滔 网 瘟 闻 郚 舞 郗 溪 携 熊 踅 熏 窨 溢 荥 源 滋 滓</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_15:鲃 魃 罢 瘢 魬 褒 鸨 褓 暴 辈 褙 骳 奔 陛 腷 駜 髲 编 蝙 褊 缏 麃 摽 憋 饼 葧 踣 餔 部 漕 浐 蝽 漘 醇 滴 幡 范 鲂 诽 肤 幞 蝠 驸 赋 腹 蝜 蝮 澉 缑 盥 虢 憨 汉 撖 颌 褐 滹 浒 沪 哗 踝 逭 漶 辉 麾 慧 浆 涟 漩 震 漤 凛 漏 漉 履 落 玛 码 祃 劢 卖 鞔 满 慢 漫 漭 猫 蝥 貌 霉 魅 缅 缈 庙 缗 瞑 摸 摩 漠 墨 慕 暮 沤 蒎 盘 醅 赔 喷 嘭 郫 陴 翩 漂 魄 噗 漆 憩 渗 漱 霆 万 逶 嬉 虾 饷 霄 勰 写 演 漾 漪 颍 渔 漳 涨 渍</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_16:澳 鲅 办 鲍 虣 惫 糒 甏 嬖 觱 鮅 鞞 遍 辨 瘭 傧 拨 饽 播 鲌 膊 馞 潺 潮 澈 澄 霏 奋 愤 讽 抚 鲋 骸 骇 颔 翰 翮 醐 寰 遑 潢 讳 阍 馄 涧 浇 洁 噱 溃 潦 涝 霖 蚂 骂 瞒 螨 醚 悯 螟 瘼 默 谋 霓 凝 潘 螃 耪 陪 霈 澎 膨 骈 蹁 谝 瓢 瞟 撇 瞥 频 鲆 扑 氆 潜 润 撒 霎 潸 潲 渑 澍 澌 潭 烫 潼 隈 沩 涠 阌 宪 廨 兴 学 浔 鄅 沄</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_17:璠 繁 鼢 缝 缚 醢 鼾 韩 憾 撼 嚎 鸿 觳 浣 擐 璜 隳 浍 诨 濂 阔 蒗 澧 潞 嬷 缦 蟒 蟊 弥 谜 糜 谧 摹 膜 浓 蟠 貔 缥 螵 嫔 皤 璞 霜 濉 禧 霞 癍 帮 谤 跸 臂 褾 豳 擘 澹 点 淀乡 鲞 亵 懈 獬 鲟 澡 泽 澶</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_18:鼥 鞴 鄙 毙 濞 髀 奰 鞭 飚 蹩 滨 摈 殡 袯 鹁 馎 鵏 闯 荡 翻 黻 赙 覆 馥 濠 阖 鄠 鲩 缋 蟪 济 谩 鄚 朦 鄍 谟 馍 貘 泞 蹒 蟛 癖 濮 濡 鲨 湿 穗 涛 潍 隙 獯 滢 杂 濯</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_19:瓣 鹎 襞 瀌 瘪 薄 醭 簿 瀍 鹑 渎 蹯 鲱 羹 鞲 鲴 缳 绘 嚯 溅 猎 浏 泺 懑 懵 蠓 祢 靡 湎 鹋 鹏 骗 鄱 谱 蹼 瀑 扰 雾 泻 霪</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_20:膀 龅 鲾 避 襣 躄 鳊 辫 穮 缤 濒 蠙 膑 黼 鳆 瀚 蚝 鹕 怀 还 濑 沥 泷 泸 迈 颟 馒 鹛 蠛 魔 譬 嚷 邂 瀣 潆 瀛 潴</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_21:黯 霸 辩 骠 膘 飙 襮 藩 瀵 鹤 轰 护 潋 澜 露 猕 腼 邈 霹 鼙 鳍 瀼 攘 潇 醺 瀹</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_22:边 鳔 鳖 沣 灌 骅 欢 獾 霁 漓 霾 鳗 艨 鳘 耱 瓤 穰 滠 响 飨 鳕 藻</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_23:鷩 变 鲼 鬟 禳 滩</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_24:蚌 髌 鬓 霍 辔 颦 躞</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_25:灞 酆 灏 鹱 漯 蛮 蘼 襻</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_26:湾</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_27:滦 缬</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_28:滟 戅</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">水_30:骉</div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('576', '<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\"><span style=\"background-color: rgb(255, 255, 255);\">升到9个太阳需要58年左右时间!&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">升到第一个太阳，只需要一年不到的时间（320天，每天两小时在线时间，如果你包一年会员要更快一点）如果要升到9个太阳，也不长，用这一辈子的时间还是有希望达到的，只要21312天即可。&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">21312天除以365天等于58.389041095890410958904109589041年。&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">假如你出生的时候，你父母就帮你申请了一个QQ号，每天帮你上线两小时，等你差不多60岁的时候你就可以有9个太阳的QQ了，爽吧！！（苦笑ing）&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">对照下面的数字，看一下你想升到多少太阳需要多长时间：&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">第一个太阳&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">0级&nbsp;0太阳&nbsp;0月亮&nbsp;0星星&nbsp;0天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">1级&nbsp;0太阳&nbsp;0月亮&nbsp;1星星&nbsp;5天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">2级&nbsp;0太阳&nbsp;0月亮&nbsp;2星星&nbsp;12天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">3级&nbsp;0太阳&nbsp;0月亮&nbsp;3星星&nbsp;21天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">4级&nbsp;0太阳&nbsp;1月亮&nbsp;0星星&nbsp;32天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">5级&nbsp;0太阳&nbsp;1月亮&nbsp;1星星&nbsp;45天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">6级&nbsp;0太阳&nbsp;1月亮&nbsp;2星星&nbsp;60天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">7级&nbsp;0太阳&nbsp;1月亮&nbsp;3星星&nbsp;77天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">8级&nbsp;0太阳&nbsp;2月亮&nbsp;0星星&nbsp;96天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">9级&nbsp;0太阳&nbsp;2月亮&nbsp;1星星&nbsp;117天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">10级&nbsp;0太阳&nbsp;2月亮&nbsp;2星星&nbsp;140天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">11级&nbsp;0太阳&nbsp;2月亮&nbsp;3星星&nbsp;165天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">12级&nbsp;0太阳&nbsp;3月亮&nbsp;0星星&nbsp;192天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">13级&nbsp;0太阳&nbsp;3月亮&nbsp;1星星&nbsp;221天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">14级&nbsp;0太阳&nbsp;3月亮&nbsp;2星星&nbsp;252天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">15级&nbsp;0太阳&nbsp;3月亮&nbsp;3星星&nbsp;285天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">16级&nbsp;1太阳&nbsp;0月亮&nbsp;0星星&nbsp;320天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">第二个太阳&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">17级&nbsp;1太阳&nbsp;0月亮&nbsp;1星星&nbsp;357天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">18级&nbsp;1太阳&nbsp;0月亮&nbsp;2星星&nbsp;396天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">19级&nbsp;1太阳&nbsp;0月亮&nbsp;3星星&nbsp;437天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">20级&nbsp;1太阳&nbsp;1月亮&nbsp;0星星&nbsp;480天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">21级&nbsp;1太阳&nbsp;1月亮&nbsp;1星星&nbsp;525天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">22级&nbsp;1太阳&nbsp;1月亮&nbsp;2星星&nbsp;572天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">23级&nbsp;1太阳&nbsp;1月亮&nbsp;3星星&nbsp;621天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">24级&nbsp;1太阳&nbsp;2月亮&nbsp;0星星&nbsp;672天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">25级&nbsp;1太阳&nbsp;2月亮&nbsp;1星星&nbsp;725天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">26级&nbsp;1太阳&nbsp;2月亮&nbsp;2星星&nbsp;780天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">27级&nbsp;1太阳&nbsp;2月亮&nbsp;3星星&nbsp;837天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">28级&nbsp;1太阳&nbsp;3月亮&nbsp;0星星&nbsp;896天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">29级&nbsp;1太阳&nbsp;3月亮&nbsp;1星星&nbsp;957天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">30级&nbsp;1太阳&nbsp;3月亮&nbsp;2星星&nbsp;1020天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">31级&nbsp;1太阳&nbsp;3月亮&nbsp;3星星&nbsp;1085天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">32级&nbsp;2太阳&nbsp;0月亮&nbsp;0星星&nbsp;1152天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">第三个太阳&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">33级&nbsp;2太阳&nbsp;0月亮&nbsp;1星星&nbsp;1221天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">34级&nbsp;2太阳&nbsp;0月亮&nbsp;2星星&nbsp;1292天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">35级&nbsp;2太阳&nbsp;0月亮&nbsp;3星星&nbsp;1365天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">36级&nbsp;2太阳&nbsp;1月亮&nbsp;0星星&nbsp;1440天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">37级&nbsp;2太阳&nbsp;1月亮&nbsp;1星星&nbsp;1517天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">38级&nbsp;2太阳&nbsp;1月亮&nbsp;2星星&nbsp;1596天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">39级&nbsp;2太阳&nbsp;1月亮&nbsp;3星星&nbsp;1677天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">40级&nbsp;2太阳&nbsp;2月亮&nbsp;0星星&nbsp;1760天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">41级&nbsp;2太阳&nbsp;2月亮&nbsp;1星星&nbsp;1845天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">42级&nbsp;2太阳&nbsp;2月亮&nbsp;2星星&nbsp;1932天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">43级&nbsp;2太阳&nbsp;2月亮&nbsp;3星星&nbsp;2021天&nbsp;&nbsp;</span></font></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\"><span style=\"background-color: rgb(255, 255, 255);\">44级&nbsp;2太阳&nbsp;3月亮&nbsp;0星星&nbsp;2112天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">45级&nbsp;2太阳&nbsp;3月亮&nbsp;1星星&nbsp;2205天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">46级&nbsp;2太阳&nbsp;3月亮&nbsp;2星星&nbsp;2300天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">47级&nbsp;2太阳&nbsp;3月亮&nbsp;3星星&nbsp;2397天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">48级&nbsp;3太阳&nbsp;0月亮&nbsp;0星星&nbsp;2496天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">第四个太阳&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">49级&nbsp;3太阳&nbsp;0月亮&nbsp;1星星&nbsp;2597天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">50级&nbsp;3太阳&nbsp;0月亮&nbsp;2星星&nbsp;2700天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">51级&nbsp;3太阳&nbsp;0月亮&nbsp;3星星&nbsp;2805天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">52级&nbsp;3太阳&nbsp;1月亮&nbsp;0星星&nbsp;2912天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">53级&nbsp;3太阳&nbsp;1月亮&nbsp;1星星&nbsp;3021天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">54级&nbsp;3太阳&nbsp;1月亮&nbsp;2星星&nbsp;3132天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">55级&nbsp;3太阳&nbsp;1月亮&nbsp;3星星&nbsp;3245天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">56级&nbsp;3太阳&nbsp;2月亮&nbsp;0星星&nbsp;3360天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">57级&nbsp;3太阳&nbsp;2月亮&nbsp;1星星&nbsp;3477天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">58级&nbsp;3太阳&nbsp;2月亮&nbsp;2星星&nbsp;3596天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">59级&nbsp;3太阳&nbsp;2月亮&nbsp;3星星&nbsp;3717天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">60级&nbsp;3太阳&nbsp;3月亮&nbsp;0星星&nbsp;3840天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">61级&nbsp;3太阳&nbsp;3月亮&nbsp;1星星&nbsp;3965天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">62级&nbsp;3太阳&nbsp;3月亮&nbsp;2星星&nbsp;4092天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">63级&nbsp;3太阳&nbsp;3月亮&nbsp;3星星&nbsp;4221天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">64级&nbsp;4太阳&nbsp;0月亮&nbsp;0星星&nbsp;4352天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">第五个太阳&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">65级&nbsp;4太阳&nbsp;0月亮&nbsp;1星星&nbsp;4485天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">66级&nbsp;4太阳&nbsp;0月亮&nbsp;2星星&nbsp;4620天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">67级&nbsp;4太阳&nbsp;0月亮&nbsp;3星星&nbsp;4757天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">68级&nbsp;4太阳&nbsp;1月亮&nbsp;0星星&nbsp;4896天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">69级&nbsp;4太阳&nbsp;1月亮&nbsp;1星星&nbsp;5037天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">70级&nbsp;4太阳&nbsp;1月亮&nbsp;2星星&nbsp;5180天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">71级&nbsp;4太阳&nbsp;1月亮&nbsp;3星星&nbsp;5325天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">72级&nbsp;4太阳&nbsp;2月亮&nbsp;0星星&nbsp;5472天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">73级&nbsp;4太阳&nbsp;2月亮&nbsp;1星星&nbsp;5621天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">74级&nbsp;4太阳&nbsp;2月亮&nbsp;2星星&nbsp;5772天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">75级&nbsp;4太阳&nbsp;2月亮&nbsp;3星星&nbsp;5925天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">76级&nbsp;4太阳&nbsp;3月亮&nbsp;0星星&nbsp;6080天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">77级&nbsp;4太阳&nbsp;3月亮&nbsp;1星星&nbsp;6237天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">78级&nbsp;4太阳&nbsp;3月亮&nbsp;2星星&nbsp;6396天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">79级&nbsp;4太阳&nbsp;3月亮&nbsp;3星星&nbsp;6557天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">80级&nbsp;5太阳&nbsp;0月亮&nbsp;0星星&nbsp;6720天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">第六个太阳&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">81级&nbsp;5太阳&nbsp;0月亮&nbsp;1星星&nbsp;6885天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">82级&nbsp;5太阳&nbsp;0月亮&nbsp;2星星&nbsp;7052天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">83级&nbsp;5太阳&nbsp;0月亮&nbsp;3星星&nbsp;7221天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">84级&nbsp;5太阳&nbsp;1月亮&nbsp;0星星&nbsp;7392天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">85级&nbsp;5太阳&nbsp;1月亮&nbsp;1星星&nbsp;7565天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">86级&nbsp;5太阳&nbsp;1月亮&nbsp;2星星&nbsp;7740天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">87级&nbsp;5太阳&nbsp;1月亮&nbsp;3星星&nbsp;7917天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">88级&nbsp;5太阳&nbsp;2月亮&nbsp;0星星&nbsp;8096天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">89级&nbsp;5太阳&nbsp;2月亮&nbsp;1星星&nbsp;8277天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">90级&nbsp;5太阳&nbsp;2月亮&nbsp;2星星&nbsp;8460天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">91级&nbsp;5太阳&nbsp;2月亮&nbsp;3星星&nbsp;8645天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">92级&nbsp;5太阳&nbsp;3月亮&nbsp;0星星&nbsp;8832天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">93级&nbsp;5太阳&nbsp;3月亮&nbsp;1星星&nbsp;9021天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">94级&nbsp;5太阳&nbsp;3月亮&nbsp;2星星&nbsp;9212天</span></font></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\"><span style=\"background-color: rgb(255, 255, 255);\">95级&nbsp;5太阳&nbsp;3月亮&nbsp;3星星&nbsp;9405天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">96级&nbsp;6太阳&nbsp;0月亮&nbsp;0星星&nbsp;9600天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">第七个太阳&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">97级&nbsp;6太阳&nbsp;0月亮&nbsp;1星星&nbsp;9797天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">98级&nbsp;6太阳&nbsp;0月亮&nbsp;2星星&nbsp;9996天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">99级&nbsp;6太阳&nbsp;0月亮&nbsp;3星星&nbsp;10197天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">100级&nbsp;6太阳&nbsp;1月亮&nbsp;0星星&nbsp;10400天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">101级&nbsp;6太阳&nbsp;1月亮&nbsp;1星星&nbsp;10605天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">102级&nbsp;6太阳&nbsp;1月亮&nbsp;2星星&nbsp;10812天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">103级&nbsp;6太阳&nbsp;1月亮&nbsp;3星星&nbsp;11021天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">104级&nbsp;6太阳&nbsp;2月亮&nbsp;0星星&nbsp;11232天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">105级&nbsp;6太阳&nbsp;2月亮&nbsp;1星星&nbsp;11445天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">106级&nbsp;6太阳&nbsp;2月亮&nbsp;2星星&nbsp;11660天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">107级&nbsp;6太阳&nbsp;2月亮&nbsp;3星星&nbsp;11877天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">108级&nbsp;6太阳&nbsp;3月亮&nbsp;0星星&nbsp;12096天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">109级&nbsp;6太阳&nbsp;3月亮&nbsp;1星星&nbsp;12317天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">110级&nbsp;6太阳&nbsp;3月亮&nbsp;2星星&nbsp;12540天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">111级&nbsp;6太阳&nbsp;3月亮&nbsp;3星星&nbsp;12765天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">112级&nbsp;7太阳&nbsp;0月亮&nbsp;0星星&nbsp;12992天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">第八个太阳&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">113级&nbsp;7太阳&nbsp;0月亮&nbsp;1星星&nbsp;13221天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">114级&nbsp;7太阳&nbsp;0月亮&nbsp;2星星&nbsp;13452天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">115级&nbsp;7太阳&nbsp;0月亮&nbsp;3星星&nbsp;13685天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">116级&nbsp;7太阳&nbsp;1月亮&nbsp;0星星&nbsp;13920天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">117级&nbsp;7太阳&nbsp;1月亮&nbsp;1星星&nbsp;14157天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">118级&nbsp;7太阳&nbsp;1月亮&nbsp;2星星&nbsp;14396天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">119级&nbsp;7太阳&nbsp;1月亮&nbsp;3星星&nbsp;14637天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">120级&nbsp;7太阳&nbsp;2月亮&nbsp;0星星&nbsp;14880天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">121级&nbsp;7太阳&nbsp;2月亮&nbsp;1星星&nbsp;15125天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">122级&nbsp;7太阳&nbsp;2月亮&nbsp;2星星&nbsp;15372天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">123级&nbsp;7太阳&nbsp;2月亮&nbsp;3星星&nbsp;15621天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">124级&nbsp;7太阳&nbsp;3月亮&nbsp;0星星&nbsp;15872天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">125级&nbsp;7太阳&nbsp;3月亮&nbsp;1星星&nbsp;16125天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">126级&nbsp;7太阳&nbsp;3月亮&nbsp;2星星&nbsp;16380天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">127级&nbsp;7太阳&nbsp;3月亮&nbsp;3星星&nbsp;16637天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">128级&nbsp;8太阳&nbsp;0月亮&nbsp;0星星&nbsp;16896天&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">第九个太阳&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">129级&nbsp;8太阳&nbsp;0月亮&nbsp;1星星&nbsp;17157天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">130级&nbsp;8太阳&nbsp;0月亮&nbsp;2星星&nbsp;17420天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">131级&nbsp;8太阳&nbsp;0月亮&nbsp;3星星&nbsp;17685天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">132级&nbsp;8太阳&nbsp;1月亮&nbsp;0星星&nbsp;17952天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">133级&nbsp;8太阳&nbsp;1月亮&nbsp;1星星&nbsp;18221天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">134级&nbsp;8太阳&nbsp;1月亮&nbsp;2星星&nbsp;18492天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">135级&nbsp;8太阳&nbsp;1月亮&nbsp;3星星&nbsp;18765天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">136级&nbsp;8太阳&nbsp;2月亮&nbsp;0星星&nbsp;19040天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">137级&nbsp;8太阳&nbsp;2月亮&nbsp;1星星&nbsp;19317天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">138级&nbsp;8太阳&nbsp;2月亮&nbsp;2星星&nbsp;19596天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">139级&nbsp;8太阳&nbsp;2月亮&nbsp;3星星&nbsp;19877天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">140级&nbsp;8太阳&nbsp;3月亮&nbsp;0星星&nbsp;20160天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">141级&nbsp;8太阳&nbsp;3月亮&nbsp;1星星&nbsp;20445天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">142级&nbsp;8太阳&nbsp;3月亮&nbsp;2星星&nbsp;20732天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">143级&nbsp;8太阳&nbsp;3月亮&nbsp;3星星&nbsp;21021天&nbsp;&nbsp;</span><br style=\"background-color: rgb(255, 255, 255);\" />\r\n	<span style=\"background-color: rgb(255, 255, 255);\">144级&nbsp;9太阳&nbsp;0月亮&nbsp;0星星&nbsp;21312天</span></font></div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('577', '<p><span style=\"color: rgb(0, 0, 0); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline !important; float: none;\">使用struts+hibernate框架时，出现了以下错误：</span></p>\r\n<pre class=\"brush: java;\" name=\"code\">\r\norg.hibernate.PropertyAccessException: Null value was assigned to a property of primitive type setter of com.xxx.publish.entity.Site.isUse\r\n at org.hibernate.property.BasicPropertyAccessor$BasicSetter.set(BasicPropertyAccessor.java:109)\r\n at org.hibernate.tuple.entity.AbstractEntityTuplizer.setPropertyValues(AbstractEntityTuplizer.java:352)\r\n at org.hibernate.tuple.entity.PojoEntityTuplizer.setPropertyValues(PojoEntityTuplizer.java:232)\r\n at org.hibernate.persister.entity.AbstractEntityPersister.setPropertyValues(AbstractEntityPersister.java:3580)\r\n at org.hibernate.engine.TwoPhaseLoad.initializeEntity(TwoPhaseLoad.java:152)\r\n at org.hibernate.loader.Loader.initializeEntitiesAndCollections(Loader.java:877)\r\n at org.hibernate.loader.Loader.doQuery(Loader.java:752)\r\n at org.hibernate.loader.Loader.doQueryAndInitializeNonLazyCollections(Loader.java:259)\r\n at org.hibernate.loader.Loader.doList(Loader.java:2232)\r\n at org.hibernate.loader.Loader.listIgnoreQueryCache(Loader.java:2129)\r\n at org.hibernate.loader.Loader.list(Loader.java:2124)\r\n at org.hibernate.loader.criteria.CriteriaLoader.list(CriteriaLoader.java:118)\r\n\r\n</pre>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">该问题产生的原因是数据库中对应的字段值为NULL，这里我的数据库中is_use字段是null。</font></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">解决方案：</font></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">1、首先要将数据库中该字段为null 的记录设置默认值。避免程序出错。</font></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">2、数据库中设置使用默认值，当保存该字段没有值时，将默认值设置进来。</font></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">3、或者将javabean对象中对应的属性isUse由基本类型boolean修改为Boolean。</font></div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('578', '<p><font face=\"Simsun\" style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">使用hibernate的注解@ManyToOne时遇到错误：</font></p>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">Caused by: org.hibernate.MappingException:</span><span style=\"background-color: rgb(255, 255, 255); color: rgb(255, 0, 0); font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\"><span style=\"background-color: inherit;\">&nbsp;</span>Could not determine type for: com.xxx.entity.Site</span><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">, at table: channel, for columns: [org.hibernate.mapping.Column(site)]</span></font></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\"><font face=\"Simsun\" style=\"background-color: inherit;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">解决方案：注解要么写在字段上，要么写在getXX上，千万千万不能混合使用，否则会报这个错误！</span></font></span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">&nbsp; &nbsp; 对于一个实体类来说，要么所有的注解都写在字段上，要么都写在getXX上，不要有的写在字段上，有的写在getXX上。</font></div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('579', '<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: inherit; line-height: 1.5;\">场景描述：</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">2张表，班级表class_a，对应实体ClassBean，字段：id, name, location .</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">学生表student, 对应实体Student，字段：id, className, name, age.</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">学生表通过className和班级表的name关联。</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n<pre class=\"brush: java;\" name=\"code\">\r\npublic class ClassBean{\r\n    \r\n    @OneToMany(targetEntity=Student.class, cascade = CascadeType.ALL, fetch = FetchType.LAZY)\r\n    @JoinColumn(name=&quot;className&quot;,referencedColumnName=&quot;name&quot;)\r\n    public java.util.Set< student > getStudents() {\r\n      return students;\r\n    }\r\n}\r\n\r\npublic class Student() {\r\n}\r\n\r\n</pre>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">说明：</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">@JoinColumn注解中，name指的是连接表中的字段名，<span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">referencedColumnName指向本表字段名。</span></span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">若不指定<span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">referencedColumnName，默认是与本表主键关联。</span></span></span></div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('580', '<p>前台页面代码：</p>\r\n<p>&nbsp;</p>\r\n<pre class=\"brush: javascript;\" name=\"code\">\r\n<script>\r\n \r\n $(function() {\r\n     $(\"#sessionId\").val($.cookie(\"JSESSIONID\"));\r\n     $(\"#submit\").click(function () {\r\n            var options = {\r\n                url: \'guestbook.jspx\',\r\n                type: \'post\',\r\n                dataType: \'json\',\r\n                data: $(\"#guestbookForm\").serialize(),\r\n                success: function (data) {\r\n                 if(data.status==0) {\r\n                     alert(\"留言成功\");\r\n                     location.href=location.href;\r\n                 } else if(data.status==1) {\r\n                     alert(\"验证码错误\");\r\n                     $(\"#guestbookCaptcha\").click();\r\n                 }\r\n                }\r\n            };\r\n            $.ajax(options);\r\n            return false;\r\n        });\r\n    });\r\n \r\n</script>\r\n\r\n</pre>\r\n后台逻辑判断：\r\n<pre class=\"brush: java;\" name=\"code\">\r\n//CSRF验证\r\n  if(StringUtils.isBlank(sessionId)||!request.getSession().getId().equals(sessionId)){\r\n       response.sendRedirect(\"404.html\");\r\n  }\r\n</pre>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('581', '<p>老旧的G450就在W540旁边，为了安装系统不停的发出咔咔咔的声音，风扇发了疯似的转。此时此刻，想起多年前它陪我一起走过的时光，莫名感动一阵心酸。</p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('582', '<p><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">&ldquo;到底是谁占用了80端口,该怎么查,怎么终止它?&rdquo;,这里就简单讲解一下,在windows下如何查看80端口占用情况?是被哪个进程占用?如何终止等.</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">这里主要是用到windows下的DOS工具,点击&rdquo;开始&rdquo;&ndash;&rdquo;运行&rdquo;,输入&rdquo;cmd&rdquo;后点击确定按钮,进入DOS窗口,接下来分别运行以下命令:</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">&gt;netstat -aon | findstr &ldquo;80&Prime;</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">Proto&nbsp;&nbsp; Local Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Foreign Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; State&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PID</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">====&nbsp;&nbsp; ============&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ==============&nbsp;&nbsp; ==========&nbsp;&nbsp; ======</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">TCP&nbsp;&nbsp;&nbsp;&nbsp; 0.0.0.0:80&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.0.0.0:0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LISTENING&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1688</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">可以看出80端口被进程号为1688的程序占用.</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">&gt;tasklist | findstr &ldquo;1688&Prime;</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">图像名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 会话名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 会话#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 内存使用</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">========================= ====== ================ ======== ============</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">inetinfo.exe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1688&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Console&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2,800 K</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">很明显,是inetinfo占用了80端口;inetinfo.exe主要用于支持微软Windows IIS网络服务的除错,这个程序对你系统的正常运行是非常重要的.</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">当然,并不是只有inetinfo.exe进程会占用80端口,这只是我机器上的情况.如果你并不了解此进程是干什么用的,千万不要盲目地将其kill掉,最好先百度或Google搜索一下;当然如果你很了解它,并确定可以终止,那么继续下面的命令.</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">&gt;taskkill /pid 1688 /F</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">成功: 已终止 PID 为 1688 的进程。</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">如果你很熟悉此进程,并确定可以终止,那么就直接使用上面的命令把PID为1688的进程终止.(这一步同样可以在任务管理器中执行,inetinfo.exe就是任务管理器中的映像名称,选中它,点击&rdquo;结束进程&rdquo;即可)</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">&gt;tasklist | findstr &ldquo;1688&Prime;</span><br style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 宋体, Verdana, sans-serif;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">再次确认是否成功终止,如果成功终止此次执行命令后应返回空.</span><span style=\"background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: \'sans serif\', tahoma, verdana, helvetica; text-align: justify;\">​</span></p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('583', '<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Helvetica, Tahoma, Arial, sans-serif;\"><span style=\"background-color: inherit; font-size: 10.5pt;\">@PathVariable用于将请求URL中的模板变量映射到功能处理方法的参数上。</span></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Helvetica, Tahoma, Arial, sans-serif;\">&nbsp;</p>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Monaco, \'DejaVu Sans Mono\', \'Bitstream Vera Sans Mono\', Consolas, \'Courier New\', monospace; font-size: 12px;\">\r\n	<div style=\"background-color: inherit; font-weight: bold;\">Java代码&nbsp;</div>\r\n	<ol start=\"1\" style=\"margin-top: 0px; margin-bottom: 0px; background-color: rgb(255, 255, 255); color: rgb(43, 145, 175); font-size: 1em;\">\r\n		<li style=\"background-color: rgb(250, 250, 250); font-size: 1em;\">\r\n			<span style=\"background-color: inherit; color: black;\"><span style=\"background-color: inherit; color: rgb(100, 100, 100);\">@RequestMapping</span>(value=<span style=\"background-color: inherit; color: blue;\">&quot;/users/{userId}/topics/{topicId}&quot;</span>)&nbsp;&nbsp;</span></li>\r\n		<li style=\"background-color: rgb(250, 250, 250); font-size: 1em;\">\r\n			<span style=\"background-color: inherit; color: black;\"><span style=\"background-color: inherit; color: rgb(127, 0, 85); font-weight: bold;\">public</span>&nbsp;String&nbsp;test(&nbsp;&nbsp;</span></li>\r\n		<li style=\"background-color: rgb(250, 250, 250); font-size: 1em;\">\r\n			<span style=\"background-color: inherit; color: black;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"background-color: inherit; color: rgb(100, 100, 100);\">@PathVariable</span>(value=<span style=\"background-color: inherit; color: blue;\">&quot;userId&quot;</span>)&nbsp;<span style=\"background-color: inherit; color: rgb(127, 0, 85); font-weight: bold;\">int</span>&nbsp;userId,&nbsp;&nbsp;&nbsp;</span></li>\r\n		<li style=\"background-color: rgb(250, 250, 250); font-size: 1em;\">\r\n			<span style=\"background-color: inherit; color: black;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"background-color: inherit; color: rgb(100, 100, 100);\">@PathVariable</span>(value=<span style=\"background-color: inherit; color: blue;\">&quot;topicId&quot;</span>)&nbsp;<span style=\"background-color: inherit; color: rgb(127, 0, 85); font-weight: bold;\">int</span>&nbsp;topicId)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>\r\n	</ol>\r\n</div>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: Helvetica, Tahoma, Arial, sans-serif;\">&nbsp;<span style=\"background-color: inherit; font-size: 10.5pt;\">如请求的</span><span style=\"background-color: inherit; font-size: 10.5pt;\">URL为&ldquo;控制器URL/users/123/topics/456&rdquo;，则自动将URL中模板变量{userId}和{topicId}绑定到通过@PathVariable注解的同名参数上，即入参后userId=123、topicId=456。代码在PathVariableTypeController中。</span></p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('584', '<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">在spring mvc+hibernate环境下出现了以下错误：</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">\r\n	<ol start=\"1\" style=\"margin-top: 0px; margin-bottom: 0px; background-color: rgb(255, 255, 255); color: rgb(43, 145, 175); font-family: Monaco, \'DejaVu Sans Mono\', \'Bitstream Vera Sans Mono\', Consolas, \'Courier New\', monospace; font-size: 12px;\">\r\n		<li style=\"background-color: rgb(250, 250, 250); font-size: 1em;\">\r\n			<span style=\"background-color: inherit; color: black;\">org.hibernate.HibernateException:&nbsp;No&nbsp;Hibernate&nbsp;Session&nbsp;bound&nbsp;to&nbsp;thread,&nbsp;and&nbsp;configuration&nbsp;does&nbsp;not&nbsp;allow&nbsp;creation&nbsp;of&nbsp;non-transactional&nbsp;one&nbsp;here&nbsp;&nbsp;</span></li>\r\n		<li style=\"background-color: rgb(250, 250, 250); font-size: 1em;\">\r\n			<span style=\"background-color: inherit; color: black;\">&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.springframework.orm.hibernate3.SpringSessionContext.currentSession(SpringSessionContext.java:<span style=\"background-color: inherit; color: rgb(192, 0, 0);\">63</span>)&nbsp;&nbsp;</span></li>\r\n		<li style=\"background-color: rgb(250, 250, 250); font-size: 1em;\">\r\n			<span style=\"background-color: inherit; color: black;\">&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.hibernate.impl.SessionFactoryImpl.getCurrentSession(SessionFactoryImpl.java:<span style=\"background-color: inherit; color: rgb(192, 0, 0);\">622</span>)&nbsp;&nbsp;</span></li>\r\n		<li style=\"background-color: rgb(250, 250, 250); font-size: 1em;\">\r\n			<span style=\"background-color: inherit; color: black;\">&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;com.ligang.modules.orm.hibernate.SimpleHibernateDao.getSession(SimpleHibernateDao.java:<span style=\"background-color: inherit; color: rgb(192, 0, 0);\">101</span>)&nbsp;&nbsp;</span></li>\r\n		<li style=\"background-color: rgb(250, 250, 250); font-size: 1em;\">\r\n			<span style=\"background-color: inherit; color: black;\">&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;com.ligang.modules.orm.hibernate.SimpleHibernateDao.createCriteria(SimpleHibernateDao.java:<span style=\"background-color: inherit; color: rgb(192, 0, 0);\">322</span>)&nbsp;&nbsp;</span></li>\r\n		<li style=\"background-color: rgb(250, 250, 250); font-size: 1em;\">\r\n			<span style=\"background-color: inherit; color: black;\">&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;com.ligang.modules.orm.hibernate.HibernateDao.findPage(HibernateDao.java:<span style=\"background-color: inherit; color: rgb(192, 0, 0);\">144</span>) &nbsp;</span></li>\r\n	</ol>\r\n</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">网上普遍的解决方案如下：</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(50, 62, 50); font-family: Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">opensession是从sessionfactory得到一个新的session，所以可以使用，而getCurrentSession是从当前线程 中得到事务开始时创建transaction的那个session，而你的事务没有能正确的启动，所以并没有一个session绑定到当前线程，所以你也 得不到。</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">大部分解决方案也是基于上面的思路：</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">1、简称sessionfactory配置是否正确</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">2、transactionManager是否配置且已经生效。</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">3、在对应的service或者dao类或者方法上添加@Transactional注解。</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">我仔细检查了一下自己项目中的配置：</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">全部采用注解的方式</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&lt;!--&nbsp;使用annotation&nbsp;自动注册bean,并保证@<a href=\"mailto:Required,@Autowired\" style=\"background-color: inherit; cursor: pointer;\">Required,@Autowired</a>的属性被注入&nbsp;--&gt;<br style=\"background-color: inherit;\" />\r\n	&lt;context:component-scan&nbsp;base-package=&quot;com.myproject.web&quot;&nbsp;/&gt;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&lt;!-- 事务管理器配置,单数据源事务 --&gt;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;&lt;bean id=&quot;transactionManager&quot;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp; class=&quot;org.springframework.orm.hibernate3.HibernateTransactionManager&quot;&gt;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp; &lt;property name=&quot;sessionFactory&quot; ref=&quot;sessionFactory&quot; /&gt;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;&lt;/bean&gt;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;&lt;!-- 使用annotation定义事务 --&gt;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;&lt;tx:annotation-driven transaction-manager=&quot;transactionManager&quot;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp; proxy-target-class=&quot;true&quot; /&gt;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">目测上述配置没有问题，且在DAO层添加了<span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">@Transactional注解。</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">------------------------------------------------------------------------------------------------------------</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">想到是不是spring自定义视图解析器时，hibernate 的session已经关闭的问题。</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">或许是因为session已经关闭才导致了上面获取不到？</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">检查一下web.xml文件，已经配置了org.springframework.orm.hibernate3.support.OpenSessionInViewFilter</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">但是该过滤器定义的只是拦截*.do请求。而我的请求地址是：<a href=\"http://localhsot:8080/porject/index.shtml\" style=\"background-color: inherit; cursor: pointer;\">http://localhsot:8080/porject/index.shtml</a></span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">也就是说我的这个请求并没有被<span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">OpenSessionInViewFilter过滤器拦截到。</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">增加一个拦截匹配：</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">&lt;filter-mapping&gt;</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">&nbsp; &nbsp; &lt;filter-name&gt;hibernateOpenSessionInViewFilter&lt;/filter-name&gt;</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">&nbsp; &nbsp; &lt;url-pattern&gt;*.shtml&lt;/url-pattern&gt;</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">&nbsp; &lt;/filter-mapping&gt;</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">完成上述配置后，重启，测试通过。</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">可能别人碰到的问题和我的情况不一样，仅仅提供一种可以解决的方案。也有人说尽量不让使用<span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-weight: normal; text-align: left;\">OpenSessionInViewFilter，看个人选择吧。</span></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('585', '<p><span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">1、复制表结构及数据到新表</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">CREATE TABLE 新表SELECT * FROM 旧表</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">这种方法会将oldtable中所有的内容都拷贝过来，当然我们可以用delete from newtable;来删除。</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">不过这种方法的一个最不好的地方就是新表中没有了旧表的primary key、Extra（auto_increment）等属性。需要自己用&amp;quot;alter&amp;quot;添加，而且容易搞错。</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">&nbsp;</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">2、只复制表结构到新表</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">CREATE TABLE 新表SELECT * FROM 旧表WHERE 1=2</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">或CREATE TABLE 新表LIKE 旧表</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">&nbsp;</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">3、复制旧表的数据到新表(假设两个表结构一样)</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">INSERT INTO 新表SELECT * FROM 旧表</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">&nbsp;</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">4、复制旧表的数据到新表(假设两个表结构不一样)</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">INSERT INTO 新表(字段1,字段2,.......) SELECT 字段1,字段2,...... FROM 旧表</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">&nbsp;</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">5、可以将表1结构复制到表2</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">SELECT * INTO 表2 FROM 表1 WHERE 1=2</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">&nbsp;</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">6、可以将表1内容全部复制到表2</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">SELECT * INTO 表2 FROM 表1</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">&nbsp;</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">7、 show create table 旧表;</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">这样会将旧表的创建命令列出。我们只需要将该命令拷贝出来，更改table的名字，就可以建立一个完全一样的表</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">&nbsp;</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">8、dump</span><br style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\" />\r\n	<span style=\"background-color: rgb(255, 255, 255); font-family: Simsun; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(42, 42, 42); line-height: 1.7857142857142858;\">用mysqldump将表dump出来，改名字后再导回去或者直接在命令行中运行</span></p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('586', '<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); line-height: 1.8571428571428572;\"><font face=\"Simsun\" style=\"background-color: inherit;\">cascade几种取值：</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); line-height: 1.8571428571428572;\"><font face=\"Simsun\" style=\"background-color: inherit;\">save-update:&nbsp;&nbsp; 级联保存(load以后如果子对象发生了更新,也会级联更新). 但它不会级联删除</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); line-height: 1.8571428571428572;\"><font face=\"Simsun\" style=\"background-color: inherit;\">delete:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 级联删除, 但不具备级联保存和更新</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); line-height: 1.8571428571428572;\"><font face=\"Simsun\" style=\"background-color: inherit;\">all-delete-orphan: 在解除父子关系时,自动删除不属于父对象的子对象, 也支持级联删除和级联保存更新.</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); line-height: 1.8571428571428572;\"><font face=\"Simsun\" style=\"background-color: inherit;\">all:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;级联删除, 级联更新,但解除父子关系时不会自动删除子对象.</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); line-height: 1.8571428571428572;\"><font face=\"Simsun\" style=\"background-color: inherit;\">delete-orphan:删除所有和当前对象解除关联关系的对象</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); line-height: 1.8571428571428572;\"><font face=\"Simsun\" style=\"background-color: inherit;\">none:...</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); line-height: 1.8571428571428572;\"><font face=\"Simsun\" style=\"background-color: inherit;\">级联保存和级联更新总是集合在一起的, 所以没单独的save 或 update</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); line-height: 1.8571428571428572;\"><font face=\"Simsun\" style=\"background-color: inherit;\">我通常会用到none,save-update,all-delete-orphan,而且还是在一对多和多对多的情况</font></p>\r\n<ol style=\"margin-top: 0px; margin-bottom: 0px; background-color: rgb(255, 255, 255); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); line-height: 1.8571428571428572;\">\r\n	<li style=\"background-color: inherit; font-size: 1em;\">\r\n		<font face=\"Simsun\" style=\"background-color: inherit;\">none就不用说了，在保存，更新，删除当前对象时，忽略其关联的对象</font></li>\r\n	<li style=\"background-color: inherit; font-size: 1em;\">\r\n		<font face=\"Simsun\" style=\"background-color: inherit;\">save-update：在保存和更新当前对象的时候，级联保存，更新关联对象，在多对多的情况下用的很多，而且一般&nbsp;&nbsp;&nbsp; 不用于一对多，一对多我通常会采用none或者all-delete-orphan</font></li>\r\n	<li style=\"background-color: inherit; font-size: 1em;\">\r\n		<font face=\"Simsun\" style=\"background-color: inherit;\">delete 删除当前对象,级联删除关联的对象,我从来单独没用过</font></li>\r\n	<li style=\"background-color: inherit; font-size: 1em;\">\r\n		<font face=\"Simsun\" style=\"background-color: inherit;\">all 也就是save-update+delete,另外对当前对象执行evict和lock时对关联对象也执行evict和lock,我从来没单独用过</font></li>\r\n	<li style=\"background-color: inherit; font-size: 1em;\">\r\n		<font face=\"Simsun\" style=\"background-color: inherit;\">delete-orphan 删除所以和当前对象解除关联的对象,我从来没单独用过</font></li>\r\n	<li style=\"background-color: inherit; font-size: 1em;\">\r\n		<font face=\"Simsun\" style=\"background-color: inherit;\">all-delete-orphan 也就是all+delete-orphan,根据需求,我在一对多中经常使用</font></li>\r\n</ol>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('587', '<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">错误信息截取：</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">Heap</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;def new generation &nbsp; total 157376K, used 18353K [0x04520000, 0x0efe0000, 0x19a70000)</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp; eden space 139904K, &nbsp;13% used [0x04520000, 0x0570c410, 0x0cdc0000)</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp; from space 17472K, &nbsp; 0% used [0x0cdc0000, 0x0cdc0000, 0x0ded0000)</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp; to &nbsp; space 17472K, &nbsp; 0% used [0x0ded0000, 0x0ded0000, 0x0efe0000)</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;tenured generation &nbsp; total 349568K, used 10088K [0x19a70000, 0x2efd0000, 0x44520000)</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp; &nbsp;the space 349568K, &nbsp; 2% used [0x19a70000, 0x1a44a2a8, 0x1a44a400, 0x2efd0000)</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;compacting perm gen &nbsp;total 21760K, used 21740K [0x44520000, 0x45a60000, 0x48520000)</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp; &nbsp;the space 21760K, &nbsp;99% used [0x44520000, 0x45a5b118, 0x45a5b200, 0x45a60000)</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">No shared spaces configured.</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">出现上述问题系统提示访问<a href=\"http://java.sun.com/webapps/bugreport/crash.jsp\" style=\"background-color: inherit; cursor: pointer; line-height: 1.5;\">http://java.sun.com/webapps/bugreport/crash.jsp</a>。</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">网上不少建议是修改系统jvm参数，提高heap内存空间等等。参考建议修改后，还是同样的问题。</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">错误日志中有：</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">Environment Variables:</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">JAVA_HOME=D:\\Program Files (x86)\\Java\\jdk1.6.0_45</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">CLASSPATH=.;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">PATH=D:/Program Files (x86)/MyEclipse/binary/com.sun.java.jdk.win32.x86_1.6.0.013/jre/bin/client;D:/Program Files (x86)/MyEclipse/binary/com.sun.java.jdk.win32.x86_1.6.0.013/jre/bin;D:\\Program Files (x86)\\Java\\jdk1.6.0_45\\bin;C:\\Windows\\system32;C:\\Windows;C:\\Windows\\System32\\Wbem;C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\;D:\\Program Files (x86)\\Microsoft SQL Server\\100\\Tools\\Binn\\;D:\\Program Files (x86)\\Microsoft SQL Server\\100\\DTS\\Binn\\;D:\\Program Files (x86)\\Microsoft SQL Server\\100\\Tools\\Binn\\VSShell\\Common7\\IDE\\;C:\\Program Files (x86)\\Microsoft Visual Studio 9.0\\Common7\\IDE\\PrivateAssemblies\\;C:\\Program Files\\Microsoft SQL Server\\100\\Tools\\Binn\\;C:\\Program Files\\Microsoft SQL Server\\100\\DTS\\Binn\\</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">USERNAME=fujm</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">OS=Windows_NT</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">PROCESSOR_IDENTIFIER=Intel64 Family 6 Model 23 Stepping 10, GenuineIntel。</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">参见PATH中，使用的是MyEclipse自带的jre环境，从这里下手调整，使用系统自己安装的JDK，即JAVA_HOME中配置的地址。</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">在MyEclipse--Window---Preferences---servers---tomcat---tomcat6---JDK中选择：</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><span style=\"color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline !important; float: none;\">再次启动tomcat，问题解决。</span></div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('588', '<p>下面的链接为JDK6各种版本的下载地址，当前测试可用，2015-04-01.</p>\r\n<p><a href=\"http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-javase6-419409.html#jdk-6u25-oth-JPR\" style=\"background-color: rgb(255, 255, 255); cursor: pointer; font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-javase6-419409.html#jdk-6u25-oth-JPR</a></p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('589', '<pre name=\"code\" class=\"brush: javascript;\">\r\n$.ajax({\r\n         type: \"GET\",\r\n         url: \"test.json\",\r\n         data: {username:$(\"#username\").val(), content:$(\"#content\").val()},\r\n         dataType: \"json\",\r\n         success: function(data){     \r\n         }\r\n });\r\n</pre>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('590', '<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">用户的解决方案：浏览器进行设置。</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">编程的解决方案：</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n<pre name=\"code\" class=\"brush: java;\">\r\nInputStream fis = null;\r\n     \r\n      try {\r\n       File file = new File(path);\r\n       \r\n       if(file.exists()) {\r\n        fis = new BufferedInputStream(new FileInputStream(path));\r\n        byte[] buffer = new byte[fis.available()];\r\n        fis.read(buffer);\r\n        fis.close();\r\n        // 清空response\r\n        response.reset();\r\n        // 设置response的Header\r\n        response.addHeader(\"Content-Disposition\", \"attachment;filename=\" + new String(FilenameUtils.getName(path).getBytes()));\r\n        response.addHeader(\"Content-Length\", \"\" + file.length());\r\n        OutputStream toClient = new BufferedOutputStream(response.getOutputStream());\r\n        response.setContentType(\"application/octet-stream\");\r\n        toClient.write(buffer);\r\n        toClient.flush();\r\n        toClient.close();\r\n       }\r\n       \r\n      } catch (Exception e) {\r\n       e.printStackTrace();\r\n      } finally {\r\n       if(fis != null) {\r\n        fis.close();\r\n       }\r\n      }\r\n</pre>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('591', '<pre style=\"font-family: arial, \'courier new\', courier, 宋体, monospace; font-style: normal; background-color: rgb(241, 254, 221); font-size: 14px; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51);\">\r\n1级 1\r\n2   5 \r\n3   15\r\n4   30\r\n5   50\r\n6   100\r\n7   200\r\n8   500\r\n9   1000\r\n10  2000 \r\n11  3000\r\n12  6000\r\n13  10000\r\n14  18000\r\n15  30000\r\n16  60000 \r\n17  100000\r\n18  300000</pre>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('592', '<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\"><strong style=\"background-color: inherit;\">Java程序员</strong></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　高级特性</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　反射、泛型、注释符、自动装箱和拆箱、枚举类、可变</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　参数、可变返回类型、增强循环、静态导入</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　核心编程</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　IO、多线程、实体类、</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　集合类、正则表达式、</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　XML和属性文件</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　图形编程</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　AWT(Java2D/JavaSound/JMF)、Swing、SWT、JFace</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　网路编程</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Applet、Socket/TCP/UDP、NIO、RMI、CORBA</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Java语法基础</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　类、抽象类、接口、最终类、静态类、匿名类、内部类、异常类、编码规范</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Java开发环境</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JDK、JVM、Eclipse、Linux</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Java核心编程技术</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Java，设计而又非常精巧的语言。学习Java，须从Java开发环境开始，到Java语法，再到Java的核心API。</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　1.Java开发入门：Java开发环境的安装与使用，包括JDK命令、EclipseIDE、Linux下Java程序的开发和部署等。</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　2.Java语法基础：基于JDK和Eclipse环境，进行Java核心功能开发，掌握Java面向对象的语法构成，包括类、抽象类、接口、最终类、静态类、匿名类、内部类、异常的编写。</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　3.Java核心API：基于JDK提供的类库，掌握三大核心功能：</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　A。Java核心编程:包括Java编程的两大核心功能&mdash;&mdash;Java输入/输出流和多线程，以及常用的辅助类库&mdash;&mdash;实体类、集合类、正则表达式、XML和属性文件。</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　B。Java图形编程：包括Sun的GUI库AWT(Java2D、JavaSound、JMF)和Swing，IBM和GUI库SWT和Jface;</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　C. Java网路编程：Applet组件编程，Socket编程，NIO非阻塞Socket编程、RMI和CORBA分布式开发。</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　4.Java高级特性：掌握JDK1.4、JDK5.0、JDK6.0中的Java高级特性，包括反射、泛型、注释，以及java高级特性&mdash;&mdash;自动装箱和拆箱、枚举类、可变参数、可变返回类型、增强循环、静态导入等。</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\"><strong style=\"background-color: inherit;\">JavaEE初级软件工程师</strong></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JSF框架开发技术</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　配置文件(页面导航、后台Bean)、JSF组件库(JSF EL语言、HTML标签、事件处理、)、JSF核心库(格式转换、输入验证、国际化)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Javaweb核心开发技术</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　开发环境(Eclipse、Linux)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　三大组件(JSP、JavaBean、Servlet)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　扩展技术(EL、JSTL、Taglib)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　网页开发技术</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　HTML、XML、CSS、JavaScript、AJAX</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　数据库设计技术</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　SQL、MySql、Oracle、SQLServer、JDBC</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Web服务器(Tomcat/Jetty/Resin/JBossWeb)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JavaWeb核心技术：</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JavaWeb项目开发的全过程可以分解为：</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　网页开发+数据库设计&mdash;&mdash;&gt;JavaWeb项目开发，其中，javaWeb由6项基本技术组成：JSP+JavaBean+Servlet+EL+JSTL+Taglib，而JSF正是将这6种技术进行有机结合的技术框架：</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\"><strong style=\"background-color: inherit;\">JavaEE中级软件工程师</strong></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　四种经典架构SSH1、SSI1、SSH2、SSI2</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Struts1表现层框架</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　入门配置、核心组件、标签库、国际化、数据检验、数据库开发、Sitemesh集成、集成Hibernate/iBATIS</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Struts2表现层框架</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　入门配置、核心组件、标签库、国际化、数据校验、Sitemesh集成转换器、拦截器、集成Hibernate/iBATIS</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Spring业务层框架</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　入门配置、IoC容器、MVC、标签库、国际化、数据校验、数据库开发</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Hibernate持久层框架</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　MySQL、Oracle、SQLServer iBATIS持久层框架</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　MySQL、Oracle、SQLServer</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Web服务器(Tomcat/Jetty/Resin/JBossWeb)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\"><strong style=\"background-color: inherit;\">Java高级软件工程师</strong></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　javaWeb开源技术与框架</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　工作流、</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　规则引擎</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　搜索引擎、</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　缓存引擎 、</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　任务调度、</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　身份认证</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　报表服务、</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　系统测试、</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　集群、</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　负载平衡、</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　故障转移</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JavaWeb分布式开发技术</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JTA(Java事物管理)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JAAS(Java验证和授权服务)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JNDI(Java命名和目录服务)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JavaMail(Java邮件服务)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JMS(java信息服务)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　WebService(web服务)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JCA(java连接体系)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　JMS(java管理体系)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　应用服务器(JBossAS/WebLogic/WebSphere)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\"><strong style=\"background-color: inherit;\">JavaEE系统架构师</strong></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　面向云架构(COA)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　COA、SaaS、网格计算、集群计算、分布式计算、云计算</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　面向资源架构(ROA)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　ROA、RESI</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　面向web服务架构(SOA)</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　WebService、SOA、SCA、ESB、OSGI、EAI</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Java设计模式</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　创建式模式：抽象工厂/建造者/工厂方法/原型/单例</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　构造型模式：适配器/桥接/组合/装饰/外观/享元/代理</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　行为型模式：责任链/命令/解释器/迭代子/中介者/备忘录/观察者/状态/策略/模板方法/访问者</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　Java与UML建模</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　对象图、用例图、组件图、部署图、序列图、交互图、活动图、正向工程与逆向工程</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\"><strong style=\"background-color: inherit;\">CTO首席技术官</strong></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　发展战略</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　技术总监</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　团队提升</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　团队建设</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　项目管理</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　产品管理</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Verdana, sans-serif, 宋体; font-size: 13px;\">　　一般情况下，java的发展路线是这样的，当然，具体情况因人而异。比如，有的可能后来转入产品职位或其他职位了。另外，每个企业里面java从业人员的title是不同的。比如，有的企业有CTO，而有的企业则只有技术经理或技术主任等，叫法不同，但本质和所需掌握的技术大致相同。</p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('593', '<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">在MyEclipse下编辑文件保存时，编译java工程，出现以下弹出提示。每次保存都会弹出，不堪其扰。</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">&ldquo;<span style=\"background-color: inherit; color: rgb(51, 51, 51); font-size: 14px; text-align: left;\">Errors occurred during the build.</span><span style=\"background-color: inherit; color: rgb(51, 51, 51); font-size: 14px; text-align: left;\">&nbsp;</span></font></p>\r\n<div style=\"background-color: rgb(255, 255, 255); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(51, 51, 51);\"><font face=\"Simsun\" style=\"background-color: inherit;\">Errors running builder &#39;JavaScript Validator&#39; on project &#39;......&#39;.&nbsp;</font></div>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\"><span style=\"background-color: inherit; color: rgb(51, 51, 51); font-size: 14px; text-align: left;\">java.lang.NullPointerException&nbsp;</span>&rdquo;</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">很明显可以看到是由于javascript校验出现了系统错误。一开始想到的是通过修改在window==&gt;preferences==&gt;validation中禁用对于的javascript validator，不起效果。</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">其实在每个项目中，也有类似的配置的地方。</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">所以解决的方案为：</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><font face=\"Simsun\" style=\"background-color: inherit;\">右键当前项目==》properties==》builders==》取消选中对于的javascript validator即可。</font></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><img alt=\"\" src=\"/fengling/u/cms/blog/201504/02220126w4yu.png\" style=\"width: 635px; height: 560px;\" /></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('594', '<p><span style=\"color: rgb(54, 46, 43); font-family: Arial; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline !important; float: none;\">最近经常遇myEclipse以debug方式启动tomcat的错误提示如下：</span></p>\r\n<p><img alt=\"\" src=\"/fengling/u/cms/blog/201504/02220434rrl2.png\" style=\"width: 532px; height: 168px;\" /></p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(54, 46, 43); font-family: Arial;\">直接run方式启动没有问题。</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(54, 46, 43); font-family: Arial;\">&nbsp;</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(54, 46, 43); font-family: Arial;\">一般这个问题等一会就不再出现，如果有耐心的话，就等几分钟再启动。如果没有耐心，可以试试下面的两个办法。</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(54, 46, 43); font-family: Arial;\">&nbsp;</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(54, 46, 43); font-family: Arial;\">解决办法一:</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(54, 46, 43); font-family: Arial;\">在win下使用&nbsp;netsh winsock reset 可以解决此问题</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(54, 46, 43); font-family: Arial;\">&nbsp;</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(54, 46, 43); font-family: Arial;\">解决办法二：</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(54, 46, 43); font-family: Arial;\">用360安全卫士里面的修复网络功能修复了一下。</p>\r\n<p style=\"margin: 5px 0px; background-color: rgb(255, 255, 255); font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; color: rgb(54, 46, 43); font-family: Arial;\"><img alt=\"\" src=\"/fengling/u/cms/blog/201504/02220434vdq5.png\" style=\"width: 900px; height: 600px;\" /></p>\r\n<p>&nbsp;</p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('595', '<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">1. 查看你的Eclipse中使用的是什么SVN Interface</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; margin-left: 40px;\">windows &gt; preference &gt; Team &gt; SVN #SVN Interface</div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\"><img alt=\"\" src=\"/fengling/u/cms/blog/201504/02220751well.png\" style=\"width: 635px; height: 772px;\" /></div>\r\n<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">\r\n	<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">2. 如果是用的JavaHL, 找到以下目录并删除auth目录.</div>\r\n	<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; margin-left: 40px;\">[Windows] C:\\Documents and Settings\\[YourUserName]\\Application Data\\Subversion\\</div>\r\n	<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; margin-left: 40px;\">[Linux] /home/[YourUserName]/.subversion/auth</div>\r\n	<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n	<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">3. 如果你用的SVNKit, 找到以下目录并删除.keyring文件.</div>\r\n	<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; margin-left: 40px;\">[eclipse安装路径]\\configuration\\org.eclipse.core.runtime</div>\r\n	<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">&nbsp;</div>\r\n	<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">4.重新通过Subclipse访问svn，输入新的帐号即可。</div>\r\n	<div style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 宋体; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 21px; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; margin-left: 40px;\">window-&gt;show view-&gt;other...-&gt;svn/svn资源库 在svn资源库中，右击**，取消，到弹出对话框提示输入用户名密码为止。</div>\r\n</div>\r\n<p>&nbsp;</p>\r\n', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('596', '<p>参见下面的示例代码：</p>\r\n<p>&nbsp;</p>\r\n<pre name=\"code\" class=\"brush: javascript;\">\r\n<script type=\"text/javascript\">\r\n  $().ready(function() {\r\n   window.scroll(0,300);\r\n  });\r\n </script>\r\n</pre>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('597', '<p>语法规则： location [=|~|~*|^~] /uri/ { &amp;hellip; }</p><p>&nbsp;</p><p>= 开头表示精确匹配</p><p>^~ 开头表示uri以某个常规字符串开头，理解为匹配 url路径即可。nginx不对url做编码，因此请求为/static/20%/aa，可以被规则^~ /static/ /aa匹配到（注意是空格）。</p><p>~ 开头表示区分大小写的正则匹配</p><p>~* 开头表示不区分大小写的正则匹配</p><p>!~和!~*分别为区分大小写不匹配及不区分大小写不匹配 的正则</p><p>/ 通用匹配，任何请求都会匹配到。</p><p>多个location配置的情况下匹配顺序为（参考资料而来，还未实际验证，试试就知道了，不必拘泥，仅供参考）:</p><p>首先匹配 =，其次匹配^~, 其次是按文件中顺序的正则匹配，最后是交给 / 通用匹配。当有匹配成功时候，停止匹配，按当前匹配规则处理请求。</p><p>例子，有如下匹配规则：</p><p>location = / {</p><p>&nbsp; &nbsp;#规则A</p><p>}</p><p>location = /login {</p><p>&nbsp; &nbsp;#规则B</p><p>}</p><p>location ^~ /static/ {</p><p>&nbsp; &nbsp;#规则C</p><p>}</p><p>location ~ \\.(gif|jpg|png|js|css)$ {</p><p>&nbsp; &nbsp;#规则D</p><p>}</p><p>location ~* \\.png$ {</p><p>&nbsp; &nbsp;#规则E</p><p>}</p><p>location !~ \\.xhtml$ {</p><p>&nbsp; &nbsp;#规则F</p><p>}</p><p>location !~* \\.xhtml$ {</p><p>&nbsp; &nbsp;#规则G</p><p>}</p><p>location / {</p><p>&nbsp; &nbsp;#规则H</p><p>}</p><p>那么产生的效果如下：</p><p>访问根目录/， 比如http://localhost/ 将匹配规则A</p><p>访问 http://localhost/login 将匹配规则B，http://localhost/register 则匹配规则H</p><p>访问 http://localhost/static/a.html 将匹配规则C</p><p>访问 http://localhost/a.gif, http://localhost/b.jpg 将匹配规则D和规则E，但是规则D顺序优先，规则E不起作用，而 http://localhost/static/c.png 则优先匹配到规则C</p><p>访问 http://localhost/a.PNG 则匹配规则E，而不会匹配规则D，因为规则E不区分大小写。</p><p>访问 http://localhost/a.xhtml 不会匹配规则F和规则G，http://localhost/a.XHTML不会匹配规则G，因为不区分大小写。规则F，规则G属于排除法，符合匹配规则但是不会匹配到，所以想想看实际应用中哪里会用到。</p><p>访问 http://localhost/category/id/1111 则最终匹配到规则H，因为以上规则都不匹配，这个时候应该是nginx转发请求给后端应用服务器，比如FastCGI（php），tomcat（jsp），nginx作为方向代理服务器存在。</p><p>&nbsp;</p><p>所以实际使用中，个人觉得至少有三个匹配规则定义，如下：</p><p>#直接匹配网站根，通过域名访问网站首页比较频繁，使用这个会加速处理，官网如是说。</p><p>#这里是直接转发给后端应用服务器了，也可以是一个静态首页</p><p># 第一个必选规则</p><p>location = / {</p><p>&nbsp; &nbsp; proxy_pass http://tomcat:8080/index</p><p>}</p><p># 第二个必选规则是处理静态文件请求，这是nginx作为http服务器的强项</p><p># 有两种配置模式，目录匹配或后缀匹配,任选其一或搭配使用</p><p>location ^~ /static/ {</p><p>&nbsp; &nbsp; root /webroot/static/;</p><p>}</p><p>location ~* \\.(gif|jpg|jpeg|png|css|js|ico)$ {</p><p>&nbsp; &nbsp; root /webroot/res/;</p><p>}</p><p>#第三个规则就是通用规则，用来转发动态请求到后端应用服务器</p><p>#非静态文件请求就默认是动态请求，自己根据实际把握</p><p>#毕竟目前的一些框架的流行，带.php,.jsp后缀的情况很少了</p><p>location / {</p><p>&nbsp; &nbsp; proxy_pass http://tomcat:8080/</p><p>}</p>', null, null, null);

-- ----------------------------
-- Table structure for `jc_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_type`;
CREATE TABLE `jc_content_type` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(20) NOT NULL COMMENT '名称',
  `img_width` int(11) DEFAULT NULL COMMENT '图片宽',
  `img_height` int(11) DEFAULT NULL COMMENT '图片高',
  `has_image` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有图片',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容类型表';

-- ----------------------------
-- Records of jc_content_type
-- ----------------------------
INSERT INTO `jc_content_type` VALUES ('1', '普通', '100', '100', '0', '0');
INSERT INTO `jc_content_type` VALUES ('2', '图文', '143', '98', '1', '0');
INSERT INTO `jc_content_type` VALUES ('3', '焦点', '280', '200', '1', '0');
INSERT INTO `jc_content_type` VALUES ('4', '头条', '0', '0', '0', '0');
INSERT INTO `jc_content_type` VALUES ('5', '微博', '139', '139', '0', '0');

-- ----------------------------
-- Table structure for `jc_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `jc_dictionary`;
CREATE TABLE `jc_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'name',
  `value` varchar(255) NOT NULL COMMENT 'value',
  `type` varchar(255) NOT NULL COMMENT 'type',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Records of jc_dictionary
-- ----------------------------
INSERT INTO `jc_dictionary` VALUES ('1', '10-20人', '10-20人', 'scale');
INSERT INTO `jc_dictionary` VALUES ('2', '20-50人', '20-50人', 'scale');
INSERT INTO `jc_dictionary` VALUES ('3', '50-10人', '50-10人', 'scale');
INSERT INTO `jc_dictionary` VALUES ('4', '100人以上', '100人以上', 'scale');
INSERT INTO `jc_dictionary` VALUES ('5', '私企', '私企', 'nature');
INSERT INTO `jc_dictionary` VALUES ('6', '股份制', '股份制', 'nature');
INSERT INTO `jc_dictionary` VALUES ('7', '国企', '国企', 'nature');
INSERT INTO `jc_dictionary` VALUES ('8', '互联网', '互联网', 'industry');
INSERT INTO `jc_dictionary` VALUES ('9', '房地产', '房地产', 'industry');
INSERT INTO `jc_dictionary` VALUES ('10', '加工制造', '加工制造', 'industry');
INSERT INTO `jc_dictionary` VALUES ('11', '服务行业', '服务行业', 'industry');

-- ----------------------------
-- Table structure for `jc_directive_tpl`
-- ----------------------------
DROP TABLE IF EXISTS `jc_directive_tpl`;
CREATE TABLE `jc_directive_tpl` (
  `tpl_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '标签名称',
  `description` varchar(1000) DEFAULT NULL COMMENT '标签描述',
  `code` text COMMENT '标签代码',
  `user_id` int(11) NOT NULL COMMENT '标签创建者',
  PRIMARY KEY (`tpl_id`),
  KEY `fk_jc_directive_tpl_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='FComment';

-- ----------------------------
-- Records of jc_directive_tpl
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_file`
-- ----------------------------
DROP TABLE IF EXISTS `jc_file`;
CREATE TABLE `jc_file` (
  `file_path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(255) DEFAULT '' COMMENT '文件名字',
  `file_isvalid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有效',
  `content_id` int(11) DEFAULT NULL COMMENT '内容id',
  PRIMARY KEY (`file_path`),
  KEY `fk_jc_file_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_file
-- ----------------------------
INSERT INTO `jc_file` VALUES ('/u/cms/www/09093304hc6x.jpg', '09093304hc6x.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09093632txyy.jpg', '09093632txyy.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/090938248x1c.jpg', '090938248x1c.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/090940173zaj.jpg', '090940173zaj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09094140f562.jpg', '09094140f562.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09094302sldg.jpg', '09094302sldg.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09094430w0xt.jpg', '09094430w0xt.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09151507n6i1.jpg', '09151507n6i1.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09152518pzoq.jpg', '09152518pzoq.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09152931cgps.jpg', '09152931cgps.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/091552426die.jpg', '091552426die.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/0915541140xt.jpg', '0915541140xt.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09160120meel.jpg', '09160120meel.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/091602465aop.jpg', '091602465aop.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09165026tk5e.jpg', '09165026tk5e.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/091655240woj.jpg', '091655240woj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09165821s06r.jpg', '09165821s06r.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09170006n0hs.jpg', '09170006n0hs.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09174523xkvt.jpg', '09174523xkvt.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/09174527lkok.jpg', '09174527lkok.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/10092229195q.jpg', '10092229195q.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/100950366ij3.jpg', '100950366ij3.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/100953460bvo.jpg', '100953460bvo.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/10103806oifr.jpg', '10103806oifr.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/10104531ukj5.jpg', '10104531ukj5.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/10144918u244.jpg', '10144918u244.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11165619lkm8.jpg', '11165619lkm8.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11165624319n.jpg', '11165624319n.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/111656292jx9.jpg', '111656292jx9.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11165633po01.jpg', '11165633po01.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/111656366w4b.jpg', '111656366w4b.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11165640djk4.jpg', '11165640djk4.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11165849ahx1.jpg', '11165849ahx1.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11170224nw94.jpg', '11170224nw94.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11170651qc2f.jpg', '11170651qc2f.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11170656zz9b.jpg', '11170656zz9b.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/111707001w2k.jpg', '111707001w2k.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11170703j2h2.jpg', '11170703j2h2.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/111707071tn0.jpg', '111707071tn0.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11170712hp37.jpg', '11170712hp37.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/111707541g63.jpg', '111707541g63.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11171054ja61.jpg', '11171054ja61.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11171058td8f.jpg', '11171058td8f.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11171102ae78.jpg', '11171102ae78.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11171106qaui.jpg', '11171106qaui.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11171109m2sr.jpg', '11171109m2sr.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11171211kmih.jpg', '11171211kmih.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11171546aux9.jpg', '11171546aux9.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/111715499z6t.jpg', '111715499z6t.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11171553t5kf.jpg', '11171553t5kf.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11171558kiit.jpg', '11171558kiit.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11171603em6o.jpg', '11171603em6o.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11171606wnmy.jpg', '11171606wnmy.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1117164754x7.jpg', '1117164754x7.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11172127ltqx.jpg', '11172127ltqx.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/111721308eyj.jpg', '111721308eyj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11172134wikw.jpg', '11172134wikw.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11172137nwy5.jpg', '11172137nwy5.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11172219hw2t.jpg', '11172219hw2t.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11173208w8ji.jpg', '11173208w8ji.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11173213qlec.jpg', '11173213qlec.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/111732181p5u.jpg', '111732181p5u.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11173222qknp.jpg', '11173222qknp.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1117323496nx.jpg', '1117323496nx.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11173244ggfv.jpg', '11173244ggfv.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11173334yvdd.jpg', '11173334yvdd.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/111737053v9i.jpg', '111737053v9i.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11173708ffx2.jpg', '11173708ffx2.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11173711toqx.jpg', '11173711toqx.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11173718do4k.jpg', '11173718do4k.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11173719ykxk.jpg', '11173719ykxk.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11173724ul7o.jpg', '11173724ul7o.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11173804j6hj.jpg', '11173804j6hj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11174436pnoi.jpg', '11174436pnoi.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/11174439eb3l.jpg', '11174439eb3l.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1117444317kg.jpg', '1117444317kg.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/111744466aux.jpg', '111744466aux.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/111745157ps9.jpg', '111745157ps9.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12105715powr.jpg', '12105715powr.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12105715u0i2.jpg', '12105715u0i2.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12105716avso.jpg', '12105716avso.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12105716f0ks.jpg', '12105716f0ks.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12105716u081.jpg', '12105716u081.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12105717rgdv.jpg', '12105717rgdv.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12105908yuqz.jpg', '12105908yuqz.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121101457hlo.jpg', '121101457hlo.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121101459s0t.jpg', '121101459s0t.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12110145r34m.jpg', '12110145r34m.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12110146fexh.jpg', '12110146fexh.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12110146v1cq.jpg', '12110146v1cq.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12110146ynj3.jpg', '12110146ynj3.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12110240hrzh.jpg', '12110240hrzh.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121104013vts.jpg', '121104013vts.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12110726kcxc.jpg', '12110726kcxc.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12110726rqp4.jpg', '12110726rqp4.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121107270owq.jpg', '121107270owq.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1211072762wj.jpg', '1211072762wj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12110728cz8z.jpg', '12110728cz8z.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12110728hvna.jpg', '12110728hvna.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12110817ejy1.jpg', '12110817ejy1.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12111106jy1l.jpg', '12111106jy1l.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12111106lobh.jpg', '12111106lobh.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12111106zad3.jpg', '12111106zad3.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12111106zedy.jpg', '12111106zedy.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12111107ctqg.jpg', '12111107ctqg.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12111107l4wg.jpg', '12111107l4wg.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1211124392sy.jpg', '1211124392sy.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12111518igwr.jpg', '12111518igwr.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12111518kvd2.jpg', '12111518kvd2.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12111518l3p5.jpg', '12111518l3p5.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12111518vk7v.jpg', '12111518vk7v.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121115195muw.jpg', '121115195muw.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12111519tyc2.jpg', '12111519tyc2.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1211190051if.jpg', '1211190051if.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12112124imh5.jpg', '12112124imh5.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121121253f1z.jpg', '121121253f1z.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121121265tk1.jpg', '121121265tk1.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121121267h0z.jpg', '121121267h0z.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12112127795n.jpg', '12112127795n.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12112128ltfy.jpg', '12112128ltfy.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12112247lfhe.jpg', '12112247lfhe.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12120435rmvm.jpg', '12120435rmvm.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12120436on4w.jpg', '12120436on4w.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121204384v5d.jpg', '121204384v5d.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121204408a3o.jpg', '121204408a3o.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1212044200gm.jpg', '1212044200gm.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121207389dlf.jpg', '121207389dlf.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134158q84h.jpg', '12134158q84h.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134158qzrx.jpg', '12134158qzrx.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121341597c2x.jpg', '121341597c2x.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134159kbxa.jpg', '12134159kbxa.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134159robe.jpg', '12134159robe.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134200cwyl.jpg', '12134200cwyl.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134300ap1h.jpg', '12134300ap1h.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134450lo6n.jpg', '12134450lo6n.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134450mwvm.jpg', '12134450mwvm.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134451j9p9.jpg', '12134451j9p9.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134451k1zj.jpg', '12134451k1zj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134452b2g1.jpg', '12134452b2g1.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134452bb5z.jpg', '12134452bb5z.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134552bk69.jpg', '12134552bk69.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121348103ux5.jpg', '121348103ux5.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121348109k92.jpg', '121348109k92.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121348110tfi.jpg', '121348110tfi.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134811y9du.jpg', '12134811y9du.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134812unit.jpg', '12134812unit.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12134933sxsx.jpg', '12134933sxsx.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135148im9s.jpg', '12135148im9s.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135149ar88.jpg', '12135149ar88.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135149bhlg.jpg', '12135149bhlg.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135149s2wm.jpg', '12135149s2wm.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135243x57l.jpg', '12135243x57l.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135606e58j.jpg', '12135606e58j.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135607ftvv.jpg', '12135607ftvv.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135607vqhp.jpg', '12135607vqhp.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135608ad8p.jpg', '12135608ad8p.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135608l3ai.jpg', '12135608l3ai.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135609wexl.jpg', '12135609wexl.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135827xy0y.jpg', '12135827xy0y.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12135944xk9f.jpg', '12135944xk9f.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12140033b5mx.jpg', '12140033b5mx.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12140434ixtu.jpg', '12140434ixtu.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12140434n4th.jpg', '12140434n4th.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12140435relm.jpg', '12140435relm.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12140436rua8.jpg', '12140436rua8.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12140436wwsc.jpg', '12140436wwsc.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12140851yp14.jpg', '12140851yp14.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12141311nuua.jpg', '12141311nuua.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12141311xxbj.jpg', '12141311xxbj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12141312d3p6.jpg', '12141312d3p6.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12141312r6eb.jpg', '12141312r6eb.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1214131399h0.jpg', '1214131399h0.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12141313ndlq.jpg', '12141313ndlq.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121414505xah.jpg', '121414505xah.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12142118fe7p.jpg', '12142118fe7p.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121421197sla.jpg', '121421197sla.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12142119m8y5.jpg', '12142119m8y5.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12142120loqu.jpg', '12142120loqu.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12142120u2tx.jpg', '12142120u2tx.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1214212172bk.jpg', '1214212172bk.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12142322wa0z.jpg', '12142322wa0z.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12142734jwmh.jpg', '12142734jwmh.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12142735jqmu.jpg', '12142735jqmu.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12142735rhib.jpg', '12142735rhib.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1214273617d5.jpg', '1214273617d5.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12142736ue6c.jpg', '12142736ue6c.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12142737cr9y.jpg', '12142737cr9y.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12142830poeb.jpg', '12142830poeb.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1214325480ue.jpg', '1214325480ue.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12143254y1wh.jpg', '12143254y1wh.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121432556ttu.jpg', '121432556ttu.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12143255ryzh.jpg', '12143255ryzh.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12143255ukxu.jpg', '12143255ukxu.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12143256g1bo.jpg', '12143256g1bo.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12143342sfmg.jpg', '12143342sfmg.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121454345gdz.jpg', '121454345gdz.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12145434959z.jpg', '12145434959z.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12145434qkiz.jpg', '12145434qkiz.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12145435lmi6.jpg', '12145435lmi6.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12145435u9c1.jpg', '12145435u9c1.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121456599tnd.jpg', '121456599tnd.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12150556da16.jpg', '12150556da16.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12150556inf7.jpg', '12150556inf7.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12150557dzrz.jpg', '12150557dzrz.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12150557etcp.jpg', '12150557etcp.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12150701tmkd.jpg', '12150701tmkd.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12150936264i.jpg', '12150936264i.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121509368460.jpg', '121509368460.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12150936cnpa.jpg', '12150936cnpa.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121509371kyv.jpg', '121509371kyv.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12150937xe3g.jpg', '12150937xe3g.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12151139jrv6.jpg', '12151139jrv6.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1215211539ic.jpg', '1215211539ic.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12152115dymp.jpg', '12152115dymp.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12152115n7ee.jpg', '12152115n7ee.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12152115oqbj.jpg', '12152115oqbj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12152116am9n.jpg', '12152116am9n.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12152257va9g.jpg', '12152257va9g.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12153550461x.jpg', '12153550461x.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12153550ryso.jpg', '12153550ryso.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12153551fflz.jpg', '12153551fflz.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12153551igy5.jpg', '12153551igy5.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12153551r5kz.jpg', '12153551r5kz.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121535526foq.jpg', '121535526foq.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121536505s2h.jpg', '121536505s2h.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121542148jkc.jpg', '121542148jkc.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121542158t1n.jpg', '121542158t1n.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121542159xil.jpg', '121542159xil.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12154215ryyk.jpg', '12154215ryyk.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12154215y02n.jpg', '12154215y02n.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12154216egtt.jpg', '12154216egtt.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121543059cct.jpg', '121543059cct.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12154708kkn6.jpg', '12154708kkn6.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12154708nsye.jpg', '12154708nsye.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12154708we6w.jpg', '12154708we6w.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12154709iod3.jpg', '12154709iod3.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/12154709ypkl.jpg', '12154709ypkl.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/121547582f5t.jpg', '121547582f5t.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1311420498g8.jpg', '1311420498g8.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/131203117zrn.jpg', '131203117zrn.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/131257327chh.jpg', '131257327chh.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13141220dfer.jpg', '13141220dfer.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/131423399l1z.jpg', '131423399l1z.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13142927kzr3.jpg', '13142927kzr3.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/1316285322ks.jpg', '1316285322ks.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13162904gqxm.jpg', '13162904gqxm.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13162913da42.jpg', '13162913da42.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/131629222u39.jpg', '131629222u39.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13162931ofsn.jpg', '13162931ofsn.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13162941ipg2.jpg', '13162941ipg2.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13163101ccd3.jpg', '13163101ccd3.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13163113pd3s.jpg', '13163113pd3s.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13163306pqvc.jpg', '13163306pqvc.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13165112t47d.jpg', '13165112t47d.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13165118lr7r.jpg', '13165118lr7r.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13165348xokj.jpg', '13165348xokj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/131656557m43.jpg', '131656557m43.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13165702cchp.jpg', '13165702cchp.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13170123ywvv.jpg', '13170123ywvv.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13170129mx9q.jpg', '13170129mx9q.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13170427k084.jpg', '13170427k084.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/131706089h4w.jpg', '131706089h4w.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13170759d8ow.jpg', '13170759d8ow.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/13170940lu1h.jpg', '13170940lu1h.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19110822fin2.jpg', '19110822fin2.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19112623820c.jpg', '19112623820c.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19112700bypf.jpg', '19112700bypf.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19114043tp85.jpg', '19114043tp85.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19114201tdir.jpg', '19114201tdir.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/191201449moh.jpg', '191201449moh.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/191203538tdp.jpg', '191203538tdp.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19131809acqm.jpg', '19131809acqm.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19131949r2ge.jpg', '19131949r2ge.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/191342393mlg.jpg', '191342393mlg.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19134448qvza.jpg', '19134448qvza.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/191351590e53.jpg', '191351590e53.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19135642zjak.jpg', '19135642zjak.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19135645ge7r.jpg', '19135645ge7r.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19135821ij0m.jpg', '19135821ij0m.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19140340fri2.jpg', '19140340fri2.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19140601kgid.jpg', '19140601kgid.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19140803w9fg.jpg', '19140803w9fg.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/191408471iyj.jpg', '191408471iyj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19141200ip5c.jpg', '19141200ip5c.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19141318apz1.jpg', '19141318apz1.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19141700opui.jpg', '19141700opui.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19141756u9sa.jpg', '19141756u9sa.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19142041eu8x.jpg', '19142041eu8x.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19142206y73m.jpg', '19142206y73m.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19142430589t.jpg', '19142430589t.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19142451945q.jpg', '19142451945q.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19142818yvty.jpg', '19142818yvty.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/19142840ycm6.jpg', '19142840ycm6.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201139137vu6.jpg', '201139137vu6.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/20114003od1n.jpg', '20114003od1n.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201140399nrc.jpg', '201140399nrc.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201143116bd3.jpg', '201143116bd3.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/20114348t1z8.jpg', '20114348t1z8.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/20114520rqti.jpg', '20114520rqti.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/20114607jim6.jpg', '20114607jim6.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/20114824s9bf.jpg', '20114824s9bf.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/20115532h8tv.jpg', '20115532h8tv.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201159459afm.jpg', '201159459afm.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/20120531bbei.jpg', '20120531bbei.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/20120732ybv8.jpg', '20120732ybv8.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201308', '201308', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201309', '201309', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201312/301119254w80.flv', '/u/cms/www/201312/301119254w80.flv', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22093458gynd.jpg', '22093458gynd.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22093502mmft.jpg', '22093502mmft.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22093506l8pv.jpg', '22093506l8pv.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22093509qm3l.jpg', '22093509qm3l.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22093513srmf.jpg', '22093513srmf.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22094752xoxd.jpg', '22094752xoxd.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22094906lrj8.jpg', '22094906lrj8.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22094911xe9x.jpg', '22094911xe9x.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22094915t8h1.jpg', '22094915t8h1.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22094918gnze.jpg', '22094918gnze.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22100555lytj.jpg', '22100555lytj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22100558gfsb.jpg', '22100558gfsb.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22100601l1us.jpg', '22100601l1us.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22100606t8mw.jpg', '22100606t8mw.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/22100611o2gl.jpg', '22100611o2gl.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/23172935t4sb.jpg', '23172935t4sb.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/23172936acob.jpg', '23172936acob.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/23172937bli1.jpg', '23172937bli1.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/23172937r23n.jpg', '23172937r23n.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/23172939ln5a.jpg', '23172939ln5a.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/231729407e1v.jpg', '231729407e1v.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/231729434x7h.jpg', '231729434x7h.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/23172944o38x.jpg', '23172944o38x.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/23172944vvdh.jpg', '23172944vvdh.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/23172946mzqx.jpg', '23172946mzqx.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/23172947nrrl.jpg', '23172947nrrl.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/24102446b7al.jpg', '24102446b7al.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/24102503z9wj.jpg', '24102503z9wj.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/2416455972ro.jpg', '2416455972ro.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/241646340nq6.jpg', '241646340nq6.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/24164707ksjq.jpg', '24164707ksjq.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/26115537aper.jpg', '26115537aper.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/26115537rs0f.jpg', '26115537rs0f.jpg', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/26150136kryi.txt', '26150136kryi.txt', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/Thumbs.db', 'Thumbs.db', '1', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/13135536pnt2.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/131359296e9c.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/1314055350gc.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/13140606bjte.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/13140635xydz.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/13140702pfne.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/13140909s64p.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/13141723ywh0.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/13142644qpdm.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/131429269ikl.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/131431450xia.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201401/131431578u9o.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/1316123792p0.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/13163251c8d5.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/131634322gqg.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/131636277cxi.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/13163934xmp0.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/13164248ng73.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/13165347xxty.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/13170503bwpw.jpg', '1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/13170603q1bw.jpg', '1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/131706463pqt.jpg', '1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/13172446osvy.jpg', '1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/13172626x71c.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/13173752etj3.zip', 'ChromeSetup.zip', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/13173805fii8.zip', 'ChromeSetup.zip', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14091703u57k.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14091741h0w0.zip', 'ChromeSetup.zip', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14092030cnyx.mp4', '18183451i5bi.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14092835ljai.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14095531y5tg.zip', 'ChromeSetup.zip', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14095543za61.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14095551kk1a.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14095759mdqw.docx', '0_開發需求_.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14102936l7gw.txt', 'freemarker.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14104521p9ey.zip', 'bbs-update-2012-11-2.zip', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14105137jxtn.mp4', '/v6/u/cms/www/201403/14105137jxtn.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14112725dsar.zip', '/v6/u/cms/www/201403/14112725dsar.zip', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14130702z3xz.png', '/v6/u/cms/www/201403/14130702z3xz.png', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/14165746s64i.pdf', '1.pdf', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201403/1914315903bj.jpg', '1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/20151821gj8y.jpg', '1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/2015202141s0.jpg', '1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/211128348kuw.jpg', '1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/2111305770l1.jpg', '1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/21113452hsxh.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/211137096eif.jpg', 'mv.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/211149148tx0.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/21115759y8sm.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/211511276v74.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/21151948k1fh.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/21154820xtfs.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/2115485050rw.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/21155236mk9b.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22084701xqxy.doc', '/v6/u/cms/www/201404/22084701xqxy.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22084833ys27.doc', '/v6/u/cms/www/201404/22084833ys27.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22111217hftv.doc', 'Linux开启mysql远程连接.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22111332dwt3.doc', 'Linux开启mysql远程连接.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22114143pw1a.doc', 'Linux开启mysql远程连接.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22132355vqdf.txt', 'IBM LDAP.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22133304pnoh.txt', '/v6/u/cms/www/201404/22133304pnoh.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22133312pz3j.exe', 'wpp.exe', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22135235m1m1.txt', 'cmstop.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22135348pbqp.swf', '2.swf', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/221353537d0o.doc', 'discuz_2.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22140446zkgv.txt', 'fengling新bug.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22140629jx27.txt', '360检测.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22140634er4n.doc', 'Discuz_X2.0数据字典(数据库表作用解释).doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22140716e5bk.flv', '/v6/u/cms/www/201404/22140716e5bk.flv', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22141101f9tv.txt', '360检测.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22141404irh6.docx', 'Apache_Shiro_使用手册.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22142207xrqx.doc', 'Discuz_X2.0数据字典(数据库表作用解释).doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22145137jigp.docx', 'Apache_Shiro_使用手册.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22145142drkb.docx', 'Apache_Shiro_使用手册.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/221501301rkt.docx', 'Apache_Shiro_使用手册.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22151702mcwi.docx', 'Apache_Shiro_使用手册.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22152145c9do.doc', 'Linux开启mysql远程连接.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22152231wfrv.mp4', '/v6/u/cms/www/201404/22152231wfrv.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22155743mgws.txt', 'bug平台推荐.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22155756p9of.txt', 'flot柱状图.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/22155756scdn.txt', 'flot使用笔记.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/28134316erf3.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/281402505i20.jpg', 'mv.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/28140346452f.jpg', 'mv.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201404/30140543hzlx.gif', 'webLogo.gif', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201405/08091845sh2l.jpg', '1.JPG', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201405/08092143cyap.jpg', '1.JPG', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201405/08092249ype2.jpg', '1.JPG', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201405/08092924h3fr.jpg', '1.JPG', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201405/08093111b3jm.jpg', '1.JPG', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201405/09083819wiab.jpg', 'mv.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201405/090840146ik7.jpg', 'mv.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201405/090918028k13.jpg', 'mv.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201406/09144419786f.txt', 'bbs好的功能.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201406/09145849ap2u.docx', '1.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201406/09151219pj5s.doc', '2.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201406/0915215434ij.txt', 'cmstop.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201407/121650299xv9.doc', 'DiscuzX2文件说明,目录说明.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201407/12165642273e.doc', 'Discuz_X2.0数据字典(数据库表作用解释).doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201407/12170522j2ct.jpg', '1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201407/30093714q9ic.mp4', '/v6/u/cms/www/201407/30093714q9ic.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201407/30130947bmm3.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201407/30170627hj1m.jpg', 'mv.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201407/31114444inln.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201407/31114945lp9t.jpg', 'mv.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201407/31115246futn.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201407/31115423u7e6.jpg', 'mv1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/u/cms/www/201407/31132254zdh7.jpg', 'mv.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201312/241031214kys.txt', '/v6/wenku/www/201312/241031214kys.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201401/16164720tu2n.doc', '/v6/wenku/www/201401/16164720tu2n.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201401/17083718btie.doc', '/v6/wenku/www/201401/17083718btie.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201401/17084032522j.doc', '/v6/wenku/www/201401/17084032522j.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201401/170842070sy2.doc', '/v6/wenku/www/201401/170842070sy2.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201401/17084442fd08.doc', '/v6/wenku/www/201401/17084442fd08.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201401/17085101zvcg.doc', '/v6/wenku/www/201401/17085101zvcg.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201401/25095002cniq.doc', '/v6/wenku/www/201401/25095002cniq.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201403/10115402nl6c.docx', '/v6/wenku/www/201403/10115402nl6c.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201403/1011550974pv.docx', '/v6/wenku/www/201403/1011550974pv.docx', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201403/101155409soa.txt', '/v6/wenku/www/201403/101155409soa.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201403/10115750uxwh.txt', '/v6/wenku/www/201403/10115750uxwh.txt', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201406/04132656esvy.pdf', '/v6/wenku/www/201406/04132656esvy.pdf', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201406/04133131ky4f.pdf', '/v6/wenku/www/201406/04133131ky4f.pdf', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201406/04133159jryy.pdf', '/v6/wenku/www/201406/04133159jryy.pdf', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201406/04133312rszg.pdf', '/v6/wenku/www/201406/04133312rszg.pdf', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201406/04133437555h.pdf', '/v6/wenku/www/201406/04133437555h.pdf', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201406/04133611h3sa.pdf', '/v6/wenku/www/201406/04133611h3sa.pdf', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201406/041340029cmx.pdf', '/v6/wenku/www/201406/041340029cmx.pdf', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201406/0413413473t5.pdf', '/v6/wenku/www/201406/0413413473t5.pdf', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201406/041353368k3b.doc', '/v6/wenku/www/201406/041353368k3b.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201406/04135541s2ay.doc', '/v6/wenku/www/201406/04135541s2ay.doc', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201408/08112543cj83.pdf', '/v6/wenku/www/201408/08112543cj83.pdf', '0', null);
INSERT INTO `jc_file` VALUES ('/v6/wenku/www/201408/08131514njo0.pdf', '/v6/wenku/www/201408/08131514njo0.pdf', '0', null);

-- ----------------------------
-- Table structure for `jc_friendlink`
-- ----------------------------
DROP TABLE IF EXISTS `jc_friendlink`;
CREATE TABLE `jc_friendlink` (
  `friendlink_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `friendlinkctg_id` int(11) NOT NULL,
  `site_name` varchar(150) NOT NULL COMMENT '网站名称',
  `domain` varchar(255) NOT NULL COMMENT '网站地址',
  `logo` varchar(150) DEFAULT NULL COMMENT '图标',
  `email` varchar(100) DEFAULT NULL COMMENT '站长邮箱',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '点击次数',
  `is_enabled` char(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  PRIMARY KEY (`friendlink_id`),
  KEY `fk_jc_ctg_friendlink` (`friendlinkctg_id`),
  KEY `fk_jc_friendlink_site` (`site_id`),
  CONSTRAINT `fk_jc_ctg_friendlink` FOREIGN KEY (`friendlinkctg_id`) REFERENCES `jc_friendlink_ctg` (`friendlinkctg_id`),
  CONSTRAINT `fk_jc_friendlink_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS友情链接';

-- ----------------------------
-- Records of jc_friendlink
-- ----------------------------
INSERT INTO `jc_friendlink` VALUES ('1', '1', '1', '个人博客', 'http://localhost:8080/fengling', null, 'fengling@163.com', 'fengling是JavaEE版网站管理系统（Java Enterprise Edition Content Manage System）的简称。Java凭借其强大、稳定、安全、高效等多方面的优势，一直是企业级应用的首选。', '37', '1', '1');
INSERT INTO `jc_friendlink` VALUES ('2', '1', '1', '七十二颗星', 'http://www.72star.com', null, 'dv3333@163.com', '风陵渡口论坛', '5', '1', '10');

-- ----------------------------
-- Table structure for `jc_friendlink_ctg`
-- ----------------------------
DROP TABLE IF EXISTS `jc_friendlink_ctg`;
CREATE TABLE `jc_friendlink_ctg` (
  `friendlinkctg_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `friendlinkctg_name` varchar(50) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  PRIMARY KEY (`friendlinkctg_id`),
  KEY `fk_jc_friendlinkctg_site` (`site_id`),
  CONSTRAINT `fk_jc_friendlinkctg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS友情链接类别';

-- ----------------------------
-- Records of jc_friendlink_ctg
-- ----------------------------
INSERT INTO `jc_friendlink_ctg` VALUES ('1', '1', '文字链接', '1');
INSERT INTO `jc_friendlink_ctg` VALUES ('2', '1', '品牌专区（图片链接）', '2');

-- ----------------------------
-- Table structure for `jc_group`
-- ----------------------------
DROP TABLE IF EXISTS `jc_group`;
CREATE TABLE `jc_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `need_captcha` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否需要验证码',
  `need_check` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否需要审核',
  `allow_per_day` int(11) NOT NULL DEFAULT '4096' COMMENT '每日允许上传KB',
  `allow_max_file` int(11) NOT NULL DEFAULT '1024' COMMENT '每个文件最大KB',
  `allow_suffix` varchar(255) DEFAULT 'jpg,jpeg,gif,png,bmp' COMMENT '允许上传的后缀',
  `is_reg_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认会员组',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS会员组表';

-- ----------------------------
-- Records of jc_group
-- ----------------------------
INSERT INTO `jc_group` VALUES ('1', '普通会员', '10', '1', '1', '0', '0', '', '1');
INSERT INTO `jc_group` VALUES ('2', '高级组', '10', '1', '1', '0', '0', '', '0');

-- ----------------------------
-- Table structure for `jc_guestbook`
-- ----------------------------
DROP TABLE IF EXISTS `jc_guestbook`;
CREATE TABLE `jc_guestbook` (
  `guestbook_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `guestbookctg_id` int(11) NOT NULL,
  `member_id` int(11) DEFAULT NULL COMMENT '留言会员',
  `admin_id` int(11) DEFAULT NULL COMMENT '回复管理员',
  `ip` varchar(50) NOT NULL COMMENT '留言IP',
  `create_time` datetime NOT NULL COMMENT '留言时间',
  `replay_time` datetime DEFAULT NULL COMMENT '回复时间',
  `is_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  PRIMARY KEY (`guestbook_id`),
  KEY `fk_jc_ctg_guestbook` (`guestbookctg_id`),
  KEY `fk_jc_guestbook_admin` (`admin_id`),
  KEY `fk_jc_guestbook_member` (`member_id`),
  KEY `fk_jc_guestbook_site` (`site_id`),
  CONSTRAINT `fk_jc_ctg_guestbook` FOREIGN KEY (`guestbookctg_id`) REFERENCES `jc_guestbook_ctg` (`guestbookctg_id`),
  CONSTRAINT `fk_jc_guestbook_admin` FOREIGN KEY (`admin_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_guestbook_member` FOREIGN KEY (`member_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_guestbook_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='CMS留言';

-- ----------------------------
-- Records of jc_guestbook
-- ----------------------------
INSERT INTO `jc_guestbook` VALUES ('1', '1', '1', null, '1', '127.0.0.1', '2014-01-01 15:02:19', null, '1', '0');
INSERT INTO `jc_guestbook` VALUES ('2', '1', '1', '1', null, '127.0.0.1', '2014-04-19 16:04:19', null, '0', '0');
INSERT INTO `jc_guestbook` VALUES ('3', '1', '1', '1', null, '127.0.0.1', '2014-04-19 16:04:34', null, '0', '0');
INSERT INTO `jc_guestbook` VALUES ('4', '1', '1', null, null, '127.0.0.1', '2014-04-19 17:11:55', null, '0', '0');
INSERT INTO `jc_guestbook` VALUES ('5', '1', '2', '1', null, '127.0.0.1', '2014-04-21 09:28:01', null, '0', '0');
INSERT INTO `jc_guestbook` VALUES ('6', '1', '1', '1', null, '127.0.0.1', '2014-04-21 10:52:45', null, '0', '0');
INSERT INTO `jc_guestbook` VALUES ('7', '1', '1', '1', null, '127.0.0.1', '2014-04-21 11:20:16', null, '0', '0');
INSERT INTO `jc_guestbook` VALUES ('8', '1', '1', '1', '1', '127.0.0.1', '2014-04-21 11:23:25', '2014-05-07 17:33:05', '0', '1');
INSERT INTO `jc_guestbook` VALUES ('9', '1', '1', '1', null, '127.0.0.1', '2014-05-04 16:06:02', null, '0', '1');

-- ----------------------------
-- Table structure for `jc_guestbook_ctg`
-- ----------------------------
DROP TABLE IF EXISTS `jc_guestbook_ctg`;
CREATE TABLE `jc_guestbook_ctg` (
  `guestbookctg_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `ctg_name` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`guestbookctg_id`),
  KEY `fk_jc_guestbookctg_site` (`site_id`),
  CONSTRAINT `fk_jc_guestbookctg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS留言类别';

-- ----------------------------
-- Records of jc_guestbook_ctg
-- ----------------------------
INSERT INTO `jc_guestbook_ctg` VALUES ('1', '1', '普通', '1', '普通留言');
INSERT INTO `jc_guestbook_ctg` VALUES ('2', '1', '投诉', '10', '投诉');

-- ----------------------------
-- Table structure for `jc_guestbook_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_guestbook_ext`;
CREATE TABLE `jc_guestbook_ext` (
  `guestbook_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '留言标题',
  `content` longtext COMMENT '留言内容',
  `reply` longtext COMMENT '回复内容',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(100) DEFAULT NULL COMMENT '电话',
  `qq` varchar(50) DEFAULT NULL COMMENT 'QQ',
  KEY `fk_jc_ext_guestbook` (`guestbook_id`),
  CONSTRAINT `fk_jc_ext_guestbook` FOREIGN KEY (`guestbook_id`) REFERENCES `jc_guestbook` (`guestbook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS留言内容';

-- ----------------------------
-- Records of jc_guestbook_ext
-- ----------------------------
INSERT INTO `jc_guestbook_ext` VALUES ('1', '111111111111111', '11', '11111111111111111', null, null, null);
INSERT INTO `jc_guestbook_ext` VALUES ('2', 'aa', 'a', null, null, 'aa', null);
INSERT INTO `jc_guestbook_ext` VALUES ('3', 'aa', 'a', null, null, 'aa', null);
INSERT INTO `jc_guestbook_ext` VALUES ('4', 'asdfsadf', 'asdfasdfasdf', null, null, null, null);
INSERT INTO `jc_guestbook_ext` VALUES ('5', 'aaaa', 'aaaaa', null, null, 'a', null);
INSERT INTO `jc_guestbook_ext` VALUES ('6', null, 'asdfasd', null, null, null, null);
INSERT INTO `jc_guestbook_ext` VALUES ('7', null, 'aaa', null, null, 'a', null);
INSERT INTO `jc_guestbook_ext` VALUES ('8', 'asdf', 'asdf', 'asdf', null, null, null);
INSERT INTO `jc_guestbook_ext` VALUES ('9', '<script>alert(\"dd\")</script> ', '<script>alert(\"dd\")</script> ', null, null, null, null);

-- ----------------------------
-- Table structure for `jc_job_apply`
-- ----------------------------
DROP TABLE IF EXISTS `jc_job_apply`;
CREATE TABLE `jc_job_apply` (
  `job_apply_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `content_id` int(11) NOT NULL COMMENT '职位id',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY (`job_apply_id`),
  KEY `fk_jc_job_apply_user` (`user_id`),
  KEY `fk_jc_job_apply_content` (`content_id`),
  CONSTRAINT `fk_jc_job_apply_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_job_apply_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职位申请表';

-- ----------------------------
-- Records of jc_job_apply
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_keyword`
-- ----------------------------
DROP TABLE IF EXISTS `jc_keyword`;
CREATE TABLE `jc_keyword` (
  `keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL COMMENT '站点ID',
  `keyword_name` varchar(100) NOT NULL COMMENT '名称',
  `url` varchar(255) NOT NULL COMMENT '链接',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`keyword_id`),
  KEY `fk_jc_keyword_site` (`site_id`),
  CONSTRAINT `fk_jc_keyword_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS内容关键词表';

-- ----------------------------
-- Records of jc_keyword
-- ----------------------------
INSERT INTO `jc_keyword` VALUES ('1', null, '内容管理系统', '<a href=\"http://www.fengling.com/\" target=\"_blank\">内容管理系统</a>', '0');

-- ----------------------------
-- Table structure for `jc_log`
-- ----------------------------
DROP TABLE IF EXISTS `jc_log`;
CREATE TABLE `jc_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `category` int(11) NOT NULL COMMENT '日志类型',
  `log_time` datetime NOT NULL COMMENT '日志时间',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL地址',
  `title` varchar(255) DEFAULT NULL COMMENT '日志标题',
  `content` varchar(255) DEFAULT NULL COMMENT '日志内容',
  PRIMARY KEY (`log_id`),
  KEY `fk_jc_log_site` (`site_id`),
  KEY `fk_jc_log_user` (`user_id`),
  CONSTRAINT `fk_jc_log_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_log_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8 COMMENT='CMS日志表';

-- ----------------------------
-- Records of jc_log
-- ----------------------------
INSERT INTO `jc_log` VALUES ('1', '1', null, '1', '2015-03-17 21:03:06', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('2', '1', '1', '3', '2015-03-17 21:03:15', '127.0.0.1', '/fengling/admin/fengling/config/o_system_update.do', '修改系统设置', null);
INSERT INTO `jc_log` VALUES ('3', '1', '1', '3', '2015-03-17 21:06:11', '127.0.0.1', '/fengling/admin/fengling/site_config/o_base_update.do', '站点基本设置', null);
INSERT INTO `jc_log` VALUES ('4', '1', '1', '3', '2015-03-17 21:12:29', '127.0.0.1', '/fengling/admin/fengling/site_config/o_base_update.do', '站点基本设置', null);
INSERT INTO `jc_log` VALUES ('5', '1', null, '1', '2015-03-17 21:22:14', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('6', '1', '1', '3', '2015-03-17 22:03:14', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=42;name=它山之石');
INSERT INTO `jc_log` VALUES ('7', '1', '1', '3', '2015-03-17 22:04:44', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=42;name=它山之石');
INSERT INTO `jc_log` VALUES ('8', '1', '1', '3', '2015-03-17 22:08:46', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=46;name=岁月如梭');
INSERT INTO `jc_log` VALUES ('9', '1', '1', '3', '2015-03-17 22:17:44', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=1;name=聚沙成塔');
INSERT INTO `jc_log` VALUES ('10', '1', '1', '3', '2015-03-17 22:21:33', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=9;name=积微成著');
INSERT INTO `jc_log` VALUES ('11', '1', '1', '3', '2015-03-17 22:22:09', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=60;title=网络调查');
INSERT INTO `jc_log` VALUES ('12', '1', '1', '3', '2015-03-17 22:22:13', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=61;title=招聘');
INSERT INTO `jc_log` VALUES ('13', '1', '1', '3', '2015-03-17 22:22:35', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=10;name=关于我们');
INSERT INTO `jc_log` VALUES ('14', '1', '1', '3', '2015-03-17 22:23:02', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=10;name=关于我们');
INSERT INTO `jc_log` VALUES ('15', '1', '1', '3', '2015-03-17 22:26:56', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=10;name=关于本站');
INSERT INTO `jc_log` VALUES ('16', '1', null, '1', '2015-03-18 23:00:04', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('17', '1', '1', '3', '2015-03-18 23:07:41', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=10;title=关于本站');
INSERT INTO `jc_log` VALUES ('18', '1', '1', '3', '2015-03-18 23:12:15', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=37;title=系统软件');
INSERT INTO `jc_log` VALUES ('19', '1', '1', '3', '2015-03-18 23:12:15', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=38;title=网络游戏');
INSERT INTO `jc_log` VALUES ('20', '1', '1', '3', '2015-03-18 23:12:15', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=39;title=媒体工具');
INSERT INTO `jc_log` VALUES ('21', '1', '1', '3', '2015-03-18 23:12:15', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=57;title=null');
INSERT INTO `jc_log` VALUES ('22', '1', '1', '3', '2015-03-18 23:12:21', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=49;title=null');
INSERT INTO `jc_log` VALUES ('23', '1', '1', '3', '2015-03-18 23:12:21', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=50;title=null');
INSERT INTO `jc_log` VALUES ('24', '1', '1', '3', '2015-03-18 23:12:21', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=51;title=null');
INSERT INTO `jc_log` VALUES ('25', '1', '1', '3', '2015-03-18 23:12:40', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=9;title=积微成著');
INSERT INTO `jc_log` VALUES ('26', '1', '1', '3', '2015-03-18 23:12:44', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=46;title=null');
INSERT INTO `jc_log` VALUES ('27', '1', '1', '3', '2015-03-18 23:12:57', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=11;title=国内新闻');
INSERT INTO `jc_log` VALUES ('28', '1', '1', '3', '2015-03-18 23:12:57', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=12;title=国际新闻');
INSERT INTO `jc_log` VALUES ('29', '1', '1', '3', '2015-03-18 23:12:57', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=13;title=社会热点');
INSERT INTO `jc_log` VALUES ('30', '1', '1', '3', '2015-03-18 23:12:57', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=14;title=时事评论');
INSERT INTO `jc_log` VALUES ('31', '1', '1', '3', '2015-03-18 23:12:57', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=15;title=图片新闻');
INSERT INTO `jc_log` VALUES ('32', '1', '1', '3', '2015-03-18 23:12:57', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=40;title=null');
INSERT INTO `jc_log` VALUES ('33', '1', '1', '3', '2015-03-18 23:12:57', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=41;title=null');
INSERT INTO `jc_log` VALUES ('34', '1', '1', '3', '2015-03-18 23:12:57', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=69;title=反腐倡廉');
INSERT INTO `jc_log` VALUES ('35', '1', '1', '3', '2015-03-18 23:13:38', '127.0.0.1', '/fengling/admin/fengling/topic/o_delete.do', '删除专题', 'id=6;name=美军准备空袭叙利亚');
INSERT INTO `jc_log` VALUES ('36', '1', '1', '3', '2015-03-18 23:13:38', '127.0.0.1', '/fengling/admin/fengling/topic/o_delete.do', '删除专题', 'id=7;name=“气功大师”王林遭质疑');
INSERT INTO `jc_log` VALUES ('37', '1', '1', '3', '2015-03-18 23:13:38', '127.0.0.1', '/fengling/admin/fengling/topic/o_delete.do', '删除专题', 'id=5;name=广西桂林学校附近发生爆炸');
INSERT INTO `jc_log` VALUES ('38', '1', '1', '3', '2015-03-18 23:13:38', '127.0.0.1', '/fengling/admin/fengling/topic/o_delete.do', '删除专题', 'id=4;name=习近平中亚之行');
INSERT INTO `jc_log` VALUES ('39', '1', '1', '3', '2015-03-18 23:13:38', '127.0.0.1', '/fengling/admin/fengling/topic/o_delete.do', '删除专题', 'id=3;name=低碳经济');
INSERT INTO `jc_log` VALUES ('40', '1', '1', '3', '2015-03-18 23:13:38', '127.0.0.1', '/fengling/admin/fengling/topic/o_delete.do', '删除专题', 'id=2;name=上海世博会专题');
INSERT INTO `jc_log` VALUES ('41', '1', '1', '3', '2015-03-18 23:13:38', '127.0.0.1', '/fengling/admin/fengling/topic/o_delete.do', '删除专题', 'id=1;name=2010年南非世界杯');
INSERT INTO `jc_log` VALUES ('42', '1', '1', '3', '2015-03-18 23:13:51', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=43;title=null');
INSERT INTO `jc_log` VALUES ('43', '1', '1', '3', '2015-03-18 23:13:51', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=44;title=null');
INSERT INTO `jc_log` VALUES ('44', '1', '1', '3', '2015-03-18 23:13:51', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=45;title=null');
INSERT INTO `jc_log` VALUES ('45', '1', '1', '3', '2015-03-18 23:14:06', '127.0.0.1', '/fengling/admin/fengling/channel/o_delete.do', '删除栏目', 'id=42;title=null');
INSERT INTO `jc_log` VALUES ('46', '1', '1', '3', '2015-03-18 23:14:54', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=70;title=它山之石');
INSERT INTO `jc_log` VALUES ('47', '1', '1', '3', '2015-03-18 23:16:06', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=71;title=null');
INSERT INTO `jc_log` VALUES ('48', '1', '1', '3', '2015-03-18 23:16:33', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=72;title=null');
INSERT INTO `jc_log` VALUES ('49', '1', '1', '3', '2015-03-18 23:17:16', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=73;title=null');
INSERT INTO `jc_log` VALUES ('50', '1', '1', '3', '2015-03-18 23:19:52', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=73;name=岁月如梭');
INSERT INTO `jc_log` VALUES ('51', '1', '1', '3', '2015-03-18 23:20:10', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=72;name=岁月如梭');
INSERT INTO `jc_log` VALUES ('52', '1', '1', '3', '2015-03-18 23:20:38', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=73;name=关于本站');
INSERT INTO `jc_log` VALUES ('53', '1', '1', '3', '2015-03-18 23:21:36', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=74;title=null');
INSERT INTO `jc_log` VALUES ('54', '1', null, '1', '2015-03-18 23:25:13', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('55', '1', '1', '3', '2015-03-18 23:26:43', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=1;name=聚沙成塔');
INSERT INTO `jc_log` VALUES ('56', '1', '1', '3', '2015-03-18 23:32:39', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=565;title=亦真亦假：技术剖析WordPress黑帽SEO插件');
INSERT INTO `jc_log` VALUES ('57', '1', '1', '3', '2015-03-18 23:38:31', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=70;name=它山之石');
INSERT INTO `jc_log` VALUES ('58', '1', '1', '3', '2015-03-18 23:39:24', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=71;name=包罗万象');
INSERT INTO `jc_log` VALUES ('59', '1', '1', '3', '2015-03-18 23:42:47', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=72;name=岁月如梭');
INSERT INTO `jc_log` VALUES ('60', '1', '1', '3', '2015-03-18 23:50:38', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=73;name=关于本站');
INSERT INTO `jc_log` VALUES ('61', '1', '1', '3', '2015-03-18 23:54:53', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=74;name=留言版');
INSERT INTO `jc_log` VALUES ('62', '1', '1', '3', '2015-03-19 00:04:12', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=565;title=亦真亦假：技术剖析WordPress黑帽SEO插件');
INSERT INTO `jc_log` VALUES ('63', '1', null, '1', '2015-03-19 21:24:15', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('64', '1', '1', '3', '2015-03-19 21:42:53', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=75;title=Linux');
INSERT INTO `jc_log` VALUES ('65', '1', '1', '3', '2015-03-19 22:09:01', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=76;title=数据库');
INSERT INTO `jc_log` VALUES ('66', '1', '1', '3', '2015-03-19 22:09:27', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=77;title=null');
INSERT INTO `jc_log` VALUES ('67', '1', '1', '3', '2015-03-19 22:09:42', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=78;title=null');
INSERT INTO `jc_log` VALUES ('68', '1', '1', '3', '2015-03-19 22:09:59', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=75;name=Linux');
INSERT INTO `jc_log` VALUES ('69', '1', '1', '3', '2015-03-19 22:10:07', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=76;name=数据库');
INSERT INTO `jc_log` VALUES ('70', '1', '1', '3', '2015-03-19 22:10:17', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=77;name=Spring');
INSERT INTO `jc_log` VALUES ('71', '1', '1', '3', '2015-03-19 22:10:25', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=78;name=Hibernate');
INSERT INTO `jc_log` VALUES ('72', '1', '1', '3', '2015-03-19 22:10:48', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=79;title=null');
INSERT INTO `jc_log` VALUES ('73', '1', '1', '3', '2015-03-19 22:11:18', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=80;title=null');
INSERT INTO `jc_log` VALUES ('74', '1', '1', '3', '2015-03-19 22:11:37', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=81;title=null');
INSERT INTO `jc_log` VALUES ('75', '1', '1', '3', '2015-03-19 22:11:48', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=81;name=Freemarker');
INSERT INTO `jc_log` VALUES ('76', '1', '1', '3', '2015-03-19 22:12:12', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=82;title=null');
INSERT INTO `jc_log` VALUES ('77', '1', '1', '3', '2015-03-19 22:12:34', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=83;title=null');
INSERT INTO `jc_log` VALUES ('78', '1', '1', '3', '2015-03-19 22:14:27', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=84;title=null');
INSERT INTO `jc_log` VALUES ('79', '1', '1', '3', '2015-03-19 22:14:43', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=85;title=null');
INSERT INTO `jc_log` VALUES ('80', '1', '1', '3', '2015-03-19 22:15:08', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=86;title=null');
INSERT INTO `jc_log` VALUES ('81', '1', '1', '3', '2015-03-19 22:15:26', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=87;title=null');
INSERT INTO `jc_log` VALUES ('82', '1', '1', '3', '2015-03-19 22:16:06', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=88;title=null');
INSERT INTO `jc_log` VALUES ('83', '1', '1', '3', '2015-03-19 22:24:16', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=75;name=Linux');
INSERT INTO `jc_log` VALUES ('84', '1', '1', '3', '2015-03-19 22:24:26', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=76;name=数据库');
INSERT INTO `jc_log` VALUES ('85', '1', '1', '3', '2015-03-19 22:25:50', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=77;name=Spring');
INSERT INTO `jc_log` VALUES ('86', '1', '1', '3', '2015-03-19 22:25:58', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=78;name=Hibernate');
INSERT INTO `jc_log` VALUES ('87', '1', '1', '3', '2015-03-19 22:26:07', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=79;name=JavaScript');
INSERT INTO `jc_log` VALUES ('88', '1', '1', '3', '2015-03-19 22:26:16', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=80;name=HTML/CSS/JSP');
INSERT INTO `jc_log` VALUES ('89', '1', '1', '3', '2015-03-19 22:26:24', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=81;name=Freemarker');
INSERT INTO `jc_log` VALUES ('90', '1', '1', '3', '2015-03-19 22:26:33', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=83;name=Maven');
INSERT INTO `jc_log` VALUES ('91', '1', '1', '3', '2015-03-19 22:26:51', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=84;name=错误处理');
INSERT INTO `jc_log` VALUES ('92', '1', '1', '3', '2015-03-19 22:27:08', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=86;name=书籍推荐');
INSERT INTO `jc_log` VALUES ('93', '1', '1', '3', '2015-03-19 22:27:17', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=87;name=编程思维');
INSERT INTO `jc_log` VALUES ('94', '1', '1', '3', '2015-03-19 22:27:24', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=88;name=模板代码');
INSERT INTO `jc_log` VALUES ('95', '1', '1', '3', '2015-03-19 22:28:02', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=82;name=全文检索');
INSERT INTO `jc_log` VALUES ('96', '1', '1', '3', '2015-03-19 22:29:00', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=565;title=亦真亦假：技术剖析WordPress黑帽SEO插件');
INSERT INTO `jc_log` VALUES ('97', '1', null, '1', '2015-03-19 23:20:32', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('98', '1', '1', '3', '2015-03-19 23:21:03', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=565;title=亦真亦假：技术剖析WordPress黑帽SEO插件');
INSERT INTO `jc_log` VALUES ('99', '1', null, '1', '2015-03-21 21:24:24', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('100', '1', '1', '3', '2015-03-21 21:24:39', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=565;title=亦真亦假：技术剖析WordPress黑帽SEO插件');
INSERT INTO `jc_log` VALUES ('101', '1', null, '1', '2015-03-22 19:36:10', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('102', '1', '1', '3', '2015-03-22 19:37:01', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=566;title=test');
INSERT INTO `jc_log` VALUES ('103', '1', null, '1', '2015-03-22 22:42:30', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('104', '1', '1', '3', '2015-03-22 22:42:54', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=1;name=聚沙成塔');
INSERT INTO `jc_log` VALUES ('105', '1', null, '1', '2015-03-23 23:15:50', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('106', '1', null, '1', '2015-03-24 22:44:44', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('107', '1', '1', '3', '2015-03-24 22:49:29', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=89;title=null');
INSERT INTO `jc_log` VALUES ('108', '1', '1', '3', '2015-03-24 22:50:18', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=90;title=null');
INSERT INTO `jc_log` VALUES ('109', '1', '1', '3', '2015-03-24 22:51:01', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=91;title=null');
INSERT INTO `jc_log` VALUES ('110', '1', '1', '3', '2015-03-24 22:51:28', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=92;title=null');
INSERT INTO `jc_log` VALUES ('111', '1', '1', '3', '2015-03-24 22:52:06', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=93;title=null');
INSERT INTO `jc_log` VALUES ('112', '1', '1', '3', '2015-03-24 22:52:41', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=94;title=null');
INSERT INTO `jc_log` VALUES ('113', '1', null, '1', '2015-03-25 22:32:14', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('114', '1', '1', '3', '2015-03-25 22:32:27', '127.0.0.1', '/fengling/admin/fengling/friendlink/o_delete.do', '删除友情链接', 'id=6;name=ihush');
INSERT INTO `jc_log` VALUES ('115', '1', '1', '3', '2015-03-25 22:32:30', '127.0.0.1', '/fengling/admin/fengling/friendlink/o_delete.do', '删除友情链接', 'id=5;name=亚马逊');
INSERT INTO `jc_log` VALUES ('116', '1', '1', '3', '2015-03-25 22:32:33', '127.0.0.1', '/fengling/admin/fengling/friendlink/o_delete.do', '删除友情链接', 'id=4;name=当当网');
INSERT INTO `jc_log` VALUES ('117', '1', '1', '3', '2015-03-25 22:32:35', '127.0.0.1', '/fengling/admin/fengling/friendlink/o_delete.do', '删除友情链接', 'id=3;name=京东商城');
INSERT INTO `jc_log` VALUES ('118', '1', '1', '3', '2015-03-25 22:33:04', '127.0.0.1', '/fengling/admin/fengling/friendlink/o_update.do', '修改友情链接', 'id=1;name=个人博客');
INSERT INTO `jc_log` VALUES ('119', '1', '1', '3', '2015-03-25 22:33:35', '127.0.0.1', '/fengling/admin/fengling/friendlink/o_update.do', '修改友情链接', 'id=2;name=七十二颗星');
INSERT INTO `jc_log` VALUES ('120', '1', null, '1', '2015-03-26 21:56:21', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('121', '1', '1', '3', '2015-03-26 21:59:17', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=72;name=岁月如梭');
INSERT INTO `jc_log` VALUES ('122', '1', null, '1', '2015-03-26 22:04:20', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('123', '1', '1', '3', '2015-03-26 22:05:37', '127.0.0.1', '/fengling/admin/fengling/channel/o_update.do', '修改栏目', 'id=72;name=岁月如梭');
INSERT INTO `jc_log` VALUES ('124', '1', null, '1', '2015-03-26 22:18:30', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('125', '1', '1', '3', '2015-03-26 22:20:29', '127.0.0.1', '/fengling/admin/fengling/type/o_save.do', '增加内容类型', 'id=5;name=微博');
INSERT INTO `jc_log` VALUES ('126', '1', '1', '3', '2015-03-26 22:20:47', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=566;title=test');
INSERT INTO `jc_log` VALUES ('127', '1', null, '1', '2015-03-28 19:00:02', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('128', '1', '1', '3', '2015-03-28 19:00:28', '127.0.0.1', '/fengling/admin/fengling/topic/o_save.do', '增加专题', 'id=1;name=test');
INSERT INTO `jc_log` VALUES ('129', '1', '1', '3', '2015-03-28 19:10:37', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=565;title=亦真亦假：技术剖析WordPress黑帽SEO插件');
INSERT INTO `jc_log` VALUES ('130', '1', '1', '3', '2015-03-29 21:55:37', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=567;title=风陵渡口博客开通了，欢迎访问。');
INSERT INTO `jc_log` VALUES ('131', '1', '1', '3', '2015-03-29 22:03:17', '127.0.0.1', '/fengling/admin/fengling/tag/o_delete.do', '删除TAG', 'id=1;name=亦');
INSERT INTO `jc_log` VALUES ('132', '1', null, '1', '2015-03-29 22:27:13', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('133', '1', '1', '3', '2015-03-29 22:30:40', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=567;title=风陵渡口博客开通了，欢迎访问。');
INSERT INTO `jc_log` VALUES ('134', '1', null, '1', '2015-03-29 22:34:31', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('135', '1', null, '1', '2015-03-29 22:41:41', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('136', '1', '1', '3', '2015-03-29 22:42:07', '127.0.0.1', '/fengling/admin/fengling/config/o_mark_update.do', '修改水印设置', null);
INSERT INTO `jc_log` VALUES ('137', '1', '1', '3', '2015-03-29 22:42:27', '127.0.0.1', '/fengling/admin/fengling/config/o_mark_update.do', '修改水印设置', null);
INSERT INTO `jc_log` VALUES ('138', '1', '1', '3', '2015-03-29 22:42:33', '127.0.0.1', '/fengling/admin/fengling/config/o_mark_update.do', '修改水印设置', null);
INSERT INTO `jc_log` VALUES ('139', '1', '1', '3', '2015-03-29 22:43:29', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=567;title=风陵渡口博客开通了，欢迎访问。');
INSERT INTO `jc_log` VALUES ('140', '1', '1', '3', '2015-03-29 22:43:50', '127.0.0.1', '/fengling/admin/fengling/config/o_mark_update.do', '修改水印设置', null);
INSERT INTO `jc_log` VALUES ('141', '1', '1', '3', '2015-03-29 22:44:28', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=567;title=风陵渡口博客开通了，欢迎访问。');
INSERT INTO `jc_log` VALUES ('142', '1', '1', '3', '2015-03-29 22:57:54', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=568;title=姓名学笔画大全');
INSERT INTO `jc_log` VALUES ('143', '1', '1', '3', '2015-03-29 23:06:26', '127.0.0.1', '/fengling/admin/fengling/topic/o_delete.do', '删除专题', 'id=1;name=test');
INSERT INTO `jc_log` VALUES ('144', '1', '1', '3', '2015-03-29 23:07:35', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=569;title=女孩常用名');
INSERT INTO `jc_log` VALUES ('145', '1', '1', '3', '2015-03-29 23:09:57', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=570;title=男孩常用名');
INSERT INTO `jc_log` VALUES ('146', '1', '1', '3', '2015-03-29 23:12:36', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=571;title=五行属木的汉字');
INSERT INTO `jc_log` VALUES ('147', '1', '1', '3', '2015-03-29 23:13:19', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=572;title=五行属火的汉字');
INSERT INTO `jc_log` VALUES ('148', '1', '1', '3', '2015-03-29 23:14:23', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=573;title=五行属土的汉字');
INSERT INTO `jc_log` VALUES ('149', '1', '1', '3', '2015-03-29 23:15:19', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=574;title=五行属金的汉字');
INSERT INTO `jc_log` VALUES ('150', '1', '1', '3', '2015-03-29 23:17:06', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=575;title=五行属水的汉字');
INSERT INTO `jc_log` VALUES ('151', '1', null, '1', '2015-03-30 20:23:39', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('152', '1', '1', '3', '2015-03-30 20:28:35', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=576;title=QQ升到9个太阳需要58年左右时间! ');
INSERT INTO `jc_log` VALUES ('153', '1', '1', '3', '2015-03-30 20:31:20', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=577;title=Null value was assigned to a property of primitive type setter of 的原因与解决方案');
INSERT INTO `jc_log` VALUES ('154', '1', '1', '3', '2015-03-30 20:36:11', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=577;title=Null value was assigned to a property of primitive type setter of 的原因与解决方案');
INSERT INTO `jc_log` VALUES ('155', '1', '1', '3', '2015-03-30 20:38:00', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=578;title=实体类注解错误：Could not determine type for: com.xxx.entity.Site');
INSERT INTO `jc_log` VALUES ('156', '1', '1', '3', '2015-03-30 20:44:36', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=579;title=hibernate 注解方式配置OneToMany（一对多）连接查询（非外键）');
INSERT INTO `jc_log` VALUES ('157', '1', '1', '3', '2015-03-30 20:45:35', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=579;title=hibernate 注解方式配置OneToMany（一对多）连接查询（非外键）');
INSERT INTO `jc_log` VALUES ('158', '1', '1', '3', '2015-03-30 20:47:01', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=579;title=hibernate 注解方式配置OneToMany（一对多）连接查询（非外键）');
INSERT INTO `jc_log` VALUES ('159', '1', '1', '3', '2015-03-30 20:50:15', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=580;title=CSRF 攻击的应对之道');
INSERT INTO `jc_log` VALUES ('160', '1', null, '1', '2015-03-31 22:16:01', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('161', '1', '1', '3', '2015-03-31 22:19:13', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=581;title=2015-03-31');
INSERT INTO `jc_log` VALUES ('162', '1', '1', '3', '2015-03-31 22:23:22', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=582;title=Windows查看端口占用及杀掉进程');
INSERT INTO `jc_log` VALUES ('163', '1', '1', '3', '2015-03-31 22:26:42', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=583;title=spring mvc @PathVariable绑定URI模板变量值');
INSERT INTO `jc_log` VALUES ('164', '1', '1', '3', '2015-03-31 22:29:30', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=584;title=No Hibernate Session bound to thread, and configuration does not allow creation ');
INSERT INTO `jc_log` VALUES ('165', '1', '1', '3', '2015-03-31 22:33:22', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=585;title=Mysql复制表结构、表数据');
INSERT INTO `jc_log` VALUES ('166', '1', null, '1', '2015-04-01 19:16:54', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('167', '1', '1', '3', '2015-04-01 20:32:29', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=586;title=hibernate cascade解释');
INSERT INTO `jc_log` VALUES ('168', '1', '1', '3', '2015-04-01 20:34:38', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=587;title=myeclipse 配合tomcat启动导致虚拟机崩溃解决方法No shared spaces configured.');
INSERT INTO `jc_log` VALUES ('169', '1', '1', '3', '2015-04-01 20:35:58', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=588;title=jdk6版本下载地址');
INSERT INTO `jc_log` VALUES ('170', '1', '1', '3', '2015-04-01 20:37:26', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=588;title=jdk6版本下载地址');
INSERT INTO `jc_log` VALUES ('171', '1', '1', '3', '2015-04-01 20:39:30', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=589;title=jquery ajax 模板代码');
INSERT INTO `jc_log` VALUES ('172', '1', '1', '3', '2015-04-01 20:42:43', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=590;title=java servlet中通知以流的方式下载文件');
INSERT INTO `jc_log` VALUES ('173', '1', '1', '3', '2015-04-01 20:44:22', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=591;title=百度贴吧等级经验对照表');
INSERT INTO `jc_log` VALUES ('174', '1', null, '1', '2015-04-02 21:51:39', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('175', '1', '1', '3', '2015-04-02 21:57:43', '127.0.0.1', '/fengling/admin/fengling/channel/o_save.do', '增加栏目', 'id=95;title=null');
INSERT INTO `jc_log` VALUES ('176', '1', '1', '3', '2015-04-02 21:59:04', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=592;title=java程序员职业发展路线图');
INSERT INTO `jc_log` VALUES ('177', '1', '1', '3', '2015-04-02 22:01:51', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=593;title=Errors occurred during the build.  Errors running builder \'JavaScript Validator\'');
INSERT INTO `jc_log` VALUES ('178', '1', '1', '3', '2015-04-02 22:05:09', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=594;title=Error staring Tomcat Cannot connect to VM错误解决办法');
INSERT INTO `jc_log` VALUES ('179', '1', '1', '3', '2015-04-02 22:08:09', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=595;title=MyEclipse中更改SVN密码  ');
INSERT INTO `jc_log` VALUES ('180', '1', '1', '3', '2015-04-02 22:10:32', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=596;title=页面加载完毕后滚动到指定位置');
INSERT INTO `jc_log` VALUES ('181', '1', '1', '3', '2015-04-02 22:11:48', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=597;title=Nginx Location配置总结');
INSERT INTO `jc_log` VALUES ('182', '1', null, '1', '2015-04-06 13:06:28', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('183', '1', null, '1', '2015-04-06 13:08:03', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('184', '1', null, '1', '2015-04-06 13:11:19', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('185', '1', '1', '3', '2015-04-06 13:25:03', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=598;title=test');
INSERT INTO `jc_log` VALUES ('186', '1', null, '1', '2015-04-06 13:43:02', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('187', '1', '1', '3', '2015-04-06 13:44:02', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=599;title=test');
INSERT INTO `jc_log` VALUES ('188', '1', '1', '3', '2015-04-06 13:46:52', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=600;title=test');
INSERT INTO `jc_log` VALUES ('189', '1', null, '1', '2015-04-06 13:52:16', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('190', '1', null, '1', '2015-04-06 13:55:19', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('191', '1', null, '1', '2015-04-06 14:02:47', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('192', '1', null, '1', '2015-04-06 14:07:34', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('193', '1', '1', '3', '2015-04-06 14:09:01', '127.0.0.1', '/fengling/admin/fengling/content/o_save.do', '增加文章', 'id=601;title=test');
INSERT INTO `jc_log` VALUES ('194', '1', null, '1', '2015-04-06 14:22:52', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('195', '1', null, '1', '2015-04-06 14:25:46', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('196', '1', null, '1', '2015-04-06 14:28:28', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('197', '1', '1', '3', '2015-04-06 14:29:28', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=601;title=test');
INSERT INTO `jc_log` VALUES ('198', '1', null, '1', '2015-04-06 14:33:27', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('199', '1', '1', '3', '2015-04-06 14:34:18', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=601;title=test');
INSERT INTO `jc_log` VALUES ('200', '1', '1', '3', '2015-04-06 14:35:38', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=601;title=test');
INSERT INTO `jc_log` VALUES ('201', '1', '1', '3', '2015-04-06 14:36:10', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=601;title=test');
INSERT INTO `jc_log` VALUES ('202', '1', null, '1', '2015-04-06 16:07:53', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('203', '1', '1', '3', '2015-04-06 16:09:56', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=601;title=test');
INSERT INTO `jc_log` VALUES ('204', '1', null, '1', '2015-04-06 16:38:39', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('205', '1', '1', '3', '2015-04-06 16:48:44', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=601;title=test');
INSERT INTO `jc_log` VALUES ('206', '1', '1', '3', '2015-04-06 17:35:41', '127.0.0.1', '/fengling/admin/fengling/config/o_system_update.do', '修改系统设置', null);
INSERT INTO `jc_log` VALUES ('207', '1', null, '1', '2015-04-06 17:37:10', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('208', '1', '1', '3', '2015-04-06 17:38:00', '127.0.0.1', '/fengling/admin/fengling/config/o_system_update.do', '修改系统设置', null);
INSERT INTO `jc_log` VALUES ('209', '1', null, '1', '2015-04-06 18:40:33', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('210', '1', '1', '3', '2015-04-06 18:41:15', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=597;title=Nginx Location配置总结');
INSERT INTO `jc_log` VALUES ('211', '1', null, '1', '2015-04-06 18:43:46', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('212', '1', '1', '3', '2015-04-06 18:44:34', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=597;title=Nginx Location配置总结');
INSERT INTO `jc_log` VALUES ('213', '1', null, '1', '2015-04-06 18:51:52', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('214', '1', '1', '3', '2015-04-06 18:52:34', '127.0.0.1', '/fengling/admin/fengling/content/o_update.do', '修改文章', 'id=597;title=Nginx Location配置总结');
INSERT INTO `jc_log` VALUES ('215', '1', null, '1', '2015-04-09 21:59:55', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);
INSERT INTO `jc_log` VALUES ('216', '1', null, '1', '2015-04-09 22:02:10', '127.0.0.1', '/fengling/admin/fengling/login.do', 'login success', null);

-- ----------------------------
-- Table structure for `jc_message`
-- ----------------------------
DROP TABLE IF EXISTS `jc_message`;
CREATE TABLE `jc_message` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `msg_title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `msg_content` longtext COMMENT '站内信息内容',
  `send_time` timestamp NULL DEFAULT NULL COMMENT '发送时间',
  `msg_send_user` int(11) NOT NULL DEFAULT '1' COMMENT '发信息人',
  `msg_receiver_user` int(11) NOT NULL DEFAULT '0' COMMENT '接收人',
  `site_id` int(11) NOT NULL DEFAULT '1' COMMENT '站点',
  `msg_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消息状态0未读，1已读',
  `msg_box` int(2) NOT NULL DEFAULT '1' COMMENT '消息信箱 0收件箱 1发件箱 2草稿箱 3垃圾箱',
  PRIMARY KEY (`msg_id`),
  KEY `fk_jc_message_user_send` (`msg_send_user`),
  KEY `fk_jc_message_user_receiver` (`msg_receiver_user`),
  KEY `fk_jc_message_site` (`site_id`),
  CONSTRAINT `fk_jc_message_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_message_user_receiver` FOREIGN KEY (`msg_receiver_user`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_message_user_send` FOREIGN KEY (`msg_send_user`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站内信';

-- ----------------------------
-- Records of jc_message
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_model`
-- ----------------------------
DROP TABLE IF EXISTS `jc_model`;
CREATE TABLE `jc_model` (
  `model_id` int(11) NOT NULL,
  `model_name` varchar(100) NOT NULL COMMENT '名称',
  `model_path` varchar(100) NOT NULL COMMENT '路径',
  `tpl_channel_prefix` varchar(20) DEFAULT NULL COMMENT '栏目模板前缀',
  `tpl_content_prefix` varchar(20) DEFAULT NULL COMMENT '内容模板前缀',
  `title_img_width` int(11) NOT NULL DEFAULT '139' COMMENT '栏目标题图宽度',
  `title_img_height` int(11) NOT NULL DEFAULT '139' COMMENT '栏目标题图高度',
  `content_img_width` int(11) NOT NULL DEFAULT '310' COMMENT '栏目内容图宽度',
  `content_img_height` int(11) NOT NULL DEFAULT '310' COMMENT '栏目内容图高度',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `has_content` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有内容',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认模型',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS模型表';

-- ----------------------------
-- Records of jc_model
-- ----------------------------
INSERT INTO `jc_model` VALUES ('1', '新闻', '1', 'news', 'news', '139', '139', '310', '310', '1', '1', '0', '1');
INSERT INTO `jc_model` VALUES ('2', '单页', '2', 'alone', 'alone', '139', '139', '310', '310', '2', '0', '0', '0');
INSERT INTO `jc_model` VALUES ('4', '下载', '4', 'download', 'download', '139', '139', '310', '310', '4', '1', '0', '0');
INSERT INTO `jc_model` VALUES ('5', '图库', '5', 'pic', 'pic', '139', '139', '310', '310', '5', '1', '0', '0');
INSERT INTO `jc_model` VALUES ('6', '视频', '6', 'vedio', 'vedio', '139', '139', '310', '310', '10', '1', '0', '0');
INSERT INTO `jc_model` VALUES ('8', '招聘', 'job', 'job', 'job', '139', '139', '310', '310', '10', '1', '0', '0');

-- ----------------------------
-- Table structure for `jc_model_item`
-- ----------------------------
DROP TABLE IF EXISTS `jc_model_item`;
CREATE TABLE `jc_model_item` (
  `modelitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL,
  `field` varchar(50) NOT NULL COMMENT '字段',
  `item_label` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '70' COMMENT '排列顺序',
  `def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `opt_value` varchar(255) DEFAULT NULL COMMENT '可选项',
  `text_size` varchar(20) DEFAULT NULL COMMENT '长度',
  `area_rows` varchar(3) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(3) DEFAULT NULL COMMENT '文本列数',
  `help` varchar(255) DEFAULT NULL COMMENT '帮助信息',
  `help_position` varchar(1) DEFAULT NULL COMMENT '帮助位置',
  `data_type` int(11) NOT NULL DEFAULT '1' COMMENT '数据类型',
  `is_single` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否独占一行',
  `is_channel` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否栏目模型项',
  `is_custom` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否自定义',
  `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  PRIMARY KEY (`modelitem_id`),
  KEY `fk_jc_item_model` (`model_id`),
  CONSTRAINT `fk_jc_item_model` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=426 DEFAULT CHARSET=utf8 COMMENT='CMS模型项表';

-- ----------------------------
-- Records of jc_model_item
-- ----------------------------
INSERT INTO `jc_model_item` VALUES ('1', '1', 'name', '栏目名称', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('2', '1', 'path', '访问路径', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('3', '1', 'title', 'meta标题', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('4', '1', 'keywords', 'meta关键字', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('5', '1', 'description', 'meta描述', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('6', '1', 'tplChannel', '栏目模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('7', '1', 'tplContent', '选择模型模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('8', '1', 'channelStatic', '栏目静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('9', '1', 'contentStatic', '内容静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('10', '1', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('11', '1', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('12', '1', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('14', '1', 'afterCheck', '审核后', '11', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('15', '1', 'commentControl', '评论', '11', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('16', '1', 'allowUpdown', '顶踩', '11', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('17', '1', 'viewGroupIds', '浏览权限', '12', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('18', '1', 'contriGroupIds', '投稿权限', '12', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('20', '1', 'link', '外部链接', '12', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('21', '1', 'titleImg', '标题图', '12', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('23', '1', 'title', '标题', '9', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('24', '1', 'shortTitle', '简短标题', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('25', '1', 'titleColor', '标题颜色', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('26', '1', 'tagStr', 'Tag标签', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('27', '1', 'description', '摘要', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('28', '1', 'author', '作者', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('29', '1', 'origin', '来源', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('30', '1', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('31', '1', 'topLevel', '固顶级别', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('32', '1', 'releaseDate', '发布时间', '10', null, null, null, null, null, null, null, '5', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('33', '1', 'typeId', '内容类型', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('34', '1', 'tplContent', '指定模板', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('35', '1', 'typeImg', '类型图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('36', '1', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('37', '1', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('38', '1', 'attachments', '附件', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('39', '1', 'media', '多媒体', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('40', '1', 'txt', '内容', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('42', '2', 'name', '栏目名称', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('43', '2', 'path', '访问路径', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('44', '2', 'title', 'meta标题', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('45', '2', 'keywords', 'meta关键字', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('46', '2', 'description', 'meta描述', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('47', '2', 'tplChannel', '栏目模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('48', '2', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('49', '2', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('50', '2', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('51', '2', 'link', '外部链接', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('52', '2', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('53', '2', 'txt', '内容', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('93', '4', 'name', '栏目名称', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('94', '4', 'path', '访问路径', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('95', '4', 'title', 'meta标题', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('96', '4', 'keywords', 'meta关键字', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('97', '4', 'description', 'meta描述', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('98', '4', 'tplChannel', '栏目模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('99', '4', 'tplContent', '选择模型模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('100', '4', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('101', '4', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('102', '4', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('103', '4', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('104', '4', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('105', '4', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('107', '4', 'channelId', '栏目', '1', null, null, null, null, null, null, null, '6', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('108', '4', 'title', '软件名称', '2', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('109', '4', 'shortTitle', '软件简称', '3', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('110', '4', 'titleColor', '标题颜色', '4', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('111', '4', 'description', '摘要', '5', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('112', '4', 'author', '发布人', '6', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('113', '4', 'viewGroupIds', '浏览权限', '7', null, null, null, null, null, null, null, '7', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('114', '4', 'topLevel', '固顶级别', '8', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('115', '4', 'releaseDate', '发布时间', '9', null, null, null, null, null, null, null, '5', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('116', '4', 'typeId', '内容类型', '21', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('117', '4', 'tplContent', '指定模板', '22', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('118', '4', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('119', '4', 'attachments', '资源上传', '11', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('120', '4', 'txt', '软件介绍', '20', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('121', '4', 'softType', '软件类型', '12', '国产软件', '国产软件,国外软件', '100', '3', '30', null, null, '6', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('122', '4', 'warrant', '软件授权', '13', '免费版', '免费版,共享版', '', '3', '30', '', '', '6', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('123', '4', 'relatedLink', '相关链接', '14', 'http://', '', '50', '3', '30', '', '', '1', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('124', '4', 'demoUrl', '演示地址', '15', 'http://', null, '60', '3', '30', null, null, '1', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('125', '5', 'name', '栏目名称', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('126', '5', 'path', '访问路径', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('127', '5', 'title', 'meta标题', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('128', '5', 'keywords', 'meta关键字', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('129', '5', 'description', 'meta描述', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('130', '5', 'tplChannel', '栏目模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('131', '5', 'tplContent', '选择模型模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('132', '5', 'channelStatic', '栏目静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('133', '5', 'contentStatic', '内容静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('134', '5', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('135', '5', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('136', '5', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('138', '5', 'afterCheck', '审核后', '11', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('139', '5', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('140', '5', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('141', '5', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('142', '5', 'contriGroupIds', '投稿权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('144', '5', 'link', '外部链接', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('145', '5', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('146', '5', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('147', '5', 'channelId', '栏目', '10', null, null, null, null, null, null, null, '6', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('148', '5', 'title', '标题', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('149', '5', 'shortTitle', '简短标题', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('150', '5', 'titleColor', '标题颜色', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('151', '5', 'tagStr', 'Tag标签', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('152', '5', 'description', '摘要', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('153', '5', 'author', '作者', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('154', '5', 'origin', '来源', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('155', '5', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('156', '5', 'topLevel', '固顶级别', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('157', '5', 'releaseDate', '发布时间', '10', null, null, null, null, null, null, null, '5', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('158', '5', 'typeId', '内容类型', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('159', '5', 'tplContent', '指定模板', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('160', '5', 'typeImg', '类型图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('161', '5', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('162', '5', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('163', '5', 'pictures', '图片集', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('164', '6', 'name', '栏目名称', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('165', '6', 'path', '访问路径', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('166', '6', 'title', 'meta标题', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('167', '6', 'keywords', 'meta关键字', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('168', '6', 'description', 'meta描述', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('169', '6', 'tplChannel', '栏目模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('170', '6', 'tplContent', '选择模型模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('171', '6', 'channelStatic', '栏目静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('172', '6', 'contentStatic', '内容静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('173', '6', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('174', '6', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('175', '6', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('177', '6', 'afterCheck', '审核后', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('178', '6', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('179', '6', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('180', '6', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('181', '6', 'contriGroupIds', '投稿权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('183', '6', 'link', '外部链接', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('184', '6', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('185', '6', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('186', '6', 'channelId', '栏目', '10', null, null, null, null, null, null, null, '6', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('187', '6', 'title', '标题', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('188', '6', 'shortTitle', '简短标题', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('189', '6', 'titleColor', '标题颜色', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('190', '6', 'tagStr', 'Tag标签', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('191', '6', 'description', '内容简介', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('192', '6', 'author', '作者', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('193', '6', 'origin', '来源', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('194', '6', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('195', '6', 'topLevel', '固顶级别', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('196', '6', 'releaseDate', '发布时间', '10', null, null, null, null, null, null, null, '5', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('197', '6', 'typeId', '内容类型', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('198', '6', 'tplContent', '指定模板', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('199', '6', 'typeImg', '类型图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('200', '6', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('201', '6', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('202', '6', 'attachments', '附件', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('203', '6', 'media', '多媒体', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('246', '4', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('249', '8', 'name', '栏目名称', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('250', '8', 'path', '访问路径', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('251', '8', 'title', 'meta标题', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('252', '8', 'keywords', 'meta关键字', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('253', '8', 'description', 'meta描述', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('254', '8', 'tplChannel', '栏目模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('255', '8', 'tplContent', '选择模型模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('256', '8', 'channelStatic', '栏目静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('257', '8', 'contentStatic', '内容静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('258', '8', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('259', '8', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('260', '8', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('262', '8', 'afterCheck', '审核后', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('263', '8', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('264', '8', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('265', '8', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('266', '8', 'contriGroupIds', '投稿权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('268', '8', 'link', '外部链接', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('269', '8', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('270', '8', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('271', '8', 'channelId', '栏目', '1', null, null, null, null, null, null, null, '6', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('272', '8', 'title', '岗位名称', '1', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('275', '8', 'tagStr', 'Tag标签', '7', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('279', '8', 'viewGroupIds', '浏览权限', '8', null, null, null, null, null, null, null, '7', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('280', '8', 'topLevel', '固顶级别', '7', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('281', '8', 'releaseDate', '发布时间', '2', null, null, null, null, null, null, null, '5', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('282', '8', 'typeId', '内容类型', '7', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('283', '8', 'tplContent', '指定模板', '8', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('289', '8', 'txt', '职位描述', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('290', '8', 'deadline', '截止日期', '2', null, null, null, '3', '30', '留空永久有效', null, '5', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('291', '8', 'experience', '工作经验', '3', null, '1-3年,3-5年,5年以上,不限', null, '3', '30', null, null, '6', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('292', '8', 'education', '最低学历', '3', '', '专科,本科,硕士,不限', '', '3', '30', '', '', '6', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('293', '8', 'salary', '职位月薪', '4', null, '1500-2000,2000-3000,3000-5000,5000-8000,8000+,面议', null, '3', '30', null, null, '6', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('294', '8', 'workplace', '工作地点', '4', '', '北京,上海,深圳,广州,重庆,南京,杭州,西安,南昌', '', '3', '30', '', '', '7', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('295', '8', 'nature', '工作性质', '5', '', '全职,兼职', '', '3', '30', '', '', '8', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('296', '8', 'hasmanage', '管理经验', '5', '', '要求,不要求', '', '3', '30', '', '', '8', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('297', '8', 'nums', '招聘人数', '6', '', '1-3人,3-5人,5-10人,若干', '', '3', '30', '', '', '6', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('298', '8', 'category', '职位类别', '6', null, '项目主管,java高级工程师,java工程师,网页设计师,测试人员,技术支持', null, '3', '30', null, null, '6', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('344', '1', 'channelId', '栏目', '8', null, null, null, null, null, null, null, '6', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('403', '6', 'Director', '导演', '10', '', '', '', '1', '2', '', '', '1', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('404', '6', 'Starring', '主演', '10', '', '', '', '1', '30', '', '', '1', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('405', '6', 'VideoType', '视频类型', '10', null, '历史,古装,都市,喜剧,悬疑,动作,谍战,伦理,战争,惊悚', null, '3', '30', null, null, '7', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('406', '6', 'Video', '影片信息', '10', '', '正片,预告片', '', '3', '30', '', '', '6', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('408', '1', 'contentImg', '内容图', '12', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('409', '5', 'txt', '内容', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('410', '6', 'txt', '内容', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('412', '1', 'allowShare', '分享', '11', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('413', '1', 'allowScore', '评分', '11', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('414', '1', 'pictures', '图片集', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('415', '1', 'finalStep', '终审级别', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('420', '6', 'finalStep', '终审级别', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('421', '6', 'allowShare', '分享', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('422', '6', 'allowScore', '评分', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('423', '8', 'finalStep', '终审级别', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('424', '8', 'allowShare', '分享', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('425', '8', 'allowScore', '评分', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');

-- ----------------------------
-- Table structure for `jc_origin`
-- ----------------------------
DROP TABLE IF EXISTS `jc_origin`;
CREATE TABLE `jc_origin` (
  `origin_id` int(11) NOT NULL AUTO_INCREMENT,
  `origin_name` varchar(255) NOT NULL COMMENT '来源名称',
  `ref_count` int(11) NOT NULL DEFAULT '0' COMMENT '来源文章总数',
  PRIMARY KEY (`origin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='来源';

-- ----------------------------
-- Records of jc_origin
-- ----------------------------
INSERT INTO `jc_origin` VALUES ('1', '新浪微博', '0');
INSERT INTO `jc_origin` VALUES ('2', '百度', '0');
INSERT INTO `jc_origin` VALUES ('3', '百度论坛', '0');
INSERT INTO `jc_origin` VALUES ('4', '百度贴吧', '0');
INSERT INTO `jc_origin` VALUES ('5', '新浪新闻', '0');
INSERT INTO `jc_origin` VALUES ('6', '腾讯新闻', '0');

-- ----------------------------
-- Table structure for `jc_plug`
-- ----------------------------
DROP TABLE IF EXISTS `jc_plug`;
CREATE TABLE `jc_plug` (
  `plug_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '插件名称',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `description` varchar(2000) DEFAULT NULL COMMENT '描述',
  `author` varchar(255) DEFAULT NULL COMMENT '作者',
  `upload_time` datetime NOT NULL COMMENT '上传时间',
  `install_time` datetime DEFAULT NULL COMMENT '安装时间',
  `uninstall_time` datetime DEFAULT NULL COMMENT '卸载时间',
  `file_conflict` tinyint(1) NOT NULL DEFAULT '0' COMMENT '包含文件是否冲突',
  `is_used` tinyint(1) NOT NULL DEFAULT '0' COMMENT '使用状态(0未使用,1使用中)',
  `plug_perms` varchar(255) DEFAULT '' COMMENT '插件权限（,分隔各个权限配置）',
  PRIMARY KEY (`plug_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='插件';

-- ----------------------------
-- Records of jc_plug
-- ----------------------------
INSERT INTO `jc_plug` VALUES ('4', '测试1', '/WEB-INF/plug/test.zip', '测试测试', 'TOM', '2014-01-04 16:49:47', '2014-02-19 09:49:31', '2014-02-19 09:49:15', '0', '0', 'test:*');

-- ----------------------------
-- Table structure for `jc_receiver_message`
-- ----------------------------
DROP TABLE IF EXISTS `jc_receiver_message`;
CREATE TABLE `jc_receiver_message` (
  `msg_re_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `msg_title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `msg_content` longtext COMMENT '站内信息内容',
  `send_time` timestamp NULL DEFAULT NULL COMMENT '发送时间',
  `msg_send_user` int(11) NOT NULL DEFAULT '1' COMMENT '发信息人',
  `msg_receiver_user` int(11) NOT NULL DEFAULT '0' COMMENT '接收人',
  `site_id` int(11) NOT NULL DEFAULT '1' COMMENT '站点',
  `msg_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消息状态0未读，1已读',
  `msg_box` int(2) NOT NULL DEFAULT '1' COMMENT '消息信箱 0收件箱 1发件箱 2草稿箱 3垃圾箱',
  `msg_id` int(11) DEFAULT NULL COMMENT '发信的信件id',
  PRIMARY KEY (`msg_re_id`),
  KEY `jc_receiver_message_user_send` (`msg_send_user`),
  KEY `jc_receiver_message_user_receiver` (`msg_receiver_user`),
  KEY `jc_receiver_message_site` (`site_id`),
  KEY `jc_receiver_message_message` (`msg_re_id`),
  KEY `fk_jc_receiver_message_message` (`msg_id`),
  CONSTRAINT `fk_jc_receiver_message_message` FOREIGN KEY (`msg_id`) REFERENCES `jc_message` (`msg_id`),
  CONSTRAINT `fk_jc_receiver_message_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_receiver_message_user_receiver` FOREIGN KEY (`msg_receiver_user`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_receiver_message_user_send` FOREIGN KEY (`msg_send_user`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='站内信收信表';

-- ----------------------------
-- Records of jc_receiver_message
-- ----------------------------
INSERT INTO `jc_receiver_message` VALUES ('1', 'aa', 'aaa', '2014-01-22 09:44:32', '1', '1', '1', '1', '0', null);
INSERT INTO `jc_receiver_message` VALUES ('2', 'aa', 'aaa', '2014-01-22 09:44:32', '1', '1', '1', '0', '3', null);

-- ----------------------------
-- Table structure for `jc_role`
-- ----------------------------
DROP TABLE IF EXISTS `jc_role`;
CREATE TABLE `jc_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `role_name` varchar(100) NOT NULL COMMENT '角色名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `is_super` char(1) NOT NULL DEFAULT '0' COMMENT '拥有所有权限',
  PRIMARY KEY (`role_id`),
  KEY `fk_jc_role_site` (`site_id`),
  CONSTRAINT `fk_jc_role_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS角色表';

-- ----------------------------
-- Records of jc_role
-- ----------------------------
INSERT INTO `jc_role` VALUES ('1', null, '管理员', '10', '1');

-- ----------------------------
-- Table structure for `jc_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `jc_role_permission`;
CREATE TABLE `jc_role_permission` (
  `role_id` int(11) NOT NULL,
  `uri` varchar(100) NOT NULL,
  KEY `fk_jc_permission_role` (`role_id`),
  CONSTRAINT `fk_jc_permission_role` FOREIGN KEY (`role_id`) REFERENCES `jc_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS角色授权表';

-- ----------------------------
-- Records of jc_role_permission
-- ----------------------------
INSERT INTO `jc_role_permission` VALUES ('1', '/top.do');
INSERT INTO `jc_role_permission` VALUES ('1', '/right.do');
INSERT INTO `jc_role_permission` VALUES ('1', '/main.do');
INSERT INTO `jc_role_permission` VALUES ('1', '/left.do');
INSERT INTO `jc_role_permission` VALUES ('1', '/index.do');
INSERT INTO `jc_role_permission` VALUES ('1', '/message/v_countUnreadMsg.do');
INSERT INTO `jc_role_permission` VALUES ('1', '/content/o_generateTags.do');
INSERT INTO `jc_role_permission` VALUES ('1', '/map.do');
INSERT INTO `jc_role_permission` VALUES ('1', '/statistic_member/v_list.do');
INSERT INTO `jc_role_permission` VALUES ('1', 'admin_global:v_list:*');
INSERT INTO `jc_role_permission` VALUES ('1', 'admin_local:v_list:*');
INSERT INTO `jc_role_permission` VALUES ('1', '/admin_local/v_edit/2');
INSERT INTO `jc_role_permission` VALUES ('1', 'admin_local:v_list');

-- ----------------------------
-- Table structure for `jc_score_group`
-- ----------------------------
DROP TABLE IF EXISTS `jc_score_group`;
CREATE TABLE `jc_score_group` (
  `score_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '分组名',
  `description` varchar(1000) DEFAULT NULL COMMENT '描述',
  `enable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用',
  `def` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否默认',
  `site_id` int(11) NOT NULL COMMENT '站点',
  PRIMARY KEY (`score_group_id`),
  KEY `fk_jc_score_group_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='FComment';

-- ----------------------------
-- Records of jc_score_group
-- ----------------------------
INSERT INTO `jc_score_group` VALUES ('1', '心情组', '心情组', '1', '1', '1');
INSERT INTO `jc_score_group` VALUES ('2', '星级评分', '星级评分', '1', '0', '1');

-- ----------------------------
-- Table structure for `jc_score_item`
-- ----------------------------
DROP TABLE IF EXISTS `jc_score_item`;
CREATE TABLE `jc_score_item` (
  `score_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `score_group_id` int(11) NOT NULL COMMENT '评分组',
  `name` varchar(255) NOT NULL COMMENT '评分名',
  `score` int(11) NOT NULL COMMENT '分值',
  `image_path` varchar(255) DEFAULT NULL COMMENT '评分图标路径',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  PRIMARY KEY (`score_item_id`),
  KEY `fk_jc_score_item_group` (`score_group_id`),
  CONSTRAINT `fk_jc_score_item_group` FOREIGN KEY (`score_group_id`) REFERENCES `jc_score_group` (`score_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='评分项';

-- ----------------------------
-- Records of jc_score_item
-- ----------------------------
INSERT INTO `jc_score_item` VALUES ('1', '1', '开心', '1', '/r/cms/smilies/m1.gif', '1');
INSERT INTO `jc_score_item` VALUES ('2', '1', '板砖', '1', '/r/cms/smilies/m2.gif', '2');
INSERT INTO `jc_score_item` VALUES ('3', '1', '感动', '1', '/r/cms/smilies/m3.gif', '3');
INSERT INTO `jc_score_item` VALUES ('4', '1', '有用', '1', '/r/cms/smilies/m4.gif', '4');
INSERT INTO `jc_score_item` VALUES ('5', '1', '疑问', '1', '/r/cms/smilies/m5.gif', '5');
INSERT INTO `jc_score_item` VALUES ('6', '1', '难过', '1', '/r/cms/smilies/m6.gif', '6');
INSERT INTO `jc_score_item` VALUES ('7', '1', '无聊', '1', '/r/cms/smilies/m7.gif', '7');
INSERT INTO `jc_score_item` VALUES ('8', '1', '震惊', '1', '/r/cms/smilies/m8.gif', '8');
INSERT INTO `jc_score_item` VALUES ('9', '2', '非常差', '1', '', '1');
INSERT INTO `jc_score_item` VALUES ('10', '2', '差', '2', '', '2');
INSERT INTO `jc_score_item` VALUES ('11', '2', '一般', '3', '', '3');
INSERT INTO `jc_score_item` VALUES ('12', '2', '好', '4', '', '4');
INSERT INTO `jc_score_item` VALUES ('13', '2', '非常好', '5', '', '5');

-- ----------------------------
-- Table structure for `jc_score_record`
-- ----------------------------
DROP TABLE IF EXISTS `jc_score_record`;
CREATE TABLE `jc_score_record` (
  `score_record_id` int(11) NOT NULL AUTO_INCREMENT,
  `score_item_id` int(11) NOT NULL COMMENT '评分项',
  `content_id` int(11) NOT NULL COMMENT '内容',
  `score_count` int(11) NOT NULL COMMENT '评分次数',
  PRIMARY KEY (`score_record_id`),
  KEY `fk_jc_record_score_item` (`score_item_id`),
  KEY `index_score_record_content` (`content_id`),
  CONSTRAINT `fk_jc_record_score_item` FOREIGN KEY (`score_item_id`) REFERENCES `jc_score_item` (`score_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评分纪录';

-- ----------------------------
-- Records of jc_score_record
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_search_words`
-- ----------------------------
DROP TABLE IF EXISTS `jc_search_words`;
CREATE TABLE `jc_search_words` (
  `word_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '搜索词汇',
  `hit_count` int(11) NOT NULL DEFAULT '0' COMMENT '搜索次数',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '优先级',
  `name_initial` varchar(500) NOT NULL DEFAULT '' COMMENT '拼音首字母',
  PRIMARY KEY (`word_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='搜索热词';

-- ----------------------------
-- Records of jc_search_words
-- ----------------------------
INSERT INTO `jc_search_words` VALUES ('1', '国内新闻', '0', '2', 'gnxw');
INSERT INTO `jc_search_words` VALUES ('4', '中大云锦', '0', '1', 'zdyj');
INSERT INTO `jc_search_words` VALUES ('5', '中国建设', '60', '2', 'zgjs');
INSERT INTO `jc_search_words` VALUES ('6', '中国农业银行', '0', '2', 'zgnyyx');
INSERT INTO `jc_search_words` VALUES ('7', '中国建设银行', '12', '10', 'zgjsyx');
INSERT INTO `jc_search_words` VALUES ('8', '江西', '1', '10', 'jx');
INSERT INTO `jc_search_words` VALUES ('9', '南昌', '22', '10', 'nc');
INSERT INTO `jc_search_words` VALUES ('10', '新闻', '9', '10', 'xw');
INSERT INTO `jc_search_words` VALUES ('11', '家', '3', '10', 'j');
INSERT INTO `jc_search_words` VALUES ('13', '毛泽东', '8', '10', 'mzd');
INSERT INTO `jc_search_words` VALUES ('14', '刘晓庆', '10', '10', 'lxq');
INSERT INTO `jc_search_words` VALUES ('15', '广西 ', '1', '10', 'gx');
INSERT INTO `jc_search_words` VALUES ('17', '国内', '16', '10', 'gn');
INSERT INTO `jc_search_words` VALUES ('18', '巴基斯坦', '1', '10', 'bjst');

-- ----------------------------
-- Table structure for `jc_sensitivity`
-- ----------------------------
DROP TABLE IF EXISTS `jc_sensitivity`;
CREATE TABLE `jc_sensitivity` (
  `sensitivity_id` int(11) NOT NULL AUTO_INCREMENT,
  `search` varchar(255) NOT NULL COMMENT '敏感词',
  `replacement` varchar(255) NOT NULL COMMENT '替换词',
  PRIMARY KEY (`sensitivity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS敏感词表';

-- ----------------------------
-- Records of jc_sensitivity
-- ----------------------------
INSERT INTO `jc_sensitivity` VALUES ('1', '法论功', '***');

-- ----------------------------
-- Table structure for `jc_site`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site`;
CREATE TABLE `jc_site` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) NOT NULL COMMENT '配置ID',
  `ftp_upload_id` int(11) DEFAULT NULL COMMENT '上传ftp',
  `domain` varchar(50) NOT NULL COMMENT '域名',
  `site_path` varchar(20) NOT NULL COMMENT '路径',
  `site_name` varchar(100) NOT NULL COMMENT '网站名称',
  `short_name` varchar(100) NOT NULL COMMENT '简短名称',
  `protocol` varchar(20) NOT NULL DEFAULT 'http://' COMMENT '协议',
  `dynamic_suffix` varchar(10) NOT NULL DEFAULT '.jhtml' COMMENT '动态页后缀',
  `static_suffix` varchar(10) NOT NULL DEFAULT '.html' COMMENT '静态页后缀',
  `static_dir` varchar(50) DEFAULT NULL COMMENT '静态页存放目录',
  `is_index_to_root` char(1) NOT NULL DEFAULT '0' COMMENT '是否使用将首页放在根目录下',
  `is_static_index` char(1) NOT NULL DEFAULT '0' COMMENT '是否静态化首页',
  `locale_admin` varchar(10) NOT NULL DEFAULT 'zh_CN' COMMENT '后台本地化',
  `locale_front` varchar(10) NOT NULL DEFAULT 'zh_CN' COMMENT '前台本地化',
  `tpl_solution` varchar(50) NOT NULL DEFAULT 'default' COMMENT '模板方案',
  `final_step` tinyint(4) NOT NULL DEFAULT '2' COMMENT '终审级别',
  `after_check` tinyint(4) NOT NULL DEFAULT '2' COMMENT '审核后(1:不能修改删除;2:修改后退回;3:修改后不变)',
  `is_relative_path` char(1) NOT NULL DEFAULT '1' COMMENT '是否使用相对路径',
  `is_recycle_on` char(1) NOT NULL DEFAULT '1' COMMENT '是否开启回收站',
  `domain_alias` varchar(255) DEFAULT NULL COMMENT '域名别名',
  `domain_redirect` varchar(255) DEFAULT NULL COMMENT '域名重定向',
  `tpl_index` varchar(255) DEFAULT NULL COMMENT '首页模板',
  `keywords` varchar(255) DEFAULT NULL COMMENT '站点关键字',
  `description` varchar(255) DEFAULT NULL COMMENT '站点描述',
  PRIMARY KEY (`site_id`),
  UNIQUE KEY `ak_domain_path` (`domain`),
  KEY `fk_jc_site_config` (`config_id`),
  KEY `fk_jc_site_upload_ftp` (`ftp_upload_id`),
  CONSTRAINT `fk_jc_site_config` FOREIGN KEY (`config_id`) REFERENCES `jc_config` (`config_id`),
  CONSTRAINT `fk_jc_site_upload_ftp` FOREIGN KEY (`ftp_upload_id`) REFERENCES `jo_ftp` (`ftp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS站点表';

-- ----------------------------
-- Records of jc_site
-- ----------------------------
INSERT INTO `jc_site` VALUES ('1', '1', null, 'localhost', 'blog', '风陵渡口博客', '风陵渡口博客', 'http://', '.jhtml', '.html', '/jx', '0', '0', 'zh_CN', 'zh_CN', 'default', '3', '3', '0', '1', '', '', '/WEB-INF/t/cms/blog/default/index/index.html', '', '');

-- ----------------------------
-- Table structure for `jc_site_access`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_access`;
CREATE TABLE `jc_site_access` (
  `access_id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(32) NOT NULL DEFAULT '',
  `site_id` int(11) NOT NULL COMMENT '站点id',
  `access_time` time NOT NULL COMMENT '访问时间',
  `access_date` date NOT NULL COMMENT '访问日期',
  `ip` varchar(50) NOT NULL DEFAULT '',
  `area` varchar(50) DEFAULT NULL COMMENT '访问地区',
  `access_source` varchar(255) DEFAULT NULL COMMENT '访问来源',
  `external_link` varchar(255) DEFAULT NULL COMMENT '外部链接网址',
  `engine` varchar(50) DEFAULT NULL COMMENT '搜索引擎',
  `entry_page` varchar(255) DEFAULT NULL COMMENT '入口页面',
  `last_stop_page` varchar(255) DEFAULT NULL COMMENT '最后停留页面',
  `visit_second` int(11) DEFAULT NULL COMMENT '访问时长(秒)',
  `visit_page_count` int(11) DEFAULT NULL COMMENT '访问页面数',
  `operating_system` varchar(50) DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(50) DEFAULT NULL COMMENT '浏览器',
  `keyword` varchar(255) DEFAULT NULL COMMENT '来访关键字',
  PRIMARY KEY (`access_id`),
  KEY `fk_jc_access_site` (`site_id`),
  CONSTRAINT `fk_jc_access_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='站点访问表';

-- ----------------------------
-- Records of jc_site_access
-- ----------------------------
INSERT INTO `jc_site_access` VALUES ('26', '276179637EE241332635B4B9AF22B437', '1', '22:44:25', '2015-04-09', '127.0.0.1', '', '', null, null, 'http://localhost:8080/fengling/', 'http://localhost:8080/fengling/kfgj/597.jhtml', '1297', '20', 'Win 7', 'firefox 37', '');

-- ----------------------------
-- Table structure for `jc_site_access_count`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_access_count`;
CREATE TABLE `jc_site_access_count` (
  `access_count` int(11) NOT NULL AUTO_INCREMENT,
  `page_count` int(11) NOT NULL DEFAULT '1' COMMENT '访问页数',
  `visitors` int(11) NOT NULL DEFAULT '0' COMMENT '用户数',
  `statistic_date` date NOT NULL COMMENT '统计日期',
  `site_id` int(11) NOT NULL COMMENT '统计站点',
  PRIMARY KEY (`access_count`),
  KEY `fk_jc_access_count_site` (`site_id`),
  CONSTRAINT `fk_jc_access_count_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='每日统计页数访问情况';

-- ----------------------------
-- Records of jc_site_access_count
-- ----------------------------
INSERT INTO `jc_site_access_count` VALUES ('1', '2', '1', '2015-03-17', '1');
INSERT INTO `jc_site_access_count` VALUES ('2', '3', '1', '2015-03-17', '1');
INSERT INTO `jc_site_access_count` VALUES ('3', '1', '1', '2015-03-18', '1');
INSERT INTO `jc_site_access_count` VALUES ('4', '2', '1', '2015-03-22', '1');
INSERT INTO `jc_site_access_count` VALUES ('5', '4', '1', '2015-03-24', '1');
INSERT INTO `jc_site_access_count` VALUES ('6', '29', '1', '2015-03-25', '1');
INSERT INTO `jc_site_access_count` VALUES ('7', '37', '1', '2015-03-25', '1');
INSERT INTO `jc_site_access_count` VALUES ('8', '33', '1', '2015-03-26', '1');
INSERT INTO `jc_site_access_count` VALUES ('9', '9', '1', '2015-03-26', '1');
INSERT INTO `jc_site_access_count` VALUES ('10', '10', '1', '2015-03-26', '1');
INSERT INTO `jc_site_access_count` VALUES ('11', '34', '1', '2015-03-28', '1');
INSERT INTO `jc_site_access_count` VALUES ('12', '19', '1', '2015-03-29', '1');
INSERT INTO `jc_site_access_count` VALUES ('13', '46', '1', '2015-03-30', '1');
INSERT INTO `jc_site_access_count` VALUES ('14', '1', '1', '2015-03-31', '1');
INSERT INTO `jc_site_access_count` VALUES ('15', '25', '1', '2015-03-31', '1');
INSERT INTO `jc_site_access_count` VALUES ('16', '14', '1', '2015-04-01', '1');
INSERT INTO `jc_site_access_count` VALUES ('17', '16', '1', '2015-04-02', '1');
INSERT INTO `jc_site_access_count` VALUES ('18', '1', '2', '2015-04-06', '1');
INSERT INTO `jc_site_access_count` VALUES ('19', '2', '1', '2015-04-06', '1');
INSERT INTO `jc_site_access_count` VALUES ('20', '4', '1', '2015-04-06', '1');
INSERT INTO `jc_site_access_count` VALUES ('21', '5', '1', '2015-04-06', '1');
INSERT INTO `jc_site_access_count` VALUES ('22', '6', '1', '2015-04-06', '1');
INSERT INTO `jc_site_access_count` VALUES ('23', '9', '1', '2015-04-06', '1');
INSERT INTO `jc_site_access_count` VALUES ('24', '15', '1', '2015-04-06', '1');

-- ----------------------------
-- Table structure for `jc_site_access_pages`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_access_pages`;
CREATE TABLE `jc_site_access_pages` (
  `access_pages_id` int(11) NOT NULL AUTO_INCREMENT,
  `access_page` varchar(255) NOT NULL COMMENT '访问页面',
  `session_id` varchar(32) NOT NULL,
  `access_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '访问日期',
  `access_time` time NOT NULL COMMENT '访问时间',
  `visit_second` int(11) NOT NULL DEFAULT '0' COMMENT '停留时长（秒）',
  `page_index` int(11) NOT NULL DEFAULT '0' COMMENT '用户访问页面的索引',
  `site_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`access_pages_id`),
  KEY `fk_jc_access_pages_access` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8 COMMENT='访问详细页面表';

-- ----------------------------
-- Records of jc_site_access_pages
-- ----------------------------
INSERT INTO `jc_site_access_pages` VALUES ('227', 'http://localhost:8080/fengling/', '276179637EE241332635B4B9AF22B437', '2015-04-09', '22:44:25', '60', '1', '1');
INSERT INTO `jc_site_access_pages` VALUES ('228', 'http://localhost:8080/fengling/', '276179637EE241332635B4B9AF22B437', '2015-04-09', '22:45:25', '233', '2', '1');
INSERT INTO `jc_site_access_pages` VALUES ('229', 'http://localhost:8080/fengling/kfgj/597.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '22:49:18', '45', '3', '1');
INSERT INTO `jc_site_access_pages` VALUES ('230', 'http://localhost:8080/fengling/JavaScript/596.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '22:50:03', '17', '4', '1');
INSERT INTO `jc_site_access_pages` VALUES ('231', 'http://localhost:8080/fengling/', '276179637EE241332635B4B9AF22B437', '2015-04-09', '22:51:18', '16', '7', '1');
INSERT INTO `jc_site_access_pages` VALUES ('232', 'http://localhost:8080/fengling/kfgj/595.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '22:50:20', '8', '5', '1');
INSERT INTO `jc_site_access_pages` VALUES ('233', 'http://localhost:8080/fengling/mbdm/590.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '22:50:28', '50', '6', '1');
INSERT INTO `jc_site_access_pages` VALUES ('234', 'http://localhost:8080/fengling/kfgj/597.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '22:52:22', '99', '9', '1');
INSERT INTO `jc_site_access_pages` VALUES ('235', 'http://localhost:8080/fengling/cwcl/577.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '22:51:34', '48', '8', '1');
INSERT INTO `jc_site_access_pages` VALUES ('236', 'http://localhost:8080/fengling/kfgj/597.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '22:54:01', '0', '10', '1');
INSERT INTO `jc_site_access_pages` VALUES ('237', 'http://localhost:8080/fengling/database/585.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '23:02:52', '18', '16', '1');
INSERT INTO `jc_site_access_pages` VALUES ('238', 'http://localhost:8080/fengling/enjoy/591.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '23:04:37', '52', '18', '1');
INSERT INTO `jc_site_access_pages` VALUES ('239', 'http://localhost:8080/fengling/JavaScript/596.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '23:03:10', '87', '17', '1');
INSERT INTO `jc_site_access_pages` VALUES ('240', 'http://localhost:8080/fengling/enjoy/576.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '23:05:29', '33', '19', '1');
INSERT INTO `jc_site_access_pages` VALUES ('241', 'http://localhost:8080/fengling/kfgj/597.jhtml', '276179637EE241332635B4B9AF22B437', '2015-04-09', '23:06:02', '0', '20', '1');

-- ----------------------------
-- Table structure for `jc_site_access_statistic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_access_statistic`;
CREATE TABLE `jc_site_access_statistic` (
  `access_statistic_id` int(11) NOT NULL AUTO_INCREMENT,
  `statistic_date` date NOT NULL COMMENT '统计日期',
  `pv` int(11) NOT NULL DEFAULT '0' COMMENT 'pv量',
  `ip` int(11) NOT NULL DEFAULT '0' COMMENT 'ip量',
  `visitors` int(11) NOT NULL DEFAULT '0' COMMENT '访客数量',
  `pages_aver` int(11) NOT NULL DEFAULT '0' COMMENT '人均浏览次数',
  `visit_second_aver` int(11) NOT NULL DEFAULT '0' COMMENT '人均访问时长（秒）',
  `site_id` int(11) NOT NULL COMMENT '站点id',
  `statisitc_type` varchar(255) NOT NULL DEFAULT 'all' COMMENT '统计分类（all代表当天所有访问量的统计）',
  `statistic_column_value` varchar(255) DEFAULT '' COMMENT '统计列值',
  PRIMARY KEY (`access_statistic_id`),
  KEY `fk_jc_access_statistic_site` (`site_id`),
  CONSTRAINT `fk_jc_access_statistic_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='访问统计表';

-- ----------------------------
-- Records of jc_site_access_statistic
-- ----------------------------
INSERT INTO `jc_site_access_statistic` VALUES ('1', '2015-03-17', '5', '1', '2', '2', '2039', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('2', '2015-03-17', '3', '1', '1', '3', '3', '1', 'source', '');
INSERT INTO `jc_site_access_statistic` VALUES ('3', '2015-03-17', '2', '1', '1', '2', '4075', '1', 'source', '直接访问');
INSERT INTO `jc_site_access_statistic` VALUES ('4', '2015-03-18', '1', '1', '1', '1', '0', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('5', '2015-03-18', '1', '1', '1', '1', '0', '1', 'source', '直接访问');
INSERT INTO `jc_site_access_statistic` VALUES ('6', '2015-03-22', '2', '1', '1', '2', '95', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('7', '2015-03-22', '2', '1', '1', '2', '95', '1', 'source', '直接访问');
INSERT INTO `jc_site_access_statistic` VALUES ('8', '2015-03-24', '4', '1', '1', '4', '104', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('9', '2015-03-24', '4', '1', '1', '4', '104', '1', 'source', '直接访问');
INSERT INTO `jc_site_access_statistic` VALUES ('10', '2015-03-25', '66', '1', '2', '33', '2255', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('11', '2015-03-25', '29', '1', '1', '29', '2102', '1', 'source', '');
INSERT INTO `jc_site_access_statistic` VALUES ('12', '2015-03-25', '37', '1', '1', '37', '2409', '1', 'source', '直接访问');
INSERT INTO `jc_site_access_statistic` VALUES ('13', '2015-03-26', '52', '1', '3', '17', '1015', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('14', '2015-03-26', '52', '1', '3', '17', '1015', '1', 'source', '直接访问');
INSERT INTO `jc_site_access_statistic` VALUES ('15', '2015-03-28', '34', '1', '1', '34', '11875', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('16', '2015-03-28', '34', '1', '1', '34', '11875', '1', 'source', '');
INSERT INTO `jc_site_access_statistic` VALUES ('17', '2015-03-29', '19', '1', '1', '19', '2232', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('18', '2015-03-29', '19', '1', '1', '19', '2232', '1', 'source', '直接访问');
INSERT INTO `jc_site_access_statistic` VALUES ('19', '2015-03-30', '46', '1', '1', '46', '4758', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('20', '2015-03-30', '46', '1', '1', '46', '4758', '1', 'source', '直接访问');
INSERT INTO `jc_site_access_statistic` VALUES ('21', '2015-03-31', '26', '1', '2', '13', '871', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('22', '2015-03-31', '26', '1', '2', '13', '871', '1', 'source', '');
INSERT INTO `jc_site_access_statistic` VALUES ('23', '2015-04-01', '14', '1', '1', '14', '778', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('24', '2015-04-01', '14', '1', '1', '14', '778', '1', 'source', '直接访问');
INSERT INTO `jc_site_access_statistic` VALUES ('25', '2015-04-02', '16', '1', '1', '16', '1213', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('26', '2015-04-02', '16', '1', '1', '16', '1213', '1', 'source', '直接访问');
INSERT INTO `jc_site_access_statistic` VALUES ('27', '2015-04-06', '43', '1', '8', '5', '406', '1', 'all', '');
INSERT INTO `jc_site_access_statistic` VALUES ('28', '2015-04-06', '5', '1', '1', '5', '150', '1', 'source', '');
INSERT INTO `jc_site_access_statistic` VALUES ('29', '2015-04-06', '38', '1', '7', '5', '442', '1', 'source', '直接访问');

-- ----------------------------
-- Table structure for `jc_site_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_attr`;
CREATE TABLE `jc_site_attr` (
  `site_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_site` (`site_id`),
  CONSTRAINT `fk_jc_attr_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点属性表';

-- ----------------------------
-- Records of jc_site_attr
-- ----------------------------
INSERT INTO `jc_site_attr` VALUES ('1', 'pvTotal', '408');
INSERT INTO `jc_site_attr` VALUES ('1', 'visitors', '61');

-- ----------------------------
-- Table structure for `jc_site_cfg`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_cfg`;
CREATE TABLE `jc_site_cfg` (
  `site_id` int(11) NOT NULL,
  `cfg_name` varchar(30) NOT NULL COMMENT '名称',
  `cfg_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_cfg_site` (`site_id`),
  CONSTRAINT `fk_jc_cfg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点配置表';

-- ----------------------------
-- Records of jc_site_cfg
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_site_company`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_company`;
CREATE TABLE `jc_site_company` (
  `site_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '公司名称',
  `scale` varchar(255) DEFAULT NULL COMMENT '公司规模',
  `nature` varchar(255) DEFAULT NULL COMMENT '公司性质',
  `industry` varchar(1000) DEFAULT NULL COMMENT '公司行业',
  `contact` varchar(500) DEFAULT NULL COMMENT '联系方式',
  `description` text COMMENT '公司简介',
  `address` varchar(500) DEFAULT NULL COMMENT '公司地址',
  `longitude` float(5,2) DEFAULT NULL COMMENT '经度',
  `latitude` float(4,2) DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`site_id`),
  CONSTRAINT `fk_jc_company_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司信息';

-- ----------------------------
-- Records of jc_site_company
-- ----------------------------
INSERT INTO `jc_site_company` VALUES ('1', 'fengling开发站', null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `jc_site_model`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_model`;
CREATE TABLE `jc_site_model` (
  `model_id` int(11) NOT NULL AUTO_INCREMENT,
  `field` varchar(50) NOT NULL COMMENT '字段',
  `model_label` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `upload_path` varchar(100) DEFAULT NULL COMMENT '上传路径',
  `text_size` varchar(20) DEFAULT NULL COMMENT '长度',
  `area_rows` varchar(3) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(3) DEFAULT NULL COMMENT '文本列数',
  `help` varchar(255) DEFAULT NULL COMMENT '帮助信息',
  `help_position` varchar(1) DEFAULT NULL COMMENT '帮助位置',
  `data_type` int(11) DEFAULT '1' COMMENT '0:编辑器;1:文本框;2:文本区;3:图片;4:附件',
  `is_single` tinyint(1) DEFAULT '1' COMMENT '是否独占一行',
  PRIMARY KEY (`model_id`),
  UNIQUE KEY `ak_field` (`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点信息模型表';

-- ----------------------------
-- Records of jc_site_model
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_site_txt`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_txt`;
CREATE TABLE `jc_site_txt` (
  `site_id` int(11) NOT NULL,
  `txt_name` varchar(30) NOT NULL COMMENT '名称',
  `txt_value` longtext COMMENT '值',
  KEY `fk_jc_txt_site` (`site_id`),
  CONSTRAINT `fk_jc_txt_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点文本表';

-- ----------------------------
-- Records of jc_site_txt
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_task`
-- ----------------------------
DROP TABLE IF EXISTS `jc_task`;
CREATE TABLE `jc_task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_code` varchar(255) DEFAULT NULL COMMENT '任务执行代码',
  `task_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务类型(1首页静态化、2栏目页静态化、3内容页静态化、4采集、5分发)',
  `task_name` varchar(255) NOT NULL COMMENT '任务名称',
  `job_class` varchar(255) NOT NULL COMMENT '任务类',
  `execycle` tinyint(1) NOT NULL DEFAULT '1' COMMENT '执行周期分类(1非表达式 2 cron表达式)',
  `day_of_month` int(11) DEFAULT NULL COMMENT '每月的哪天',
  `day_of_week` tinyint(1) DEFAULT NULL COMMENT '周几',
  `hour` int(11) DEFAULT NULL COMMENT '小时',
  `minute` int(11) DEFAULT NULL COMMENT '分钟',
  `interval_hour` int(11) DEFAULT NULL COMMENT '间隔小时',
  `interval_minute` int(11) DEFAULT NULL COMMENT '间隔分钟',
  `task_interval_unit` tinyint(1) DEFAULT NULL COMMENT '1分钟、2小时、3日、4周、5月',
  `cron_expression` varchar(255) DEFAULT NULL COMMENT '规则表达式',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `task_remark` varchar(255) DEFAULT NULL COMMENT '任务说明',
  `site_id` int(11) NOT NULL COMMENT '站点',
  `user_id` int(11) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`task_id`),
  KEY `fk_jc_task_site` (`site_id`),
  CONSTRAINT `fk_jc_task_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务表';

-- ----------------------------
-- Records of jc_task
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_task_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_task_attr`;
CREATE TABLE `jc_task_attr` (
  `task_id` int(11) NOT NULL,
  `param_name` varchar(30) NOT NULL COMMENT '参数名称',
  `param_value` varchar(255) DEFAULT NULL COMMENT '参数值',
  KEY `fk_jc_attr_task` (`task_id`),
  CONSTRAINT `fk_jc_attr_task` FOREIGN KEY (`task_id`) REFERENCES `jc_task` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务参数表';

-- ----------------------------
-- Records of jc_task_attr
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_test`
-- ----------------------------
DROP TABLE IF EXISTS `jc_test`;
CREATE TABLE `jc_test` (
  `test_id` int(11) NOT NULL AUTO_INCREMENT,
  `test_title` varchar(255) DEFAULT NULL,
  `test_description` varchar(255) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`test_id`),
  KEY `fk_jc_test_user` (`user_id`),
  KEY `fk_jc_test_site` (`site_id`),
  CONSTRAINT `fk_jc_test_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_test_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='测试表';

-- ----------------------------
-- Records of jc_test
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_third_account`
-- ----------------------------
DROP TABLE IF EXISTS `jc_third_account`;
CREATE TABLE `jc_third_account` (
  `account_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_key` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方账号key',
  `username` varchar(100) NOT NULL DEFAULT '0' COMMENT '关联用户名',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '第三方账号平台(QQ、新浪微博等)',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='第三方登录平台账号';

-- ----------------------------
-- Records of jc_third_account
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_topic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_topic`;
CREATE TABLE `jc_topic` (
  `topic_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) DEFAULT NULL,
  `topic_name` varchar(150) NOT NULL COMMENT '名称',
  `short_name` varchar(150) DEFAULT NULL COMMENT '简称',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `title_img` varchar(100) DEFAULT NULL COMMENT '标题图',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '专题模板',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推??',
  PRIMARY KEY (`topic_id`),
  KEY `fk_jc_topic_channel` (`channel_id`),
  CONSTRAINT `fk_jc_topic_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS专题表';

-- ----------------------------
-- Records of jc_topic
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_user`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user`;
CREATE TABLE `jc_user` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `register_time` datetime NOT NULL COMMENT '注册时间',
  `register_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '注册IP',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '最后登录IP',
  `login_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `rank` int(11) NOT NULL DEFAULT '0' COMMENT '管理员级别',
  `upload_total` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传总大小',
  `upload_size` int(11) NOT NULL DEFAULT '0' COMMENT '上传大小',
  `upload_date` date DEFAULT NULL COMMENT '上传日期',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否管理员',
  `is_self_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否只管理自己的数据',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `ak_username` (`username`),
  KEY `fk_jc_user_group` (`group_id`),
  CONSTRAINT `fk_jc_user_group` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户表';

-- ----------------------------
-- Records of jc_user
-- ----------------------------
INSERT INTO `jc_user` VALUES ('1', '1', 'admin', '', '2011-01-03 00:00:00', '127.0.0.1', '2015-04-09 22:02:10', '127.0.0.1', '1083', '9', '198468', '398', '2015-04-02', '1', '0', '0');

-- ----------------------------
-- Table structure for `jc_user_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_attr`;
CREATE TABLE `jc_user_attr` (
  `user_id` int(11) NOT NULL,
  `attr_name` varchar(255) NOT NULL,
  `attr_value` varchar(255) DEFAULT NULL,
  KEY `fk_jc_attr_user` (`user_id`),
  CONSTRAINT `fk_jc_attr_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户属性表';

-- ----------------------------
-- Records of jc_user_attr
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_user_collection`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_collection`;
CREATE TABLE `jc_user_collection` (
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `content_id` int(11) NOT NULL DEFAULT '0' COMMENT '内容id',
  PRIMARY KEY (`user_id`,`content_id`),
  KEY `fk_jc_user_collection_con` (`content_id`),
  CONSTRAINT `fk_jc_user_collection_con` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_user_collection_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户收藏关联表';

-- ----------------------------
-- Records of jc_user_collection
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_user_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_ext`;
CREATE TABLE `jc_user_ext` (
  `user_id` int(11) NOT NULL,
  `realname` varchar(100) DEFAULT NULL COMMENT '真实姓名',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '出生日期',
  `intro` varchar(255) DEFAULT NULL COMMENT '个人介绍',
  `comefrom` varchar(150) DEFAULT NULL COMMENT '来自',
  `qq` varchar(100) DEFAULT NULL COMMENT 'QQ',
  `msn` varchar(100) DEFAULT NULL COMMENT 'MSN',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `user_img` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `user_signature` varchar(255) DEFAULT NULL COMMENT '用户个性签名',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_jc_ext_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户扩展信息表';

-- ----------------------------
-- Records of jc_user_ext
-- ----------------------------
INSERT INTO `jc_user_ext` VALUES ('1', '大师', null, null, null, '南昌', null, null, '1110', '110', '', '');

-- ----------------------------
-- Table structure for `jc_user_menu`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_menu`;
CREATE TABLE `jc_user_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(255) NOT NULL COMMENT '菜单名称',
  `menu_url` varchar(255) NOT NULL COMMENT '菜单地址',
  `priority` int(11) NOT NULL DEFAULT '10',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`),
  KEY `fk_jc_menu_user` (`user_id`),
  CONSTRAINT `fk_jc_menu_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户常用菜单';

-- ----------------------------
-- Records of jc_user_menu
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_user_resume`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_resume`;
CREATE TABLE `jc_user_resume` (
  `user_id` int(11) NOT NULL,
  `resume_name` varchar(255) NOT NULL COMMENT '简历名称',
  `target_worknature` varchar(255) DEFAULT NULL COMMENT '期望工作性质',
  `target_workplace` varchar(255) DEFAULT NULL COMMENT '期望工作地点',
  `target_category` varchar(255) DEFAULT NULL COMMENT '期望职位类别',
  `target_salary` varchar(255) DEFAULT NULL COMMENT '期望月薪',
  `edu_school` varchar(255) DEFAULT NULL COMMENT '毕业学校',
  `edu_graduation` datetime DEFAULT NULL COMMENT '毕业时间',
  `edu_back` varchar(255) DEFAULT NULL COMMENT '学历',
  `edu_discipline` varchar(255) DEFAULT NULL COMMENT '专业',
  `recent_company` varchar(500) DEFAULT NULL COMMENT '最近工作公司名称',
  `company_industry` varchar(255) DEFAULT NULL COMMENT '最近公司所属行业',
  `company_scale` varchar(255) DEFAULT NULL COMMENT '公司规模',
  `job_name` varchar(255) DEFAULT NULL COMMENT '职位名称',
  `job_category` varchar(255) DEFAULT NULL COMMENT '职位类别',
  `job_start` datetime DEFAULT NULL COMMENT '工作起始时间',
  `subordinates` varchar(255) DEFAULT NULL COMMENT '下属人数',
  `job_description` text COMMENT '工作描述',
  `self_evaluation` varchar(2000) DEFAULT NULL COMMENT '自我评价',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_jc_resume_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户简历';

-- ----------------------------
-- Records of jc_user_resume
-- ----------------------------
INSERT INTO `jc_user_resume` VALUES ('1', '程序员', '全职', '上海', 'java工程师', '', '家里蹲大学', null, '本科', '吃饭', '<img src=/admin/fengling/admin_global/o_update.do?password=111&groupId=1&rank=9&roleIds=1&siteIds=1&steps=2&allChannels=true&id=1＞', null, null, '11', null, null, null, '111', '111');

-- ----------------------------
-- Table structure for `jc_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_role`;
CREATE TABLE `jc_user_role` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`),
  KEY `fk_jc_role_user` (`user_id`),
  CONSTRAINT `fk_jc_role_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_role` FOREIGN KEY (`role_id`) REFERENCES `jc_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户角色关联表';

-- ----------------------------
-- Records of jc_user_role
-- ----------------------------
INSERT INTO `jc_user_role` VALUES ('1', '1');

-- ----------------------------
-- Table structure for `jc_user_site`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_site`;
CREATE TABLE `jc_user_site` (
  `usersite_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `check_step` tinyint(4) NOT NULL DEFAULT '1' COMMENT '审核级别',
  `is_all_channel` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否拥有所有栏目的权限',
  PRIMARY KEY (`usersite_id`),
  KEY `fk_jc_site_user` (`user_id`),
  KEY `fk_jc_user_site` (`site_id`),
  CONSTRAINT `fk_jc_site_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS管理员站点表';

-- ----------------------------
-- Records of jc_user_site
-- ----------------------------
INSERT INTO `jc_user_site` VALUES ('2', '1', '1', '3', '1');

-- ----------------------------
-- Table structure for `jc_vote_item`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_item`;
CREATE TABLE `jc_vote_item` (
  `voteitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `votetopic_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `vote_count` int(11) NOT NULL DEFAULT '0' COMMENT '投票数量',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `subtopic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`voteitem_id`),
  KEY `fk_jc_vote_item_topic` (`votetopic_id`),
  KEY `FK_jc_vote_item_subtopic` (`subtopic_id`),
  CONSTRAINT `FK_jc_vote_item_subtopic` FOREIGN KEY (`subtopic_id`) REFERENCES `jc_vote_subtopic` (`subtopic_id`),
  CONSTRAINT `fk_jc_vote_item_topic` FOREIGN KEY (`votetopic_id`) REFERENCES `jc_vote_topic` (`votetopic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='CMS投票项';

-- ----------------------------
-- Records of jc_vote_item
-- ----------------------------
INSERT INTO `jc_vote_item` VALUES ('1', '2', '不喜欢', '0', '3', '12');
INSERT INTO `jc_vote_item` VALUES ('2', '2', '喜欢', '0', '2', '12');
INSERT INTO `jc_vote_item` VALUES ('3', '2', '很喜欢', '1', '1', '12');
INSERT INTO `jc_vote_item` VALUES ('4', '2', '没有改进', '0', '7', '11');
INSERT INTO `jc_vote_item` VALUES ('5', '2', '有改进', '0', '5', '11');
INSERT INTO `jc_vote_item` VALUES ('6', '2', '改进很大', '1', '4', '11');
INSERT INTO `jc_vote_item` VALUES ('7', '2', '差不多', '0', '6', '11');
INSERT INTO `jc_vote_item` VALUES ('8', '2', '下载', '1', '11', '9');
INSERT INTO `jc_vote_item` VALUES ('9', '2', '新闻', '1', '8', '9');
INSERT INTO `jc_vote_item` VALUES ('10', '2', '图库', '1', '9', '9');
INSERT INTO `jc_vote_item` VALUES ('11', '2', '视频', '1', '10', '9');

-- ----------------------------
-- Table structure for `jc_vote_record`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_record`;
CREATE TABLE `jc_vote_record` (
  `voterecored_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `votetopic_id` int(11) NOT NULL,
  `vote_time` datetime NOT NULL COMMENT '投票时间',
  `vote_ip` varchar(50) NOT NULL COMMENT '投票IP',
  `vote_cookie` varchar(32) NOT NULL COMMENT '投票COOKIE',
  PRIMARY KEY (`voterecored_id`),
  KEY `fk_jc_vote_record_topic` (`votetopic_id`),
  KEY `fk_jc_voterecord_user` (`user_id`),
  CONSTRAINT `fk_jc_vote_record_topic` FOREIGN KEY (`votetopic_id`) REFERENCES `jc_vote_topic` (`votetopic_id`),
  CONSTRAINT `fk_jc_voterecord_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS投票记录';

-- ----------------------------
-- Records of jc_vote_record
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_vote_reply`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_reply`;
CREATE TABLE `jc_vote_reply` (
  `votereply_id` int(11) NOT NULL AUTO_INCREMENT,
  `reply` text COMMENT '回复内容',
  `subtopic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`votereply_id`),
  KEY `FK_jc_vote_reply_sub` (`subtopic_id`),
  CONSTRAINT `FK_jc_vote_reply_sub` FOREIGN KEY (`subtopic_id`) REFERENCES `jc_vote_subtopic` (`subtopic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票文本题目回复表';

-- ----------------------------
-- Records of jc_vote_reply
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_vote_subtopic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_subtopic`;
CREATE TABLE `jc_vote_subtopic` (
  `subtopic_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `votetopic_id` int(11) NOT NULL DEFAULT '0' COMMENT '投票（调查）',
  `subtopic_type` int(2) NOT NULL DEFAULT '1' COMMENT '类型（1单选，2多选，3文本）',
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`subtopic_id`),
  KEY `FK_jc_vote_subtopic_vote` (`votetopic_id`),
  CONSTRAINT `FK_jc_vote_subtopic_vote` FOREIGN KEY (`votetopic_id`) REFERENCES `jc_vote_topic` (`votetopic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='投票子题目';

-- ----------------------------
-- Records of jc_vote_subtopic
-- ----------------------------
INSERT INTO `jc_vote_subtopic` VALUES ('9', '您觉得V5演示站哪些模块做的比较好', '2', '2', '4');
INSERT INTO `jc_vote_subtopic` VALUES ('10', '我觉得这里完善一下：', '2', '3', '3');
INSERT INTO `jc_vote_subtopic` VALUES ('11', 'V5版本比V2012sp1版的设计风格有改进吗？', '2', '1', '2');
INSERT INTO `jc_vote_subtopic` VALUES ('12', 'V5版本演示站网页的设计风格您喜欢吗？', '2', '1', '1');

-- ----------------------------
-- Table structure for `jc_vote_topic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_topic`;
CREATE TABLE `jc_vote_topic` (
  `votetopic_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `repeate_hour` int(11) DEFAULT NULL COMMENT '重复投票限制时间，单位小时，为空不允许重复投票',
  `total_count` int(11) NOT NULL DEFAULT '0' COMMENT '总投票数',
  `multi_select` int(11) NOT NULL DEFAULT '1' COMMENT '最多可以选择几项',
  `is_restrict_member` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制会员',
  `is_restrict_ip` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制IP',
  `is_restrict_cookie` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制COOKIE',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认主题',
  PRIMARY KEY (`votetopic_id`),
  KEY `fk_jc_votetopic_site` (`site_id`),
  CONSTRAINT `fk_jc_votetopic_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS投票主题';

-- ----------------------------
-- Records of jc_vote_topic
-- ----------------------------
INSERT INTO `jc_vote_topic` VALUES ('2', '1', 'fengling演示站改版用户问卷调查', 'fenglingv5版正式发布了，伴随着系统的完善，fengling演示站的模板也一直在不断的改版，针对此次改版，fengling美工团队特邀您参与“fengling演示站改版用户问卷调查”，希望大家能提出宝贵的意见，我们一定认真改进，谢谢大家的支持！', null, null, null, '1', '1', '0', '0', '0', '0', '1');

-- ----------------------------
-- Table structure for `jo_authentication`
-- ----------------------------
DROP TABLE IF EXISTS `jo_authentication`;
CREATE TABLE `jo_authentication` (
  `authentication_id` char(32) NOT NULL COMMENT '认证ID',
  `userid` int(11) NOT NULL COMMENT '用户ID',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `login_time` datetime NOT NULL COMMENT '登录时间',
  `login_ip` varchar(50) NOT NULL COMMENT '登录ip',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`authentication_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='认证信息表';

-- ----------------------------
-- Records of jo_authentication
-- ----------------------------

-- ----------------------------
-- Table structure for `jo_config`
-- ----------------------------
DROP TABLE IF EXISTS `jo_config`;
CREATE TABLE `jo_config` (
  `cfg_key` varchar(50) NOT NULL COMMENT '配置KEY',
  `cfg_value` varchar(255) DEFAULT NULL COMMENT '配置VALUE',
  PRIMARY KEY (`cfg_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置表';

-- ----------------------------
-- Records of jo_config
-- ----------------------------
INSERT INTO `jo_config` VALUES ('email_encoding', '');
INSERT INTO `jo_config` VALUES ('email_host', 'smtp.126.com');
INSERT INTO `jo_config` VALUES ('email_password', 'mingming_chen');
INSERT INTO `jo_config` VALUES ('email_personal', '');
INSERT INTO `jo_config` VALUES ('email_port', null);
INSERT INTO `jo_config` VALUES ('email_username', 'fenglingv5@126.com');
INSERT INTO `jo_config` VALUES ('login_error_interval', '30');
INSERT INTO `jo_config` VALUES ('login_error_times', '3');
INSERT INTO `jo_config` VALUES ('message_forgotpassword_subject', '找回fengling密码');
INSERT INTO `jo_config` VALUES ('message_forgotpassword_text', '感谢您使用fengling系统会员密码找回功能，请记住以下找回信息：\r\n用户ID：${uid}\r\n用户名：${username}\r\n您的新密码为：${resetPwd}\r\n请访问如下链接新密码才能生效：\r\nhttp://demo.fengling.com/member/password_reset.jspx?uid=${uid}&key=${resetKey}');
INSERT INTO `jo_config` VALUES ('message_register_subject', '欢迎您注册fengling用户');
INSERT INTO `jo_config` VALUES ('message_register_text', '${username}您好：\r\n欢迎您注册fengling系统会员\r\n请点击以下链接进行激活\r\nhttp://demo.fengling.com/active.jspx?username=${username}&key=${activationCode}');
INSERT INTO `jo_config` VALUES ('message_subject', 'fengling会员密码找回信息');
INSERT INTO `jo_config` VALUES ('message_text', '感谢您使用fengling系统会员密码找回功能，请记住以下找回信息：\r\n用户ID：${uid}\r\n用户名：${username}\r\n您的新密码为：${resetPwd}\r\n请访问如下链接新密码才能生效：\r\nhttp://localhost/member/password_reset.jspx?uid=${uid}&key=${resetKey}\r\n');

-- ----------------------------
-- Table structure for `jo_ftp`
-- ----------------------------
DROP TABLE IF EXISTS `jo_ftp`;
CREATE TABLE `jo_ftp` (
  `ftp_id` int(11) NOT NULL AUTO_INCREMENT,
  `ftp_name` varchar(100) NOT NULL COMMENT '名称',
  `ip` varchar(50) NOT NULL COMMENT 'IP',
  `port` int(11) NOT NULL DEFAULT '21' COMMENT '端口号',
  `username` varchar(100) DEFAULT NULL COMMENT '登录名',
  `password` varchar(100) DEFAULT NULL COMMENT '登陆密码',
  `encoding` varchar(20) NOT NULL DEFAULT 'UTF-8' COMMENT '编码',
  `timeout` int(11) DEFAULT NULL COMMENT '超时时间',
  `ftp_path` varchar(255) DEFAULT NULL COMMENT '路径',
  `url` varchar(255) NOT NULL COMMENT '访问URL',
  PRIMARY KEY (`ftp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='FTP表';

-- ----------------------------
-- Records of jo_ftp
-- ----------------------------

-- ----------------------------
-- Table structure for `jo_template`
-- ----------------------------
DROP TABLE IF EXISTS `jo_template`;
CREATE TABLE `jo_template` (
  `tpl_name` varchar(150) NOT NULL COMMENT '模板名称',
  `tpl_source` longtext COMMENT '模板内容',
  `last_modified` bigint(20) NOT NULL COMMENT '最后修改时间',
  `is_directory` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否目录',
  PRIMARY KEY (`tpl_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模板表';

-- ----------------------------
-- Records of jo_template
-- ----------------------------

-- ----------------------------
-- Table structure for `jo_upload`
-- ----------------------------
DROP TABLE IF EXISTS `jo_upload`;
CREATE TABLE `jo_upload` (
  `filename` varchar(150) NOT NULL COMMENT '文件名',
  `length` int(11) NOT NULL COMMENT '文件大小(字节)',
  `last_modified` bigint(20) NOT NULL COMMENT '最后修改时间',
  `content` longblob NOT NULL COMMENT '内容',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='上传附件表';

-- ----------------------------
-- Records of jo_upload
-- ----------------------------

-- ----------------------------
-- Table structure for `jo_user`
-- ----------------------------
DROP TABLE IF EXISTS `jo_user`;
CREATE TABLE `jo_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `password` char(32) NOT NULL COMMENT '密码',
  `register_time` datetime NOT NULL COMMENT '注册时间',
  `register_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '注册IP',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '最后登录IP',
  `login_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reset_key` char(32) DEFAULT NULL COMMENT '重置密码KEY',
  `reset_pwd` varchar(10) DEFAULT NULL COMMENT '重置密码VALUE',
  `error_time` datetime DEFAULT NULL COMMENT '登录错误时间',
  `error_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录错误次数',
  `error_ip` varchar(50) DEFAULT NULL COMMENT '登录错误IP',
  `activation` tinyint(1) NOT NULL DEFAULT '1' COMMENT '激活状态',
  `activation_code` char(32) DEFAULT NULL COMMENT '激活码',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `ak_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of jo_user
-- ----------------------------
INSERT INTO `jo_user` VALUES ('1', 'admin', null, '5f4dcc3b5aa765d61d8327deb882cf99', '2011-01-03 00:00:00', '127.0.0.1', '2013-11-06 15:09:12', '127.0.0.1', '131', null, null, '2013-12-24 17:01:46', '1', '127.0.0.1', '1', null);
