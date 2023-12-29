
<%@page import="com.eminent.notification.Notification"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.holidays.Holidays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@ page import="org.apache.log4j.*"%>

<%
    //Configuring log4j properties

    Logger logger = Logger.getLogger("Holiday Calendar");

    int assignedto = (Integer) session.getAttribute("userid_curr");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<%@ include file="../header.jsp"%> <br>
<html>
    <head>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script> 
        <script type="text/javascript">    CKEDITOR.timestamp = '123';</script>
        <meta http-equiv="Content-Type" content="text/html">
        <meta name="Generator" content="EditPlus">
        <meta name="Author" content="">
        <meta name="Keywords" content="">
        <meta name="Description" content="">
    </head>
    <jsp:useBean id="nc" class="com.eminent.notification.NotificationController"></jsp:useBean>
    <% nc.setAll(request);%>
    <body>

        <TABLE width="100%">

            <TR>
                <TD align="left"  bgcolor="#E8EEF7">
                    <B>Manage Notification</B>
                </TD>
            </TR>

        </TABLE>

        <table>
            <tr>
                <td >
                    <a href="<%=request.getContextPath()%>/UserProfile/employeeHandbook.jsp"> Employee Handbook</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/UserProfile/leaveRequest.jsp">Leave Management</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%
                        if (assignedto == 112 || assignedto == 103 || assignedto == 104) {%>
                    <a href="<%=request.getContextPath()%>/leave/leaveView.jsp">Leaves </a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/leave/LeaveViewByPeriod.jsp">Leaves Summary </a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/UserProfile/manageNotification.jsp" style="cursor: pointer;font-weight: bold;">Notification </a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <% }%>
            </tr>
        </table>


        <br/>
        <br/>

        <form class="theForm" method="post" action="<%=request.getContextPath()%>/UserProfile/manageNotification.jsp">
            <table width="70%" bgColor=#E8EEF7 border="0" >



                <tr>
                    <td><strong>Notification</strong></td>

                    <td height="21" width="80%"><font size="2"
                                                      face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                                      name="notification" wrap="physical" id="notificationName" cols="84" rows="4"
                                                      onKeyDown="textCounter(document.theForm.notification, document.theForm.remLen1, 4000);"
                                                      onKeyUp="textCounter(document.theForm.notification, document.theForm.remLen1, 4000);"><%=nc.getNotification().getNotification()%></textarea></font></td>
                <script type="text/javascript">
                    CKEDITOR.replace('notification', {toolbar: 'Basic', height: 100});
                    var editor_data = CKEDITOR.instances.notification.getData();
                    CKEDITOR.instances["notification"].on("instanceReady", function ()
                    {

                        //set keyup event
                        this.document.on("keyup", updateTextArea);
                        //and paste event
                        this.document.on("paste", updateTextArea);

                    });

                    function updateTextArea()
                    {
                        CKEDITOR.tools.setTimeout(function ()
                        {
                            var desc = CKEDITOR.instances.notification.getData();
                            var leng = desc.length;
                            editorTextCounter(leng, document.theForm.remLen1, 4000);

                        }, 0);
                    }
                </script>     

                </tr>
                <tr>
                    <td><strong>Name </strong></td>
                    <td>
                        <select name="notificationType" id="notificationType">
                            <option value="">Select</option>
                            <%for (String type : nc.getNotificationType()) {
                                    if (nc.getNotification().getNotificationType().equalsIgnoreCase(type)) {%> 
                            <option selected=""><%=type%></option>
                            <%} else {%>
                            <option><%=type%></option>

                            <%}%>
                            <%}%>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td><strong>Expiry Date</strong></td>
                    <td> <input type="text" id="expiryDate" name="expiryDate"  maxlength="10" size="10" readonly  value="<%=nc.converDateToString(nc.getNotification().getExpiryDate())%>"/><a href="javascript:NewCal('expiryDate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a>

                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <input type="hidden" name="notificationId" id="notificationId"  value="<%=nc.getNotification().getNotificationId()%>"/>

                        <%if (nc.getNotification().getNotificationId() > 0l) {%>
                        <input type="submit"  name="submit" id="submit"   value="Update"/></span>
                        <%} else {%>
                        <input type="submit" name="submit" id="submit" value="Submit" ></span> 
                        <%}%>

                        <input
                            type="reset" id="reset" value=" Reset "></td>
                </tr>             
            </table>
        </form>



        <table style="width: 90%;" >
            <tr style="background-color: #C3D9FF;font-weight: bold;height: 21px;">
                <th>SNo.</th>
                <th>Notification</th>
                <th>Notification Type</th>
                <th>Expiry Date</th>
            </tr>
            <%
                int i = 0;
                for (Notification notification : nc.getNotifications()) {

                    if (i % 2 == 0) {%>
            <tr style="height: 21px;"  id="notificationRow<%=notification.getNotificationId()%>">  
                <%} else {%>
            <tr style="background-color: #E8EEF7;height: 21px;"  id="notificationRow<%=notification.getNotificationId()%>">
                <%}
                    i++;
                %>
                <td><%=i++%></td>
                <td> <a href="<%=request.getContextPath()%>/UserProfile/manageNotification.jsp?notificationId=<%=notification.getNotificationId()%>"><%=notification.getNotification()%></a></td>
                <td><%=notification.getNotificationType()%></td>
                <td><%=nc.converDateToString(notification.getExpiryDate())%></td>

                <%}
                %>

            </tr>

        </table>
        <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script> 


        <script type="text/javascript">

                                                        $("#submit").click(function () {
                                                            $('.error2').remove();
                                                            var count = 0;
                                                            var notification = $("#notificationName").val();
                                                            var notificationType = $("#notificationType").val();
                                                            var notificationId = $("#notificationId").val();
                                                            notification = $.trim(notification);
                                                            if (notification.length == 0) {
                                                                $("<div class='error2'>Notification cannot be empty</div>").insertAfter("#notificationName");
                                                                count = 1;
                                                            } else if (notification.length > 2000) {
                                                                $("<div class='error2'>Notification cannot be more than 2000 characters</div>").insertAfter("#notificationName");
                                                                count = 1;
                                                            } else {
                                                                $.ajax({
                                                                    url: '<%=request.getContextPath()%>/UserProfile/checkNotification.jsp',
                                                                    data: {notificationId: notificationId, notification: notification, rand: Math.random(1, 10)},
                                                                    async: false,
                                                                    type: 'GET',
                                                                    success: function (responseText, statusTxt, xhr) {

                                                                        if (statusTxt == "success") {
                                                                            var result = $.trim(responseText);
                                                                            if (result === "false") {
                                                                                $("<div class='error2'><b>'" + notification + "'</b> Notification already exists</div>").insertAfter("#reset");
                                                                                count = 1;
                                                                            }
                                                                        }
                                                                    }
                                                                });
                                                            }
                                                            if (notificationType.length == 0) {
                                                                $("<div class='error2'>Select a Notification type </div>").insertAfter("#notificationType");
                                                                count = 1;
                                                            }
                                                            if (count === 0) {
                                                                document.theForm.submit();
                                                                return true;
                                                            } else {

                                                                return false;
                                                            }
                                                        });
                                                        $(".deleteNotification").click(function () {
                                                            var notificationId = $(this).attr('id');

                                                            if (confirm("Do you want to delete a Notification?")) {
                                                                $.ajax({
                                                                    url: '<%=request.getContextPath()%>/pages/notification/deleteNotification.jsp',
                                                                    data: {notificationId: notificationId, rand: Math.random(1, 10)},
                                                                    async: false,
                                                                    type: 'GET',
                                                                    success: function (responseText, statusTxt, xhr) {

                                                                        if (statusTxt == "success") {
                                                                            var result = $.trim(responseText);
                                                                            if (result === "false") {
                                                                                $('#notificationRow' + notificationId).remove();
                                                                                $(".message").html("Notification Deleted Successfully");
                                                                            } else {
                                                                                $(".message").html("Please Try/Again");
                                                                            }
                                                                        }
                                                                    }


                                                                });

                                                            } else {

                                                            }
                                                        });
                                                        function editorTextCounter(field, cntfield, maxlimit)
                                                        {
                                                            if (field > maxlimit)
                                                            {

                                                                if (maxlimit === 4000)
                                                                    alert('Description size is exceeding 4000 characters');
                                                                else
                                                                    alert('Expected Result size is exceeding 2000 characters');
                                                            } else
                                                                cntfield.value = maxlimit - field;
                                                        }
        </script>
    </div>
    <noscript>
    <style type="text/css">
        .pagecontainer{display :none;}
        .noscriptmsg{color:red;font-size: 36px;}
    </style>
    <div class="noscriptmsg">
        Java script is disabled on your browser.Please enable java script. 
    </div>
    </noscript>
</body>
</html>