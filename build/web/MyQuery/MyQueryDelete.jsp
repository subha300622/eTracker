<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
	
	Logger logger = Logger.getLogger("MyQueryDelete");
	
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
    <script language="JavaScript">
	function check(theForm)
	{
 
        if(top.treeframe!==undefined){
                top.treeframe.location.reload();
                }
        var x=document.getElementById("status").value;
        theForm.action='MyQueryView.jsp?status='+x;
        theForm.submit();
    }
    </script>
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>

<META content=0 http-equiv=Expires>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
</head>

<body onload="check(theForm)">
<form name="theForm" METHOD="POST" ACTION="MyQuerySave.jsp"><%@ page
	import="java.sql.*"%> <%@ page
	import="java.util.*"%> <%@ page language="java"%>
<%@ include file="../header.jsp"%> <br>
<%! 
        int query_id=0;
        PreparedStatement ps;
        PreparedStatement ps1;
        ResultSet rs1=null;
        int rowcount;
%> <% 
    int id=0;
 
  //  Logger logger = Logger.getLogger("MyQueryDelete");
   
    Connection connection=null;
    ResultSet rs=null,rsName=null;
    int flag=0;
    String status=null;
    String name="";
    try
    {
	connection=MakeConnection.getConnection();
        if (connection!=null)
	{
		query_id = Integer.parseInt(request.getParameter("query_id"));
                logger.info("here"+query_id);
                ps1 = connection.prepareStatement("select name from myquery where query_id=?");
      		ps1.setInt(1,query_id);
                rs1=ps1.executeQuery();
                if (rs1!=null)
                {
                        while (rs1.next())
                        {
                            name=rs1.getString("name");
                        }
                }
                ps = connection.prepareStatement("delete from myquery where query_id=?");
		ps.setInt(1,query_id);
                flag=ps.executeUpdate();
                if (flag==1)
                    status=name;
        }
        %>
        <table>
            <tr><td><input type="hidden" name="status" id="status" value="<%=status%>"></td></tr>
        </table>
        </form>
</body>
</html>
           
<%
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
 %>


