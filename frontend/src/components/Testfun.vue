<template>
  <div>
    <el-tabs tab-position="top">
      <el-tab-pane label="创建设备">
        <el-form ref="createform" :model="createform" label-width="80px">
          <el-form-item label="设备ID">
            <el-input v-model="createform.client_id" placeholder="设备ID"></el-input>
          </el-form-item>
          <el-form-item label="设备名字">
            <el-input v-model="createform.client_name" placeholder="设备名字"></el-input>
          </el-form-item>
          <el-form-item label="设备描述">
            <el-input v-model="createform.client_declare" placeholder="设备描述"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-circle-plus" @click="createfun">创建设备</el-button>
            <el-button>取消</el-button>
          </el-form-item>
        </el-form>

        <el-table
          :data="allTable"
          stripe
          style="width: 100%">
          <el-table-column
            prop="client_id"
            label="设备id"
            width="300">
          </el-table-column>
          <el-table-column
            prop="client_name"
            label="设备名"
            width="300">
          </el-table-column>
          <el-table-column
            prop="client_declare"
            label="设备描述"
            width="500">
          </el-table-column>
        </el-table>
      </el-tab-pane>
      <el-tab-pane label="修改设备">
        <el-form ref="updateform" :model="updateform" label-width="80px">
          <el-form-item label="设备ID">
            <el-input v-model="updateform.client_id" placeholder="设备ID"></el-input>
          </el-form-item>
          <el-form-item label="设备名字">
            <el-input v-model="updateform.client_name" placeholder="设备名字"></el-input>
          </el-form-item>
          <el-form-item label="设备描述">
            <el-input v-model="updateform.client_declare" placeholder="设备描述"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-circle-plus" @click="updatefun">修改设备</el-button>
            <el-button>取消</el-button>
          </el-form-item>
        </el-form>

        <el-table
          :data="allTable"
          stripe
          style="width: 100%">
          <el-table-column
            prop="client_id"
            label="设备id"
            width="300">
          </el-table-column>
          <el-table-column
            prop="client_name"
            label="设备名"
            width="300">
          </el-table-column>
          <el-table-column
            prop="client_declare"
            label="设备描述"
            width="500">
          </el-table-column>
        </el-table>
      </el-tab-pane>
      <el-tab-pane label="删除设备">
        <el-form ref="deleteform" :model="deleteform" label-width="80px">
          <el-form-item label="设备ID">
            <el-input v-model="deleteform.client_id" placeholder="删除的设备ID"></el-input>
          </el-form-item>
          <el-form-item label="设备名字">
            <el-input v-model="deleteform.client_name" placeholder="删除的设备名字"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-delete" @click="deletefun">删除设备</el-button>
            <el-button>取消</el-button>
          </el-form-item>
        </el-form>

        <el-table
          :data="allTable"
          stripe
          style="width: 100%">
          <el-table-column
            prop="client_id"
            label="设备id"
            width="300">
          </el-table-column>
          <el-table-column
            prop="client_name"
            label="设备名"
            width="300">
          </el-table-column>
          <el-table-column
            prop="client_declare"
            label="设备描述"
            width="500">
          </el-table-column>
        </el-table>
      </el-tab-pane>
      <el-tab-pane label="查询设备记录">
        <el-form ref="form" :model="form" label-width="80px">
          <el-form-item label="设备名">
            <el-input v-model="form.client_id" placeholder="输入查询设备ID 必填项"></el-input>
          </el-form-item>
          <el-form-item label="数值区间">
            <el-input v-model="form.interval" placeholder="输入Value数值区间,格式例如：11~50"></el-input>
          </el-form-item>
          <el-form-item label="是否告警">
            <el-input v-model="form.is_alert" placeholder="输入是否告警,格式例如：是 或 否"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" @click="postfun">查找</el-button>
            <el-button>取消</el-button>
          </el-form-item>
        </el-form>

        <el-table
          :data="tableData1"
          stripe
          style="width: 100%">
          <el-table-column
            prop="client_id"
            label="设备名"
            width="180">
          </el-table-column>
          <el-table-column
            prop="info"
            label="设备信息"
            width="300">
          </el-table-column>
          <el-table-column
            prop="value"
            label="数值"
            width="180">
          </el-table-column>
          <el-table-column
            prop="alert"
            label="是否告警"
            width="180">
          </el-table-column>
          <el-table-column
            prop="lat"
            label="纬度"
            width="180">
          </el-table-column>
          <el-table-column
            prop="lng"
            label="经度"
            width="180">
          </el-table-column>
        </el-table>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import state from '../store/index'
import axios from 'axios'
import qs from "qs";

export default {
  name: "Test",
  mounted() {
    this.testfun()
    this.getall()
  },
  data() {
    return {
      name: '',
      age: '',
      tableData: [],
      tableData1: [],
      allTable: [],
      form: {
        name: "",
        age: "",
        client_id: '',
        interval: '',
        is_alert: "",
      },
      createform: {
        client_id: "",
        client_name: "",
        client_declare: "",
      },
      updateform: {
        client_id: "",
        client_name: "",
        client_declare: "",
      },
      deleteform: {
        client_id: "",
        client_name: "",
      },
      valueSwitch: false,
    }
  },
  methods: {
    testfun() {
      axios.get("/api/device/find_device/")
        .then(response => {
          //console.log(response)
          this.tableData = response.data
          console.log(this.tableData)
        }).catch(err => {
        this.$message.error("注册失败，请检查您的输入信息")
        console.log(err)
      })
    },
    postfun() {
      var postObj = JSON.parse(JSON.stringify(this.form))
      axios.post("/api/device/find_device/", postObj)
        .then(response => {
          console.log(response)
          this.tableData1 = response.data
        }).catch(err => {
        this.$message.error("注册失败，请检查您的输入信息")
        console.log(err)
      })
    },
    createfun() {
      var postObj = JSON.parse(JSON.stringify(this.createform))
      axios.post("/api/device/create_device/", postObj)
        .then(response => {
          console.log(response)
          this.allTable = response.data
        }).catch(err => {
        this.$message.error("创建失败")
        console.log(err)
      })
    },
    updatefun() {
      var postObj = JSON.parse(JSON.stringify(this.updateform))
      axios.post("/api/device/update_device/", postObj)
        .then(response => {
          console.log(response)
          this.allTable = response.data
        }).catch(err => {
        this.$message.error("创建失败")
        console.log(err)
      })
    },
    getall() {
      axios.get("/api/device/create_device/")
        .then(response => {
          //console.log(response)
          this.allTable = response.data
          console.log(this.allTable)
        }).catch(err => {
        this.$message.error("创建失败")
        console.log(err)
      })
    },
    deletefun() {
      var postObj = JSON.parse(JSON.stringify(this.deleteform))
      axios.post("/api/device/delete_device/", postObj)
        .then(response => {
          console.log(response)
          this.allTable = response.data
        }).catch(err => {
        this.$message.error("删除失败")
        console.log(err)
      })
    },
  }
}
</script>

<style scoped>

</style>
