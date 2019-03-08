<template>
  <ul class="switches">
    <li class="switch-item" v-for="(item,index) in switches" :class="{'active':currentIndex === index}"
        @click="switchItem(index)">
      <span>{{item.name}} </span>
    </li>
  </ul>
</template>

<script>
  export default {
    props: {
      switches: {
        type: Array,
        default: []
      },
      currentIndex: {
        type: Number,
        default: 0
      }
    },
    methods: {
      switchItem(index) {
        this.$emit('switchItem', index)
      }
    }
  }
</script>

<style >

  .switches{
    display: flex;
    align-items: center;
    width: 240px;
    margin: 0 auto;
    background: white;
    border: 1px solid #F75940;
    border-radius: 5px;
    padding-left: 0px;
  }
  .switches .switch-item{
    list-style-type: none;
    flex: 1;
    padding: 8px;
    text-align: center;
    font-size: 15px;
    color: black;
    }
  .switches .active {
    background: #F75940;
  }

</style>
