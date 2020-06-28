package com.neuedu.neupha.service;

import java.util.List;
import java.util.Map;

import com.neuedu.bean.RespBean;

public interface EntryService {


    RespBean getEntryList(Integer page, Integer count, String keywords);
    RespBean getEntryList1(Integer page, Integer count, String keywords);
    RespBean getEntryList2(Integer page, Integer count, String keywords);
    RespBean getEntryList3(Integer page, Integer count, String keywords);
    RespBean getEntryList4(Integer page, Integer count, String keywords);
    int getEntryCount(String keywords);

    int addEntryOne(Map<String, Object> map);

    int updateEntryOne(Map<String, Object> map);
    int updateEntryOne1(Map<String, Object> map);
    int updateEntryOne2(Map<String, Object> map);
    int updateEntryOne3(Map<String, Object> map);

}