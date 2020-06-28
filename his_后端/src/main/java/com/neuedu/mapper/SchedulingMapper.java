package com.neuedu.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;


@Mapper
public interface SchedulingMapper extends BaseMapper{
	
    List<Map<String,Object>> getSchedulingList( @Param("start") Integer start, @Param("count") Integer count
			,@Param("keywords") String keywords ,@Param("keywords2") String keywords2,@Param("keywords3") String keywords3);

    
    int getSchedulingCount( @Param("keywords") String keywords, @Param("keywords2") String keywords2,@Param("keywords3") String keywords3);
    
    int getSchedulingCount02( @Param("keywords") String keywords);
    
   /* int getSchedulingCount06( @Param("keywords") String keywords,@Param("keywords2") String keywords2
    		,@Param("keywords3") String keywords3);*/

}
