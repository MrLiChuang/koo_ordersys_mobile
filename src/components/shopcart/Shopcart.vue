<template>
  <div class="shopcart" :class="{'highligh':totalCount>0}">
    <div class="shopcart-wrapper">
      <!--底部左侧-->
      <div class="content-left">
        <div class="logo-wrapper" :class="{'highligh':totalCount>0}">
          <span class="icon-shopping_cart logo" :class="{'highligh':totalCount>0}" @click="toggleList"></span>
          <i class="num" v-show="totalCount">{{totalCount}}</i>
        </div>
        <div class="desc-wrapper">
          <p class="total-price" v-show="totalCount">￥{{totalPrice}}</p>
          <p class="tip" :class="{'highligh':totalCount>0}">点此可查看详细清单</p>
        </div>
      </div>
      <!--底部右侧-->
      <div class="content-right" :class="{'highligh':totalCount>0}" @click="makeorder">
        {{payStr}}
      </div>
      <!-- 购物车列表 -->
      <div class="shopcart-list" v-show="listShow" :class="{'show':listShow}">
        <div class="list-header">
          <span class="title">我的口袋</span>
          <div class="empty" @click="clearAll">
            <img src="./img/ash_bin.png"/>
            <span>清空购物车</span>
          </div>
        </div>
        <div class="list-content" ref="listContent">
          <div>
            <li class="food-item" v-for="(food,index) in selectFoods" :key="index">
              <div class="desc-wrapper">
                <div class="desc-left">
                  <div class="name">{{food.name}}</div>
                  <div class="unit" v-show="!food.description">份</div>
                  <div class="description" v-show="!food.unit">{{food.description}}</div>
                </div>
                <div class="desc-right">
                  <div class="text">￥{{food.price}}</div>
                  <app-cart-control :food="food"></app-cart-control>
                </div>
              </div>
            </li>
          </div>
        </div>
        <div class="list-bottom"></div>
      </div>
    </div>
    <div class="shopcart-mask" v-show="listShow" @click="hideMask"></div>
  </div>
</template>
<script>
  import BScroll from 'better-scroll'
  import CartControl from '../cartcontrol/CartControl'

  export default {
    data() {
      return {
        fold: true
      }
    },
    props: {
      selectFoods: {
        type: Array,
        default() {
          return []
        }
      }
    },
    computed: {
      totalCount() {
        let num = 0
        this.selectFoods.forEach((food) => {
          num += food.count
        })
        return num;
      },
      totalPrice() {
        let total = 0;
        this.selectFoods.forEach((food) => {
          total += food.count * food.price
        })
        return total;
      },
      payStr() {
        if (this.totalCount > 0) {
          return "提交订单"
        } else {
          return "请点餐"
        }
      },
      listShow() {
        if (!this.totalCount) {
          this.fold = true;
          return false
        }
        let show = !this.fold;
        if (show) {
          this.$nextTick(() => {
              if (!this.shopScroll) {
                this.shopScroll = new BScroll(this.$refs.listContent, {
                  click: true
                })
              } else {
                this.shopScroll.refresh()
              }
            }
          )
        }
        return show

      }
    },
    methods: {
      toggleList() {
        if (!this.totalCount) {
          return;
        }
        this.fold = !this.fold
      },
      clearAll() {
        this.selectFoods.forEach((food) => {
          food.count = 0;
        })
      },
      hideMask() {
        this.fold = true;
      },
      makeorder() {
        if(this.totalCount > 0){
          this.$emit('handleorder')
        }
      }

    },
    components: {
      "app-cart-control": CartControl
    }
  }
</script>
<style>
  @import url(../../common/css/icon.css);

  .shopcart-wrapper {
    list-style-type: none;
    width: 100%;
    height: 51px;
    background: #393e46;
    position: fixed;
    left: 0;
    bottom: 0;
    display: flex;
    z-index: 99;
  }

  .shopcart-wrapper .content-left {
    flex: 1;
  }

  .shopcart-wrapper .content-right {
    flex: 0 0 110px;
    font-size: 15px;
    color: #BAB9B9;
    line-height: 51px;
    text-align: center;
    font-weight: bold;
  }

  .shopcart-wrapper .content-left .logo-wrapper {
    width: 50px;
    height: 50px;
    background: #666666;
    border-radius: 50%;
    position: relative;
    top: -14px;
    left: 10px;
    text-align: center;
    float: left;
  }

  .shopcart-wrapper .content-left .logo-wrapper .logo {
    font-size: 28px;
    color: #c4c4c4;
    line-height: 50px;
  }

  .shopcart-wrapper .content-left .desc-wrapper {
    float: left;
    margin-left: 13px;
  }

  .shopcart-wrapper .content-left .desc-wrapper .tip {
    font-size: 12px;
    color: #bab9b9;
    line-height: 51px;
  }

  .shopcart-wrapper .content-left .logo-wrapper.highligh {
    background: #F75940;
  }

  .shopcart-wrapper .content-left .logo-wrapper .logo.highligh {
    color: #2D2B2A;
  }

  .shopcart-wrapper .content-left .logo-wrapper .num {
    width: 15px;
    height: 15px;
    line-height: 15px;
    border-radius: 50%;
    font-size: 9px;
    color: white;
    background: red;
    position: absolute;
    right: 0;
    top: 0;
  }

  .shopcart-wrapper .content-left .desc-wrapper .tip.highligh {
    line-height: 12px;
  }

  .shopcart-wrapper .content-right.highligh {
    background: #F75940;
    color: #2D2B2A;
  }

  .shopcart-wrapper .content-left .desc-wrapper .total-price {
    font-size: 18px;
    line-height: 33px;
    color: white;
  }

  .shopcart-wrapper .shopcart-list {
    position: absolute;
    left: 0;
    top: 0;
    z-index: -1;
    width: 100%;
  }

  .shopcart-wrapper .shopcart-list.show {
    transform: translateY(-100%);
  }

  .shopcart-wrapper .shopcart-list .list-top {
    height: 30px;
    text-align: center;
    font-size: 11px;
    background: #f3e6c6;
    line-height: 30px;
    color: #646158;
  }

  .shopcart-wrapper .shopcart-list .list-header {
    height: 45px;
    background: #F4F4F4;
    text-align: center;
  }

  .shopcart-wrapper .shopcart-list .list-header .title {
    float: left;
    border-left: 4px solid #F75940;
    padding-top: 10px;
    padding-left: 6px;
    line-height: 30px;
    font-size: 12px;
  }

  .shopcart-wrapper .shopcart-list .list-header .empty {
    padding-top: 7px;
    float: right;
    line-height: 30px;
    margin-right: 10px;
    font-size: 0;
  }

  .shopcart-wrapper .shopcart-list .list-header .empty img {
    height: 14px;
    margin-right: 9px;
    vertical-align: middle;
  }

  .shopcart-wrapper .shopcart-list .list-header .empty span {
    font-size: 12px;
    vertical-align: middle;
  }

  .shopcart-wrapper .shopcart-list .list-content {
    max-height: 360px;
    padding-top: 10px;
    overflow: hidden;
    background: white;
  }

  .shopcart-wrapper .shopcart-list .list-content .food-item {
    height: 38px;
    padding: 12px 12px 10px 12px;
    border-bottom: 1px solid #F4F4F4;
  }

  .shopcart-wrapper .shopcart-list .list-content .food-item .desc-wrapper {
    float: left;
    width: 100%;
  }
  .shopcart-wrapper .shopcart-list .list-content .food-item .desc-wrapper .desc-left {
    float: left;
    line-height: 20px;
    width: 170px;
  }

  .shopcart-wrapper .shopcart-list .list-content .food-item .desc-wrapper .desc-left .name {
    font-size: 13px;
    margin-bottom: 6px;

    /* 超出部分隐藏*/
    -webkit-line-clamp: 1;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
    height: 16px;
  }

  .shopcart-wrapper .shopcart-list .list-content .food-item .desc-wrapper .desc-left .unit {
    font-size: 12px;
    color: #B4B4B4;
  }

  .shopcart-wrapper .shopcart-list .list-content .food-item .desc-wrapper .desc-left .description {
    font-size: 8pt;
    color: #B4B4B4;

    /* 超出部分隐藏*/
    overflow: hidden;
    height: 17px;
  }

  .shopcart-wrapper .shopcart-list .list-content .food-item .desc-wrapper .desc-right {
    align-items: center;
    float: right;
    width: 150px;
    -webkit-display:flex;
    display:flex;
    -webkit-align-items:center;
    align-items:center;
    -webkit-justify-content:center;
    justify-content:center;
  }

  .shopcart-wrapper .shopcart-list .list-content .food-item .desc-wrapper .desc-right .price {
    font-size: 12px;
    line-height: 38px;
  }

  .shopcart-wrapper .shopcart-list .list-content .food-item .desc-wrapper .desc-right .text {
    margin-right: 10px;
  }

  .shopcart .shopcart-mask {
    position: fixed;
    top: 0;
    right: 0;
    width: 100%;
    height: 100%;
    z-index: 98;
    background: rgba(7, 17, 27, 0.6);
  }

</style>
