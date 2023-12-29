<%-- 
    Document   : updateTestCase
    Created on : 23 Jan, 2010, 12:19:48 PM
    Author     : TAMILVELAN
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="dashboard.CheckDate"%>
<%@page import="dashboard.CurrentDay"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.util.SendMail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmTestcasestatus,org.apache.log4j.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%

			//Configuring log4j properties

			Logger logger = Logger.getLogger("Update Test Case");
			

			String logoutcheck=(String)session.getAttribute("Name");
			if(logoutcheck==null)
			{
				logger.fatal("================Session expired===================");
				%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
			}

	%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
               <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    </head>
    <body>
       <%
             HashMap hmtstatus =new HashMap<Integer,String>();
             hmtstatus.put(new Integer(0), "Yet to Test");
             hmtstatus.put(new Integer(1), "Not Applicable");
             hmtstatus.put(new Integer(2), "Not Run");
             hmtstatus.put(new Integer(3), "Failed");
             hmtstatus.put(new Integer(4), "Passed");
             String issueId      = request.getParameter("issueid");
             String fname = (String) session.getAttribute("fName");
             String lname = (String) session.getAttribute("lName");
             String Name = fname + " " + lname;
             int userId          = (Integer)session.getAttribute("userid_curr");
             String ptcid=request.getParameter("ptcid");
             String testcasestatus=request.getParameter("status");
             int statusid    =   Integer.parseInt(request.getParameter("status"));
             String comments =   request.getParameter("comments");
             logger.info("Issue Id"+issueId);
            try{
           
            
            
            logger.info("Status Name from Page"+statusid);
            TqmTestcasestatus statusName    =   new TqmTestcasestatus();
  //          statusName.setStatusid(statusid);
 //           String status   =   statusName.getStatus();
 //           logger.info("Status Name from Database"+status);
            
            
            
            logger.info("Ptcid"+ptcid);
            logger.info("Status"+testcasestatus);
            TqmUtil.updateTestCase(ptcid,statusid);
            TqmUtil.updateTestCaseResult(comments,issueId,ptcid,statusid,userId);
            }
            catch(Exception e){
                logger.error(e.getMessage());
            }
            String Subject="";
            
            HashMap hm= IssueDetails.getIssue(issueId);
            logger.info(hm);
            String product=(String) hm.get("projectname");
            String version=(String) hm.get("foundversion");
            String customer=(String) hm.get("customer");
            String type=(String) hm.get("type");
            String createdby=(String) hm.get("createdby");
            String createdon=(String) hm.get("createdon");
            String priority=(String) hm.get("priority");
            String severity=(String) hm.get("severity");
            String modulename=(String) hm.get("modulename");
            String platform=(String) hm.get("platform");
            String assignedto=(String) hm.get("assignedto");
            String fixversion=(String) hm.get("fixversion");
            String duedate = (String) hm.get("duedate");
            String subject = (String) hm.get("subject");
            String tstatus =(String)hmtstatus.get(statusid);
            Subject = "eTracker "+tstatus+" Testcase :"+subject;
            logger.info("Subject"+Subject);
            String issuedescription = (String) hm.get("description");
            String issueexpectedresult = (String) hm.get("expectedresult");
            String rootcause = (String) hm.get("rootcause");
            HashMap cr = IssueDetails.getCRID(issueId);
            String crHtml = "";
                    if (cr.size() > 0) {
                        Collection setCR = cr.keySet();
                        Iterator iterCR = setCR.iterator();
                        while (iterCR.hasNext()) {

                            String key = (String) iterCR.next();
                            String desc = (String) cr.get(key);
                            logger.info("ID-->" + key);
                            logger.info("Desc-->" + desc);


                            crHtml = "<tr height='21'><td width='13%'><B><font face=Verdana, Arial, Helvetica, sans-serif size=2 >CR ID </B></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + key + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >CR ID Desc.</b></td><td colspan=2><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + desc + "</td></tr>";

                        }
                    }
            ArrayList<String> dateAndTime = CurrentDay.getDateTime();
            String font = "#000000";
            DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
            java.util.Date da = df.parse(duedate);
            String viewDueDate = sdf.format(da);
            if ((!duedate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(viewDueDate) == true)) {
                        font = "RED";
            }
            ArrayList<String> al = dashboard.Project.getDetails(product + ":" + version);
            String createdBy=request.getParameter("createdBy");
            String functionality=request.getParameter("functionality");
            String description=request.getParameter("description");
            String expectedResult=request.getParameter("expectedResult");
            
            String htmlContent = "<b><font color=blue >Project Details</font></b><table width=100% > <font face=Verdana, Arial, Helvetica, sans-serif size=2 >"
                            + "<tr bgcolor=#E8EEF7 ><td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Project</b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + product + "</font></td>"
                            + "<td width = 18% ><b> <font face=Verdana, Arial, Helvetica, sans-serif size=2 >Customer </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + customer + "</td>"
                            + "</tr>"
                            + "<tr><td width   = 18% ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 > Version </b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + version + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Manager</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(al.get(0)) + "</td> "
                            + "</tr>"
                            + "<tr  bgcolor=#E8EEF7><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b> Status </b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(4) + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Phase</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(1) + "</td> "
                            + "</tr>"
                            + "<tr><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Start Date</b> </td>"
                            + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(2) + "</td>"
                            + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>End Date</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(3) + "</td>"
                            + "</tr></table><br><font color=blue><b>Updated Issue details</b></font><table width=100% >"
                            + "<tr bgcolor=#E8EEF7><td width = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Issue ID</b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + issueId + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Type </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + type + "</td>"
                            + "</tr>" + "<tr  >"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Created By</b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(createdby) + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Created On</b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + createdon + "</td>"
                            + "</tr>"
                            + "<tr bgcolor=#E8EEF7><td width   = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Priority </b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + priority + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Severity</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + severity + "</td> "
                            + "</tr>"
                            + "<tr ><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Module</b> </td>"
                            + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + modulename + "</td>"
                            + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Platform</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + platform + "</td>"
                            + "</tr>"
                            + "<tr bgcolor=#E8EEF7><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Assigned To</b> </td>"
                            + "<td width  = 32%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(assignedto) + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Fix Version </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + fixversion + "</td>"
                            + "</tr>"
                            + "<tr ><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Updated By</b> </td>"
                            + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Name + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Updated On </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + dateAndTime.get(0) + " " + dateAndTime.get(1) + "</td>"
                            + "</tr>"
                            + "<tr bgcolor=#E8EEF7>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Issue Status </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + "QA-TCE" + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Due Date</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=" + font + ">" + viewDueDate + "</font></td>"
                            + "</tr>" + crHtml
                            + "<tr><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Subject</b> </td>"
                            + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + subject + "</td>"
                            + "</tr>"
                            + "<tr bgcolor=#E8EEF7><td width  = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Description</b> </td>"
                            + "<td width  = 82%  colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + issuedescription + "</td>"
                            + "</tr>"
                            + "<tr ><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Root Cause</b> </td>"
                            + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + rootcause + "</td>"
                            + "</tr>"
                            + "<tr ><td width  = 18% bgcolor=#E8EEF7><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Expected Result</b> </td>"
                            + "<td width  = 82% colspan=3  bgcolor=#E8EEF7><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + issueexpectedresult + "</td>"
                            + "</tr></table><br/><b><font color=blue >Testcase Details</font></b>"
                            +"<table width=\"100%\">"
                            +"<tr bgcolor=\"#E8EEF7\">"
                            +"<tr bgcolor=\"#E8EEF7\"><td width=\"15%\"><b>Test Case ID</b></td><td>"+ptcid+"</td>   <td><b>Created By</b></td><td>"+createdBy+"</td><td><b>Status</b></td><td>"+tstatus+"</td></tr>"
                            +"<tr >"
                             +"<td><b>Functionality</b></td><td colspan=\"5\">"+functionality+"</td></tr>"
                            +"<tr bgcolor=\"#E8EEF7\"><td><b>Description</b></td><td colspan=\"5\">"+description+"</td></tr>"
                            +"<tr><td><b>Expected Result</b></td><td colspan=\"5\">"+expectedResult+"</td></tr>"
                            +"<tr bgcolor=\"#E8EEF7\"><td><b>Comments</b></td><td colspan=\"5\">"+comments+"</td></tr>";
                String endLine = "</table><br>Thanks,";
                String signature = "<br>eTracker&trade;<br>";
                String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                String lineBreak = "<br>";
                String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;
                SendMail.tceMailUpdate(issueId, Subject, htmlContent, Name, String.valueOf(userId));
    %>
<jsp:forward page="UpdateIssueview.jsp">
    <jsp:param name="issueid" value="<%=issueId%>"/>
</jsp:forward>
    </body>
</html>
