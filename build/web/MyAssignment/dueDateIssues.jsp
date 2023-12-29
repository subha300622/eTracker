<%-- 
    Document   : dueDateIssues
    Created on : Sep 07, 2017, 11:50:34 AM
    Author     : Muthu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Integer headeruserId = (Integer) session.getAttribute("userid_curr");
            String query= "select distinct i.issueid, pname as project, i.subject, i.description, i.priority, i.severity, i.type, i.createdon, i.due_date, i.modifiedon,i.createdby,i.assignedto,s.status,module,i.rating,i.feedback from issue i,issuestatus s,project p,users u,modules m  where  i.pid=p.pid and i.module_id=m.moduleid and p.STATUS='Work in progress' And pmanager = "+headeruserId+" and i.issueid=s.issueid  and u.userid=p.pmanager and (select i.DUE_DATE - trunc(sysdate)  from dual) <=5 and s.status!='Closed' order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            session.setAttribute("IssueSummaryQuery",query);%>
            <jsp:forward page="/IssueSummary/IssueSummaryView.jsp"></jsp:forward>
    </body>
</html>
