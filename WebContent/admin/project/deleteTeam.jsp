<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
	
	Logger logger = Logger.getLogger("Project");
	logger.setLevel(Level.DEBUG);
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}
%>
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
<meta name="Generator" content="EditPlus">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<META content=0 http-equiv=Expires>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
</head>

<body bgcolor="#FFFFFF">
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page language="java"%>
<div align="center">
<center><%! 
        int userid=0;
        int pid=0;
        PreparedStatement ps;
        PreparedStatement ps1;
        ResultSet rs1=null;
        int rowcount;
%> <% 
    int id=0;
 
  //  Logger logger = Logger.getLogger("MyQueryDelete");
 
    Connection connection=null;
    ResultSet rs=null,rsName=null;
    String status=null;
    String name="";
    try
    {
	connection=MakeConnection.getConnection();
        if (connection!=null)
	{
		userid = Integer.parseInt(request.getParameter("userid"));
                ps1 = connection.prepareStatement("select firstname,lastname from users where userid=?");
      		ps1.setInt(1,userid);
                rs1=ps1.executeQuery();
                if (rs1!=null)
                {
                        while (rs1.next())
                        {
                            name=rs1.getString("firstname")+" "+rs1.getString("lastname");
                        }
                }
                pid = Integer.parseInt(request.getParameter("pid"));
                ps = connection.prepareStatement("delete from userproject where userid=? and pid=?");
		ps.setInt(1,userid);
                ps.setInt(2,pid);
                int flag=ps.executeUpdate();
                if (flag==1)
                    status=name;
        }
        %> <jsp:forward page="viewTeam.jsp">
	<jsp:param name="status" value="<%=status%>" />
</jsp:forward> <%
    }
    catch(Exception e)
    {
        logger.error(e.getMessage());
    }
    finally
    {
        if (rs1!=null)
            rs1.close();
        if (ps!=null)
            ps.close();
        if (ps1!=null)
            ps1.close();
        
        if (connection!=null)
            connection.close();
        } 
 %> <%--
    This example uses JSTL, uncomment the taglib directive above.
    To test, display the page like this: index.jsp?sayHello=true&name=Murphy
    --%> <%--
    <c:if test="${param.sayHello}">
        <!-- Let's welcome the user ${param.name} -->
        Hello ${param.name}!
    </c:if>
    --%>
</body>
</html>
