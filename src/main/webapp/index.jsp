<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>员工列表</title>

  <%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
  %>
  <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
  <script src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
  <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <div class="row">
    <div class="col-md-1"></div>
    <%--主要内容--%>
    <div class="col-md-10">
      <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">
          <h3 align="center">员工列表管理</h3>
          <div class="form-group" style="margin-bottom: 0px">
            <button id="multi_delete_btn" class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span> 批量删除</button>
            <button id="new_emp_btn" type="button" class="btn btn-success" data-toggle="modal" data-target="#new_emp_modal"><span class="glyphicon glyphicon-plus"></span> 新增</button>
          </div>
        </div>
        <div class="panel-body">
          <!-- 员工列表 -->
          <table class="table table-hover">
            <thead>
            <tr>
              <th><span><input id="check_all" type="checkbox"/>全选</span></th>
              <th>ID</th>
              <th>员工姓名</th>
              <th>员工性别</th>
              <th>邮箱</th>
              <th>部门</th>
              <th>操作</th>
            </tr>
            </thead>
            <tbody id="emps_table_body"></tbody>


          </table>
          <%--分页信息--%>
          <div class="row">
            <%--左侧文字信息--%>
            <div class="col-md-6" id="page_info">

            </div>
            <%--右侧分页信息--%>
            <div class="col-md-6">
              <div class="">
                <ul id="page_nav" class="pagination" style="margin: 0px">

                </ul>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>
    <div class="col-md-1"></div>
  </div>
</div>

<%--新增员工模态框--%>
<div id="new_emp_modal" class="modal fade" data-backdrop="false" tabindex="-1" role="dialog" aria-labelledby="newEmpHead">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="newEmpHead">新增员工</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
          <div class="form-group">
            <%--新增姓名--%>
            <label for="new_emp_name" class="col-sm-2 control-label">姓名：</label>
            <div class="col-sm-8">
              <input type="text" name="empName" class="form-control" id="new_emp_name" placeholder="姓名">
              <span class="help-block"></span>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label">性别：</label>
            <div class="col-sm-8">
              <label class="radio-inline">
                <input type="radio" name="gender" id="gender_m" value="M" checked> 男
              </label>
              <label class="radio-inline">
                <input type="radio" name="gender" id="gender_f" value="F"> 女
              </label>
            </div>
          </div>

          <div class="form-group">
            <label for="new_emp_email" class="col-sm-2 control-label">邮箱：</label>
            <div class="col-sm-8">
              <input type="text" name="email" class="form-control" id="new_emp_email" placeholder="Email">
              <span class="help-block"></span>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label">部门：</label>
            <div class="col-sm-4">
              <select name="dId" class="form-control">

              </select>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button id="save_emp_btn" type="button" class="btn btn-primary">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%--修改员工模态框--%>
<div id="update_emp_modal" class="modal fade" data-backdrop="false" tabindex="-1" role="dialog" aria-labelledby="updateEmpHead">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="updateEmpHead">修改员工信息</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
          <div class="form-group">
            <%--姓名--%>
            <label for="update_emp_name" class="col-sm-2 control-label">姓名：</label>
              <div class="col-sm-8">
                <p class="form-control-static" id="update_emp_name">...</p>
              </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label">性别：</label>
            <div class="col-sm-8">
              <label class="radio-inline">
                <input type="radio" name="gender" value="M" checked> 男
              </label>
              <label class="radio-inline">
                <input type="radio" name="gender" value="F"> 女
              </label>
            </div>
          </div>

          <div class="form-group">
            <label for="update_emp_email" class="col-sm-2 control-label">邮箱：</label>
            <div class="col-sm-8">
              <input type="text" name="email" class="form-control" id="update_emp_email" placeholder="Email">
              <span class="help-block"></span>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label">部门：</label>
            <div class="col-sm-4">
              <select name="dId" class="form-control">

              </select>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button id="save_updatedEmp_btn" type="button" class="btn btn-primary">更新</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<%--///////////////修改员工信息//////////////////--%>


<script type="text/javascript">
  $(function () {
    var currentPageNum = 1;
    // 当前的总页数 + 1,用于新增后跳转
    var maxPageNum = 0;
    sendAjax(1);

    // 获取pageNo的员工页
    function sendAjax(pageNo) {
      $.ajax({
        url: "${APP_PATH}/emps",
        data: "pageNo=" + pageNo,
        type: "GET",
        success: function (result) {
          console.log(result);
          bulid_emps_table(result);
          buid_pageInfo(result);
          buid_page_nav(result);
        },
        error: function () {
          alert("请求失败！");
        }

      });
    }

    // 添加员工表
    function bulid_emps_table(result) {
      // 清空之前的查询
      $("#emps_table_body").empty();

      var emps = result.data.pageInfo.list;
      $.each(emps, function (index, item) {
        var id = $('<td></td>').append(item.empId);
        var name = $('<td></td>').append(item.empName);
        var gender = $('<td></td>').append((item.gender == "M") ? "男" : "女");
        var email = $('<td></td>').append(item.email);
        var dept = $('<td></td>').append(item.department.deptName);
        // 操作列

        var edit = $('<button></button>').attr({"type":"button","edit-id":item.empId}).addClass("btn btn-primary btn-sm update-btn").append(
            $('<span></span>').addClass("glyphicon glyphicon-edit")
        ).append(" 修改");
        var delete_ele = $('<button></button>').attr({"type":"button","delete-id":item.empId}).addClass("btn btn-danger btn-sm delete-btn").append(
            $('<span></span>').addClass("glyphicon glyphicon-trash")
      ).append(" 删除");

        var ops = $('<td></td>').append(edit).append(" ").append(delete_ele);


        $("#emps_table_body").append(
            $('<tr></tr>').append('<td><input class="check-item" type="checkbox" /></td>')
                .append(id)
                .append(name)
                .append(gender)
                .append(email)
                .append(dept)
                .append(ops)
        );
      });
    }

    // 分页信息
    function buid_pageInfo(result) {
      // 清空之前的查询
      $("#page_info").empty();

      var page = result.data.pageInfo;
      maxPageNum = page.pages+1;
      currentPageNum = page.pageNum;
      $("#page_info").append('当前第 <span class="badge">'
          + page.pageNum
          + '</span> 页,共 <span class="badge">'
          + page.pages
          + '</span> 页,共 <span class="badge">'
          + page.total
          + '</span> 条记录');
    }

    // 分页导航条信息
    function buid_page_nav(result) {
      // 清空之前的查询
      $("#page_nav").empty();

      var navNums = result.data.pageInfo;

      // 首页 加前一页
      var firstPageNav = $("<li></li>").append($("<a></a>").append("首页").click(function () {
        sendAjax(1);
      }));
      $("#page_nav").append(firstPageNav);
      if (navNums.hasPreviousPage) {
        var prePage = $("<li></li>").append($("<a>&laquo;</a>").click(function () {
          sendAjax(navNums.prePage);
        }));
        $("#page_nav").append(prePage);
      }

      $.each(navNums.navigatepageNums, function (index, item) {
        var subNav = $("<li></li>").append($("<a></a>").append(item));
        if (navNums.pageNum == item) {
          subNav.addClass("active");
        }
        subNav.click(function () {
          sendAjax(item);
        });
        $("#page_nav").append(subNav);
      });
      // 后一页 加末页
      if (navNums.hasNextPage) {
        var nextPage = $("<li></li>").append($("<a>&raquo;</a>").click(function () {
          sendAjax(navNums.nextPage);
        }));
        $("#page_nav").append(nextPage);
      }
      var lastPageNav = $("<li></li>").append($("<a></a>").append("末页").click(function () {
        sendAjax(navNums.pages);
      }));
      $("#page_nav").append(lastPageNav);

    }

    // 新增员工模态框注入部门信息
    $("#new_emp_btn").click(function () {
      // 表单重置
      $("#new_emp_modal form")[0].reset();
      $("#new_emp_modal form span.help-block").text("");
      $("#new_emp_modal select").empty();

      inject_dept_options("#new_emp_modal select");
    });
    // 查询部门信息注入到 模态框 ele 的 select 中
    function inject_dept_options(ele) {
      $.ajax({
        url: "${APP_PATH}/depts",
        type: "GET",
        success: function (result) {
          $.each(result.data.depts,function (index,item) {
            $(ele).append($("<option></option>").attr("value",item.deptId).append(item.deptName));
          });
        },
        error: function (result) {
          alert("请求失败！");
        }
      });
    }

    // 保存新增员工 按钮事件，先校验
    // 显示校验信息
    function show_validate_msg(ele,status,msg) {
      if("success" == status){
        $(ele).parent().removeClass("has-success has-error").addClass("has-success");
        $(ele).next("span").text(msg);
      }else if("error" == status){
        $(ele).parent().removeClass("has-success has-error").addClass("has-error");
        $(ele).next("span").text(msg);
      }
    }
    // 校验名称可用
    function checkEmpName() {
      var empName = $("#new_emp_name").val();
      $.ajax({
        url: "${APP_PATH}/checkuser",
        type: "POST",
        data: "empName="+empName,
        success: function (result) {
          if(result.code == "0000"){
            show_validate_msg("#new_emp_name","success","名称可用！");
          }
          if(result.code == "1111"){
            show_validate_msg("#new_emp_name","success","名称已被注册！");
            $("#save_emp_btn").attr("validate-res","error");
          }
        }
      });
    }
    // 新增员工 表单验证
    function new_emp_validate(){
      show_validate_msg("#new_emp_name","success","");
      show_validate_msg("#new_emp_email","success","");

      // 1.
      var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
      if(!regName.test($("#new_emp_name").val())){
        show_validate_msg("#new_emp_name","error","姓名格式为6-16为的字母或数字、2-5位中文！");
        $("#save_emp_btn").attr("validate-res","error");
        return false;
      }
      // 2.
      checkEmpName();

      // 3.性别不为空

      // 4.
      var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
      if(!regEmail.test($("#new_emp_email").val())){
        show_validate_msg("#new_emp_email","error","邮箱格式不正确！");
        $("#save_emp_btn").attr("validate-res","error");
        return false;
      }
      $("#save_emp_btn").attr("validate-res","success");
    }
    // 为change事件绑定检验
    $("#new_emp_name").change(function () {
      new_emp_validate();

    });
    $("#new_emp_email").change(function () {
      new_emp_validate();
    });
    // 新增
    $("#save_emp_btn").click(function () {
      if( $(this).attr("validate-res") == "error"){
        return false;
      }
      $.ajax({
        url: "${APP_PATH}/emp",
        type: "POST",
        data: $("#new_emp_modal form").serialize(),
        success: function (result) {
          alert(result.msg);
          $("#new_emp_modal").modal("hide");
          sendAjax(maxPageNum);

        },
        error: function (result) {
          alert("保存失败！");
        }
      });
    });

    // 为修改(编辑)按钮绑定事件
    $("#emps_table_body").on("click",".update-btn",function(){
      $("#update_emp_modal").modal({
        backdrop:'static'
      });
      // 查部门
      $("#update_emp_modal select").empty();
      inject_dept_options("#update_emp_modal select");
      // 查员工
      var id = $(this).attr("edit-id");
      $("#save_updatedEmp_btn").attr("edit-id",id);
      $.ajax({
        url: '${APP_PATH}/emp/'+id,
        type: 'GET',
        success: function (result) {
          $("#update_emp_name").text(result.data.emp.empName);
          $("#update_emp_email").val(result.data.emp.email);
          $("#update_emp_modal input[name='gender']").val([result.data.emp.gender]);
          $("#update_emp_modal select").val([result.data.emp.dId]);

        }
      });
    });

    // 为更新按钮绑定事件
    $("#save_updatedEmp_btn").click(function () {
      // 1.校验邮箱
      var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
      if(!regEmail.test($("#update_emp_email").val())){
        show_validate_msg("#update_emp_email","error","邮箱格式不正确！");
        return false;
      }
      var empId = $(this).attr("edit-id");
      // 2.提交保存
      $.ajax({
        url: '${APP_PATH}/emp/'+empId,
        type: 'PUT',
        data: $("#update_emp_modal form").serialize(),
        success: function (result) {
          alert("处理成功！");
          $("#update_emp_modal").modal('hide');
          sendAjax(currentPageNum);

        },
        error: function () {
          alert("请求出错!");
        }
      });

    });

    // 发送删除信息 ids为要删除的以'-'连接的id
    function sendDelete(ids) {
      $.ajax({
        url: '${APP_PATH}/emp/'+ids,
        type: "DELETE",
        success: function (res) {
          alert("成功删除 "+res.data.deleteRow+" 人信息!");
          // 刷新当前页
          sendAjax(currentPageNum);
        },
        error: function () {
          alert("删除失败!");
        }
      });
    }
    // 为删除按钮绑定事件
    $("#emps_table_body").on("click",".delete-btn",function () {
      var empName = $(this).parent().parent().find("td").eq(2).text();
      // 1.弹出确认框
      if(!confirm("确认要删除员工 '"+empName+"' 的信息吗？")){
        return false;
      }
      var deleteId = $(this).attr("delete-id");
      //2.删除
      sendDelete(deleteId);

    });

    // 全选、全不选功能
    $("#check_all").click(function () {
      $(".check-item").prop("checked",$(this).prop("checked"));
    });
    // item全选时，全选自动选中
    $("#emps_table_body").on("click",".check-item",function () {
      var allChecked = ($("#emps_table_body .check-item[checked='checked']").length == $(".check-item").length);
    $("#check_all").prop("checked",allChecked);

    });

    // 批量删除
    $("#multi_delete_btn").click(function () {
      if(!confirm("确认要删除所选多个员工的信息吗？")) {
        return false;
      }
      var deleteIds="";
      $.each($(".check-item:checked"),function (index,item) {
        deleteIds += $(this).parents("tr").find("td:eq(1)").text()+"-";
      });
      deleteIds = deleteIds.substring(0,deleteIds.length-1);
      // alert(deleteIds);
      sendDelete(deleteIds);
    });
  });


</script>

</body>
</html>
