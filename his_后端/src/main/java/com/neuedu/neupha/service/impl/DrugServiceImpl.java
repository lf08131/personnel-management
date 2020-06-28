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
import com.neuedu.mapper.DrugsMapper;
import com.neuedu.neupha.service.DrugService;
@Service
public class DrugServiceImpl implements DrugService {
	
	@Autowired
	private DrugsMapper drugsMapper;

	@Override
	@Transactional(readOnly=true)
	public RespBean getDrugList( Integer page, Integer count,String keywords) {
		RespBean resp = new RespBean();
		if(count == 10 || count<=1){
			count = resp.defaultSize;
		}
	    int start = (page - 1) * count;
	    resp.setList(drugsMapper.getDrugList(start, count, keywords));
	    resp.setTotalCount(drugsMapper.getDrugCount(keywords));	        
	    return resp;
	}

	@Override
	@Transactional(readOnly=true)
    public int getDrugCount( String keywords) {
        return drugsMapper.getDrugCount(keywords);
    }


	@Override
	@Transactional
	public int addDrugOne(Map<String, Object> map) {
		map.put("DelMark",1);
		return drugsMapper.insertSelective(map);
	}

	@Override
	@Transactional
	public int updateDrugOne(Map<String, Object> map) {

		return drugsMapper.updateByPrimaryKeySelective(map);
	}

	@Override
	@Transactional
	public boolean delDrug(String ids) {
        String[] split = ids.split(",");
        int result = 0;
        Map<String,Object> map = new HashMap<String,Object>();
        for(int i=0;i<split.length;i++) {
        	map.put("Dept_id", split[i]);
        	map.put("DelMark", 0);
        	result += drugsMapper.updateByPrimaryKeySelective(map);
        }        
        return result == split.length;
	}



}
