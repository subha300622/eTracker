<%-- 
    Document   : addReason
    Created on : Aug 20, 2014, 6:19:14 PM
    Author     : RN.Khans
--%>

<%@page import="com.eminentlabs.mom.Fine"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("ReasonMaintain");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET"/>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
        <script type="text/javascript">
            var fresult;
            function validate(theForm) {
                if ((theForm.reason.value) == '') {
                    alert('Enter the  Reason  ');
                    theForm.reason.focus();
                    return false;
                }

                addReason();
                if (fresult == false) {
                    theForm.reason.focus();
                    return false;
                } else {
                    document.theForm.action = "addReason.jsp";
                }
                monitorSubmit();

            }
            function numbersonly(e) {
                var unicode = e.charCode ? e.charCode : e.keyCode
                if (unicode != 8) { //if the key isn't the backspace key (which we should allow)
                    if (unicode < 48 || unicode > 57) //if not a number
                        return false //disable key press
                }

            }

            function createRequest() {
                var reqObj = null;
                try
                {
                    reqObj = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (err)
                {
                    try {
                        reqObj = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (err2) {
                        try {
                            reqObj = new XMLHttpRequest();
                        }
                        catch (err3) {
                            reqObj = null;
                        }
                    }
                }
                return reqObj;
            }

            function addReason() {
                xmlhttp = createRequest();
                if (xmlhttp !== null) {
                    var reason = document.getElementById('reason').value;
                    xmlhttp.open("get", "/eTracker/MOM/saveReason.jsp?reason=" + reason + "&rand=" + Math.random(1, 10), false);
                    xmlhttp.onreadystatechange = checkValue;
                    xmlhttp.send(null);
                }
            }
            function checkValue()
            {
                if (xmlhttp.readyState === 4)
                {
                    if (xmlhttp.status === 200)
                    {
                        var result = xmlhttp.responseText;
                        var reasonId = new Number(result);
                        if (reasonId != 0) {
                            alert('Reason already exists');
                            fresult = false;
                        } else {
                            fresult = true;
                        }
                    }
                }
            }
        </script>
    </head>
    <body>
        <%@ include file="/header.jsp"%>

        <jsp:useBean id="reason" class="com.eminentlabs.mom.AddReason"></jsp:useBean>

            <table cellpadding="0" cellspacing="0" width="100%">
                <tr border="2" bgcolor="#C3D9FF">
                    <td border="1" align="left" width="70%">
                        <font size="4" COLOR="#0000FF"><b>Reason Maintain</b></font>
                    </td>
                </tr>
            </table>           
        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 

    <%
       int wrmSize= mas.wrmIssues().size();
   int assignedto = (Integer) session.getAttribute("userid_curr");%>

        <table cellpadding="0" cellspacing="0" width="100%">

            <tr>
                <td style="height: 25px;">
                    <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
                    <%if (reason.getModList().contains(((Integer) assignedto).toString())) {
                    %>
                    <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer;">Add Fine</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/FinePayment.jsp" style="cursor: pointer;">Fine Collection</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/addReason.jsp" style="cursor: pointer; font-weight: bold;">Reason Maintain</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                    <%                 }%>
                    <a href="<%=request.getContextPath()%>/MOM/weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; " title="Due Date Report">DDR</a> &nbsp;&nbsp;&nbsp;
                                        <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer;">Fine Amount Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
<a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table>
        <br/>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="70%">
                    <font size="4" COLOR="#0000FF"><b>Add Reason</b></font>
                </td>
            </tr>
        </table>     
        <br/>
        <form name="theForm" method="post" action="addReason.jsp" onsubmit="return validate(this);">
            <table width="70%" bgColor=#E8EEF7 border="0" align="left">
                <tr>
                    <td><strong>Reason </strong></td>
                    <td><input type="text" id="reason" name="reason" />
                    </td>
                </tr>

                <tr>
                    <td>&nbsp;</td>
                    <td><input type="submit" value="Submit" id="submit" name="submit" > 
                        <input type="reset" id="reset" value=" Reset "></td>
                </tr>             
            </table>
        </form>
        <br/>
        <br/>
        <%if (!reason.getReasonList().isEmpty()) {%>

        <table align="left" style="width: 70%;" >
            <tr style="background-color: #C3D9FF; font-weight: bold; text-align: center;">
                <td style="width:10%;">Reason ID</td>
                <td style="width:35%;">Reason Name</td>
                <td style="width:35%;">Added By</td>
            </tr>

            <tr >
                <% int i = 0;

                    for (Fine reasonList : reason.getReasonList()) {
                        if ((i % 2) != 0) {
                %>
            <tr bgcolor="#E8EEF7" height="21">
                <%} else {%>
            <tr bgcolor="white" height="21">
                <%                    }
                    i++;%>
                <td style="width:5%;"><%=reasonList.getId()%></td>
                <td style="width:35%;"><%=reasonList.getReason()%></td>    
                <td style="width:35%;"><%=reason.getMember().get(reasonList.getAddedby())%></td>    
            </tr>              
            <%}%>
        </table>

        <%}%>
    </body>
</html>