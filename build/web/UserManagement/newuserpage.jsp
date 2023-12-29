<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>
    </head>
    <body>
        <%@ page import="java.sql.*,com.eminent.util.UserRegistrationMail"%>
        <%@ page import="pack.eminent.encryption.*"%>
        <%@ page import="org.apache.log4j.*"%>
        <%@ page import="com.pack.MyAuthenticator,com.eminent.util.*"%>
        <%@ page import="javax.mail.*,dashboard.*"%>
        <%@ page import="java.util.*,java.text.*"%>
        <%@ page import="javax.mail.internet.*"%>
        <%@ page import="javax.mail.internet.MimeMessage"%>
        <jsp:useBean id="Register" class="com.pack.RegisterBean">
            <jsp:setProperty name="Register" property="*" />
        </jsp:useBean>
        <%

            //Configuring log4j properties
            Logger logger = Logger.getLogger("New User Page");

	Connection connection= null;

	try
	{
                connection = MakeConnection.getConnection();
                String UserEmail = request.getParameter("userEmail");
                String name = request.getParameter("firstName");
                String lName = request.getParameter("lastName");

                String ucompany = request.getParameter("company");

                String Operator = request.getParameter("operator");
                String mobile = request.getParameter("mobile");
                logger.info("Registered User Name" + name);
                if (connection != null) {
                    boolean state = Register.UserExist(connection, UserEmail);
                    if (state == true) {
        %>
        <jsp:forward page="userexist.jsp" />
        <%
			}
			else
			{
					Register.CreateUser(connection,UserEmail);
        %>
        <!-- 			<jsp:getProperty name="Register" property = "firstName" />
        <jsp:getProperty name="Register" property = "lastName" />
        <jsp:getProperty name="Register" property = "password" />
        <jsp:getProperty name="Register" property = "userEmail" />
        <jsp:getProperty name="Register" property = "company" />
        <jsp:getProperty name="Register" property = "phone" />
        <jsp:getProperty name="Register" property = "phone1" />
        <jsp:getProperty name="Register" property = "phone2" />
        <jsp:getProperty name="Register" property = "mobile" />                
        <jsp:getProperty name="Register" property = "mobile1" />
        -->
        <%             //Edited by sowjanya
                                        MimeMessage msg= MakeConnection.getMailConnections();
                                        //Edit End by sowjanya
                        msg.setHeader("Content-Type", "text/plain;charset=UTF-8");
				msg.setFrom(new InternetAddress("admin@eminentlabs.net","Eminentlabs eTracker"));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(UserEmail));
            //				msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));
            msg.setSubject("Your eTracker Account Has Been Created Successfully!!");
				String htmlContent="<table width='100%'><tr><font color=blue >Dear Mr."+name+",</font></tr><tr><b><font color=blue >Your eTracker&trade; account has been created successfully. Please wait for Admin to approve your registration</font></tr><tr><font color=blue >Thanks,</font></tr><tr><font color=blue >eTracker&trade;  Team</font></tr></table>";
				msg.setContent(htmlContent,"text/html");

            Transport.send(msg);
            /*Edit by mukesh*/
            String Content ="";
            String endLine = "</table><br>Thanks,";
            String signature = "<br>eTracker&trade;<br>";
            String emi = "<br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
            String lineBreak = "<br>";

            Content = "<table><tr><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Hi,</td></tr>"
                    + "<tr><td colspan='4'><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + name + " has registered in the eTracker&trade;.<td></tr>"
                    + "<br>"
                    + "<tr><td >First Name</td><td>" + name + "</td>"
                    + "</tr><tr ><td>Last Name</td><td>" + lName + "</td></tr>"
                    + "<tr><td>Email</td><td> " + UserEmail + " </td></tr>"
                    + "<tr><td>Company</td><td> " + ucompany + "</td></tr>"
                    + "<br>"
                    + "<tr><td colspan='3'> Please log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>  to view the user details.<td></tr>";

            Content = Content + endLine + signature + lineBreak + emi;
            UserRegistrationMail.IntimatingAdmin(Content);
            /*Edit by mukesh*/
        %>
        <jsp:forward page="registersuccess.jsp" />
        <%
                    }
                }
	}
	catch(Exception e)
    {

                logger.error(e.getMessage());
	} 
	finally
	{
		if (connection!=null)
		{
                    connection.close();
                }
            }
        %>
    </body>
</html>