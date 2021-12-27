<template>
  <div>
    <div class="total-class" id="myChart" :style="{width: '80%', height: '400px'}"></div>
    <div class="total-class" id="mygjChart" :style="{width: '80%', height: '400px'}"></div>
  </div>
</template>

<script>
import axios from 'axios'
import qs from "qs";

export default {
  name: "Picture",
  data() {
    return {
      msg: 'Welcome to Your Vue.js App',
      xdata: [],
      ydata: [],
      gjxdata:[],
      gjydata:[]
    }
  },
  mounted() {
    this.getdata()
    this.gjgetdata()
  },
  methods: {
    drawLine() {
      // 基于准备好的dom，初始化echarts实例
      let myChart = this.$echarts.init(document.getElementById('myChart'))
      // 绘制图表
      myChart.setOption({
        title: {text: '设备接受数据量'},
        tooltip: {},
        xAxis: {
          data: this.xdata
        },
        yAxis: {},
        series: [{
          name: 'value',
          type: 'bar',
          data: this.ydata
        }]
      });
    },
    getdata(){
      var colorList = ['#FFC367', '#5793F3', '#DA9CFF', '#27727B',
        '#5D84FF', '#C1232B', '#B5C334', '#FCCE10', '#E87C25',
        '#FE8463', '#9BCA63', '#FAD860', '#F3A43B', '#60C0DD',
        '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0'];
      axios.get("/api/device/get_device/")
        .then(response => {
          console.log(response)
          this.xdata = response.data.xdata
          this.ydata = response.data.ydata
          console.log(this.xdata)
          let myChart = this.$echarts.init(document.getElementById('myChart'))
          // 绘制图表
          myChart.setOption({
            title: {text: '设备接受数据量'},
            tooltip: {},
            color: colorList,
            xAxis: {
              data: this.xdata
            },
            yAxis: {},
            series: [{
              name: '数据量',
              type: 'bar',
              data: this.ydata
            }]
          });
        }).catch(err => {
        this.$message.error("获取x轴失败")
        console.log(err)
      })
    },
    gjgetdata(){
      var colorList = ['#26C0C0s', '#5793F3', '#DA9CFF', '#27727B',
        '#5D84FF', '#C1232B', '#B5C334', '#FCCE10', '#E87C25',
        '#FE8463', '#9BCA63', '#FAD860', '#F3A43B', '#60C0DD',
        '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0'];
      axios.get("/api/device/get_gjdevice/")
        .then(response => {
          console.log(response)
          this.gjxdata = response.data.xdata
          this.gjydata = response.data.ydata
          let myChart = this.$echarts.init(document.getElementById('mygjChart'))
          // 绘制图表
          myChart.setOption({
            title: {text: '设备接受告警数据量'},
            tooltip: {},
            color: colorList,
            xAxis: {
              data: this.gjxdata
            },
            yAxis: {},
            series: [{
              name: '告警数据量',
              type: 'bar',
              data: this.gjydata
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
