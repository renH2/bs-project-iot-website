<template>
  <div class="disp_map_file">
    <div>
      <el-button @click="testchart">测试echart</el-button>

    </div>
    <div style="margin-bottom: 1%">
      <el-tabs tab-position="left">
        <el-tab-pane label="查询筛选">
          <el-row style="margin-bottom: 2%; margin-top:2%;">
            <el-col :span="22" :offset="1">
              <el-form ref="regForm" :model="reqForm" label-position="top">
                <el-col :span="reqLen" class="filterItem">
                  <el-form-item label="客户ID" prop="clientId">
                    <el-input v-model="reqForm.clientId" placeholder="所查询信息的clientId"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="reqLen" class="filterItem">
                  <el-form-item label="话题列表" prop="topics">
                    <el-row>
                      <el-input v-model="reqForm.topics" placeholder="查询的话题列表,多个值用英文逗号隔开"></el-input>
                    </el-row>
                  </el-form-item>
                </el-col>
                <el-col :span="reqLen" class="filterItem">
                  <el-form-item prop="topics">
                    <template slot="label">
                      数值区间
                      <el-switch v-model="valueSwitch"></el-switch>
                    </template>
                    <el-row>
                      <el-col :span="12" class="filterItem">
                        <el-input type="number" :step="0.0001"
                                  :disabled="!valueSwitch" v-model="reqForm.valueInterval[0]"></el-input>
                      </el-col>
                      <el-col :span="12" class="filterItem">
                        <el-input type="number" :step="0.0001"
                                  :disabled="!valueSwitch" v-model="reqForm.valueInterval[1]"></el-input>
                      </el-col>
                    </el-row>
                    <el-slider
                      :disabled="!valueSwitch"
                      v-model="reqForm.valueInterval"
                      range
                      ref="testSlider"
                      :max="100">
                    </el-slider>
                  </el-form-item>
                </el-col>
                <el-col :span="reqLen" class="filterItem">
                  <el-form-item label="是否告警" prop="alert">
                    <el-input v-model="reqForm.alert" placeholder="0为是，1为否"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="reqLen" class="filterItem">
                  <el-form-item label="经度区间" prop="lonInterval">
                    <template slot="label">
                      经度区间
                      <el-switch v-model="lonSwitch"></el-switch>
                    </template>
                    <el-row>
                      <el-col :span="12" class="filterItem">
                        <el-input type="number" :step="0.0001"
                                  @input="(val)=>{this.reqForm.lonInterval[0]=parseFloat(val)}"
                                  :disabled="!lonSwitch" v-model="reqForm.lonInterval[0]"></el-input>
                      </el-col>
                      <el-col :span="12" class="filterItem">
                        <el-input type="number" :disabled="!lonSwitch" v-model="reqForm.lonInterval[1]"></el-input>
                      </el-col>
                    </el-row>
                    <el-slider
                      :disabled="!lonSwitch"
                      v-model="reqForm.lonInterval"
                      range
                      :max="180">
                    </el-slider>
                  </el-form-item>
                </el-col>
                <el-col :span="reqLen" class="filterItem">
                  <el-form-item prop="latInterval">
                    <template slot="label">
                      纬度区间
                      <el-switch v-model="latSwitch"></el-switch>
                    </template>
                    <el-row>
                      <el-col :span="12" class="filterItem">
                        <el-input :disabled="!latSwitch" v-model="reqForm.latInterval[0]"></el-input>
                      </el-col>
                      <el-col :span="12" class="filterItem">
                        <el-input :disabled="!latSwitch" v-model="reqForm.latInterval[1]"></el-input>
                      </el-col>
                    </el-row>
                    <el-slider
                      :disabled="!latSwitch"
                      v-model="reqForm.latInterval"
                      range
                      :max="180">
                    </el-slider>
                  </el-form-item>
                </el-col>
                <el-col :span="reqLen" class="filterItem">
                  <el-form-item prop="timestampInterval">
                    <template slot="label">
                      时间戳区间
                      <el-switch v-model="timestampSwitch"></el-switch>
                    </template>
                    <el-row>
                      <el-date-picker
                        :disabled="!timestampSwitch"
                        v-model="reqForm.timestampInterval"
                        type="datetimerange"
                        range-separator="至"
                        start-placeholder="开始日期"
                        end-placeholder="结束日期"
                      >
                      </el-date-picker>
                    </el-row>
                  </el-form-item>
                </el-col>
              </el-form>
              <div style="float: right; margin-top: 3%;margin-right: 8%">
                <el-button @click="formReset">重置</el-button>
                <el-button type="success" @click="formSubmit">提交</el-button>
              </div>
            </el-col>
          </el-row>
        </el-tab-pane>
        <el-tab-pane label="地图配置">
          <el-button @click="bmapObj.zoomIn()">zoomin</el-button>
          <el-button @click="bmapObj.zoomOut()">zoomOut</el-button>
        </el-tab-pane>
      </el-tabs>
    </div>
    <div style="height: 100%;width: 90% ; margin-left: 3%;">
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


    testchart() {
      // 通过ref初始化容器
      var ROOT_PATH = 'https://cdn.jsdelivr.net/gh/apache/echarts-website@asf-site/examples';
      axios.get(ROOT_PATH + '/data/asset/data/hangzhou-tracks.json')
        .then(data => {
          console.log(data)
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
          center: [120.13066322374, 30.240018034923],
          zoom: 14,
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
            color: ['blue', 'blue', 'green', 'yellow', 'red']
          }
        },
        series: [{
          type: 'heatmap',
          coordinateSystem: 'bmap',
          data: data,
          pointSize: 5,
          blurSize: 6
        }]
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

    formSubmit() {
      var submitObject = qs.parse(qs.stringify(this.reqForm));
      submitObject.timestampInterval[0] = this.reqForm.timestampInterval[0].getTime();
      submitObject.timestampInterval[1] = this.reqForm.timestampInterval[1].getTime();
      submitObject.topics = this.reqForm.topics.split(",");
      if (!this.timestampSwitch) {
        submitObject.timestampInterval = null
      }
      if (!this.valueSwitch) {
        submitObject.valueInterval = null
      }
      if (!this.latSwitch) {
        submitObject.latInterval = null
      }
      if (!this.lonSwitch) {
        submitObject.lonInterval = null
      }
      axios.post("/api/queryData", {
        messageReq: submitObject
      }).then(res => {
        console.log(res)
        if (res.data.success) {
          this.$message.success(res.data.info)
          state.commit('setMapData', this.convertData(res.data.data))
          this.myChart.setOption(this.generateOption(this.mapData))
        } else {
          this.$message.error(res.data.info)
        }
      })
        .catch(err => {
          console.log(err)
        })
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
