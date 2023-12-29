<%-- 
    Document   : viewRequest
    Created on : Jun 25, 2009, 3:32:24 PM
    Author     : Tamilvelan
--%>
<%@ page import="org.apache.log4j.*,java.text.*,com.eminent.util.*,com.eminent.leaveUtil.*"%>

<%
    //Configuring log4j properties

  

    Logger logger = Logger.getLogger("View Request");
  
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<%@ include file="../header.jsp"%> <br>
<%@page import="com.eminent.leaveUtil.*"%>
<%@page import="java.util.List"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <script>
            function trim(str)
            {
                while (str.charAt(str.length - 1) == " ")
                    str = str.substring(0, str.length - 1);
                while (str.charAt(0) == " ")
                    str = str.substring(1, str.length);
                return str;
            }
            function textCounter(field, cntfield, maxlimit)
            {
                if (field.value.length > maxlimit)
                {
                    field.value = field.value.substring(0, maxlimit);
                    if (maxlimit == 2000)
                        alert('Description size is exceeding 4000 characters');
                    else
                        alert('Expected Result size is exceeding 2000 characters');
                }
                else
                    cntfield.value = maxlimit - field.value.length;
            }

            function validateApprove() {
                leaveSubmit();
                var comments = document.theForm.comments.value;
                var leaveid = document.theForm.leaveid.value
                var type = document.theForm.type.value;
                var approval = 1;

                document.theForm.action = "updateLeave.jsp?comments=" + comments + "&leaveid=" + leaveid + "&type=" + type + "&approval=" + approval;
                document.theForm.submit();


            }
            function validateReject() {
                leaveSubmit();
                if (trim(document.theForm.comments.value) == '')
                {
                    alert("Please Enter the comments for rejecting Leave ");
                    document.theForm.comments.focus();
                    return false;
                }
                var comments = document.theForm.comments.value;
                var leaveid = document.theForm.leaveid.value;
                var type = document.theForm.type.value;
                var approval = -1;

                document.theForm.action = "updateLeave.jsp?comments=" + comments + "&leaveid=" + leaveid + "&type=" + type + "&approval=" + approval;
                document.theForm.submit();
                monitorSubmit();
            }
            function validateCancel() {
                leaveCancelSubmit();
                //               var comments =   document.theForm.comments.value;
                var comments = "NA";
                var leaveid = document.theForm.leaveid.value;
                var type = document.theForm.type.value;
                var approval = -2;

                document.theForm.action = "updateLeave.jsp?comments=" + comments + "&leaveid=" + leaveid + "&type=" + type + "&approval=" + approval;
                document.theForm.submit();


            }
        </script>
        <script language=javascript
                src="<%= request.getContextPath()%>/javaScript/checkSubmit.js">
        </script>
        <LINK title=STYLE	href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type=text/css rel=STYLESHEET>

        <meta http-equiv="Content-Type" content="text/html">

    </head>
    <%
        DateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        int currentuser = (Integer) session.getAttribute("userid_curr");

        String leaveDetails[][] = LeaveUtil.getLeave(currentuser);

        int noOfLeave = leaveDetails.length;

    %>
    <body>
        <TABLE width="100%">

            <TR >
                <TD align="left"  bgcolor="#E8EEF7">
                    <B>View Leave</B>
                </TD>
            </TR>
        </TABLE>
        <table>
            <tr>
                <td>
                    <a href="holidayCalendar.jsp"> Holiday Calendar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="employeeHandbook.jsp"> Employee Handbook</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="leaveRequest.jsp">Leave Request</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    
                </td>
            </tr>
        </table>
        <br></br>
        <br></br>
        <br></br>
        <%
            int leaveId = Integer.parseInt(request.getParameter("leaveid"));


            String editLeaveDetails[][] = LeaveUtil.getEditRequest(leaveId);

            int i = 0;


        %>


        <%
            logger.info("Leave Id" + editLeaveDetails[i][0]);
            logger.info("From Date" + editLeaveDetails[i][1]);
            logger.info("To Date" + editLeaveDetails[i][2]);
            logger.info("Type" + editLeaveDetails[i][3]);
            logger.info("Desc" + editLeaveDetails[i][4]);
            logger.info("Created" + editLeaveDetails[i][5]);
            logger.info("Requested" + editLeaveDetails[i][7]);
            logger.info("Assigned to" + editLeaveDetails[i][8]);
            logger.info("Approval" + editLeaveDetails[i][9]);
            logger.info("Comments" + editLeaveDetails[i][10]);


            String from = editLeaveDetails[i][1];
            String to = editLeaveDetails[i][2];
            String type = editLeaveDetails[i][3];
            String desc = editLeaveDetails[i][4];
            String created = editLeaveDetails[i][5];
            int requested = Integer.parseInt(editLeaveDetails[i][7]);
            int assignedto = Integer.parseInt(editLeaveDetails[i][8]);
            int approve = Integer.parseInt(editLeaveDetails[i][9]);
            String comments = editLeaveDetails[i][10];
            if (comments == null) {
                comments = "NA";
            }

        %>
        <form name="theForm"  method="post"">
            <table bgcolor="E8EEF7" align="center">
                <tr>
                    <td><B>From</B></td>
                    <td><%=from%></td>
                    <td><B>To</B></td>
                    <td><%=to%></td>
                </tr>
                <tr>
                    <td><b>Type</b></td>
                    <td >

                        <%=type%>
                    </td>
                    <td><B>Created On</B></td>
                    <td><%=created%></td>
                </tr>
                <tr>
                    <td><b>Reason for Leave</b></td>
                    <td colspan="3"><%=desc%></td>
                </tr>

                <tr>
                    <td><b>Comments</b></td>

                    <td colspan="3">


                        <%=comments%>

                    </td>

                </tr>

                <tr>

                    <%

                        java.util.Date toDate = sdf.parse(from);
                        String cur = sdf.format(new java.util.Date());
                        java.util.Date currDate = sdf.parse(cur);
                        logger.info(currDate+","+toDate);
                        if (approve != -1 && approve != -2) {
                            if (currDate.compareTo(toDate) < 0) {

                    %>
                    <td align="right" colspan="2"><input id="submit1" type="submit" value="Cancel Leave" onclick="validateCancel('approve')"/></td>
                        <%}else{
                                
                            }
                    }%>
                </tr>
                <tr><td><input type="hidden" name="leaveid" value="<%=leaveId%>"></td><input type="hidden" name="type" value="<%=type%>"></td></tr>
            </table>
        </form>




    </body>
</html>

