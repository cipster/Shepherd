<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <link rel="icon" href="/img/favico.png">


    <title>Shepherd</title>

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/css/navbar-fixed-top.css" rel="stylesheet">
    <link href="/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="/css/datatabletools.css" rel="stylesheet">
    <link href="/css/datatables.bootstrap.css" rel="stylesheet">
</head>

<body>
<jsp:include page="include/navbar.jsp"></jsp:include>

<div class="container" style="margin-bottom: 40px;">
    <!-- Main component -->
    <div id="spinner-container" class="jumbotron">
        <img id="spinner" src="/img/spinner.gif" class="spinner" style="display: none;">
        <br/>
        <table id="tabelProiecte" class="table unselectable" width="100%">
            <thead>
            <th></th>
            <th hidden="hidden">Id</th>
            <th><spring:message code="MAIN.NR"/></th>
            <th><spring:message code="MAIN.AN"/></th>
            <th><spring:message code="MAIN.NUME"/></th>
            <th><spring:message code="MAIN.CLIENT"/></th>
            </thead>
            <tbody>
            <c:forEach items="${listaProiecte}" var="prj">
                <tr id="${prj.idProiect}" class="idTabel" data-id="${prj.idProiect}" data-idBd="${prj.idBd}"
                    data-idPropunere="${prj.idPropunere}" data-idChestionarFinal="${prj.idChestionarFinal}"
                    data-idRaportFinal="${prj.idRaportFinal}" data-idAlteMateriale="${prj.idAlteMateriale}">
                    <td class="details-control" title="Apasa pentru detalii"></td>
                    <td hidden="hidden" class="id">${prj.idProiect}</td>
                    <td>${prj.nrProiect} </td>
                    <td>${prj.an}</td>
                    <td>${prj.numeProiect}</td>
                    <td>
                        <c:forEach items="${listaClienti}" var="clnt">
                            <c:if test="${prj.idClient == clnt.idClient}">
                                ${clnt.client}
                            </c:if>

                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>
</div>
<sec:authorize access="hasAnyRole('ROLE_DOWNLOAD','ROLE_ADMIN')">
    <div id="childrcmenu" class="unselectable">
        <div class="menuItem" onclick="download();"><spring:message code="MAIN.DESCARCA"/></div>
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <input id="idMaster" hidden="hidden"/>
            <input id="id" hidden="hidden"/>
            <input id="category" hidden="hidden"/>
            <input id="fileName" hidden="hidden"/>

            <div class="menuItem" data-toggle="modal"
                 data-target="#estiSigurFile" onclick="atribuieNumeFile();"><spring:message code="MAIN.DELETE"/></div>
        </sec:authorize>
    </div>
</sec:authorize>
<div id="rcmenu" class="unselectable">
    <%--<div class="menuItem" data-toggle="modal" data-target="#cercCheltuieli"><spring:message code="MAIN.CHELTUIELI" /></div>--%>
    <div class="menuItem" data-toggle="modal" data-target="#uploadPropunere"><spring:message code="MAIN.PROPUNERE"/></div>
    <div class="menuItem" data-toggle="modal" data-target="#uploadChestionar"><spring:message code="MAIN.CHESTIONAR"/></div>
    <div class="menuItem" data-toggle="modal" data-target="#uploadRaport"><spring:message code="MAIN.RAPORT"/></div>
    <div class="menuItem" data-toggle="modal" data-target="#uploadBd"><spring:message code="MAIN.BD"/></div>
    <div class="menuItem" data-toggle="modal" data-target="#uploadAlteMateriale"><spring:message code="MAIN.ALTEMATERIALE"/></div>
</div>


<div class="modal fade" id="uploadPropunere">
    <c:import url="include/proiecte/uploadPropunere.jsp"></c:import>
</div>
<!-- /.modal -->

<div class="modal fade" id="uploadChestionar">
    <c:import url="include/proiecte/uploadChestionar.jsp"></c:import>
</div>
<!-- /.modal -->

<div class="modal fade" id="uploadRaport">
    <c:import url="include/proiecte/uploadRaport.jsp"></c:import>
</div>
<!-- /.modal -->

<div class="modal fade" id="uploadBd" role="dialog">
    <c:import url="include/proiecte/uploadBd.jsp"></c:import>
</div>
<!-- /.modal -->

<div class="modal fade" id="uploadAlteMateriale">
    <c:import url="include/proiecte/uploadAlteMateriale.jsp"></c:import>
</div>
<!-- /.modal -->
<div class="modal fade" id="estiSigurFile">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><spring:message code="DIALOG.DELETE"/></h4>
            </div>
            <div class="modal-body">
                <h3><spring:message code="DIALOG.ESTISIGURDELETE"/> <span id="fileNameDel" style="color: #149bdf; word-break: break-all;"></span>?</h3>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="deleteFile();"><spring:message code="DIALOG.DEL"/></button>
                <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="NU"/></button>

            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- /.modal -->
<div class="modal fade" id="cercCheltuieli">
    <div class="modal-dialog modal-xlg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><spring:message code="MAIN.CHELTUIELI"/></h4>
            </div>
            <div class="modal-body">
                <table>
                    <tr>
                        <td>
                            <div class="pic img-circle"></div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary pull-left" onclick=""><spring:message code="DIALOG.ADD"/></button>
                <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="DIALOG.CLOSE"/></button>

            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<div id="alert" class="notifications"></div>


<input id="username" hidden="hidden" value="${pageContext.request.userPrincipal.name}"/>
<sec:authorize access="hasAnyRole('ROLE_DOWNLOAD','ROLE_ADMIN')">
    <input id="propDownloadString" hidden="hidden" value="1">
    <input id="chestDownloadString" hidden="hidden" value="1">
    <input id="rapDownloadString" hidden="hidden" value="1">
    <input id="bdDownloadString" hidden="hidden" value="1">
    <input id="amDownloadString" hidden="hidden" value="1">
    <input id="download" hidden="hidden">
</sec:authorize>
<input hidden="hidden" id="appLangCode" value="">
<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="/js/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/docs.min.js"></script>
<script src="/js/bootstrap.file-input.js"></script>
<script src="/js/chosen.jquery.min.js"></script>
<script src="/js/datatables.js"></script>
<script src="/js/datatables.bootstrap.js"></script>
<script src="/js/bootstrap-notify.js"></script>
<script src="//cdn.datatables.net/tabletools/2.2.3/js/dataTables.tableTools.min.js"></script>
<script src="/js/common.js"></script>
<script type="text/javascript">
    var table;
    var appLangCode = getUrlParameter("lang");
    var appLang;

    switch (appLangCode) {
        case '':
            appLang = "/fonts/ro_RO.txt";
            break;
        case 'ro':
            appLang = "/fonts/ro_RO.txt";
            break;
        case 'en':
            appLang = "/fonts/en_EN.txt";
            break;
        default:
            appLang = "/fonts/ro_RO.txt";
            break;
    }

    function deleteFile() {
        var category = $("#category").val();
        switch (category) {
            case 'p':
                propunereDelete();
                break;
            case 'c':
                chestionarDelete();
                break;
            case 'r':
                raportDelete();
                break;
            case 'bd':
                bdDelete();
                break;
            case 'am':
                alteMaterialeDelete();
                break;
            default:
                return;
        }
    }

    function atribuieNumeFile() {
        $("#fileNameDel").text($('#fileName').val());
    }

    function download() {
        window.location = $("#download").val();
    }

    function verificaFisierC() {
        if ($("#filechestionarFile").text() == "Click aici pentru a selecta un chestionar final") {
            $('#mesajAlertaC').show();
            $('#mesajAlertaC').fadeOut(3000);
        } else {
            chestionarAjaxCall();
        }
    }

    function verificaFisierP() {
        if ($("#filepropunereFile").text() == "Click aici pentru a selecta o propunere") {
            $('#mesajAlertaP').show();
            $('#mesajAlertaP').fadeOut(3000);
        } else {
            propunereAjaxCall();
        }
    }

    function verificaFisierR() {
        if ($("#fileraportFile").text() == "Click aici pentru a selecta un raport final") {
            $('#mesajAlertaR').show();
            $('#mesajAlertaR').fadeOut(3000);
        } else {
            raportAjaxCall();
        }
    }

    function verificaFisierBD() {
        if ($("#filebdFile").text() === "Click aici pentru a selecta o baza de date") {
            $('#mesajAlertaBD').show();
            $('#mesajAlertaBD').fadeOut(3000);
        } else {
            bdAjaxCall();
        }
    }

    function verificaFisierAM() {
        if ($("#filealteMaterialeFile").text() == "Click aici pentru a selecta alte materiale") {
            $('#mesajAlertaAM').show();
            $('#mesajAlertaAM').fadeOut(3000);
        } else {
            alteMaterialeAjaxCall();
        }
    }

    $('input[type=file]').bootstrapFileInput();
    $('.file-inputs').bootstrapFileInput();

    function ajaxLoaderShow(type) {
        $('.inprogress-gif').show();
        $('div.modal-body').addClass('inprogress');
    }

    function ajaxLoaderHide() {
        $('div.modal-body').removeClass('inprogress');
        $('.inprogress-gif').hide();
    }

    function bdAjaxCall() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        ajaxLoaderShow();
        var data;
        var idProiect = $('#idProiectBd').val();
        data = new FormData();
        data.append('file', $('#bdFile')[0].files[0]);
        data.append('idProiect', idProiect);
        data.append('user', $('#username').val());
        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/upload/uploadBd',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: data,
            dataType: 'text',
            processData: false,
            contentType: false,
            success: function (response) {

                var t = '#' + idProiect;
                var tr = $(t);
                var row = table.row(tr);
                row.child(format(tr.prop("id"))).show();
                tr.next().addClass('copil');
                $("#copil").children().addClass('copil');

                $("#uploadAlert").html(EMPTY);
                $("#bdFile").val(EMPTY);
                $("#filebdFile").text("Click aici pentru a selecta o baza de date");

                if (response == "error") {
                    showNotification('Fisierul este gol!', DANGER, 15000);
                    return;
                }
                var respContent = "";
                var uploadResponse = JSON.parse(JSON.parse(response));

                respContent += "Fisierul ";
                respContent += uploadResponse.fileName;
                respContent += " a fost adaugat cu succes in sectiunea baza de date!  ";
                hideModal();
                showNotification(respContent);
            },
            error: function (e) {
                showNotification('Eroare la conexiune!', DANGER);
            },
            complete: function (e) {
                ajaxLoaderHide();

            }
        });
    }

    function propunereAjaxCall() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        ajaxLoaderShow();
        var data;
        var idProiect = $('#idProiectPropunere').val();
        data = new FormData();
        data.append('file', $('#propunereFile')[0].files[0]);
        data.append('idProiect', idProiect);
        data.append('user', $('#username').val());
        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/upload/uploadPropunere',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: data,
            dataType: 'text',
            processData: false,
            contentType: false,
            success: function (response) {
                var t = '#' + idProiect;
                var tr = $(t);
                var row = table.row(tr);
                row.child(format(tr.prop("id"))).show();
                tr.next().addClass('copil');
                $("#copil").children().addClass('copil');
                $("#uploadAlert").html(EMPTY);
                $("#propunereFile").val(EMPTY);
                $("#filepropunereFile").text("Click aici pentru a selecta o propunere");

                if (response == "error") {
                    showNotification('Fisierul este gol', DANGER, 15000);
                    return;
                }

                var respContent = "";
                var uploadResponse = JSON.parse(JSON.parse(response));
                respContent += "Fisierul ";
                respContent += uploadResponse.fileName;
                respContent += " a fost adaugat cu succes in sectiunea propunere!  ";
                hideModal();
                showNotification(respContent);
            },
            error: function (e) {
                showNotification('Eroare la conexiune!', DANGER);
            },
            complete: function (e) {
                ajaxLoaderHide();
            }
        });
    }

    function chestionarAjaxCall() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        ajaxLoaderShow();
        var data;
        var idProiect = $('#idProiectChestionar').val();
        data = new FormData();
        data.append('file', $('#chestionarFile')[0].files[0]);
        data.append('idProiect', idProiect);
        data.append('user', $('#username').val());
        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/upload/uploadChestionar',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: data,
            dataType: 'text',
            processData: false,
            contentType: false,
            success: function (response) {
                var t = '#' + idProiect;
                var tr = $(t);
                var row = table.row(tr);
                row.child(format(tr.prop("id"))).show();
                tr.next().addClass('copil');
                $("#copil").children().addClass('copil');
                $("#uploadAlert").html(EMPTY);
                $("#chestionarFile").val(EMPTY);
                $("#filechestionarFile").text("Click aici pentru a selecta un chestionar final");

                if (response == "error") {
                    showNotification('Fisierul este gol', DANGER, 15000);
                    return;
                }

                var respContent = EMPTY;
                var uploadResponse = JSON.parse(JSON.parse(response));

                respContent += "Fisierul ";
                respContent += uploadResponse.fileName;
                respContent += " a fost adaugat cu succes in sectiunea chestionar final!  ";
                hideModal();
                showNotification(respContent);
            },
            error: function (e) {
                showNotification('Eroare la conexiune!', DANGER);
            },
            complete: function (e) {
                ajaxLoaderHide();
            }
        });
    }

    function raportAjaxCall() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        ajaxLoaderShow();
        var data;
        var idProiect = $('#idProiectRaport').val();
        data = new FormData();
        data.append('file', $('#raportFile')[0].files[0]);
        data.append('idProiect', idProiect);
        data.append('user', $('#username').val());
        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/upload/uploadRaport',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: data,
            dataType: 'text',
            processData: false,
            contentType: false,
            success: function (response) {
                var t = '#' + idProiect;
                var tr = $(t);
                var row = table.row(tr);
                row.child(format(tr.prop("id"))).show();
                tr.next().addClass('copil');
                $("#copil").children().addClass('copil');
                $("#uploadAlert").html(EMPTY);
                $("#raportFile").val(EMPTY);
                $("#fileraportFile").text("Click aici pentru a selecta un raport final");

                if (response == "error") {
                    showNotification('Fisierul este gol', DANGER, 15000);
                    return;
                }

                var respContent = EMPTY;
                var uploadResponse = JSON.parse(JSON.parse(response));

                respContent += "Fisierul ";
                respContent += uploadResponse.fileName;
                respContent += " a fost adaugat cu succes in sectiunea raport final!  ";
                hideModal();
                showNotification(respContent);
            },
            error: function (e) {
                showNotification('Eroare la conexiune!', DANGER);
            },
            complete: function (e) {
                ajaxLoaderHide();
            }
        });
    }

    function alteMaterialeAjaxCall() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        ajaxLoaderShow();
        var data;
        var idProiect = $('#idProiectAlteMateriale').val();
        data = new FormData();
        data.append('file', $('#alteMaterialeFile')[0].files[0]);
        data.append('idProiect', idProiect);
        data.append('user', $('#username').val());
        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/upload/uploadAlteMateriale',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: data,
            dataType: 'text',
            processData: false,
            contentType: false,
            success: function (response) {
                $("#uploadAlert").html(EMPTY);
                $("#alteMaterialeFile").val(EMPTY);
                $("#filealteMaterialeFile").text("Click aici pentru a selecta alte materiale");

                if (response == "error") {
                    showNotification('Fisierul este gol', DANGER);
                    return;
                }
                var respContent = EMPTY;
                var uploadResponse = JSON.parse(JSON.parse(response));

                respContent += "Fisierul ";
                respContent += uploadResponse.fileName;
                respContent += " a fost adaugat cu succes in sectiunea alte materiale!  ";

                var t = '#' + uploadResponse.idProiect;
                var tr = $(t);
                var row = table.row(tr);
                row.child(format(tr.prop("id"))).show();
                tr.next().addClass('copil');
                $("#copil").children().addClass('copil');
                hideModal();
                showNotification(respContent);
            },
            error: function (e) {
                showNotification('Eroare la conexiune!', DANGER);
            },
            complete: function (e) {
                ajaxLoaderHide();
            }
        });
    }

    function alteMaterialeDelete() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        var idProiect = $('#idMaster').val();
        var idAM = $('#id').val();
        var fileName = $('#fileName').val();

        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/delete/altemateriale',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: 'idProiect=' + idProiect + "&idAM=" + idAM,
            cache: false,

            success: function (response) {
                if (response == "error") {
                    showNotification('Fisierul este gol', DANGER);
                }
                var respContent = EMPTY;
                var uploadResponse = JSON.parse(response);

                respContent += "Fisierul ";
                respContent += uploadResponse.nume;
                respContent += " a fost sters!  ";
                hideModal();
                showNotification(respContent, INFO);
            },
            error: function (e) {
                showNotification('Eroare la conexiune!', DANGER);
            },
            complete: function (e) {
                var t = '#' + idProiect;
                var tr = $(t);
                var row = table.row(tr);
                row.child(format(tr.prop("id"))).show();
                tr.next().addClass('copil');
                $("#copil").children().addClass('copil');
            }
        });
    }

    function propunereDelete() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        var idProiect = $('#idMaster').val();
        var idP = $('#id').val();
        var fileName = $('#fileName').val();

        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/delete/propunere',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: 'idProiect=' + idProiect + "&idP=" + idP,
            cache: false,
            success: function (response) {
                if (response == "error") {
                    showNotification('Fisierul este gol', DANGER);
                    return;
                }
                var respContent = EMPTY;
                var uploadResponse = JSON.parse(response);

                respContent += "Fisierul ";
                respContent += uploadResponse.nume;
                respContent += " a fost sters!  ";
                hideModal();
                showNotification(respContent, INFO);
            },
            error: function (e) {
                showNotification('Eroare la conexiune!', DANGER);
            },
            complete: function (e) {
                var t = '#' + idProiect;
                var tr = $(t);
                var row = table.row(tr);
                row.child(format(tr.prop("id"))).show();
                tr.next().addClass('copil');
                $("#copil").children().addClass('copil');
            }
        });
    }

    function chestionarDelete() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        var idProiect = $('#idMaster').val();
        var idC = $('#id').val();
        var fileName = $('#fileName').val();

        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/delete/chestionar',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: 'idProiect=' + idProiect + "&idC=" + idC,
            cache: false,

            success: function (response) {
                if (response == "error") {
                    showNotification('Fisierul este gol', DANGER);
                    return;
                }
                var respContent = EMPTY;
                var uploadResponse = JSON.parse(response);

                respContent += "Fisierul ";
                respContent += uploadResponse.nume;
                respContent += " a fost sters!  ";
                hideModal();
                showNotification(respContent, INFO);
            },
            error: function (e) {
                showNotification('Eroare la conexiune!', DANGER);
            },
            complete: function (e) {
                var t = '#' + idProiect;
                var tr = $(t);
                var row = table.row(tr);
                row.child(format(tr.prop("id"))).show();
                tr.next().addClass('copil');
                $("#copil").children().addClass('copil');
            }
        });
    }

    function raportDelete() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        var idProiect = $('#idMaster').val();
        var idR = $('#id').val();
        var fileName = $('#fileName').val();

        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/delete/raport',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: 'idProiect=' + idProiect + "&idR=" + idR,
            cache: false,
            success: function (response) {
                if (response == "error") {
                    showNotification('Fisierul este gol', DANGER);
                    return;
                }
                var respContent = EMPTY;
                var uploadResponse = JSON.parse(response);

                respContent += "Fisierul ";
                respContent += uploadResponse.nume;
                respContent += " a fost sters!  ";
                hideModal();
                showNotification(respContent, INFO);
            },
            error: function (e) {
                showNotification('Eroare la conexiune!', DANGER);
            },
            complete: function (e) {
                var t = '#' + idProiect;
                var tr = $(t);
                var row = table.row(tr);
                row.child(format(tr.prop("id"))).show();
                tr.next().addClass('copil');
                $("#copil").children().addClass('copil');
            }
        });
    }

    function bdDelete() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        var idProiect = $('#idMaster').val();
        var idB = $('#id').val();
        var fileName = $('#fileName').val();

        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/delete/bd',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: 'idProiect=' + idProiect + "&idB=" + idB,
            cache: false,

            success: function (response) {
                if (response == "error") {
                    showNotification('Fisierul este gol', DANGER);
                    return;
                }
                var respContent = EMPTY;
                var uploadResponse = JSON.parse(response);

                respContent += "Fisierul ";
                respContent += uploadResponse.nume;
                respContent += " a fost sters!  ";
                hideModal();
                showNotification(respContent, INFO);
            },
            error: function (e) {
                showNotification('Eroare la conexiune!', DANGER);
            },
            complete: function (e) {
                var t = '#' + idProiect;
                var tr = $(t);
                var row = table.row(tr);
                row.child(format(tr.prop("id"))).show();
                tr.next().addClass('copil');
                $("#copil").children().addClass('copil');
            }
        });
    }

    function getProjId(id) {
        $("input[name='idProiect']").val(id);
    }

    function format(idProj) {
        var childString = '<div id="copil-' + idProj + '" class="well copil">' +
                '<table class="table copil" style="width: 100%;font-size: 8pt;word-break: break-all;">' +
                '<thead class="copil" style="margin-bottom:10px;">' +
                '<tr class="copil">' +
                '<th>Propunere</th><th>Chestionar final</th><th>Raport final</th><th>Baza de date</th><th>Alte materiale</th></tr>' +
                '</thead>' +
                '<tbody class="copil"><tr class="copil"> ';
        var propString = '<td style="vertical-align: top;">';
        var chestString = '<td style="vertical-align: top;">';
        var rapString = '<td style="vertical-align: top;">';
        var bdString = '<td style="vertical-align: top;">';
        var amString = '<td style="vertical-align: top;">';

        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $.ajax({
            type: 'get',
            url: '${pageContext.request.contextPath}/files/' + idProj,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            async: false,
            cache: false,

            success: function (response) {
                var project = JSON.parse(response);

                var propunere = project.propunere;
                var chestionar = project.chestionar;
                var raport = project.raport;
                var bd = project.bd;
                var alteMateriale = project.alteMateriale;

                var propArr = propunere.toString().split(",");
                var chestArr = chestionar.toString().split(",");
                var rapArr = raport.toString().split(",");
                var bdArr = bd.toString().split(",");
                var amArr = alteMateriale.toString().split(",");

                for (var i = 0; i < propArr.length; i++) {
                    var arr = propArr[i];
                    arr = arr.split("=");
                    if (arr[0] != 0 || arr[1] != "null") {
                        var id = '' + arr[0];
                        id = id.replace(" ", "");
                        var downloadLink = '';
                        if ($("#propDownloadString") && $("#propDownloadString").val() == 1) {
                            downloadLink = 'href="\/download\/propunere\/' + id + '" title="Click pentru download"';
                        }
                        propString += '<a class="download pr"' + downloadLink + ' id="prop' + id + '" data-idp="' + id + '"> &#9658;&nbsp;' + arr[1] + '</a><br style="margin: 3px;"/>'
                    }
                }
                for (var i = 0; i < chestArr.length; i++) {
                    var arr = chestArr[i];
                    arr = arr.split("=");
                    if (arr[0] != 0 || arr[1] != "null") {
                        var id = '' + arr[0];
                        id = id.replace(" ", "");
                        var downloadLink = '';
                        if ($("#chestDownloadString") && $("#chestDownloadString").val() == 1) {
                            downloadLink = 'href="\/download\/chestionar\/' + id + '" title="Click pentru download"';
                        }
                        chestString += '<a class="download ch" ' + downloadLink + ' id="chest' + id + '" data-idc="' + id + '"> &#9658;&nbsp;' + arr[1] + '</a><br style="margin: 3px;"/>'
                    }
                }
                for (var i = 0; i < rapArr.length; i++) {
                    var arr = rapArr[i];
                    arr = arr.split("=");
                    if (arr[0] != 0 || arr[1] != "null") {
                        var id = '' + arr[0];
                        id = id.replace(" ", "");
                        var downloadLink = '';
                        if ($("#rapDownloadString") && $("#rapDownloadString").val() == 1) {
                            downloadLink = 'href="\/download\/raport\/' + id + '" title="Click pentru download"';
                        }
                        rapString += '<a class="download ra" ' + downloadLink + ' id="rap' + id + '" data-idr="' + id + '"> &#9658;&nbsp;' + arr[1] + '</a><br style="margin: 3px;"/>'
                    }
                }
                for (var i = 0; i < bdArr.length; i++) {
                    var arr = bdArr[i];
                    arr = arr.split("=");
                    if (arr[0] != 0 || arr[1] != "null") {
                        var id = '' + arr[0];
                        id = id.replace(" ", "");
                        var downloadLink = '';
                        if ($("#bdDownloadString") && $("#bdDownloadString").val() == 1) {
                            downloadLink = 'href="\/download\/bd\/' + id + '" title="Click pentru download"';
                        }
                        bdString += '<a class="download bd" ' + downloadLink + ' id="bd' + id + '" data-idb="' + id + '""> &#9658;&nbsp;' + arr[1] + '</a><br style="margin: 3px;"/>'
                    }
                }
                for (var i = 0; i < amArr.length; i++) {
                    var arr = amArr[i];
                    arr = arr.split("=");
                    if (arr[0] != 0 || arr[1] != "null") {
                        var id = '' + arr[0];
                        id = id.replace(" ", "");
                        var downloadLink = '';
                        if ($("#amDownloadString") && $("#amDownloadString").val() == 1) {
                            downloadLink = 'href="\/download\/altemateriale\/' + id + '" title="Click pentru download"';
                        }
                        amString += '<a class="download am" ' + downloadLink + ' id="am' + id + '" data-ida="' + id + '"> &#9658;&nbsp;' + arr[1] + '</a><br style="margin: 3px;"/>'
                    }
                }
            },
            error: function (e) {
                alert("Nu sunt fisiere la acest proiect!");

            }
        });
        propString += '</td>';
        chestString += '</td>';
        rapString += '</td>';
        bdString += '</td>';
        amString += '</td>';
        var buttonString = '<tr class="copil">  <td><a type="button" class="btn btn-sm btn-primary" style="margin:10px; width: 150px !important;" onclick="getProjId(' + idProj + ');" data-toggle="modal" data-target="#uploadPropunere"><span class="fa fa-upload ">&nbsp;</span> Upload Propunere</a></td>' +
                '<td><a type="button" class="btn btn-sm btn-primary" style="margin:10px; width: 150px !important;" onclick="getProjId(' + idProj + ');" data-toggle="modal" data-target="#uploadChestionar"><span class="fa fa-upload ">&nbsp;</span> Upload Chestionar</a></td>' +
                '<td><a type="button" class="btn btn-sm btn-primary" style="margin:10px; width: 150px !important;" onclick="getProjId(' + idProj + ');" data-toggle="modal" data-target="#uploadRaport"><span class="fa fa-upload">&nbsp;</span> Upload Raport</a></td>' +
                '<td><a type="button" class="btn btn-sm btn-primary" style="margin:10px; width: 150px !important;" onclick="getProjId(' + idProj + ');" data-toggle="modal" data-target="#uploadBd"><span class="fa fa-upload ">&nbsp;</span> Upload Baza de date</a></td>' +
                '<td><a type="button" class="btn btn-sm btn-primary" style="margin:10px; width: 150px !important;" onclick="getProjId(' + idProj + ');" data-toggle="modal" data-target="#uploadAlteMateriale"><span class="fa fa-upload ">&nbsp;</span> Upload Alte Materiale</a></td></tr>';
        childString += propString + chestString + rapString + bdString + amString + '</tr>';
        childString += buttonString;
        childString += '</tbody></table></div>';

        return childString;
    }

    function showChildRow(elem) {
        var tr = elem.closest('tr');
        var row = table.row(tr);
        var id;
        if (!elem.hasClass('copil')) {
            if (event.button == 0) {
                tr.addClass('selected');
                tr.siblings().removeClass('selected');
            }
            if (row.child.isShown()) {
                // This row is already open - close it
                row.child.hide();
                tr.removeClass('shown');
            }
            else {
                // Open this row
                row.child(format(tr.prop("id"))).show();
                tr.next().addClass('copil');
                $("#copil").children().addClass('copil');
                tr.addClass('shown');
                id = elem.closest('tr').attr('id');
                $("input[name='idProiect']").val(id);
                $("#idMaster").val(id);
            }
        }
    }

    $(document).ready(function () {
        $('#slashmain').addClass('active');

        table = $('#tabelProiecte').DataTable({
            "language": {
                "url": '/fonts/ro_RO.txt'
            },
            "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Toate"]],
            stateSave: true,
            "aoColumns": [{
                "sWidth": "15px",
                "bSortable": false,
                "orderable": false
            }, {
                "sWidth": "25px",
                "bSortable": false
            }, {
                "sWidth": "50px",
                "sClass": "center"
            }, {
                "sWidth": "50px",
                "sClass": "center"
            }, {
                "sWidth": "600px",
                "sClass": "center"
            }, {
                "sWidth": "300px",
                "sClass": "center"
            }],
            "aoColumnDefs": [{
                "fnRender": function (o, val) {
                    return o.aData[0];
                }
            }],
            dom: 'Tlfrtip<"break-row-lg">',
            tableTools: {
                "sSwfPath": "/swf/copy_csv_xls_pdf.swf",
                "aButtons": [
                    {
                        "sExtends": "csv",
                        "sButtonClass": "btn btn-default",
                        "sButtonText": '<span class="fa fa-file-o">&nbsp;&nbsp;</span><span>CSV</span>',
                        "mColumns": [2, 3, 4, 5],
                        "oSelectorOpts": {
                            page: 'current'
                        }
                    },
                    {
                        "sExtends": "xls",
                        "sButtonClass": "btn btn-default",
                        "sCharSet": "utf16le",
                        "sButtonText": '<span class="fa fa-file-excel-o">&nbsp;&nbsp;</span><span>XLS</span>',
                        "mColumns": [2, 3, 4, 5],
                        "oSelectorOpts": {
                            page: 'current'
                        }
                    },
                    {
                        "sExtends": "pdf",
                        "sButtonClass": "btn btn-default",
                        "sButtonText": '<span class="fa fa-file-pdf-o">&nbsp;&nbsp;</span><span>PDF</span>',
                        "mColumns": [2, 3, 4, 5],
                        "oSelectorOpts": {
                            page: 'current'
                        }
                    }
                ]
            }
        });

        // Add event listener for opening and closing details
        $('#tabelProiecte tbody').on('dblclick', 'tr', function () {
            showChildRow($(this))
        });

        $('#tabelProiecte tbody').on('click', 'td.details-control', function () {
            showChildRow($(this))
        });

        $('#tabelProiecte tbody').on('mousedown', 'tr', function (e) {
            var id;
            var div;
            var tr = $(event.target).closest('tr');
            if ($(tr).hasClass('copil')) {
                div = $(this).closest('div').attr('id');
                if (div === 'tabelProiecte_wrapper') {
                    div = tr.find('div.copil');
                    id = +$(div).attr('id').replace('copil-', '');
                } else {
                    id = div.replace('copil-', '');
                }
                $('#' + id).siblings().removeClass('selected');
                $('#' + id).addClass('selected');
                $("input[name='idProiect']").val(id);
                $("#idMaster").val(id);

            } else {
                id = $(this).closest('tr').attr('id');

                $("input[name='idProiect']").val(id);
                $("#idMaster").val(id);
                tr.addClass('selected');
                tr.siblings().removeClass('selected');
            }
            var aElem = $(event.target).closest("a");
            if (aElem.hasClass('download')) {
                if (e.button == 2) {
                    $("#download").val(aElem.attr('href'));
                    if (aElem.hasClass('am')) {
                        $("#id").val(aElem.data('ida'));
                        $("#category").val("am");
                    } else if (aElem.hasClass('pr')) {
                        $("#id").val(aElem.data('idp'));
                        $("#category").val("p");
                    } else if (aElem.hasClass('ch')) {
                        $("#id").val(aElem.data('idc'));
                        $("#category").val("c");
                    } else if (aElem.hasClass('ra')) {
                        $("#id").val(aElem.data('idr'));
                        $("#category").val("r");
                    } else {
                        $("#id").val(aElem.data('idb'));
                        $("#category").val("bd");
                    }
                    $('#fileName').val(aElem.text());
                    $("#childrcmenu").css('left', e.pageX + 5);
                    $("#childrcmenu").css('top', e.pageY + 5);
                    $("#childrcmenu").fadeIn(80);
                    $("#rcmenu").fadeOut(40);
                }
            } else if (!$(this).hasClass('copil')) {
                if (event.button == 0) {
                    $(this).addClass('selected');
                    $(this).siblings().removeClass('selected');
                }
                if (event.button == 2) {
                    $("#rcmenu").css('left', e.pageX + 5);
                    $("#rcmenu").css('top', e.pageY + 5);
                    $("#rcmenu").fadeIn(80);
                    $("#childrcmenu").fadeOut(40);
                }
            }
        });


        document.getElementById("tabelProiecte").oncontextmenu = function () {
            return false;
        };

        $(document).click(function (e) {
            if (e.button == 0 || e.button == 1) {
                $("#rcmenu").fadeOut(40);
                $("#childrcmenu").fadeOut(40);
            }
        });
    })
    ;
</script>
