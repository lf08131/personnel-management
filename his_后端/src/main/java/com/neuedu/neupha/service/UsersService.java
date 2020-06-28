package com.neuedu.neupha.service;

import java.util.List;
import java.util.Map;

import com.neuedu.bean.RespBean;

public interface UsersService {

	int addUsers(List<Map<String, Object>> drugList);

	RespBean getUsersList(Integer page, Integer count, String keywords);

	int getUsersCount(String keywords);

	int addUsersOne(Map<String, Object> map);

	int updateUsersOne(Map<String, Object> map);

	boolean delUsers(String ids);

}