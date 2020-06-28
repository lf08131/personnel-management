package com.neuedu.neupha.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.neuedu.bean.RespBean;
import com.neuedu.neupha.service.UsersService;


/** 
* 操作药品Controller 
* @auther: 东软教师
* @date:   2018-11-29
*/ 
@RestController
@RequestMapping("/neupha/Users")
public class UsersController {
    @Autowired
    private UsersService phaService;
    
    @RequestMapping(value = "/listPage", method = RequestMethod.GET)
    public RespBean getDrugsPage( @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber, 
    		@RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,String keywords01 ) {

        RespBean resp = phaService.getUsersList( pageNumber, pageSize,keywords01);
        return resp;
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public RespBean addNewDrug(@RequestParam Map<String,Object> map) {
        int result = phaService.addUsersOne(map);
        if (result == 1) {
            return new RespBean("success", "添加成功!(药品信息)");
        }
        return new RespBean("error", "添加失败!");
    }
    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public RespBean updateDrug(@RequestParam Map<String,Object> map) {
        int result = phaService.updateUsersOne(map);
        if (result == 1) {
            return new RespBean("success", "修改成功!(药品信息)");
        }
        return new RespBean("error", "修改失败!");
    }
    
    @RequestMapping(value = "/{ids}", method = RequestMethod.DELETE)
    public RespBean delDrugOne(@PathVariable("ids") String ids) {
        boolean result = phaService.delUsers(ids);
        if (result) {
            return new RespBean("success", "删除成功!(药品信息)");
        }
        return new RespBean("error", "删除失败!");
    }
    



}
