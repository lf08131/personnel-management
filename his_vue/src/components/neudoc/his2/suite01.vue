<template>
	<el-container >
		<el-aside style="width:40%;background:#fff">
			<el-row style="background-color: #EAF1F5">
          <el-col :span="6" style="margin-top: 4px;">
            <el-tag size="small">病历模板：</el-tag>
          </el-col>
          <el-col :span="6" >
          <el-button type="text" size="small" class="el-icon-circle-plus" @click="dialogTableVisible = true">新建模板</el-button>

            <el-dialog title="创建模板" :visible.sync="dialogTableVisible" label-width="80px">
              <el-form ref="form"  >
                <el-form-item label="模板类型">
                  <el-select  placeholder="请选择模板类型" v-model="eltab02">
                    <el-option label="内科病历模板" value="neike"></el-option>
                    <el-option label="门诊病历模板" value="menzen"></el-option>
                    <el-option label="融合病历模板" value="ronghe"></el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="模板名称">
                  <el-input ></el-input>
                </el-form-item>
                <el-form-item label="模板范围">
                <el-radio v-model="radio01" label="3">全院</el-radio>
                <el-radio v-model="radio01" label="6">科室</el-radio>
                <el-radio v-model="radio01" label="9">个人</el-radio>
                </el-form-item>
                <el-form-item>
                  <el-button type="primary" @click="onSubmit">立即创建</el-button>
                  <el-button @click="onSubmit">取消</el-button>
                </el-form-item>
              </el-form>
            </el-dialog>

         </el-col>
          <el-col :span="6" >
          <el-button type="text" size="small" class="el-icon-edit" >修改名称</el-button>
          </el-col>
          <el-col :span="6" >
          <el-button type="text" size="small" class="el-icon-delete">删除模板</el-button>
         </el-col>
			</el-row>
			<el-row style="margin-top: 10px;">
				模板范围：
	    		<el-radio v-model="radio01" label="1" >全院</el-radio>
				<el-radio v-model="radio01" label="2">科室</el-radio>
				<el-radio v-model="radio01" label="3">个人</el-radio>
			</el-row>
			<el-row>
	    		<el-input placeholder="输入模板名称" class="input-with-select">
				    <el-button slot="append" icon="el-icon-search"></el-button>
				</el-input>
			</el-row>
			<el-row>
        <el-table ref="singleTable" :data="tableData01"
                  style="width: 100%" :show-header="true">
          <el-table-column prop="choose02" label="" width="30px">
            <template slot-scope="scope">
              <input type="radio" name="chooseOne01" />
            </template>
          </el-table-column>
          <el-table-column property="leixing" label="模板类型" width="80">
          </el-table-column>
          <el-table-column property="mingcheng" label="模板名称" >
          </el-table-column>
          <el-table-column property="shijian" label="创建时间" width="120">
          </el-table-column>
        </el-table>
			</el-row>
		</el-aside>
		<el-main style="width:60%;background:#fff;height: 1200px;">
			<el-form ref="form" label-width="80px">
				<el-row style="background-color: #EAF1F5">
				  	<el-col :span="18" style="margin-top: 4px;">
			  			<el-tag size="small">模板内容：</el-tag>
			  		</el-col>
			  		
			  		<el-col :span="6" >
			  			<el-button type="primary" size="mini" plain class="el-icon-circle-plus-outline">保存模板</el-button>
				   </el-col>
				</el-row>
				
				<el-form-item label="主诉">
			    <el-input type="textarea"  :rows="2" ></el-input>
				</el-form-item>
				<el-form-item label="现病史">
			    <el-input type="textarea" v-model="siteName" :rows="2" ></el-input>
				</el-form-item>				
			  <el-form-item label="体格检查">
			    <el-input type="textarea" :rows="2" ></el-input>
			  </el-form-item>								
			  <el-form-item label="辅助检查">
			    <el-input type="textarea" :rows="2" ></el-input>
			  </el-form-item>
			</el-form>
		</el-main>
		
	</el-container>  
</template>

<script>
export default {
  methods:{
    nodeClick:function (clickDate) {
      this.siteName = clickDate.label;
    },
    onSubmit:function(){
      this.dialogTableVisible=false;
    }
  },
  data() {
  	return {
      siteName:"",
  		radio01:1,
      dialogTableVisible: false,
  		eltab01:'first',
  		eltab02:'',
      radio01:'3',
      tableData01:[{
        leixing:'内科病历',
        mingcheng:'慢性咽炎',
        shijian:'2019-01-05'
      },{
        leixing:'内科病历',
        mingcheng:'哮喘',
        shijian:'2019-01-05'
      },{
        leixing:'门诊病历',
        mingcheng:'感冒',
        shijian:'2019-01-05'
      },{
        leixing:'门诊病历',
        mingcheng:'滑膜炎',
        shijian:'2019-01-05'
      },{
        leixing:'融合病历',
        mingcheng:'免疫力低下',
        shijian:'2019-01-05'
      },{
        leixing:'融合病历',
        mingcheng:'放射损伤',
        shijian:'2019-01-05'
      }],



  	}
  }
}
</script>

<style>
</style>
