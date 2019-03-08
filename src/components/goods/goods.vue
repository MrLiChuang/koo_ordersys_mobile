<template>
  <div class="goods">
    <!--分类列表-->
    <div class="menu-wrapper" ref="menuScroll">
      <div>
        <li
          class="menu-item"
          :class="{'current':currentIndex === index }"
          v-for="(item,index) in goods" :key="index"
          @click="selectMenu(index)"
        >
          <p class="text">
            {{item.name}}
          </p>
          <i class="num" v-show="calculateCount(item.spus)">
            {{calculateCount(item.spus)}}
          </i>
        </li>
      </div>
    </div>

    <!--商品列表-->
    <div class="foods-wrapper" ref="foodScroll">
      <div>
        <!--专场-->
        <!-- 具体分类 -->
        <li v-for="(item,index) in goods" :key="index" class="food-list food-list-hook">
          <h3 class="title">{{item.name}}</h3>
          <!-- 具体的商品列表 -->
            <div>
              <li v-for="(food,index) in item.spus" :key="index" @click="showDetail(food)" class="food-item">
                <div class="icon" :style="head_bg(food.image)"></div>
                <div class="content">
                  <h3 class="name">{{food.name}}</h3>
                  <p class="desc" v-if="food.description">{{food.description}}</p>
                  <p class="price">
                    <span class="text">￥{{food.price}}</span>
                    <span class="unit">/份</span>
                  </p>
                </div>
                <div class="cartcontrol-wrapper">
                  <app-cart-control :food="food"></app-cart-control>
                </div>
              </li>
            </div>
        </li>
      </div>
  </div>
  <!--购物车-->
  <app-shopcart ref="shopcart" :selectFoods="selectFoods" @handleorder="handleorder"></app-shopcart>
  <!-- 商品详情 -->
  <app-product-detail :food="selectFood" ref="foodView" @changedrawer="changedrawer"></app-product-detail>

  <app-order :selectFoods="selectFoods" ref="orderView" @changedrawer="changedrawer"
             @clearshopcart="clearshopcart"></app-order>


  </div>

</template>

<script>
  import BScroll from 'better-scroll'
  import CartControl from '../cartcontrol/CartControl'
  import Shopcart from '../shopcart/Shopcart'
  import ProductDetail from '../productDetail/ProductDetail'
  import Order from '../order/Order'

  export default {
    name: "goods",
    components: {
      "app-shopcart": Shopcart,
      "app-product-detail": ProductDetail,
      "app-order": Order,
      "app-cart-control": CartControl,
    },
    data() {
      return {
        goods: [],
        poiInfo: {},
        listHeight: [],
        menuScroll: {},
        foodScroll: {},
        scrollY: 0,
        selectFood: {}
      }
    },
    created() {
      fetch("../static/data/xxx.json")
        .then(res => res.json())
        .then(response => {
          if (response.code == 0) {
            this.change(response.data)
            //DOM已经更新
            this.$nextTick(() => {
              // 执行滚动方法
              this.initScroll()
              // 计算分类的区间高度
              this.calculateHeight()
      
            })
          }
        })
    },
    computed: {
      currentIndex() {
        for (let i = 0; i < this.listHeight.length; i++) {
          let height1 = this.listHeight[i];
          let height2 = this.listHeight[i + 1];
          if (!height2 || (this.scrollY >= height1 && this.scrollY < height2)) {
            return i;
          }

        }
        return 0
      },
      selectFoods() {
        let foods = []
        this.goods.forEach((item) => {
          item.spus.forEach((food) => {
            if (food.count > 0) {
              foods.push(food)
            }
          })
        })
        return foods
      }
    },
    methods: {
      change(param) {
        var _this = this;
        param.forEach(function (dish, index, array) {
          dish.w_show = true;
          let typeIndex = _this.goods.findIndex(function (typeList, index, array) {
            return typeList.name == dish.type;
          })
          if (typeIndex == -1) {
            var obj = {
              name: '',
              spus: []
            };
            obj.name = dish.type;
            let length = _this.goods.push(obj);
            _this.goods[length - 1].spus.push(dish);
          }
          else {
            _this.goods[typeIndex].spus.push(dish);
          }
        })
      },
      head_bg(imgName) {
        return "background-image: url(" + imgName + ");"
      },
      initScroll() {
        this.menuScroll = new BScroll(this.$refs.menuScroll, {
          click: true
        })
        this.foodScroll = new BScroll(this.$refs.foodScroll, {
          probeType: 3,
          click: true
        })
        //foodScroll监听事件
        this.foodScroll.on("scroll", (pos) => {
          this.scrollY = Math.abs(pos.y)
        })

      },
      calculateHeight() {
        let foodlist = this.$refs.foodScroll.getElementsByClassName("food-list-hook")

        let height = 0
        this.listHeight.push(height)
        for (let i = 0; i < foodlist.length; i++) {
          let item = foodlist[i]
          // 累加
          height += item.clientHeight
          this.listHeight.push(height)
        }
      },
      selectMenu(index) {
        let foodlist = this.$refs.foodScroll.getElementsByClassName("food-list-hook")
        let element = foodlist[index]
        this.foodScroll.scrollToElement(element, 250)
      },
      calculateCount(spus) {
        let count = 0
        spus.forEach((food) => {
          if (food.count > 0) {
            count += food.count
          }
        })
        return count
      },
      showDetail(food) {
        this.selectFood = food;
        this.$refs.foodView.showView()
      },
      refeshscroll() {
        this.foodScroll.refresh()
      },
      changedrawer() {
        this.$emit('changedrawer')
      },
      handleorder() {
        this.$refs.orderView.showView()
      },
      clearshopcart() {
        this.$refs.shopcart.clearAll()
      }
    }
  }
</script>

<style>
  .goods {
    display: flex;
    position: absolute;
    top: 180px;
    bottom: 51px;
    overflow: hidden;
    width: 100%;
  }

  .goods .menu-wrapper {
    z-index: 0;
    flex: 0 0 85px;
    background: #f4f4f4;
  }

  .goods .foods-wrapper {
    flex: 1;
  }

  .goods .menu-wrapper .menu-item {
    list-style-type: none;
    text-align: center;
    padding: 11px 10px 5px 10px;
    border-bottom: 1px solid #E4E4E4;
    position: relative;
  }

  .goods .foods-wrapper {
    flex: 1;
    z-index: 0;
  }

  .goods .menu-wrapper .menu-item .text {
    font-size: 13px;
    color: #333333;
    line-height: 17px;
    vertical-align: middle;
    -webkit-line-clamp: 2;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }

  .goods .menu-wrapper .menu-item .text .icon {
    width: 15px;
    height: 15px;
    vertical-align: middle;
  }

  /* 具体分类商品布局 */
  .goods .foods-wrapper .food-list {
    list-style-type: none;
    padding: 11px;
  }

  .goods .foods-wrapper .food-list .title {
    height: 13px;
    font-size: 13px;
    background: url("img/btn_yellow_highlighted.png") no-repeat left center;
    background-size: 2px 10px;
    padding-left: 7px;
    margin-bottom: 12px;
  }

  .goods .foods-wrapper .food-list .food-item {
    display: flex;
    margin-bottom: 25px;
    position: relative;
  }

  .goods .foods-wrapper .food-list .food-item .icon {
    flex: 0 0 63px;
    background-position: center;
    background-size: 120% 100%;
    background-repeat: no-repeat;
    margin-right: 11px;
    height: 75px;
  }

  .goods .foods-wrapper .food-list .food-item .content {
    flex: 1;
  }

  /* 具体内容样式 */
  .goods .foods-wrapper .food-list .food-item .content .name {
    font-size: 16px;
    line-height: 21px;
    color: #333333;
    margin-bottom: 10px;
    padding-right: 27px;
  }

  .goods .foods-wrapper .food-list .food-item .content .desc {
    font-size: 10px;
    line-height: 19px;
    color: #bfbfbf;
    margin-bottom: 8px;

    /* 超出部分显示省略号*/
    -webkit-line-clamp: 1;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }

  .goods .foods-wrapper .food-list .food-item .content .extra {
    font-size: 10px;
    color: #BFBFBF;
    margin-bottom: 7px;
  }

  .goods .foods-wrapper .food-list .food-item .content .extra .saled {
    margin-right: 14px;
  }

  .goods .foods-wrapper .food-list .food-item .content .product {
    height: 15px;
    margin-bottom: 6px;
  }

  .goods .foods-wrapper .food-list .food-item .content .price {
    font-size: 0;
  }

  .goods .foods-wrapper .food-list .food-item .content .price .text {
    font-size: 14px;
    color: #fb4e44;
  }

  .goods .foods-wrapper .food-list .food-item .content .price .unit {
    font-size: 12px;
    color: #BFBFBF;
  }

  /* 当前选中 */
  .goods .menu-wrapper .menu-item.current {
    background: white;
    font-weight: bold;
    margin-top: -1px;
  }

  .goods .menu-wrapper .menu-item:first-child.current {
    margin-top: 1px;
  }

  .cartcontrol-wrapper {
    position: absolute;
    right: 0;
    bottom: 0;
  }

  .goods .menu-wrapper .menu-item .num {
    position: absolute;
    right: 5px;
    top: 5px;
    width: 13px;
    height: 13px;
    border-radius: 50%;
    color: white;
    background: red;
    text-align: center;
    font-size: 7px;
    line-height: 13px;
  }
</style>
