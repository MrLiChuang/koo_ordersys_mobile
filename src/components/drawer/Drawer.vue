<template>
  <vue-drawer-layout
    ref="drawerLayout"
    :content-drawable="true"
    :enable="able"
    @mask-click="goToggleDrawer">

    <div class="drawer" slot="drawer">
      <div class="logo">
        <img src="@/assets/Koo_logo.png" width="150" >
      </div>
      <div class="list-items" >
        <div class="item" @click="ToBill">
          <img src="./img/bill.png" width="20"> 账   单
        </div>
        <div class="item" @click="ToDeliver">
          <img src="./img/post.png" width="20"> 传   菜
        </div>
      </div>
      <div class="buttonposition">
        <button @click="logoff" class="button">退出登录</button>
      </div>
    </div>

    <div class="content" slot="content">
      <div class="head" ref="head">
        <m-header @goToggleDrawer="goToggleDrawer"></m-header>
      </div>
      <goods @changedrawer="changedrawer" ></goods>
    </div>
  </vue-drawer-layout>
</template>

<script>
  import MHeader from "../m-header/m-header"
  import Goods  from "../goods/goods"

    export default {
      name: "drawer",
      data() {
        return {
          able: true
        }
      },
      components: {
        MHeader,
        Goods,
      },
      methods: {
        goToggleDrawer() {
          this.$refs.drawerLayout.toggle();
        },
        changedrawer() {
          if(this.able == true)
            this.able = false
          else  {
            this.able = true
          }
        },
        logoff() {
          this.$router.back()
        },
        ToBill() {
          this.$router.push({ path : '/Bill'})
        },
        ToDeliver() {
          this.$router.push({ path : '/Deliver',query:{waiter_id:this.$parent.waiter_id}})
        }
      }
    }
</script>

<style >
  .drawer{
    background-color: #393e46;
    height: 100%;
  }
  .drawer .logo {
    padding-top: 20px;
    text-align: center;
    overflow: hidden;
    border-radius: 8px;
  }
  .drawer .list-items{
    height: 300px;
  }
  .drawer .list-items .item {
    height: 30px;
    justify-content:center;
    margin-top: 7%;
    padding-left: 13%;
    color: white;
    font-size:27px;
  }
  .drawer .buttonposition {
    float: bottom;
    text-align: center;
  }
  .drawer .buttonposition .button {
    height: 35px;
    width: 180px;
    font-size: 16px;
    justify-content:center;
    color: white;
    background-color: #F75940;
    border-width: 0px;
  }
</style>
