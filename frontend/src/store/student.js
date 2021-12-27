import Vue from 'vue'
import Vuex from 'vuex'
import global from '../lib/global'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    file: 'student',
    hwDetail: {},
    stuInfo: {},
    courseList: [],
    chosenCourse: {},
  },
  mutations: {
    setHwDetail(state, hw) {
      state.hwDetail = hw;
      console.log(state.hwDetail, hw);
    },
    setStuInfo(state, info) {
      state.stuInfo = info;
      // console.log(state);
    },
    setCourseList(state, list) {
      state.courseList = list;
    },
    setChoosenCourse(state, course) {
      state.chosenCourse = course;
    }
  },
  actions: {},
  modules: {},
  getters: {
    getHwDetail(state) {
      return state.hwDetail;
    },
    getStuInfo(state) {
      return state.stuInfo;
    },
    getCourseList(state) {

      const lookup = ['全年', '春', '夏', '秋', '冬', '春夏', '秋冬', '暑学期']

      return state.courseList.map(item => {
        item.semester = lookup[item.semester]
        console.log(item.schedule)
        item.schedule = global.mapSchedule(item.schedule)
        return item
      })
    },
    getChoosenCourse(state) {
      return state.chosenCourse;
    }
  }
})
