package com.neuedu.neupha.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.neuedu.mapper.SchedulingMapper;
import com.neuedu.neupha.service.SchedulingService;

/** 
* 排班管理专属Service
* @auther: 东软教师
* @date:   2019-2-18
*/ 
@Service
@Transactional
public class SchedulingServiceImpl implements SchedulingService {
    @Autowired
    SchedulingMapper schedulingMapper;
    
    /** 
     * 按条件分页查询排班的方法   
     * @param: page当前页   count每页显示记录数量   keywords keywords2 查询关键字
     * @return: 包含查询结果的Map集合
     */  
    public List<Map<String,Object>> getSchedulingList( Integer page, Integer count,String keywords,String keywords2,String keywords3) {
         int start = (page - 1) * count;
         return schedulingMapper.getSchedulingList(start, count, keywords ,keywords2,keywords3);
    }

   /**
     * 获取符合条件的记录数量
     * @param keywords keywords2 查询条件
     * @return 记录数量
     */
     public int getSchedulingCount( String keywords, String keywords2,String keywords3) {
         return schedulingMapper.getSchedulingCount(keywords, keywords2,keywords3);
     }

     public int getSchedulingCount02( String keywords) {
         return schedulingMapper.getSchedulingCount02(keywords);
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
  	public static int dayForWeek(String pTime) throws Exception {
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
   }	

}