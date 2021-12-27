<template>
  <div class="disp_map_file">
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
<!--        <el-button>取消</el-button>-->
        <el-button type="primary" icon="el-icon-search" @click="postfuntotal">显示告警设备</el-button>
      </el-form-item>
    </el-form>

<!--    <div>-->
<!--      <el-button @click="testchart">测试echart</el-button>-->
<!--    </div>-->

    <div style="margin-bottom: 1%;margin-top: 2%">
      <el-form label-position="left">
        <el-form-item label="地图操作">
          <el-button @click="bmapObj.zoomIn()" style="float: right; margin-right: 5%">放大</el-button>
          <el-button @click="bmapObj.zoomOut()" style="float: right; margin-right: 3%">缩小</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div style="height: 80%;width: 80% ; margin-left: 3%;">
      <div id="dispMap" ref="chart"></div>
    </div>
  </div>

</template>

<script>
import axios from 'axios'
import qs from 'qs'
import Vue from 'vue';
import state from '../store/index'

import "echarts/extension/bmap/bmap"

export default {

  mounted() {
  },

  computed: {

    mapData() {
      return state.getters.getMapData
    },
    hasLogin() {
      return state.getters.hasLogin
    },
    userInfo() {
      return state.getters.userInfo
    }
  },
  data: function () {
    return {
      myChart: null,

      collapse: null,
      chartData: null,
      bmapObj: null,
      msgData: null,
      checkList: [],
      form: {
        name: "",
        age: "",
        client_id: '',
      },
      reqLen: 8,

      reqForm: {
        clientId: null,
        topics: null,
        valueInterval: [1, 100],
        alert: null,
        lonInterval: [0, 180.0],
        latInterval: [0, 180.0],
        timestampInterval: [new Date(), new Date()]
      },
      valueSwitch: false,
      lonSwitch: false,
      latSwitch: false,
      timestampSwitch: false,
      testSwitch: false,

    }

  },
  methods: {
    handleClick() {
      console.log('asd');
    },
    postfun() {
      var postObj = JSON.parse(JSON.stringify(this.form))
      axios.post("/api/device/get_chart_value/", postObj)
        .then(data => {
          console.log(data.data)
          data = data.data
          var points = [].concat.apply([], data.map(function (track) {
            return track.map(function (seg) {
              return seg.coord.concat([1]);
            });
          }));
          console.log(points)
          state.commit('setMapData', points)
          this.myChart = this.$echarts.init(this.$refs.chart);
          this.myChart.setOption(this.generateOption(this.mapData));
          var bmap = this.myChart.getModel().getComponent('bmap').getBMap();
          this.bmapObj = bmap;
          bmap.disableScrollWheelZoom();
          bmap.disableDoubleClickZoom();
          bmap.disablePinchToZoom();
          bmap.enableAutoResize();
        })
    },
    postfuntotal() {
      var postObj = JSON.parse(JSON.stringify(this.form))
      axios.post("/api/device/get_chart_value_alter/", postObj)
        .then(data => {
          console.log(data.data)
          data = data.data
          var points = [].concat.apply([], data.map(function (track) {
            return track.map(function (seg) {
              return seg.coord.concat([1]);
            });
          }));
          console.log(points)
          state.commit('setMapData', points)
          this.myChart = this.$echarts.init(this.$refs.chart);
          this.myChart.setOption(this.generateOption1(this.mapData));
          var bmap = this.myChart.getModel().getComponent('bmap').getBMap();
          this.bmapObj = bmap;
          bmap.disableScrollWheelZoom();
          bmap.disableDoubleClickZoom();
          bmap.disablePinchToZoom();
          bmap.enableAutoResize();
        })
    },
    testchart() {
      // 通过ref初始化容器
      var ROOT_PATH = 'https://cdn.jsdelivr.net/gh/apache/echarts-website@asf-site/examples';
      axios.get(ROOT_PATH + '/data/asset/data/hangzhou-tracks.json')
        .then(data => {
          console.log(data.data)
          data = data.data
          var points = [].concat.apply([], data.map(function (track) {
            return track.map(function (seg) {
              return seg.coord.concat([1]);
            });
          }));
          console.log(points)
          state.commit('setMapData', points)
          this.myChart = this.$echarts.init(this.$refs.chart);
          this.myChart.setOption(this.generateOption(this.mapData));
          var bmap = this.myChart.getModel().getComponent('bmap').getBMap();
          this.bmapObj = bmap;
          bmap.disableScrollWheelZoom();
          bmap.disableDoubleClickZoom();
          bmap.disablePinchToZoom();
          bmap.enableAutoResize();
        })

    },

    testMyData() {
      this.formSubmit()
        .then(data => {
          data = data.data.data
          var points = this.convertData(data)
          console.log(points)
          state.commit('setMapData', points)
          this.myChart = this.$echarts.init(this.$refs.chart);
          this.myChart.setOption(this.generateOption(this.mapData));
          var bmap = this.myChart.getModel().getComponent('bmap').getBMap();
          this.bmapObj = bmap;
          bmap.disableScrollWheelZoom();
          bmap.disableDoubleClickZoom();
          bmap.disablePinchToZoom();
          bmap.enableAutoResize();
        })
    },

    generateNewForm() {
      return {
        clientId: null,
        topics: null,
        valueInterval: [1, 100],
        alert: null,
        lonInterval: [0, 180.0],
        latInterval: [0, 180.0],
        timestampInterval: [new Date(), new Date()]
      };
    },

    generateOption(data) {
      return {
        animation: false,
        bmap: {
          center: [119.9, 30.1],
          zoom: 11,
          roam: true
        },
        visualMap: {
          show: false,
          top: 'top',
          min: 0,
          max: 5,
          seriesIndex: 0,
          calculable: true,
          inRange: {
            color: ['yellow', 'red', 'green', 'yellow', 'red']
          }
        },
        series: [{
          type: 'heatmap',
          coordinateSystem: 'bmap',
          data: data,
          pointSize: 20,
          blurSize: 1
        }]
      }
    },
    generateOption1(data) {
      return {
        animation: false,
        bmap: {
          center: [119.9, 30.1],
          zoom: 11,
          roam: true
        },
        visualMap: {
          show: false,
          top: 'top',
          min: 0,
          max: 5,
          seriesIndex: 0,
          calculable: true,
          inRange: {
            color: ['yellow', 'blue', 'green', 'yellow', 'blue']
          }
        },
        series: [{
          type: 'heatmap',
          coordinateSystem: 'bmap',
          data: data,
          pointSize: 20,
          blurSize: 1
        }]
      }
    },
    generateBipartiteOption(data) {
      return {
        animation: false,
        bmap: {
          center: [119.9, 30.1],
          zoom: 11,
          roam: true
        },
        visualMap: [{
          show: false,
          top: 'top',
          min: 0,
          max: 5,
          seriesIndex: 0,
          calculable: true,
          inRange: {
            color: ['#27bfd8', '#3597c4', '#4177b4', '#4e53a2']
          }
        },
          {
            show: false,
            top: 'top',
            min: 0,
            max: 5,
            seriesIndex: 1,
            calculable: true,
            inRange: {
              color: ['#f5a718', '#f48116', '#f35a14', '#f23d13']
            }
          }


        ],
        series: [{
          type: 'heatmap',
          coordinateSystem: 'bmap',
          data: data.normal,
          pointSize: 20,
          blurSize: 1
        },
          {
            type: 'heatmap',
            coordinateSystem: 'bmap',
            data: data.alert,
            pointSize: 20,
            blurSize: 1
          }
        ]
      }
    },

    convertData(reqData) {
      return reqData.map((data) => {
        return [data.lon, data.lat, 1];
      });
    },


    formReset() {
      this.reqForm = this.generateNewForm()
    },

    submitAndRefresh() {
      this.formSubmit()
        .then(res => {
          console.log(res)

          if (res.data.success) {
            if (res.data.data.length === 0) {
              this.$message.warning("您所指定的查询条件下，没有设备信息")
            }
          } else {
            this.$message.error(res.data.info)
          }
        })
        .catch(err => {
          console.log(err)
        })
    },

    formSubmit() {
      var submitObject = qs.parse(qs.stringify(this.reqForm));

      if (submitObject.topics != null && submitObject.topics.length > 0) {
        submitObject.topics = submitObject.topics.split(",");
      } else {
        submitObject.topics = null
      }
      if (!this.timestampSwitch) {
        submitObject.timestampInterval = null
      } else {
        submitObject.timestampInterval[0] = this.reqForm.timestampInterval[0].getTime();
        submitObject.timestampInterval[1] = this.reqForm.timestampInterval[1].getTime();
      }
      if (!this.valueSwitch) {
        submitObject.valueInterval = null
      } else {
        submitObject.valueInterval = submitObject.valueInterval.map(v => parseFloat(v));
      }
      if (!this.latSwitch) {
        submitObject.latInterval = null
      } else {
        submitObject.latInterval = submitObject.latInterval.map(v => parseFloat(v));
      }
      if (!this.lonSwitch) {
        submitObject.lonInterval = null
      } else {
        submitObject.lonInterval = submitObject.lonInterval.map(v => parseFloat(v));
      }
      return axios.post("/api/queryData", submitObject)
    }


  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.disp_map_file {
  text-align: center;
}

#dispMap {
  background-color: silver;
  width: 90%;
  min-height: 100%;
  overflow: hidden;
  margin: 0 auto;
  position: absolute;
}

.filterItem {
  padding-right: 2%;
  padding-left: 2%;
}


</style>
