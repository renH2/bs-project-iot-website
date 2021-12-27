<template>
  <div id="app">

    <el-container>
      <el-header>
        <Navbar></Navbar>
      </el-header>
      <el-main>

        <router-view></router-view>


      </el-main>

      <el-footer>

      </el-footer>
    </el-container>


  </div>
</template>

<script>
import Navbar from "./components/Navbar";

export default {
  mounted() {
    //this.$router.push("/main")
  },
  beforeCreate() {// 在页面重新载入的时候，通过cookie重新载入身份等信息

  },
  name: 'app',
  components: {Navbar},
  data() {
    return {

    }
  },
  methods: {

  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>
