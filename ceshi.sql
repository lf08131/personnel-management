/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50529
Source Host           : localhost:3306
Source Database       : ceshi

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2020-06-30 12:42:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `Dept_id` int(11) NOT NULL,
  `Dept_name` varchar(255) NOT NULL,
  `Dept_type` varchar(255) NOT NULL,
  `Dept_phone` varchar(255) NOT NULL,
  `Dept_describe` varchar(255) DEFAULT NULL,
  `Superior_dept` varchar(255) DEFAULT NULL,
  `DelMark` int(255) NOT NULL,
  PRIMARY KEY (`Dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '财务处', '财务', '80886', '管理财务', '董事会', '1');
INSERT INTO `department` VALUES ('2', '市场部', '市场', '80887', '市场调研', '董事会', '1');
INSERT INTO `department` VALUES ('3', '研发部', '开发', '80888', '技术开发', '董事会', '1');
INSERT INTO `department` VALUES ('4', '运营部', '运营', '80889', '产品运营', '董事会', '1');
INSERT INTO `department` VALUES ('5', '产品部', '产品', '80890', '产品研发', '董事会', '1');
INSERT INTO `department` VALUES ('6', '人事部', '人事', '80891', '人事管理', '董事会', '1');
INSERT INTO `department` VALUES ('7', '设计部', '设计', '80892', '产品设计', '董事会', '1');
INSERT INTO `department` VALUES ('8', '秘书处', '秘书', '80893', '处理各项事宜', '董事会', '1');
INSERT INTO `department` VALUES ('9', '招标部', '招投标', '80894', '招标投标', '董事会', '1');
INSERT INTO `department` VALUES ('10', '董事会', '管理', '80895', '管理', '', '1');

-- ----------------------------
-- Table structure for dimission
-- ----------------------------
DROP TABLE IF EXISTS `dimission`;
CREATE TABLE `dimission` (
  `ID` int(11) NOT NULL,
  `employerName` varchar(255) NOT NULL,
  `Sex` varchar(255) NOT NULL,
  `endDate` date NOT NULL,
  `Deptname` varchar(255) NOT NULL,
  `Postname` varchar(255) NOT NULL,
  `Turnover_type` varchar(255) DEFAULT NULL,
  `talent_bank` varchar(255) DEFAULT NULL COMMENT '离职表的员工ID应与员工入职表一致，离职员工信息应在员工入职表中删除。\r\nTurnover type 填的是离职类型。\r\ntalent bank填的是是否进入人才库，填true或false。\r\nDeptname部门名称，Postname岗位名称也应与入职表一样.\r\n报表管理功能的，离职员工报表信息也从这边取。',
  `Tornoverreason` varchar(255) DEFAULT NULL,
  `DelMark` int(11) DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dimission
-- ----------------------------

-- ----------------------------
-- Table structure for entry
-- ----------------------------
DROP TABLE IF EXISTS `entry`;
CREATE TABLE `entry` (
  `entry_id` int(11) NOT NULL,
  `employerName` varchar(255) NOT NULL,
  `Sex` varchar(255) NOT NULL,
  `birthData` varchar(255) NOT NULL,
  `Tornoverreason` varchar(255) DEFAULT NULL,
  `Deptname` varchar(255) NOT NULL,
  `Postname` varchar(255) NOT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `Employment_type` varchar(255) NOT NULL,
  `Personnel_type` varchar(255) NOT NULL COMMENT '员工入职表：主表\r\ndeptname与部门表一样；postname岗位名也与岗位管理的岗位名一样。\r\nstartData是入职日期，workData是工作日期。\r\nEmployment type 用工形式应填：1或2。与Employment form相关联，1代表正式员工，2代表临时员工\r\nPersonal type 人员来源 应填 1，2，3\r\n与Personal form 相关联。1代表校园招聘；2代表社会招聘，3代表其他。\r\n报表管理的入职员工报表从这边取',
  `DelMark` int(11) NOT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of entry
-- ----------------------------
INSERT INTO `entry` VALUES ('1', 'Jack', '男', '1999-02-05', '', '人事部', '人事专员', '2020-01-08', '2020-02-19', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('2', 'Jenny', '女', '1987-07-19', '', '财务处', '会计', '2005-03-02', '2005-03-28', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('3', 'Lee', '男', '1991-03-14', '', '研发部', 'java开发', '2018-05-09', '2018-05-25', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('4', 'Anna', '女', '1999-09-08', '', '研发部', 'web前端', '2020-05-06', '2020-05-18', '临时员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('5', 'Ben', '男', '1992-08-13', '', '运营部', '新媒体运营', '2019-09-10', '2019-10-07', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('6', 'Jim', '男', '1994-03-11', '', '产品部', '产品助理', '2019-10-21', '2019-11-04', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('7', 'Ada', '女', '1978-09-06', '', '秘书处', '总经理秘书', '2006-06-09', '2006-06-28', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('8', 'Amanda', '女', '1986-09-22', null, '招标部', '招标员', '2011-02-26', '2011-03-03', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('9', 'Nancy', '女', '1984-04-29', null, '产品部', '产品经理', '2009-09-10', '2009-09-14', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('10', 'Kate', '女', '1988-12-09', null, '运营部', '社群运营', '2008-05-13', '2008-05-16', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('11', 'Tom', '男', '1991-11-20', null, '产品部', '产品助理', '2013-04-10', '2013-04-15', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('12', 'Jerry', '男', '1993-01-07', null, '财务处', '审计', '2014-08-15', '2014-08-18', '临时员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('13', 'Leo', '男', '1996-07-29', null, '研发部', 'Java开发', '2018-09-07', '2018-09-10', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('14', 'Bob', '男', '1981-02-15', null, '研发部', 'iOS开发', '2007-10-25', '2007-10-31', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('15', 'Jimmy', '男', '1984-10-23', null, '市场部', '销售经理', '2006-10-11', '2006-10-23', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('16', 'Mike', '男', '1993-07-27', null, '设计部', 'UI设计', '2020-01-14', '2020-01-20', '临时员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('17', 'Micky', '男', '1979-06-17', null, '管理部', '人事总监', '2002-07-23', '2002-07-29', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('18', 'Nike', '男', '1985-12-04', null, '研发部', 'Android开发', '2010-06-15', '2010-06-21', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('19', 'Minn', '女', '1993-11-21', null, '市场部', '销售', '2017-03-14', '2017-03-20', '临时员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('20', 'Lynn', '女', '1996-07-26', null, '市场部', '销售', '2019-09-11', '2019-09-16', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('21', 'David', '男', '1987-06-24', null, '招标部', '招标员', '2005-08-18', '2005-08-21', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('22', 'Yamy', '女', '1988-12-08', null, '财务部', '会计', '2007-03-22', '2007-03-26', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('23', 'Sunny', '女', '1992-09-12', null, '人事部', '人事专员', '2016-09-12', '2016-09-16', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('24', 'Candy', '女', '1998-06-04', null, '设计部', '平面设计', '2020-04-14', '2020-04-20', '临时员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('25', 'Bridge', '男', '1994-11-28', null, '运营部', '推广运营', '2018-07-28', '2018-08-02', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('26', 'Dam', '男', '1993-10-08', null, '研发部', 'iOS开发', '2017-09-22', '2017-09-26', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('27', 'Mardan', '男', '1988-04-22', null, '研发部', 'Android开发', '2011-06-28', '2011-06-26', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('28', 'Cherry', '女', '1974-09-26', null, '财务部', '会计', '2011-02-21', '2011-02-27', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('29', 'Adam', '男', '1977-04-26', null, '管理部', '市场经理', '2006-02-11', '2006-02-15', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('30', 'Geo', '男', '1984-11-23', null, '研发部', 'web前端', '2004-09-21', '2004-09-22', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('31', 'Sam', '男', '1973-06-21', null, '产品部', '产品经理', '2003-06-18', '2003-06-19', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('32', 'Kimmy', '男', '1994-11-28', null, '运营部', '新媒体运营', '2019-09-22', '2019-09-27', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('33', 'Lee', '男', '1997-08-21', null, '人事部', '人事专员', '2020-06-08', '2020-06-15', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('34', 'Kitty', '女', '1996-12-08', null, '财务部', '审计', '2018-09-21', '2018-09-22', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('35', 'Nana', '女', '1976-09-11', null, '运营部', '推广运营', '2003-08-11', '2003-08-16', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('36', 'Ana', '女', '1991-10-09', null, '财务部', '审计', '2011-05-22', '2011-05-30', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('37', 'Jimmy', '男', '1996-08-21', null, '市场部', '销售', '2013-03-06', '2013-03-05', '临时员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('38', 'He', '男', '1993-07-18', null, '设计部', '平面设计', '2015-07-22', '2015-07-28', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('39', 'Wendy', '女', '1996-05-18', null, '秘书处', '总经理秘书', '2014-06-21', '2014-06-21', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('40', 'Vic', '女', '1993-04-30', null, '研发部', 'Java开发', '2015-07-19', '2015-07-25', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('41', 'Rita', '女', '1986-04-21', null, '研发部', '数据分析', '2013-06-28', '2013-06-30', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('42', 'Tia', '女', '1993-06-18', null, '市场部', '销售经理', '2014-06-21', '2014-06-24', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('43', 'Mike', '男', '1986-03-21', null, '产品部', '产品经理', '2011-09-21', '2011-09-24', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('44', 'Jacky', '男', '1985-07-24', null, '运营部', '社群运营', '2008-07-27', '2008-07-30', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('45', 'Zack', '男', '1995-08-26', null, '招标部', '招标助理', '2015-07-18', '2015-07-20', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('46', 'Tim', '男', '1997-06-17', null, '研发部', 'Web前端', '2020-04-23', '2020-04-28', '临时员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('47', 'Rummy', '女', '1983-11-18', null, '财务处', '审计', '2005-11-28', '2005-11-30', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('48', 'victory', '女', '1986-06-21', null, '秘书处', '董事长秘书', '2003-03-17', '2003-03-22', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('49', 'Vim', '男', '1977-02-17', null, '研发部', 'Android开发', '2001-09-22', '2001-09-24', '正式员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('50', 'William', '男', '1996-07-19', null, '研发部', '数据分析', '2018-09-25', '2018-09-29', '正式员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('51', '彭于晏', '男', '1999-02-05', '', '研发部', 'iOS开发', '2020-06-27', '2020-06-30', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('52', '彭昱畅', '男', '1995-01-05', '', '研发部', 'Android开发', '2020-01-28', '2021-06-28', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('53', '陈伟霆', '男', '1992-10-24', '', '研发部', 'Java开发', '2002-03-06', '2020-06-30', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('54', '王嘉尔', '男', '1999-09-08', '主动离职', '研发部', 'Java开发', '2002-03-06', '2021-08-09', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('55', '王一博', '男', '1999-09-05', '', '研发部', 'iOS开发', '2002-03-06', '2020-06-29', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('56', '蔡徐坤', '男', '2002-03-06', '', '研发部', 'iOS开发', '2020-08-09', '2021-05-06', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('57', '范丞丞', '男', '2002-03-06', '', '研发部', 'iOS开发', '2020-01-06', '2020-10-09', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('58', '迪丽热巴', '女', '2002-03-06', null, '财务处', '会计', '2015-10-21', '2016-10-21', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('59', '古力娜扎', '女', '1999-02-19', '能力不足，予以辞退', '财务处', '会计', '2015-10-21', '2016-10-21', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('60', '佟丽娅', '女', '1999-02-19', null, '财务处', '审计', '2016-11-11', '2017-01-02', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('61', '麦迪娜', '女', '1992-01-01', null, '财务处', '审计', '1999-02-19', '1999-03-19', '临时员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('62', '杨幂', '女', '1986-05-06', null, '市场部', '销售经理', '1999-08-09', '1999-10-09', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('63', '范冰冰', '女', '1988-02-22', null, '市场部', '销售经理', '1999-08-09', '1999-10-09', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('64', '李冰冰', '女', '1989-02-19', null, '市场部', '销售经理', '2000-12-12', '2001-01-13', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('65', '欧阳娜娜', '女', '2002-05-14', '主动离职', '市场部', '销售', '2019-04-05', '2019-05-12', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('66', '宋祖儿', '女', '2001-10-15', null, '市场部', '销售', '2019-12-12', '2000-01-30', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('67', '周冬雨', '女', '1994-12-20', null, '市场部', '销售', '2018-05-12', '2018-10-12', '临时员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('68', '白冰', '女', '1989-05-06', null, '运营部', '新媒体运营', '2018-05-12', '2018-12-12', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('69', '万茜', '女', '1989-04-09', null, '运营部', '新媒体运营', '2016-05-20', '2016-09-20', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('70', '丁当', '女', '1985-11-05', null, '运营部', '推广运营', '2017-12-10', '2018-02-03', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('71', '黄圣依', '女', '1982-05-18', null, '运营部', '推广运营', '2016-05-09', '2016-12-09', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('72', '张萌', '女', '1982-12-15', null, '运营部', '社群运营', '2018-09-17', '2018-12-19', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('73', '金晨', '女', '1991-10-19', null, '运营部', '社群运营', '2019-10-18', '2019-12-30', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('74', '宁静', '女', '1981-02-03', null, '产品部', '产品经理', '2016-05-20', '2016-10-20', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('75', '伊能静', '女', '1980-10-15', null, '产品部', '产品经理', '2017-01-02', '2017-03-02', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('76', '沈梦辰', '女', '1991-12-19', '能力不足，予以辞退', '产品部', '产品专员', '2019-10-12', '2020-01-12', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('77', '吴昕', '女', '1992-03-29', null, '产品部', '产品专员', '2018-05-28', '2018-07-28', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('78', '孟佳', '女', '1993-10-27', null, '产品部', '产品助理', '2017-10-13', '2017-12-13', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('79', '王霏霏', '女', '1989-02-19', null, '产品部', '产品助理', '2018-02-10', '2018-04-10', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('80', '肖战', '男', '1992-10-12', null, '人事部', '人事总监', '2016-10-15', '2016-10-30', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('81', '易烊千玺', '男', '1995-02-16', null, '人事部', '人事经理', '2017-10-12', '2017-10-20', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('82', '王俊凯', '男', '1995-02-16', null, '人事部', '人事经理', '2017-10-12', '2017-11-01', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('83', '王源', '男', '1995-02-17', null, '人事部', '人事专员', '2017-10-20', '2017-12-20', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('84', '黄子韬', '男', '1992-10-12', '能力不足，予以辞退', '设计部', 'UI设计', '2016-02-15', '2016-03-15', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('85', '鹿晗', '男', '1991-05-19', null, '设计部', 'UI设计', '2017-10-12', '2017-12-17', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('86', '吴亦凡', '男', '1990-05-12', null, '设计部', '平面设计', '2016-05-12', '2016-10-12', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('87', '张艺兴', '男', '1992-12-15', null, '设计部', '平面设计', '2015-10-16', '2015-12-16', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('88', '胡歌', '男', '1993-05-06', null, '研发部', 'Web前端', '2015-10-12', '2016-12-10', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('89', '霍建华', '男', '1989-02-15', null, '研发部', 'Java开发', '2012-10-15', '2013-01-13', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('90', '杨洋', '男', '1992-10-16', null, '运营部', '新媒体运营', '2013-04-06', '2014-01-13', '临时员工', '校园招聘', '2');
INSERT INTO `entry` VALUES ('91', '刘敏涛', '女', '1982-02-13', null, '市场部', '市场经理', '2014-10-15', '2014-10-30', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('92', '阿朵', '女', '1981-02-16', null, '招标部', '招标助理', '2013-10-12', '2014-01-12', '临时员工', '社会招聘', '2');
INSERT INTO `entry` VALUES ('93', '郑爽', '女', '1995-10-15', null, '招标部', '招标助理', '2014-12-13', '2015-03-15', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('94', '宋茜', '女', '1992-05-04', null, '招标部', '招标员', '2012-02-15', '2012-03-15', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('95', '杨紫', '女', '1993-12-13', null, '招标部', '招标员', '2016-12-13', '2017-03-13', '正式员工', '校园招聘', '1');
INSERT INTO `entry` VALUES ('96', '黄磊', '男', '1972-05-25', null, '董事会', '董事长', '2000-01-01', '2000-01-01', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('97', '何炅', '男', '1973-05-23', null, '董事会', '董事长', '2000-01-01', '2000-01-01', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('98', '刘德华', '男', '1972-10-12', null, '董事会', '总经理', '2000-01-01', '2000-01-01', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('99', '王中磊', '男', '1970-01-02', null, '董事会', '董事长', '2000-01-01', '2000-01-01', '正式员工', '社会招聘', '1');
INSERT INTO `entry` VALUES ('100', '林志颖', '男', '1974-05-13', null, '董事会', '总经理', '2000-01-01', '2000-01-01', '正式员工', '社会招聘', '1');

-- ----------------------------
-- Table structure for induction
-- ----------------------------
DROP TABLE IF EXISTS `induction`;
CREATE TABLE `induction` (
  `ID` int(11) NOT NULL,
  `employerName` varchar(255) NOT NULL,
  `Sex` varchar(255) NOT NULL,
  `Deptname` varchar(255) NOT NULL,
  `Postname` varchar(255) NOT NULL,
  `startDate` date DEFAULT NULL,
  `DelMark` int(255) DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of induction
-- ----------------------------

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `Post_id` int(11) NOT NULL,
  `Post_name` varchar(255) NOT NULL,
  `Post_type` varchar(255) NOT NULL,
  `DelMark` int(11) NOT NULL DEFAULT '1',
  `date` date NOT NULL,
  PRIMARY KEY (`Post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES ('11', '总经理', '管理', '1', '2020-04-01');
INSERT INTO `post` VALUES ('12', '董事长', '管理', '1', '2020-04-01');
INSERT INTO `post` VALUES ('101', '会计', '财务', '1', '2020-06-29');
INSERT INTO `post` VALUES ('102', '审计', '财务', '1', '2020-06-27');
INSERT INTO `post` VALUES ('201', '销售', '市场', '1', '2020-06-26');
INSERT INTO `post` VALUES ('202', '销售经理', '市场', '1', '2020-06-26');
INSERT INTO `post` VALUES ('203', '市场经理', '管理', '1', '2020-04-01');
INSERT INTO `post` VALUES ('301', 'Web前端', '研发', '1', '2020-06-26');
INSERT INTO `post` VALUES ('302', 'iOS开发', '研发', '1', '2020-06-26');
INSERT INTO `post` VALUES ('303', 'Android开发', '研发', '1', '2020-06-26');
INSERT INTO `post` VALUES ('304', 'Java开发', '研发', '1', '2020-01-01');
INSERT INTO `post` VALUES ('305', '数据分析', '研发', '1', '2019-09-10');
INSERT INTO `post` VALUES ('401', '新媒体运营', '运营', '1', '2020-05-03');
INSERT INTO `post` VALUES ('402', '推广运营', '运营', '1', '2020-05-06');
INSERT INTO `post` VALUES ('403', '社群运营', '运营', '1', '2020-05-19');
INSERT INTO `post` VALUES ('501', '产品助理', '产品', '1', '2020-06-03');
INSERT INTO `post` VALUES ('502', '产品专员', '产品', '1', '2020-05-25');
INSERT INTO `post` VALUES ('503', '产品经理', '产品', '1', '2020-04-03');
INSERT INTO `post` VALUES ('601', '人事专员', '人事', '1', '2020-06-05');
INSERT INTO `post` VALUES ('602', '人事经理', '人事', '1', '2020-06-20');
INSERT INTO `post` VALUES ('603', '人事总监', '管理', '1', '2020-04-10');
INSERT INTO `post` VALUES ('701', 'UI设计', '设计', '1', '2020-04-01');
INSERT INTO `post` VALUES ('702', '平面设计', '设计', '1', '2020-04-01');
INSERT INTO `post` VALUES ('801', '总经理秘书', '秘书', '1', '2020-04-01');
INSERT INTO `post` VALUES ('802', '董事长秘书', '秘书', '1', '2020-04-01');
INSERT INTO `post` VALUES ('901', '招标助理', '招标', '1', '2020-04-01');
INSERT INTO `post` VALUES ('902', '招标员', '招标', '1', '2020-04-01');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `ID` int(9) NOT NULL AUTO_INCREMENT COMMENT 'ID主键',
  `UserName` varchar(64) NOT NULL COMMENT '登录名',
  `Password` varchar(64) NOT NULL COMMENT '密码',
  `RealName` varchar(64) NOT NULL COMMENT '真实姓名',
  `UseType` int(1) DEFAULT NULL COMMENT '用户类别',
  `DocTitleID` int(9) DEFAULT NULL COMMENT '医生职称ID',
  `IsScheduling` char(1) DEFAULT NULL COMMENT '是否参与排班',
  `DeptID` int(9) NOT NULL COMMENT '所在科室ID',
  `RegistLeID` int(9) DEFAULT NULL COMMENT '挂号级别ID',
  `DelMark` int(1) NOT NULL DEFAULT '1' COMMENT '删除标记',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('9', 'root', 'root', 'ROOT', '0', '81', '否', '1', '1', '1');
