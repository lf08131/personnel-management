<template>
  <!-- 医技模板管理 -->
  <el-container >
    <el-aside style="width:40%;background:#fff">
      <el-row style="background-color: #EAF1F5">
        <el-col :span="18">
          <el-tag size="small">医技模板：</el-tag>
        </el-col>
        <el-col :span="5" style="text-align: center">
          <el-button type="text" size="mini" class="el-icon-circle-plus"  @click="dialogTableVisible = true">新建模板</el-button>
        </el-col>
        <el-dialog title="创建模板" :visible.sync="dialogTableVisible" width="30%">
          <el-form ref="form01" :model="dialogForm01" label-width="80px" size="mini">
            <el-form-item label="模板范围">
              <el-select  placeholder="请选择模板范围" v-model="dialogForm01.Scope">
                <el-option label="全院" value="3"></el-option>
                <el-option label="科室" value="2"></el-option>
                <el-option label="个人" value="1"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="模板名称">
              <el-input placeholder="输入模板名称" v-model="dialogForm01.Name"></el-input>
            </el-form-item>
            <el-form-item label="模板类型">
              <el-select  placeholder="请选择模板类型" v-model="dialogForm01.RecordType">
                <el-option label="处置" value="3"></el-option>
                <el-option label="检验" value="2"></el-option>
                <el-option label="检查" value="1"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button @click="dialogTableVisible=false" type="warning">取消</el-button>
              <el-button type="primary" @click="addNewData">创建</el-button>
            </el-form-item>
          </el-form>
        </el-dialog>
      </el-row>

       <el-form :inline="true" :model="searchForm01" class="demo-form-inline" size="mini">
       <el-row style="margin-top: 10px;">
          <el-form-item label="名称：">
            <el-input v-model="searchForm01.Name" placeholder="输入模板名称"></el-input>
          </el-form-item>
          <el-form-item label="  范围：">
            <el-select v-model="searchForm01.Scope" placeholder="范围" style="width: 100px">
              <el-option label="所有" value=""></el-option>
              <el-option label="全院" value="3"></el-option>
              <el-option label="科室" value="2"></el-option>
              <el-option label="个人" value="1"></el-option>
            </el-select>
          </el-form-item>
      </el-row>
      <el-row>
        <el-form-item label="记录类型：">
          <el-select v-model="searchForm01.RecordType" placeholder="类型" style="width: 100px">
            <el-option label="所有" value=""></el-option>
            <el-option label="处置" value="3"></el-option>
            <el-option label="检验" value="2"></el-option>
            <el-option label="检查" value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item >
          <el-button type="primary" @click="searchTemplate">查询</el-button>
        </el-form-item>
      </el-row>
      </el-form>

      <el-row style="margin-top: 10px">
        <el-table ref="singleTable" :data="templateData01" highlight-current-row @current-change="handleCurrentChange01"
                  style="width: 100%" size="mini">
          <el-table-column property="Name" label="模板名称" >
          </el-table-column>
          <el-table-column property="CreationTime" label="创建时间" width="130">
            <template slot-scope="scope">
              {{ scope.row.CreationTime|formatDateTime }}
            </template>
          </el-table-column>
          <el-table-column property="Scope" label="范围" width="100">
            <template slot-scope="scope">
              {{ scope.row.Scope|showScope }}
            </template>
          </el-table-column>
          <el-table-column property="RecordType" label="类型" width="100">
            <template slot-scope="scope">
              {{ scope.row.RecordType|showType }}
            </template>
          </el-table-column>
        </el-table>
      </el-row>
    </el-aside>
    <el-main style="width:60%;height: 1200px;">
      <el-row style="background-color: #EAF1F5">
        <el-col :span="14">
          <el-tag type="info" >操作：</el-tag>
        </el-col>
        <el-col :span="5" style="text-align: right">
          <el-button type="text" size="small" class="el-icon-check" @click="updataTemplate">修改模板</el-button>
        </el-col>
        <el-col :span="5" style="text-align: right">
          <el-button type="text" size="small" class="el-icon-delete" @click="deleteTemplate">删除模板</el-button>
        </el-col>
      </el-row>
      <el-row style="margin-top: 10px">
        <el-col>
          <el-tag size="mini" style="width: 100%;text-align: center">模板明细：</el-tag>
        </el-col>
      </el-row>
      <el-form :model="formEdit03" label-width="200px" style="margin-top: 10px">
        <el-form-item label="模板名称">
          <el-input  v-model="formEdit03.Name"></el-input>
        </el-form-item>
        <el-form-item label="创建时间">
          <el-tag type="info">{{ formEdit03.CreationTime | formatDateTime}}</el-tag>
        </el-form-item>
        <el-form-item label="模板范围">
          <el-select v-model="formEdit03.Scope"  placeholder="范围">
            <el-option label="全院" value="3">全院</el-option>
            <el-option label="科室" value="2">科室</el-option>
            <el-option label="个人" value="1">个人</el-option>
          </el-select>
        </el-form-item>
          <el-form-item label="记录类型">
            <el-select v-model="formEdit03.RecordType"  placeholder="类型"  >
              <el-option label="处置" value="3"></el-option>
              <el-option label="检验" value="2"></el-option>
              <el-option label="检查" value="1"></el-option>
            </el-select>
        </el-form-item>
      </el-form>
      <el-row>
        <el-button @click="showFme" type="primary">增加检验项目</el-button>
      </el-row>
      <!-- 编辑弹框---start -->
      <el-dialog title="新增医技" :visible.sync="dialogFormVisible" width="80%">
        <el-row>
          <el-col :span="18">
            <div class="grid-content bg-purple">
              <el-input placeholder="请输入医技助记码" size="mini" v-model="keywords01">
              </el-input>
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
              <el-form :label-position="labelPosition" label-width="100px"  :model="formEdit02" class="demo-form-inline" size="mini">
                <el-form-item label="项目名称">
                  <el-input v-model="formEdit02.ItemName" placeholder="项目名称" readonly="readonly" ></el-input>
                </el-form-item>
                <el-form-item label="检查部位">
                  <el-input v-model="formEdit02.Position" placeholder="检查部位" ></el-input>
                </el-form-item>
                <el-form-item>
                  <el-button type="danger" style="width: 100px;" @click="addCheckDetailed"  >添加
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

      <el-table stripe ref="multipleTable" size="mini"
        :data="categories02" tooltip-effect="dark" style="width: 100%">
        <el-table-column label="项目编码" prop="ItemCode" width="140" align="left" ></el-table-column>
        <el-table-column label="项目名称" prop="ItemName" align="left"></el-table-column>
        <el-table-column label="项目规格" prop="Format" width="80" align="left"></el-table-column>
        <el-table-column label="检查部位" prop="Position" width="80" align="left"></el-table-column>
        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <el-button size="mini"  type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-main>

  </el-container>
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
      this.loadDatas('','','');
    },
    methods:{
      handleCurrentChange01:function(val){
        this.formEdit03.ID=val.ID;
        this.formEdit03.Name=val.Name;
        this.formEdit03.CreationTime = val.CreationTime ;
        this.formEdit03.Scope = val.Scope+'';
        this.formEdit03.RecordType = val.RecordType+'';
        this.showTmplChecks(val.ID);
      },
      showTmplChecks(CheckTempID){
        let _this = this;
        getRequest(this.rootUrl +'/neupha/templateDetaile/listTemplateChecks?keywords01='+CheckTempID).then(resp=> {
          if(resp.status == 200){
            this.categories02 = resp.data.list;
          }else{
            _this.$message({type:'warm',message:'后台数据错误！'});
          }
        });
      },
      //打开添加模板中医技信息的“对话框”
      showInnerDialog(index,row){
        this.innerVisible=true;
        this.formEdit02 = row;
        this.formEdit02.CheckProjID = row.ID;
        this.formEdit02.CheckTempID = this.formEdit03.ID;
      },
      //增加模板中医技项目
      addCheckDetailed(){
        let _this = this;
        postRequest(this.rootUrl +'/neupha/templateDetaile/check',this.formEdit02).then(resp=> {
          if(resp.status == 200){
            let json = resp.data;
            _this.$message({type:json.status,message:json.msg});
            _this.formEdit02 = {};
            this.innerVisible=false;
            _this.showTmplChecks(_this.formEdit03.ID)
          }else{
            _this.$message({type:'warm',message:'添加失败！'});
          }
        });
      },
      //删除模板中医技项目
      handleDelete(index,row){
        let _this = this;
        this.$confirm('删除该项目 ,是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          deleteRequest(this.rootUrl +'/neupha/templateDetaile/checks/'+row.ID).then(resp => {
            if (resp.status == 200) {
              let json = resp.data;
              _this.$message({type: json.status, message: json.msg});
              _this.showTmplChecks(_this.formEdit03.ID);
            }
          });
        }).catch(() => {
          _this.$message({
            type: 'info',
            message: '已取消'
          });
        });
      },
      //修改模板信息
      updataTemplate(){
        let _this = this;
        this.$confirm('此操作将修改模板信息 ,是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          putRequest(this.rootUrl +'/neupha/template/check', this.formEdit03).then(resp => {
            if (resp.status == 200) {
              let json = resp.data;
              _this.$message({type: json.status, message: json.msg});
              _this.loadDatas('', '','');
            }
          });
        }).catch(() => {
          _this.$message({
            type: 'info',
            message: '已取消'
          });
        });
      },
      //删除模板信息
      deleteTemplate(){
        let _this = this;
        this.$confirm('此操作将删除模板信息 ,是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          deleteRequest(this.rootUrl +'/neupha/template/check/'+this.formEdit03.ID).then(resp => {
            if (resp.status == 200) {
              let json = resp.data;
              _this.$message({type: json.status, message: json.msg});
              _this.formEdit03 = {CreationTime:new Date()};
              _this.categories02=[];
              _this.loadDatas('','','');
            }
          });
        }).catch(() => {
          _this.$message({
            type: 'info',
            message: '已取消'
          });
        });
      },
      searchTemplate(){
        this.loadDatas(this.searchForm01.Name,this.searchForm01.Scope,this.searchForm01.RecordType);
      },
      addNewData(){
        let _this = this;
        postRequest(this.rootUrl +'/neupha/template/check', this.dialogForm01).then(resp => {
          if (resp.status == 200) {
            let json = resp.data;
            _this.$message({type: json.status, message: json.msg});
            this.dialogForm01.Name='';
            _this.loadDatas('', '','');
          }
        });
        _this.dialogTableVisible = false;
      },
      //加载模板数据 -- 无分页
      loadDatas(keywords01,keywords02,keywords03){
        let _this = this;
        let url =this.rootUrl +this.rootUrl +"/neupha/template/listCheckTemplate?keywords01="+keywords01+"&keywords02="+keywords02+"&keywords03="+keywords03;
        getRequest(url).then(resp=>{
          if(resp.status == 200){
            _this.templateData01 = resp.data ;
          }else{
            _this.templateData01.Name = '没有数据';
          }
        }).catch(resp=>{
          _this.$message({type:'error',message:'数据加载失败！'});
        });
      },

      searchData(){
        this.loadFmeDatas(1,this.pageSize,this.keywords01)
      },
      showFme(){
        this.dialogFormVisible=true;
        this.loadFmeDatas(1,10,'');
      },
      //翻页
      currentChange(currentPage){
        this.currentPage01 = currentPage;
        this.loading = true;
        this.loadFmeDatas(currentPage, this.pageSize,this.keywords01);
      },
      //加载医技数据
      loadFmeDatas(pageNumber, pageSize ,keywords01){
        let _this = this;
        let url =this.rootUrl +this.rootUrl +"/neuski/fme/listPage?pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&keywords01=" + keywords01 ;
        getRequest(url).then(resp=> {
          _this.loading = false;
          if (resp.status == 200) {
            _this.categories = resp.data.list;
            _this.totalCount = resp.data.totalCount;
            _this.currentPage01 = pageNumber ;
          } else {
            _this.$message({type: 'error', message: '数据加载失败!'});
          }
        }, resp=> {
          _this.loading = false;
          if (resp.response.status == 403) {
            _this.$message({type: 'error', message: resp.response.data});
          } else {
            _this.$message({type: 'error', message: '数据加载失败!'});
          }
        }).catch(resp=> {
          //压根没见到服务器
          _this.loading = false;
          _this.$message({type: 'error', message: '数据加载失败!'});
        });
      },
    },
    data() {
      return {
        dialogTableVisible: false,
        dialogFormVisible:false,
        innerVisible:false,
        categories:[],
        categories02:[],
        pageSize:10,
        totalCount:0,
        currentPage01:1,
        keywords01: '',
        formEdit02:{CheckProjID:'',CheckTempID:'',Position:''},
        formEdit03:{ID:'',Name:'',Scope:'',UserID:'1',CreationTime:new Date(),RecordType:''},
        dialogForm01:{ID:'',Name:'',Scope:'1',UserID:'1',CreationTime:'2019-03-08 10:18',RecordType:'1'},
        searchForm01:{Name:'',Scope:'',RecordType:''},
        templateData01: [],


        selItems:[],
        labelPosition:'right',

      }
    },
    filters:{
      showScope:function(scope){
        if(scope==1){
          return '个人';
        }else if(scope==2){
          return '科室';
        }else{
          return '全院';
        }
      },
      showType:function(scope){
        if(scope==1){
          return '检查';
        }else if(scope==2){
          return '检验';
        }else{
          return '处置';
        }
      }
    },
  }
</script>

<style>
</style>
