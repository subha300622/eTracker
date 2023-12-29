<%@page import="com.eminent.util.UserRegistrationMail"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
              type="text/css" rel="STYLESHEET">
        <meta http-equiv="Content-Type" content="text/html ">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
    </head>

    <body>
        <!-- Java Package Import Declarations -->
        <%@ page import="java.sql.*,pack.eminent.encryption.*"%>
        <%@ page import="java.util.Properties"%>
        <%@ page import="javax.mail.*"%>
        <%@ page import="javax.mail.internet.*"%>
        <%@ page import="javax.mail.internet.MimeMessage"%>
        <%@ page import="javax.xml.parsers.*"%>
        <%@ page import="org.w3c.dom.*,com.pack.MyAuthenticator"%>
        <%@ page import="org.apache.log4j.*,com.eminent.util.GetProjects"%>


        <!-- Notifying JSP to use AdminBean Class in the Package Named com.pack -->

        <jsp:useBean id="Register" class="com.pack.RegisterBean">
            <jsp:setProperty name="Register" property="*" />
        </jsp:useBean>

        <!-- Java Coding Starts Here -->
        <%@ include file="/header.jsp"%>
        <%

            //Configuring log4j properties
            Logger logger = Logger.getLogger("User Creation in Admin Module");

		Connection  connection = null;
            Statement mailStatement = null;
            ResultSet mailResultSet = null;
		String UserEmail=request.getParameter("userEmail");

		String company=request.getParameter("company");
		String first=request.getParameter("firstName");
		String last=request.getParameter("lastName");
		String password1=request.getParameter("password");
		String secret1=request.getParameter("secret");
		String answer1=request.getParameter("answer");
        String team=request.getParameter("team");
        String project=request.getParameter("project");

		
	try
	{
                connection = MakeConnection.getConnection();
		logger.debug("Connection:"+connection);
		if (connection!=null)
		{
			boolean state = Register.UserExist(connection,UserEmail);
			logger.debug("User Exist State:"+state);
			if (state==true)
			{
                        logger.debug("UserExists");
        %>
        <P><br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
        <TABLE bgColor=#E8EEF7 align="center">
            <TBODY>

                <tr>
                    <TD align="center"><B><FONT SIZE="3" COLOR="#FF0000">
                                Username You Have Entered Already Exist. </FONT></B></TD>
                </tr>
                <tr>
                    <td colspan="2">
                        <div align="Left">Return to eTracker Register page <a
                                href="addnewuser.jsp">Click Here </a></div>
                    </td>
                </tr>
            </TBODY>
        </TABLE>
        <P></P>
        <P></P>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <%
			}
			else
			{
					Register.createUser(connection,UserEmail);

                    String emailAdmin="";
            mailStatement = connection.createStatement();
		mailResultSet = mailStatement.executeQuery("SELECT EMAIL FROM USERS WHERE ROLEID ="+1);
		if(mailResultSet != null )
		{
			while(mailResultSet.next())
			{
                    emailAdmin = mailResultSet.getString("EMAIL");
                }
            }

            String mail = "";
      String from = emailAdmin;
            String to = UserEmail;
            //Edited by sowjanya
            MimeMessage msg= MakeConnection.getMailConnections();
            //Edit end by sowjanya
		            msg.setFrom(new InternetAddress(from));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            msg.setSubject("eTracker Account Details");
		msg.setContent("<table width='100%'><tr><font color=blue >Dear "+first+" "+last+" ,</font></tr><tr><b><font>Your eTracker&trade; <font color=blue >Username</font> has been created successfully.</b></tr><tr><b><font>Please find The Password, Secret Question and Secret Answer Below to access your account.</b></tr><tr><b><font color=blue >Password  : "+password1+"</b></tr><tr><b><font color=blue >Your Secret Question  : "+secret1+"</b></tr><tr><b><font color=blue >Your Answer for Secret Question  : "+answer1+"</b></tr><tr><font color=blue >Thanks,</font></tr><tr></tr><tr><font color=blue >eTracker&trade;</font></tr></table>","text/html");
            Transport.send(msg);

            /*Edit by mukesh*/
          String Content ="";
            String endLine = "</table><br>Thanks,";
            String signature = "<br>eTracker&trade;<br>";
            String emi = "<br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
            String lineBreak = "<br>";
            String projectName = GetProjects.getProjectName(project);

            Content = "<table><tr><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Hi,</td></tr>"
                    + "<tr><td colspan='4'><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + first + " has registered in the eTracker&trade; .<td></tr>"
                    + "<br>"
                    + "<tr><td >First Name</td><td>" + first + "</td>"
                    + "</tr><tr><td >Last Name</td><td>" + last + "</td></tr>"
                    + "<tr><td>Email</td><td> " + UserEmail + " </td></tr>"
                    + "<tr><td>Company</td><td> " + company + "</td></tr>"
                    + "<tr><td>Team</td><td> " + team + "</td></tr>"
                    + "<tr><td>Project</td><td> " + projectName + "</td></tr>"
                    + "<br>"
                    + "<tr><td colspan='3'> Please log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>  to view the user details.<td></tr>";

            Content = Content + endLine + signature + lineBreak + emi;

            UserRegistrationMail.IntimatingAdmin(Content);
            /*Edit by mukesh*/

        %>
        <jsp:forward page="/admin/user/viewuser.jsp">
            <jsp:param name="userregistration" value="true" />
            <jsp:param name="email" value="<%= UserEmail %>" />
        </jsp:forward>
        <%

                    }
                }
	}
	catch(Exception e)
    {

		logger.error("SQLException while registering new user as a Admin"+e);
	}
	finally
	{
		if(mailResultSet!=null)
                    mailResultSet.close();
		if(mailStatement!=null)
                    mailStatement.close();
         if(connection!=null)
                    connection.close();
                }


        %>

        <!-- End of Java Coding -->

    </body>

</html>