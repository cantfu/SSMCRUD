<template>
  <div id="app">
    <el-row>
      <el-col :span="2"><div class="grid-content"></div></el-col>
      <el-col :span="20"><div class="grid-content">
        <router-view></router-view>
      </div></el-col>
      <el-col :span="2"><div class="grid-content"></div></el-col>
    </el-row>
    <!-- <router-view/> -->
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
body{
  margin: 0px;
}
#app {
  font-family: "Helvetica Neue",Helvetica,"PingFang SC","Hiragino Sans GB","Microsoft YaHei","微软雅黑",Arial,sans-serif;
  /*background: #aaaf67a8;*/
}
  .el-row {
    margin-bottom: 20px;
    &:last-child {
      margin-bottom: 0;
    }
  }
  
  .grid-content {
    border-radius: 4px;
    min-height: 1px;
  }

</style>
