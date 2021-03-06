<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ro" style="background-color: #ffffff !important">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/img/favico.png">

    <title>Login</title>

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/css/signin.css" rel="stylesheet">
    <style>
        .error {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #a94442;
            background-color: #f2dede;
            border-color: #ebccd1;
            width: 300px;
            margin-left: auto;
            margin-right: auto;
        }

        .msg {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #31708f;
            background-color: #d9edf7;
            border-color: #bce8f1;
            width: 300px;
            margin-left: auto;
            margin-right: auto;
        }

    </style>
</head>

<body class="text-center" style="background: #ffffff !important">

<div class="container">


    <form:form class="form-signin" name='loginForm' action="/login" method="POST">
        <h2 class="form-signin-heading"><img style="margin-top: 6px;" width="200" src="/img/logoLogin.png"/></h2>
        <input id="username" name="username" type="text" autocomplete="off" class="form-control" placeholder="<spring:message code="USER" />"/>
        <input name="password" type="password" class="form-control" placeholder="<spring:message code="PASSWORD" />"/>
        <button id="btnLogin" class="btn btn-lg btn-primary btn-block" type="submit"> Sign in</button>
    </form:form>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    <c:if test="${not empty notActive}">
        <div class="error">${notActive}</div>
    </c:if>
    <c:if test="${not empty msg}">
        <div class="msg">${msg}</div>
    </c:if>

</div>
<!-- /container -->
<%--<div id="downloadChrome" class="jumbotron" style="width: 60%;height:auto; margin-left:auto; margin-right: auto;">--%>
    <%--<div>--%>
    <%--<h3><spring:message code="DOWNLOADCHROME" /></h3>--%>
    <%--<div>--%>
    <%--<a class="btn btn-primary pull-right" href="http://google.com">Google Chrome</a>  <a class="btn btn-primary pull-right" href="">Chromium</a>--%>
    <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>
<script src="/js/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script type="application/javascript">

    $(document).ready(function(){
        $(".container").show();
        $('#username').focus();
    });
</script>
