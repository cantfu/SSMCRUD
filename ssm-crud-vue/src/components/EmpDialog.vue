<template>
  <div class="EmpDialog">
    <el-dialog :title="title" :visible.sync="empDialogVisible" >
      <el-form :model="form" :rules="rules" ref="form" label-position="right" label-width="80px" size="small">
        <el-form-item label="姓名" :label-width="formLabelWidth" prop="empName">
          <el-input v-model="form.empName" placeholder="输入2-8位的员工姓名" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="性别" :label-width="formLabelWidth" prop="gender">
          <el-radio-group v-model="form.gender">
            <el-radio label="M">男</el-radio>
            <el-radio label="F">女</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="邮箱"  :label-width="formLabelWidth" prop="email">
          <el-input v-model="form.email" placeholder="abc@xx.com" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="部门" :label-width="formLabelWidth" prop="dept">
          <el-select  v-model="form.dId" placeholder="请选择员工部门">
            <el-option v-for="dept in depts" :key="dept.deptId" :label="dept.deptName" :value="dept.deptId"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="empDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitEmp">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'EmpDialog',
  // 未完成：
  // 1.父子组件双向绑定使得dialog可见性一致  （用 bus 总线）？
  // 2.新增和编辑不一样要分别处理
  // 3.etc.

  /**
   * 组件属性值 
   * @type {String} newEmp、editEmp
   */
  props:['type',''],
  data() {
    return {
      title:'',
      empDialogVisible: true,
      formLabelWidth: '100px',
      form: {
        empName: '',
        gender: '',
        email: '',
        dId: '',
        
      },
      depts: [],
      // 表单校验规则
      rules:{
        empName: [
          { required: true, message: '请输入员工姓名', trigger: 'blur' },
          { pattern:/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/,message:'姓名格式为6-16为的字母或数字、2-5位中文！',trigger: 'blur'}
        ],
        gender:[
          { required: true, message: '请选择员工性别', trigger: 'blur' },
        ],
        email: [
          { required: true, message: '请输入员工邮箱', trigger: 'blur' },
          { pattern:/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/,message:'邮箱格式不正确！',trigger: 'blur'}
        ],
        dept:[
          { required: true, message: '请选择员工性别', trigger: 'blur' },
        ],
      },
    }
  },
  methods: {
    // 表单重置
    reset(formName){
      this.$refs[formName].resetFields();
    },
    submitEmp(){
      console.log(this.form.gender);
      console.log(this.form.dId);

      this.empDialogVisible = false;
    }
  },
  mounted(){
    // 新增员工
    if(this.type == 'newEmp'){
      this.title = '新增员工';
      this.reset('form');
    }
    // 编辑员工信息
    if(this.type == 'editEmp'){
      this.itle == '编辑员工信息';
    }
    // 注入部门信息
    this.$axios.get('depts').then(res=>{
      this.depts = res.data.data.depts;
    }).catch(err=>{
      this.$notify({
          title: '查询部门信息出错',
          message: err,
          type: 'error'
        });
    })
  }
}
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>