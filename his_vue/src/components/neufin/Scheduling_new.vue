<!--离职报表管理-->
<template>
  <gao-el-container>
    <!--按时间查询的日期表-->
    <!--开始日期参数是keywords1-->
    <font style="font-size:13px;font-family:'Microsoft YaHei'">开始时间:</font>&nbsp;
    <el-date-picker
      type="date"
      placeholder="选择日期" size="mini" style="width: 130px;" v-model="keywords"  value-format="yyyy-MM-dd">
    </el-date-picker>
    <!--结束时间绑定参数是keywords2-->
    <font style="font-size:13px;font-family:'Microsoft YaHei'">结束时间:</font>&nbsp;
    <el-date-picker
      type="date"
      placeholder="选择日期" size="mini" style="width: 130px;" v-model="keywords2" value-format="yyyy-MM-dd">
    </el-date-picker>
    <!--日期表结束-->

    <el-col :span="4">
      <!--根据部门名称和起止时间查指定部门的新聘员工报表，部门名称绑定参数为keywords3-->
      <el-input placeholder="请输入部门名称" size="mini" v-model="keywords3"></el-input>
    </el-col>
    <el-button type="primary" size="mini" style="margin-left: 10px" icon="el-icon-view" @click="searchClick">查询部门离职员工报表</el-button>

    <p></p>
    <!-- :data="categories：类别"  --><!--日期对象-->
    <el-table
      ref="multipleTable"
      :data="tableData3"
      tooltip-effect="dark"
      style="width: 100%"
      @selection-change="handleSelectionChange" v-loading="loading">
      <el-table-column
        type="selection"
        width="55" align="left">
      </el-table-column>
      <!--界面大框结束-->

      <!--显示界面表头-->
      <el-table-column
        label="报表ID"
        prop="ID"
        width="120" align="left">
      </el-table-column>

      <el-table-column
        label="部门名称"
        prop="Deptname"
        width="120" align="left">
      </el-table-column>

      <el-table-column
        label="岗位名称"
        prop="Postname"
        width="120" align="left">
      </el-table-column>

      <el-table-column
        label="员工姓名"
        prop="employerName"
        width="120" align="left">

      </el-table-column>

      <el-table-column
        label="性别"
        prop="Sex"
        width="120" align="left">
      </el-table-column>

     <!-- <el-table-column
        label="入职日期"
        prop="startDate"
        width="120" align="left">
      </el-table-column>-->

      <el-table-column
        label="离职日期"
        prop="endDate"
        width="120" align="left">
      </el-table-column>

      <el-table-column
        label="离职原因"
        prop="Tornoverreason"
        width="120" align="left">
      </el-table-column>

   <!--   <el-table-column
        label="ID"
        prop="ID"
        width="120" align="left" v-if='false'>
      </el-table-column>-->
      <!--显示界面表头结束-->

    </el-table>


  </gao-el-container>
</template>

<script>
  import {postRequest} from '../../utils/api'
  import {putRequest} from '../../utils/api'
  import {deleteRequest} from '../../utils/api'
  import {getRequest} from '../../utils/api'

  //const cityOptions = ['上海', '北京', '广州', '深圳'];

  export default{
    methods: {
    /*  handleCheckAllChange(val) {
        this.checkedCities = val ? cityOptions : [];
        this.isIndeterminate = false;
      },
      handleCheckedCitiesChange(value) {
        let checkedCount = value.length;
        this.checkAll = checkedCount === this.cities.length;
        this.isIndeterminate = checkedCount > 0 && checkedCount < this.cities.length;
      },*/
      handleSelectionChange(val) {
        this.selItems = val;
      },
      //翻页相关
      currentChange(currentPage){
        this.currentPage01 = currentPage;
        this.loading = true;
        this.loadBlogs(currentPage, this.pageSize);
      },
      //排班查询
      searchClick(){
        this.loadBlogs(1, this.pageSize);
      },
      //排班查询 相关
      loadBlogs(page, count){
        var _this = this;

        var url =this.rootUrl +"/neusys/scheduling/all?page=" + page + "&count=" + count + "&keywords=" + this.keywords + "&keywords2=" + this.keywords2 + "&keywords3=" + this.keywords3  ;
        getRequest(url).then(resp=> {
          if (resp.status == 200) {
            _this.loading = false;
            _this.tableData3 = resp.data.list;
            _this.totalCount = resp.data.totalCount;
            _this.currentPage01 = page ;
          } else {
            _this.$message({type: 'error', message: '数据加载失败1!'});
          }
        }, resp=> {
          _this.loading = false;
          if (resp.response.status == 403) {
            _this.$message({type: 'error', message: resp.response.data});
          } else {
            _this.$message({type: 'error', message: '数据加载失败2!'});
          }
        }).catch(resp=> {
          //压根没见到服务器
          _this.loading = false;
          _this.$message({type: 'error', message: '数据加载失败3!'});
        })
      },
    },

    data(){

      return {

        selItems: [],
        //翻页相关 {
        totalCount: 2,
        currentPage01:1,
        pageSize: 10,
        //翻页相关 }


        keywords: '',
        keywords2: '',
        keywords3: '',


       // tableData2: [],
        tableData3: [{
          ID: '',
          Deptname: '',
          Postname: '',
          employerName: '',
          Sex: '',
          Tornoverreason: '',
          endDate:''},
        ],
        loading: false,
        dialogAddVisible: false,
        dialogFormVisible: false,

        ///*
        //*/
      }
    }
  }
</script>
<style>
  .gao-cate_mana_header {
    background-color: #ececec;
    margin-top: 20px;
    padding-left: 5px;
    display: flex;
    justify-content: flex-start;
    text-align: center;
    vertical-align: middle;
  }

  .gao-cate_mana_main {
    /*justify-content: flex-start;*/
    display: flex;
    flex-direction: column;
    padding-left: 5px;
    background-color: #ececec;
    margin-top: 20px;
    padding-top: 10px;
  }

  .gao-transfer-footer {
    margin-left: 20px;
    padding: 6px 5px;
  }

  .gao-el-header {
    background-color: #20a0ff;
    color: #333;
    text-align: left;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .gao-el-aside {
    background-color: #ECECEC;
  }

  .gao-el-main {
    background-color: #fff;
    color: #000;
    text-align: left;
  }

  .gao-el-container {
    background-color: #fff;
    color: #000;
    text-align: left;
  }
</style>
