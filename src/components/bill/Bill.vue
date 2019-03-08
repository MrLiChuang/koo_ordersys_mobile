<template>
  <transition name="bill-page">
    <div class="bill">
      <div class="bill-title">
        <div class="icon-back" @click="back">
          <img src="@/assets/back.png" height="30">
        </div>
        <div class="text">账单</div>
      </div>
      <div class="choose">
        <h3 class="text">选择桌号</h3>
        <v-select v-model="selected" :options="['1','2','3','4','5','6','50']"
                           :maxHeight="'80px'"
                           :placeholder="'请选择桌号'" class="select"
                           @onChange="getbill">
        </v-select>
      </div>
      <div class="bill-detail" v-show="show">
        <h2>该桌消费金额为</h2>
        <span class="money">{{price}}</span>
        <div class="pay">
          <div class="pay-text">请支付，并点击确认</div>
          <div class="pic">
            <img src="@/assets/Koo_logo.png" width="180">
            <img src="@/assets/Koo_logo.png" width="180">
          </div>
          <button @click="configpay" class="button">确认支付</button>
        </div>
      </div>
    </div>
    </transition>
</template>

<script>
    export default {
        name: "bill",
      data() {
        return{
          selected: null,
          show: false,
          price: 0
        }
      },
      methods: {
        getbill(){
          if(this.selected !=null){
            this.$http.get('/api/bill/'+this.selected
            ).then(function (response) {
              if(response.data >= 0){
                this.price = response.data
                this.show = true
              } else {
                this.$toast('获取失败')
              }
            }).catch(function (error) {
              this.$toast('获取失败')
              console.log(error)
            })

          }

        },
        configpay() {
          this.$http.post('/api/bill/'+this.selected
          ).then(function (response) {
            }).catch(function (error) {
            console.log(error)
          })
          this.$router.back()
        },
        back() {
          this.$router.back()
        }
      },
      watch: {
          selected: function (oldselcted,newselected) {
            this.getbill()
          }
      }
    }
</script>

<style >
  .bill {
    position: fixed;
    height: 100%;
    left: 0;
    top: 0;
    bottom: 51px;
    background: white;
    width: 100%;
    z-index: 100;
  }
  .bill .bill-title {
    float: left;
    width: 100%;
    height: 60px;
    font-size: 18pt;
    background: #F75940;
    align-items: center;
  }
  .bill .choose {
    top: 60px;
    width: 100%;
    position: absolute;
    height: 70px;
    border-bottom: 1px solid #F75940;
  }
  .bill .bill-detail {
    top: 120px;
    width: 100%;
    color: #F75940;
    text-align: center;
    position: absolute;
  }
  .bill .bill-detail .money {
    font-size: 25pt;
    line-height: 60px;
  }
  .bill .bill-detail .pay {

  }
  .bill .bill-detail .pay .pay-text{
    font-size: 15pt;
  }
  .bill .bill-detail .pay .pic{
  }
  .bill .bill-detail .pay .button {
    height: 35px;
    width: 180px;
    font-size: 16px;
    margin-top: 20px;
    justify-content:center;
    color: white;
    background-color: #F75940;
    border-width: 0px;
  }
  .bill .choose .text {
    float: left;
    padding-left: 20px;
  }
  .bill .choose .select {
    margin-top: 15px;
    width: 240px;
    position: absolute;
    margin-left: 35%;
  }
  .bill .bill-title .icon-back{
    float: left;
    position: fixed;
    margin-top: 14px;
  }
  .bill .bill-title .text{
    margin-top: 13px;
    color: white;
    text-align: center;
  }
  .bill-page-enter-active, .bill-page-leave-active {
    transition: 0.5s
  }

  .bill-page-enter, .bill-page-leave-to {
    transform: translateX(100%);
  }
</style>
