<template>
  <div class="main">
    <el-row>
      <el-col :span="24" style="margin-bottom: 2%;">
        <el-menu mode="horizontal"
                 default-active="/main/bar"
                 active-text-color="#409EFF"
                 router>
          <el-menu-item index="/main/bar">
            设备统计
          </el-menu-item>
          <el-menu-item index="/main/map">
            地图信息
          </el-menu-item>
        </el-menu>
      </el-col>
    </el-row>

<!--    <el-button @click="routeTo('map')">tomap</el-button>-->
<!--    <el-button @click="routeTo('bar')">tobar</el-button>-->
    <router-view></router-view>
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
  components: {},
  computed: {},
  data: function () {
    return {
      tabName: 'bar',
    }

  },
  methods: {
    routeTo(path) {
      this.$router.push(path)
      console.log(this.$router.currentRoute.name)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.main {
  text-align: center;
}

#dispMap {
  background-color: silver;
  width: 80%;
  min-height: 150%;
  overflow: hidden;
  margin: 0 auto;
  position: absolute;
}

.filterItem {
  padding-right: 2%;
  padding-left: 2%;
}


</style>
