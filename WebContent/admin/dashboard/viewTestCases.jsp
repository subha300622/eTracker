<%-- 
    Document   : viewTestCases
    Created on : 15 Jun, 2010, 9:25:12 AM
    Author     : ADAL
--%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.eminent.tqm.TqmTestcaseexecutionresult"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page  import="dashboard.*,org.apache.log4j.*,com.eminent.util.*,com.pack.StringUtil,com.eminent.tqm.TqmUtil"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setHeader("Pragma","no-cache");
        response.setDateHeader("Expires", 0);

        //Configuring log4j properties
      
        Logger logger       =   Logger.getLogger("Test Case Chart");
       
        String sessionCheck =   (String)session.getAttribute("Name");
        if(sessionCheck ==  null){
%>
                <jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
        }
        String pid              =   request.getParameter("pid");
        String mid              =   request.getParameter("mid");
        String testCases[][]    =   TestCases.showTestcaseDetails(pid, mid);
        int noOfRecords         =   testCases.length;
        HashMap <String,String> testCaseStatus=IssueDetails.getTestCaseStatus();
%>
<%@ include file="/header.jsp"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS Solution</title>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
    </head>
    <body>
         <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
            <tr  bgColor="#C3D9FF">
                <td  align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Project Test Cases</b></font></td>
            </tr>
        </table>
       <table width="100%">

	<tr height="10">
		<td align="left" width="100%">This list shows <b> <%=noOfRecords %></b> Project Test Cases.</td>
               
	</tr>
</table>
<br>
<table width="100%">

    <tr bgcolor="#C3D9FF" width="100%">
        <td width="9%"><b>TestCaseId</b></td>
        <td width="12%"><b>Project</b></td>
        <td width="9%"><b>Module</b></td>
        <td width="6%"><b>Status</b></td>
        <td width="16%"><b>Functionality</b></td>
        <td width="16%"><b>Description</b></td>
        <td width="16%"><b>Expected Result</b></td>
        <td width="10%"><b>Createdby</b></td>
        
     </tr>
<%
     int k=1;
     String created   =  null;
     String project   =  null;
     String module    =  null;
     String ptcid     =  null;
     String func      =   null;
     String desc      =   null;
     String reslt     =   null;
     HashMap statusMap   =   TestCasePlan.getTescaseStatus();
     logger.info("statusMap"+statusMap);
     String[][] test=TestCasePlan.getExecutionResultBYpidmid(pid, mid);
     logger.info("test.length"+test.length);
     for (int i =0; i<noOfRecords;i++,k++ ) {
            project   =   testCases[i][0];
            module    =   testCases[i][1];
            ptcid     =   testCases[i][2];
            func      =   testCases[i][3];
            desc      =   testCases[i][4];
            reslt     =   testCases[i][5];
            created   =   testCases[i][6];

            String funcTitle=func;
            String descTitle=desc;
            String rsltTitle=reslt;
            if(func.length()>20){
                func=func.substring(0,20)+"...";
                }
            if(desc.length()>20){
                desc=desc.substring(0,20)+"...";
                }
            if(reslt.length()>20){
                reslt=reslt.substring(0,20)+"...";
                }
                 logger.info("Result-->"+reslt);
                logger.info("Project-->"+project);
                logger.info("Created-->"+created);

          if(( k % 2 ) != 0)
                {
%>
	<tr bgcolor="white" height="22">
		<%
                }
                else
                {
%>

	<tr bgcolor="#E8EEF7" height="22">
		<%
                }
%>
<td><a href="<%=request.getContextPath()%>/admin/tqm/viewPTC.jsp?ptcID=<%=ptcid%>">   <%=ptcid%> </a>
    
        
         <%if(!TqmUtil.isPtcExist(ptcid)){%>
         <img alt="Common Test Case"  title="Common Test Case" src="<%=request.getContextPath()%>/images/tick.png">
         <%}%>
</td>
        <td><%=project%></td>
        <td><%=module%></td>
        <% String statuses="";
            String plan="";
         
         int l=0;
         
         for(int j=0;j<test.length;j++){
             if(test[j][1].equalsIgnoreCase(ptcid)){
                 logger.info("ptcid"+ptcid);
                 logger.info("status"+test[j][2].trim()+", "+statusMap.get(test[j][2].trim()));
                 String planName   =  test[j][0];
                 String status       =   (String)statusMap.get(Integer.valueOf(test[j][2].trim()));
                 statuses=statuses+status+",";
                 plan=plan+planName+",";
                 l++;
             }
         }
            
                if(testCaseStatus.get(ptcid)!=null){
                   statuses=statuses+testCaseStatus.get(ptcid)+",";
                }else{
                    statuses=statuses+"Yet to Test"+",";
                }
                

       String pn[]= plan.split(",");
       String st[]= statuses.split(",");
       String wholeStatus="";
       for(int j=0;j<st.length;j++){
           if(plan.length()!=0){
            if(st.length-1!=j){
               wholeStatus=wholeStatus+pn[j]+"# <b>"+st[j]+"</b><br/>";
            }else{
                wholeStatus=wholeStatus+st[j];
            }
           }else{
               wholeStatus=wholeStatus+st[j];
           }
       }
       String idge=i+"tab";
   %>
    <td id="<%=idge%>" onmouseover="xstooltip_show('<%=i%>', '<%=idge%>', 289, 49);" onmouseout="xstooltip_hide('<%=i%>');">
            <%=TestCasePlan.getFinalizedStatus(statuses)%>
            <div class="issuetooltip" id="<%=i%>"><%= wholeStatus%></div>
        </td>
        <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><%=StringUtil.encodeHtmlTag(func)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>
        <td><%=created%></td>
        
    </tr>
               <%
                }
     %>
</table>
    </body>
</html>
