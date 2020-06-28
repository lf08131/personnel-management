package com.neuedu.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by Think on 2020/6/24.
 */
@Mapper
public interface PostMapper extends BaseMapper {
	public int insertPostBatch(List<Map<String,Object>> drugList);

	//分页显示药品信息
	public List<Map<String,Object>> getPostList(@Param("start")int start, @Param("count")Integer count, @Param("keywords")String keywords);
	int getPostCount(@Param("keywords")String keywords);
}
