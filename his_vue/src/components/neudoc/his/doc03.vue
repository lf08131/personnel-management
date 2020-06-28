<template>
  <div class="container" >
    <!-- 3.检验申请 -->
    <el-container direction="horizontal">
      <!-- 页面弹窗 -->
      <el-dialog
        title="新增检验申请"
        :visible.sync="dialog01Visible"
        width="30%">
        <el-form size="mini">
          <el-form-item>
            <el-input placeholder="请输入内容"  class="input-with-select" style="width: 100%">
              <template slot="prepend">检验名称：</template>
              <el-button slot="append" icon="el-icon-search"></el-button>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-table border :data="tableData02" size="mini">
              <el-table-column prop="choose02" label="" width="30px">
                <template slot-scope="scope">
                  <input type="radio" name="chooseOne02" />
                </template>
              </el-table-column>
              <el-table-column property="feilei" label="分类" width="80">
              </el-table-column>
              <el-table-column property="xiangmu" label="项目" >
              </el-table-column>
            </el-table>
          </el-form-item>
          <el-form-item label="检验科室" >
            <el-select  placeholder="请选择">
              <el-option
                v-for="item in selectData01"
                :key="item.keshi"
                :label="item.keshi"
                :value="item.keshi">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="是否加急：" >
            <el-switch
              v-model="switch01"
              active-color="#13ce66">
            </el-switch>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="dialog01Visible = false">确 定</el-button>
            <el-button @click="dialog01Visible = false">取 消</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>


      <!-- 页面正文 -->
      <el-aside  style="width: 700px;height: 500px;">

        <el-row style="background-color: #EAF1F5">
          <el-col :span="8" style="margin-top: 4px;">
            <el-tag size="mini">本项目金额合计：</el-tag>
            <el-tag type="warning" size="mini">235.00元</el-tag>
          </el-col>
          <el-col :span="3"><el-button type="text" size="mini" class="el-icon-circle-plus" @click="dialog01Visible=true">新增项目</el-button></el-col>
          <el-col :span="3"><el-button type="text" size="mini" class="el-icon-remove" @click="showConfirm('删除选择的检验项目')">删除项目</el-button></el-col>
          <el-col :span="2"><el-button type="text" size="mini" class="el-icon-tickets" @click="showMsg('暂存')">暂存</el-button></el-col>
          <el-col :span="2"><el-button type="text" size="mini" class="el-icon-success" @click="showConfirm('使科室收到开立的检验项目')">开立</el-button></el-col>
          <el-col :span="3"><el-button type="text" size="mini" class="el-icon-delete" @click="showConfirm('已经开立的检验项目作废')">作废</el-button></el-col>
          <el-col :span="3"><el-button type="text" size="mini" class="el-icon-circle-plus-outline" @click="showConfirm('选择的检验项设为常用')">存为常用</el-button></el-col>
        </el-row>

        <el-form ref="form"  label-width="80px">
          <el-row>
            <el-col :span="2" style="margin-top: 40px;">
              <el-input type="textarea" :rows="4" :disabled="true" style="width: 45px;" v-model="msg01">

              </el-input>
            </el-col>
            <el-col :span="22" style="margin-top: 4px;">
              <el-table ref="singleTable" :data="tableData02"
                        style="width: 100%;margin: 0px;padding: 0px;" :show-header="true">
                <el-table-column  type="selection">
                </el-table-column>
                <el-table-column property="feilei" label="分类" width="80">
                </el-table-column>
                <el-table-column property="xiangmu" label="项目" >
                </el-table-column>
                <el-table-column property="keshi" label="执行科室" width="80">
                </el-table-column>
                <el-table-column property="jiaji" label="加急" width="50">
                </el-table-column>
                <el-table-column property="zhuangtai" label="状态" width="80">
                </el-table-column>
                <el-table-column property="danjia" label="单价" width="80">
                </el-table-column>
                <el-table-column property="jieguo" label="检验结果" width="80">
                  <template slot-scope="scope">
                    <el-popover
                      placement="right"
                      width="400"
                      trigger="click">
                      <img src="static/imgs/img01.jpg"></img>
                      <el-button slot="reference" type="text" size="mini">查看</el-button>
                    </el-popover>

                  </template>
                </el-table-column>

              </el-table>
            </el-col>
          </el-row>

          <el-row>
            <el-form-item label="目的要求">
              <el-input type="textarea" :rows="4" placeholder="【检验目的：】【患者主诉：】【现病史：】"></el-input>
            </el-form-item>
          </el-row>

        </el-form>
      </el-aside>
      <el-main style="margin-top: -20px;">
        <el-tabs type="card" v-model="activeName">
          <el-tab-pane label="常用项目" name="second" >

            <el-table :data="tableData04" style="width: 100%" ref="singleTable" >
              <el-table-column prop="name" label="名称">
              </el-table-column>
              <el-table-column fixed="right" label="操作" width="120">
                <template slot-scope="scope">
                  <el-button @click.native.prevent="showConfirm('添加该项目')"
                             type="text" size="small">
                    使用
                  </el-button>
                  <el-button @click.native.prevent="showConfirm('从常用中删除该项目')"
                             type="text" size="small">
                    移除
                  </el-button>
                </template>
              </el-table-column>
            </el-table>
          </el-tab-pane>

        </el-tabs>
      </el-main>
    </el-container>

  </div>
</template>

<script>
  import {showMsgTitle} from '../../../utils/api'
  import  {showMsgConfirm} from '../../../utils/api'
  export default {
    methods: {
      showConfirm(msg) {
        showMsgConfirm(this, msg);
      },
      showMsg(msg) {
        showMsgTitle(this, msg);
      }
    },
    data() {
      return {
        dialog01Visible:false,
        switch01:false,

        msg01:'检验项目',
        tableData02:[{
          feilei:'尿常规',
          xiangmu:'尿蛋白指标',
          keshi:'检验科',
          jiaji:'是',
          zhuangtai:'已开立',
          danjia:'20.00',
        },{
          feilei:'血常规',
          xiangmu:'白细胞指标',
          keshi:'检验科',
          jiaji:'否',
          zhuangtai:'新建',
          danjia:'36.00',
        },{
          feilei:'心电图',
          xiangmu:'心电图',
          keshi:'外科',
          jiaji:'是',
          zhuangtai:'已完成',
          danjia:'10.00',
        }],
        tableData03:[{
          name:'尿常规检验单'
        },{
          name:'血常规检验单'
        },{
          name:'心率检验单'
        }],
        tableData04:[{
          name:'尿常规'
        },{
          name:'血常规'
        },{
          name:'心电图'
        }],
        selectData01:[{
          keshi:'心电图科',
        },{
          keshi:'放射科',
        },{
          keshi:'超声诊断科',
        },{
          keshi:'医学影像科',
        }],

        activeName: 'second',

      }
    }
  }
</script>

<style scoped>
</style>
