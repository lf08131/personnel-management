package com.neuedu.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
@Mapper
public interface DisecategoryMapper extends BaseMapper{

    List<Map<String,Object>> getSchedulingList1( @Param("start") Integer start, @Param("count") Integer count
            ,@Param("keywords") String keywords ,@Param("keywords2") String keywords2,@Param("keywords3") String keywords3);


    int getSchedulingCount1( @Param("keywords") String keywords, @Param("keywords2") String keywords2,@Param("keywords3") String keywords3);

    int getSchedulingCount021( @Param("keywords") String keywords);
}