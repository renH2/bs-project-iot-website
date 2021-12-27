/*
所有全局函数都在这里定义，已经被vue引用，使用时直接this.$global.方法名()调用
 */
import state from '../store/index'
import Vue from "vue";
import axios from "axios";

export default {
  test() {
    console.log("global test")
  },

  /**
   * 在页面刷新时，重新通过cookies导入信息
   */
  syncInfoOnRefresh() {
    state.commit('relogin')
  },


  /**
   * 转化成正格式的字符串
   * @param str
   * @returns {string}
   * @constructor
   */
  formatTimeString(str) {
    let date = new Date(Date.parse(str))
    return date.toLocaleString()
  },
  /**
   * 由毫秒转化成时间
   * @param num
   * @returns {string}
   */
  num2date(num) {
    var date = new Date(num);
    return date.toLocaleString()
  },

  /**
   * 单位字符转化成长度
   * @param unitStr
   */
  unitToNum(unitStr) {
    var unitDict = {
      "每分": 1,
      "每小时": 60,
      "每天": 60 * 24,
      "每月(以30天计)": 60 * 24 * 30
    }
    return unitDict[unitStr];
  },

  deepCopy(data){
    return JSON.parse(JSON.stringify(data))
  }

}
