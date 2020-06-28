package com.neuedu.neupha.service;

import java.util.List;
import java.util.Map;

/**
* 疾病类型管理专属Service接口
* @auther: 东软教师
* @date:   2019-2-18
*/
public interface DiseCategoryService {

	/**
	 * 按条件统计记录数量  确定页数最大值时用的
	 * @param keywords keywords2 查询关键字
	 * @return 记录数量  整型
	 */
	int getSchedulingCount1(String keywords, String keywords2,String keywords3);

	/**
	 * 按条件统计记录数量  确定页数最大值时用的
	 * @param keywords 查询关键字
	 * @return 记录数量  整型
	 */
	int getSchedulingCount021(String keywords);

	/**
	 * 获取排班医生的 挂号额度
	 * @param keywords keywords2 keywords3 查询关键字
	 * @return 挂号额度  整型
	 */
/*
	int getSchedulingCount06(String keywords, String keywords2, String keywords3);
*/


	/**
	 * 按条件分页查询规则记录的方法
	 * @param: page当前页   count每页显示记录数量   keywords keywords2查询关键字
	 * @return: 包含查询结果的Map集合
	 */
	List<Map<String, Object>> getSchedulingList1(Integer page, Integer count, String keywords, String keywords2,String keywords3);
}