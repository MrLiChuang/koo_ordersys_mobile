<template>
  <div class="login">
    <img class="logo" src="@/assets/Koo_logo.png" width="200" height="200">
    <div v-show="showLogin">
      <h2 class="title">koo点餐系统</h2>
      <h3>登录</h3>
      <input type="text" placeholder="请输入用户名" v-model="account" class="input">
      <input type="password" placeholder="请输入密码" v-model="password" class="input">
      <button v-on:click="login" class="button">登录</button>
    </div>

  </div>
</template>

<script>
  export default {
    data() {
      return {
        account: '',
        password: '',
        showLogin: true,
        showRegister: false,
        serverData: '',
      }
    },
    methods: {
      login() {
        let account = this.account;
        let password = this.password;
        if (account == '' || password == '') {
          this.$toast('帐号或密码不能为空');
        } else {
          this.$http.post('/api/user/selectUser', {
            account: account,
            password: password
          }, {}).then((response) => {
            if (response.data == 0) {
              this.$toast('账户不存在或密码错误') ;
              this.account = '';
              this.password = '';
            }
            else {
              this.$toast('登录成功，页面即将跳转') ;
              localStorage.setItem('waiter_id',JSON.stringify(response.data));
              setTimeout(() => {
                this.$router.push({path: '/home'})
              }, 500)
            }
          }).catch(function (error) {
            this.$toast('登录失败')
            console.log(error)
          })
        }
      }
    }
  }
</script>
<style>
  .login {
    text-align: center;
    margin-top: 13%;
  }

  .login .title {
    color: #F75940;
  }

  .login .input {
    display: block;
    width: 250px;
    height: 40px;
    line-height: 40px;
    margin: 0 auto;
    margin-bottom: 10px;
    outline: none;
    border: 1px solid #888;
    padding: 10px;
    box-sizing: border-box;
  }
  .login .button {
    display: block;
    width: 250px;
    height: 40px;
    line-height: 40px;
    margin: 0 auto;
    border: none;
    background-color: #41b883;
    color: #fff;
    font-size: 16px;
    margin-bottom: 5px;
  }

</style>
