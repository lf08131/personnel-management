<template>
  <!-- 部门管理 -->
  <el-container v-loading="loading">
    <el-header style="padding: 10px">
      <el-row >
        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-input placeholder="请输入部门名称" size="mini" v-model="keywords01">
            </el-input>
          </div>
        </el-col>

        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-button type="primary" size="mini" style="margin-left: 50px" icon="el-icon-view" @click="searchData">查询部门</el-button>
          </div>
        </el-col>

        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-button type="primary" size="mini" style="margin-left: 150px" icon="el-icon-edit" @click="showAddDialog">新增部门</el-button>
          </div>
        </el-col>

        <!--  <el-col :span="6" align="right">
            <div class="grid-content bg-purple">
              <el-upload class="upload-demo" action="http://localhost:8081/his/pha/upExcel" :on-progress="beginUpLoad"
                         :on-success="showUpSuccess" :on-error="showUpError" :show-file-list="false">
                <el-button size="mini" type="primary" icon="el-icon-sold-out">导入药品</el-button>
              </el-upload>
            </div>
          </el-col>-->
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
        <el-table-column label="部门ID" prop="Dept_id" width="140" align="left" ></el-table-column>
        <el-table-column label="部门名称" prop="Dept_name" align="left"></el-table-column>
        <el-table-column label="部门类型" prop="Dept_type" width="140" align="left"></el-table-column>
        <el-table-column label="部门电话" prop="Dept_phone" width="80" align="left"></el-table-column>
        <el-table-column label="部门描述" prop="Dept_describe" width="80" align="left"></el-table-column>
        <el-table-column label="上级部门" prop="Superior_dept" width="80" align="left">
          <!--  <template slot-scope="scope">
              {{ scope.row.DrugsDosageID | formatConstant }}
            </template>-->
        </el-table-column>
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
    <!-- 新增部门---start -->
    <el-dialog title="新增部门" :visible.sync="dialogFormVisible" width="700px">
      <el-form label-width="100px" :inline="true" :model="formEdit01" :rules="rules" ref="addDrugForm" class="demo-form-inline" size="mini">
        <el-form-item label="部门ID" prop="Dept_id">
          <el-input v-model="formEdit01.Dept_id" placeholder="部门ID" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="部门名称" prop="Dept_name">
          <el-input v-model="formEdit01.Dept_name" placeholder="部门名称" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="部门类型" prop="Dept_type">
          <el-input v-model="formEdit01.Dept_type" placeholder="部门类型" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="部门电话">
          <el-input v-model="formEdit01.Dept_phone" placeholder="部门电话" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="部门描述">
          <el-input v-model="formEdit01.Dept_describe" placeholder="部门描述" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="上级部门">
          <el-input v-model="formEdit01.Superior_dept" placeholder="上级部门" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="显示码">
          <el-input v-model="formEdit01.DelMark" placeholder="显示码   -- 只能填1" size="mini"></el-input>
        </el-form-item>
        <!--<el-form-item label="药品单价" prop="Price">
          <el-input v-model="formEdit01.DrugsPrice" placeholder="药品单价 - - 两位小数" size="mini"></el-input>
        </el-form-item>-->
        <!--<el-form-item label="药品剂型">
          <el-select  placeholder="输入剂型代码" v-model="formEdit01.DrugsDosageID" filterable remote size="mini" :remote-method="remoteMethod" :loading="loading">
            <el-option v-for="item in options01" :key="item.ID" :label="item.ConstantName" :value="item.ID">
              <span style="float: left">{{ item.ConstantName }}</span>
              <span style="float: right; color: #8492a6; font-size: 12px">{{ item.ConstantCode }}</span>
            </el-option>
          </el-select>
        </el-form-item>-->

        <!--<el-form-item label="部门类型">
          <el-select  placeholder="药品类型" v-model="formEdit01.Dept_type" size="mini" >
            <el-option v-for="item in options02" :key="item.ID" :label="item.ConstantName" :value="item.ID"></el-option>
          </el-select>
        </el-form-item>-->
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button type="warning" @click="dialogFormVisible = false" size="mini">取 消</el-button>
        <el-button type="primary" @click="addNewData('addDrugForm')" size="mini">保 存</el-button>
      </div>
    </el-dialog>
    <!--新增部门 ---end -->
    <!--编辑部门开始   --start -->
    <el-dialog title="编辑部门" :visible.sync="dialogFormVisible02" width="700px">
      <el-form :label-position="labelPosition" label-width="100px" :inline="true" :model="formEdit02" class="demo-form-inline" size="mini">
        <el-form-item label="部门ID">
          <el-input v-model="formEdit02.Dept_id" placeholder="部门ID" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="部门名称">
          <el-input v-model="formEdit02.Dept_name" placeholder="部门名称" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="部门类型" prop="Dept_type">
          <el-input v-model="formEdit02.Dept_type" placeholder="部门类型" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="部门电话">
          <el-input v-model="formEdit02.Dept_phone" placeholder="药品助记码" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="部门描述">
          <el-input v-model="formEdit02.Dept_describe" placeholder="药品规格" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="上级部门">
          <el-input v-model="formEdit02.Superior_dept" placeholder="药品单位" size="mini"></el-input>
        </el-form-item>

        <!--<el-form-item label="药品单价">
          <el-input v-model="formEdit02.DrugsPrice" placeholder="药品单价" size="mini"></el-input>
        </el-form-item>
        <el-form-item label="药品剂型">
          <el-select  placeholder="药品剂型" v-model="formEdit02.DrugsDosageID"
                      size="mini" >
            <el-option v-for="item in options01" :key="item.ID" :label="item.ConstantName" :value="item.ID">
              <span style="float: left">{{ item.ConstantName }}</span>
              <span style="float: right; color: #8492a6; font-size: 12px">{{ item.ConstantCode }}</span>
            </el-option>
          </el-select>
        </el-form-item>-->

        <!-- <el-form-item label="部门类型">
           <el-select  placeholder="部门类型类型" v-model="formEdit02.Dept_type" size="mini" >
             <el-option v-for="item in options02" :key="item.ID" :label="item.ConstantName" :value="item.ID"></el-option>
           </el-select>
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
      //增加对话框中，药品剂型下拉列表用户输入查询
      /* remoteMethod(query) {
         if (query !== '') {
           this.loading = false;
           setTimeout(() => {
             this.loading = false;
             this.options01 = this.options01.filter(item => {
               return item.ConstantCode.toLowerCase()
                 .indexOf(query.toLowerCase()) > -1;
             });
           }, 200);
         } else {
           let url = this.rootUrl +"/neusys/constantItem/listByType?keywords=Drugs_Dosage";
           this.getDrugDosageByConst(url);
         }
       },
       //远程加载"药品剂型"数据
       getDrugDosageByConst(url){
         let _this = this;
         getRequest(url).then(resp=> {
           let _this = this;
           _this.loading = false;
           if (resp.status == 200) {
             this.options01 = resp.data.list;
           } else {
             _this.$message({type: 'error', message: '数据加载失败!'});
           }
         }).catch(resp=> {
           //压根没见到服务器
           _this.loading = false;
           _this.$message({type: 'error', message: '数据加载失败!'});
         })
       },
       //远程加载"药品类型"数据
       getDrugTypeByConst(url){
         let _this = this;
         getRequest(url).then(resp=> {
           let _this = this;
           _this.loading = false;
           if (resp.status == 200) {
             this.options02 = resp.data.list;
           } else {
             _this.$message({type: 'error', message: '数据加载失败!'});
           }
         }).catch(resp=> {
           //压根没见到服务器
           _this.loading = false;
           _this.$message({type: 'error', message: '数据加载失败!'});
         })
       },
 */
      addNewData(formName){
        let _this = this;
        this.$refs[formName].validate((valid) => {
          if (valid) {
            postRequest(this.rootUrl +'/neupha/drug/', this.formEdit01).then(resp=> {
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

      //弹出修改药品对话框
      showEditDialog(index, row){
        this.dialogFormVisible02=true;

        this.formEdit02 = row;
      },
      //进行修改药品信息
      updateData(){
        let _this = this;
        putRequest(this.rootUrl +'/neupha/drug/', this.formEdit02).then(resp=> {
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
        this.$confirm('确认删除 \"' + row.Dept_name + '\" ?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.deleteData(row.Dept_id);
          this.showMsgTitle(this,"删除"+ row.Dept_name);
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
            ids += selItems[i].Dept_id + ",";
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
        deleteRequest(this.rootUrl +'/neupha/drug/' + ids).then(resp=> {
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
        let url = this.rootUrl +"/neupha/drug/listPage?pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&keywords01=" + keywords01 ;
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
            _this.$message({type: 'error', message: '数据加载失败1!'});
          }
        }).catch(resp=> {
          //压根没见到服务器
          _this.loading = false;
          _this.$message({type: 'error', message: '数据加载失败2!'});
        });


      },

    },
    data(){
      return {
        loading:false,
        loading:false,
        currentPage01:1,
        pageSize:10,
        totalCount:0,
        keywords01: '',
        selItems: [],
        categories: [{
          Dept_id:'1',   Dept_name:'财务处',   Dept_type:'财务',   Dept_phone:'80886',     Dept_describe:'无',    Superior_dept:'秘书处',
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
          //表单对象
          Dept_id:'',
          Dept_name:'',
          Dept_type:'',
          Dept_phone:'',
          Dept_describe:'',
          Superior_dept:'',
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
