/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50529
Source Host           : localhost:3306
Source Database       : ceshi

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2020-06-28 17:09:31
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
INSERT INTO `department` VALUES ('1', '财务处', '财务', '80886', '管钱', '秘书处', '1');
INSERT INTO `department` VALUES ('2', '市场部', '市场', '80887', '无', '总裁办公室', '1');
INSERT INTO `department` VALUES ('3', '3', '3', '3', '355', '3', '1');
INSERT INTO `department` VALUES ('4', '11', '111', '80883', '管钱', '财务总办公室', '1');
INSERT INTO `department` VALUES ('5', '5', '5', '5', '5', '5', '0');
INSERT INTO `department` VALUES ('12', '12', '12', '11112', '12', '12', '0');

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
INSERT INTO `dimission` VALUES ('1', 'jack1', '男', '2020-06-30', '消防部', '看看', '1', '1', '1', '0');
INSERT INTO `dimission` VALUES ('2', 'ssm', '女', '2021-06-28', 'jjj', 'zjl', '1', '1', '无', '0');
INSERT INTO `dimission` VALUES ('10', '10', '10', '2020-06-30', '10', '10', '1', '1', '无', '0');
INSERT INTO `dimission` VALUES ('12', '12', '12', '2021-08-09', '12', '12', '1', '1', '12', '0');
INSERT INTO `dimission` VALUES ('77', '5', '5', '2020-06-27', 'lll', 'kkk', '1', '1', '1', '0');
INSERT INTO `dimission` VALUES ('88', '8', '8', '2021-05-06', '8', '8', '1', '1', '8', '0');
INSERT INTO `dimission` VALUES ('111', '111', '111', '2020-10-09', '111', '111', '1', '1', '111', '0');

-- ----------------------------
-- Table structure for employ form
-- ----------------------------
DROP TABLE IF EXISTS `employ form`;
CREATE TABLE `employ form` (
  `Type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '用工形式表：\r\n1：正式工\r\n2.临时员工\r\n与员工入职表的Employment type 关联',
  PRIMARY KEY (`Type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employ form
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
INSERT INTO `entry` VALUES ('1', 'jack1', '男', '1999-02-05', '1', '消防部', '看看', '2020-06-27', '2020-06-30', '1', '1', '0');
INSERT INTO `entry` VALUES ('2', 'ssm', '女', '2020-07-19', '无', 'jjj', 'zjl', '2020-06-28', '2021-06-28', '1', '1', '0');
INSERT INTO `entry` VALUES ('10', '10', '10', '10', '无', '10', '10', '2020-06-28', '2020-06-30', '10', '是', '0');
INSERT INTO `entry` VALUES ('12', '12', '12', '1999-09-08', '12', '12', '12', '2020-07-21', '2021-08-09', '12', '12', '0');
INSERT INTO `entry` VALUES ('77', '5', '5', '5', '1', '2', 'kkk', '2020-06-27', '2020-06-27', '1', '1', '1');
INSERT INTO `entry` VALUES ('88', '8', '8', '8', '8', '8', '12', '2020-02-02', '2021-05-06', '1', '1', '1');
INSERT INTO `entry` VALUES ('111', '111', '111', '2019-09-08', '111', '111', '111', '2020-09-10', '2020-10-09', '111', '111', '0');

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
INSERT INTO `induction` VALUES ('2', 'ssm', '女', 'jjj', 'zjl', '2020-06-28', '3');
INSERT INTO `induction` VALUES ('10', '10', '10', '10', '10', '2020-06-28', '1');
INSERT INTO `induction` VALUES ('12', '12', '12', '12', '12', '2020-07-21', '1');
INSERT INTO `induction` VALUES ('111', '111', '111', '111', '111', '2020-09-10', '1');

-- ----------------------------
-- Table structure for personal form
-- ----------------------------
DROP TABLE IF EXISTS `personal form`;
CREATE TABLE `personal form` (
  `Type` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL COMMENT '人员来源表：与员工入职表的Personal type相关联。\r\n1：校园招聘；\r\n2：社会招聘；\r\n3：其他。',
  PRIMARY KEY (`Type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of personal form
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
INSERT INTO `post` VALUES ('2', '2', '2', '0', '2020-06-29');
INSERT INTO `post` VALUES ('3', '8', '5', '1', '2020-06-26');
INSERT INTO `post` VALUES ('5', '5', '5', '1', '2020-06-26');
INSERT INTO `post` VALUES ('7', '71', '7', '1', '2020-06-26');
INSERT INTO `post` VALUES ('8', '81', '3', '1', '2020-06-26');
INSERT INTO `post` VALUES ('10', '5', '5', '1', '2020-06-26');
INSERT INTO `post` VALUES ('11', '11', '11', '1', '2020-06-26');
INSERT INTO `post` VALUES ('77', '5', '5', '1', '2020-01-01');
INSERT INTO `post` VALUES ('111', '111', '111', '0', '2019-09-10');

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'bianque', '1', '1', '1', '82', '1', '1', '1', '1');
INSERT INTO `user` VALUES ('2', 'fwb', 'fwb123', '范无病', '3', '83', '是', '1', '2', '1');
INSERT INTO `user` VALUES ('3', 'hqb', 'hqb456', '霍去病', '3', '83', '是', '1', '2', '1');
INSERT INTO `user` VALUES ('4', 'huatuo', 'huatuo123', '华佗', '4', '81', '是', '2', '1', '1');
INSERT INTO `user` VALUES ('6', 'adq', 'adq123', '安道全', '3', '83', '是', '2', '2', '1');
INSERT INTO `user` VALUES ('9', 'root', 'root', 'ROOT', '0', '81', '否', '1', '1', '1');
INSERT INTO `user` VALUES ('10', 'ghy', 'ghy456', '挂号收费员', '2', '81', '否', '1', '1', '1');
INSERT INTO `user` VALUES ('11', 'admin', 'admin123', '医院管理员', '1', '81', '否', '1', '1', '1');
INSERT INTO `user` VALUES ('12', '1', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `user` VALUES ('13', '1', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `user` VALUES ('14', '8', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `user` VALUES ('15', '8', '8', '8', '8', '8', '8', '8', '8', '0');
INSERT INTO `user` VALUES ('16', '7', '7', '7', '7', '7', '7', '7', '7', '0');
INSERT INTO `user` VALUES ('17', '2', '2', '2', '2', '2', '2', '2', '2', '0');
INSERT INTO `user` VALUES ('18', '4', '4', '5', '9', '1', '8', '7', '4', '0');
INSERT INTO `user` VALUES ('19', '8', '8', '8', '8', '8', '8', '8', '8', '0');
INSERT INTO `user` VALUES ('20', '4', '6', '6', '6', '6', '6', '6', '6', '0');
INSERT INTO `user` VALUES ('21', '6', '6', '6', '6', '6', '5', '5', '5', '1');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `ID` int(11) NOT NULL COMMENT '用户管理的users表',
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `Realname` varchar(255) NOT NULL COMMENT '员工信息表',
  `startData` varchar(255) NOT NULL,
  `endData` varchar(255) NOT NULL,
  `language` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
