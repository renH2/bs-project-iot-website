<template>
  <div style="margin-top: 0;">
    <el-menu
      :default-active="router_page"
      mode="horizontal"
      @select="handleSelect"
      active-text-color="green"
      background-color="#FF9E40"
      text-color="#fff"
    >
      <el-menu-item @click="drawer=!drawer">
        <div class="el-icon-s-unfold" style="color: white"></div>
      </el-menu-item>
      <el-menu-item disabled index="icon"
                    style="color: white!important;cursor: pointer!important;opacity: 1!important;font-size: x-large">
        <div @click="backToMain">
          BS Project-IOT网站
        </div>
      </el-menu-item>
      <el-menu-item style="color: white!important;cursor: pointer!important;opacity: 1!important;font-size: x-large" v-if="hasLogin">
        <div>
          欢迎浏览
        </div>
      </el-menu-item>


    </el-menu>
    <el-drawer
      direction="ltr"
      :visible.sync="drawer"
      :show-close="false"
      :wrapper-closable="true"
      :with-header="false"
    >
      <el-menu
        :default-active="router_page"
        mode="vertical"
        @select="handleSelect"
        active-text-color="#FF9E40"
        router
      >
        <el-menu-item index="/picture">查看首页</el-menu-item>
        <el-menu-item index="/test">设备配置</el-menu-item>
        <el-menu-item index="/Drawmap">地图界面</el-menu-item>
        <el-menu-item index="/line">统计信息</el-menu-item>
      </el-menu>
    </el-drawer>



    <div class="dialogs_class">
      <el-dialog
        title="访客注册"
        :visible.sync="regDisplay"
        :close-on-click-modal="false"
        width="50%"
      >
        <div>
          <el-form ref="regForm" :model="regForm" :rules="regRules"
          >
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="regForm.email" placeholder="小于64位的正确邮件格式"
              ></el-input>
            </el-form-item>
            <el-form-item label="用户名" prop="userName">
              <el-input v-model="regForm.userName" placeholder="2-15位中英文或数字"></el-input>
            </el-form-item>
            <el-form-item label="输入密码" prop="password">
              <el-input type="password" v-model="regForm.password" placeholder="长度大于等于6位的英文，数字或特殊字符"></el-input>
            </el-form-item>
            <el-form-item label="再次输入密码" prop="passwordAgain">
              <el-input type="password" v-model="regForm.passwordAgain" placeholder="长度大于等于6位的英文，数字或特殊字符"></el-input>
            </el-form-item>
          </el-form>
        </div>
        <el-button type="primary" @click="regSubmit('regForm')">确定</el-button>
        <el-button @click="formReset('regForm')">取消</el-button>

      </el-dialog>
      <el-dialog
        title="用户登录"
        :visible.sync="loginDisplay"
        :close-on-click-modal="false"
        width="500px"
      >
        <el-form ref="loginForm" :model="loginForm" :rules="loginRules"
        >
          <el-form-item label="输入登录邮箱" prop="email">
            <el-input v-model="loginForm.email"
            ></el-input>
          </el-form-item>

          <el-form-item label="输入密码" prop="password">
            <el-input type="password" v-model="loginForm.password" placeholder="6-20位英文或数字"></el-input>
          </el-form-item>

        </el-form>
        <el-button type="primary" @click="loginSubmit('loginForm')">登录</el-button>
        <el-button @click="formReset('loginForm')">取消</el-button>
      </el-dialog>
    </div>

  </div>
</template>

<script>
import state from '../store/index'
import axios from 'axios'
import qs from "qs";

export default {
  computed: {
    curRole() {
      return state.getters.getRole
    },
    isTA() {
      return state.getters.isTA
    },
    loginRules() {
      return {
        email: this.regRules.email,
        password: this.regRules.password
      }
    },
    hasLogin() {
      return state.getters.hasLogin
    },
    userInfo() {
      return state.getters.userInfo
    }
  },
  name: "Navbar",
  data() {
    return {
      router_page: '/',
      drawer: false,

      courseList: [],
      activeName: '1',
      avatar_src: "",
      regDisplay: false,
      regForm: {
        email: "",
        password: "",
        userName: "",
        passwordAgain: "",
      },
      regRules: {
        email: [
          {
            required: true,
            validator: (rule, value, callback) => {
              const reg = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+(\.([a-zA-Z]{2,4}))+$/;
              if (reg.test(value) && value.length < 64) {
                // callback()
                callback()
              } else {
                callback(new Error("请输入正确格式的邮箱"))
              }

            }, message: '请输入正确的邮箱', trigger: 'blur'
          }
        ],
        password: [
          {
            required: true, validator: (rule, value, callback) => {
              const reg = /^[0-9a-zA-Z.]{6,1024}$/;
              if (reg.test(value)) {
                callback()
              } else {
                callback(new Error("请输入正确格式的密码"))
              }
              callback()
            }, message: '请输入正确的密码', trigger: 'blur'
          }
        ],
        passwordAgain: [
          {
            required: true, validator: (rule, value, callback) => {
              const reg = /^[0-9a-zA-Z.]{6,1024}$/;
              if (reg.test(value) && value === this.regForm.password) {
                callback()
              } else {
                callback(new Error("请输入相同的密码"))
              }
            }, message: "请输入相同的密码", trigger: 'blur'
          }
        ],
        userName: [
          {
            required: true, validator: (rule, value, callback) => {
              const reg = /^[0-9a-zA-Z.\u4e00-\u9fa5]{2,24}$/;
              if (reg.test(value) || value.length === "") {
                callback()
              } else {
                callback(new Error("请输入正确的用户名"))
              }
            }, message: '请输入正确的用户名', trigger: 'blur'
          }
        ],

      },
      loginDisplay: false,
      loginForm: {
        email: "",
        password: "",
      },
      mmsg:{
        'msg':'logout'
      },
    }
  },
  methods: {

    handleSelect(index, keyPath) {
      if (index === "openDrawer") {
        this.drawer = !this.drawer
      } else {
        this.drawer = false
      }
    },
    backToMain() {
      if (this.$router.currentRoute.name !== 'Main') {
        this.$router.push('/main')
      }
    },


    handleClick() {
      console.log('asd')
    },


    regSubmit(formName) {
      console.log(this.regForm)
      this.$refs[formName].validate((valid) => {
        if (valid) {
          axios.post('/api/register', qs.stringify(this.regForm)).then(res => {
            console.log(res)
            if (res.data.success) {
              this.$message.success(res.data.info)
              this.formReset(formName)
            } else {
              this.$message.error(res.data.info)
            }
          }).catch(err => {
            this.$message.error("注册失败，请检查您的输入信息")
            console.log(err)
          })

        } else {
          this.$message.error("注册失败，请检查您的输入信息")
          return false;
        }
      })
    },

    loginSubmit(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          axios.post('/api/login', qs.stringify(this.loginForm))
            .then(res1 => {

              console.log(res1)
              if (res1.data.success) {
                state.commit('login', {
                  email: this.loginForm.email,
                  role: res1.data.data.role,
                  id: res1.data.data.userId,
                  name: res1.data.data.userName,
                })
                this.$message.success(res1.data.info)
                this.formReset(formName)
              } else {
                this.loginForm.password = ''
                this.$message.error(res1.data.info)
              }
            })

        } else {
          this.$message.error("请选择合理的输入格式")
          return false
        }
      })
    },

    logout() {
      state.commit('logout')
      axios.post("/api/test",postObj)
        .then(response => {
          console.log(response)
        }).catch(err => {
        this.$message.error("注册失败，请检查您的输入信息")
        console.log(err)
      })
    },

    formReset(formName) {
      this.$refs[formName].resetFields();
      this.regDisplay = false;
      this.loginDisplay = false;
    },

  }
}
</script>

<style scoped>
</style>
