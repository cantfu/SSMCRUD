<template>
  <div class="ManagePage">
    <!-- 新增、编辑弹出框 -->
    <!-- <emp-dialog :type="dialogType" :row="dialogRow"></emp-dialog> -->


    <el-container>
      <!-- 头部 -->
      <el-header>
        <h1>{{head}}</h1> 
        
      </el-header>

      <!-- 员工表格内容 -->
      <el-main>
        <el-row>
          <el-button type="danger" icon="el-icon-delete" @click="hadleBatchDelete">批量删除</el-button>
          <el-button type="success" icon="el-icon-plus" @click="newEmpDialogVisible=true">新增</el-button>
        </el-row>

        <el-table :data="empsTable" style="width: 100%" v-loading="loading" @selection-change="hadleSelectionChange">
          <el-table-column type="selection"></el-table-column>
          <el-table-column prop="empId" label="ID" ></el-table-column>
          <el-table-column prop="empName" label="姓名" ></el-table-column>
          <el-table-column prop="gender" :formatter="genderFormat" label="性别" ></el-table-column>
          <el-table-column prop="email" label="邮箱" ></el-table-column>
          <el-table-column prop="department.deptName" label="部门" ></el-table-column>
          <el-table-column prop="ops" label="操作" width="200">
            <template slot-scope="scope">
              <el-button size="mini" type="info" icon="el-icon-edit-outline" 
              @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
              <el-button size="mini" icon="el-icon-delete" type="danger"
                @click="handleDelete(scope.$index, scope.row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
        
      </el-main>

      <!-- 底部分页信息 -->
      <el-footer>
        <el-row>
          <el-col :span="12"><div>
          当前第 <el-badge :value="pageNum" class="item"></el-badge> 页，
          共 <el-badge :value="pages" class="item"></el-badge> 页，
          共 <el-badge :value="total" class="item"></el-badge> 条记录
          </div></el-col>
          <el-col :span="12"><div>
            <el-pagination
              background
              layout="prev, pager, next"
              :total="total" :page-size="pageSize" :current-page="pageNum"
              @current-change="getEmpsWithPage">
            </el-pagination>
          </div></el-col>
        </el-row>
      </el-footer>
    </el-container>

    <!-- 新增员工框 -->
    <div class="newEmpDialog">
      <el-dialog title="新增员工" :visible.sync="newEmpDialogVisible" >
        <el-form :model="newEmpForm" :rules="rules" ref="newEmpForm" label-position="right" label-width="80px" size="small">
          <el-form-item label="姓名" :label-width="formLabelWidth" prop="empName">
            <el-input v-model="newEmpForm.empName" placeholder="输入2-8位的员工姓名" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="性别" :label-width="formLabelWidth" prop="gender">
            <el-radio-group v-model="newEmpForm.gender">
              <el-radio label="M">男</el-radio>
              <el-radio label="F">女</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="邮箱"  :label-width="formLabelWidth" prop="email">
            <el-input v-model="newEmpForm.email" placeholder="abc@xx.com" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="部门" :label-width="formLabelWidth" prop="dept">
            <el-select  v-model="newEmpForm.dId" placeholder="请选择员工部门">
              <el-option v-for="dept in depts" :key="dept.deptId" :label="dept.deptName" :value="dept.deptId"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="newEmpDialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="submitNewEmp">确 定</el-button>
        </div>
      </el-dialog>
    </div>
    <!-- 编辑员工框 -->
    <div class="editEmpDialog">
      <el-dialog title="修改员工信息" :visible.sync="editEmpDialogVisible" >
        <el-form :model="editEmpRow" :rules="rules" ref="editEmpRow" label-position="right" label-width="80px" size="small">
          <el-form-item label="姓名" :label-width="formLabelWidth" prop="empName">
            <el-input v-model="editEmpRow.empName" disabled placeholder="输入2-8位的员工姓名" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="性别" :label-width="formLabelWidth" prop="gender">
            <el-radio-group v-model="editEmpRow.gender">
              <el-radio label="M">男</el-radio>
              <el-radio label="F">女</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="邮箱"  :label-width="formLabelWidth" prop="email">
            <el-input v-model="editEmpRow.email" placeholder="abc@xx.com" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="部门" :label-width="formLabelWidth" prop="dept">
            <el-select  v-model="editEmpRow.dId" placeholder="请选择员工部门">
              <el-option v-for="dept in depts" :key="dept.deptId" :label="dept.deptName" :value="dept.deptId"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="cancleEdit">取 消</el-button>
          <el-button type="primary" @click="submitEditEmp">更 新</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
// import EmpDialog from './EmpDialog.vue'
import QS from 'qs'
export default {
  name: 'ManagePage',
  // components:{
  //   'emp-dialog': EmpDialog
  // },
  data () {
    return {
      head: '员工信息管理',
      // 主体数据
      empsTable: [],
      loading: true,

      // 页码信息
      total: 0, // 总记录数
      pages: 0, // 总页数
      pageNum: 0, // 当前页
      pageSize: 0, // 每页的大小
      // 分页信息
      
      // 表格
      multipleSelection: [], // 当前被选中行的所有信息，就是data中的该行信息

      // 对话框相关 （新增、编辑）
      formLabelWidth: '100px',
      depts: [],
      validate: false, // 校验结果
      // 新增相关
      newEmpDialogVisible: false,
      newEmpForm: {
        empName: '',
        gender: '',
        email: '',
        dId: '',
      },
      // 表单校验规则 共用
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
      // 编辑相关
      editEmpRow: { //编辑时给的该行员工信息
        empName: '',
        gender: '',
        email: '',
        dId: '',
      },
      editEmpDialogVisible: false,
    }
  },
  mounted() {
    this.getEmpsWithPage(1);
    // 注入部门信息
    this.$axios.get('depts').then(res=>{
      this.depts = res.data.data.depts;
    }).catch(err=>{
      this.$notify({
          title: '查询部门信息出错',
          message: err,
          type: 'error'
        });
    });
  },
  methods: {
    // 重置新增员工框的元素
    resetNewEmpDialog(){
      this.newEmpForm.empName='';
      this.newEmpForm.gender='';
      this.newEmpForm.email='';
      this.newEmpForm.dId='';
    },
    // 点击修改员工按钮
    handleEdit (index, row) {
      // 注入该名员工数据
      this.editEmpRow = row;
      this.editEmpDialogVisible = true;
    },
    // 取消更新
    cancleEdit(){
      this.editEmpDialogVisible = false;
      this.$message('取消编辑！');
      this.getEmpsWithPage(this.pageNum);
    },
    // 提交修改员工信息
    submitEditEmp(){
      let id = this.editEmpRow.empId;
      let name = this.editEmpRow.empName;
      let data = QS.stringify({
        'empName':this.editEmpRow.empName,
        'gender':this.editEmpRow.gender,
        'email':this.editEmpRow.email,
        'dId':this.editEmpRow.dId
      });
      this.$axios.put('emp/'+id,data).then(res=>{
        if(res.data.code == '0000'){
          this.editEmpDialogVisible = false;
          this.notify(name,'已成功修改员工信息','success');
        }else if(res.data.code == '1111'){
          this.notify(name,res.data.data.error,'error');
          this.getEmpsWithPage(this.pageNum);
        }
      }).catch(err=>{
        this.notify('异常',err,'error');
        this.getEmpsWithPage(this.pageNum);
      });

    },
    // 新增员工
    submitNewEmp(){
      if(this.newEmpForm.gender=='' || this.newEmpForm.dId=='') {
        this.$message('所有带"*"的为必填字段！');
        return false;
      }
      let name = this.newEmpForm.empName;
      let data = QS.stringify({
        'empName':this.newEmpForm.empName,
        'gender':this.newEmpForm.gender,
        'email':this.newEmpForm.email,
        'dId':this.newEmpForm.dId
      });

      this.$axios.post('emp',data).then(res=>{
        if(res.data.code == '0000'){
          this.notify(name,'已添加员工信息','success');
          // 重置
          this.resetNewEmpDialog();
          this.editEmpDialogVisible = false;
          this.getEmpsWithPage(this.pages+1); // 加一防止，添加员工后加了一页
        }else if(res.data.code == '1111'){
          this.notify(name,res.data.data.error,'error');
        }

      }).catch(err=>{
        this.notify('异常',err,'error');
      });

      
    },

    // 单个行内删除员工
    handleDelete (index, row) {
      var name = row.empName;
      // console.log(name+":"+row.empId);
      //确认删除框
      this.$confirm('即将删除员工 '+name+' 的信息, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          //删除请求
          this.sendDeleteRequest(row.empId,name);
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          }); 
        })   
    },
    
    // 批量删除员工
    hadleBatchDelete(){
      // console.log(this.multipleSelection.length);
      if (!this.multipleSelection.length){
        this.$message({
          message:'您还什么都没选呢0.0',
          showClose: true,
          type:'error',
        });
        return false;
      }
      // 待删除的id '-'拼接，eg. 1-2-3
        var idsStr = '';
        var nameStr = '';
        this.multipleSelection.forEach((val,i) => {
          idsStr+=val.empId+'-';
          nameStr+=' '+val.empName;
        });
        idsStr = idsStr.substr(0,idsStr.length - 1);
        // console.log(idsStr+'\n'+nameStr);
      // 确认删除
      this.$confirm('即将删除员工'+nameStr+'的信息, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // 删除请求
        this.sendDeleteRequest(idsStr,nameStr);       
      }).catch((err) => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });   
      }); 
      
    },
    // 发送删除请求 idStr=
    sendDeleteRequest (idStr,name){
      this.$axios.delete('emp/'+idStr)
        .then((res) => {
          if(res.data.code == '0000'){
            this.notify(name,'成功删除所选员工的信息','success');
            //结果回应
            this.getEmpsWithPage(this.pageNum);
          }else if(res.data.code == '1111') {
            this.notify(name,'删除失败','error');
          }
        })
        .catch((err) => {
          this.notify('异常',err,'error');
        });
    },
    
    // 表格选中行改变（增、减）
    hadleSelectionChange(val) {
      this.multipleSelection = val;
      // console.log(this.multipleSelection);
    },
    // 性别格式化
    genderFormat(row, column){
      return row.gender == 'M' ? '男' : '女';
    },
    // 获取 pageNo 页的员工信息
    getEmpsWithPage (pageNo) {

      this.loading = true;
      this.$axios.get('emps',{params:{pageNo:pageNo}})
        .then((res) => {
          var pageInfo = res.data.data.pageInfo;
          // console.log(pageInfo);
          this.empsTable = pageInfo.list;
          this.total = pageInfo.total;
          this.pages = pageInfo.pages;
          this.pageNum = pageInfo.pageNum;
          this.pageSize = pageInfo.pageSize;
          this.loading = false;
      })
        .catch((err)=> {
          this.notify('错误信息','获取员工信息错误','info');
        })
    },
    // 通用弹出消息
    notify(title,msg,type){
      this.$notify({
          title: title,
          message: msg,
          type: type
        });
    }
  }
  
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1{
  margin: 0px;
  padding-top: 20px;
  text-align: center;
}
.el-main{
  padding-top: 0px;
}
/*.el-container{
  background: #F5F5F5;
}*/
.el-container {
  /*border-radius: 2px;*/
}
</style>
