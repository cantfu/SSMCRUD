# ssm-crud-vue

> SSM and vue project
+ ElementUI
+ axios
+ vue-router ?

## Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report
```

## 开发过程

### 1.初始化

``` bash
vue init webpack ssm-crud-vue
cd ssm-crud-vue/
cnpm install
```

编辑package.json文件，可在script属性的dev后面添加运行端口号，如：--port 8083。默认(不添加)为8080端口号。

此时即可运行项目

``` bash
npm run dev
```

### 2.引入 ElementUI、axios

注：npm 会可能很慢的，耐心等待:happy:,有时候运行显示缺少包，可能是cnpm的问题，删除node_modules/文件夹，重新安装，cnpm install

> 导入ElementUI

``` bash
npm install element-ui --save
```

在main.js中全局导入此模块。（也可以按需导入子模块，参见[官方网站](http://element-cn.eleme.io/#/zh-CN/component/quickstart)的说明）。编辑main.js

``` js
import Vue from 'vue'
import router from './router'
import ElementUI from 'element-ui'//添加新行
import 'element-ui/lib/theme-chalk/index.css'//添加新行

import App from './App'

Vue.use(ElementUI);//添加新行
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  render: h => h(App)
})

```

>  导入 axios:
>
>  详情可查看[ axios 使用说明 ](<https://www.kancloud.cn/yunye/axios/234845>)

``` bash
npm install axios --save
```

在main.js中将axios 加入到Vue 原型链中。

``` js
import axios from 'axios'
Vue.prototype.$axios = axios
```

### 3.**接口约定**

| 接口               | 参数                          | 说明                                       |
| ------------------ | :---------------------------- | :----------------------------------------- |
| /emps              | pageNo:要查询的页码           | 员工列表(分页查询)，Json数据，封装返回结果 |
| /emp/{id}  GET     | id:Integer                    | 按id查询员工                               |
| /emp  POST         |                               | 新增员工                                   |
| /emp/{id}  PUT     | e:Employee                    | 修改员工信息                               |
| /emp/{ids}  DELETE | ids:String，多个id则以'-'隔开 | 删除员工信息                               |
| /checkuser         | empName:String,待检查的姓名   | 新增或修改用户信息时，检查username是否可用 |
| /depts             |                               | 所有部门信息，封装结果                     |



### 4. 小坑

1. 使用 axios 时 then() 或 catch() 时应使用箭头函数。保证其中的 this 指向 Vue。

   ``` js
   this.$axios.get('emps',{params:{pageNo:pageNo}})
           .then((res) => {
             console.log(this);
         })
           .catch((err)=> {
             console.log(this);
           })
   ```

2. 使用 ElementUI 的 container 时，`<el-container>` 的子元素**只能**是后四者，`el-header` 等的父元素也**只能**是 `<el-container>`。

3. 表格数据中 性别由 M/F 转化为 男/女,在`<el-table-column`中添加formatter属性，绑定一个函数。

   ```js
   <el-table-column prop="gender" :formatter="genderFormat" label="性别" width="70"></el-table-column>
   
   // 性别格式化
   genderFormat(row, column){
       return row.gender == 'M' ? '男' : '女';
   },
   ```

4. 做分页时，element 的分页组件 只要绑定好 `总记录数` `总页数` `当前页` `每页的大小` 就可以了。这里后端是配合 pageHelper 使用的。

5. 表格选中多行：在 `el-table` 上添加事件`@selection-change`，其回调函数参数即为 所选中的行（含有该行的data所有信息）。

6. 考虑封装 dialog 为emp-dialog，使得编辑和新增可以共用。

7. 用axios发送post请求时，自动将数据变为 request payload,而不是form data。

   解决办法：

   1. 配置请求头，可以全局配置

      ```js
      // 配置请求头
      axios.defaults.headers.post['Content-Type']='application/x-www-form-urlencoded;charset=UTF-8';
      ```

   2. 在调用post 方法时引入 qs 模块

      ```js
      import QS from 'qs'
      ```

   3. qs 格式化并调用（下面是在 vue 中）

      ```js
      let data = QS.stringify({
          'empName':this.newEmpForm.empName,
          'gender':this.newEmpForm.gender,
          'email':this.newEmpForm.email,
          'dId':this.newEmpForm.dId
      });
      
      this.$axios.post('emp',data).then(res=>{}).catch(err=>{});
      ```
