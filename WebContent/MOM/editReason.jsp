<%-- 
    Document   : addReason
    Created on : Aug 20, 2014, 6:19:14 PM
    Author     : RN.Khans
--%>

<%@page import="com.eminentlabs.mom.Fine"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("editReason");
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
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
        <script type="text/javascript">
            function validate(theForm) {
                if ((theForm.amount.value) == '') {
                    alert('Enter the Amount ');
                    theForm.amount.focus();
                    return false;
                }
                  monitorSubmit();
            }
        </script>
        <script type="text/javascript">
            function numbersonly(e) {
                var unicode = e.charCode ? e.charCode : e.keyCode
                if (unicode != 8) { //if the key isn't the backspace key (which we should allow)
                    if (unicode < 48 || unicode > 57) //if not a number
                        return false ;//disable key press
                }
            }
        </script>

    </head>
    <body>
        <%@ include file="/header.jsp"%>

        <jsp:useBean id="reason" class="com.eminentlabs.mom.AddReason"></jsp:useBean>
        <%String reasonId = request.getParameter("id");
            String reasonName = request.getParameter("reasonName");
            String amount = request.getParameter("amt");%>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="leeft" width="70%">
                    <font size="10" COLOR="#0000FF"><b> Edit Reason</b></font>
                </td>
            </tr>
        </table>

        <%int assignedto = (Integer) session.getAttribute("userid_curr");%>


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
                    <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer; ">Add Fine</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/addReason.jsp" style="cursor: pointer; font-weight: bold;">Reason Maintain</a> &nbsp;&nbsp;&nbsp;
                    <%                 }%>
                    <a href="<%=request.getContextPath()%>/MOM/weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer; ">Fine Amount Report</a> &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table>
        <br/>
        <form name="theForm" method="post" action="updateReason.jsp" onsubmit="return validate(this);">

            <table width="50%" bgColor='#E8EEF7' border="0" align="center">
                

                <tr>
                    <td><strong>Reason </strong></td>
                    <td ><%=reasonName%> </td>
                </tr>

                <tr>
                    <td><strong>Amount</strong></td>
                    <td> <input type="text" id="amount" name="amount" value="<%=amount%>" onkeypress="return numbersonly(event)"/></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><input type="hidden" id="reasonId" name="reasonId" value="<%=reasonId%>" />
                        <input type=submit value=Update id="submit" name=submit> <input
                            type="reset" id="reset" value=" Reset "></td>
                </tr>             
            </table>
        </form>
        <br/>
        <br/>

    </body>
</html>