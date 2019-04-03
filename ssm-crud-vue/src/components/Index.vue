<template>
  <div id="Index">
    <div class="block">
      <h2 >网站升级......</h2>
      <el-timeline>
        <el-timeline-item timestamp="2019/4/1" placement="top">
          <el-card>
            <h2>网站建设升级中......</h2>
            <p>cantfu 提交于 2019/4/1 20:46</p>
          </el-card>
        </el-timeline-item>
        <el-timeline-item timestamp="2019/4/..." placement="top">
          <el-card>
            <h2>网站投入使用</h2>
            <p>近期即可使用，别急！</p>
            <p>cantfu 提交于 2019/4/1 21:46</p>
          </el-card>
        </el-timeline-item>
      </el-timeline>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Index',
  data() {
    return {
      
    }
  }
}
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.block>h2{
  margin-top: 20px;
  text-align: center;
}
</style>