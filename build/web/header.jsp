<%@page import="com.eminent.notification.NotificationController"%>
<%@page import="com.eminent.notification.Notification"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.issue.controller.DueDateNotificationController"%>
<%@page import="com.eminent.util.VerifiedStatusCheck"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="java.lang.annotation.Target"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.min.js"></script>  
    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.js"></script>  
    <script type="text/javascript"	src="<%= request.getContextPath()%>/javaScript/XMLHttpRequest.js"></script>   

    <%
        Integer deskId = (Integer) session.getAttribute("userid_curr");
        if (deskId == null) {

        } else {
    %>


    <%}%>
    <script>
        $.noConflict();
    </script>
    <style>
        body {font-family: Arial, Helvetica, sans-serif;}

        /* The Modal (background) */
        .notificationPop {
            position: fixed; /* Stay in place */
            z-index: 10;  
            /*            padding-top: 50px;  Location of the box */
            left: 0;
            /*            top: 0;*/
            width: 80%;  
            /*    height: 50%;  Full height */     
            overflow: auto; /* Enable scroll if needed */
            /*           background-color: rgb(0,0,0);  
                          background-color: rgba(0,0,0,0.4); */
            /*            margin-left: 200px;*/
        }

        /* Modal Content */
        .modal-content {
            background-color: #e0ecff;


        }

        .sticky-note { 
            width: 60%;
            height: 50%;
            resize: both;
            overflow: auto;
            background:#ecf1f7;
            border-radius: 10px; 
            margin: auto;
            border: 1px solid #173653;                      font-family: Helvetica, Arial, sans-serif; 
            font-size: 13px; box-shadow: 2px 2px 10px rgba(0,0,0,0.4); 
        }
        .contents { background: #ecf1f7; margin: 20px; outline: none; text-align: justify}
        .handle { padding-bottom: 10px;background: #C3D9FF; border-radius: 8px 8px 0px 0px; }
        .handle { cursor: pointer;}
        .close { cursor: pointer;float: right; font-size:20px;
                 font-weight: bold;  opacity: 1; text-shadow: 1px 0px 1px #a08805; padding: 4px; }


    </style>

    <style type="text/css">
        .links { text-decoration: none;}
        .noti{
            width: 100px;
            text-align: center;
            /* width and height can be anything, as long as they're equal */
        }
        .image {
            position:relative;
            float:left; /* optional */
        }
        .image1 {
            position:relative;
            float: start; /* optional */
            width: 4%;
        }
        .image .text {
            position:absolute;
            top:1px; /* in conjunction with left property, decides the text position */
            left:16px;
            width:300px;
            alignment-adjust: before-edge;/* optional, though better have one */
        }
        .image1 .text {
            position:absolute;
            top:1px; /* in conjunction with left property, decides the text position */
            left:16px;
            width:300px;
            alignment-adjust: before-edge;/* optional, though better have one */
        }
    </style>
    <script type="text/javascript">
        var LogTimer = 0, CommitTimesToLogout = 60 * 60, CommitTimesToWarning = 55 * 60, CommitTimes = 0, CheckInterval = 1000;
        function CommitLogoutTimer()
        {
            document.getElementById("nSecs").innerHTML = parseInt((CommitTimesToLogout - CommitTimes) * CheckInterval / 1000);
            try {
                clearTimeout(LogTimer);
            } catch (Ex) {
            }
            CommitTimes++;
            if (CommitTimes == CommitTimesToLogout)
                window.location.href = ("<%= request.getContextPath()%>/SessionExpired.jsp");
            if (CommitTimes == CommitTimesToWarning)
                document.getElementById("LogoutBox").style.display = "";
            LogTimer = setTimeout("CommitLogoutTimer()", CheckInterval);
        }
        function KeepAlive()
        {
            CommitTimes = 0;
            document.getElementById("LogoutBox").style.display = "none";
            $.ajax({
                url: 'help.jsp',
                success: function (data) {

                }
            });
        }
    </script> 
    <script language="Javascript" type="text/javascript">
        beforeload = (new Date()).getTime();
        function pageloadingtime()
        {

            //calculate the current time in afterload
            afterload = (new Date()).getTime();
            // now use the beforeload and afterload to calculate the seconds
            secondes = (afterload - beforeload) / 1000;
            // If necessary update in window.status
            window.status = 'You Page Load took  ' + secondes + ' seconde(s).';
            // Place the seconds in the innerHTML to show the results
            document.getElementById("loadingtime").innerHTML = "<font color='red'>You Page Load took " + secondes + " second(s).</font>";

        }

        //
        //var isNS = (navigator.appName == "Netscape") ? 1 : 0;
        //var EnableRightClick = 0;
        //if(isNS)
        //document.captureEvents(Event.MOUSEDOWN||Event.MOUSEUP);
        //function mischandler(){
        //  if(EnableRightClick==1){ return true; }
        //  else {return false; }
        //}
        //function mousehandler(e){
        //  if(EnableRightClick==1){ return true; }
        //  var myevent = (isNS) ? e : event;
        //  var eventbutton = (isNS) ? myevent.which : myevent.button;
        //  if((eventbutton==2)||(eventbutton==3)) return false;
        //}
        //function keyhandler(e) {
        //  var myevent = (isNS) ? e : window.event;
        //  if (myevent.keyCode==96)
        //    EnableRightClick = 1;
        //  return;
        //}
        //document.oncontextmenu = mischandler;
        //document.onkeypress = keyhandler;
        //document.onmousedown = mousehandler;
        //document.onmouseup = mousehandler;
        //
        //Hides all status bar messages

        function hidestatus() {
            window.status = ''
            return true
        }

        if (document.layers)
            document.captureEvents(Event.MOUSEOVER | Event.MOUSEOUT)

        document.onmouseover = hidestatus
        document.onmouseout = hidestatus
    </script>


    <script language="Javascript" type="text/javascript">


        function showNotification()
        {
            var modal = document.getElementById("notificationDiv");
            if (modal.style.display === "block") {
                modal.style.display = "none";
            } else if (modal.style.display === "none") {
                modal.style.display = "block";
            }
        }

    </script>
</head>
<%
//		response.setHeader("Cache-Control","no-cache");
    //	   	response.setHeader("Cache-Control","no-store");
    //               response.setDateHeader("Expires", 0);
    //                response.setHeader("Pragma","no-cache");

    //Configuring log4j properties
    //Logger myLogger 		= Logger.getLogger("Header");
    //String logout		=(String)session.getAttribute("Name");
    //if(logout == null)
    //{
    //myLogger.fatal("=========================Session Expired======================");
%>
<%--<jsp:forward page="../SessionExpired.jsp"/>--%>
<%	    //}
%>

<script type="text/javascript">

    function detail() {

        window.open("<%=request.getContextPath()%>/version.jsp", null,
                "left=550,top=170,height=200,width=400,status=no,toolbar=no,menubar=no,location=no,titlebar=no,resizable=no,screenX=550,screenY=170");


    }


</script>

<%@ include file="noScript.jsp" %>

<body onload="CommitLogoutTimer();">
    <div id="LogoutBox"
         style="display: none; z-index: 100; text-align: center; background-color: #4169E1;">
        <label style="color:white;">
            You will be logged out in</label>&nbsp;<a
            id="nSecs" style="color: white; font-weight: bold;"></a>&nbsp;<label style="color:white;">
            seconds.</label><br />
        <label style="color:white;">
            To stay logged in, Please click &quot;OK&quot;.</label><br />

        <input type="button" onclick="KeepAlive();" value="OK"></input></div>
        <%
            int notify = 0;
            Integer headeruserId = (Integer) session.getAttribute("userid_curr");
            String lastlog = (String) session.getAttribute("lastlogon");
            if (lastlog == null) {
                lastlog = "NA";
            }

            int newissues = VerifiedStatusCheck.GetNewIssues(headeruserId, lastlog);
            int dueDateIssueCount = DueDateNotificationController.GetDueDateIssueCount(headeruserId);
            List<Notification> notifications = NotificationController.getNotificationList(request);
            if (notifications.size() > 0) {
                notify = NotificationController.todayCount(notifications);
            }

        %>
    <table width="100%" valign="right" height="5%" border="0">
        <tr>
            <%String lName = (String) session.getAttribute("lName");%>
            <td border="0" align="left" width="800"><b><font size="3"
                                                             COLOR="#0000FF"> Welcome</font></b> <FONT SIZE="3" COLOR="#0000FF">
                    <b><%=session.getAttribute("fName")%>&nbsp;<%=lName.substring(0, 1)%>,
                    </b></FONT> <FONT SIZE="2" COLOR="#00CC00"> <b><%=session.getAttribute("company")%>&nbsp;&nbsp;
                        <font size="3" COLOR="#0000FF"> Last Login:</font> <%=session.getAttribute("lastlogon")%>
                    </b></FONT></td>

            <%if (notifications.size() > 0) {
            %>
            <td class="image1" >
                <IMG SRC="<%=request.getContextPath()%>/images/notification.png" ALT="Notification" style="vertical-align: text-top;text-align: right;position: relative; top: 0; left: 0;"
                    width="20" height="25" ><a class="text" href="#" title="Notification" style="vertical-align: top;width:1%; " class="noti" onclick="javascript:showNotification();"><%=notifications.size()%></a>
            </td>
            <%}%>

            <%if (dueDateIssueCount > 0) {
            %>
            <td class="image1">
                <IMG
                    SRC="<%=request.getContextPath()%>/images/due.png" ALT="Due Date Exceed issues"
                    width="20" height="25" style="vertical-align: text-top;text-align: right;position: relative; top: 0; left: 0;"><a class="text" href="/eTracker/MyAssignment/dueDateIssues.jsp" title="Due Date Exceed issues" class="noti" style="vertical-align: top;width:1%; " ><%=dueDateIssueCount%></a>
            </td>
            <%}%>



            <%if (newissues > 0) {
            %>
            <td class="image">
                <IMG
                    SRC="<%=request.getContextPath()%>/images/bellb.png" ALT="New Assigned issues"
                    width="20" height="25" style="vertical-align: text-top;text-align: right;position: relative; top: 0; left: 0;"><a class="text" href="/eTracker/MyAssignment/newAssigned.jsp" title="New Assigned issues" class="noti" style="vertical-align: top;width:1%; " ><%=newissues%></a>
            </td>
            <%}%>

            <td width="8%" border="1" align="center"><font size="2"
                                                           face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                        SRC="<%=request.getContextPath()%>/images/New.jpg" ALT="New Features"
                        width="25" height="15" align="middle">&nbsp;&nbsp;<a class="links"
                        href="<%=request.getContextPath()%>/newFeatures.jsp">Features</a></font></td>
            <td width="8%" border="1" align="center"><font size="2"
                                                           face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                        SRC="<%=request.getContextPath()%>/images/update.gif" ALT="about"
                        width="20" height="21" align="middle">&nbsp;&nbsp;<a class="links"
                        href="<%=request.getContextPath()%>/help.jsp ">Help</a></font></td>
            <td width="8%" border="1" align="center"><font size="2"
                                                           face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                        SRC="<%=request.getContextPath()%>/images/help.gif" ALT="about"
                        width="20" height="21" align="middle">&nbsp;&nbsp;<a class="links"
                        href="javascript:detail() ">About</a></font></td>
            <td width="8%" border="1" align="center"><font size="2"
                                                           face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                        SRC="<%=request.getContextPath()%>/images/profile.jpeg" ALT="profile"
                        width="17" height="18" align="middle">&nbsp;&nbsp;<a class="links"
                        href="<%=request.getContextPath()%>/UserProfile/profile.jsp">Profile</a></font>
            </td>

            <td width="8%" align="center" border="1"><font size="2"
                                                           face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                        SRC="<%=request.getContextPath()%>/images/logout.gif" ALT="logout"
                        width="20" height="21" align="middle">&nbsp;&nbsp;<A  class="links"
                        HREF="<%= request.getContextPath()%>/logout.jsp" target="_parent">Logout</A></font>
            </td>
        </tr>
    </table>
    <div id="notificationDiv" class="notificationPop"  style="display: none;">

        <div class="sticky-note">
            <div ondblclick="javascript:showNotification();" class="handle">&nbsp;<div onclick="javascript:showNotification();" class="close">&times;</div></div>
            <%                for (Notification notification : notifications) {
            %>
            <div ondblclick="javascript:showNotification();" class="contents">
                <%=notification.getNotification()%>
            </div>               
            <br/>
            <%}%>
        </div>
    </div>

</body>
</html>