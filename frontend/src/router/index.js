import Vue from 'vue'
import Router from 'vue-router'
import Main from '../components/Main';
import DispMap from "../components/DispMap";
import Testfun from "../components/Testfun";
import Statistic from "../components/Statistic";
import Picture from "../components/Picture";
import Drawmap from "../components/Drawmap";
import LinePic from "../components/LinePic";
Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: "/test",
      name: "Testfun",
      component: Testfun
    },
    {
      path: "/statistics",
      name: "Statistic",
      component: Statistic
    },
    {
      path: "/picture",
      name: "Picture",
      component: Picture
    },
    {
      path: "/drawmap",
      name: "Drawmap",
      component: Drawmap
    },
    {
      path: "/map",
      name: "DispMap",
      component: DispMap
    },
    {
      path:"/line",
      name:"LinePic",
      component:LinePic
    }
  ]
})
