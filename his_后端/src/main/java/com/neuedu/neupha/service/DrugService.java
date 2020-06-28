package com.neuedu.neupha.service;

import java.util.List;
import java.util.Map;

import com.neuedu.bean.RespBean;

public interface DrugService {





	RespBean getDrugList(Integer page, Integer count, String keywords);


	int getDrugCount(String keywords);

	int addDrugOne(Map<String, Object> map);


	int updateDrugOne(Map<String, Object> map);


	boolean delDrug(String ids);

}