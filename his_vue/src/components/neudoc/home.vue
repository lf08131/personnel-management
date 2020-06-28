<template>
	<el-container style="height: 950px; border: 1px solid #eee">
  		<el-aside width="350px" v-if="showMenu">
        <el-container >
        	<!--   患者选择区      -->
        	<el-header style="padding: 0;margin: 0">
            <el-row>
              <el-col :span="12" style="text-align: left">
                <el-tag size="mini" style="width: 100%;">患者选择：</el-tag>
              </el-col>
              <el-col :span="12" style="text-align: right">
                <el-button type="primary" icon="el-icon-refresh" size="mini" @click="reloadUser" style="margin-right: 5px"></el-button>
              </el-col>
            </el-row>
            <el-row>
              <el-input placeholder="请输入内容" v-model="inputPatient" class="input-with-select" style="width: 100%" size="mini">
                <template slot="prepend">患者名：</template>
                <el-button slot="append" icon="el-icon-search" ></el-button>
              </el-input>
            </el-row>
        	</el-header>
        	<el-main style="height: 800px;padding: 0;margin: 0">
        		<el-tabs type="border-card" >
	            <el-tab-pane label="本人" >
	            	<el-tag size="mini" style="width: 100%">未诊患者：</el-tag>
					<el-table ref="singleTable" :data="RegistersTable01" highlight-current-row @row-click="handleCurrentChange01"
					    style="width: 100%;height: 50%" :show-header="false" max-height="400" size="mini">
					    <el-table-column property="CaseNumber" label="病历号" width="80">
					    </el-table-column>
					    <el-table-column property="RealName" label="姓名" >
					    </el-table-column>
					    <el-table-column property="Age" label="年龄" width="50">
					    </el-table-column>
					</el-table><br/><br/>
					<el-tag size="mini" style="width: 100%">已诊患者：</el-tag>
					<el-table ref="singleTable" :data="RegistersTable02" @row-click="handleCurrentChange02"
					    style="width: 100%;height: 50%" :show-header="false" size="mini">
					    <el-table-column property="CaseNumber" label="病历号" width="80">
					    </el-table-column>
					    <el-table-column property="RealName" label="姓名" >
					    </el-table-column>
					    <el-table-column property="Age" label="年龄" width="50">
					    </el-table-column>
					</el-table>
	            </el-tab-pane>
	            <el-tab-pane label="科室*">
					<el-tag>未诊患者：</el-tag>

					<el-table ref="singleTable" :data="MyPatientsData01" highlight-current-row
					    style="width: 100%;height: 50%" :show-header="false" size="mini">
            <el-table-column property="CaseNumber" label="病历号" width="80">
            </el-table-column>
            <el-table-column property="RealName" label="姓名" >
            </el-table-column>
            <el-table-column property="Age" label="年龄" width="50">
            </el-table-column>
					</el-table>
					 <el-tag>已诊患者：</el-tag>
					<el-table ref="singleTable" :data="MyPatientsData02"
					    style="width: 100%;height: 50%" :show-header="false" size="mini">
            <el-table-column property="CaseNumber" label="病历号" width="80">
            </el-table-column>
            <el-table-column property="RealName" label="姓名" >
            </el-table-column>
            <el-table-column property="Age" label="年龄" width="50">
            </el-table-column>
					</el-table>
	            </el-tab-pane>
	        	</el-tabs>
        	</el-main>
        </el-container>
       </el-aside>

    	<el-container direction="vertical" style="height: 950px">
    		<el-row>
    		<el-button type="primary" plain @click="showHideMenu(false)" :span="2" size="mini">
			          	{{patientsButtonText}}
			</el-button>
			<span style="margin-left: 20px;font-size: small;" :span="20">{{showPatientsTop}}</span>
			<el-button type="text" size="small" style="float: right;margin-right: 20px;" @click="endRegister" v-if="showStop" :span="2">诊毕</el-button>

			</el-row>
    		<!--<el-breadcrumb separator="/" style="padding:10px;border:1px solid #ddd;background:#fff;margin-bottom:1px;">
	            <el-breadcrumb-item>请选择患者</el-breadcrumb-item>
	        </el-breadcrumb>-->
	       <!--
           	门诊主要功能区
           -->
	        <el-tabs type="border-card" :before-leave="toTab">
	            <!-- 患者检查填写  -->
	            <el-tab-pane label="病历首页">
	            	<vDoctorA ref="doc01" ></vDoctorA>
	            </el-tab-pane>
	            <!-- 医生给患者根据病历要求患者进行的检查项：一般无比对标准，如B超 -->
	            <el-tab-pane label="检查申请" :lazy="true">
	            	<vDoctorB></vDoctorB>
	            </el-tab-pane>
	            <!-- 医生给患者根据病历要求患者进行的检验项：一般有比对标准，如血常规 -->
	            <el-tab-pane label="检验申请*" :lazy="true">
	            	<vDoctorC></vDoctorC>
	            </el-tab-pane>
	             <!-- 患者病历填写  -->
	        	  <el-tab-pane label="门诊确诊*" :lazy="true">
	            	<vDoctorD></vDoctorD>
	            </el-tab-pane>
	            <!-- 医生给患者根据病历要求患者进行的处置项：一般有治疗作用，如洗胃 -->
	            <el-tab-pane label="处置申请*" :lazy="true">
	            	<vDoctorE></vDoctorE>
	            </el-tab-pane>
	            <!-- 医生给患者根据病历开具处方、药品和使用配套器材 -->
	            <el-tab-pane label="成药处方" :lazy="true">
	            	<vDoctorF></vDoctorF>
	            </el-tab-pane>
	            <el-tab-pane label="草药处方*" :lazy="true">
	            	<vDoctorG></vDoctorG>
	            </el-tab-pane>
	            <el-tab-pane label="费用查询*" :lazy="true">
	            	<vDoctorH></vDoctorH>
	            </el-tab-pane>

	        </el-tabs>
    	</el-container>
    </el-container>
</template>
<style>


</style>

<script>

import vDoctorA from './his/doc01.vue';
import vDoctorB from './his/doc02.vue';
import vDoctorC from './his/doc03.vue';
import vDoctorD from './his/doc04.vue';
import vDoctorE from './his/doc05.vue';
import vDoctorF from './his/doc06.vue';
import vDoctorG from './his/doc07.vue';
import vDoctorH from './his/doc08.vue';

import {postRequest}   from '../../utils/api'
import {putRequest}    from '../../utils/api'
import {deleteRequest} from '../../utils/api'
import {getRequest}    from '../../utils/api'

export default {
  name: 'tabpage',
  components: {
      vDoctorA,vDoctorB,vDoctorC,vDoctorD,vDoctorE,vDoctorF,vDoctorG,vDoctorH,
  },
  mounted:function () {
    this.showFirstStateRegisters();
    this.showSecondStateRegisters();
    sessionStorage.removeItem('patientsObj');
  },
  methods: {
    toTab(activeName,oldActiveName){
      if(activeName>0){
        if(this.$store.state.Register==null || this.$store.state.Register==''){
          this.$message({type:'error',message:"需要先选择要诊治的患者"});
          return false;
        }
        let vs = this.$store.state.Register.VisitState;
        if(vs==null || vs==''||vs!='2'){
          this.$message({type:'error',message:"需要先将 病历首页 提交后，进行操作"});
          return false;
        }
      }
    },
    //诊毕
    endRegister(){
      this.$confirm('确认诊毕：'+this.$store.state.Register.RealName, '提示', {
        type: 'warning',
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(()=> {
        let _this = this;
        let url =this.rootUrl +this.rootUrl +"/neudoc/medical/endCheck?registID="+this.$store.state.Register.ID+"&visitState=3&caseState=3";
        getRequest(url).then(resp=>{
          if(resp.status == 200){
            _this.reloadUser();
            _this.$message({type:resp.data.status,message:this.$store.state.Register.RealName+'诊毕'});
          }
        }).catch(resp=>{
          _this.$message({type:'error',message:'数据加载失败！'});
        });
      }).catch(() => {
        this.$message({type: 'info',message: '取消'});
      });

    },

    //刷新患者
    reloadUser(){
      this.showFirstStateRegisters();
      this.showSecondStateRegisters();
      sessionStorage.removeItem('patientsObj');
      this.showPatientsTop='';
    },
    // 显示/隐藏
    showHideMenu() {
      this.showMenu = !this.showMenu;
      if (this.showMenu) {
        this.patientsButtonText = "隐藏患者栏";
      } else {
        this.patientsButtonText = "显示患者栏";
      }
    },
    //保存选择的 患者信息 到Vuex中
    handleCurrentChange01(val, column, event) {
      this.showPatientsTop = "患者姓名：" + val.RealName + "  病历号：" + val.CaseNumber + "  年龄：" + val.Age + "  性别："+this.$options.filters.formatConstant(val.Gender);
      this.$store.state.Register = val;
      this.$refs.doc01.loadMedicalRecord(val.ID,1);
      this.showStop = true;
    },
    //保存选择的 患者信息 到sessionStorage和Vuex中
    handleCurrentChange02(val, column, event) {
      this.showPatientsTop = "患者姓名：" + val.RealName + "  病历号：" + val.CaseNumber + "  年龄：" + val.Age + "  性别："+this.$options.filters.formatConstant(val.Gender);
      sessionStorage.setItem('patientsObj',JSON.stringify(val));
      this.$store.state.Register = val;

      this.$refs.doc01.loadMedicalRecord(val.ID,2);
      this.showStop = true;
    },

    //加载“1.已挂号”状态的患者,不分页
    showFirstStateRegisters(){
      let _this = this;
      let url =this.rootUrl +this.rootUrl +"/neureg/register/listStateRegisters?keywords02=1";
      getRequest(url).then(resp=>{
        if(resp.status == 200){
          _this.RegistersTable01 = resp.data ;
        }else{
          _this.RegistersTable01.RealName = '没有数据';
        }
      }).catch(resp=>{
        _this.$message({type:'error',message:'数据加载失败！'});
      });
    },

    //加载“2.医生接诊”状态的患者,不分页
    showSecondStateRegisters(){
      let _this = this;
      let url =this.rootUrl +this.rootUrl +"/neureg/register/listStateRegisters?keywords02=2";
      getRequest(url).then(resp=>{
        if(resp.status == 200){
          _this.RegistersTable02 = resp.data ;
        }else{
          _this.RegistersTable02.RealName = '没有数据';
        }
      }).catch(resp=>{
        _this.$message({type:'error',message:'数据加载失败！'});
      });
    },
  },
  data() {
    return {
      RegistersTable01:[{ID:'',RealName:'',Gender:'',IDnumber:'',BirthDate:'',Age:'',AgeType:'',
        HomeAddress:'',CaseNumber:'',VisitDate:'',Noon:'',DeptId:'',UserId:'',RegistLeID:'',
        SettleId:'',IsBook:'',RegistTime:'',RegisterID:'',VisitState:''}],
      RegistersTable02:[{ID:'',RealName:'',Gender:'',IDnumber:'',BirthDate:'',Age:'',AgeType:'',
        HomeAddress:'',CaseNumber:'',VisitDate:'',Noon:'',DeptId:'',UserId:'',RegistLeID:'',
        SettleId:'',IsBook:'',RegistTime:'',RegisterID:'',VisitState:''}],


          inputPatient:'',
        	showStop:false,
        	showMenu: true,
        	patientsButtonText:'隐藏患者栏',
        	showPatientsTop:'请选择患者',
        	MyPatientsData01: [{
            CaseNumber: '01212124545',
            RealName: '易慧丹',
            Age: '32'
	        }, {
            CaseNumber: '01212124546',
            RealName: '桂龙成',
            Age: '45'
	        }, {
            CaseNumber: '01212124547',
            RealName: '董晨发',
            Age: '21'
	        }],
	        MyPatientsData02: [{
            CaseNumber: '01212124542',
            RealName: '张金龙',
            Age: '45'
	        }, {
            CaseNumber: '01212124543',
            RealName: '王玉荣',
            Age: '47'
	        }, {
            CaseNumber: '01212124544',
            RealName: '邓桂英',
            Age: '29'
	        }],
        	form01: {
	          MedicalNo: '',
	          region: '',
	          date1: '',
	          date2: '',
	          delivery: false,
	          type: [],
	          resource: '',
	          desc: ''
	        },
	        form02: {
	          MedicalNo: '',
	          region: '',
	          date1: '',
	          date2: '',
	          delivery: false,
	          type: [],
	          resource: '',
	          desc: ''
	        },
            defaultProps: {
                children: 'children',
                label: 'label'
            }
        }
    },
}
</script>
