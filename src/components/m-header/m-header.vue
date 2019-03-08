<template>
  <div class="m-header">
    <div class="top-title">
      <div class="person">
        <img src="./img/person.png" @click="showDrawer" width="30" >
      </div>
      <div class="text">欢迎</div>
    </div>

  <div class="background" >
    <img src="./img/pic.png" width="100%" height="100%" >
  </div>
  </div>
</template>

<script>
  export default{
    methods: {
      showDrawer() {
        this.$emit('goToggleDrawer');
      }
    }
  }
</script>

<style>
  .m-header{
    height: 180px;
    position: relative;
    overflow: hidden}
  .m-header .top-title{
    float: left;
    width: 100%;
    line-height: 15px;
    font-size: 20pt;
    color: aliceblue}
  .m-header .top-title .text {
    margin-top: 12px;
    margin-right: 10%;
    text-align: center;
  }
  .m-header .top-title .person{
    float: left;
    margin-left: 10px;
    margin-top: 10px;
  }
  .m-header .background{
    position:absolute;
    top:0;
    left:0;
    z-index:-1;
    filter:blur(1px);}
</style>
