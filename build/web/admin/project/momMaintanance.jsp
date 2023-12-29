<%-- 
    Document   : momUserMaintanance
    Created on : 7 May, 2015, 12:20:23 PM
    Author     : EMINENT
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminentlabs.mom.MomMaintanance"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <LINK title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=2" type="text/css" rel=STYLESHEET>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery-drag-ui.css?test=2">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <style>
        /*            .sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
                    .sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 18px;-webkit-box-shadow: inset 0px 10px 0px 0px #C3D9FE;      
                                   -moz-box-shadow: inset 0px 1px 0px 0px #C3D9FE;      
                                   box-shadow: inset 0px 1px 0px 0px #C3D9FE; }
                    .sortable li span { float:left;width: 40%; color: #45474A;font-size: 13px; }*/
        #sortable1, #sortable2, #sortable3, #sortable4,#sortable5 {
            border: 1px solid #CCC;
            width: 48%;
            min-height: 250px;
            max-height: 250px;
            overflow: auto;
            list-style-type: none;
            margin: 0;
            padding: 5px 0 0 0;
            float: left;
            margin-right: 15px;
            margin-bottom: 15px;
            border-radius: 10px;
        }
        #sortable3{
            clear: both;
        }
        #sortable1 li, #sortable2 li,#sortable3 li, #sortable4 li , #sortable5 li {
            margin: 0 5px 5px 5px;
            padding: 5px;
            font-size: 1.2em;
            width: 90%;
        }
        ::-webkit-scrollbar {
            width: 12px;
        }

        ::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px #C5D7F4; 
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px #C5D7F4; 
        }
    </style>

</head>
<body>
    <%@ include file="/header.jsp"%>
    <%
        int roleId = (Integer) session.getAttribute("Role");
        if (roleId >0) {
    %> 
    <jsp:useBean id="mmc" class="com.eminentlabs.mom.controller.MomMaintananceController"/>
    <%mmc.setAll(request);%>
    <div style="width: 100%;background-color: #C3D9FE;font-weight: bold;">Centralized Team Maintenance <span> <a href="<%=request.getContextPath()%>/MOM/sendMomMaintanance.jsp" >Send MoM Maintenance</a></span></div>
    <br/>
    <table width="100%" border="0">
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add Project</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainWrmDays.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp" >Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp" style="cursor: pointer;font-weight: bold;">MoM Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;">Gantt Chart</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;">Daywise E-Invoice</a>  
            </td>
            <td></td>
        </tr>
    </table>
    <br/>
    <form name="theForm" method="post" action="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp">
        <div  style="width: 90%;">
            <%int i = 1;
                for (Map.Entry<Integer, String> entry : mmc.momTypeMaintanance().entrySet()) {
            %><ul id="sortable<%=i%>" class="connectedSortable" ><span  class="ui-state-disabled" style="line-height: 34px;margin-left: 10px;font-weight: 600;border-bottom: 2px solid #C3D9FE;font-size: 14px;color:#000;"><%=entry.getValue()%></span>
                <%
                    if (mmc.getMaintanace().containsKey(entry.getKey())) {
                        for (MomMaintanance maintanance : mmc.getMaintanace().get(entry.getKey())) {%>
                <li style="height:21px;" class="ui-state-default">
                    <span><%=mmc.getEminentUsers().get(maintanance.getUserid())%><input type="hidden" name="userId" id="userId" value="<%=maintanance.getUserid()%>"></span>
                </li>
                <%}
                %>
                <%} else if (entry.getKey() == 0) {
                        for (Map.Entry<Integer, String> entrya : mmc.getNotApplicableUsers().entrySet()) {%>
                <li style="height:21px;" class="ui-state-default">
                    <span><%=entrya.getValue()%><input type="hidden" name="userId" id="userId" value="<%=entrya.getKey()%>"></span>
                </li>
                <%}
                        }%></ul>
                <%i++;
                        }%>

            <div><input type="submit" name="submit" id="submit" value="Submit"></div>
        </div>
    </form>

    <%} else {%>
    <BR>
    <table align="center">
        <tr align="center" ><td><font color="red">You are not authorized to access this page.</font></td></tr>
    </table>
    <%}%>
</body>

<script type="text/javascript">
    var phrases1 = [];
    var phrases2 = [];
    var phrases3 = [];
    var phrases4 = [];
    var phrases5 = [];
    $('#submit').click(function () {
        // this is inner scope, in reference to the .phrase element
        var phrase = '';
        $("#sortable1").find('input[name=userId]').each(function () {
            // cache jquery var
            var current = $(this);
            // check if our current li has children (sub elements)
            // if it does, skip it
            // ps, you can work with this by seeing if the first child
            // is a UL with blank inside and odd your custom BLANK text

            // add current text to our current phrase
            phrase += current.val() + ",";
        });
        // now that our current phrase is completely build we add it to our outer array
        phrases1.push(phrase);
        // this is inner scope, in reference to the .phrase element
        phrase = '';
        $('#sortable2').find('input[name=userId]').each(function () {
            // cache jquery var
            var current = $(this);
            // check if our current li has children (sub elements)
            // if it does, skip it
            // ps, you can work with this by seeing if the first child
            // is a UL with blank inside and odd your custom BLANK text

            // add current text to our current phrase
            phrase += current.val() + ",";
        });
        // now that our current phrase is completely build we add it to our outer array
        phrases2.push(phrase);
        phrase = '';
        $('#sortable3').find('input[name=userId]').each(function () {
            // cache jquery var
            var current = $(this);
            // check if our current li has children (sub elements)
            // if it does, skip it
            // ps, you can work with this by seeing if the first child
            // is a UL with blank inside and odd your custom BLANK text

            // add current text to our current phrase
            phrase += current.val() + ",";
        });
        // now that our current phrase is completely build we add it to our outer array
        phrases3.push(phrase);
        phrase = '';
        $('#sortable4').find('input[name=userId]').each(function () {
            // cache jquery var
            var current = $(this);
            // check if our current li has children (sub elements)
            // if it does, skip it
            // ps, you can work with this by seeing if the first child
            // is a UL with blank inside and odd your custom BLANK text

            // add current text to our current phrase
            phrase += current.val() + ",";
        });
        // now that our current phrase is completely build we add it to our outer array
        phrases4.push(phrase);
        phrase = ',';
        $('#sortable5').find('input[name=userId]').each(function () {
            // cache jquery var
            var current = $(this);
            // check if our current li has children (sub elements)
            // if it does, skip it
            // ps, you can work with this by seeing if the first child
            // is a UL with blank inside and odd your custom BLANK text

            // add current text to our current phrase
            phrase += current.val() + ",";
        });
        // now that our current phrase is completely build we add it to our outer array
        phrases5.push(",");

        // note the comma in the alert shows separate phrases
        $('<input>').attr({
            type: 'hidden',
            id: '',
            name: 'technical',
            value: phrases1
        }).appendTo('form');
        $('<input>').attr({
            type: 'hidden',
            id: '',
            name: 'functional',
            value: phrases2
        }).appendTo('form');
        $('<input>').attr({
            type: 'hidden',
            id: '',
            name: 'technicalHead',
            value: phrases3
        }).appendTo('form');
        $('<input>').attr({
            type: 'hidden',
            id: '',
            name: 'overtechnicalHeads',
            value: phrases5
        }).appendTo('form');
        $('<input>').attr({
            type: 'hidden',
            id: '',
            name: 'notApplicable',
            value: phrases4
        }).appendTo('form');
    });
    $(document).ready(function () {

        $('.text').keydown(function (event) {
            // Allow special chars + arrows 
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9
                    || event.keyCode == 27 || event.keyCode == 13
                    || (event.keyCode == 65 && event.ctrlKey === true)
                    || (event.keyCode >= 35 && event.keyCode <= 39)) {
                return;
            } else {
                // If it's not a number stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });
        $('#submit').click(function () {
            var counts = 0;
            var rows = $('#tables');
            var count = $("input:text").length;
            var counta = new Number(count);
            var sorted;
            $.each(rows, function () {
                sorted = $(this).find("input[type='text']").sort(
                        function (a, b) {
                            return a.value - b.value;
                        });
                var sortedMax = $(this).find("input[type='text']").sort(
                        function (a, b) {
                            return b.value - a.value;
                        });
                var lowest = sorted[0].value;
                var highest = sortedMax[0].value;
                var highesta = new Number(highest);
                var lowesta = new Number(lowest);
                var maxCount = counta + lowesta;
                var maxCounta = new Number(maxCount);
                maxCounta = maxCounta - 1;
                if (highesta > maxCounta && counts == 0) {
                    alert('Crossed maximum number of Serial Number. Please enter the serial Number between ' + lowesta + ' and ' + maxCounta);
                    counts = 1;
                }
                if (counts == 0) {
                    for (var k = 0; k < maxCounta; k++) {
                        if (sorted[k].value != "") {
                            if (sorted[k].value == sorted[k + 1].value) {
                                alert('Duplicate value is ' + sorted[k].value);
                                counts = 1;
                                break;
                            }
                        }
                    }
                }
            });
            if (counts == 0) {
                return true;
            } else {
                return false;
            }
        });
    });</script>
<script>
    $(function () {
        $("#sortable1, #sortable2,#sortable3,#sortable4,#sortable5").sortable({
            connectWith: ".connectedSortable"
        }).disableSelection();

        $("#sortable1, #sortable2,#sortable3,#sortable4,#sortable5").sortable({
            cancel: ".ui-state-disabled"
        });
    });


</script>
</html>
