<%-- 
    Document   : printView
    Created on : Dec 21, 2011, 10:40:58 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.appraisal.ErmAppraisalComment"%>
<%@page import="com.eminentlabs.dao.ModelDAO"%>
<%@page import="com.eminentlabs.appraisal.ErmAppraisal,com.eminentlabs.dao.ModelDAO"%>
<%@ page import="org.apache.log4j.*,java.text.SimpleDateFormat"%>
<%@ page import="java.util.Iterator,java.util.List,java.util.Map,java.util.Collection,java.util.HashMap,com.eminent.util.GetProjectManager"%>
<%@ page import="com.eminentlabs.appraisal.AppraisalUtil"%>
<%@ include file = "/include files/cacheRemover.jsp" %>
<%
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
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/tooltip.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/addSummary.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
        <style type="text/css">

        </style>
         <script type="text/javascript">
            
                    $(document).ready(function()
			{
                                          $("#showUserAccomplishment").click(function ()
					  {
                                               var appId   =   document.getElementById('appId').value;
                                                location.href='<%=request.getContextPath() %>/admin/appraisal/addAccomplishment.jsp?appId='+appId+'&viewEdit=edit'
                                          });
					  $("#showAccomplishment").click(function ()
					  {
                                             if($("#showAccomplishment").hasClass('expand')){
                                                    $("#showAccomplishment").removeClass('expand');
                                                    $("#accDiv").html("");
                                                    $("#showAccomplishment").html('>')
                                             }else{
                                                  var appId   =   document.getElementById('appId').value;
                                                $.ajax({
                                                      url: '<%= request.getContextPath() %>/admin/appraisal/viewAccomplishment.jsp?appId='+appId,

                                                      success: function( data ) {
                                                              $("#accDiv").html(data);

                                                      }
                                                    });
                                                    $("#showAccomplishment").addClass('expand');
                                                    $("#showAccomplishment").html('v')
                                                }
					  });
                                          $("#showActivities").click(function ()
					  {
                                              if($("#showActivities").hasClass('expand')){
                                                    $("#showActivities").removeClass('expand');
                                                    $("#goingDiv").html("");
                                                    $("#showActivities").html('>')
                                             }else{
                                              var appId   =   document.getElementById('appId').value;
                                                $.ajax({
                                                      url: '<%= request.getContextPath() %>/admin/appraisal/viewActivities.jsp?appId='+appId,

                                                      success: function( data ) {
                                                              $("#goingDiv").html(data);

                                                      }
                                                    });
                                               $("#showActivities").addClass('expand');
                                                    $("#showActivities").html('v')
                                                }
					  });

                                          $("#showPlan").click(function ()
					  {
                                              if($("#showPlan").hasClass('expand')){
                                                    $("#showPlan").removeClass('expand');
                                                    $("#planDiv").html("");
                                                    $("#showPlan").html('>')
                                             }else{
                                                var appId   =   document.getElementById('appId').value;
                                                $.ajax({
					    	  url: '<%= request.getContextPath() %>/admin/appraisal/viewPlan.jsp?appId='+appId,

					    	  success: function( data ) {
					    		  $("#planDiv").html(data);

					    	  }
					    	});
                                                    $("#showPlan").addClass('expand');
                                                    $("#showPlan").html('v')
                                           }
					  });

                                          $("#showTimeAcc").click(function ()
					  {
                                            if($("#showTimeAcc").hasClass('expand')){
                                                    $("#showTimeAcc").removeClass('expand');
                                                    $("#timesheetAcc").html("");
                                                    $("#showTimeAcc").html('>')
                                             }else{
                                            var appUser   =   document.getElementById('appUser').value;
					    $.ajax({
					    	  url: '<%= request.getContextPath() %>/admin/appraisal/viewTimesheetAccomplishment.jsp?appUser='+appUser,

					    	  success: function( data ) {
					    		  $("#timesheetAcc").html(data);

					    	  }
					    	});
                                                $("#showTimeAcc").addClass('expand');
                                                $("#showTimeAcc").html('v')
                                            }
					  });

                                          $("#showTimePlan").click(function ()
					  {
                                              if($("#showTimePlan").hasClass('expand')){
                                                    $("#showTimePlan").removeClass('expand');
                                                    $("#timesheetPlan").html("");
                                                    $("#showTimePlan").html('>')
                                             }else{
                                              var appUser   =   document.getElementById('appUser').value;
					    $.ajax({
					    	  url: '<%= request.getContextPath() %>/admin/appraisal/viewCreatedIssues.jsp?appUser='+appUser,

					    	  success: function( data ) {
					    		  $("#timesheetPlan").html(data);

					    	  }
					    	});
                                                $("#showTimePlan").addClass('expand');
                                                $("#showTimePlan").html('v')
                                                }
					  });

                                          $("#showTimeLearning").click(function ()
					  {
                                              if($("#showTimeLearning").hasClass('expand')){
                                                    $("#showTimeLearning").removeClass('expand');
                                                    $("#timesheetLearnings").html("");
                                                    $("#showTimeLearning").html('>')
                                             }else{
                                              var appUser   =   document.getElementById('appUser').value;
					    $.ajax({
					    	  url: '<%= request.getContextPath() %>/admin/appraisal/viewClosedIssues.jsp?appUser='+appUser,

					    	  success: function( data ) {
					    		  $("#timesheetLearnings").html(data);

					    	  }
					    	});
                                                $("#showTimeLearning").addClass('expand');
                                                $("#showTimeLearning").html('v')
                                                }
					  });
                                          $("#showWorked").click(function ()
					  {
                                              if($("#showWorked").hasClass('expand')){
                                                    $("#showWorked").removeClass('expand');
                                                    $("#workedIssues").html("");
                                                    $("#showWorked").html('>')
                                             }else{
                                              var appUser   =   document.getElementById('appUser').value;
					    $.ajax({
					    	  url: '<%= request.getContextPath() %>/admin/appraisal/viewWorkedIssues.jsp?appUser='+appUser,

					    	  success: function( data ) {
					    		  $("#workedIssues").html(data);

					    	  }
					    	});
                                                $("#showWorked").addClass('expand');
                                                $("#showWorked").html('v')
                                                }
					  });
			});
             
             


        </script>

    </head>

    <body>
        <%
            String appId    =   request.getParameter("appId");
            int userId      =   (Integer)session.getAttribute("uid");
%>
            <%@ include file="/header.jsp"%>
       <table cellpadding="0" cellspacing="0" width="100%">
	<tr  bgcolor="#C3D9FF">
		<td align="left"><b> View Appraisal Request </b></td>
                <td align="right"><b><a href="<%= request.getContextPath() %>/admin/appraisal/printAppraisal.jsp?appId=<%=appId%>" target="_blank">Print this appraisal</a></b>
                    <input type="hidden" id="appId" name="appId" value="<%=appId%>">
                   
                </td>
	</tr>

        </table>
        <%
                String[] monthName = {"Jan", "Feb","Mar", "Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct", "Nov","Dec"};
                
                
                int appraisalId =   0;
                if(appId!=null){
                    appraisalId =   Integer.parseInt(appId);
                }
                ErmAppraisal app    =   (ErmAppraisal)ModelDAO.load(ErmAppraisal.class, appraisalId);
                HashMap initiater           =   AppraisalUtil.getIntiater();
                Map users           =   initiater;
                Object[] userArray  =   users.entrySet().toArray();
                int noOfUser    =   userArray.length;

                String period   = app.getPeriod();
                session.setAttribute("period", period);
                String start   =   period.substring(0, period.indexOf('*'));
                String end     =   period.substring(period.indexOf('*')+1,period.length() );
                String startMonth  =   start.substring(0, start.indexOf('-'));
                String endMonth  =   end.substring(0, end.indexOf('-'));

                String startYear  =   start.substring(start.indexOf('-')+1, start.length());
                String endYear  =   end.substring(end.indexOf('-')+1, end.length());

                period  =   monthName[Integer.parseInt(startMonth)]+" "+startYear+"  To "+monthName[Integer.parseInt(endMonth)]+" "+endYear;
                SimpleDateFormat sdf    = new SimpleDateFormat("dd MMM yy");
                String created      =   sdf.format(app.getCreatedon());
                String updated      =   sdf.format(app.getUpdatedon());

                int statusId        =   app.getErmAppraisalStatus().getStatusId();
                String currentStatus=   app.getErmAppraisalStatus().getStatus();

                HashMap status      =   AppraisalUtil.getStatus(statusId);
                status.put(statusId,currentStatus );
                int appraisalUser   =   app.getAppraisalUser();
                int firstAppraiser  =   app.getFirstAppraiser();
                int secondAppraiser  =   app.getSecondAppraiser();
                int thirdAppraiser  =   app.getThirdAppraiser();
                String attendance       =   app.getAttendanceComments();
                String createdIss       =   app.getCreatedIssuesComment();
                String workedIss        =   app.getWorkedIssuesComment();
                String closedIss        =   app.getClosedIssuesComment();
                String approvalPer      =   app.getApprovalPercentage();
                String newLearning      =   app.getNewLearningsComment();

        %>

        <form name="theForm" action="updateAppraisal.jsp">
        <table width="100%" bgcolor="#E8EEF7" id="appTable">

                <tr>
                    <td><b>Name</b></td>
                    <td><%=GetProjectManager.getUserName(appraisalUser)%></td>
                    <td><b>Designation</b></td>
                    <td><%=GetProjectManager.getUserDesignation(appraisalUser)%> <input type="hidden" id="appUser" name="appUser" value="<%=appraisalUser%>"/></td>
                    <td><b>Emp Id</b></td>
                    <td><%=app.getEmpId()%></td>
                </tr>
                <tr>

                    <td><b>Period</b></td>
                    <td><%=period %></td>
                    <td><b>Status</b></td>
                    <td>
                        <%=AppraisalUtil.getAppraisalStatus(statusId)%>
                    </td>
                    <td><b>Initiated By</b></td>
                    <td><%=GetProjectManager.getUserName(app.getInitiatedBy())%></td>

                </tr>



                <tr>
                    <td><b>First Appraiser</b></td>
                    <td><%=GetProjectManager.getUserName(firstAppraiser)%></td>
                    <td><b>Second Appraiser</b></td>
                    <td><%=GetProjectManager.getUserName(secondAppraiser)%> </td>
                    <td><b>Third Appraiser</b></td>
                    <td><%=GetProjectManager.getUserName(thirdAppraiser)%>
                     
                    </td>
                </tr>
                 <tr>
                    <td><b>Assigned To</b></td>
                    <td><%=GetProjectManager.getUserName(app.getAssignedto())%></td>
                    <td><b>Created On</b></td>
                    <td><%= created%></td>
                    <td><b>Updated On</b></td>
                    <td><%=updated%></td>

                </tr>
                <%
            int accomplishmentCount     =   AppraisalUtil.getAccomplishmentCount(appraisalId);
            int activityCount           =   AppraisalUtil.getActivityCount(appraisalId);
            int planCount               =   AppraisalUtil.getPlanCount(appraisalId);
            if(accomplishmentCount>0){
%>
             <tr bgcolor="#C3D9FF">
                 <td colspan="6" style="font-weight: bold;"> View Accomplishments  &nbsp; &nbsp;<span id="showAccomplishment" style="cursor:pointer;font-weight: bold;"> <b>></b></span></td>
             </tr>
             <tr>
                 <td  id="accDiv" colspan="6"></td>
             </tr>

<%
            }
             if(activityCount>0){
%>
              <tr bgcolor="#C3D9FF">
                  <td colspan="6" style="font-weight: bold;"> View On Going Activities &nbsp; &nbsp;<span id="showActivities" style="cursor:pointer;font-weight: bold;"> <b>></b></span></td>
             </tr>
             <tr>
                 <td id="goingDiv" colspan="6"></td>
             </tr>
<%
            }
             if(planCount>0){
%>
             <tr bgcolor="#C3D9FF">
                 <td colspan="6" style="font-weight: bold;">View Next Cycle Plan &nbsp; &nbsp;<span style="cursor:pointer;" id="showPlan">></span></td>
             </tr>

               <tr>
                 <td id="planDiv" colspan="6"></td>
             </tr>
<%
            }
%>
             <tr bgcolor="#C3D9FF">
                 <td colspan="6" style="font-weight: bold;">Timesheet Details &nbsp; &nbsp;<span style="cursor:pointer;" id="showTimeAcc">></span></td>
             </tr>

               <tr>
             <td id="timesheetAcc" colspan="6"></td>
             </tr>
             <tr bgcolor="#C3D9FF">
                 <td colspan="6" style="font-weight: bold;">Created Issues &nbsp; &nbsp;<span style="cursor:pointer;" id="showTimePlan">></span></td>
             </tr>

             <tr>
                 <td id="timesheetPlan" colspan="6"></td>
             </tr>
              <tr bgcolor="#C3D9FF">
                 <td colspan="6" style="font-weight: bold;">Closed Issues &nbsp; &nbsp;<span style="cursor:pointer;" id="showTimeLearning">></span></td>
             </tr>

             <tr>
                 <td id="timesheetLearnings" colspan="6" ></td>
             </tr>
             <tr bgcolor="#C3D9FF">
                 <td colspan="6" style="font-weight: bold;">Worked Issues &nbsp; &nbsp;<span style="cursor:pointer;" id="showWorked">></span></td>
             </tr>

             <tr>
                 <td id="workedIssues" colspan="6" ></td>
             </tr>
               


<%
                
                if(attendance!=null){
%>
                <tr bgcolor="#C3D9FF" style="height:8px;">
                    <td colspan="6"><b>Appraisal Review Comments</b></td>
                </tr>

                <tr>
                    <td><b>Attendance</b></td>
                    <td colspan="5"><%=attendance%></td>
                </tr>
                <tr>
                    <td><b>Created Issues</b></td>
                    <td colspan="5"><%=createdIss%></td>
                </tr>
                <tr>
                    <td><b>Worked Issues</b></td>
                    <td colspan="5"><%=workedIss%></td>
                </tr>
                <tr>
                    <td><b>Closed Issues</b></td>
                    <td colspan="5"><%=closedIss%></td>
                </tr>
                <tr>
                    <td><b>Approval Percentage</b></td>
                    <td colspan="5"><%=approvalPer%></td>
                </tr>
                <tr>
                    <td><b>New Learnings</b></td>
                    <td colspan="5"><%=newLearning%></td>
                </tr>


<%
                }
                
%>





        </table>
        </form>

<table width="100%">
	<tr>
		<th align="center">CommentedBy</th>
		<th align="center">TimeStamp</th>
		<th align="center">Comments History</th>
		<th align="center">Status</th>
		<th align="center">CommentedTo</th>

	</tr>
<%
                    try
                    {
                                int k=1;

                                List comments    =   AppraisalUtil.viewAppraisalComments(appraisalId);
                                String color="white";
                                 ErmAppraisalComment    appraisalComment    =   null;
                                 int commentStatusId   =   0;
                                if(comments.size()>0){
                                for (Iterator commentIterator = comments.iterator(); commentIterator.hasNext();k++ ) {
                                    appraisalComment =(ErmAppraisalComment)commentIterator.next();
                                     if(( k % 2 ) != 0)
                                    {
                                         color  ="white";
                                    }
                                    else
                                    {
                                         color  ="#E8EEF7";
                                    }
                                    java.util.Date commentedOn    =   appraisalComment.getCommentedOn();
                                    String commentedTime="NA";
                                    if(commentedOn!=null){
                                        commentedTime=new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(commentedOn);
                                    }
                                    commentStatusId =   appraisalComment.getStatus();

                            %>

                            <tr bgcolor="<%=color%>">
                                <td><%=GetProjectManager.getUserName(appraisalComment.getCommentedBy())%></td>
                                <td><%=commentedTime%></td>
                                <td><%=appraisalComment.getComments()%></td>
                                <td><%=AppraisalUtil.getAppraisalStatus(commentStatusId)%></td>
                                <td><%=GetProjectManager.getUserName(appraisalComment.getCommentedTo())%></td>

                            </tr>
                            <%
                            commentStatusId=0;
                                }
                            %>


</table>
<%

		}
		else
		{
			%>
<%= "Nothing to display"%>
<%
		}
	}
	catch(Exception e)
	{
		logger.error(e);
	}


%>
    </body>
</html>



