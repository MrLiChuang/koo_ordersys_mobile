<template>
  <transition name="deliver-page">
    <div class="deliver">
      <div class="deliver-title">
        <div class="icon-back" @click="back">
          <img src="@/assets/back.png" height="30">
        </div>
        <div class="text">传菜</div>
      </div>
      <div class="switch">
        <switches @switchItem="switchItem" :switches="switches" :currentIndex="currentIndex" ></switches>
      </div>
        <div class="list" ref="waiting_listScroll" v-if="currentIndex===0">
          <div>
            <li class="food-item" v-for="(item,index) in waiting_list" :key="index">
              <img class="icon" :src=item.image height="70">
              <div class="content">
                <h3 class="name">{{item.dish_name}}  ×{{item.num}}份</h3>
                <p class="price">
                  <span class="text">{{item.table}}号桌</span>
                </p>
              </div>
              <button class="button" @click="postchoice(item)" v-if="index === 0" v-show="item.w_show">选择</button>
              <button class="button-done"  v-show="!item.w_show">已选</button>
            </li>
          </div>
        </div>
      <div class="list" ref="my_listScroll" v-if="currentIndex===1">
          <div>
            <li class="food-item" v-for="(item,index) in waiting_list" :key="index">
              <img class="icon" :src=item.image height="70">
              <div class="content">
                <h3 class="name">{{item.dish_name}}  ×{{item.num}}份</h3>
                <p class="price">
                  <span class="text">{{item.table}}号桌</span>
                </p>
              </div>
              <button class="button" @click="configchoice(item)" v-if="index===0" v-show="item.w_show">已送</button>
              <button class="button-done"  v-show="!item.w_show">完成</button>
            </li>
          </div>
      </div>

    </div>
  </transition>
</template>

<script>
  import BScroll from 'better-scroll'
  import Switches from '../switches/Switches'
  export default {
    name: "deliver",
    data() {
      return{
        waiting_listScroll: {},
        my_listScroll: {},
        currentIndex: 0,
        waiting_list:[],
        waiter_id: 0,
        my_list:[],
        disabled:true,
        switches: [
          {
            name: '待传列表'
          },
          {
            name: '我的列表'
          }
        ]
      }
    },
    components: {
      Switches
    },
    mounted() {
      this.waiter_id = JSON.parse(localStorage.getItem('waiter_id'));
    },
    created() {
      this.getwaitlist()

      // this.$http.get('/api/dishes/'+this.waiter_id).then(response => {
      //   this.change(response.data)
      //   //DOM已经更新
      //   this.$nextTick(() => {
      //     // 执行滚动方法
      //     this.initScroll()
      //     // 计算分类的区间高度
      //     this.calculateHeight()
      //   })
      // })

    //   fetch("../static/data/xxx.json")
    //     .then(res => res.json())
    //       .then(response => {
    //         if (response.code == 0) {
    //           this.waiting_list = response.data
    //           //DOM已经更新
    //           this.$nextTick(() => {
    //             // 执行滚动方法
    //             this.init_wait()
    //     })
    //   }
    // })
    },
    methods: {
      init_wait(){
        this.waiting_listScroll = new BScroll(this.$refs.waiting_listScroll, {
          click: true
        })
      },
      init_my() {
        this.my_listScroll = new BScroll(this.$refs.my_listScroll, {
          click: true
        })
      },
      reform(index){
        if(index==1){
          this.waiting_list.forEach(function (param, index, array) {
            param.w_show = true
          })
        }else if (index==2){
          this.my_list.forEach(function (param, index, array) {
            param.w_show = true
          })
        }
      },
      switchItem(index) {
        this.currentIndex = index
      },
      getwaitlist() {
        this.$http.get('/api/deliver').then(response => {
          this.waiting_list = response.data
          this.reform(1)
          //DOM已经更新
          this.$nextTick(() => {
            // 执行滚动方法
            this.init_wait()
          })
        })
      },
      postchoice(param){
        this.$http.post('/api/deliver/'+this.waiter_id).then(response =>{
          if(response.data = '0'){
            this.$toast("选择成功")
            param.w_show = false
            this.getwaitlist()
          }else {
            this.$toast("选择失败")
          }
        }).catch(function (error) {
          this.$toast('选择失败')
          console.log(error)
        })
      },
      getmylist() {
        this.$http.get('/api/deliver/'+this.waiter_id).then(response => {
          this.my_list = response.data
          this.reform(2)
          //DOM已经更新
          this.$nextTick(() => {
            // 执行滚动方法
            this.init_my()
          })
        })
      },
      configchoice(param){
        this.$http.post('/api/deliver/'+this.waiter_id).then(response =>{
          if(response.data = '0'){
            this.$toast("提交成功")
            param.w_show = false
            this.getmylist()
          }else {
            this.$toast("提交失败")
          }
        }).catch(function (error) {
          this.$toast('提交失败')
          console.log(error)
        })
      },
      back() {
        this.$router.back()
      }
    },
    watch: {
      currentIndex : function(oldValue,newValue) {
        if(oldValue == 0){
          this.getwaitlist()
        }else if (oldValue == 1){
          this.getmylist()
        }
      }
    }
  }
</script>

<style >
  .deliver {
    position: fixed;
    height: 100%;
    left: 0;
    top: 0;
    bottom: 51px;
    background: white;
    width: 100%;
    z-index: 100;
  }
  .deliver .deliver-title {
    float: left;
    width: 100%;
    height: 60px;
    font-size: 18pt;
    background: #F75940;
    align-items: center;
  }
  .deliver .switch {
    margin-top: 20%;
  }
  .deliver .list {
    margin-top: 10px;
    height: 83%;
    width: 100%;
    overflow: hidden;
    border-bottom: 1px solid #E4E4E4;
  }
  .deliver .list .food-item {
    list-style-type: none;
    display: flex;
    align-items: center;
    margin-bottom: 25px;
    position: relative;
  }

  .deliver .list .food-item .icon {
    flex: 0 0 63px;
    margin-left: 20px;
    background-position: center;
    background-size: 120% 100%;
    background-repeat: no-repeat;
    margin-right: 11px;
    height: 75px;
  }

  .deliver .list .food-item .content {
    flex: 1;
  }

  .deliver .list .food-item .button {
    float: right;
    margin-right: 5%;
    background: #fb4e44;
    color: white;
    border-width: 0px;
    width: 60px;
    border-radius: 4px;
    height: 25px;
  }
  .deliver .list .food-item .button-done {
    float: right;
    margin-right: 5%;
    background: #da4e38;
    color: white;
    border-width: 0px;
    width: 60px;
    border-radius: 4px;
    height: 25px;
  }
  /* 具体内容样式 */
  .deliver .list .food-item .content .name {
    font-size: 16px;
    line-height: 21px;
    color: #333333;
    margin-bottom: 10px;
    padding-right: 27px;
  }

  .deliver .list .food-item .content .price {
    font-size: 0;
  }

  .deliver .list .food-item .content .price .text {
    font-size: 14px;
    color: #fb4e44;
  }
  .deliver .deliver-title .icon-back{
    float: left;
    position: fixed;
    margin-top: 14px;
  }
  .deliver .deliver-title .text{
    margin-top: 13px;
    color: white;
    text-align: center;
  }
  .deliver-page-enter-active, .deliver-page-leave-active {
    transition: 0.5s
  }

  .deliver-page-enter, .deliver-page-leave-to {
    transform: translateX(100%);
  }
</style>
