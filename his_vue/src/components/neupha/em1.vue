<template>
  <!-- 实习管理 -->
  <el-container v-loading="loading">


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
        <el-table-column label="离职原因" prop="Tornoverreason" width="140" align="left"></el-table-column>
        <el-table-column label="部门名" prop="Deptname" align="left"></el-table-column>
        <el-table-column label="岗位名" prop="Postname" width="140" align="left"></el-table-column>
        <!-- <el-table-column label="用户名" prop="startDate" align="left"></el-table-column>
         <el-table-column label="密码" prop="endDate" width="140" align="left"></el-table-column>
         <el-table-column label="用户名" prop="Employment_type" align="left"></el-table-column>
         <el-table-column label="密码" prop="Personnel_type" width="140" align="left"></el-table-column>-->
        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <el-button type="primary1"
                       size="mini"
                       @click="showEditDialog1(scope.$index, scope.row)">入职
            </el-button>
            <el-button type="primary"
                       size="mini"
                       @click="showEditDialog(scope.$index, scope.row)">离职
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-row>

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
    <el-dialog title="" :visible.sync="dialogFormVisible1" width="700px">
      <el-form :label-position="labelPosition" label-width="100px" :inline="true" :model="formEdit02" class="demo-form-inline" size="mini">
        <el-form-item label="部门名字" >
          <el-input v-model="formEdit02.Deptname" placeholder="输入入职后的部门" size="mini">输入入职后的部门</el-input>

        </el-form-item>
        <el-form-item label="岗位名字" >
          <el-input v-model="formEdit02.Postname" placeholder="输入入职后的岗位" size="mini">输入入职后的岗位</el-input>

        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="warning" @click="dialogFormVisible1 = false" size="mini">取 消</el-button>
        <el-button type="primary" @click="updateData1" size="mini">保 存</el-button>
      </div>
    </el-dialog>

    <el-dialog title="" :visible.sync="dialogFormVisible02" width="700px">
      <el-form :label-position="labelPosition" label-width="100px" :inline="true" :model="formEdit02" class="demo-form-inline" size="mini">

        <el-form-item label="离职原因" >
          <el-input v-model="formEdit02.Tornoverreason" placeholder="" size="mini">输入离职原因</el-input>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="warning" @click="dialogFormVisible02 = false" size="mini">取 消</el-button>
        <el-button type="primary" @click="updateData" size="mini">保 存</el-button>
      </div>
    </el-dialog>
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
      showEditDialog(index, row){
        this.dialogFormVisible02=true;
        this.formEdit02 = row;
      },
      showEditDialog1(index, row){
        this.dialogFormVisible1=true;
        this.formEdit02 = row;
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



      updateData(){
        let _this = this;
        putRequest(this.rootUrl +'/neupha/Entry/2', this.formEdit02).then(resp=> {
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
        putRequest(this.rootUrl +'/neupha/Entry/3', this.formEdit02).then(resp=> {
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
        let url = this.rootUrl +"/neupha/Entry/listPage2?pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&keywords01=" + keywords01 ;
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
          employerName:'张三',     Sex:'男',    birthData:'2017-09-08',    Tornoverreason:'无',   Deptname:'财务部',   Postname:'经理',
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
        /*  startDate:'',
          endDate:'',
          Employment_type:'',
          Personnel_type:'',
          DelMark:'',*/
        },
        formEdit02: {
          //表单对象
        },
        dialogFormVisible1: false,
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
