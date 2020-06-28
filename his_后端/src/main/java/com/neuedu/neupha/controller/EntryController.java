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
import com.neuedu.neupha.service.EntryService;



@RestController
@RequestMapping("/neupha/Entry")
public class EntryController {
    @Autowired
    private EntryService phaService;

    @RequestMapping(value = "/listPage", method = RequestMethod.GET)
    public RespBean getEntryPage( @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber,
                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,String keywords01 ) {

        RespBean resp = phaService.getEntryList( pageNumber, pageSize,keywords01);
        return resp;
    }
    @RequestMapping(value = "/listPage1", method = RequestMethod.GET)
    public RespBean getEntryPage1( @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber,
                                  @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,String keywords01 ) {

        RespBean resp = phaService.getEntryList1( pageNumber, pageSize,keywords01);
        return resp;
    }
    @RequestMapping(value = "/listPage2", method = RequestMethod.GET)
    public RespBean getEntryPage2( @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber,
                                   @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,String keywords01 ) {

        RespBean resp = phaService.getEntryList2( pageNumber, pageSize,keywords01);
        return resp;
    }
    @RequestMapping(value = "/listPage3", method = RequestMethod.GET)
    public RespBean getEntryPage3( @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber,
                                   @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,String keywords01 ) {

        RespBean resp = phaService.getEntryList3( pageNumber, pageSize,keywords01);
        return resp;
    }@RequestMapping(value = "/listPage4", method = RequestMethod.GET)
    public RespBean getEntryPage4( @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber,
                                   @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,String keywords01 ) {

        RespBean resp = phaService.getEntryList4( pageNumber, pageSize,keywords01);
        return resp;
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public RespBean addNewEntry(@RequestParam Map<String,Object> map) {
        int result = phaService.addEntryOne(map);
        if (result == 1) {
            return new RespBean("success", "入职成功");
        }
        return new RespBean("error", "请再次填写!");
    }

    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public RespBean updateEntry(@RequestParam Map<String,Object> map) {
        int result = phaService.updateEntryOne(map);
        if (result == 1) {
            return new RespBean("success", "修改成功!(员工信息)");
        }
        return new RespBean("error", "修改失败!");
    }
    @RequestMapping(value = "/1", method = RequestMethod.PUT)
    public RespBean updateEntry1(@RequestParam Map<String,Object> map) {
        int result = phaService.updateEntryOne1(map);
        if (result == 1) {
            return new RespBean("success", "修改成功!(员工信息)");
        }
        return new RespBean("error", "修改失败!");
    }
    @RequestMapping(value = "/2", method = RequestMethod.PUT)
    public RespBean updateEntry2(@RequestParam Map<String,Object> map) {
        int result = phaService.updateEntryOne2(map);
        if (result == 1) {
            return new RespBean("success", "修改成功!(员工信息)");
        }
        return new RespBean("error", "修改失败!");
    }
    @RequestMapping(value = "/3", method = RequestMethod.PUT)
    public RespBean updateEntry3(@RequestParam Map<String,Object> map) {
        int result = phaService.updateEntryOne3(map);
        if (result == 1) {
            return new RespBean("success", "修改成功!(员工信息)");
        }
        return new RespBean("error", "修改失败!");
    }








}
