<template>
  <transition name="food-detail">
    <div class="order" v-show="showFlag">
      <div class="order-title">
        <div class="icon-back" @click="closeView">
          <img src="@/assets/back.png" height="30">
        </div>
        <div class="text">确认订单</div>
      </div>
      <div class="food-content">
        <div class="food-list" ref="orderView">
          <div>
            <li class="food-item" v-for="(food,index) in selectFoods" :key="index">
              <img class="icon" :src=food.image height="70"></img>
              <div class="content">
                <h3 class="name">{{food.name}}</h3>
                <p class="price">
                  <span class="text">￥{{food.price}}</span>
                  <span class="unit">/份</span>
                </p>
              </div>
              <h3 class="count">×{{food.count}}</h3>
            </li>
          </div>
        </div>

        <div class="up-order">
          <h3 class="text">共计:
            {{totalPrice}}
          </h3>
          <v-select v-model="table" :options="['1','2','3','4','5','6']"
                    :maxHeight="'70px'"
                    :placeholder="'请选择桌号'" class="select">
          </v-select>
          <div class="radios">
            <input type="radio" id="one" value=true v-model="emergency">
            <label for="one">加急</label>
            <input type="radio" id="two" value=false v-model="emergency">
            <label for="two">不加急</label>
          </div>
            <div class="bottom" @click="submit">
            <span class="text">确认</span>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>
<script>
  import BScroll from 'better-scroll'

  export default {
    data() {
      return {
        showFlag: false,
        table: null,
        meal: '',
        price: 0,
        emergency: false
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
        this.price = total
        return total;
      }
    },
    methods: {
      showView() {
        this.$emit('changedrawer')
        this.showFlag = true
        this.$nextTick(() => {
          if (!this.scroll) {
            this.scroll = new BScroll(this.$refs.orderView, {
              click: true
            })
          } else {
            this.scroll.refresh()
          }
        })
        this.totalname()
      },
      closeView() {
        this.$emit('changedrawer');
        this.showFlag = false
      },
      totalname() {
        this.selectFoods.forEach((food) => {
          this.meal += food.id +' '+ food.name + ' ' + food.count + ','
        })
      },
      uploadeorder() {
        this.$http.post('/api/order', {
          table: this.table,
          meal: this.meal,
          price: this.price,
          emergency: this.emergency
        },{emulateJSON:true}).then((response) => {
            if (response.data == '0'){
              this.$toast('订单提交成功')
              this.closeView()
              this.$emit('clearshopcart')
            }else{
              this.$toast('订单提交失败')
           }
        }).catch(function (error) {
          this.$toast('订单提交失败')
          console.log(error)
        })

      },
      submit() {
        if (this.table != null) {
          this.uploadeorder()
        }
        else {
          this.$toast('请选择桌号')
        }
      }
    }
  }

</script>
<style>
  .order {
    position: fixed;
    height: 100%;
    left: 0;
    top: 0;
    bottom: 51px;
    background: white;
    width: 100%;
    z-index: 100;
  }

  .order .order-title {
    float: left;
    width: 100%;
    height: 60px;
    font-size: 18pt;
    background: #F75940;
    align-items: center;
  }

  .order .order-title .icon-back {
    float: left;
    position: fixed;
    margin-top: 14px;
  }

  .order .order-title .text {
    margin-top: 13px;
    color: white;
    text-align: center;
  }

  .food-detail-enter-active, .food-detail-leave-active {
    transition: 0.4s
  }

  .food-detail-enter, .food-detail-leave-to {
    transform: translateX(100%);
  }

  .order .food-content {
    display: flex;
    position: absolute;
    top: 60px;
    bottom: 51px;
    width: 100%;
  }

  .order .food-content .food-list {
    list-style-type: none;
    height: 80%;
    width: 100%;
    overflow: hidden;
    border-bottom: 1px solid #E4E4E4;
  }

  .order .food-content .food-list .food-item {
    display: flex;
    margin-bottom: 25px;
    position: relative;
  }

  .order .food-content .food-list .food-item .icon {
    flex: 0 0 63px;
    margin-left: 20px;
    background-position: center;
    background-size: 120% 100%;
    background-repeat: no-repeat;
    margin-right: 11px;
    height: 75px;
  }

  .order .food-content .food-list .food-item .count {
    float: right;
    margin-right: 20px;
  }

  .order .food-content .food-list .food-item .content {
    flex: 1;
  }

  /* 具体内容样式 */
  .order .food-content .food-list .food-item .content .name {
    font-size: 16px;
    line-height: 21px;
    color: #333333;
    margin-bottom: 10px;
    padding-right: 27px;
  }

  .order .food-content .food-list .food-item .content .price {
    font-size: 0;
  }

  .order .food-content .food-list .food-item .content .price .text {
    font-size: 14px;
    color: #fb4e44;
  }

  .order .food-content .food-list .food-item .content .price .unit {
    font-size: 12px;
    color: #BFBFBF;
  }

  .order .food-content .up-order {
    top: 80%;
    position: absolute;
    flex-direction: column;
  }

  .order .food-content .up-order .text {
    float: left;
    padding-left: 20px;
  }

  .order .food-content .up-order .select {
    margin-top: 15px;
    width: 240px;
    position: fixed;
    margin-left: 35%;
    z-index: 100;
  }
  .order .food-content .up-order .radios {
    float: left;
    margin-top: 30%;
  }
  .order .food-content .up-order .bottom {
    list-style-type: none;
    width: 100%;
    height: 60px;
    background: #393e46;
    position: fixed;
    left: 0;
    bottom: 0;
    display: flex;
  }

  .order .food-content .up-order .bottom .text {
    width: 100%;
    font-size: 20pt;
    text-align: center;
    line-height: 60px;
    color: white;
    z-index: 99;
  }
</style>
