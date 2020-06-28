package com.neuedu.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
@Mapper
public interface EntryMapper extends BaseMapper{
    //批量插入上传的excel数据
    public int insertUsersBatch(List<Map<String,Object>> drugList);

    //分页显示药品信息
    public List<Map<String,Object>> getEntryList(@Param("start")int start, @Param("count")Integer count, @Param("keywords")String keywords);
    int getEntryCount(@Param("keywords")String keywords);
    public List<Map<String,Object>> getEntryList1(@Param("start")int start, @Param("count")Integer count, @Param("keywords")String keywords);
    int getEntryCount1(@Param("keywords")String keywords);
    public List<Map<String,Object>> getEntryList2(@Param("start")int start, @Param("count")Integer count, @Param("keywords")String keywords);
    int getEntryCount2(@Param("keywords")String keywords);
    public List<Map<String,Object>> getEntryList3(@Param("start")int start, @Param("count")Integer count, @Param("keywords")String keywords);
    int getEntryCount3(@Param("keywords")String keywords);
    public List<Map<String,Object>> getEntryList4(@Param("start")int start, @Param("count")Integer count, @Param("keywords")String keywords);
    int getEntryCount4(@Param("keywords")String keywords);
}