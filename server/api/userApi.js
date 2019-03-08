var models = require('../db');
var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var $sql = require('../sqlMap');
// 连接数据库
var conn = mysql.createConnection(models.mysql);
conn.connect();
var jsonWrite = function(res, ret) {
  if(typeof ret === 'undefined') {
    res.json({
      code: '1',
      msg: '操作失败'
    });
  } else {
    res.json(ret);
  }
};
// 增加用户接口
router.post('/addUser', (req, res) => {
  var sql_account = $sql.waiter.select_account;
  var sql = $sql.waiter.add;
  var params = req.body;
  console.log(params);
  conn.query(sql_account,params.account,function (err,result) {
    if (err) {
      console.log(err)
    }
    if(result[0]===undefined){
      conn.query(sql, [params.account, params.password], function(err, result) {
        if (err) {
          console.log(err);
        }
        if (result) {
          jsonWrite(res, result);
        }
      })
    }else {
      res.send('-1')
    }
  }
  )
});
//查找用户接口
router.post('/selectUser', (req,res) => {
  var sql_account = $sql.waiter.select_account;
  var sql_password = $sql.waiter.select_password;
  var params = req.body;
  console.log(params);
  conn.query(sql_account,params.account,function(err, result) {
    if(err) {
      console.log(err)
    }
    if(result[0]===undefined) {
      res.send('-1')    //查询不出username，data返回-1
    }else {
      conn.query(sql_password,params.password, function(err, result) {
        if(err) {
          console.log(err)
        }
        if(result[0]===undefined) {
          res.send('0')    //username正确后，password错误，data返回 0
        }else {
          jsonWrite(res, result);
        }
      })
    }
  })
});
//增加账单
router.post('/postorder', (req,res) => {
  var sql_addbill = $sql.waiter.insert_order;
  var params = req.body;
  conn.query(sql_addbill,[params.meal, params.money, params.selected], function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      jsonWrite(res, result);
    }
  })
});

module.exports = router;
