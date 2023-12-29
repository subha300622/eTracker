<%-- 
    Document   : createExecutionPlan
    Created on : 20 Mar, 2010, 4:31:38 PM
    Author     : TAMILVELAN
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.eminent.tqm.*,org.apache.log4j.*"%>
<%
//Configuring log4j properties
	

	Logger logger = Logger.getLogger("Create Execution Plan");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		//response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
	}

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <LINK title=STYLE  href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    </head>
    <body>
       <%
            logger.info("Project"+request.getParameter("project"));
            String planname  =   request.getParameter("planname");
            int pid         =   Integer.parseInt(request.getParameter("project"));
            String buildno  =   request.getParameter("buildno");
            logger.info("Manager"+request.getParameter("manager"));
            int qmanager    =   Integer.parseInt(request.getParameter("manager"));

            String startdate=   request.getParameter("startdate");
            String enddate  =   request.getParameter("enddate");
            logger.info("Start Date-->"+startdate);
            logger.info("End Date-->"+enddate);
            int userId      =   (Integer)session.getAttribute("uid");

            String modules[]  =   request.getParameterValues("modulesFinal");
              
            for(String s:modules){
                   logger.info("Module id-->"+s);
                }

            TestCasePlan.createplan(planname,pid,buildno,qmanager,startdate,enddate,userId,modules);

       %>
       <jsp:forward page="/UserProject/listProjectTestPlan.jsp">
           <jsp:param name="pid" value="<%=pid%>"/>
       </jsp:forward>
    </body>
</html>
