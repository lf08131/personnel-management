<template>
  <!-- 用户管理 -->
  <el-container v-loading="loading">
    <el-header style="padding: 10px">
      <el-row >
        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-input placeholder="输入查询用户关键字" size="mini" v-model="keywords01">
            </el-input>
          </div>
        </el-col>

        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-button type="primary" size="mini" style="margin-left: 10px" icon="el-icon-view" @click="searchData">查询用户</el-button>
          </div>
        </el-col>

        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-button type="primary" size="mini" style="margin-left: 10px" icon="el-icon-edit" @click="showAddDialog">新增用户</el-button>
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

        <el-table-column label="用户名" prop="UserName" align="left"></el-table-column>
        <el-table-column label="密码" prop="Password" width="140" align="left"></el-table-column>
        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <el-button type="primary"
                       size="mini"
                       @click="showEditDialog(scope.$index, scope.row)">编辑
            </el-button>
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-row>
        <el-col :span="8" align="left">
          <el-button type="danger" style="margin-top: 10px;width: 100px;" size="mini"
                     @click="deleteAll"  :disabled="this.selItems.length==0">批量删除
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
    </el-main>

    <!-- 编辑弹框---start -->
    <el-dialog title="新增用户" :visible.sync="dialogFormVisible" width="700px">
      <el-form label-width="100px" :inline="true" :model="formEdit01" :rules="rules" ref="addDrugForm" class="demo-form-inline" size="mini">


        <el-form-item label="用户名" prop="UserName">
          <el-input v-model="formEdit01.UserName" placeholder="用户名" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="formEdit01.Password" placeholder="密码" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="真实姓名">
          <el-input v-model="formEdit01.RealName" placeholder="真实姓名" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="用户类型">
          <el-input v-model="formEdit01.UseType" placeholder="用户类型" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="药品单价" >
          <el-input v-model="formEdit01.DocTitleID" placeholder="药品单价 - - 两位小数" size="mini"></el-input>
        </el-form-item>
       <!-- <el-form-item label="药品单价" >
          <el-input v-model="formEdit01.IsScheduling" placeholder="药品单价 - - 两位小数" size="mini"></el-input>
        </el-form-item>-->
        <el-form-item label="所在部门ID" >
          <el-input v-model="formEdit01.DeptID" placeholder="所在部门ID" size="mini"></el-input>
        </el-form-item>
       <!-- <el-form-item label="药品单价" >
          <el-input v-model="formEdit01.RegistLeID" placeholder="药品单价 - - 两位小数" size="mini"></el-input>
        </el-form-item>-->
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

        <el-form-item label="用户ID">
          <el-input v-model="formEdit02.ID" placeholder="用户ID" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="用户名">
          <el-input v-model="formEdit02.UserName" placeholder="用户名" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="formEdit02.Password" placeholder="密码" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="真实姓名">
          <el-input v-model="formEdit02.RealName" placeholder="真实姓名" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="用户类型">
          <el-input v-model="formEdit02.UseType" placeholder="用户类型" size="mini"></el-input>
        </el-form-item>
     <!--   <el-form-item label="药品单价1">
          <el-input v-model="formEdit02.DocTitleID" placeholder="药品单价" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="药品单价2" >
          <el-input v-model="formEdit02.IsScheduling" placeholder="药品小数" size="mini"></el-input>
        </el-form-item>-->
        <el-form-item label="所在部门ID" >
          <el-input v-model="formEdit02.DeptID" placeholder="所在部门ID" size="mini"></el-input>
        </el-form-item>
       <!-- <el-form-item label="药品单价4" >
          <el-input v-model="formEdit02.RegistLeID" placeholder="药品单价 - - 两位小数" size="mini"></el-input>
        </el-form-item>-->
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="warning" @click="dialogFormVisible02 = false" size="mini">取 消</el-button>
        <el-button type="primary" @click="updateData" size="mini">保 存</el-button>
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

      showUpSuccess(response, file, fileList){
        this.loading = false;
        if(file.status=="success"){
          showMsgTitle(this,file.name+"上传");
          this.categories=response.list;
          this.totalCount=response.totalCount;
        }else {
          this.$message("文件上传失败,请重新上传");
        }
      },
      showUpError(response, file, fileList){
        this.loading = false;
        this.$message("文件上传失败,请重新上传");
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


      addNewData(formName){
        let _this = this;
        this.$refs[formName].validate((valid) => {
          if (valid) {
            postRequest(this.rootUrl +'/neupha/Users/', this.formEdit01).then(resp=> {
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
        putRequest(this.rootUrl +'/neupha/Users/', this.formEdit02).then(resp=> {
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
      //删除单个药品信息
      handleDelete(index, row){
        let _this = this;
        this.$confirm('确认删除 \"' + row.UserName + '\" ?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.deleteData(row.ID);
          this.showMsgTitle(this,"删除"+ row.UserName);
        }).catch(() => {
          //取消
          _this.loading = false;
        });
      },
      deleteAll(){
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
          _this.deleteData(ids);
          // this.showMsgConfirm(this,"删除"+ this.selItems.length + ' 条数据');
        }).catch(() => {
          //取消
          _this.loading = false;
        });
      },
      deleteData(ids){
        let _this = this;
        this.loading = true;
        //删除
        deleteRequest(this.rootUrl +'/neupha/Users/' + ids).then(resp=> {
          let json = resp.data;
          _this.$message({
            type: json.status,
            message: json.msg
          });
          _this.loadDatas(1, this.pageSize,'');
        }, resp=> {
          _this.loading = false;
          if (resp.response.status == 403) {
            _this.$message({
              type: 'error',
              message: resp.data.msg
            });
          } else if (resp.response.status == 500) {
            _this.$message({
              type: 'error',
              message: '删除失败!'
            });
          }
        })
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
        let url = this.rootUrl +"/neupha/Users/listPage?pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&keywords01=" + keywords01 ;
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
          other: "",
          name1: "",
          address1: "",
          date1: "",
          other1: ""
        },
        formEdit01: {
          //表单对象
          //ID ,UserName, Password, RealName,UseType,DocTitleID,IsScheduling,DeptID
          ID:'',
          UserName:'',
          Password:'',
          RealName:'',
          UseType:'',
          DocTitleID:'',
          IsScheduling:'',
          DeptID:'',
          RegistLeID:'',
          DelMark:'',
        },
        formEdit02: {
          //表单对象
        },
        dialogAddVisible: false,
        dialogFormVisible02: false,
        dialogFormVisible: false,
        labelPosition:'right',
      }
    }
  }
</script>

<style scoped>
</style>
