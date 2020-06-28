package com.neuedu.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
@Mapper
public interface UsersMapper extends BaseMapper{
	//批量插入上传的excel数据
    public int insertUsersBatch(List<Map<String,Object>> drugList);
    
    //分页显示药品信息
    public List<Map<String,Object>> getUsersList(@Param("start")int start, @Param("count")Integer count, @Param("keywords")String keywords);
    int getUsersCount(@Param("keywords")String keywords);
    
    
}