import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)
/**
 * 储存全局信息，如是否登录等等
 *
 */
export default new Vuex.Store({ // 存储跨组件的，刷新不被保留的数据
  state: {
    role_list: ['none', 'guest', 'student', 'teacher', 'admin', 'test', 'ta'],
    hasLogin: false,
    userInfo: {
      role: '',
      name: '',
      email: '',
      id: '',
    },
    reqData: [],


  },
  mutations: {
    /**
     * 在页面刷新时，重新加载vuex数据操作的集合
     * @param state 当前state
     */
    reloadOnRefresh(state) {
      if (Vue.$cookies.get("role") !== 'none') {
        console.log(this.getters.getCookieInfo)
        this.commit('login', this.getters.getCookieInfo)
      }
      // 此处应当有一系列重新加载数据的操作
    },
    /**
     * 用户通过输入信息进行登入
     * @param state
     * @param info
     */
    login(state, info) {
      state.hasLogin = true
      state.userInfo = info
      Vue.$cookies.set('role', info.role)
      Vue.$cookies.set('name', state.userInfo.name)
      Vue.$cookies.set('id', state.userInfo.id)
      Vue.$cookies.set('email', state.userInfo.email)
    },
    /**
     * 在重新加载页面时，通过cookie进行登录
     * @param state
     */
    relogin(state) {
      console.log(this.getters.getCookieInfo, this.getters.getCookieInfo.role !== null)
      if (this.getters.getCookieInfo.role !== null) {
        state.hasLogin = true
        state.userInfo = this.getters.getCookieInfo
      }


    },
    logout(state) {
      state.hasLogin = false
      Vue.$cookies.set('role', 'none')
      Vue.$cookies.set('name', '')
      Vue.$cookies.set('email', '')
      Vue.$cookies.set('id', '')
    },

    setRole(state, role) {// 对role的更新必须写cookie,否则刷新就会出错
      if (state.role_list.includes(role)) {
        Vue.$cookies.set('role', role)
        state.userInfo.role = role

      } else {
        alert("error!no in the role list!")
      }
    },

    setMapData(state, data) {
      state.reqData = data
    }


  },
  getters: {
    getRole(state) {
      return state.userInfo.role
    },
    getCookieInfo(state) {
      return {
        role: parseInt(Vue.$cookies.get("role")),
        name: Vue.$cookies.get("name"),
        email: Vue.$cookies.get('email'),
        id: parseInt(Vue.$cookies.get('id')),
      }
    },
    userInfo(state) {
      return state.userInfo
    },
    hasLogin(state) {
      return state.hasLogin
    },
    getMapData(state) {
      return state.reqData;
    }

  },

})
