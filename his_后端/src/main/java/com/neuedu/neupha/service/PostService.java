package com.neuedu.neupha.service;

import java.util.List;
import java.util.Map;

import com.neuedu.bean.RespBean;

public interface PostService {



	RespBean getPostList(Integer page, Integer count, String keywords);

	int getPostCount(String keywords);

	int addPostOne(Map<String, Object> map);

	int updatePostOne(Map<String, Object> map);

	boolean delPost(String ids);

}