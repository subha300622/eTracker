<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
<title>Project Administration</title>
<meta http-equiv="Content-Type" content="text/html ">
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
</head>
<table width="100%" bgcolor="#EEEEEE" valign="right" height="5%"
	border="0">

	<tr>
		<td border="0" align="left" width="800"><b> <font size="3"
			COLOR="#0000FF"> Current User:</font></b> <b><FONT SIZE="3"
			COLOR="#0000FF"><b>&nbsp;<%=session.getAttribute("fName")%>&nbsp;
		<%=session.getAttribute("lName")%> </b></FONT></b></td>


		<td width="6%" align="center" border="1"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <A
			HREF="<%= request.getContextPath() %>/logout.jsp" target="_parent">Logout</A>
		</font></td>

	</tr>

</table>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<body>
<%@ page import="java.sql.*,pack.eminent.encryption.*, org.apache.log4j.*"%>
<%@ page language="java"%>
<jsp:useBean id="UserUpdate" class="com.pack.UserUpdateBean">
	<jsp:setProperty name="UserUpdate" property="*" />
</jsp:useBean>
<%!
         Connection connection=null;       
         %>
<%


    //Configuring log4j properties

		

			Logger logger = Logger.getLogger("userupdate");
		

    try{
		
		int updateStatus=0;

		connection=MakeConnection.getConnection();

		if (connection!=null)
		{
 //                       System.out.println("Next"+request.getParameter("operator"));
			//UserUpdate.Query1(connection,fname,lname,company,email1,password,mobile,mobile1,phone,phone1,phone2,name);
			updateStatus = UserUpdate.updateUser(connection);
			session.setAttribute("fName",(String)request.getParameter("firstName"));
			session.setAttribute("lName",(String)request.getParameter("lastName"));
			if(updateStatus>0)
			{
				%>
<jsp:forward page="edituser1.jsp">
	<jsp:param name="profilestatus" value="true" />
</jsp:forward>

<%
			}
		}
	}
        catch(Exception e)
        {
            logger.error("Exception in user update", e);
        }
        finally{
            if(connection!=null)
                connection.close();
        }
%>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
</body>
</html>