<%-- 
    Document   : updateTestPlan
    Created on : 9 Aug, 2011, 10:29:59 AM
    Author     : Tamilvelan
--%>
<%@page  import="org.apache.log4j.*,com.eminent.tqm.TestCasePlan"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
//Configuring log4j properties
	

	Logger logger = Logger.getLogger("Update Test Plan");
	

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
       <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
    </head>
    <body>
       <%
            String planId       =   request.getParameter("planId");
            String pId       =   request.getParameter("pId");
            logger.info("Pid in Update test plan"+pId);
            String planName     =   request.getParameter("planname");
            int qmanager    =   Integer.parseInt(request.getParameter("manager"));
            int status    =   Integer.parseInt(request.getParameter("status"));
            String modules[]  =   request.getParameterValues("modulesFinal");
           if(status==3||status==2){
               TestCasePlan.updateActualEndDate(Integer.parseInt(planId));
           }
           TestCasePlan.updatePlan(Integer.parseInt(planId), planName, qmanager, status, modules);
       %>
        <jsp:forward page="listProjectTestPlan.jsp">
           <jsp:param name="planId" value="<%=planId%>"/>
            <jsp:param name="pid" value="<%=pId%>"/>
       </jsp:forward>
    </body>
</html>

