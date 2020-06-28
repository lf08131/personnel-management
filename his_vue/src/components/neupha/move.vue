<template>
  <!-- 员工调动 -->
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
P
        <el-table-column label="员工名" prop="employerName" align="left"></el-table-column>

        <el-table-column label="部门名" prop="Deptname" align="left"></el-table-column>
        <el-table-column label="岗位名" prop="Postname" width="140" align="left"></el-table-column>
        <!-- <el-table-column label="用户名" prop="startData" align="left"></el-table-column>
         <el-table-column label="密码" prop="workData" width="140" align="left"></el-table-column>
         <el-table-column label="用户名" prop="Employment_type" align="left"></el-table-column>
         <el-table-column label="密码" prop="Personnel_type" width="140" align="left"></el-table-column>-->
        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <el-button type="primary1"
                       size="mini"
                       @click="showEditDialog1(scope.$index, scope.row)">部门调动
            </el-button>
            <el-button type="primary"
                       size="mini"
                       @click="showEditDialog(scope.$index, scope.row)">岗位调动
            </el-button>
          </template>
        </el-table-column>
      </el-table>


    <!-- 编辑弹框---start -->
    <el-dialog title="" :visible.sync="dialogFormVisible" width="700px">
      <el-form :label-position="labelPosition" label-width="100px" :inline="true" :model="formEdit02" class="demo-form-inline" size="mini">
        <el-form-item label="部门名字" >
          <el-input v-model="formEdit02.Deptname" placeholder="输入调动后的部门" size="mini">输入调动后的部门</el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="warning" @click="dialogFormVisible = false" size="mini">取 消</el-button>
        <el-button type="primary" @click="updateData1" size="mini">保 存</el-button>
      </div>
    </el-dialog>
    <el-dialog title="" :visible.sync="dialogFormVisible02" width="700px">
      <el-form :label-position="labelPosition" label-width="100px" :inline="true" :model="formEdit02" class="demo-form-inline" size="mini">

        <el-form-item label="岗位名称" >
          <el-input v-model="formEdit02.Postname" placeholder="输入调动后的岗位" size="mini">输入调动后的岗位</el-input>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="warning" @click="dialogFormVisible02 = false" size="mini">取 消</el-button>
        <el-button type="primary" @click="updateData" size="mini">保 存</el-button>
      </div>
    </el-dialog>
    <!-- 编辑弹框---end -->
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


      //弹出修改药品对话框
      showEditDialog1(index, row){
        this.dialogFormVisible = true;
        this.formEdit02 = row;
      },
      showEditDialog(index, row){
        this.dialogFormVisible02=true;
        this.formEdit02 = row;
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
      //删除单个药品信息

      updateData1(){
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
        this.dialogFormVisible=false;
      },
      //删除单个药品信息



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
          employerName:'张三',   Deptname:'财务部',    Postname:'经理',
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
          employerName:'',
          Deptname:'',
          Postname:'',

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
