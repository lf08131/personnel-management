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
import com.neuedu.mapper.EntryMapper;
import com.neuedu.neupha.service.EntryService;
@Service
public class EntryServiceImpl implements EntryService {

    @Autowired
    private EntryMapper postMapper;

    @Override
    @Transactional(readOnly=true)
    public RespBean getEntryList( Integer page, Integer count,String keywords) {
        RespBean resp = new RespBean();
        if(count == 10 || count<=1){
            count = resp.defaultSize;
        }
        int start = (page - 1) * count;
        resp.setList(postMapper.getEntryList(start, count, keywords));
        resp.setTotalCount(postMapper.getEntryCount(keywords));
        return resp;
    }
    @Override
    @Transactional(readOnly=true)
    public RespBean getEntryList1( Integer page, Integer count,String keywords) {
        RespBean resp = new RespBean();
        if(count == 10 || count<=1){
            count = resp.defaultSize;
        }
        int start = (page - 1) * count;
        resp.setList(postMapper.getEntryList1(start, count, keywords));
        resp.setTotalCount(postMapper.getEntryCount1(keywords));
        return resp;
    }
    @Override
    @Transactional(readOnly=true)
    public RespBean getEntryList2( Integer page, Integer count,String keywords) {
        RespBean resp = new RespBean();
        if(count == 10 || count<=1){
            count = resp.defaultSize;
        }
        int start = (page - 1) * count;
        resp.setList(postMapper.getEntryList2(start, count, keywords));
        resp.setTotalCount(postMapper.getEntryCount2(keywords));
        return resp;
    }
    @Override
    @Transactional(readOnly=true)
    public RespBean getEntryList3( Integer page, Integer count,String keywords) {
        RespBean resp = new RespBean();
        if(count == 10 || count<=1){
            count = resp.defaultSize;
        }
        int start = (page - 1) * count;
        resp.setList(postMapper.getEntryList3(start, count, keywords));
        resp.setTotalCount(postMapper.getEntryCount3(keywords));
        return resp;
    }
    @Override
    @Transactional(readOnly=true)
    public RespBean getEntryList4( Integer page, Integer count,String keywords) {
        RespBean resp = new RespBean();
        if(count == 10 || count<=1){
            count = resp.defaultSize;
        }
        int start = (page - 1) * count;
        resp.setList(postMapper.getEntryList4(start, count, keywords));
        resp.setTotalCount(postMapper.getEntryCount4(keywords));
        return resp;
    }
    @Override
    @Transactional(readOnly=true)
    public int getEntryCount( String keywords) {
        return postMapper.getEntryCount(keywords);
    }


    @Transactional(readOnly=true)
    public int getEntryCount1( String keywords) {
        return postMapper.getEntryCount1(keywords);
    }

    @Override
    @Transactional
    public int addEntryOne(Map<String, Object> map) {
        map.put("ID",map.get("entry_id"));
        map.put("DelMark",1);
        postMapper.insertSelective1(map);
        return postMapper.insertSelective(map);

    }

    @Override
    @Transactional
    public int updateEntryOne(Map<String, Object> map) {

        return postMapper.updateByPrimaryKeySelective(map);
    }
    @Override
    @Transactional
    public int updateEntryOne1(Map<String, Object> map) {
        map.put("ID",map.get("entry_id"));
        map.put("Turnover_type","1");
        map.put("talent_bank","1");
        map.put("DelMark",0);
       postMapper.insertSelective2(map);
        return postMapper.updateByPrimaryKeySelective(map);
    }
    @Override
    @Transactional
    public int updateEntryOne2(Map<String, Object> map) {
        map.put("ID",map.get("entry_id"));
        map.put("Turnover_type","1");
        map.put("talent_bank","1");
        map.put("DelMark",4);
       postMapper.insertSelective2(map);
        return postMapper.updateByPrimaryKeySelective(map);
    }
    @Override
    @Transactional
    public int updateEntryOne3(Map<String, Object> map) {
        map.put("ID",map.get("entry_id"));

        map.put("DelMark",3);
       postMapper.insertSelective1(map);
        return postMapper.updateByPrimaryKeySelective(map);
    }


}
