<template>
  <!-- 实习离职 -->
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
        <!-- <el-table-column label="用户名" prop="startData" align="left"></el-table-column>
         <el-table-column label="密码" prop="workData" width="140" align="left"></el-table-column>
         <el-table-column label="用户名" prop="Employment_type" align="left"></el-table-column>
         <el-table-column label="密码" prop="Personnel_type" width="140" align="left"></el-table-column>-->

      </el-table>

    </el-main>


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
        let url = this.rootUrl +"/neupha/Entry/listPage4?pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&keywords01=" + keywords01 ;
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
         /* startDate:'',
          endDate:'',

          Employment_type:'',
          Personnel_type:'',
          DelMark:'',*/
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


