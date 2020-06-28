package com.neuedu.neupha.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.neuedu.mapper.DisecategoryMapper;
import com.neuedu.neupha.service.DiseCategoryService;


/**
* 人员信息维护
* @auther: 东软教师
* @date:   2018-11-29
*/
@Service
@Transactional
public class DiseCategoryServiceImpl implements DiseCategoryService {
    @Autowired
    DisecategoryMapper diseCategoryMapper;

    /**
     * 按条件分页查询排班的方法
     * @param: page当前页   count每页显示记录数量   keywords keywords2 查询关键字
     * @return: 包含查询结果的Map集合
     */
    public List<Map<String,Object>> getSchedulingList1( Integer page, Integer count,String keywords,String keywords2,String keywords3) {
        int start = (page - 1) * count;
        return diseCategoryMapper.getSchedulingList1(start, count, keywords ,keywords2,keywords3);
    }

    /**
     * 获取符合条件的记录数量
     * @param keywords keywords2 查询条件
     * @return 记录数量
     */
    public int getSchedulingCount1( String keywords, String keywords2,String keywords3) {
        return diseCategoryMapper.getSchedulingCount1(keywords, keywords2,keywords3);
    }

    public int getSchedulingCount021( String keywords) {
        return diseCategoryMapper.getSchedulingCount021(keywords);
    }

    /**
     * 获取排班医生的 挂号额度
     * @param keywords keywords2 keywords3 查询关键字
     * @return 挂号额度  整型
     */
   /*  public int getSchedulingCount06(String keywords,String keywords2,String keywords3) {
         return schedulingMapper.getSchedulingCount06(keywords,keywords2,keywords3);
     }*/

    /**
     * 判断当前日期是星期几
     *
     * @param pTime 修要判断的时间
     * @return dayForWeek 判断结果
     * @Exception 发生异常
     */
  /*  public static int dayForWeek1(String pTime) throws Exception {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c = Calendar.getInstance();
        c.setTime(format.parse(pTime));
        int dayForWeek = 0;
        if(c.get(Calendar.DAY_OF_WEEK) == 1){
            dayForWeek = 7;
        }else{
            dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
        }
        return dayForWeek;
    }*/
}