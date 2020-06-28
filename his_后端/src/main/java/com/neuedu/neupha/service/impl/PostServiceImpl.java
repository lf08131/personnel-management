package com.neuedu.neupha.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neuedu.bean.RespBean;
import com.neuedu.mapper.PostMapper;
import com.neuedu.neupha.service.PostService;
@Service
public class PostServiceImpl implements PostService {

	@Autowired
	private PostMapper postMapper;

	@Override
	@Transactional(readOnly=true)
	public RespBean getPostList( Integer page, Integer count,String keywords) {
		RespBean resp = new RespBean();
		if(count == 10 || count<=1){
			count = resp.defaultSize;
		}
		int start = (page - 1) * count;
		resp.setList(postMapper.getPostList(start, count, keywords));
		resp.setTotalCount(postMapper.getPostCount(keywords));
		return resp;
	}

	@Override
	@Transactional(readOnly=true)
	public int getPostCount( String keywords) {
		return postMapper.getPostCount(keywords);
	}


	@Override
	@Transactional
	public int addPostOne(Map<String, Object> map) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			String date = map.get("date").toString();
			map.put("date",sdf.parse(date));
		} catch (Exception e) {
			map.put("date",new java.util.Date());
		}
		map.put("DelMark",1);
		return postMapper.insertSelective(map);
	}

	@Override
	@Transactional
	public int updatePostOne(Map<String, Object> map) {

		return postMapper.updateByPrimaryKeySelective(map);
	}

	@Override
	@Transactional
	public boolean delPost(String ids) {
		String[] split = ids.split(",");
		int result = 0;
		Map<String,Object> map = new HashMap<String,Object>();
		for(int i=0;i<split.length;i++) {
			map.put("Post_id", split[i]);
			map.put("DelMark", 0);
			result += postMapper.updateByPrimaryKeySelective(map);
		}
		return result == split.length;
	}

}
