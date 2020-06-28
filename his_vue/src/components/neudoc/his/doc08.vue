<template>
  <!-- 8.患者账单 -->
	<div class="container" >
	
	<el-row style="background-color: #EAF1F5">
		<el-tag size="mini">患者账单明细：</el-tag>
	</el-row>
	<el-row style="margin: 5px;">
		<el-table :data="tableData01" style="width: 100%" ref="singleTable" >
			<el-table-column type="index" width="50">
    		</el-table-column>
		    <el-table-column property="mingcheng" label="名称" >
		    </el-table-column>
		    <el-table-column property="guige" label="规格" width="160">
		    </el-table-column>
		    <el-table-column property="shuliang" label="数量" width="100">
		    </el-table-column>
		    <el-table-column property="fushu" label="付数" width="100">
		    </el-table-column>
		    <el-table-column property="danjia" label="单价" width="100">
		    </el-table-column>
		    <el-table-column property="jiner" label="金额" width="100">
		    </el-table-column>
		    <el-table-column property="zhuangtai" label="收费状态" width="100">
		    </el-table-column>
		</el-table>
	</el-row>
	<el-row style="margin: 5px;">
		<el-tag size="mini">金额合计：</el-tag><span>215.00元</span>
	</el-row>
	
   </div>
</template>

<script>
export default {
  data() {
  	return {
  		tableData01:[{
  			mingcheng:'挂号费',
  			guige:'',
  			shuliang:'1',
  			fushu:'1',
  			danjia:'5.00',
  			jiner:'5.00',
  			zhuangtai:'已收费',
  		},{
  			mingcheng:'B超常规检查',
  			guige:'',
  			shuliang:'1',
  			fushu:'1',
  			danjia:'200.00',
  			jiner:'200.00',
  			zhuangtai:'划价',
  		},{
  			mingcheng:'呋喃妥因肠溶片',
  			guige:'50mg*100片',
  			shuliang:'2',
  			fushu:'2',
  			danjia:'5.00',
  			jiner:'10.00',
  			zhuangtai:'划价',
  		}]
  	}
  }
}
</script>

<style>
</style>
