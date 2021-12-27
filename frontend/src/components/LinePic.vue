<template>
  <div>
  <el-form ref="lineform" :model="lineform" label-width="80px">
    <el-form-item label="设备ID">
      <el-input v-model="lineform.client_id" placeholder="输入设备ID"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" icon="el-icon-circle-plus" @click="getdata">查看设备</el-button>
      <el-button>取消</el-button>
    </el-form-item>
  </el-form>
    <div class="total-class" id="myChart" :style="{width: '80%', height: '400px'}"></div>
  </div>
</template>

<script>
import axios from 'axios'
import qs from "qs";

export default {
  name: "LinePic",
  data() {
    return {
      msg: 'Welcome to Your Vue.js App',
      xdata: [],
      ydata: [],
      lineform: {
        client_id: ""
      }
    }
  },
  mounted() {
  },
  methods: {
    drawLine() {
      // 基于准备好的dom，初始化echarts实例
      let myChart = this.$echarts.init(document.getElementById('myChart'))
      // 绘制图表
      myChart.setOption({
        title: {text: '设备value'},
        tooltip: {},
        xAxis: {
          data: this.xdata
        },
        yAxis: {},
        series: [{
          name: 'value',
          type: 'line',
          data: this.ydata
        }]
      });
    },
    getdata() {
      var postObj = JSON.parse(JSON.stringify(this.lineform))
      var colorList = ['#FFC367', '#5793F3', '#DA9CFF', '#27727B',
        '#5D84FF', '#C1232B', '#B5C334', '#FCCE10', '#E87C25',
        '#FE8463', '#9BCA63', '#FAD860', '#F3A43B', '#60C0DD',
        '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0'];

      axios.post("/api/device/get_device_value/",postObj)
        .then(response => {
          console.log(response)
          this.xdata = response.data.xdata
          this.ydata = response.data.ydata
          console.log(this.xdata)
          let myChart = this.$echarts.init(document.getElementById('myChart'))
          // 绘制图表
          myChart.setOption({
            title: {text: '设备value'},
            tooltip: {},
            color: colorList,
            xAxis: {
              data: this.xdata
            },
            yAxis: {},
            series: [{
              name: 'value',
              type: 'line',
              data: this.ydata
            }]
          });
        }).catch(err => {
        this.$message.error("获取x轴失败")
        console.log(err)
      })
    },
  }
}
</script>

<style scoped>

</style>
