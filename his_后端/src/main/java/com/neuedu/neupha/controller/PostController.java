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


import com.neuedu.bean.RespBean;
import com.neuedu.neupha.service.PostService;



@RestController
@RequestMapping("/neupha/Post")
public class PostController {
    @Autowired
    private PostService phaService;

    @RequestMapping(value = "/listPage", method = RequestMethod.GET)
    public RespBean getPostPage( @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber,
                                  @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,String keywords01 ) {

        RespBean resp = phaService.getPostList( pageNumber, pageSize,keywords01);
        return resp;
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public RespBean addNewPost(@RequestParam Map<String,Object> map) {
        int result = phaService.addPostOne(map);
        if (result == 1) {
            return new RespBean("success", "添加成功!(岗位信息)");
        }
        return new RespBean("error", "添加失败!");
    }
    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public RespBean updatePost(@RequestParam Map<String,Object> map) {
        int result = phaService.updatePostOne(map);
        if (result == 1) {
            return new RespBean("success", "修改成功!(岗位信息)");
        }
        return new RespBean("error", "修改失败!");
    }

    @RequestMapping(value = "/{ids}", method = RequestMethod.DELETE)
    public RespBean delPostOne(@PathVariable("ids") String ids) {
        boolean result = phaService.delPost(ids);
        if (result) {
            return new RespBean("success", "删除成功!(岗位信息)");
        }
        return new RespBean("error", "删除失败!");
    }





}
