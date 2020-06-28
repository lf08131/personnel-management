<template>
  <!-- 岗位管理 -->
  <el-container v-loading="loading">
    <el-header style="padding: 10px">
      <el-row >
        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-input placeholder="" size="mini" v-model="keywords01">
            </el-input>
          </div>
        </el-col>

        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-button type="primary" size="mini" style="margin-left: 10px" icon="el-icon-view" @click="searchData">查询岗位</el-button>
          </div>
        </el-col>

        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-button type="primary" size="mini" style="margin-left: 10px" icon="el-icon-edit" @click="showAddDialog">新增岗位</el-button>
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


        <el-table-column label="岗位名称" prop="Post_name" align="left"></el-table-column>
        <el-table-column label="岗位类型" prop="Post_type" width="140" align="left"></el-table-column>
        <el-table-column label="成立日期" prop="date" width="140" align="left"></el-table-column>
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
    <el-dialog title="新增药品" :visible.sync="dialogFormVisible" width="700px">
      <el-form label-width="100px" :inline="true" :model="formEdit01" :rules="rules" ref="addDrugForm" class="demo-form-inline" size="mini">

        <el-form-item label="岗位ID" prop="Post_id">
          <el-input v-model="formEdit01.Post_id" placeholder="岗位" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="岗位名称" prop="UserName">
          <el-input v-model="formEdit01.Post_name" placeholder="岗位名称" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="岗位类型">
          <el-input v-model="formEdit01.Post_type" placeholder="岗位类型" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="Delmark">
          <el-input v-model="formEdit01.DelMark" placeholder="1" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="成立日期">
          <el-input v-model="formEdit01.date" placeholder="1" size="mini"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="warning" @click="dialogFormVisible = false" size="mini">取 消</el-button>
        <el-button type="primary" @click="addNewData('addDrugForm')" size="mini">保 存</el-button>
      </div>
    </el-dialog>
    <el-dialog title="编辑药品" :visible.sync="dialogFormVisible02" width="700px">
      <el-form :label-position="labelPosition" label-width="100px" :inline="true" :model="formEdit02" class="demo-form-inline" size="mini">

        <el-form-item label="岗位ID">
          <el-input v-model="formEdit02.Post_id" placeholder="岗位ID" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="岗位名称">
          <el-input v-model="formEdit02.Post_name" placeholder="岗位名称" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="岗位类型">
          <el-input v-model="formEdit02.Post_type" placeholder="岗位类型" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="DelMark">
          <el-input v-model="formEdit02.DelMark" placeholder="DelMark-- 1显示0不显示" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="成立日期">
          <el-input v-model="formEdit02.date" placeholder="成立日期" size="mini"></el-input>
        </el-form-item>
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
            postRequest(this.rootUrl +'/neupha/Post/', this.formEdit01).then(resp=> {
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
        putRequest(this.rootUrl +'/neupha/Post/', this.formEdit02).then(resp=> {
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
        this.$confirm('确认删除 \"' + row.Post_name + '\" ?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.deleteData(row.Post_id);
          //this.showMsgTitle(this,"删除"+ row.Post_name);
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
            ids += selItems[i].Post_id + ",";
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
        deleteRequest(this.rootUrl +'/neupha/Post/' + ids).then(resp=> {
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
        let url = this.rootUrl +"/neupha/Post/listPage?pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&keywords01=" + keywords01 ;
        getRequest(url).then(resp=> {
          _this.loading = false;
          if (resp.status == 200) {
            _this.categories = resp.data.list;
            _this.totalCount = resp.data.totalCount;
            _this.currentPage01 = pageNumber ;
          } else {
            _this.$message({type: 'error', message: '数据加载失败200!'});
          }
        }, resp=> {
          _this.loading = false;
          if (resp.response.status == 403) {
            _this.$message({type: 'error', message: resp.response.data});
          } else {
            _this.$message({type: 'error', message: '数据加载失败403!'});
          }
        }).catch(resp=> {
          //压根没见到服务器
          _this.loading = false;
          _this.$message({type: 'error', message: '数据加载失败555!'});
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
          Post_name:'经理',Post_type:'管理',date:'2020-09-09',
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
          Post_id:'',
          Post_name:'',
          Post_type:'',
          DelMark:'',
          date:'',
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

