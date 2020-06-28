<template>
  <!-- 7.草药处方 -->
	<el-container>
      <!-- 页面弹窗 -->
      <el-dialog
        title="保存为常用模板"
        :visible.sync="dialog01Visible"
        width="30%">
        <el-form size="mini">
          <el-form-item>
            <el-input placeholder="请输入药品助记码"  class="input-with-select" style="width: 100%">
              <template slot="prepend">药品名称：</template>
            </el-input>
          </el-form-item>
          <el-form-item label="已选择药品">
            <el-table border :data="tableData03" size="mini">
              <el-table-column prop="choose02" label="" width="30px">
                <template slot-scope="scope">
                  <input type="radio" name="chooseOne01" />
                </template>
              </el-table-column>
              <el-table-column property="mingcheng" label="名称" >
              </el-table-column>
              <el-table-column property="guige" label="规格" >
              </el-table-column>
              <el-table-column property="danwei" label="单位" width="60">
              </el-table-column>
            </el-table>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="dialog01Visible = false">确 定</el-button>
            <el-button @click="dialog01Visible = false">取 消</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>

      <el-dialog
        title="保存为常用模板"
        :visible.sync="dialog02Visible"
        width="30%">
        <el-form size="mini">
          <el-form-item>
            <el-input placeholder="请输入内容"  class="input-with-select" style="width: 100%">
              <template slot="prepend">模板名称：</template>
            </el-input>
          </el-form-item>

          <el-form-item label="模板范围">
            <el-radio v-model="dialogRadio01" label="1">个人</el-radio>
            <el-radio v-model="dialogRadio01" label="2">科室</el-radio>
            <el-radio v-model="dialogRadio01" label="3">全院</el-radio>
          </el-form-item>
          <el-form-item label="已选择药品">
            <el-table border :data="tableData03" size="mini">
              <el-table-column prop="choose02" label="" width="30px">
                <template slot-scope="scope">
                  <input type="radio" name="chooseOne01" />
                </template>
              </el-table-column>
              <el-table-column property="mingcheng" label="名称" >
              </el-table-column>
              <el-table-column property="guige" label="规格" >
              </el-table-column>
              <el-table-column property="danwei" label="单位" width="60">
              </el-table-column>
            </el-table>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="dialog02Visible = false">确 定</el-button>
            <el-button @click="dialog02Visible = false">取 消</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>

      <el-dialog
        title="增加处方"
        :visible.sync="dialog03Visible"
        width="30%">
        <el-form size="mini">
          <el-form-item>
            <el-input placeholder="默认名为‘新增处方’"  class="input-with-select" style="width: 100%">
              <template slot="prepend">处方名称：</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="dialog03Visible = false">确 定</el-button>
            <el-button @click="dialog03Visible = false">取 消</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>
      <!-- 页面正文 -->
		  <el-header >
		  	<el-row>					  		
		  		<el-tag>门诊诊断：</el-tag>
		  		<el-tag type="info">【中医诊断】风湿化热证</el-tag>					  		
		  	</el-row>
        <el-row style="background-color: #EAF1F5">
          <el-col :span="7" style="margin-top: 4px;"><el-tag >门诊处方：</el-tag></el-col>
          <el-col :span="2"><el-button type="text" class="el-icon-circle-plus" @click="dialog03Visible=true">增方</el-button></el-col>
          <el-col :span="2"><el-button type="text" class="el-icon-remove" @click="showConfirm('删除选择处方')">删方</el-button></el-col>
          <el-col :span="2"><el-button type="text" class="el-icon-tickets" @click="showMsg('暂存选择处方')">保存</el-button></el-col>
          <el-col :span="2"><el-button type="text" class="el-icon-success" @click="showConfirm('发送选择处方')">发送</el-button></el-col>
          <el-col :span="2"><el-button type="text" class="el-icon-delete" @click="showConfirm('作废已经发送处方')">作废</el-button></el-col>
          <el-col :span="3"><el-button type="text"></el-button></el-col>
          <el-col :span="2"><el-button type="text" class="el-icon-circle-plus-outline" @click="dialog01Visible=true">增药</el-button></el-col>
          <el-col :span="2"><el-button type="text" class="el-icon-remove-outline" @click="showConfirm('在处方中删除选择的药品')">删药</el-button></el-col>
        </el-row>
		  </el-header>
		  <el-container >
		  <el-aside width="250px" >
		  	<el-card class="box-card" >
			  <div slot="header" class="clearfix">
			    <span>处方</span>
			    <el-button style="float: right; padding: 3px 0" type="text" @click="dialog02Visible=true">存为模板</el-button>
			   </div>							
			<el-table ref="singleTable" :data="tableData01" highlight-current-row @current-change="handleCurrentChange"
			    style="width: 100%" :show-header="false">
        <el-table-column prop="choose02" label="" width="30px">
          <template slot-scope="scope">
            <input type="radio" name="chooseOne01" />
          </template>
        </el-table-column>
			    <el-table-column property="name" label="名称" width="110">
			    </el-table-column>
			    <el-table-column property="state" label="状态" width="80">
			    </el-table-column>
			</el-table>
			</el-card>
		  </el-aside>
		  <el-main >
		  	<el-row>
			  <el-col :span="6"><div class="grid-content ">
			  	处方类型：
		  		<el-select size="mini" style="width: 80px;" v-model="select01" placeholder="请选择">
			    	<el-option v-for="item in selectData01" :key="item.value" :label="item.label" :value="item.value">
					</el-option>
			    </el-select>
			  </div></el-col>
			  <el-col :span="6"><div class="grid-content ">
			  	付数：<el-input type="number" size="mini" style="width: 80px;"></el-input>						  	
			  </div></el-col>
			  <el-col :span="6"><div class="grid-content ">
			  	频次：
		  		<el-select size="mini" style="width: 100px;" v-model="select03" placeholder="请选择">
			    	<el-option v-for="item in selectData03" :key="item.value" :label="item.label" :value="item.value">
					</el-option>
			    </el-select>
			  </div></el-col>
			  <el-col :span="6"><div class="grid-content ">
			  	用法：
		  		<el-select size="mini" style="width: 100px;" v-model="select04" placeholder="请选择">
			    	<el-option v-for="item in selectData04" :key="item.value" :label="item.label" :value="item.value">
					</el-option>
			    </el-select>
			  </div></el-col>
			</el-row>
			<el-row>
				<el-col :span="6">
					治法：<el-input size="mini" style="width: 80px;"></el-input>
				</el-col>
				<el-col :span="3" style="margin-top: 4px;">
					<span >治法详细：</span>
				</el-col>
				<el-col :span="15">
					<el-input size="mini" style="width: 95%;"></el-input>
				</el-col>
			</el-row>
			<el-row>
				<el-col :span="24">
					医嘱：<el-input size="mini" style="width: 90%;"></el-input>
				</el-col>
			</el-row>
		  	<el-row>
				<el-col :span="24">
		  		处方金额：250.00元
		  	</el-col>
			</el-row>
		  	<el-table ref="singleTable" :data="tableData08"
			    style="width: 100%" :show-header="true">
			    <el-table-column  type="selection">
			    </el-table-column>
			    <el-table-column property="mingcheng" label="药品名称*" >
			    </el-table-column>
			    <el-table-column property="yongliang" label="用量*" width="100">
			    </el-table-column>
			    <el-table-column property="danwei" label="单位" width="60">
			    </el-table-column>
			    <el-table-column property="jiaozhu" label="脚注" width="120">
			    </el-table-column>
			    <el-table-column property="danjia" label="单价" width="80">
			    </el-table-column>
			</el-table>
		  </el-main>
		  </el-container>
		  <el-footer style="height: 500px">
		  	<el-tabs type="card" v-model="activeName">
			<el-tab-pane label="处方模板" name="first">
			    	<el-container direction="horizontal">
					  <el-aside width="400px">
					  	<el-card class="box-card">
						  <div slot="header" class="clearfix">
						    <span style="font-size: small;">处方模板列表</span>
						    &nbsp;&nbsp;&nbsp;&nbsp;
							    <el-radio v-model="radio01" label="3">全院</el-radio>
							    <el-radio v-model="radio01" label="6">科室</el-radio>
							    <el-radio v-model="radio01" label="9">个人</el-radio>
						  </div>
						  <el-table :data="tableData06" style="width: 100%" ref="singleTable" highlight-current-row :show-header='false'>
                <el-table-column prop="choose02" label="" width="30px">
                  <template slot-scope="scope">
                    <input type="radio" name="chooseOne01" />
                  </template>
                </el-table-column>
                <el-table-column
						        prop="name"
						        label="名称">
						      </el-table-column>
						      
						    </el-table>
						</el-card>
					  </el-aside>
					  <el-main>
					  	<el-card class="box-card" style="margin-top: -20px;margin-left: -20px;">
						  <div slot="header" class="clearfix">
						    <span style="font-size: small;">模板明细</span>
						    <el-button style="float: right; padding: 3px 0" type="text" @click="showConfirm('使用选择的模板作为处方')">使用该模板</el-button>
						  </div>
						  <el-table :data="tableData08" style="width: 100%" ref="singleTable" >
						    <el-table-column property="mingcheng" label="药品名称*" >
						    </el-table-column>
						    <el-table-column property="yongliang" label="用量*" width="100">
						    </el-table-column>
						    <el-table-column property="danwei" label="单位" width="60">
						    </el-table-column>
						    <el-table-column property="jiaozhu" label="脚注" width="120">
						    </el-table-column>
						    <el-table-column property="danjia" label="单价" width="80">
						    </el-table-column> 
						    </el-table>
						</el-card>
					  </el-main>
					</el-container>
			    </el-tab-pane>
          <el-tab-pane label="常用药品" name="second">
            <el-tag type="success" closable @close="showConfirm('删除该常用药品')"><span @click="showConfirm('在处方中添加该药品')">5%葡萄糖注射液 250ml*1袋</span></el-tag>
            <el-tag type="success" closable @close="showConfirm('删除该常用药品')"><span @click="showConfirm('在处方中添加该药品')">5%葡萄糖注射液 250ml*1袋</span></el-tag>
            <el-tag type="success" closable @close="showConfirm('删除该常用药品')"><span @click="showConfirm('在处方中添加该药品')">5%葡萄糖注射液 250ml*1袋</span></el-tag>
          </el-tab-pane>
			    <el-tab-pane label="建议方案" name="third">					    	
			    	<el-tag type="warning">暂时不完成。。。</el-tag>
			    	<div style="font-size: small;font-family: '仿宋';">
			    	建议方案是事先根据一些常用的疾病的治疗方案，已经制定完成的处方方案；<br>
			    	当医生开立诊断后选择，系统可以根据诊断结果列出该疾病的病因、注意事项、针对该疾病的用药方案及相应的方案的说明及注意事项；<br>
			    	主要目的是用来辅助医生诊疗。
			    	</div>
			    </el-tab-pane>
			    <el-tab-pane label="历史处方" name="fourth">
			    	<el-container direction="horizontal">
					  <el-aside width="400px">

						  <el-table :data="tableData07" style="width: 100%" ref="singleTable" highlight-current-row :show-header='false'>
                <el-table-column prop="choose02" label="" width="30px">
                  <template slot-scope="scope">
                    <input type="radio" name="chooseOne01" />
                  </template>
                </el-table-column>
                <el-table-column width="160px" prop="datetime" label="处方时间">
						      </el-table-column>
						      <el-table-column prop="name01" label="诊断结果">
						      </el-table-column>
						      <el-table-column  prop="name02" label="处方名称">
						      </el-table-column>									      
						    </el-table>
						
					  </el-aside>
					  <el-main>
					  	<el-card class="box-card" style="margin-top: -20px;margin-left: -20px;">
						  <div slot="header" class="clearfix">
						    <span style="font-size: small;">处方明细</span>
						    <el-button style="float: right; padding: 3px 0" type="text" @click="showConfirm('使用该历史处方')">使用该处方</el-button>
						  </div>
						  <el-table :data="tableData08" style="width: 100%" ref="singleTable" >
						    <el-table-column property="mingcheng" label="药品名称*" >
						    </el-table-column>
						    <el-table-column property="yongliang" label="用量*" width="100">
						    </el-table-column>
						    <el-table-column property="danwei" label="单位" width="60">
						    </el-table-column>
						    <el-table-column property="jiaozhu" label="脚注" width="120">
						    </el-table-column>
						    <el-table-column property="danjia" label="单价" width="80">
						    </el-table-column>
						    </el-table>
						</el-card>
					  </el-main>
					</el-container>
			    </el-tab-pane>
			  </el-tabs>
		  </el-footer>
		</el-container>
</template>

<script>
  import {showMsgTitle} from '../../../utils/api'
  import  {showMsgConfirm} from '../../../utils/api'
export default {
  methods:{
    showConfirm(msg) {
      showMsgConfirm(this, msg);
    },
    showMsg(msg) {
      showMsgTitle(this, msg);
    },
    handleCurrentChange(){

    },
  },
  data() {
  	return {
      dialog01Visible:false,
      dialog02Visible:false,
      dialog03Visible:false,
      dialogRadio01:'1',
      tableData03:[],
      selectData01:[],
      selectData02:[],
      selectData03:[],
      selectData04:[],
      select01:[],
      select02:[],
      select03:[],
      select04:[],
  		tableData01:[{
        	name:'新增处方01',
        	state:'已发送'
        },{
        	name:'新增处方02',
        	state:'暂存'
        },{
        	name:'新增处方03',
        	state:''
        }],
  		tableData06: [{
          name: '病毒性感冒处方',
        }, {
          name: '寒湿瘀郁证处方',
        }, {
          name: '细菌炎症处方',
        }],
        tableData08: [{
          mingcheng:'三七',	          
          yongliang:'一次5克',
          danwei: '克',
          jiaozhu:'研粉末吞服',
          danjia:'2元'
        }, {
          mingcheng:'肉桂',	          
          yongliang:'一次2克',
          danwei: '克',
          jiaozhu:'后下',
          danjia:'0.5元'
        }, {
          mingcheng:'五灵脂',	          
          yongliang:'一次1克',
          danwei: '克',
          jiaozhu:'包煎',
          danjia:'1元'
        },{
          mingcheng:'阿胶',	          
          yongliang:'一次2克',
          danwei: '克',
          jiaozhu:'冲服',
          danjia:'1.5元'
        }],
        tableData07: [{
          datetime:'2018-10-11 10:02:23',
          name01: '病毒性感冒',
          name02:'新建处方03'
        }, {
          datetime:'2018-10-11 10:00:03',
          name01: '病毒性感冒',
          name02:'新建处方02'
        }, {
          datetime:'2018-10-11 09:52:23',
          name01: '病毒性感冒',
          name02:'新建处方01'
        },{
          datetime:'2018-10-11 09:42:23',
          name01: '咽炎',
          name02:'新建处方02'
        },{
          datetime:'2018-10-11 09:40:23',
          name01: '咽炎',
          name02:'新建处方01'
        }],
        radio01:'3',
      activeName:'first',
  	}
  }
}
</script>

<style>
</style>
