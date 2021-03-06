<%-- 
    Document   : userInfo
    Created on : 2018-1-22, 12:31:50
    Author     : lol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
        <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>向阳小队专版OJ</title>
                <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/comm/layui/css/layui.css" />
                <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/comm/layui/css/modules/layer/default/layer.css" />
                <link rel="stylesheet" href="${pageContext.request.contextPath}/res/layui/css/layui.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/global.css">
                <script src="${pageContext.request.contextPath}/comm/layui/layui.js" charset="utf-8"></script>
                <script src="${pageContext.request.contextPath}/comm/jquery/jquery-2.1.4.js"></script>
                <script src="${pageContext.request.contextPath}/comm/layer/layer.js"></script>
        </head>
        <body>
                <c:import url="top.jsp" />
                <c:if test="${empty user}">
                    <c:set var="info" value="请选择你要查看的用户" scope="session" />
                    <c:redirect url="index.jsp" />
                </c:if>
                <div class="fly-home fly-panel" style="background-image: url(${pageContext.request.contextPath}/img/timg.jpg)">
                        <img src="${pageContext.request.contextPath}/img/timg.jpg">
                        <h1>
                                ${user.userId}(${user.name})
                        </h1>
                        <p class="fly-home-info">
                                <span>${user.signs}</span><br>
                                <span style="color: #FF7200;">积分: ${user.score}</span><br>
                                <i class="iconfont icon-shijian"></i><span>最近登录: ${user.lastLogin}</span>
                                        <c:if test="${identity.lvl == '-99'}">
                                        <br><span>最近ip: ${user.ip}</span>
                                        <c:if test="${isCanShow}">
                                            <a class="layui-btn-normal" href="${pageContext.request.contextPath}/QuestionAction?method=ksms">
                                                      开启考试模式
                                            </a>
                                        </c:if>
                                        <c:if test="${!isCanShow}">
                                            <a class="layui-btn-normal" href="${pageContext.request.contextPath}/QuestionAction?method=ksms">
                                                      关闭考试模式
                                            </a>
                                        </c:if>
                                </c:if>
                        </p>

                        <c:if test="${sessionScope.identity.userId != sessionScope.user.userId}">
                            <div class="fly-sns" data-user="">
                                    <a href="javascript:;" onclick="message22()" class="layui-btn layui-btn-normal fly-imActive" data-type="chat">发送信息</a>
                            </div>
                        </c:if>
                </div>

                <div class="layui-container">
                        <div class="layui-row layui-col-space15">
                                <div class="fly-panel" align="center">
                                        <h3 class="fly-panel-title">${user.userId} 最近通过的题</h3>
                                        <c:if test="${not empty questions}">
                                            <c:forEach items="${questions}" var="q">
                                                <c:if test="${q != ''}">
                                                    <c:if test="${user.userId == questionMap[q].userId}">
                                                        <a class="layui-btn layui-btn-xs layui-btn-warm" href="QuestionAction?method=get&questionId=${q}">
                                                                <i class="layui-icon">&#xe756;${q}.${questionMap[q].title}</i>
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${user.userId != questionMap[q].userId}">
                                                        <a class="layui-btn layui-btn-xs layui-btn-normal" href="QuestionAction?method=get&questionId=${q}">
                                                                <i class="layui-icon">&#xe63c;${q}.<c:if test="${isCanShow}">${questionMap[q].title}</c:if></i>
                                                        </a>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty questions}">
                                            <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><span>没有回答任何问题</span></div>
                                        </c:if>
                                </div>
                                <div class="fly-panel">
                                        <h3 class="fly-panel-title">${user.userId} 最近的代码</h3>
                                        <ul class="jie-row">
                                                <c:if test="${not empty coders}">
                                                    <table class="layui-table" lay-even lay-skin="nob">
                                                            <colgroup>
                                                                    <col width="50">
                                                                    <col width="150">
                                                                    <col width="50">
                                                                    <col width="50">
                                                                    <col width="50">
                                                                    <col width="50">
                                                                    <col width="50">
                                                            </colgroup>
                                                            <thead>
                                                                    <tr>
                                                                            <th>提交编号</th>
                                                                            <th>题目编号</th>
                                                                            <th>提交时间</th>
                                                                            <th>运行状态</th>
                                                                            <th>运行时间</th>
                                                                            <th>提交者</th>
                                                                            <th>操作</th>
                                                                    </tr> 
                                                            </thead>
                                                            <tbody>
                                                                    <c:forEach items="${coders}" var="q">
                                                                        <tr>
                                                                                <td>No.${q.coderId}</td>
                                                                                <td><a href="QuestionAction?method=get&questionId=${q.questionId}" style="color: #01AAED;">No.${q.questionId} <c:if test="${isCanShow}">${questionMap[q.questionId].title}</c:if></a></td>
                                                                                <td>
                                                                                        <jsp:useBean id="dateObject" class="java.util.Date" scope="page"></jsp:useBean>
                                                                                        <jsp:setProperty property="time" name="dateObject" value="${q.time}"/>
                                                                                        <fmt:formatDate value="${dateObject}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                                                </td>
                                                                                <td>
                                                                                        <c:choose>  
                                                                                            <c:when test="${empty q.status || q.status == 0}">
                                                                                                正在运行
                                                                                            </c:when>  
                                                                                            <c:otherwise>
                                                                                                ${applicationScope.coderStatus[q.status + 6].name}
                                                                                            </c:otherwise>  
                                                                                        </c:choose>
                                                                                </td>
                                                                                <td>
                                                                                        <c:choose>  
                                                                                            <c:when test="${empty q.status || q.status == 0}">
                                                                                                未知
                                                                                            </c:when>  
                                                                                            <c:otherwise>
                                                                                                ${q.endTime - q.startTime}ms
                                                                                            </c:otherwise>  
                                                                                        </c:choose>
                                                                                </td>
                                                                                <td>
                                                                                        <a href="${pageContext.request.contextPath}/UserAction?method=get&userId=${q.userId}">
                                                                                                ${q.userId}
                                                                                        </a>
                                                                                </td>
                                                                                <td><a href="CoderAction?method=get&coderId=${q.coderId}"><button class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe600;</i> 查看</button></a></td>
                                                                        </tr>
                                                                    </c:forEach>
                                                            </tbody>
                                                    </table>
                                                    <div id="pageDiv" align="center"></div>
                                                </c:if>
                                                <c:if test="${empty coders}">
                                                    <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><i style="font-size:14px;">没有任何代码</i></div>
                                                </c:if>
                                </div>

                        </div>
                </div>

                <c:if test="${not empty coders}">
                    <script>
                        layui.use(['laypage', 'layer'], function () {
                            var laypage = layui.laypage
                                    , layer = layui.layer;
                            laypage.render({
                                elem: 'pageDiv'
                                , count: ${coderSize}
                                , theme: '#1E9FFF'
                                , layout: ['count', 'prev', 'page', 'next', 'limit', 'skip']
                                , limit: ${questionLimit}
                                , curr: ${questionPage}
                                , jump: function (obj) {
                                    if (obj.curr != ${questionPage} || obj.limit != ${questionLimit}) {
                                        location.href = "UserAction?method=get&userId=${user.userId}&questionPage=" + obj.curr + "&questionLimit=" + obj.limit;
                                    }
                                }
                            });
                        });
                        //注意：导航 依赖 element 模块，否则无法进行功能性操作
                        layui.use('element', function () {
                            var element = layui.element;

                            //…
                        });
                    </script>
                </c:if>
        </body>
</html>
