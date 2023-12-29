<%-- 
    Document   : updateTestCase
    Created on : 23 Jan, 2010, 12:19:48 PM
    Author     : TAMILVELAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.eminent.util.SendMail,java.util.HashMap,com.eminent.util.GetProjectManager,java.util.ArrayList,dashboard.CurrentDay,com.eminent.tqm.TqmUtil,com.eminent.tqm.TestCasePlan,com.eminent.tqm.TqmTestcasestatus,org.apache.log4j.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <script type="text/javascript">
        function check()
	{
  		if (confirm("Do you want to upload a File"))
		{
				var attach='yes';
				location = 'fileAttach.jsp?attach='+attach
		}
		else
		{
			var attach='no';
			location='fileAttach.jsp?attach='+attach
		}

	}
        </script>
    </head>
    <body onload="check()">
       <%
             
             int userId          = (Integer)session.getAttribute("userid_curr");
            
            try{
           
            String comments =   request.getParameter("comments");
            int statusid    =   Integer.parseInt(request.getParameter("status"));
            int tceId       =   Integer.parseInt(request.getParameter("tceId"));
            int assign      =   Integer.parseInt(request.getParameter("assignedto"));
            String functionality    =   request.getParameter("functionality");
            String desc             =   request.getParameter("description");
            String expected         =   request.getParameter("expectedresult");
            String plancreatedBy    =   request.getParameter("plancreatedby");
            String testcasecreated  =   request.getParameter("testcasecreatedby");
            String projectName      =   request.getParameter("project");
            String moduleName       =   request.getParameter("module");
            String planName         =   request.getParameter("planname");
            String pId              =   request.getParameter("pid");
            String planmanager      =   request.getParameter("planmanager");

            String issueId  =   request.getParameter("issueid");
            logger.info("Status Name from Page"+statusid);
            TqmTestcasestatus statusName    =   new TqmTestcasestatus();
            session.setAttribute("uploadstatus", statusid);
            session.setAttribute("uploadtceid", tceId);

 //           String status   =   statusName.getStatus();
 //           logger.info("Status Name from Database"+status);
            long startTime  =   System.currentTimeMillis();
            String ptcid=request.getParameter("ptcid");
            String testcasestatus=request.getParameter("status");
            logger.info("Ptcid"+ptcid);
            logger.info("Status"+testcasestatus);
            session.setAttribute("uploadtestcaid", ptcid);
            TestCasePlan.updateActualStartDate(((Integer)tceId).toString());
            if(issueId!=null){
                TestCasePlan.updateTestCase(ptcid,statusid,tceId,assign,issueId);
            }
            else{
                TestCasePlan.updateTestCase(ptcid,statusid,tceId,assign);
            }
                TestCasePlan.updateTestCaseResult(comments,ptcid,statusid,userId,tceId,assign);
                long endTime    =   System.currentTimeMillis();
                logger.info("Total time taken for update a test case"+(endTime-startTime)/1000);
                             HashMap hm =new HashMap<Integer,String>();
                        hm.put(new Integer(0), "Yet to Test");
                        hm.put(new Integer(1), "Not Applicable");
                        hm.put(new Integer(2), "Could Not Run");
                        hm.put(new Integer(3), "Failed");
                        hm.put(new Integer(4), "Passed");
                        
                 ArrayList<String> dateAndTime = CurrentDay.getDateTime();
                String mailContent  =  "<b><font color=blue >Test Case Details</font></b><table width=100% > <font face=Verdana, Arial, Helvetica, sans-serif size=2 >" +
                             
                             "<tr bgcolor='#E8EEF7'>"+
                                "<td width='15%'><b>Test Plan Name</b></td><td>"+planName+"</td>   <td><b>Plan Created By</b></td><td>"+plancreatedBy+"</td>"+
                            "</tr>"+
                             "<tr >"+
                                "<td width='15%'><b>Project</b></td><td>"+projectName+"</td>   <td><b>Module</b></td><td>"+moduleName+"</td>"+
                            "</tr>"+
                            "<tr bgcolor='#E8EEF7'>"+
                                "<td width='15%'><b>Test Case ID</b></td><td>"+ptcid+"</td>   <td><b>Created By</b></td><td>"+testcasecreated+"</td>"+
                            "</tr>"+
                            "<tr>"+
			    "<td width='15%'><b>Status</b></td><td>"+hm.get(statusid)+"</td>   <td><b>Assigned To</b></td><td>"+GetProjectManager.getUserName(assign)+"</td>"+
			    "</tr>"+
		  	    "<tr  bgcolor='#E8EEF7'>"+
		            "<td width='15%'><b>Updated By</b></td><td>"+GetProjectManager.getUserName(userId)+"</td>   <td><b>Updated On</b></td><td>"+dateAndTime.get(0)+"</td>"+
			    "<tr>"+
                            "<tr >"+
                                "<td><b>Functionality</b></td><td colspan='3'>"+functionality+"</td>"+
                            "</tr>"+
                            "<tr bgcolor='#E8EEF7'>"+
                                "<td><b>Description</b></td><td colspan='3'>"+desc+"</td>"+
                            "</tr>"+
                            "<tr >"+
                                "<td><b>Expected Result</b></td><td colspan='3'>"+expected+"</td>"+
                            "</tr>"+
                            "<tr bgcolor='#E8EEF7'>"+
                            "<td><b>Comments</b></td><td colspan='3'>"+comments+"</td>"+
                            "</tr>"+
                            "</table>";


                String endLine="<br>Thanks,";
                String signature="<br>eTracker&trade;<br>";
                String emi      =   "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                String lineBreak =  "<br>";

                String htmlTableEnd="<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                mailContent =   mailContent+endLine+signature+emi+lineBreak+htmlTableEnd;
                String subject="eTracker "+hm.get(statusid)+" Testcase :  " +functionality;
                SendMail.testCaseUpdateMail(mailContent,assign,userId,pId,planmanager, subject);

            }
            catch(Exception e){
                logger.error(e.getMessage());
            }
      
%>


    </body>
</html>
