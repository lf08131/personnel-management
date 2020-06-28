<template>
  <!-- 6.成药处方 -->
	<el-container>
    <!-- 页面弹窗 -->
    <!-- 增加 -->
    <el-dialog title="增加处方" :visible.sync="dialogAddPres" width="30%">
      <el-form size="mini" :model="dialogAddForm">
        <el-form-item>
          <el-input placeholder="默认名为‘新增处方’" v-model="dialogAddForm.PrescriptionName"  class="input-with-select" style="width: 100%">
            <template slot="PrescriptionName">处方名称：</template>
          </el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="addPres">确 定</el-button>
          <el-button @click="dialogAddPres = false">取 消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <!-- 页面正文 -->
	  <el-header >
	  	<el-row>
	  		<el-tag>门诊诊断：</el-tag>
	  		<el-tag type="info">【西医诊断】流行性腮腺炎并心肌炎</el-tag>
	  	</el-row>
	  	<el-row style="background-color: #EAF1F5">
	  		<el-col :span="7" style="margin-top: 4px;"></el-col>
	  		<el-col :span="2"><el-button type="text" class="el-icon-circle-plus" @click="dialogAddPres=true">增方</el-button></el-col>
	  		<el-col :span="2"><el-button type="text" class="el-icon-remove" @click="deleteAll">删方</el-button></el-col>
	  		<el-col :span="2"><el-button type="text" class="el-icon-success" @click="upToSaved">开立</el-button></el-col>
	  		<el-col :span="2"><el-button type="text" class="el-icon-delete" @click="upToBad">作废</el-button></el-col>
        <el-col :span="2"><el-button type="text" class="el-icon-circle-plus-outline" @click="refApply">刷新</el-button></el-col>
	  		<el-col :span="3"><el-button type="text"></el-button></el-col>
	  		<el-col :span="2"><el-button type="text" class="el-icon-circle-plus-outline" @click="showDrugsList">增药</el-button></el-col>
	  		<el-col :span="2"><el-button type="text" class="el-icon-remove-outline" :disabled="this.selItemDrugs.length==0" @click="deleteDrugsDetailed">删药</el-button></el-col>
	  	</el-row>
      <!-- 处方增加药品对话框 -->
      <el-dialog title="处方增加药品" :visible.sync="dialogDrugsVisible" top="10px" width="80%">
        <el-row>
          <el-col :span="18">
            <div class="grid-content bg-purple">
              <el-input placeholder="请输入药品助记码" size="mini" v-model="keywords01">
              </el-input>
            </div>
          </el-col>
          <el-col :span="6">
            <div class="grid-content bg-purple">
              <el-button type="primary" size="mini" style="margin-left: 10px" icon="el-icon-view" @click="searchData">查询药品</el-button>
            </div>
          </el-col>
        </el-row>
        <el-table stripe ref="multipleTable" size="mini"
                  :data="categories" tooltip-effect="dark" style="width: 100%">
          <el-table-column label="药品编码" prop="DrugsCode" width="140" align="left"></el-table-column>
          <el-table-column label="药品名称" prop="DrugsName" align="left"></el-table-column>
          <el-table-column label="药品规格" prop="DrugsFormat" width="140" align="left"></el-table-column>
          <el-table-column label="药品单位" prop="DrugsUnit" width="80" align="left"></el-table-column>
          <el-table-column label="药品单价" prop="DrugsPrice" width="80" align="left"></el-table-column>
          <el-table-column label="药品剂型" prop="DrugsDosageID" :formatter="showFormatConstants"  width="80" align="left"></el-table-column>
          <el-table-column label="药品类型" prop="DrugsTypeID" :formatter="showFormatConstants" width="80" align="left"></el-table-column>
          <el-table-column label="操作" align="center">
            <template slot-scope="scope">
              <el-button type="primary"
                         size="mini"
                         @click="showInnerDialog(scope.$index, scope.row)">选择
              </el-button>
            </template>
            <el-dialog width="30%" title="添加处方中的药品详情" :visible.sync="innerVisible" append-to-body center="center">
              <el-form :label-position="labelPosition" label-width="100px"  :model="formEdit02" class="demo-form-inline" size="mini">
                <el-form-item label="药品编码">
                  <el-input v-model="formEdit02.DrugsCode" placeholder="药品编码" readonly="readonly" ></el-input>
                </el-form-item>
                <el-form-item label="药品名称">
                  <el-input v-model="formEdit02.DrugsName" placeholder="药品名称" readonly="readonly" ></el-input>
                </el-form-item>
                <el-form-item label="药品规格">
                  <el-input v-model="formEdit02.DrugsFormat" placeholder="药品规格" readonly="readonly" ></el-input>
                </el-form-item>
                <el-form-item label="药品单位">
                  <el-input v-model="formEdit02.DrugsUnit" placeholder="药品单位" readonly="readonly"></el-input>
                </el-form-item>
                <el-form-item label="药品用法">
                  <el-input v-model="formEdit02.DrugsUsage" placeholder="药品用法" ></el-input>
                </el-form-item>
                <el-form-item label="药品用量">
                  <el-input v-model="formEdit02.Dosage" placeholder="药品用量" ></el-input>
                </el-form-item>
                <el-form-item label="使用频次">
                  <el-input v-model="formEdit02.Frequency" placeholder="使用频次" ></el-input>
                </el-form-item>
                <el-form-item label="数量">
                  <el-input v-model="formEdit02.Amount" placeholder="数量" ></el-input>
                </el-form-item>
                <el-form-item>
                  <el-button type="danger" style="width: 100px;" @click="addDrugsDetailed"  >添加
                  </el-button>
                </el-form-item>
              </el-form>
            </el-dialog>
          </el-table-column>
        </el-table>
        <el-row>
          <el-col :span="8" align="left">
            <el-button type="danger" style="margin-top: 10px;width: 100px;" size="mini"
                       @click="closeAddDrugs"  >关闭
            </el-button>
          </el-col>
          <el-col :span="16" align="right">
            <el-pagination
              background
              :page-size="pageSize" :current-page.sync="currentPage01"
              layout="prev, pager, next"
              :total="totalCount" @current-change="currentChange" v-show="this.categories.length>0">
            </el-pagination>
          </el-col>
        </el-row>
      </el-dialog>
	  </el-header>
	  <el-container >
	  <el-aside width="300px" >
	  	<el-card class="box-card" >
        <el-tag type="info" style="width: 100px" size="mini">门诊处方：</el-tag>
		<el-table ref="singleTable" :data="tableData01" style="width: 100%" size="mini" >
      <el-table-column  width="50">
        <template  slot-scope="scope">
          <el-radio :label="scope.$index" v-model="tableData01.index" @change.native="handleSelectionChange(scope.$index,scope.row)">&nbsp;</el-radio>
        </template>
      </el-table-column>
		    <el-table-column property="PrescriptionName" label="名称" >
		    </el-table-column>
		    <el-table-column property="PrescriptionState" label="状态" width="60">
          <template slot-scope="scope">
            {{ scope.row.PrescriptionState|showState }}
          </template>
		    </el-table-column>
		</el-table>
		</el-card>
	  </el-aside>

	  <el-main >
	  	<div >
        <el-tag size="mini">本处方金额合计：</el-tag>
        <el-tag type="warning" size="mini">{{Temp.sumPrice}}元</el-tag>
	  	</div>
	  	<el-table ref="singleTable" :data="tableData03" style="width: 100%" :show-header="true" size="mini" @selection-change="handleSelectionChange01">
	    <el-table-column  type="selection">
	    </el-table-column>
	    <el-table-column property="DrugsName" label="药品名称" >
	    </el-table-column>
	    <el-table-column property="DrugsFormat" label="规格" width="100">
	    </el-table-column>
	    <el-table-column property="DrugsPrice" label="单价" width="80">
	    </el-table-column>
	    <el-table-column property="DrugsUsage" label="用法" width="100">
	    </el-table-column>
	    <el-table-column property="Dosage" label="用量" width="50">
	    </el-table-column>
	    <el-table-column property="Frequency" label="频次" width="50">
	    </el-table-column>
	    <el-table-column property="Amount" label="数量" width="50">
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
              <el-row style="margin-top: 10px;">
                <el-form :inline="true" :model="searchForm01" class="demo-form-inline" size="mini">
                  <el-form-item label="名称：">
                    <el-input v-model="searchForm01.Name" placeholder="输入模板名称"></el-input>
                  </el-form-item>
                  <el-form-item>
                    <el-button type="primary" @click="searchTemplate">查询</el-button>
                  </el-form-item>
                </el-form>
              </el-row>
              <el-row style="margin-top: 10px">
                <el-table ref="singleTable" :data="templateData01" highlight-current-row @current-change="handleCurrentChange01"
                          style="width: 100%" size="mini">
                  <el-table-column property="Name" label="模板名称" >
                  </el-table-column>
                  <el-table-column property="Scope" label="范围" width="100">
                    <template slot-scope="scope">
                      {{ scope.row.Scope|showScope }}
                    </template>
                  </el-table-column>
                </el-table>
              </el-row>
					</el-card>
				  </el-aside>
				  <el-main>
				  	<el-card class="box-card" style="margin-top: -20px;margin-left: -20px;">
					  <div slot="header" class="clearfix">
					    <span style="font-size: small;">模板明细</span>
					    <el-button style="float: right; padding: 3px 0" type="text" :disabled="this.Temp.selectTemp" @click="useSelectTempl">使用该模板</el-button>
					  </div>
              <el-row >
                <el-table :data="templateDrugs" style="width: 100%"  size="mini" >
                  <el-table-column property="DrugsName" label="药品名称" >
                  </el-table-column>
                  <el-table-column property="DrugsFormat" label="规格" >
                  </el-table-column>
                  <el-table-column property="DrugsUnit" label="单位" width="50">
                  </el-table-column>
                  <el-table-column property="DrugsUsage" label="用法" width="50">
                  </el-table-column>
                  <el-table-column property="DrugsDosage" label="用量" width="50">
                  </el-table-column>
                  <el-table-column property="DrugsFrequency" label="频次" width="100">
                  </el-table-column>
                </el-table>
              </el-row>
					</el-card>
				  </el-main>
				</el-container>
		    </el-tab-pane>
		    <el-tab-pane label="常用药品*" name="second">
          <el-tag type="success" closable @close="showConfirm('删除该常用药品')"><span @click="showConfirm('在处方中添加该药品')">5%葡萄糖注射液 250ml*1袋</span></el-tag>
		    	<el-tag type="success" closable @close="showConfirm('删除该常用药品')"><span @click="showConfirm('在处方中添加该药品')">5%葡萄糖注射液 250ml*1袋</span></el-tag>
		    	<el-tag type="success" closable @close="showConfirm('删除该常用药品')"><span @click="showConfirm('在处方中添加该药品')">5%葡萄糖注射液 250ml*1袋</span></el-tag>
		    </el-tab-pane>
		    <el-tab-pane label="建议方案*" name="third">
		    	<el-tag type="warning">暂时不完成。。。</el-tag>
		    	<div style="font-size: small;font-family: '仿宋';">
		    	建议方案是事先根据一些常用的疾病的治疗方案，已经制定完成的处方方案；<br>
		    	当医生开立诊断后选择，系统可以根据诊断结果列出该疾病的病因、注意事项、针对该疾病的用药方案及相应的方案的说明及注意事项；<br>
		    	主要目的是用来辅助医生诊疗。
		    	</div>
		    </el-tab-pane>
		    <el-tab-pane label="历史处方*" name="fourth">
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
					  <el-table :data="tableData03" style="width: 100%" ref="singleTable" >
					    <el-table-column property="mingcheng" label="药品名称" >
					    </el-table-column>
					    <el-table-column property="guige" label="规格" >
					    </el-table-column>
					    <el-table-column property="yongliang" label="用量" width="50">
					    </el-table-column>
					    <el-table-column property="danwei" label="单位" width="50">
					    </el-table-column>
					    <el-table-column property="pinci" label="频次" width="50">
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
import  {showConstants} from '../../../utils/api'
import {postRequest}   from '../../../utils/api'
import {putRequest}    from '../../../utils/api'
import {deleteRequest} from '../../../utils/api'
import {getRequest}    from '../../../utils/api'
export default {
  mounted:function(){
    this.loadSessionPatient();
    this.loadDrugTemplates('','');
    this.loadApply(this.$store.state.Register.ID,'');
  },
  methods:{
    refApply(){
      this.loadSessionPatient();
      this.loadDrugTemplates('','');
      this.loadApply(this.$store.state.Register.ID,'');
      this.selItems={};
    },
    showFormatConstants(row, column, cellValue, index){
      return showConstants(row, column, cellValue, index);
    },

    closeAddDrugs(){
      this.loadPrescriptionDetail(this.selItems.ID);
      this.dialogDrugsVisible = false;
    },

    showConfirm(msg) {
      showMsgConfirm(this, msg);
    },
    showMsg(msg) {
      showMsgTitle(this, msg);
    },
    //选择模板
    handleCurrentChange01:function(val){
      console.log(val.ID);
      this.Temp.selectTemp = false;
      this.showTmplDrugs(val.ID);
      this.selItemTempls = val;
    },
    //使用模板
    useSelectTempl(){
      this.$confirm('确认使用该模板：'+this.selItemTempls.ID+":"+this.selItemTempls.Name, '提示', {
        type: 'warning',
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(()=> {
        let _this = this;
        this.dialogAddForm.TemplID=this.selItemTempls.ID;
        this.dialogAddForm.MedicalID=this.sessionPatient.ID;
        this.dialogAddForm.RegistID=this.sessionPatient.RegistID;
        let url =this.rootUrl +this.rootUrl +"/neudoc/prescription/savePredByTempl";
        postRequest(url,this.dialogAddForm).then(resp=>{
          let json = resp.data ;
          if(resp.status == 200){
            _this.$message({type:json.status,message:json.msg});
            _this.refApply();
          }else{
            _this.$message({type:json.status,message:json.msg});
          }
        });
      }).catch(() => {
        //取消
        //_this.loading = false;
      });

    },

    //增加处方
    addPres(){
      if(this.dialogAddForm.PrescriptionName==null||this.dialogAddForm.PrescriptionName==''){
        this.dialogAddForm.PrescriptionName = '新增处方'+this.Temp.nameNum;
        this.Temp.nameNum++;
      }
      let _this = this;
      this.dialogAddForm.MedicalID=this.sessionPatient.ID;
      this.dialogAddForm.RegistID=this.sessionPatient.RegistID;
      postRequest(this.rootUrl +'/neudoc/prescription/', this.dialogAddForm).then(resp => {
        if (resp.status == 200) {
          let json = resp.data;
          _this.$message({type: json.status, message: json.msg});
          this.loadApply(this.$store.state.Register.ID,'',1);
          this.dialogAddForm.PrescriptionName = '';
        }
      });
      this.dialogAddPres = false;
    },

    //选择处方
    handleSelectionChange(index,val){
      this.selItems = val;
      this.loadPrescriptionDetail(val.ID);

    },
    //选择处方中药品
    handleSelectionChange01(val){
      this.selItemDrugs = val;
    },
    //删除处方
    deleteAll(){
      if(this.selItems==null || this.selItems.PrescriptionName==null || this.selItems.ID==null){
        this.$message({type:'warning',message:'请选择要删除的处方'});
      }else {
        this.$confirm('确认删除 "' + this.selItems.PrescriptionName + '" 处方?', '提示', {
          type: 'warning',
          confirmButtonText: '确定',
          cancelButtonText: '取消'
        }).then(() => {
          let ids = this.selItems.ID+",";
          this.deleteData(ids);
        }).catch(() => {
          this.$message({type: 'info', message: '取消'});
        });
      }
    },
    deleteData(ids){
      let _this = this;
      //删除
      deleteRequest(this.rootUrl +'/neudoc/prescription/' + ids).then(resp=> {
        if (resp.status == 200) {
          let json = resp.data;
          _this.$message({type: json.status,message: json.msg});
          _this.loadApply(this.$store.state.Register.ID,'',1);
        }else{
          _this.$message({type: 'warning', message: '数据加载失败!'});
        }
      });
    },

    //发送 所有 处方
    upToSaved(){
      let selItems = this.tableData01;
      this.$confirm('确认发送所有处方?', '提示', {
        type: 'warning',
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(()=> {
        this.updateData(selItems,2);
      }).catch(() => {
        this.$message({type: 'info',message: '取消'});
      });
    },
    //作废处方
    upToBad() {
      let selItems = [];
      if (this.selItems == null || this.selItems.ID == null) {
        this.$message({type: 'warning', message: '请选择处方'});
      } else {
        selItems.push(this.selItems);
        this.$confirm('确认作废处方： ' + this.selItems.PrescriptionName + '提示', {
          type: 'warning',
          confirmButtonText: '确定',
          cancelButtonText: '取消'
        }).then(() => {
          this.updateData(selItems, 0);
        }).catch(() => {
          this.$message({type: 'info', message: '取消'});
        });
      }
    },
    //修改状态
    updateData(selItems,state){
      let _this = this;
      let ids = '';
      for (let i = 0; i < selItems.length; i++) {
        ids += selItems[i].ID + ",";
      }
      // console.log(ids+":"+state);
      getRequest(this.rootUrl +'/neudoc/prescription/upToSaved?ids='+ids+"&state="+state).then(resp=> {
        if (resp.status == 200) {
          let json = resp.data;
          _this.$message({type: json.status,message: json.msg});
          _this.loadApply(this.$store.state.Register.ID,'',1);
        }else{
          _this.$message({type: 'error', message: '数据加载失败!'});
        }
      });
    },

    //显示模板包含的药品信息
    showTmplDrugs(id){
      let _this = this;
      let url =this.rootUrl +this.rootUrl +"/neupha/templateDetaile/listTemplateDrugs?keywords01="+id;
      getRequest(url).then(resp=>{
        if(resp.status == 200){
          _this.templateDrugs = resp.data ;
        }else{
          _this.templateData01.Name = '没有数据';
        }
      }).catch(resp=>{
        _this.$message({type:'error',message:'数据加载失败！'});
      });
    },
    //加载处方
    loadApply(RegistID,PrescriptionState){
      let _this = this;
      let url =this.rootUrl +this.rootUrl +"/neudoc/prescription/listPres?" +"RegistID=" + RegistID + "&PrescriptionState=" + PrescriptionState  ;
      getRequest(url).then(resp=> {
        _this.loading = false;
        if (resp.status == 200) {
          _this.tableData01 = resp.data.list;
        } else {
          _this.$message({type: 'error', message: '数据加载失败!'});
        }
      });;
    },
    //加载处方中药品明细
    loadPrescriptionDetail(PrescriptionID){
      let _this = this;
      this.Temp.sumPrice = 0;
      let url =this.rootUrl +this.rootUrl +"/neudoc/prescriptionDetailed/listDetail?PrescriptionID=" + PrescriptionID ;
      getRequest(url).then(resp=> {
        _this.loading = false;
        if (resp.status == 200) {
          _this.tableData03 = resp.data.list;
          for(let i=0;i<_this.tableData03.length;i++){
            _this.Temp.sumPrice += _this.tableData03[i].DrugsPrice * _this.tableData03[i].Amount;
            // console.log(i+":"+_this.Temp.sumPrice);
          }
          _this.Temp.sumPrice = parseFloat(_this.Temp.sumPrice).toFixed(2)
        } else {
          _this.$message({type: 'error', message: '数据加载失败!'});
        }
      });;
    },
    searchTemplate(){
      this.loadDrugTemplates('',this.searchForm01.Name);
    },
    //加载模板数据 -- 无分页
    loadDrugTemplates(UserID,TemplateName){
      let _this = this;
      let url =this.rootUrl +this.rootUrl +"/neupha/template/drug/listTemplateByDoc?ID="+UserID+"&Name="+TemplateName;
      getRequest(url).then(resp=>{
        if(resp.status == 200){
          _this.templateData01 = resp.data.list ;
        }else{
          _this.templateData01.Name = '没有数据';
        }
      }).catch(resp=>{
        _this.$message({type:'error',message:'数据加载失败！'});
      });
    },
    //处方中药品信息
    showDrugsList(){
      // console.log(this.selItems);
      if(this.selItems==null || this.selItems.ID==null ){
        this.$message({type: 'error', message: '请选择要添加药品的处方!'});
      }else {
        if(this.selItems.PrescriptionState!=1){
          this.$message({type:'warning',message:"已开立的处方，不能添加药品"});
        }else{
          this.loadDrugs(1, this.pageSize,this.keywords01);
          this.dialogDrugsVisible=true;
        }
      }
    },
    //加载药品数据 -- 有分页
    loadDrugs(pageNumber, pageSize ,keywords01){
      let _this = this;
      let url =this.rootUrl +this.rootUrl +"/neupha/drug/listPage?pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&keywords01=" + keywords01 ;
      getRequest(url).then(resp=> {
        _this.loading = false;
        if (resp.status == 200) {
          _this.categories = resp.data.list;
          _this.totalCount = resp.data.totalCount;
          _this.currentPage01 = pageNumber ;
        } else {
          _this.$message({type: 'error', message: '数据加载失败!'});
        }
      });
    },
    //翻页
    currentChange(currentPage){
      this.currentPage01 = currentPage;
      this.loading = true;
      this.loadDrugs(currentPage, this.pageSize,this.keywords01);
    },
    //搜索
    searchData(){
      if(this.keywords01==null || this.keywords01==''){
        this.loadDrugs(1, this.pageSize,'');
      }else{
        this.loadDrugs(1, this.pageSize,this.keywords01);
      }
    },
    //打开添加处方中药品信息的“对话框”
    showInnerDialog(index,row){
      this.innerVisible=true;
      this.formEdit02 = row;
      this.formEdit02.PrescriptionID = this.selItems.ID;
      this.formEdit02.DrugsID = row.ID;
    },
    //添加处方中药品信息
    addDrugsDetailed(){
      let _this = this;
      if(this.tableData03.length>=5){
        this.$message({type:'warm',message:'一个处方只能开立 5 种药品，请新建处方'});
      }else{
        postRequest(this.rootUrl +'/neudoc/prescriptionDetailed/',this.formEdit02).then(resp=> {
          if(resp.status == 200){
            let json = resp.data;
            _this.$message({type:json.status,message:json.msg});
            _this.formEdit02 = {};
            _this.loadPrescriptionDetail(this.selItems.ID);
            this.innerVisible=false;
          }else{
            _this.$message({type:'warm',message:'添加失败！'});
          }
        });
      }
    },
    //删除处方中药品信息
    deleteDrugsDetailed(){
      let _this = this;
      if(this.selItems.PrescriptionState!=1){
        this.$message({type:'warning',message:"已开立的处方，不能删除药品"});
      }else{
        this.$confirm('确认删除这 ' +  this.selItemDrugs.length + ' 条数据?', '提示', {
          type: 'warning',
          confirmButtonText: '确定',
          cancelButtonText: '取消'
        }).then(()=> {
          let selItemDrugs = _this.selItemDrugs;
          let ids = '';
          for (let i = 0; i < selItemDrugs.length; i++) {
            ids += selItemDrugs[i].ID + ",";
          }
          // alert(ids);
          this.deleteDrugsByIds(ids);
          this.$message({type:'success',message:"删除"+ this.selItemDrugs.length + ' 条数据成功！'});
        }).catch(() => {
          //取消
          //_this.loading = false;
        });
      }
    },
    deleteDrugsByIds(ids){
      let _this = this;
      //删除
      deleteRequest(this.rootUrl +'/neudoc/prescriptionDetailed/' + ids).then(resp=> {
        let json = resp.data;
        _this.$message({type: json.status,message: json.msg});
        this.loadPrescriptionDetail(this.selItems.ID);
      }, resp=> {
        _this.$message({type: 'error',message: '删除失败!'});
      });
    },

    //加载session中患者病历信息
    loadSessionPatient() {
      let patstr = sessionStorage.getItem('medicalRecord');
      if (patstr != null && patstr.length > 0 && patstr != '{}') {
        this.sessionPatient = JSON.parse(patstr);
        return true;
      } else {
        this.sessionPatient={ID:'',CaseNumber:'',RegistID:'',Readme:'',Present:'',PresentTreat:'',History:'',Allergy:'',
          Physique:'',Proposal:'',Careful:'',CheckResult:'',Diagnosis:'',Handling:'',CaseState:''};
        this.$message({type: 'info', message: '请选择患者'});
        return false;
      }
    },
  },
  data() {
  	return {
      dialogAddPres:false,
      dialogDrugsVisible:false,
      innerVisible:false,
      currentPage01:1,
      pageSize:10,
      totalCount:0,
      keywords01: '',
      dialogAddForm:{MedicalID:'',PrescriptionName:''},
      sessionPatient:{ID:'',CaseNumber:'',RegistID:'',Readme:'',Present:'',PresentTreat:'',History:'',Allergy:'',
        Physique:'',Proposal:'',Careful:'',CheckResult:'',Diagnosis:'',Handling:'',CaseState:''},
      Temp:{nameNum:'1',sumPrice:'',selectTemp:true},
      selItems:{},
      selItemTempls:{ID:''},
      selItemDrugs:[],
      //处方
      tableData01:[{PrescriptionName:'新增处方1',PrescriptionState:'已发送'},{PrescriptionName:'新增处方2',PrescriptionState:'暂存'}],
      //处方中的药品
      tableData03: [{DrugsCode:'',DrugsName:'',DrugsFormat:'',DrugsUnit:'',Manufacturer:'',DrugsPrice:'',
        DrugsUsage:'',Dosage:'',Frequency:'',Amount:''}],
      activeName: 'first',




      //测试数据
      searchForm01:{
        Name:'',Scope:''
      },
      templateData01: [],
      templateDrugs:[{ID:'',DrugstempId:'',DrugsId:'',DrugsName:'',DrugsFormat:'',DrugsUnit:'',DrugsUsage:'',DrugsDosage:'',DrugsFrequency:''}],
      categories:[],
      labelPosition:'',
      formEdit02:{},
      tableData07: [{datetime:'2018-10-11 10:02:23',name01: '病毒性感冒',name02:'新建处方03'},
        {datetime:'2018-10-11 10:00:03',name01: '病毒性感冒',name02:'新建处方02'}],

  	}
  },
  filters:{
    showState:function(state){
      if(state=='1'){
        return '暂存';
      }else if(state=='2'){
        return '已开立';
      }else if(state=='3'){
        return '已交费';
      }else if(state=='4'){
        return '已取药';
      }else if(state=='5'){
        return '已退药';
      }else if(state=='6'){
        return '已退费';
      }else{
        return '已作废';
      }
    },
    showScope:function(scope){
      if(scope==1){
        return '个人';
      }else if(scope==2){
        return '科室';
      }else{
        return '全院';
      }
    },
  },
}
</script>

<style>
</style>
