package com.neuedu.neupha.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.neuedu.bean.RespBean;
import com.neuedu.neupha.service.SchedulingService;


/** 
* 排班管理专属Controller 
* @auther: 东软教师
* @date:   2019-2-18
*/ 
@RestController
@RequestMapping("/neusys/scheduling")
public class SchedulingController {
    @Autowired
    SchedulingService schedulingService;

    /** 
     * 按条件分页查询排班的方法   
     * @param: page当前页   count每页显示记录数量   keywords keywords2 查询关键字
     * @return: 包含查询结果的Map集合
     */  
    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public Map<String, Object> getSchedulingList( @RequestParam(value = "page", defaultValue = "1") Integer page, 
    		@RequestParam(value = "count", defaultValue = "10") Integer count,@RequestParam("keywords") String keywords,@RequestParam("keywords2") String keywords2,@RequestParam("keywords3") String keywords3) {
        int totalCount = schedulingService.getSchedulingCount(keywords,keywords2,keywords3);
        List<Map<String,Object>> list = schedulingService.getSchedulingList( page, count,keywords,keywords2,keywords3);
        Map<String, Object> map = new HashMap<>();
        map.put("totalCount", totalCount);//totalCount  10
        map.put("list", list);
        
        return map;
    }
}