// sql语句
var sqlMap = {
  // 用户
  waiter: {
    add: 'insert into waiter(account, password) values (?, ?)',
    select_account: 'SELECT * from waiter where account=?',
    select_password: 'SELECT * from waiter where password=?',
    insert_order: 'insert into bill(m_list, m_price, m_table) values (?, ?, ?)'
  }
}
module.exports = sqlMap;
