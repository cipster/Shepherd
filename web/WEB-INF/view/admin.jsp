<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="cipster">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <link rel="icon" href="/img/favico.png">

    <title>Shepherd</title>

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/css/navbar-fixed-top.css" rel="stylesheet">
    <link href="/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="/css/chosen.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        input {
            font-size: 13pt!important;
        }
        select {
            font-size: 13pt!important;
        }
    </style>
</head>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>
<div class="container">
    <div class="jumbotron col-md-12" style="min-height: 500px;">
        <div class="list-group col-md-3">
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <a id="adauga" class="list-group-item">
                    <span class="fa fa-plus fa-fw">&nbsp;</span> <spring:message code="ADMIN.ADDPROJ" /></a>
                <a id="modifica" class="list-group-item">
                    <span class="fa fa-pencil fa-fw">&nbsp;</span>
                    <spring:message code="ADMIN.MODPROJ" /></a>
                <a id="sterge" class="list-group-item">
                    <span class="fa fa-remove fa-fw">&nbsp;</span>
                    <spring:message code="ADMIN.DELPROJ" /></a>
                <a id="clienti" class="list-group-item">
                    <span class="fa fa-briefcase fa-fw">&nbsp;</span> <spring:message code="ADMIN.MODCLIENTI" /></a>
            </sec:authorize>
            <a id="utilizatori" class="list-group-item">
                <span class="fa fa-group fa-fw">&nbsp;</span> <spring:message code="ADMIN.MODUSER" /></a>
            <a id="inventar" class="list-group-item">
                <span class="fa fa-cubes fa-fw">&nbsp;</span> <spring:message code="ADMIN.MODINVENTAR" /></a>
        </div>
        <div class="well col-md-9 col-md-offset-0" id="continut">

            <h3 style="text-align: center;" id="sfat"><spring:message code="ADMIN.PLACEHOLDER" /></h3>

            <div id="addProj" style="display: none">
                <c:import url="include/addProj.jsp"></c:import>
            </div>
            <div id="modProj" style="display: none">
                <c:import url="include/modProj.jsp"></c:import>
            </div>
            <div id="delProj" style="display: none">
                <c:import url="include/delProj.jsp"></c:import>
            </div>
            <div id="modClienti" style="display: none">
                <c:import url="include/modClient.jsp"></c:import>
            </div>
            <div id="modUsers" style="display: none">
                <c:import url="include/modUsers.jsp"></c:import>
            </div>
            <div id="modInventar" style="display: none">
                <c:import url="include/modInventar.jsp"></c:import>
            </div>
        </div>
    </div>
</div><!--/.container-->

<div id="alert" class="notifications"></div>

<form action="/logout" method="post" id="logoutForm">
    <input type="hidden" name="${_csrf.parameterName}"
           value="${_csrf.token}"/>
</form>
<footer class="panel-footer">
    <p>&copy; fieldcover 2014 <a href="#"></a> &middot; <a href="#">Shepherd</a></p>
</footer>
</body>
</html>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="/js/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/chosen.jquery.js"></script>
<script src="/js/bootstrap-notify.js"></script>
<script type="text/javascript">
    var unselect = -1;
    function formSubmit() {
        document.getElementById("logoutForm").submit();
    }

    function getAllCod1(){
        var cod1 = $("#cod1-mod-select");
        cod1.html("");

        var idCod1;
        var denumire1;
        $.ajax({
            type: 'get',
            url: '${pageContext.request.contextPath}/api/cod1list',
            contentType: "application/json",
            async: false,
            success: function (response) {
                if(typeof response !== 'undefined') {
                    for (var i = 0; i < response.length; i++) {
                        idCod1 =  response[i].cod1;
                        denumire1 = response[i].denumire1;
                        cod1.append($('<option id="cod1-' + idCod1 + '" label="' + denumire1 +'">').val(idCod1).text(denumire1));
                    }
                }
            },
            error: function (e) {
                alert("Connection error!");
            }
        });
        cod1.val(unselect);
        cod1.trigger("chosen:updated");
    }

    function getCod2ByCod1(idCod1){
        var cod2 = $('#cod2-mod-select');
        cod2.html('');
        var idCod2;
        var denumire2;
        $.ajax({
            type: 'get',
            url: '${pageContext.request.contextPath}/api/cod2list/' + idCod1,
            contentType: "application/json",
            async: false,
            success: function (response) {
                if(typeof response !== 'undefined') {
                    for (var i = 0; i < response.length; i++) {
                        idCod2 =  response[i].cod2;
                        denumire2 = response[i].denumire2;
                        cod2.append($('<option id="cod2-' + idCod2 + '"  label="' + denumire2 + '">').val(idCod2).text(denumire2));
                    }
                }
            },
            error: function (e) {
                alert("Connection error!");
            }
        });
        cod2.val(unselect);
        cod2.trigger('chosen:updated');
    }

    function getArticole(){
        var modArticoleSelect = $("#articol-mod-select");
        modArticoleSelect.html("");

        var idCod3;
        var denumire3;
        var stare;
        var idLoc;
        var dataAdaugare;
        $.ajax({
            type: 'get',
            url: '${pageContext.request.contextPath}/api/articolelist',
            contentType: "application/json",
            async: false,
            success: function (response) {
                if(typeof response !== 'undefined') {
                    for (var i = 0; i < response.length; i++) {
                        idCod3 =  response[i].idCod3;
                        denumire3 = response[i].denumire3;
                        stare = response[i].stare;
                        idLoc = response[i].idLoc;
                        dataAdaugare = response[i].dataAdaugare;
                        modArticoleSelect.append($('<option id="articol' + idCod3 + '" label="' + denumire3 + '" data-stare="' + stare + '"' +
                        ' data-loc="' + idLoc + '" data-data="' + dataAdaugare +'">').val(idCod3).text(denumire3));
                    }
                }
            },
            error: function (e) {
                alert("Connection error!");
            }
        });
        modArticoleSelect.val(unselect);
        modArticoleSelect.trigger("chosen:updated");
    }

    function getLocuri(){
        var modLocSelect = $("#loc-mod-select");
        var locSelect = $("#loc-articol");
        modLocSelect.html("");
        locSelect.html("");

        var idLoc;
        var denumireLoc;
        $.ajax({
            type: 'get',
            url: '${pageContext.request.contextPath}/api/locurilist',
            contentType: "application/json",
            async: false,
            success: function (response) {
                if(typeof response !== 'undefined') {
                    for (var i = 0; i < response.length; i++) {
                        idLoc =  response[i].idLoc;
                        denumireLoc = response[i].denumireLoc;
                        modLocSelect.append($('<option id="loc' + idLoc + '" label="' + denumireLoc + '">').val(idLoc).text(denumireLoc));
                        locSelect.append($('<option id="artloc' + idLoc + '" label="' + denumireLoc + '">').val(idLoc).text(denumireLoc));
                    }
                }
            },
            error: function (e) {
                alert("Connection error!");
            }
        });
        modLocSelect.val(unselect);
        modLocSelect.trigger("chosen:updated");
        locSelect.val(unselect);
        locSelect.trigger("chosen:updated");
    }

    function getPersoane(){
        var modPersoanaSelect = $("#persoana-mod-select");
        var newPersoanaSelect = $("#persoana-select-new");
        modPersoanaSelect.html("");
        newPersoanaSelect.html("");

        var idPersoana;
        var nume;
        var username;
        var cnp;
        var functie;
        $.ajax({
            type: 'get',
            url: '${pageContext.request.contextPath}/api/persoanelist',
            contentType: "application/json",
            async: false,
            success: function (response) {
                if(typeof response !== 'undefined') {
                    for (var i = 0; i < response.length; i++) {
                        idPersoana =  response[i].idPersoana;
                        nume = response[i].nume;
                        username = response[i].username;
                        cnp = response[i].cnp;
                        functie = response[i].functie;
                        modPersoanaSelect.append($('<option id="persoana' + idPersoana + '" label="' + nume + '" data-username="' + username + '"' +
                        ' data-cnp="' + cnp + '" data-functie="' + functie +'">').val(idPersoana).text(nume));
                        newPersoanaSelect.append($('<option id="artpersoana' + idPersoana + '" label="' + nume + '" data-username="' + username + '"' +
                        ' data-cnp="' + cnp + '" data-functie="' + functie +'">').val(idPersoana).text(nume));
                    }
                }
            },
            error: function (e) {
                alert("Connection error!");
            }
        });
        modPersoanaSelect.val(unselect);
        modPersoanaSelect.trigger("chosen:updated");
        newPersoanaSelect.val(unselect);
        newPersoanaSelect.trigger("chosen:updated");
    }

    function getClients(){
        $("#clientselect").html("");
        $("#idClient").html("");
        $("#idClientInput").html("");
        $.ajax({
            type: 'get',
            url: '${pageContext.request.contextPath}/api/clientlist',
            contentType: "application/json",
            async: false,
            success: function (response) {
                if(typeof response !== 'undefined') {
                    for (var i = 0; i < response.length; i++) {
                        $("#clientselect").append($("<option>").val(response[i].idClient).text(response[i].client));
                        $("#idClientInput").append($("<option>").val(response[i].idClient).text(response[i].client));
                        $("#idClient").append($("<option>").val(response[i].idClient).text(response[i].client));
                    }
                }
            },
            error: function (e) {
                alert("Connection error!");
            }
        });
        $("#clientselect").val(unselect);
        $("#clientselect").trigger("chosen:updated");
        $("#idClientInput").val(unselect);
        $("#idClientInput").trigger("chosen:updated");
        $("#idClient").val(unselect);
        $("#idClient").trigger("chosen:updated");

    }

    function getUsers(){
        var idUserSelect = $("#idUserSelect");
        idUserSelect.html("");
        $.ajax({
            type: 'get',
            url: '${pageContext.request.contextPath}/api/userlist',
            contentType: "application/json",
            async: false,
            success: function (response) {
                var idPersoana;
                if(typeof response !== 'undefined') {
                    for (var i = 0; i < response.length; i++) {
                        var username = response[i].username;
                        username = username.replace(/\./g, '-');
                        $.ajax({
                            type: 'get',
                            url: '${pageContext.request.contextPath}/api/userlistpersoane/' + username,
                            contentType: "application/json",
                            async: false,
                            success: function (response) {
                                idPersoana = response.idPersoana;
                            },
                            error: function (e) {
                                alert("Connection error! Nu s-a gasit persoana pentru: " + response[i].username);
                            }
                        });
                        idUserSelect
                                .append( $('<option id="' + response[i].username + '" data-username="' + response[i].username +'" data-password="' + response[i].password +'" data-status="' + response[i].enabled + '" data-persoana="' + idPersoana + '">')
                                        .val(response[i].username).text(response[i].username) );
                    }
                }
            },
            error: function (e) {
                alert("Connection error!");
            }
        });



        idUserSelect.val(unselect);
        idUserSelect.trigger("chosen:updated");
    }

    function getProjects(){
        var idProiectSelect = $("#idProiectSelect");
        var idProiect = $("#idProiect");
        idProiectSelect.html("");
        idProiect.html("");
        $.ajax({
            type: 'get',
            url: '${pageContext.request.contextPath}/api/proiectelist',
            contentType: "application/json",
            async: false,
            success: function (response) {
                if(typeof response !== 'undefined') {
                    for (var i = 0; i < response.length; i++) {
                        idProiectSelect
                                .append($('<option id="' + response[i].idProiect + '" data-nume="' + response[i].numeProiect +'" data-nr="' + response[i].nrProiect +'" data-an="' + response[i].an + '" data-idClient="' + response[i].idClient +'">')
                                        .val(response[i].idProiect).text(response[i].nrProiect + ' ' + response[i].numeProiect + ' ' + response[i].an));
                        idProiect
                                .append($('<option id="' + response[i].idProiect + '" data-nume="' + response[i].numeProiect +'" data-nr="' + response[i].nrProiect +'" data-an="' + response[i].an + '" data-idClient="' + response[i].idClient +'">')
                                        .val(response[i].idProiect).text(response[i].nrProiect + ' ' + response[i].numeProiect + ' ' + response[i].an));


                    }
                }
            },
            error: function (e) {
                alert("Connection error!");
            }
        });
        idProiectSelect.val(unselect);
        idProiectSelect.trigger("chosen:updated");
        idProiect.val(unselect);
        idProiect.trigger("chosen:updated");

    }

    $(document).ready(function () {

        $('#slashadmin').addClass('active');
        $("#adminInput").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Rolul nu exista!"
        });
        $("#idProiect").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Proiectul nu exista!",
            allow_single_deselect: true
        });
        $("#clientselect").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Clientul nu exista!",
            allow_single_deselect: true
        });
        $("#idClient").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Clientul nu exista!",
            allow_single_deselect: true
        });
        $("#idClientInput").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Clientul nu exista!",
            allow_single_deselect: true
        });
        $("#idProiectSelect").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Proiectul nu exista!",
            allow_single_deselect: true
        });
        $("#idUserSelect").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Utilizatorul nu exista!",
            allow_single_deselect: true,
            disable_search_threshold: 5
        });
        $("#statusInput").chosen({
            width: "100%",
            disable_search: true,
            allow_single_deselect: true
        });

        $("#anInput").chosen({
            width: "100%",
            disable_search: true,
            allow_single_deselect: true
        });

        $("#anSelInput").chosen({
            width: "100%",
            disable_search: true,
            allow_single_deselect: true
        });

        $("#newRoluriInput").chosen({
            width: "100%",
            disable_search: true,
            allow_single_deselect: true
        });

        $("#stare-articol").chosen({
            width: "100%",
            disable_search: true,
            allow_single_deselect: true
        });
        $("#stare-articol").val(unselect);
        $("#stare-articol").trigger('chosen:updated');

        $("#persoana-select").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Persoana nu exista!",
            allow_single_deselect: true
        });
        $("#persoana-select").val(unselect);
        $("#persoana-select").trigger('chosen:updated');

        $("#persoana-mod-select").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Persoana nu exista!",
            allow_single_deselect: true
        });
        $("#persoana-mod-select").val(unselect);
        $("#persoana-mod-select").trigger('chosen:updated');

        $("#loc-mod-select").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Persoana nu exista!",
            allow_single_deselect: true
        });
        $("#loc-mod-select").val(unselect);
        $("#loc-mod-select").trigger('chosen:updated');

        $("#articol-mod-select").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Persoana nu exista!",
            allow_single_deselect: true
        });
        $("#articol-mod-select").val(unselect);
        $("#articol-mod-select").trigger('chosen:updated');

        $("#persoana-select-new").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Persoana nu exista!",
            allow_single_deselect: true
        });
        $("#persoana-select-new").val(unselect);
        $("#persoana-select-new").trigger('chosen:updated');

        $("#loc-articol").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Locul nu exista!",
            allow_single_deselect: true
        });
        $("#loc-articol").val(unselect);
        $("#loc-articol").trigger('chosen:updated');

        $("#cod1-mod-select").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Locul nu exista!",
            allow_single_deselect: true
        });
        $("#cod1-mod-select").val(unselect);
        $("#cod1-mod-select").trigger('chosen:updated');

        $("#cod2-mod-select").chosen({
            width: "100%",
            search_contains: true,
            no_results_text: "Locul nu exista!",
            allow_single_deselect: true
        });
        $("#cod2-mod-select").val(unselect);
        $("#cod2-mod-select").trigger('chosen:updated');

        getClients();
        getProjects();

        $("#anSelInput").val(unselect);
        $("#anSelInput").trigger("chosen:updated");
        $("#idProiect").val([]);
        $("#idProiect").trigger("chosen:updated");
        $("#idUserSelect").val([]);
        $("#idUserSelect").trigger("chosen:updated");
        $("#idProiectSelect").val([]);
        $("#idProiectSelect").trigger("chosen:updated");
        $("#clientselect").val([]);
        $("#clientselect").trigger("chosen:updated");

        $("#addProj").css('display', "none");
        $("#modProj").css('display', "none");
        $("#delProj").css('display', "none");
        $("#modUsers").css('display', "none");
        $("#modClienti").css('display', "none");
        $("#modInventar").css('display', "none");


        $("#adauga").click(function () {
            $("#adauga").prop('class', "list-group-item active");
            $("#inventar").prop('class', "list-group-item");
            $("#modifica").prop('class', "list-group-item");
            $("#sterge").prop('class', "list-group-item");
            $("#utilizatori").prop('class', "list-group-item");
            $("#clienti").prop('class', "list-group-item");
            $("#addProj").css('display', "block");
            $("#modProj").css('display', "none");
            $("#modInventar").css('display', "none");
            $("#delProj").css('display', "none");
            $("#modUsers").css('display', "none");
            $("#modClienti").css('display', "none");
            $("#sfat").css('display', "none");


        });

        $("#modifica").click(function () {
            $("#modifica").prop('class', "list-group-item  active");
            $("#inventar").prop('class', "list-group-item");
            $("#adauga").prop('class', "list-group-item");
            $("#sterge").prop('class', "list-group-item");
            $("#utilizatori").prop('class', "list-group-item");
            $("#clienti").prop('class', "list-group-item");
            $("#addProj").css('display', "none");
            $("#modProj").css('display', "block");
            $("#modInventar").css('display', "none");
            $("#delProj").css('display', "none");
            $("#modUsers").css('display', "none");
            $("#modClienti").css('display', "none");
            $("#sfat").css('display', "none");
            getProjects();
            getClients();


        });

        $("#sterge").click(function () {
            $("#sterge").prop('class', "list-group-item  active");
            $("#inventar").prop('class', "list-group-item");
            $("#adauga").prop('class', "list-group-item");
            $("#modifica").prop('class', "list-group-item");
            $("#utilizatori").prop('class', "list-group-item");
            $("#clienti").prop('class', "list-group-item");
            $("#addProj").css('display', "none");
            $("#modProj").css('display', "none");
            $("#delProj").css('display', "block");
            $("#modInventar").css('display', "none");
            $("#modUsers").css('display', "none");
            $("#modClienti").css('display', "none");
            $("#sfat").css('display', "none");
            getProjects();


        });

        $("#clienti").click(function () {
            $("#utilizatori").prop('class', "list-group-item");
            $("#inventar").prop('class', "list-group-item");
            $("#adauga").prop('class', "list-group-item");
            $("#modifica").prop('class', "list-group-item");
            $("#sterge").prop('class', "list-group-item");
            $("#clienti").prop('class', "list-group-item active");
            $("#addProj").css('display', "none");
            $("#modProj").css('display', "none");
            $("#modInventar").css('display', "none");
            $("#delProj").css('display', "none");
            $("#modUsers").css('display', "none");
            $("#modClienti").css('display', "block");
            $("#sfat").css('display', "none");
            getClients();
            $('#btnModClient').attr('data-target', '');
            $('#btnDelClient').attr('data-target', '');
            $('#numeClient').val('');

        });

        $("#utilizatori").click(function () {
            $("#utilizatori").prop('class', "list-group-item active");
            $("#inventar").prop('class', "list-group-item");
            $("#adauga").prop('class', "list-group-item");
            $("#modifica").prop('class', "list-group-item");
            $("#sterge").prop('class', "list-group-item");
            $("#clienti").prop('class', "list-group-item");
            $("#addProj").css('display', "none");
            $("#modProj").css('display', "none");
            $("#delProj").css('display', "none");
            $("#modInventar").css('display', "none");
            $("#modUsers").css('display', "block");
            $("#modClienti").css('display', "none");
            $("#sfat").css('display', "none");
            getUsers();
            getPersoane();
            $('#btnChPass').attr('data-target','');
            $('#btnModUser').attr('data-target','');

        });

        $("#inventar").click(function () {
            $("#inventar").prop('class', "list-group-item active");
            $("#utilizatori").prop('class', "list-group-item");
            $("#adauga").prop('class', "list-group-item");
            $("#modifica").prop('class', "list-group-item");
            $("#sterge").prop('class', "list-group-item");
            $("#clienti").prop('class', "list-group-item");
            $("#addProj").css('display', "none");
            $("#modProj").css('display', "none");
            $("#delProj").css('display', "none");
            $("#modInventar").css('display', "block");
            $("#modUsers").css('display', "none");
            $("#modClienti").css('display', "none");
            $("#sfat").css('display', "none");
            getPersoane();
            getLocuri();
            getArticole();
            getAllCod1();

        });
    });

</script>
