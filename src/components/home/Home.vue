<template>
  <div class="home">
    <drawer></drawer>
  </div>
</template>

<script>

  import Drawer  from "../drawer/Drawer"

  export default{
    components: {
      Drawer
    }
  }
</script>

<style>
  .home{
    width: 100% ;
    height: 100%;
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;}
</style>
