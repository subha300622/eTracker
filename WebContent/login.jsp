<%@ page import="javax.xml.parsers.*"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="org.apache.log4j.*"%>
<%@ page import="org.apache.log4j.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page buffer="1024kb" autoFlush="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
    Logger logger = Logger.getLogger("Login");

%>

<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST, 
SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
            <%@ include file="noScript.jsp" %>

        <META content="text/html;charset=windows-1252" http-equiv=Content-Type>
        <META content=0 http-equiv=Expires>
        <META content=no-cache http-equiv=Pragma>
        <META content=no-cache http-equiv=Cache-Control>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>

        <STYLE>
            BODY {
                BACKGROUND: white;
                COLOR: #333333;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 11px
            }

            P {
                BACKGROUND: white;
                COLOR: #333333;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 11px
            }

            HR {
                COLOR: black
            }

            A:link {
                COLOR: #cc0000
            }

            A:visited {
                COLOR: #330099
            }

            A:hover {
                COLOR: #ff3300
            }

            .footer {
                COLOR: black;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 11px
            }

            .warning {
                COLOR: red;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 11px;
                TEXT-ALIGN:CENTER;
            }

            H1 {
                COLOR: #333333;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 17px;
                FONT-WEIGHT: bold
            }

            H2 {
                COLOR: #666666;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 15px;
                FONT-WEIGHT: bold
            }

            H3 {
                COLOR: #333333;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 13px;
                FONT-WEIGHT: bold
            }

            H4 {
                COLOR: #666666;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 11px;
                FONT-WEIGHT: bold
            }

            H5 {
                COLOR: #333333;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 11px
            }

            H6 {
                COLOR: #666666;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 11px
            }

            B {
                COLOR: navy;
                FONT-WEIGHT: bold
            }

            TH {
                BACKGROUND: #000099;
                COLOR: white;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 11px;
                FONT-WEIGHT: bold;
                TEXT-ALIGN: center
            }

            TABLE {
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 11px
            }

            TD {
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 11px
            }

            .pagebreak {
                PAGE-BREAK-BEFORE: always
            }

            .general {
                BORDER-BOTTOM: #000000 1px solid;
                BORDER-LEFT: #000000 1px solid;
                BORDER-RIGHT: #000000 1px solid;
                BORDER-TOP: #000000 1px solid;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 11px;
                FONT-WEIGHT: normal;
                VERTICAL-ALIGN: middle
            }

            .bigger {
                COLOR: red;
                FONT-FAMILY: Arial, Helvetica;
                FONT-SIZE: 17px;
                FONT-WEIGHT: bold
            }

            .double {
                border-style: solid;
                border-width: 1px;
                border-color: #6699FF;
            }

            li {
                text-align: justify
            }
        </STYLE>

        <META content="Microsoft FrontPage 5.0" name=GENERATOR>
    </HEAD>
    <script language="JavaScript">
        function getRes() {
            var width = screen.width;
            var height = screen.height;
            var offset = new Date().getTimezoneOffset();
            document.getElementById('res').value = width + 'x' + height;
            document.getElementById('zone').value = offset;
        }
        function trim(str) {
            while (str.charAt(str.length - 1) == " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) == " ")
                str = str.substring(1, str.length);
            return str;
        }
        function isEmailValid(str)
        {
            var pattern = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.@_-"
            var i = 0;
            do
            {
                var pos = 0;
                for (var j = 0; j < pattern.length; j++)
                    if (str.charAt(i) == pattern.charAt(j))
                    {
                        pos = 1;
                        break;
                    }
                i++;
            }
            while (pos == 1 && i < str.length)
            if (pos == 0)
                return false;
            return true;
        }
        function fun(theForm)
        {
            if ((theForm.username.value) == '')
            {
                alert('Please Enter Email ID');
                document.theForm.username.value = "";
                theForm.username.focus();
                return false;
            }


            if (!isEmailValid(trim(theForm.username.value))) {
                alert('Please Enter Valid Email ID');
                document.theForm.username.value = "";
                theForm.username.focus();
                return false;
            }
            if ((theForm.password.value) == '')
            {
                alert('Please Enter the Password ');
                document.theForm.password.value = "";
                theForm.password.focus();
                return false;
            }
            disableSubmit();
            return true
        }
        function setFocus()
        {
            document.theForm.username.focus();
        }

        function forgotPassword()
        {
            window.open('UserProfile/forgotpassword.jsp', null, "left=371,top=180,height=300,width=400,status=no,toolbar=no,menubar=no,location=no,titlebar=no,resizable=no,screenX=10,screenY=360");
        }
        window.onload = setFocus;
    </script>
    <BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0" marginwidth="0" onload="getRes()" oncontextmenu="return(false);">
        <FORM METHOD=POST ACTION="loginvalidat.jsp" name="theForm"
              onReset=" return setFocus()" onSubmit="return fun(this)"><!--Start main table cell 1-->
            <%
                try {
                    logger.info("Session" + session.isNew());
                    logger.info("Session ID" + session.getId());
                    String SessionName = (String) session.getAttribute("Name");
                    logger.info("SessionName" + SessionName);
                    if (SessionName != null) {

                        int role = ((Integer) session.getAttribute("Role")).intValue();
                        logger.info("Role" + role);
                        if (role == 2) {
            %> <jsp:forward page="welcome.jsp" /> <%
            } else if (role == 1) {
            %> <jsp:forward page="admin/user/adminwelcome.jsp" />
            <%
                    }
                }

            %> <%            if (request.getParameter("logoutstatus") != null && request.getParameter("logoutstatus").equalsIgnoreCase("true")) {
            %>
            <TABLE bgColor=#E8EEF7 align="center">
                <TBODY>
                    <TR>
                        <TD align="center"><B><FONT SIZE="4" COLOR="#33CC33">
                                    You have been logged out successfully. </FONT></B></TD>
                    </tr>
                </TBODY>
            </TABLE>
            <%
            } else if (request.getParameter("logoutstatus") != null && request.getParameter("logoutstatus").equalsIgnoreCase("Session Expired")) {
            %>
            <TABLE bgColor=#E8EEF7 align="center">
                <TBODY>
                    <TR>
                        <TD align="center"><B><FONT SIZE="4" COLOR="#33CC33">
                                    Your session has expired. Login again </FONT></B></TD>
                    </tr>
                </TBODY>
            </TABLE>
            <%
                }
            %> <BR>
            <TABLE border=0 cellPadding=0 cellSpacing=0 width="100%" height="1%">
                <TBODY height="100%">
                <BR>
                <BR>
                <TR>
                    <TD width="3%"></TD>
                    <TD width="16%"><img border="0"
                                         src="eminentech support files/Eminentlabs.png"
                                         alt="Eminentlabs Software Pvt. Ltd."></TD>
                    <TD width="70%"><!--Start table for cell 2-->
                        <TABLE border=0 cellPadding=0 cellSpacing=0 width="95%" height="10%">

                            <TR>
                                <TD>
                                    <TABLE border=0 cellPadding=0 cellSpacing=0 width="100%">
                                        <TR>
                                            <TD align=left border=0 bgColor=#C3D9FF height=23 vAlign=center
                                                width="100%">&nbsp;<b>Welcome Customer</b></TD>
                                        </TR>
                                    </TABLE>
                                    <!--End table for customer/buttons--></TD>
                            </TR>
                        </TABLE>
                        <!--End table for cell 2--></TD>
                </TR>
                </TBODY>
            </TABLE>
            <BR>
            <BR>
            <TABLE align=center width="90%" height="10%">
                <TBODY>
                    <TR vAlign=top>
                        <TD><BR>
                            <BR>
                            <BR>
                            <TABLE class="double" color="#C3D9FF">
                                <TBODY>
                                    <TR>

                                        <TD>
                                            <TABLE bgColor=#E8EEF7 border=0>
                                                <TBODY>


                                                    <%!
        //                		String domain,mailServer;
                                                    %>
                                                    <%
//							logger.debug("SessionID Status:"+session.isNew());
//							logger.debug("SesssionID:"+session.getId());
                                                        if (session != null) {
                                                            session.invalidate();
                                                            logger.info("Invalidating session");
                                                        }

//							String contextRootPath = this.getServletContext().getRealPath("/");
//							String dirPath = contextRootPath + "/configuration";
//							String filePath = dirPath + "/domains.xml";
//							DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
//							DocumentBuilder db = dbf.newDocumentBuilder();
//							Document doc = db.parse(filePath);
//							NodeList list = doc.getChildNodes();
//							int childCnt = list.getLength();
//							for(int i=0; i<childCnt;i++)  
//							{
//								domain = doc.getDocumentElement().getElementsByTagName("Domain").item(i).getTextContent().trim();
//								mailServer = doc.getDocumentElement().getElementsByTagName("MailServerName").item(i).getTextContent().trim();
//								logger.info("Domain Name:"+domain);
//								logger.info("MailServerName:"+mailServer);
//								application.setAttribute("Domain",domain);
//								application.setAttribute("MailServerName",mailServer);
//							}

                                                    %>


                                                    <%                                                                    String emailId = "";
                                                        Cookie[] cookie = request.getCookies();
                                                        if (cookie != null) {
                                                            for (int i = 0; i < cookie.length; i++) {
                                                                if (cookie[i].getName().equalsIgnoreCase("emailId")) {
                                                                    emailId = cookie[i].getValue();
                                                                }
                                                            }
                                                        }

                                                    %>
                                                    <TR>
                                                        <TD><FONT SIZE="2">Email ID</FONT></TD>
                                                        <TD><INPUT class=general name=username size=25 type="text"
                                                                   maxlength="100"
                                                                   value="<%= emailId%>"></TD>
                                                    </TR>

                                                    <%


                                                    %>
                                                    <TR>
                                                        <TD><FONT SIZE="2">Password</FONT></TD>
                                                        <TD><INPUT class=general name=password size=25
                                                                   type=password maxlength="16"></TD>
                                                    </TR>

                                                    <%                                                                    if (request.getParameter("userAuthentication") != null && request.getParameter("userAuthentication").equals("false")) {
                                                    %>
                                                <font color="red" face="Tahoma" size="2"><%= "Invalid Username or Password"%></font>
                                                    <%
                                                    } else if (request.getParameter("userAuthentication") != null && request.getParameter("userAuthentication").equals("true")) {
                                                    %>
                                                <font color="red" face="Tahoma" size="2"><%= "Invalid Username or Password"%></font>
                                                    <%
                                                        }
                                                    %>
                                                <TR>
                                                    <TD align=center  colspan="2"><INPUT type=submit id="submit" value="Sign In" name=Register></TD>

                                                </TR>
                                                <TR>
                                                    <TD><span class="style10"><font
                                                                color=#0033FF><B><a	href="<%=request.getContextPath()%>/UserManagement/register.jsp"><u>New User?</u></a></span></td>
                                                                    <TD ALIGN="right"><span class="style10"><font
                                                                                color=#0033FF><a href="javascript:forgotPassword()"><B><U>Forgot
                                                                                            Password?</U></B></a></font> </span>
                                                                        </TR>
                                                                        </TBODY>
                                                                        </TABLE>
                                                                    </TD>
                                                                    </TR>
                                                                    </TBODY>
                                                                    </TABLE>
                                                                    <BR>
                                                                    <BR>
                                                                    <BR>


                                                                    </TD>
                                                                    <%
                                                                        } catch (Exception e) {
                                                                            logger.error("Login Error:" + e);

                                                                        }
                                                                    %>
                                                                    <TD>&nbsp;&nbsp;</TD>
                                                                    <TD vAlign=top height="10%" width="66%"><BR>
                                                                        <BR>
                                                                        <BR>
                                                                        <font size=4>Welcome To Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution </font><BR>
                                                                        <BR>
                                                                        <BR>
                                                                        <font size=3><b>eTracker&#153; </b></font><BR>
                                                                        <BR>
                                                                        <UL>
                                                                            <li>eTracker&#153; is a complete CRM, APM, TQM, ERM and Enterprise Performance
                                                                                Tracking System</li>
                                                                            <li>eTracker&#153; brings in visibility in the system aiding in
                                                                                quick decision making</li>
                                                                            <li>eTracker&#153; allows employees to track, manage and follow
                                                                                the defined processes to continuously improve productivity and
                                                                                reduce company-operating costs</li>
                                                                            <li>eTracker&#153; provides an effective communication link to
                                                                                be forged between people working in different departments across
                                                                                geographical locations</li>
                                                                        </UL>
                                                                        <h3>FEATURES AND BENEFITS</h3>
                                                                        <ul>
                                                                            <li>Information to help ensure the quality, security, and
                                                                                performance of your Distributed Software Development</li>
                                                                            <li>Information about software maintenance, functional
                                                                                enhancements and updates, and technical support</li>
                                                                            <li>Information that helps you realize the full value of your
                                                                                Enterprise and optimize the performance of your resources</li>
                                                                            <li>Improves productivity and deliver a better customer
                                                                                experience</li>
                                                                            <li>Easy integration with any of your existing website or
                                                                                portals</li>
                                                                        </ul>

                                                                        <br>

                                                                    </TD>
                                                                    </TR>
                                                                    </TBODY>
                                                                    </TABLE>
                                                                    <DIV class=warning><SCRIPT language=javascript>
                                                                        if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion >= "4.0")
                                                                        {
                                                                            document.write("")
                                                                        }
                                                                        if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion < "4.0")
                                                                        {
                                                                            document.write("This website is best experienced using Microsoft Internet Explorer 4+. IE 3.02+ and Netscape Navigator 4.5+ are also supported.")
                                                                        }
                                                                        if (navigator.appName == "Netscape" && navigator.appVersion >= "4.0")
                                                                        {
                                                                            document.write("This website is best experienced using Microsoft Internet Explorer 4+. IE 3.02+ and Netscape Navigator 4.5+ are also supported. You are running Netscape 4 or better")
                                                                        }
                                                                        if (navigator.appName == "Netscape" && navigator.appVersion < "4.0")
                                                                        {
                                                                            document.write("This website is best experienced using Microsoft Internet Explorer 4+. IE 3.02+ and Netscape Navigator 4.5+ are also supported. Warning: You are running Netscape 3.x or under")
                                                                        }
                                                                        if (navigator.appName != "Microsoft Internet Explorer" && navigator.appName != "Netscape")
                                                                        {
                                                                            document.write("This website is best experienced using Microsoft Internet Explorer 4+. IE 3.02+ and Netscape Navigator 4.5+ are also supported. Warning: You are not running IE or Netscape")
                                                                        }
                                                                        </SCRIPT></DIV>
                                                                    <BR>


                                                                    <DIV align=center class=warning>Your browser must accept cookies
                                                                        to enter this site.</DIV>

                                                                    <br>
                                                                    <br>
                                                                    <TABLE border=0 width="96%">
                                                                        <TR>
                                                                            <TD width="2%"></TD>
                                                                            <TD bgColor="#C3D9FF" align=center noWrap vAlign=top width="100%"
                                                                                height=20><font face="Verdana" size="1" color="#666666">
                                                                                    ERPDS&#153;, EWE&#153;, eTracker&#153;, eOutsource&#153;, Rightshore&#153; are registered trademarks of Eminentlabs&#153; Software Private Limited</font></TD>
                                                                        </TR>
                                                                        <tr><td><input type="hidden" name="res" id="res" /><input type="hidden" name="zone" id="zone" />
                                                                                <INPUT type="hidden" name="protocal" value="" />
                                                                            </td></tr>
                                                                    </TABLE>

                                                                    </FORM>
                                                                    </BODY>

                                                                   
                                                                    </HTML>
