<template>
  <el-container >
    <el-aside style="width:40%;background:#fff">

      <el-row style="background-color: #EAF1F5">
        <el-col :span="12" style="margin-top: 4px;">
          <el-tag size="small">中医处方模板：</el-tag>
        </el-col>
        <el-col :span="4" >
          <el-button type="text" size="small" class="el-icon-circle-plus" @click="dialogTableVisible = true">新建模板</el-button>

          <el-dialog title="创建模板" :visible.sync="dialogTableVisible" label-width="80px">
            <el-form ref="form"  >
              <el-form-item label="上级菜单">
                <el-select  placeholder="请选择上级菜单" v-model="eltab02">
                  <el-option label="西药处方模板" value="neike"></el-option>
                  <el-option label="中药处方模板" value="menzen"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="模板名称">
                <el-input ></el-input>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="onSubmit">立即创建</el-button>
                <el-button @click="onSubmit">取消</el-button>
              </el-form-item>
            </el-form>
          </el-dialog>

        </el-col>
        <el-col :span="4" >
          <el-button type="text" size="small" class="el-icon-edit" >修改名称</el-button>
        </el-col>
        <el-col :span="4" >
          <el-button type="text" size="small" class="el-icon-delete">删除模板</el-button>
        </el-col>
      </el-row>
      <el-row style="margin-top: 10px;">
        模板范围：
        <el-radio v-model="radio01" label="1" >全院</el-radio>
        <el-radio v-model="radio01" label="2">科室</el-radio>
        <el-radio v-model="radio01" label="3">个人</el-radio>
      </el-row>
      <el-row>
        <el-input placeholder="输入模板名称" class="input-with-select">
          <el-button slot="append" icon="el-icon-search"></el-button>
        </el-input>
      </el-row>
      <el-row>
        <el-tree :data="treeData" :default-expanded-keys="[1]"  node-key="id" :expand-on-click-node="false" @node-click="nodeClick">
			            <span class="custom-tree-node" slot-scope="{ node, data }">
			                <span>{{node.label}}
                        <!--
                                <i class="el-icon-plus" @click.stop="() => add(data)"></i>
                                <i class="el-icon-edit-outline" @click.stop="() => edit(data)"></i>
                                <i class="el-icon-delete" @click.stop="() => remove(node,data)"></i>
                               -->
			                </span>
			            </span>
        </el-tree>
      </el-row>
    </el-aside>
    <el-main style="width:60%;background:#fff;height: 1200px;">
        <el-card class="box-card" style="margin-top: -20px;margin-left: -20px;">
          <div slot="header" class="clearfix">
            <span style="font-size: small;">处方明细</span>
            <el-button style="float: right; padding: 3px 0" type="text">保存处方</el-button>
            <el-button style="float: right; padding: 3px 0" type="text">删除药品</el-button>
            <el-button style="float: right; padding: 3px 0" type="text">增加药品</el-button>
          </div>
          <el-table :data="tableData03" style="width: 100%" :row-class-name="tableRowClassName" >
            <el-table-column type="selection" width="55"></el-table-column>
            <el-table-column property="mingcheng" label="药品名称" >
            </el-table-column>
            <el-table-column property="guige" label="规格" >
            </el-table-column>
            <el-table-column property="yongliang" label="用量" width="50">
            </el-table-column>
            <el-table-column property="danwei" label="单位" width="50">
            </el-table-column>
            <el-table-column property="pinci" label="频次" width="100">
            </el-table-column>
          </el-table>
        </el-card>
    </el-main>

  </el-container>
</template>

<script>
  export default {
    methods:{
      nodeClick:function (clickDate) {
        this.siteName = clickDate.label;
      },
      onSubmit:function(){
        this.dialogTableVisible=false;
      }
    },
    data() {
      return {
        siteName:"",
        radio01:1,
        dialogTableVisible: false,
        eltab01:'first',
        eltab02:'',

        treeData: [{
          id: 1,
          label: '病历模板',
          children: [{
            id: 11,
            label: '西药处方模板',
            children: [{
              id: 111,
              label: '慢性咽炎'
            }, {
              id: 112,
              label: '哮喘'
            }]
          },{
            id: 12,
            label: '中药处方模板',
            children: [{
              id: 121,
              label: '感冒'
            }, {
              id: 122,
              label: '滑囊炎'
            }]
          },{
            id: 13,
            label: '中西医处方模板',
            children: [{
              id: 131,
              label: '免疫力低下处方'
            }, {
              id: 132,
              label: '放射损伤处方'
            }]
          }]
        }],
        tableData03: [{
          mingcheng: '头孢拉定注射液',
          guige:'0.25ml*10支',
          danjia:'10/支',
          yongliang:'0.25',
          danwei:'ml',
          pinci:'一天一次',
          tianshu:'3',
          cishu:'3',
          shuliang:'3',
          danwei:'支',
          zhutuo:'需要皮试',
          jieguo:'查看'
        }, {
          mingcheng: '5%葡萄糖注射液',
          guige:'250ml*1袋',
          danjia:'2/袋',
          yongliang:'250',
          danwei:'ml',
          pinci:'一天一次',
          tianshu:'3',
          cishu:'3',
          shuliang:'3',
          danwei:'袋',
          zhutuo:'',
          jieguo:'查看'
        }, {
          mingcheng: '5%葡萄糖注射液',
          guige:'250ml*1袋',
          danjia:'2/袋',
          yongliang:'250',
          danwei:'ml',
          pinci:'一天一次',
          tianshu:'3',
          cishu:'3',
          shuliang:'3',
          danwei:'袋',
          zhutuo:'',
          jieguo:'查看'
        }],
      }
    }
  }
</script>

<style>
</style>
