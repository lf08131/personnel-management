import Vue from 'vue'
import Router from 'vue-router'

import Login from '@/components/Login'//登录

import Home from '@/components/Home' //主界面

import Entry   from '@/components/neureg/Entry'    //入职管理

import Cost     from '@/components/neufin/Cost'     //离职管理

import DiseCategory   from '@/components/neufin/DiseCategory.vue' //新品员工报表
import Scheduling_new from '@/components/neufin/Scheduling_new.vue' //离职员工报表
import em1 from '@/components/neupha/em1.vue'  //实习管理 delmark=2
import em2 from '@/components/neupha/em2.vue'  //实习转正 delmark=3
import em3 from '@/components/neupha/em3.vue'  //实习离职 delmark=4
import move from '@/components/neupha/move.vue'  //员工调动 delmark =1, 问题，岗位名没显示
import Post from '@/components/neupha/Post.vue'  // 岗位管理


import shop03 from '@/components/neupha/shop03.vue'  //部门管理

import User from '@/components/neusys/User'  //用户管理

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: '登录',
      hidden: true,
      component: Login,  //Login   Home
      meta: {
        isLogin: false
      }
    },
    {
      path: '/home',
      name: '',
      component: Home,
      hidden: true,
      meta: {
        isLogin: true
      }
    }, {
      path: '/home',
      component: Home,
      name:'员工管理',
      iconCls: 'fa fa-file-text-o',
      children: [
        {
          path: '/Entry',
          name: '入职管理',
          component: Entry,
          meta: {
            keepAlive: false,
            isLogin: true
          }
        },
        {
          path: '/Cost',
          name: '离职管理',
          component: Cost,
          meta: {
            keepAlive: false,
            isLogin: true
          }
        }
        ,
        {
          path: '/em1',
          name: '实习管理',
          component: em1,
          meta: {
            keepAlive: false,
            isLogin: true
          }
        }
        ,
        {
          path: '/em2',
          name: '实习转正',
          component: em2,
          meta: {
            keepAlive: false,
            isLogin: true
          }
        }
        ,
        {
          path: '/em3',
          name: '实习离职',
          component: em3,
          meta: {
            keepAlive: false,
            isLogin: true
          }
        }
        ,
        {
          path: '/move',
          name: '员工调动',
          component: move,
          meta: {
            keepAlive: false,
            isLogin: true
          }
        }
      ]
    },{
      path: '/home',
      component: Home,
      children: [
        {
          path: '/Post',
          name: '岗位管理',
          component: Post,
          meta: {
            keepAlive: false,
            isLogin: true
          }
        },
      ]
    },{
      path: '/home',
      component: Home,
      name: '报表管理',
      iconCls: 'fa fa-user-o',
      children: [
        {
          path: '/DiseCategory',
          name: '入职报表',
          component: DiseCategory,
          meta: {
            keepAlive: false,
            isLogin: true
          }
        },
        {
          path: '/Scheduling_new',
          name: '离职报表',
          component: Scheduling_new,
          meta: {
            keepAlive: false,
            isLogin: true
          }
        }
       ]},{
      path: '/home',
      component: Home,
      iconCls: 'fa fa-user-o',
      children: [
        {
          path: '/shop03',
          name: '部门管理',
          component: shop03,
          meta: {
            keepAlive: false,
            isLogin: true
          }
        }]
    }

      ,{
      path: '/home',
      component: Home,

      iconCls: 'fa fa-user-o',
      children: [
        {
          path: '/User',
          name: '用户管理',
          component: User,
          meta: {
            keepAlive: false,
            isLogin: true
          }
        }
      ]
    }
  ]
})
