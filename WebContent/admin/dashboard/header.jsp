<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="java.lang.annotation.Target"%>
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
        <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>  
<title>header</title>
</head>
<%
	
		//response.setHeader("Cache-Control","no-cache");
	   	// response.setHeader("Cache-Control","no-store");
    	//response.setDateHeader("Expires", 0);
	    //response.setHeader("Pragma","no-cache");

    		
		//Configuring log4j properties
		
		
		
		//Logger myLogger 		= Logger.getLogger("Header");
		
		//String logout		=(String)session.getAttribute("Name");
		//if(logout == null)
		//{
			//myLogger.fatal("=========================Session Expired======================");
			%>
<%--<jsp:forward page="../SessionExpired.jsp"/>--%>
<%
	    //}
	%>
 <%
            Integer deskId = (Integer) session.getAttribute("userid_curr");
            if (deskId == null) {

            } else  {
        %>
        <script src="<%=request.getContextPath()%>/javaScript/atmosphere.js"></script>

        <script>


            document.addEventListener('DOMContentLoaded', function() {
                if (Notification.permission !== "granted")
                    Notification.requestPermission();
            });

            function notifyMe() {
                if (!Notification) {
                    alert('Desktop notifications not available in your browser. Try Chromium.');
                    return;
                }

                if (Notification.permission !== "granted")
                    Notification.requestPermission();
                else {

                    var notification = new Notification('eTracker:IssueSubject hkahkhakshdkahsdhkahsdkhaksdh', {
                        icon: 'http://www.eminentlabs.com/eTracker/eminentech%20support%20files/Eminentlabs_logo.gif',
                        body: "",
                    });

                }

            }
        </script>

        <%}%>
        <script type="text/javascript">
            $(function() {
                "use strict";
                
                var issueId;
                var socket = atmosphere;
                var subSocket;
                var transport = 'websocket';
                // We are now ready to cut the request
                var request = {url: '/eTracker/check',
                    contentType: "application/json",
                    logLevel: 'debug',
                    transport: transport,
                    trackMessageLength: true,
                    reconnectInterval: 5000};


                request.onOpen = function(response) {
                    transport = response.transport;

                    // Carry the UUID. This is required if you want to call subscribe(request) again.
                    request.uuid = response.request.uuid;
                };

                request.onClientTimeout = function(r) {
                    if (issueId.length == 0) {
                    } else {
                        subSocket.push(atmosphere.util.stringifyJSON({issueId: issueId, assignedTo: 'is inactive and closed the connection. Will reconnect in ' + request.reconnectInterval}));
                        setTimeout(function() {
                            subSocket = socket.subscribe(request);
                        }, request.reconnectInterval);
                    }
                };

                request.onReopen = function(response) {
                };

                // For demonstration of how you can customize the fallbackTransport using the onTransportFailure function
                request.onTransportFailure = function(errorMsg, request) {
                    request.fallbackTransport = "long-polling";
                };

                request.onMessage = function(response) {

                    var responseContent = response.responseBody;
                    try {
                        var json = atmosphere.util.parseJSON(responseContent);
                        var currentId = '<%=deskId%>';
                        if (json.assignedTo === undefined) {

                        } else {
                            if (currentId === json.assignedTo) {
                                var notification = new Notification(json.issueId, {
                                    icon: 'http://www.eminentlabs.com/eTracker/eminentech%20support%20files/Eminentlabs_logo.gif',
                                    body: json.subject,
                                });
                                notification.onclick = function() {
                                    window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + json.issueId);
                                };
                            }
                        }
                    } catch (e) {
                        console.log('This doesn\'t look like a valid JSON: ', responseContent);
                        return;
                    }
                };

                request.onClose = function(response) {

                };

                request.onError = function(response) {

                };

                request.onReconnect = function(request, response) {

                };

                subSocket = socket.subscribe(request);

                $("#submit").click( function() {
                    issueId = $.trim($('#issueId').val());
                    if (issueId.length == 0) {
                    } else
                    if (issueId.length === 12) {
                        var assignedTo = $("#assignedto").val();

                        if ('<%=deskId%>' === assignedTo) {

                        } else {
                            subSocket.push(atmosphere.util.stringifyJSON({issueId: issueId, assignedTo: assignedTo}));
                        }
                    }
                });


            });



        </script>
<script type="text/javascript">

	function detail(){
	
	window.open("<%=request.getContextPath()%>/version.jsp",null,
    "left=550,top=170,height=200,width=400,status=no,toolbar=no,menubar=no,location=no,titlebar=no,resizable=no,screenX=550,screenY=170" );
	
	
	}


</script>

<body>
<table width="100%" valign="right" height="5%" border="0">
	<tr>
		<td border="0" align="left" width="800"><b><font size="3"
			COLOR="#0000FF"> Welcome</font></b> <FONT SIZE="3" COLOR="#0000FF">
		<b><%=session.getAttribute("fName")%>&nbsp;<%=session.getAttribute("lName")%>,
		</b></FONT> <FONT SIZE="2" COLOR="#00CC00"> <b><%=session.getAttribute("company")%>,&nbsp;<%=session.getAttribute("lastlogon")%>
		</b></FONT><b>&nbsp;&nbsp;Last Login :  &nbsp;<%=session.getAttribute("lastlogon")%></td>

		<td width="8%" border="1" align="center"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <IMG
			SRC="<%=request.getContextPath()%>/images/help.gif" ALT="about"
			width="20" height="21" align="middle">&nbsp;&nbsp;<a
			href="javascript:detail() ">About</a></font></td>
		<td width="8%" border="1" align="center"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <IMG
			SRC="<%=request.getContextPath()%>/images/profile.jpeg" ALT="profile"
			width="17" height="18" align="middle">&nbsp;&nbsp;<a
			href="<%=request.getContextPath() %>/UserProfile/profile.jsp">Profile</a></font>
		</td>

		<td width="8%" align="center" border="1"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <IMG
			SRC="<%=request.getContextPath()%>/images/logout.gif" ALT="logout"
			width="20" height="21" align="middle">&nbsp;&nbsp;<A
			HREF="<%= request.getContextPath() %>/logout.jsp" target="_parent">Logout</A></font>
		</td>
	</tr>
</table>

</body>
</html>