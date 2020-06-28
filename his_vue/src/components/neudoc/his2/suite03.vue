<template>
  <el-container >
    <el-aside style="width:40%;background:#fff">
      <el-row style="background-color: #EAF1F5">
        <el-col :span="18">
          <el-tag size="small">西药处方模板：</el-tag>
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
            <el-form-item>
              <el-button @click="dialogTableVisible=false" type="warning">取消</el-button>
              <el-button type="primary" @click="addNewData('form01')">创建</el-button>
            </el-form-item>
          </el-form>
        </el-dialog>
      </el-row>
      <el-row style="margin-top: 10px;">
        <el-form :inline="true" :model="searchForm01" class="demo-form-inline" size="mini">
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
        </el-table>
      </el-row>
    </el-aside>
    <el-main style="width:60%;height: 1200px;">
        <el-row style="background-color: #EAF1F5">
          <el-col :span="4">
            <el-tag type="info" >操作：</el-tag>
          </el-col>
          <el-col :span="5" style="text-align: right">
            <el-button type="text" size="small" class="el-icon-circle-plus-outline" @click="showDrugsList">增加药品</el-button>
          </el-col>
          <el-dialog title="模板增加药品" :visible.sync="dialogDrugsVisible" top="10px" width="80%">
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
                <el-dialog width="30%" title="添加模板中的药品详情" :visible.sync="innerVisible" append-to-body center="center">
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
                      <el-input v-model="formEdit02.Usage" placeholder="药品用法" ></el-input>
                    </el-form-item>
                    <el-form-item label="药品用量">
                      <el-input v-model="formEdit02.Dosage" placeholder="药品用量" ></el-input>
                    </el-form-item>
                    <el-form-item label="使用频次">
                      <el-input v-model="formEdit02.Frequency" placeholder="使用频次" ></el-input>
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
                           @click="closeDrugsDialog"  >关闭
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
          <el-col :span="5" style="text-align: right">
            <el-button type="text" size="small" class="el-icon-close" @click="deleteTmplDrugs"  :disabled="this.selItems.length==0">删除药品</el-button>
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

        <el-form inline="inline" :model="formEdit03" size="small">
          <el-tag  type="info">模板名称：</el-tag>
          <el-form-item style="width: 50%">
            <el-input  v-model="formEdit03.Name" style="width: 200px"></el-input>
          </el-form-item>
            <el-form-item label="模板范围">
            <el-select v-model="formEdit03.Scope"  placeholder="范围" style="width: 100px" >
              <el-option label="全院" value="3">全院</el-option>
              <el-option label="科室" value="2">科室</el-option>
              <el-option label="个人" value="1">个人</el-option>
            </el-select>
            </el-form-item>
        </el-form>
      <el-row >
          <el-table ref="multipleTable02" :data="templateDrugs" style="width: 100%" @selection-change="handleSelectionChange01" size="mini" >
            <el-table-column type="selection" width="55"></el-table-column>
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
    </el-main>

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
      this.loadDatas('','');
      //this.loadDrugs(1, this.pageSize,this.keywords01);
    },
    methods:{
      onSubmit:function(){
        this.dialogTableVisible=false;
      },
      showFormatConstants(row, column, cellValue, index){
        return showConstants(row, column, cellValue, index);
      },
      handleSelectionChange01:function(val){
        // alert(val[0].ID);
        // alert(JSON.stringify(val));
        this.selItems = val;
      },
      handleCurrentChange01:function(val){
        this.formEdit03.ID=val.ID;
        this.formEdit03.Name=val.Name;
        this.formEdit03.Scope = val.Scope +'';
        this.showTmplDrugs(val.ID);
      },
      //修改模板信息
      updataTemplate(){
        let _this = this;
        this.$confirm('此操作将修改模板信息 ,是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          putRequest(this.rootUrl +'/neupha/template/', this.formEdit03).then(resp => {
            if (resp.status == 200) {
              let json = resp.data;
              _this.$message({type: json.status, message: json.msg});
              // _this.formEdit03 = {};
              _this.loadDatas('', '');
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
          deleteRequest(this.rootUrl +'/neupha/template/drug/'+this.formEdit03.ID).then(resp => {
            if (resp.status == 200) {
              let json = resp.data;
              _this.$message({type: json.status, message: json.msg});
              _this.formEdit03 = {};
              _this.loadDatas('', '');
              _this.showTmplDrugs(this.formEdit03.ID);
            }
          });
        }).catch(() => {
          _this.$message({
            type: 'info',
            message: '已取消'
          });
        });
      },
      closeDrugsDialog(){
        this.dialogDrugsVisible=false;
        this.showTmplDrugs(this.formEdit03.ID);
      },
      //显示模板包含的药品信息
      showTmplDrugs(id){
        let _this = this;
        let url =this.rootUrl +this.rootUrl +"/neupha/templateDetaile/listTemplateDrugs?keywords01="+id;
        getRequest(url).then(resp=>{
          if(resp.status == 200){
            _this.templateDrugs = resp.data ;
            // alert(_this.templateDrugs[0].ID);
          }else{
            _this.templateData01.Name = '没有数据';
          }
        }).catch(resp=>{
          _this.$message({type:'error',message:'数据加载失败！'});
        });
      },
      searchTemplate(){
        this.loadDatas(this.searchForm01.Name,this.searchForm01.Scope);
      },
      showDrugsList(){
        if(this.formEdit03.ID==null || this.formEdit03.ID==''){
          this.$message({type: 'error', message: '请选择要添加药品的模板!'});
        }else {
          this.loadDrugs(1, this.pageSize,this.keywords01);
          this.dialogDrugsVisible=true;
        }
      },
      addNewData(formName){
        let _this = this;
        postRequest(this.rootUrl +'/neupha/template/', this.dialogForm01).then(resp => {
          if (resp.status == 200) {
            let json = resp.data;
            _this.$message({type: json.status, message: json.msg});
            _this.dialogForm01 = {};
            _this.loadDatas('', '');
          }
        });
        _this.dialogTableVisible = false;
      },
      //加载模板数据 -- 无分页
      loadDatas(keywords01,keywords02){
        let _this = this;
        let url =this.rootUrl +this.rootUrl +"/neupha/template/listDrugTemplate?keywords01="+keywords01+"&keywords02="+keywords02;
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
        })
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

      //打开添加模板中药品信息的“对话框”
      showInnerDialog(index,row){
          this.innerVisible=true;
          this.formEdit02 = row;
          this.formEdit02.DrugsDosage = row.Dosage;
          this.formEdit02.DrugtempId = this.formEdit03.ID;
          this.formEdit02.DrugsId = row.ID;
          this.formEdit02.Usage='';
          this.formEdit02.Dosage='';
          this.formEdit02.Frequency='';
      },
      //添加模板中药品信息
      addDrugsDetailed(){
        let _this = this;
        postRequest(this.rootUrl +'/neupha/templateDetaile/drugs',this.formEdit02).then(resp=> {
          if(resp.status == 200){
            let json = resp.data;
            _this.$message({type:json.status,message:json.msg});
            _this.formEdit02 = {};
            this.innerVisible=false;
          }else{
            _this.$message({type:'warm',message:'添加失败！'});
          }
        });
      },
      //删除模板中药品信息
      deleteTmplDrugs(){
        let _this = this;
        this.$confirm('确认删除这 ' +  this.selItems.length + ' 条数据?', '提示', {
          type: 'warning',
          confirmButtonText: '确定',
          cancelButtonText: '取消'
        }).then(()=> {
          let selItems = _this.selItems;
          let ids = '';
          for (let i = 0; i < selItems.length; i++) {
            ids += selItems[i].ID + ",";
          }
          // alert(ids);
          this.deleteTmplDrug(ids);

          this.$message({type:'success',message:"删除"+ this.selItems.length + ' 条数据成功！'});
        }).catch(() => {
          //取消
          //_this.loading = false;
        });
      },
      deleteTmplDrug(ids){
        let _this = this;
        //this.loading = true;
        //删除
        deleteRequest(this.rootUrl +'/neupha/templateDetaile/drugs/' + ids).then(resp=> {
          let json = resp.data;
          _this.$message({
            type: json.status,
            message: json.msg
          });
          this.showTmplDrugs(this.formEdit03.ID);
        }, resp=> {
          _this.loading = false;
          if (resp.response.status == 403) {
            _this.$message({
              type: 'error',
              message: resp.response.data
            });
          } else if (resp.response.status == 500) {
            _this.$message({
              type: 'error',
              message: '删除失败!'
            });
          }
        })
      },
    },
    data() {
      return {
        dialogTableVisible: false,
        dialogDrugsVisible:false,
        innerVisible:false,
        selItems:[],
        labelPosition:'right',
        dialogForm01:{
          Name:'',Scope:'1',UserID:'1',CreationTime:'2019-03-08 10:18'
        },
        searchForm01:{
          Name:'',Scope:''
        },
        templateData01: [],
        currentPage01:1,
        pageSize:10,
        totalCount:0,
        keywords01: '',
        categories:[{ MnemonicCode:'ZSYJAZZ',DrugsCode:'242413242', DrugsName:'注射用甲氨喋呤', Format:'1g×1支', Unit:'支', Price:'15.73', Dosage:'针剂', DrugsType:'西药',}],
        formEdit02:{ID:'',DrugtempId:'',DrugsId:'',DrugsName:'',Format:'',Unit:'',Usage:'',Dosage:'',Frequency:'',  DrugsDosage:'',DrugsCode:''},
        templateDrugs:[{ID:'',DrugstempId:'',DrugsId:'',DrugsName:'',DrugsFormat:'',DrugsUnit:'',DrugsUsage:'',DrugsDosage:'',DrugsFrequency:''}],
        formEdit03:{ID:'',Name:'',Scope:''},


        siteName:'',
        radio01:1,

        eltab01:'first',
        eltab02:'',




        tableData03: [],
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
      }
    },
  }
</script>

<style>
</style>
