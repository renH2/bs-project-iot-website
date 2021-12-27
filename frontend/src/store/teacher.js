import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import qs from 'qs'
import global from "../lib/global";

Vue.use(Vuex)

export default new Vuex.Store({
  state: {

    teacherInfo: {
      // "teacherId": 'res.data.teacherId',
      // "email": 'res.data.email',
      // "name": 'res.data.name',
      // "department": 'res.data.department',
      // "telephone": 'res.data.telephone',
      // "teacherProfile": 'res.data.teacherProfile'
    },

// 存储所有教学班信息
    classes: [

      // {
      //   college: "计算机科学与技术"
      //   courseId: 0
      //   course_id: 4
      //   course_name: "计算机网络"
      //   credits: 4.5
      //   schedule: "2 3 4 5"
      //   semester: 6
      //   stat: 1
      //   teacher_name: "yhm"
      //   year: 2020
      // },
    ],

    stuList: [],
    chosenClass: null,
    isSelectReady: false,
  },
  getters: {
    /**
     * 返回教师课程列表的计算属性
     * @param state
     * @returns
     */
    getClasses(state) {
      if (state.classes === null) {
        return []
      }
      const lookup = ['全年', '春', '夏', '秋', '冬', '春夏', '秋冬', '暑学期']

      return state.classes.map(item => {
        item.semester = lookup[item.semester]
        console.log(item.schedule)
        item.schedule = global.mapSchedule(item.schedule)
        return item
      })
    },
    /**
     * 返回教室独有的计算属性
     * @param state
     * @returns {{}}
     */
    getTeacherInfo(state) {
      return state.teacherInfo
    },

    getChosenClass(state) {
      return state.chosenClass
    },

    getIsSelectReady(state) {
      return state.isSelectReady
    },

    getStuList(state) {
      return state.stuList
    }
  },
  mutations: {
    initCourse(state) {
      // 初始化课程
    },
    addCourses(state, courseInfo) {
      state.classes.push(courseInfo)
    },
    setClasses(state, classes) {
      // assert(state.courses === [], "can`t modify")
      state.classes = classes
    },
    setTeacherInfo(state, info) {
      state.teacherInfo = info
      console.log(info)
    },

    setChosenClass(state, chosen) {
      state.chosenClass = chosen
    },

    setIsSelectReady(state, v) {
      state.isSelectReady = v
    },

    setStuList(state, v) {
      state.stuList = v
    }
  },
  actions: {},
})
