<template>
  <!-- 4.门诊确诊 -->
	<div class="container" >
	<el-form ref="form" v-model="form01" label-width="80px">
	<el-row style="background-color: #EAF1F5;margin-top: 5px;">
    <el-col :span="15" >
      <el-tag size="small">患者病历填写：</el-tag>
    </el-col>

    <el-col :span="3"><el-button type="text" size="small" class="el-icon-success" @click="showMsg('保存')">保存</el-button></el-col>
    <el-col :span="3"><el-button type="text" size="small" class="el-icon-delete" @click="showMsg('作废')">作废</el-button></el-col>
    <el-col :span="3"><el-button type="text" size="small" class="el-icon-delete" @click="showMsg('刷新')">刷新</el-button></el-col>

		  		
	</el-row>	
	<el-row style="margin-top: 2px;">
			<el-form-item label="病历号">
		    <el-input ></el-input>
		  </el-form-item>
  </el-row>
    <el-row style="margin-top: 2px;">
			<el-form-item label="患者姓名">
		    <el-input v-model="this.$store.state.Register.RealName"></el-input>
		    </el-form-item>
    </el-row>
    <el-row style="margin-top: 2px;">
			<el-form-item label="性别">
		    <el-select v-model="selected01" placeholder="请选择">
		      <el-option label="男" value="男"></el-option>
		      <el-option label="女" value="女"></el-option>
		    </el-select>
		  </el-form-item>
    </el-row>
    <el-row style="margin-top: 2px;">
			<el-form-item label="年龄">
		    <el-input ></el-input>
		    </el-form-item>
	</el-row>
	<el-row style="margin-top: 2px;">
		<el-form-item label="检查">
		    <el-input type="textarea" :rows="5" placeholder="请输入检查结果" ></el-input>
		</el-form-item>
	</el-row>
	<el-row style="margin-top: 2px;">
		<el-form-item label="诊断">
		    <el-input type="textarea" :rows="4" placeholder="请输入诊断结果" ></el-input>
		</el-form-item>		
	</el-row>
	<el-row style="margin-top: 2px;">
		<el-form-item label="处理意见">
		    <el-input type="textarea" :rows="3" placeholder="请输入处理意见" ></el-input>
		</el-form-item>		
	</el-row>
	
	</el-form>
   </div>
</template>

<script>
import {showMsgTitle} from '../../../utils/api'
export default {
  methods:{
    showMsg(msg){
      showMsgTitle(this,msg);
    }
  },
  data() {
  	return {
      form01:{},
  		selected01:'男',

  	}
  }
}
</script>

<style>
</style>
