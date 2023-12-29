<%@page import="com.eminent.issue.dao.EscalationDAOImpl"%>
<%@page import="com.eminent.issue.dao.EscalationDAO"%>
<%@page import="com.eminent.issue.dao.IssueDAOImpl"%>
<%@page import="com.eminentlabs.dao.ModelDAO"%>
<%@page import="com.eminentlabs.mom.ApmWrmPlan"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminentlabs.mom.TeamWiseMom"%>
<%@page import="com.eminentlabs.mom.ApmAdditionalClosed"%>
<%@ page import="org.apache.log4j.*,com.eminent.tqm.TqmUtil,com.eminent.issue.*"%>
<%@ page import="com.pack.MyAuthenticator,com.eminent.util.*, com.eminent.validation.StatusValidation"%>
<%@ page import="javax.mail.*,dashboard.*"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="pack.eminent.encryption.*,com.pack.ChangeFormat,com.eminent.issue.ApmComponentIssues,com.eminent.issue.Issuecomments"%>
<%@ page language="java"%>
<%@ page autoFlush="true" buffer="1094kb"%>
<%
    //Configuring log4j properties
    Logger logger = Logger.getLogger("Modify Issue");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <LINK title=STYLE
          href="<%=request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel=STYLESHEET>
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <META NAME="Generator" CONTENT="EditPlus">
    <META NAME="Author" CONTENT="">
    <META NAME="Keywords" CONTENT="">
    <META NAME="Description" CONTENT="">
    <meta http-equiv="Content-Type" content="text/html ">
<script type="text/javascript">
        function refreshLeft() {
            parent.treeframe.location.reload();
        }
    </script>
</HEAD>


<BODY onload="javascript;refreshLeft();">
    <%@ include file="../header.jsp"%>
    <br>
    <br>
    <jsp:useBean id="iuc" class="com.eminent.issue.controller.IssueUpdateController"/>
    <script LANGUAGE="JavaScript">
        <%
        try {
            iuc.updateIssue(request);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String link = (String) session.getAttribute("forwardpage");
        if (link == null) {
            link = "/MyAssignment/UpdateIssue.jsp";
        }
    %>
   
        
        parent.treeframe.location.reload();

    </script>
    <jsp:forward page="<%=link%>">
        <jsp:param name="flag" value="true"/>
    </jsp:forward>

</BODY>
</HTML>
