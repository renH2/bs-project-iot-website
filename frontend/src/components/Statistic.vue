<template>
  <el-tabs tab-position="top">
  <el-tab-pane label="查询地图数据">
    <el-form ref="form" :model="form" label-width="80px">
      <el-form-item label="设备名">
        <el-input v-model="form.client_id"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="postfun">查找</el-button>
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
</template>

<script>
import axios from 'axios'
import qs from "qs";
import Vue from 'vue';

export default {
  name: "Statistic",
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
      },
      createform: {
        client_id: "",
        client_name: "",
        client_declare: "",
      },
      deleteform: {
        client_id: "",
        client_name: "",
      },
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
