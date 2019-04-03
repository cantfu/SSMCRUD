<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>

    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" >
    <script src="${APP_PATH}/static/js/jquery-3.3.1.min.js" ></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" ></script>
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
                        <button class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span> 批量删除</button>
                        <button type="button" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span> 新增</button>
                    </div>
                </div>
                <div class="panel-body">
                    <!-- 员工列表 -->
                    <table class="table table-hover">
                        <tr>
                            <th><span><input type="checkbox" />全选</span></th>
                            <th>ID</th>
                            <th>员工姓名</th>
                            <th>员工性别</th>
                            <th>邮箱</th>
                            <th>部门</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach var="emp" items="${page.list}">
                            <tr>
                                <td><input type="checkbox" /></td>
                                <td>${emp.empId}</td>
                                <td>${emp.empName}</td>
                                <td>${emp.gender == "M" ? "男" : "女"}</td>
                                <td>${emp.email}</td>
                                <td>${emp.department.deptName}</td>
                                <td>
                                    <button type="button" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-edit"></span> 修改</button>
                                    <button type="button" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash"></span> 删除</button>
                                </td>
                            </tr>
                        </c:forEach>

                    </table>
                    <%--分页信息--%>
                    <div class="row">
                        <%--左侧文字信息--%>
                        <div class="col-md-6">
                            当前第 <span class="badge">${page.pageNum}</span> 页,共 <span class="badge">${page.pages}</span> 页,共 <span class="badge">${page.total}</span> 条记录
                        </div>
                        <%--右侧分页信息--%>
                        <div class="col-md-6">
                            <div class="">
                                <ul class="pagination" style="margin: 0px">
                                    <li><a href="${APP_PATH}/emps?pageNo=1">首页</a></li>
                                    <%--前一页--%>
                                    <c:if test="${page.hasPreviousPage}">
                                        <li><a href="${APP_PATH}/emps?pageNo=${page.prePage}">&laquo;</a></li>
                                    </c:if>
                                    <c:forEach items="${page.navigatepageNums}" var="pageNo">
                                        <c:if test="${pageNo == page.pageNum}">
                                            <li class="active"><a href="#">${pageNo}</a></li>
                                        </c:if>
                                        <c:if test="${pageNo != page.pageNum}">
                                            <li><a href="${APP_PATH}/emps?pageNo=${pageNo}">${pageNo}</a></li>
                                        </c:if>
                                    </c:forEach>
                                    <%--后一页--%>
                                    <c:if test="${page.hasNextPage}">
                                        <li><a href="${APP_PATH}/emps?pageNo=${page.nextPage}">&raquo;</a></li>
                                    </c:if>

                                    <li><a href="${APP_PATH}/emps?pageNo=${page.pages}">末页</a></li>
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

</body>
</html>
