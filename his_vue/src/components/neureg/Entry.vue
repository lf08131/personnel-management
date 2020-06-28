<template>
  <!-- 入职管理 -->
  <el-container v-loading="loading">
    <el-header style="padding: 10px">
      <el-row >
        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-input placeholder="输入查询员工关键字" size="mini" v-model="keywords01">
            </el-input>
          </div>
        </el-col>

        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-button type="primary" size="mini" style="margin-left: 10px" icon="el-icon-view" @click="searchData">查询员工</el-button>
          </div>
        </el-col>

        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-button type="primary" size="mini" style="margin-left: 10px" icon="el-icon-edit" @click="showAddDialog">员工入职</el-button>
          </div>
        </el-col>


      </el-row>
    </el-header>
    <el-main >
      <el-table
        stripe
        ref="multipleTable" size="mini"
        :data="categories" @selection-change="handleSelectionChange01"
        tooltip-effect="dark"
        style="width: 100%">
        <el-table-column
          type="selection"
          width="55" align="left">
        </el-table-column>

        <el-table-column label="员工名" prop="employerName" align="left"></el-table-column>
        <el-table-column label="性别" prop="Sex" width="140" align="left"></el-table-column>
        <el-table-column label="生日" prop="birthData" align="left"></el-table-column>
      <!--  <el-table-column label="离职原因" prop="Tornoverreason" width="140" align="left"></el-table-column>-->
        <el-table-column label="部门名" prop="Deptname" align="left"></el-table-column>
        <el-table-column label="岗位名" prop="Postname" width="140" align="left"></el-table-column>

        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <el-button type="primary1"
                       size="mini"
                       @click="showEditDialog(scope.$index, scope.row)">编辑
            </el-button>
            <el-button type="primary"
                       size="mini"
                       @click="showEditDialog1(scope.$index, scope.row)">离职
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-row>

        <el-col :span="23" align="right">
          <el-pagination
            background
            :page-size="pageSize" :current-page.sync="currentPage01"
            layout="prev, pager, next"
            :total="totalCount" @current-change="currentChange" v-show="this.categories.length>0">
          </el-pagination>
        </el-col>
      </el-row>
    </el-main>

    <!-- 新增员工弹框---start -->
    <el-dialog title="新增员工" :visible.sync="dialogFormVisible" width="700px">
      <el-form label-width="100px" :inline="true" :model="formEdit01" :rules="rules" ref="addDrugForm" class="demo-form-inline" size="mini">
        <el-form-item label="员工Id" prop="entry_id">
          <el-input v-model="formEdit01.entry_id" placeholder="员工ID" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="员工名" prop="employerName">
          <el-input v-model="formEdit01.employerName" placeholder="员工名" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-input v-model="formEdit01.Sex" placeholder="性别" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="生日">
          <el-input v-model="formEdit01.birthData" placeholder="生日" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="离职原因">
          <el-input v-model="formEdit01.Tornoverreason" placeholder="离职原因" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="部门名" >
          <el-input v-model="formEdit01.Deptname" placeholder="部门名" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="岗位名" >
          <el-input v-model="formEdit01.Postname" placeholder="岗位名" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="入职日期" >
          <el-input v-model="formEdit01.startDate" placeholder="入职日期" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="离职日期" >
          <el-input v-model="formEdit01.endDate" placeholder="离职日期" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="员工类型" >
          <el-input v-model="formEdit01.Employment_type" placeholder="员工类型" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="是否入人才库" >
          <el-input v-model="formEdit01.Personnel_type" placeholder="是否入人才库 -- 是或否" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="DelMark" >
          <el-input v-model="formEdit01.DelMark" placeholder="DelMark --1显示0不显示" size="mini"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="warning" @click="dialogFormVisible = false" size="mini">取 消</el-button>
        <el-button type="primary" @click="addNewData('addDrugForm')" size="mini">保 存</el-button>
      </div>
    </el-dialog>

    <el-dialog title="编辑药品" :visible.sync="dialogFormVisible02" width="700px">
      <el-form :label-position="labelPosition" label-width="100px" :inline="true" :model="formEdit02" class="demo-form-inline" size="mini">
        <el-form-item label="员工名" >
          <el-input v-model="formEdit02.employerName" placeholder="员工名" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-input v-model="formEdit02.Sex" placeholder="性别" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="生日">
          <el-input v-model="formEdit02.birthData" placeholder="生日" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="离职原因">
          <el-input v-model="formEdit02.Tornoverreason" placeholder="离职原因" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="部门名" >
          <el-input v-model="formEdit02.Deptname" placeholder="部门名" size="mini"></el-input>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="warning" @click="dialogFormVisible02 = false" size="mini">取 消</el-button>
        <el-button type="primary" @click="updateData" size="mini">保 存</el-button>
      </div>
    </el-dialog>
    <el-dialog title="" :visible.sync="dialogFormVisible1" width="700px">
      <el-form :label-position="labelPosition" label-width="100px" :inline="true" :model="formEdit02" class="demo-form-inline" size="mini">

        <el-form-item label="离职原因" >
          <el-input v-model="formEdit02.Tornoverreason" placeholder="" size="mini">输入离职原因</el-input>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="warning" @click="dialogFormVisible1 = false" size="mini">取 消</el-button>
        <el-button type="primary" @click="updateData1" size="mini">保 存</el-button>
      </div>
    </el-dialog>
    <!-- 编辑弹框---end -->
  </el-container>
</template>

<script>
  import {showMsgTitle} from '../../utils/api'
  import  {showConstants} from '../../utils/api'
  import {postRequest}   from '../../utils/api'
  import {putRequest}    from '../../utils/api'
  import {deleteRequest} from '../../utils/api'
  import {getRequest}    from '../../utils/api'
  export default{
    mounted: function () {
      this.loadDatas(1, this.pageSize,this.keywords01);
    },
    methods: {
      beginUpLoad(){
        this.loading = true;
      },
      showFormatConstants(row, column, cellValue, index){
        return showConstants(row, column, cellValue, index);
      },


      handleSelectionChange01(val){
        this.selItems = val;
      },
      searchData(){
        if(this.keywords01==null || this.keywords01==''){
          this.loadDatas(1, this.pageSize,'');
        }else{
          this.loadDatas(1, this.pageSize,this.keywords01);
        }
      },
      //弹出增加新数据对话框时，需要初始化数据
      showAddDialog(){
        this.dialogFormVisible = true;
        this.formEdit02 = row;
      },
      //弹出修改药品对话框
      showEditDialog(index, row){
        this.dialogFormVisible02=true;
        this.formEdit02 = row;
      },
      showEditDialog1(index, row){
        this.dialogFormVisible1=true;
        this.formEdit02 = row;
      },

      addNewData(formName){
        let _this = this;
        this.$refs[formName].validate((valid) => {
          if (valid) {
            postRequest(this.rootUrl +'/neupha/Entry/', this.formEdit01).then(resp=> {
              if (resp.status == 200) {
                let json = resp.data.list;
                _this.$message({type: json.status, message: json.msg});
                _this.formEdit01 = {};
                _this.loadDatas(1, this.pageSize,'');
              }
              _this.loading = false;
            }, resp=> {
              if (resp.response.status == 403) {
                _this.$message({
                  type: 'error',
                  message: resp.response.data
                });
              }
              _this.loading = false;
            });
            this.dialogFormVisible = false;
          }else{
            this.dialogFormVisible = true;
          }
        });

      },


      //进行修改药品信息
      updateData(){
        let _this = this;
        putRequest(this.rootUrl +'/neupha/Entry/', this.formEdit02).then(resp=> {
          if (resp.status == 200) {
            let json = resp.data.list;
            _this.$message({type: json.status, message: json.msg});
            _this.formEdit01 = {};
            _this.loadDatas(1, this.pageSize,'');
          }
          _this.loading = false;
        }, resp=> {
          if (resp.response.status == 403) {
            _this.$message({
              type: 'error',
              message: resp.response.data
            });
          }
          _this.loading = false;
        });
        this.dialogFormVisible02=false;
      },
      updateData1(){
        let _this = this;
        putRequest(this.rootUrl +'/neupha/Entry/1', this.formEdit02).then(resp=> {
          if (resp.status == 200) {
            let json = resp.data.list;
            _this.$message({type: json.status, message: json.msg});
            _this.formEdit01 = {};
            _this.loadDatas(1, this.pageSize,'');
          }
          _this.loading = false;
        }, resp=> {
          if (resp.response.status == 403) {
            _this.$message({
              type: 'error',
              message: resp.response.data
            });
          }
          _this.loading = false;
        });
        this.dialogFormVisible1=false;
      },

      handleSelectionChange(val) {
        this.selItems = val;
      },
      //翻页
      currentChange(currentPage){
        this.currentPage01 = currentPage;
        this.loading = true;
        this.loadDatas(currentPage, this.pageSize,this.keywords01);
      },
      //加载数据

      loadDatas(pageNumber, pageSize ,keywords01){
        let _this = this;
        let url = this.rootUrl +"/neupha/Entry/listPage?pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&keywords01=" + keywords01 ;
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


    data(){
      return {
        loading:false,
        currentPage01:1,
        pageSize:10,
        totalCount:0,
        keywords01: '',
        selItems: [],
        categories: [{
          DrugsCode:'13083243242',          DrugsName:'注射用甲氨喋呤',          DrugsFormat:'1g×1支',          DrugsUnit:'支',          DrugsPrice:'15.73',          DrugsDosageID:'110',          DrugsTypeID:'101',
        }],
        loading: false,
        formAdd: {
          //表单对象
          name: "",
          address: "",
          date: "",
          other: ""
        },
        formEdit01: {
          //表单对
          entry_id:'',
          employerName:'',
          Sex:'',
          birthData:'',
          Tornoverreason:'',
          Deptname:'',
          Postname:'',
          startDate:'',
          endDate:'',
          Employment_type:'',
          Personnel_type:'',
          DelMark:'',
        },
        formEdit02: {
          //表单对象
        },
        dialogAddVisible: false,
        dialogFormVisible1: false,
        dialogFormVisible02: false,
        dialogFormVisible: false,
        labelPosition:'right',
      }
    }
  }
</script>

<style scoped>
</style>
