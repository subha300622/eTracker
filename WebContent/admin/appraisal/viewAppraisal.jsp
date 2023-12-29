<%-- 
    Document   : viewAppraisal
    Created on : Dec 19, 2011, 10:30:51 AM
    Author     : Tamilvelan
--%>
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.sql.*,com.eminent.tqm.TestCasePlan"%>
<%@ page import="java.util.HashMap,java.util.List,com.eminent.leaveUtil.*,com.eminent.timesheet.*"%>
<%@ page import="pack.eminent.encryption.*, com.eminent.util.*, dashboard.*, com.pack.*,java.util.Iterator"%>
<%@ page import="com.eminentlabs.appraisal.AppraisalUtil,com.eminentlabs.appraisal.ErmAppraisal"%>
<%@ include file = "/include files/cacheRemover.jsp" %>
<%


    session.setAttribute("forwardpage","/admin/appraisal/viewAppraisal.jsp");



	//Configuring log4j properties

	

	Logger logger = Logger.getLogger("view Appraisal");
	
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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">

        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
    </head>
    <%@ include file="/header.jsp"%>
    <body>
       <table cellpadding="0" cellspacing="0" width="100%">
	<tr  bgcolor="#E8EEF7">
		<td align="left"><b> Appraisal Request </b></td>

	</tr>

        </table>
        <%
                String[] monthName = {"Jan", "Feb","Mar", "Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct", "Nov","Dec"};
                int userId      =   (Integer)session.getAttribute("uid");
                List appRequest =   AppraisalUtil.viewMyAppraisalrequest(userId);
                int noOfRequest =   appRequest.size();
        %>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr style="height: 30px;">
                    <td align="left">This list shows <%=noOfRequest%> Appraisal Request created by you. </td>
            </tr>

        </table>
        <table width="100%">
            <tr bgcolor="#C3D9FF">
                <td>Requestor</td>
                <td>Period</td>
                <td>First Appraiser</td>
                <td>Initiated By</td>
                <td>Status</td>
            </tr>

            <%
                int i=0;

                ErmAppraisal    appraisalrequest    =   null;
                String period                       =   null,color="white",start=null,end=null,startMonth="",endMonth="",startYear="",endYear="";
                for (Iterator reqIterator = appRequest.iterator(); reqIterator.hasNext();i++ ) {
                    if(( i % 2 ) != 0)
                                    {
                                         color  ="#E8EEF7";
                                    }
                                    else
                                    {
                                         color  ="white";
                                    }
                    appraisalrequest =(ErmAppraisal)reqIterator.next();
                    period  =   appraisalrequest.getPeriod();
                    if(period!=null){
                        start   =   period.substring(0, period.indexOf('*'));
                        end     =   period.substring(period.indexOf('*')+1,period.length() );
                        startMonth  =   start.substring(0, start.indexOf('-'));
                        endMonth  =   end.substring(0, end.indexOf('-'));

                        startYear  =   start.substring(start.indexOf('-')+1, start.length());
                        endYear  =   end.substring(end.indexOf('-')+1, end.length());
                        logger.info("Start Month"+startMonth);
                        logger.info("End Month"+endMonth);
                    }else{

                    }

            %>
            <tr bgcolor="<%=color%>">
                    <td><a href="printView.jsp?appId=<%=appraisalrequest.getAppraisalId()%>"><%=GetProjectManager.getUserName(appraisalrequest.getAppraisalUser())%></a></td>
                    <td>From <%=monthName[Integer.parseInt(startMonth)]%> <%=startYear%> To <%=monthName[Integer.parseInt(endMonth)]%> <%=endYear%></td>
                    <td><%=GetProjectManager.getUserName(appraisalrequest.getFirstAppraiser())%></td>

                    <td><%=GetProjectManager.getUserName(appraisalrequest.getInitiatedBy())%></td>
                    <td><%=appraisalrequest.getErmAppraisalStatus().getStatus()%></td>
                </tr>
            <%
                }
            %>

        </table>

    </body>
</html>
