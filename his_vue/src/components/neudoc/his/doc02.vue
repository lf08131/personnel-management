<template>
	<div class="container" >
    <!-- 2.检查申请 -->
	<el-container direction="horizontal">

    <!-- 编辑弹框---start -->
    <el-dialog title="新增医技" :visible.sync="dialogFormVisible" width="80%">
      <el-row>
        <el-col :span="18">
          <div class="grid-content bg-purple">
            <el-input placeholder="请输入医技助记码" size="mini" v-model="keywords01"></el-input>
          </div>
        </el-col>
        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-button type="primary" size="mini" style="margin-left: 10px" icon="el-icon-view" @click="searchData">查询</el-button>
          </div>
        </el-col>
      </el-row>
      <el-table stripe ref="multipleTable" size="mini" :data="categories" tooltip-effect="dark" style="width: 100%">
        <el-table-column label="项目编码" prop="ItemCode" width="140" align="left" ></el-table-column>
        <el-table-column label="项目名称" prop="ItemName" align="left"></el-table-column>
        <el-table-column label="项目规格" prop="Format" width="80" align="left"></el-table-column>
        <el-table-column label="项目单价" prop="Price" width="80" align="left"></el-table-column>
        <el-table-column label="拼音助记码" prop="MnemonicCode" width="180" align="left"></el-table-column>
        <el-table-column label="操作" align="center" width="80">
          <template slot-scope="scope">
            <el-button type="primary"  size="mini" @click="showInnerDialog(scope.$index, scope.row)">选择
            </el-button>
          </template>
          <el-dialog width="30%" title="添加详情" :visible.sync="innerVisible" append-to-body center="center">
            <el-form label-width="100px"  :model="formEdit02" class="demo-form-inline" size="mini">
              <el-form-item label="申请名称">
                <el-input v-model="formEdit02.Name" placeholder="申请名称" ></el-input>
              </el-form-item>
              <el-form-item label="项目名称">
                <el-tag type="info">{{ Temp.TempItemName }}</el-tag>
              </el-form-item>
              <el-form-item label="目的要求">
                <el-input v-model="formEdit02.Objective" placeholder="检查部位" ></el-input>
              </el-form-item>
              <el-form-item label="检查部位">
                <el-input v-model="formEdit02.Position" placeholder="检查部位" ></el-input>
              </el-form-item>
              <el-form-item label="是否加急">
                <el-switch v-model="formEdit02.IsUrgent" active-text="是" inactive-text="否"></el-switch>
              </el-form-item>
              <!--
              <el-form-item label="数量">
                <el-input-number v-model="formEdit02.Num" @change="applyDialog01" :min="1" :max="10"></el-input-number>
              </el-form-item>
              -->
              <el-form-item>
                <el-button type="primary" style="width: 100px;" @click="addCheckDetailed"  >添加
                </el-button>
              </el-form-item>
            </el-form>
          </el-dialog>
        </el-table-column>
      </el-table>
      <el-row>
        <el-col :span="24" align="right">
          <el-pagination
            background
            :page-size="pageSize" :current-page.sync="currentPage01"
            layout="prev, pager, next"
            :total="totalCount" @current-change="currentChange" v-show="this.categories.length>0">
          </el-pagination>
        </el-col>
      </el-row>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="dialogFormVisible=false" size="mini">关闭</el-button>
      </div>
    </el-dialog>
    <!-- 编辑弹框---end -->


    <!-- 页面正文 -->
		<el-aside  style="width: 700px;height: 500px;">
		  	<el-row style="background-color: #EAF1F5">
		  		<el-col :span="6" style="margin-top: 4px;">

		  		</el-col>
		  		<el-col :span="3"><el-button type="text" size="mini" class="el-icon-circle-plus" @click="showFme">新增项目</el-button></el-col>
          <el-col :span="3"><el-button type="text" size="mini" class="el-icon-remove" :disabled="this.selItems.length==0" @click="deleteAll">删除项目</el-button></el-col>
          <el-col :span="3"><el-button type="text" size="mini" class="el-icon-success" :disabled="this.selItems.length==0" @click="upToSaved">开立项目</el-button></el-col>
          <el-col :span="3"><el-button type="text" size="mini" class="el-icon-delete" :disabled="this.selItems.length==0" @click="upToBad">作废项目</el-button></el-col>
          <el-col :span="3"><el-button type="text" size="mini" class="el-icon-circle-plus-outline" :disabled="this.selItems.length==0" >存为组套*</el-button></el-col>
          <el-col :span="3"><el-button type="text" size="small" class="el-icon-circle-plus-outline" @click="refApply">刷新</el-button></el-col>
        </el-row>
      <el-row>
        <el-col>
          <el-tag size="mini">本项目金额合计：</el-tag>
          <el-tag type="warning" size="mini">{{sumPrice}}元</el-tag>
        </el-col>
      </el-row>
		  	<el-row>
		  		<el-col :span="22" style="margin-top: 4px;">
		  		<el-table ref="singleTable" :data="tableData02"
				    style="width: 100%;margin: 0px;padding: 0px;" :show-header="true" size="mini" @selection-change="handleSelectionChange">
				    <el-table-column  type="selection">
				    </el-table-column>
				    <el-table-column property="Name" label="申请名称" width="100">
				    </el-table-column>
				    <el-table-column property="ItemName" label="项目名称" >
				    </el-table-column>
				    <el-table-column property="DeptName" label="执行科室" width="100">
				    </el-table-column>
            <el-table-column property="State" label="执行状态" width="100">
              <template slot-scope="scope">
                {{ scope.row.State|showState }}
              </template>
            </el-table-column>
				    <el-table-column property="Price" label="单价" width="80">
				    </el-table-column>
				    <el-table-column property="Result" label="检查结果" width="80" >
				      <template slot-scope="scope">
                <el-popover   placement="right"
                  width="400" :content="scope.row.Result" trigger="click">
                  <el-button slot="reference" type="text" size="mini">查看详细</el-button>
                </el-popover>
				      </template>
				    </el-table-column>
				</el-table>
				</el-col>
		  	</el-row>
		</el-aside>
  		<el-main style="margin-top: -20px;">
  			<el-tabs type="card" >
		    <el-tab-pane label="常用模板" >
			    <el-table :data="tableData04" style="width: 100%" ref="singleTable" size="mini">
			      <el-table-column prop="Name" label="名称">
			      </el-table-column>
			      <el-table-column fixed="right" label="操作" width="120">
				      <template slot-scope="scope">
				      	<el-button @click.native.prevent="addTmplChecks(scope.row)" type="text" size="small">
				          	使用
				        </el-button>
				        <el-button @click.native.prevent="showTmplChecks(scope.row)" type="text" size="small">
				          	详细
				        </el-button>
				      </template>
			      </el-table-column>
			    </el-table>
		    </el-tab-pane>
			</el-tabs>
        <el-dialog title="模板详细" :visible.sync="applyDialogShow" width="40%">
          <el-table stripe ref="multipleTable" size="mini"
                    :data="categories02" tooltip-effect="dark" style="width: 100%">
            <el-table-column label="项目编码" prop="ItemCode" width="140" align="left" ></el-table-column>
            <el-table-column label="项目名称" prop="ItemName" align="left"></el-table-column>
            <el-table-column label="项目规格" prop="Format" width="80" align="left"></el-table-column>
            <el-table-column label="检查部位" prop="Position" width="80" align="left"></el-table-column>
          </el-table>
          <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="applyDialogShow=false" size="mini">关闭</el-button>
          </div>
        </el-dialog>
  		</el-main>
	</el-container>

   </div>
</template>

<script>
import {showMsgTitle} from '../../../utils/api'
import  {showMsgConfirm} from '../../../utils/api'
import {postRequest}   from '../../../utils/api'
import {putRequest}    from '../../../utils/api'
import {deleteRequest} from '../../../utils/api'
import {getRequest}    from '../../../utils/api'
export default {
  mounted:function(){
    this.loadApply(this.$store.state.Register.ID,'',1);
    this.loadTemplateByDoc(this.$store.state.Register.UserID,1,'');
    this.loadSessionPatient();
  },
  methods: {
    refApply(){
      this.loadApply(this.$store.state.Register.ID,'',1);
      this.loadTemplateByDoc(this.$store.state.Register.UserID,1,'');
      this.loadSessionPatient();
    },
    showConfirm(msg) {
      showMsgConfirm(this, msg);
    },
    showMsg(msg) {
      showMsgTitle(this, msg);
    },

    //医技操作
    showFme(){
      if(this.loadSessionPatient()){
        this.dialogFormVisible=true;
        this.loadFmeDatas(1,10,'',1);
      }else{
        this.$message({type:'warning',message:'请选择已经提交病历的患者'});
        return false;
      }
    },
    searchData(){
//todo
    },
    //翻页
    currentChange(currentPage){
      this.currentPage01 = currentPage;
      this.loading = true;
      this.loadFmeDatas(currentPage, this.pageSize,this.keywords01,1);
    },
    //加载医技数据
    loadFmeDatas(pageNumber, pageSize ,MnemonicCode,RecordType){
      let _this = this;
      let url =this.rootUrl +this.rootUrl +"/neuski/fme/listPageByRecordtype?"
        +"pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&MnemonicCode=" + MnemonicCode+ "&RecordType=" + RecordType ;
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

    //打开添加模板中医技信息的“对话框”
    showInnerDialog(index,row){
      this.innerVisible=true;
      this.templateToApply(row);
    },
    templateToApply(row){
      this.formEdit02 = row;
      this.formEdit02.CreationTime = new Date();
      this.Temp.TempItemName = row.ItemName;

      this.formEdit02.MedicalID = this.sessionPatient.ID;
      this.formEdit02.RegistID = this.sessionPatient.RegistID;
      this.formEdit02.ItemID = row.ID;
      this.formEdit02.DoctorID = 1; //默认开立医生的ID为1，需要根据登录医生获取 TODO
      this.formEdit02.CheckOperID = 2; //默认检查人员的ID为2，需要根据排班和工作量获取 TODO
      this.formEdit02.ResultOperID = 2; //默认结果录入人员的ID为2，需要根据获取 TODO
    },
    //
    applyDialog01(val){
      this.formEdit02.Num = val;
    },
    //添加检查申请
    addCheckDetailed(){
      let _this = this;
      this.formEdit02.State = '1';
      this.formEdit02.RecordType = '1';
      postRequest(this.rootUrl +'/neudoc/apply/check', this.formEdit02).then(resp => {
        if (resp.status == 200) {
          let json = resp.data;
          _this.$message({type: json.status, message: json.msg});
          this.loadApply(this.$store.state.Register.ID,'',1);
        }
      });
      // console.log(this.formEdit02);
      this.innerVisible = false;
    },
    //复选检查项目
    handleSelectionChange(val){
      this.selItems = val;
      this.sumPrice = 0;
      for(let i=0;i<val.length;i++){
        this.sumPrice += val[i].Price;
      }
    },
    //删除检查项目
    deleteAll(){
      let tableData02 = this.tableData02;
      let selItems = this.selItems;

      for(let j=0;j<selItems.length;j++){
        if(selItems[j].State != 1){
          this.$message({type:'warning',message:'只能删除暂存状态的检查单，请重新选择'});
          return false;
        }
      }

      this.$confirm('确认删除这 ' +  this.selItems.length + ' 条数据?', '提示', {
        type: 'warning',
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(()=> {
        // let selItems = this.selItems;
        let ids = '';
        for (let i = 0; i < selItems.length; i++) {
          ids += selItems[i].ID + ",";
        }
        this.deleteData(ids);

      }).catch(() => {
        this.$message({type: 'info',message: '取消'});
      });
    },
    deleteData(ids){
      let _this = this;
      this.loading = true;
      //删除
      deleteRequest(this.rootUrl +'/neudoc/apply/check/' + ids).then(resp=> {
        if (resp.status == 200) {
          let json = resp.data;
          _this.$message({type: json.status,message: json.msg});
          _this.loadApply(this.$store.state.Register.ID,'',1);
        }else{
          _this.$message({type: 'error', message: '数据加载失败!'});
        }
      });
    },
    //开立项目
    upToSaved(){
      let selItems = this.selItems;
      this.$confirm('确认开立这 ' +  this.selItems.length + ' 条数据?', '提示', {
        type: 'warning',
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(()=> {
        this.updateData(selItems,2);
      }).catch(() => {
        this.$message({type: 'info',message: '取消'});
      });
    },
    //作废项目
    upToBad(){
      let selItems = this.selItems;
      for(let j=0;j<selItems.length;j++){
        if(selItems[j].State != 2){
          this.$message({type:'warning',message:'只能作废已开立状态的检查单，请重新选择'});
          return false;
        }
      }
      this.$confirm('确认作废这 ' +  this.selItems.length + ' 条数据?', '提示', {
        type: 'warning',
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(()=> {
        this.updateData(selItems,0);
      }).catch(() => {
        this.$message({type: 'info',message: '取消'});
      });
    },
    //修改状态
    updateData(selItems,state){
      let _this = this;
      let ids = '';
      for (let i = 0; i < selItems.length; i++) {
        ids += selItems[i].ID + ",";
      }
      getRequest(this.rootUrl +'/neudoc/apply/check?ids='+ids+"&state="+state).then(resp=> {
        if (resp.status == 200) {
          let json = resp.data;
          _this.$message({type: json.status,message: json.msg});
          _this.loadApply(this.$store.state.Register.ID,'',1);
        }else{
          _this.$message({type: 'error', message: '数据加载失败!'});
        }
      });
    },
    //加载申请
    loadApply(RegistID,State,RecordType){
      let _this = this;
      let url =this.rootUrl +this.rootUrl +"/neudoc/apply/listCheck?" +"RegistID=" + RegistID + "&State=" + State + "&RecordType=" + RecordType ;
      getRequest(url).then(resp=> {
        _this.loading = false;
        if (resp.status == 200) {
          _this.tableData02 = resp.data.list;
        } else {
          _this.$message({type: 'error', message: '数据加载失败!'});
        }
      });;
    },
    //加载模板
    loadTemplateByDoc(UserID, RecordType, Name){
      let _this = this;
      let url =this.rootUrl +this.rootUrl +"/neupha/template/check/listTemplateByDoc?" +"UserID=" + UserID + "&RecordType=" + RecordType + "&Name=" + Name ;
      getRequest(url).then(resp=> {
        _this.loading = false;
        if (resp.status == 200) {
          _this.tableData04 = resp.data.list;
        } else {
          _this.$message({type: 'error', message: '数据加载失败!'});
        }
      });
    },
    //加载患者病历
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

    //使用模板添加检查申请
    addTmplChecks(CheckTemp){
      let _this = this;
      this.$confirm('添加模板中的检查申请,是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        getRequest(this.rootUrl +'/neupha/templateDetaile/listTemplateChecks?keywords01='+CheckTemp.ID).then(resp=> {
          if(resp.status == 200){
            this.categories02 = resp.data.list;
            if(this.categories02!=null){
              for(let i=0;i<this.categories02.length;i++){
                this.templateToApply(this.categories02[i]);
                this.formEdit02.Name = '模板：'+CheckTemp.Name;
                this.formEdit02.ItemID = this.categories02[i].CheckProjID;
                this.formEdit02.Num = 1;
                this.formEdit02.State = '1';
                this.formEdit02.RecordType = '1';
                postRequest(this.rootUrl +'/neudoc/apply/check', this.formEdit02).then(resp => {
                  if (resp.status == 200) {
                    let json = resp.data;
                    _this.$message({type: json.status, message: json.msg});
                    this.loadApply(this.$store.state.Register.ID,'',1);
                  }else{
                    this.$message({
                      type: 'warning',
                      message: '添加失败!'
                    });
                  }
                });
              }
            }
          }else{
            _this.$message({type:'warm',message:'后台数据错误！'});
          }
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消'
        });
      });
    },
    //显示模板详情
    showTmplChecks(CheckTemp){
      console.log(CheckTemp.ID);
      this.applyDialogShow = true;
      this.listTmplChecks(CheckTemp.ID)
    },
    //查询模板详情
    listTmplChecks(CheckTempID){
      let _this = this;
      getRequest(this.rootUrl +'/neupha/templateDetaile/listTemplateChecks?keywords01='+CheckTempID).then(resp=> {
        if(resp.status == 200){
          this.categories02 = resp.data.list;
        }else{
          _this.$message({type:'warm',message:'后台数据错误！'});
        }
      });
    },
  },
  data() {
  	return {
      loading : false,
      dialogTableVisible: false,
      dialogFormVisible:false,
      innerVisible:false,
      applyDialogShow:false,
      categories:[],
      categories02:[],
      pageSize:10,
      totalCount:0,
      currentPage01:1,
      keywords01: '',
      formEdit02:{ID:'',MedicalID:'',RegistID:'',ItemID:'',Name:'',Objective:'',Position:'',IsUrgent:false,Num:1,CreationTime:new Date(),
        DoctorID:'',CheckOperID:'',ResultOperID:'',CheckTime:new Date(),Result:'',ResultTime:new Date(),State:'1',RecordType:'1'},
      tableData02:[],
      tableData04:[],
      selItems:[],
      //病历信息 -- sessionStorage中
      sessionPatient:{ID:'',CaseNumber:'',RegistID:'',Readme:'',Present:'',PresentTreat:'',History:'',Allergy:'',
        Physique:'',Proposal:'',Careful:'',CheckResult:'',Diagnosis:'',Handling:'',CaseState:''},
      Temp:{TempItemName:''},
      sumPrice:0,

      formEdit03:{ID:'',Name:'',Scope:'',UserID:'1',CreationTime:new Date(),RecordType:''},
      dialogForm01:{ID:'',Name:'',Scope:'1',UserID:'1',CreationTime:'2019-03-08 10:18',RecordType:'1'},
      searchForm01:{Name:'',Scope:'',RecordType:''},
      templateData01: [],
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
        return '已登记';
      }else if(state=='5'){
        return '执行完';
      }else if(state=='6'){
        return '已退费';
      }else{
        return '已作废';
      }
    },

  },
}
</script>

<style>
</style>
