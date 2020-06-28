<template>
  <!-- 1. 门诊病历 -->
	<el-container v-loading="loading">
    <!-- 页面弹窗 -->
    <el-dialog     title="添加西医诊断"    :visible.sync="dialog01Visible"   width="50%">
      <el-input placeholder="请输入疾病名称或ICD查询" v-model="inputSearchDis" class="input-with-select" style="width: 100%">
        <template slot="prepend">疾病名称：</template>
        <el-button slot="append" icon="el-icon-search" @click="searchDis('1')"></el-button>
      </el-input>
      <el-table :data="dialog01Table"    style="width: 100%" size="mini">
        <el-table-column prop="DiseaseICD" label="ICD编码" width="100px">
        </el-table-column>
        <el-table-column prop="DiseaseName" label="疾病名称" >
        </el-table-column>
        <el-table-column prop="DicaName" label="疾病类型" >
        </el-table-column>
        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <el-button type="primary"
                       size="mini"
                       @click="showInnerDialog(scope.$index, scope.row,'1')">选择
            </el-button>
          </template>
          <el-dialog width="30%" title="添加疾病详情" :visible.sync="innerVisible01" append-to-body center="center">
            <el-form label-width="100px" :model="MedicalDisease" class="demo-form-inline" size="mini">
              <el-form-item label="疾病名称">
                <el-input v-model="MedicalDisease.DiseaseName" placeholder="疾病名称" readonly="readonly" ></el-input>
              </el-form-item>
              <el-form-item label="发病日期">
                <div class="block">
                  <el-date-picker v-model="MedicalDisease.GetSiskDate" type="datetime" placeholder="选择日期时间，不选择默认为当前时间">
                  </el-date-picker>
                </div>
              </el-form-item>
              <el-form-item>
                <el-button type="danger" style="width: 100px;" @click="addDiseaseDetailed('1')">添加
                </el-button>
              </el-form-item>
            </el-form>
          </el-dialog>
        </el-table-column>
      </el-table>
      <el-col :span="24" align="right">
        <el-pagination
          background
          :page-size="pageSize" :current-page.sync="currentPage01"
          layout="prev, pager, next"
          :total="totalCount" @current-change="currentChange" v-show="this.WesternDiagnosis01.length>0 && this.inputSearchDis==''">
        </el-pagination>
      </el-col>
      <span slot="footer" class="dialog-footer">
      <el-button type="primary" @click="dialog01Visible = false" size="mini">关闭</el-button>
      </span>
    </el-dialog>

    <el-dialog      title="添加中医诊断"    :visible.sync="dialog02Visible" width="50%">
      <el-input placeholder="请输入疾病名称或ICD查询" v-model="inputSearchDis" class="input-with-select" style="width: 100%">
        <template slot="prepend">疾病名称：</template>
        <el-button slot="append" icon="el-icon-search" @click="searchDis('2')"></el-button>
      </el-input>
      <el-table :data="dialog02Table"    style="width: 100%" size="mini">
        <el-table-column prop="DiseaseICD" label="ICD编码" width="100px">
        </el-table-column>
        <el-table-column prop="DiseaseName" label="疾病名称" >
        </el-table-column>
        <el-table-column prop="DicaName" label="疾病类型" >
        </el-table-column>
        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <el-button type="primary"
                       size="mini"
                       @click="showInnerDialog(scope.$index, scope.row,'2')">选择
            </el-button>
          </template>
          <el-dialog width="30%" title="添加疾病详情" :visible.sync="innerVisible02" append-to-body center="center">
            <el-form  label-width="100px" :model="MedicalDisease" class="demo-form-inline" size="mini">
              <el-form-item label="疾病名称">
                <el-input v-model="MedicalDisease.DiseaseName" placeholder="疾病名称" readonly="readonly" ></el-input>
              </el-form-item>
              <el-form-item label="发病日期">
                <div class="block">
                  <el-date-picker v-model="MedicalDisease.GetSiskDate" type="datetime" placeholder="选择日期时间，不选择默认为当前时间" >
                  </el-date-picker>
                </div>
              </el-form-item>
              <el-form-item>
                <el-button type="danger" style="width: 100px;" @click="addDiseaseDetailed('2')">添加
                </el-button>
              </el-form-item>
            </el-form>
          </el-dialog>
        </el-table-column>
      </el-table>
      <el-col :span="24" align="right">
        <el-pagination
          background
          :page-size="pageSize" :current-page.sync="currentPage01"
          layout="prev, pager, next"
          :total="totalCount" @current-change="currentChange" v-show="this.WesternDiagnosis02.length>0">
        </el-pagination>
      </el-col>
      <span slot="footer" class="dialog-footer">
      <el-button @click="dialog02Visible = false">取 消</el-button>
      <el-button type="primary" @click="dialog02Visible = false">确 定</el-button>
      </span>
    </el-dialog>
    <!-- 页面正文 -->
		<el-main style="width:100%;background:#fff;height:800px;overflow-y: auto">
			<el-form ref="form" :model="medicalRecord01" label-width="80px" label-position="left" size="mini" >
				<el-row style="background-color: #EAF1F5;margin-top: -20px">
				  	<el-col :span="8" style="margin-top: 4px;">

			  		</el-col>
			  		<el-col :span="4" >
				    <el-button type="text" size="small" class="el-icon-tickets" @click="stageCheck">暂存</el-button>
				    </el-col>
			  		<el-col :span="4" >
				    <el-button type="text" size="small" class="el-icon-success" @click="saveCheck">提交</el-button>
				    </el-col>
			  		<el-col :span="4" >
				    <el-button type="text" size="small" class="el-icon-printer" :disabled="isSaved" @click="cleanCheck">清空所有</el-button>
				    </el-col>
			  		<el-col :span="4" >
				    <el-button type="text" size="small" class="el-icon-circle-plus-outline" @click="refMedicalRecord">刷新</el-button>
				   </el-col>
				</el-row>
				<el-tag>病史内容：</el-tag>
				<el-form-item label="主诉">
			    <el-input type="textarea" :rows="1" v-model="medicalRecord01.Readme" :disabled="isSaved"></el-input>
				</el-form-item>
				<el-form-item label="现病史">
			    <el-input type="textarea" :rows="2" v-model="medicalRecord01.Present" :disabled="isSaved"></el-input>
				</el-form-item>
				<el-form-item label="现病治疗情况">
			    <el-input type="textarea" :rows="2" v-model="medicalRecord01.PresentTreat" :disabled="isSaved"></el-input>
				</el-form-item>
        <el-form-item label="既往史">
          <el-input type="textarea" :rows="2" v-model="medicalRecord01.History" :disabled="isSaved"></el-input>
        </el-form-item>
				<el-form-item label="过敏史">
			    <el-input type="textarea" :rows="2" v-model="medicalRecord01.Allergy" :disabled="isSaved"></el-input>
				</el-form-item>
			  <el-form-item label="体格检查">
			    <el-input type="textarea" :rows="2" v-model="medicalRecord01.Physique" :disabled="isSaved"></el-input>
			  </el-form-item>
        <el-tag>评估/诊断：</el-tag>
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>西医诊断</span>
            <span v-show="medicalRecord01.CaseState!='2'">
            <el-button style="float: right; padding: 0px 3px" type="text" v-show="this.medicalRecord.MedicalDisease02.length<1"
                       @click="showDialog('1')">增加</el-button>
            <el-button style="float: right; padding: 0px 10px" type="text" v-show="this.medicalRecord.MedicalDisease02.length<1" :disabled="this.selItems.length==0"
                       @click="deleteDisa('1')">删除</el-button>
            </span>
           </div>
          <el-table :data="medicalRecord.MedicalDisease01"   style="width: 100%" size="mini" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55">
            </el-table-column>
            <el-table-column prop="DiseaseICD" label="ICD编码" width="150px">
            </el-table-column>
            <el-table-column prop="DiseaseName" label="名称" >
            </el-table-column>
            <el-table-column prop="GetSiskDate" label="发病时间" width="130px">
            </el-table-column>
          </el-table>
        </el-card>
        <el-card class="box-card">
          <div slot="header" >
            <span>中医诊断</span>
            <span v-show="medicalRecord01.CaseState!='2'">
            <el-button style="float: right; padding: 0px 3px" type="text" v-show="this.medicalRecord.MedicalDisease01.length<1"
                       @click="showDialog('2')">增加</el-button>
            <el-button style="float: right; padding: 0px 10px" type="text" v-show="this.medicalRecord.MedicalDisease01.length<1" :disabled="this.selItems.length==0"
                       @click="deleteDisa('2')" >删除</el-button>
            </span>
          </div>
          <el-table :data="medicalRecord.MedicalDisease02" style="width: 100%;" size="mini" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55">
            </el-table-column>
            <el-table-column prop="DiseaseICD" label="ICD编码" width="150px">
            </el-table-column>
            <el-table-column prop="DiseaseName" label="名称" >
            </el-table-column>
            <el-table-column prop="GetSiskDate" label="发病时间" width="130px">
            </el-table-column>
          </el-table>
        </el-card>
			  <el-form-item label="检查建议">
			    <el-input type="textarea" :rows="2" v-model="medicalRecord01.Proposal" :disabled="isSaved"></el-input>
			  </el-form-item>
        <el-form-item label="注意事项">
          <el-input type="textarea" :rows="2" v-model="medicalRecord01.Careful" :disabled="isSaved"></el-input>
        </el-form-item>
      </el-form>
      <el-button type="text" size="small" class="el-icon-success" @click="saveCheck">提交</el-button>
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
  mounted:function () {
  },
  methods: {
    showConfirm(msg) {
      showMsgConfirm(this, msg);
    },
    showMsg(msg) {
      showMsgTitle(this, msg);
    },

    //中西医对话框:1-西医   2-中医
    showDialog(type) {
      this.loading = true;
      this.loadDatas(1, this.pageSize, type);
      if(type=='1'){
        this.dialog01Visible = true;
      }else if(type=='2'){
        this.dialog02Visible = true;
      }
      this.keywords01 = type;
    },
    handleSelectionChange(val){
      this.selItems = val;
    },
    //删除诊断
    deleteDisa(type){
      if(type=='1'){
        for (let i = 0; i < this.selItems.length; i++) {
          for(let j=this.medicalRecord.MedicalDisease01.length-1;j>=0;j--){
            if(this.medicalRecord.MedicalDisease01[j].ID==this.selItems[i].ID){
              this.medicalRecord.MedicalDisease01.splice(j,1);
            }
          }
        }
      }else if(type=='2'){
        for (let i = 0; i < this.selItems.length; i++) {
          for(let j=this.medicalRecord.MedicalDisease02.length-1;j>=0;j--){
            if(this.medicalRecord.MedicalDisease02[j].ID==this.selItems[i].ID){
              this.medicalRecord.MedicalDisease02.splice(j,1);
            }
          }
        }
      }
    },
    //打开添加患者诊断疾病信息的“对话框”
    showInnerDialog(index,row,type){
      if(type=='1'){
        this.innerVisible01=true;
      }else if(type=='2'){
        this.innerVisible02=true;
      }
      this.MedicalDisease = row;
    },
    //添加疾病信息
    addDiseaseDetailed(type){
      if(typeof this.MedicalDisease.GetSiskDate == "undefined"){
        this.MedicalDisease.GetSiskDate = this.$options.filters.formatDateTime(new Date());
      }else{
        this.MedicalDisease.GetSiskDate = this.$options.filters.formatDateTime(this.MedicalDisease.GetSiskDate);
      }
      if(type=='1'){
        this.innerVisible01=false;
        this.medicalRecord.MedicalDisease01.push(this.MedicalDisease);
      }else if(type=='2'){
        this.innerVisible02=false;
        this.medicalRecord.MedicalDisease02.push(this.MedicalDisease);
      }
    },

    //暂存
    stageCheck() {
      this.stageOrSave('1');
    },
    //提交
    saveCheck() {
      this.isSaved = true;
      this.stageOrSave('2');
      this.$store.state.Register.VisitState='2';
      //保持病历信息
      sessionStorage.setItem("medicalRecord",JSON.stringify(this.sessionPatient));
    },
    //保存
    stageOrSave(type){
      if (this.loadSessionPatient()) {
        this.medicalRecodTo01();
        this.medicalRecord.RegistID = this.$store.state.Register.ID;
        this.medicalRecord.CaseNumber = this.sessionPatient.CaseNumber;
        this.medicalRecord.CaseState = type;
        if(this.medicalRecord.MedicalDisease01!=null && this.medicalRecord.MedicalDisease01.length>0){
          this.medicalRecord.MedicalDisease = [];
          for(let i=0;i<this.medicalRecord.MedicalDisease01.length;i++){
            this.medicalRecord.MedicalDisease.push({
              MedicalID:this.medicalRecord.ID,RegistID:this.$store.state.Register.ID,
              DiseaseID:this.medicalRecord.MedicalDisease01[i].ID,DiagnoseType:'1',
              GetSiskDate:this.medicalRecord.MedicalDisease01[i].GetSiskDate,DiagnoseCate:type
            });
          }
        }else if(this.medicalRecord.MedicalDisease02!=null && this.medicalRecord.MedicalDisease02.length>0) {
          this.medicalRecord.MedicalDisease = [];
          for (let i = 0; i < this.medicalRecord.MedicalDisease02.length; i++) {
            this.medicalRecord.MedicalDisease.push({
              MedicalID:this.medicalRecord.ID, RegistID:this.$store.state.Register.ID,
              DiseaseID: this.medicalRecord.MedicalDisease02[i].ID, DiagnoseType: '2',
              GetSiskDate: this.medicalRecord.MedicalDisease02[i].GetSiskDate, DiagnoseCate:type
            });
          }
        }
        this.medicalRecord.MedicalDisease = JSON.stringify(this.medicalRecord.MedicalDisease);
        // alert(this.medicalRecord.MedicalDisease);
        let _this = this;

        postRequest(this.rootUrl +'/neudoc/medical/saveCheck', this.medicalRecord).then(resp => {
          if (resp.status == 200) {
            let json = resp.data;
            _this.$message({type: json.status, message: json.msg});
          }
        });
      }else{
        this.isSaved = false;
      }
    },

    //清空
    cleanCheck() {
      this.medicalRecord01 = {};
      this.medicalRecord.MedicalDisease01 = [];
      this.medicalRecord.MedicalDisease02 = [];
    },

    nodeClick: function (clickDate) {
      this.form03.data02 = clickDate.label;
    },
    setMsgToMain: function () {
      this.form02.data01 = this.form03.data01;
      this.form02.data02 = this.form03.data02;
      this.form02.data05 = this.form03.data03;
      this.form02.data06 = this.form03.data04;
    },
    cleanMain(msg) {
      this.form02 = {};
      showMsgTitle(this, msg);
    },

    //查询疾病数据
    searchDis(DicaType){
      let url =this.rootUrl +this.rootUrl +"/neudoc/disease/getPage?DicaType=" + DicaType + "&keywords01=" + this.inputSearchDis;
      let _this = this;
      if(this.inputSearchDis==null || this.inputSearchDis==''){
        this.loadDatas(1, this.pageSize, DicaType);
      }else{
        getRequest(url).then(resp => {
          if (resp.status == 200) {
            if (DicaType == 1) {
              _this.dialog01Table = resp.data.list;
              _this.dialog02Table = [];
            } else {
              _this.dialog02Table = resp.data.list;
              _this.dialog01Table = [];
            }
          } else {
            _this.$message({type: 'error', message: '数据加载失败!'});
          }
        }, resp => {
          _this.loading = false;
          if (resp.response.status == 403) {
            _this.$message({type: 'error', message: resp.response.data});
          } else {
            _this.$message({type: 'error', message: '数据加载失败!'});
          }
        }).catch(resp => {
          //压根没见到服务器
          _this.loading = false;
          _this.$message({type: 'error', message: '数据加载失败!'});
        });
      }
    },
    //翻页
    currentChange(currentPage){
      this.currentPage01 = currentPage;
      this.loadDatas(currentPage, this.pageSize, this.keywords01);
    },
    //加载对话框--疾病数据
    loadDatas(pageNumber, pageSize, keywords01) {
      let _this = this;
      let url =this.rootUrl +this.rootUrl +"/neudoc/disease/listPage?pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&keywords01=" + keywords01;
      getRequest(url).then(resp => {
        _this.loading = false;
        if (resp.status == 200) {
          if (keywords01 == 1) {
            _this.dialog01Table = resp.data.list;
            _this.totalCount = resp.data.totalCount;
            _this.currentPage01 = pageNumber;
          } else {
            _this.dialog02Table = resp.data.list;
            _this.totalCount = resp.data.totalCount;
            _this.currentPage01 = pageNumber;
          }
        } else {
          _this.$message({type: 'error', message: '数据加载失败!'});
        }
      }, resp => {
        _this.loading = false;
        if (resp.response.status == 403) {
          _this.$message({type: 'error', message: resp.response.data});
        } else {
          _this.$message({type: 'error', message: '数据加载失败!'});
        }
      }).catch(resp => {
        //压根没见到服务器
        _this.loading = false;
        _this.$message({type: 'error', message: '数据加载失败!'});
      });
    },
    //刷新患者病历
    refMedicalRecord(){
      if(this.loadSessionPatient()){
        this.loadMedicalRecord(this.$store.state.Register.ID);
        // let a = this.medicalRecord.Present;
        //
        // this.$set(this.medicalRecord,'Present',a);
        // alert(this.medicalRecord.Present);
      }
    },
    //根据挂号ID，加载一条病历信息
    loadMedicalRecord(RegistID,type) {
      // alert(RegistID);
      let _this = this;
      if(RegistID==null || RegistID==''){
        RegistID = this.$store.state.Register.ID;
      }
      if(type==null || type==''){
        type = '1';
      }
      let url =this.rootUrl +this.rootUrl +"/neudoc/medical/getDataByCaseNumber?keywords01=" + RegistID+"&keywords02="+type;
      getRequest(url).then(resp => {
        if (resp.status == 200) {
          _this.medicalRecord01 = resp.data;
          if(resp.data.MedicalDisease!=null && resp.data.MedicalDisease.length>0 && resp.data.MedicalDisease[0].DiagnoseType=='1'){
            _this.medicalRecord.MedicalDisease01 = resp.data.MedicalDisease;
            _this.medicalRecord.MedicalDisease02 = [];
            for(let i=0;i<_this.medicalRecord.MedicalDisease01.length;i++){
              _this.medicalRecord.MedicalDisease01[i].GetSiskDate = this.$options.filters.formatDateTime(_this.medicalRecord.MedicalDisease01[i].GetSiskDate);
            }

          }else if(resp.data.MedicalDisease!=null && resp.data.MedicalDisease.length>0 && resp.data.MedicalDisease[0].DiagnoseType=='2'){
            _this.medicalRecord.MedicalDisease02 = resp.data.MedicalDisease;
            _this.medicalRecord.MedicalDisease01 = [];
            for(let i=0;i<_this.medicalRecord.MedicalDisease02.length;i++){
              _this.medicalRecord.MedicalDisease02[i].GetSiskDate = this.$options.filters.formatDateTime(_this.medicalRecord.MedicalDisease02[i].GetSiskDate);
            }

          }else{
            this.medicalRecord.MedicalDisease01 = [];
            this.medicalRecord.MedicalDisease02 = [];
          }
          if(this.medicalRecord01!=null && this.medicalRecord01.CaseState=='2'){
            this.isSaved = true;
            //保持病历信息
            sessionStorage.setItem("medicalRecord",JSON.stringify(this.medicalRecord01));
          }else{
            this.isSaved = false;
            //保持病历信息
            sessionStorage.setItem("medicalRecord",'{}');
          }
        } else {
          _this.$message({type: 'error', message: '数据加载失败01!'});
        }
      }, resp => {
        if (resp.response.status == 403) {
          _this.$message({type: 'error', message: resp.response.data});
        } else {
          _this.$message({type: 'error', message: '数据加载失败02!'});
        }
      }).catch(resp => {
        //产生异常
        this.medicalRecord.MedicalDisease01 = [];
        this.medicalRecord.MedicalDisease02 = [];
        _this.$message({type: 'error', message: '产生异常：'+resp});
      });
    },
    //加载患者
    loadSessionPatient() {
      let patstr = this.$store.state.Register;
      if (this.$store.state.Register.ID != null ) {
        this.sessionPatient = patstr;
        return true;
      } else {
        this.sessionPatient={};
        this.$message({type: 'info', message: '请选择患者'});
        return false;
      }
    },
    medicalRecodTo01(){
      this.medicalRecord.ID = this.medicalRecord01.ID;
      this.medicalRecord.Readme = this.medicalRecord01.Readme;
      this.medicalRecord.Present = this.medicalRecord01.Present;
      this.medicalRecord.PresentTreat = this.medicalRecord01.PresentTreat;
      this.medicalRecord.History = this.medicalRecord01.History;
      this.medicalRecord.Allergy = this.medicalRecord01.Allergy;
      this.medicalRecord.Proposal = this.medicalRecord01.Proposal;
      this.medicalRecord.Careful = this.medicalRecord01.Careful;
      this.medicalRecord.Physique = this.medicalRecord01.Physique;
      // this.medicalRecord.Readme = this.medicalRecord01.Readme;
      // this.medicalRecord.Readme = this.medicalRecord01.Readme;
    }
  },
  data() {
  	return {
      loading:false,

      currentPage01:1,
      pageSize:10,//页面数据
      totalCount:0,
      keywords01: '',//1-西医   2-中医
      inputSearchDis:'',

      dialog01Table:[],
      dialog02Table:[],
      selItems:[],

      MedicalDisease:{DiseaseName:'',MedicalID:'',DiseaseID:'',DiagnoseType:'',GetSiskDate:'',DiagnoseCate:'1',},

      //病历信息 -- sessionStorage中
      sessionPatient:{ID:'',CaseNumber:'',RegistID:'',Readme:'',Present:'',PresentTreat:'',History:'',Allergy:'',
        Physique:'',Proposal:'',Careful:'',CheckResult:'',Diagnosis:'',Handling:'',CaseState:''},

      sessionCheck:{},

      medicalRecord:{
        ID:'',CaseNumber:'',RegistID:'',Readme:'',Present:'',PresentTreat:'',History:'',Allergy:'',
        Physique:'',Proposal:'',Careful:'',CheckResult:'',Diagnosis:'',Handling:'',CaseState:'',
        MedicalDisease:[{ID:'',MedicalID:'',RegistID:'',DiseaseID:'',DiagnoseType:'',GetSiskDate:'',DiagnoseCate:''}], //回传疾病数据
        MedicalDisease01:[], //患者西医疾病诊断
        MedicalDisease02:[], //患者中医疾病诊断
      },
      medicalRecord01:{
        ID:'',CaseNumber:'',RegistID:'',Readme:'',Present:'',PresentTreat:'',History:'',Allergy:'',
        Physique:'',Proposal:'',Careful:'',CheckResult:'',Diagnosis:'',Handling:'',CaseState:'',
      },

      isSaved:false,

      dialog01Visible:false,
      innerVisible01:false,
      dialog02Visible:false,
      innerVisible02:false,

  		eltab01:'first',
  		eltab02:'first',
      dialogRadio01:'1',
      selectData02:[{
        keshi:'内科病历',
      },{
        keshi:'门诊病历',
      },{
        keshi:'融合病历',
      },],
      form02:{
        data01:'',
        data02:'',
        data03:'',
        data04:'',
        data05:'',
        data06:'',
      },
      form03:{
        data01:'',
        data02:'',
        data03:'',
        data04:'',
      },
      WesternDiagnosis01: [{
        icd: 'A28.051',
        name: '巴斯德菌病',
        baddate: '2018-3-12'
      }, {
        icd: 'A23.052',
        name: '地中海热',
        baddate: '2018-7-5'
      }, {
        icd: 'A23.052',
        name: '地中海热',
        baddate: '2018-10-23'
      }],
      WesternDiagnosis02: [{
        icd: 'ZBFM21',
        name: '风湿化热证',
        baddate: '2018-3-12'
      }, {
        icd: 'ZBHM40',
        name: '寒湿瘀郁证',
        baddate: '2018-7-5'
      }, {
        icd: 'ZBHM40',
        name: '寒湿瘀郁证',
        baddate: '2018-10-23'
      }],
      treeData: [{
            id: 1,
            label: '病历模板',
            children: [{
                id: 11,
                label: '内科病历模板',
                children: [{
                    id: 111,
                    label: '慢性咽炎病历'
                }, {
                    id: 112,
                    label: '哮喘病历'
                }]
            },{
                id: 12,
                label: '门诊病历模板',
                children: [{
                    id: 121,
                    label: '感冒病历'
                }, {
                    id: 122,
                    label: '滑囊炎病历'
                }]
            },{
                id: 13,
                label: '融合病历模板',
                children: [{
                    id: 131,
                    label: '免疫力低下'
                }, {
                    id: 132,
                    label: '放射损伤'
                }]
            }]
        }],
      tableData4: [{
        name: '巴斯德菌病',
      }, {
        name: '感冒',
      }, {
        name: '咽炎',
      }],
      tableData5: [{
        name: '风湿化热证',
      }, {
        name: '寒湿瘀郁证',
      }, {
        name: '巴斯德菌病',
      }]
  	}
  }
}
</script>

<style>
</style>
