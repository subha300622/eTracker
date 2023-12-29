<%--
    Document   : editAppraisal
    Created on : Dec 19, 2011, 12:46:53 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.dao.ModelDAO"%>
<%@page import="com.eminentlabs.appraisal.ErmAppraisal,com.eminentlabs.dao.ModelDAO"%>
<%@ page import="org.apache.log4j.Logger,java.text.SimpleDateFormat"%>
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
        String appId    =   request.getParameter("appId");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <script type="text/javascript">
            function addAccomplishment(){
               
            }
        </script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/tooltip.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/addSummary.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript">
            function addAppraisal(){
                var status  =   document.getElementById('status').value;
                // when user chagnes the status from review to Approved, User should be able to enter the App percentage
                if(status=='7'){
                    var tableName   =   document.getElementById("appTable");
                    var usrApp      =   document.getElementById("usrApp").value;

                    if((document.getElementById("appraisalRow")==null)){

                    if(usrApp=='NA'){
                            var row=tableName.insertRow(5);
                            row.setAttribute("id", "appraisalRow");
                            var title = document.createTextNode("System Appraisal %");
                            var bold = document.createElement("b");
                            bold.appendChild(title);
                            var cell1   =   row.insertCell(0);
                            cell1.appendChild(bold);

                            var appraisal  =   document.getElementById('sysApp').value;

                            var sysApp = document.createTextNode(appraisal);
                            var bold1 = document.createElement("b");
                            bold1.appendChild(sysApp);
                            var cell2   =   row.insertCell(1);
                            cell2.appendChild(sysApp);

                            var title2 = document.createTextNode("Appraiser Appraisal %");
                            var bold3 = document.createElement("b");
                            bold3.appendChild(title2);
                            var cell3   =   row.insertCell(2);
                            cell3.appendChild(bold3);

                            var input = document.createElement('input');
                            input.setAttribute("id", "userAppraisal");
                            input.setAttribute("name", "userAppraisal");
                            input.setAttribute("type", "text");
                            input.setAttribute("size", "15");
                            input.setAttribute("maxLength", "3");

                            var cell4   =   row.insertCell(3);
                            cell4.appendChild(input);
                    }
                }
                    

                }else{
                    if(document.getElementById("appraisalRow")!=null){
                         var tableName   =   document.getElementById("appTable");
                         tableName.deleteRow(5);
                    }
                   
                }
            
            }
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
             function Slider(){
                $("#projectSummary").toggle("slow");
             }
             function editorTextCounter(field,cntfield,maxlimit)
                {
                    if (field > maxlimit)
                    {

                            if (maxlimit==2000)
                                alert('Comments size is exceeding 2000 characters');
                            else
                                alert('Comments size is exceeding 2000 characters');
                    }
                    else
                            cntfield.value = maxlimit - field;
                }
            function trim(str)  {
  		while (str.charAt(str.length - 1)==" ")
                    str = str.substring(0, str.length - 1);
  		while (str.charAt(0)==" ")
                    str = str.substring(1, str.length);
  		return str;
            }
            function fun(theForm)
            {
                var validate    =   document.getElementById('validation').value;
                if(document.getElementById('secondAppraiser').value==''){
                    alert("Please select Second Appraiser");
                    document.getElementById('secondAppraiser').focus();
                    return false;
                }
                if(document.getElementById('thirdAppraiser').value==''){
                    alert("Please select Third Appraiser");
                    document.getElementById('thirdAppraiser').focus();
                    return false;
                }
                if(validate=='submission'){
                    var project =document.getElementsByName("project");
                    var module  =document.getElementsByName("module");
                    var task    =document.getElementsByName("task");
                    var role    =document.getElementsByName("role");
                    for(var i=0;i<project.length;i++){

                        if(trim(project[i].value)==''){
                            alert('Please enter the Project Detail');
                            project[i].focus();
                            return false;
                        }
                        var projtext=project[i].value;

                        if((projtext.length)>1000){
                            alert('Project length should be less than 1000');
                            project[i].focus();
                            return false;
                        }
                         if(trim(module[i].value)==''){
                            alert('Please enter the Module details');
                            module[i].focus();
                            return false;
                        }
                        var modtext=module[i].value;

                        if((modtext.length)>1000){
                            alert('Module length should be less than 1000');
                            module[i].focus();
                            return false;
                        }
                        if(trim(task[i].value)==''){
                            alert('Please enter the Task');
                            task[i].focus();
                            return false;
                        }
                        var tasktext=task[i].value;

                        if((tasktext.length)>1000){
                            alert('Task length should be less than 1000');
                            task[i].focus();
                            return false;
                        }
                        if(trim(role[i].value)==''){
                            alert('Please enter the Role');
                            role[i].focus();
                            return false;
                        }
                        var roletext=role[i].value;

                        if((roletext.length)>1000){
                            alert('Role length should be less than 1000');
                            role[i].focus();
                            return false;
                        }

                    }
                    if (trim(CKEDITOR.instances.accomplishments.getData()) == "")
                    {
                        alert ("Please Enter the Accomplishments");
                        CKEDITOR.instances.accomplishments.focus();
                        return false;
                    }
                    if (CKEDITOR.instances.accomplishments.getData().length>2000)
                    {
                        alert (" Accomplishments exceeds 2000 character");
                        CKEDITOR.instances.accomplishments.focus();

                        return false;
                    }
                    if (trim(CKEDITOR.instances.ongoing.getData()) == "")
                    {
                        alert ("Please Enter the On Going Activities");
                        CKEDITOR.instances.ongoing.focus();
                        return false;
                    }
                    if (CKEDITOR.instances.ongoing.getData().length>2000)
                    {
                        alert (" On Going Activities exceeds 2000 character");
                        CKEDITOR.instances.ongoing.focus();

                        return false;
                    }
                    if (trim(CKEDITOR.instances.nextcycle.getData()) == "")
                    {
                        alert ("Please Enter the Plan for Next Cycle");
                        CKEDITOR.instances.nextcycle.focus();
                        return false;
                    }
                    if (CKEDITOR.instances.nextcycle.getData().length>2000)
                    {
                        alert ("Plan for Next Cycle exceeds 2000 character");
                        CKEDITOR.instances.nextcycle.focus();

                        return false;
                    }
                }
                if(validate=='review'){
                    if (trim(CKEDITOR.instances.attendance.getData()) == "")
                    {
                        alert ("Please Enter the Attendance Review");
                        CKEDITOR.instances.attendance.focus();
                        return false;
                    }
                    if (CKEDITOR.instances.attendance.getData().length>2000)
                    {
                        alert ("Attendance Review exceeds 2000 character");
                        CKEDITOR.instances.attendance.focus();

                        return false;
                    }
                    if (trim(CKEDITOR.instances.createdIssue.getData()) == "")
                    {
                        alert ("Please Enter the Created Issues Review");
                        CKEDITOR.instances.createdIssue.focus();
                        return false;
                    }
                    if (CKEDITOR.instances.attendance.getData().length>2000)
                    {
                        alert ("Created Issues Review exceeds 2000 character");
                        CKEDITOR.instances.createdIssue.focus();

                        return false;
                    }
                    if (trim(CKEDITOR.instances.workedIssue.getData()) == "")
                    {
                        alert ("Please Enter the Worked Issues Review");
                        CKEDITOR.instances.workedIssue.focus();
                        return false;
                    }
                    if (CKEDITOR.instances.workedIssue.getData().length>2000)
                    {
                        alert ("Worked Issues Review exceeds 2000 character");
                        CKEDITOR.instances.workedIssue.focus();

                        return false;
                    }
                    if (trim(CKEDITOR.instances.closedIssue.getData()) == "")
                    {
                        alert ("Please Enter the Closed Issues Review");
                        CKEDITOR.instances.closedIssue.focus();
                        return false;
                    }
                    if (CKEDITOR.instances.closedIssue.getData().length>2000)
                    {
                        alert ("Closed Issues Review exceeds 2000 character");
                        CKEDITOR.instances.closedIssue.focus();
                        return false;
                    }
                    if (trim(CKEDITOR.instances.approvalPercentage.getData()) == "")
                    {
                        alert ("Please Enter the Approval Percentage Review");
                        CKEDITOR.instances.approvalPercentage.focus();
                        return false;
                    }
                    if (CKEDITOR.instances.approvalPercentage.getData().length>2000)
                    {
                        alert ("Approval Percentage Review exceeds 2000 character");
                        CKEDITOR.instances.approvalPercentage.focus();
                        return false;
                    }
                    if (trim(CKEDITOR.instances.newLearnings.getData()) == "")
                    {
                        alert ("Please Enter the New Learnings Review");
                        CKEDITOR.instances.newLearnings.focus();
                        return false;
                    }
                    if (CKEDITOR.instances.newLearnings.getData().length>2000)
                    {
                        alert ("New Learnings Review exceeds 2000 character");
                        CKEDITOR.instances.newLearnings.focus();
                        return false;
                    }
                }
                var status  =   document.getElementById('status').value;
                if(status=='7'){
                var userApp =   document.getElementById('userAppraisal').value;
                if(userApp===''){
                     alert ("Please Enter the Appraisal Percentage");
                     return false;
                }
                if(validate=='yes'){
                    if (trim(CKEDITOR.instances.comments.getData()) == "")
                        {
                            alert ("Please Enter the Comments");
                            CKEDITOR.instances.comments.focus();
                            return false;
                        }
                        if (CKEDITOR.instances.comments.getData().length>2000)
                        {
                            alert (" Comments exceeds 2000 character");
                            CKEDITOR.instances.comments.focus();

                            return false;
                        }
                }
              
              }
                disableSubmit();
            }
        </script>
        <style type="text/css">
/*            #appTable tr{height:30px;}*/
        </style>
    </head>
    <%@ include file="/header.jsp"%>
    <body>
       <table cellpadding="0" cellspacing="0" width="100%">
	<tr  bgcolor="#C3D9FF">
		<td align="left"><b> Update Appraisal Request </b></td>
                <td align="right"><a
			href="<%=request.getContextPath()%>/admin/appraisal/printView.jsp?appId=<%= appId %>"
			target="_blank">Print this Issue</a></td>
                        
	</tr>

        </table>
        <%
                String[] monthName = {"Jan", "Feb","Mar", "Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct", "Nov","Dec"};
                int userId      =   (Integer)session.getAttribute("uid");
                
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
                
                Integer secondAppraiser  =   app.getSecondAppraiser();
                if(secondAppraiser==null){
                    secondAppraiser=0;
                }
                    
                
                Integer thirdAppraiser  =   app.getThirdAppraiser();
                if(thirdAppraiser==null){
                    thirdAppraiser=0;
                }

                String attendance       =   app.getAttendanceComments();
                String createdIss       =   app.getCreatedIssuesComment();
                String workedIss        =   app.getWorkedIssuesComment();
                String closedIss        =   app.getClosedIssuesComment();
                String approvalPer      =   app.getApprovalPercentage();
                String newLearning      =   app.getNewLearningsComment();

                
                int sysAppraisal    =   app.getSystemAppraisalPercentage();
                Integer userAppraisal   =   app.getUserAppraisalPercentage();
                String usrApp   =   "NA";
                if(userAppraisal!=null){
                    usrApp="Yes";
                }
        %>
        <table width="100%" >

        </table>
        <form name="theForm" action="<%= request.getContextPath() %>/MyAssignment/updateAppraisal.jsp" onsubmit="return fun(this);">
        <table width="100%" bgcolor="#E8EEF7" id="appTable">
            <tr>
                <td><input type="hidden" id="appId" name="appId" value="<%=appId%>"/>
                        <input type="hidden" id="appUser" name="appUser" value="<%=appraisalUser%>"/>
                        <input type="hidden" id="sysApp" name="sysApp" value="<%=sysAppraisal%>"/>
                        <input type="hidden" id="usrApp" name="usrApp" value="<%=usrApp%>"/>
                    </td>
            </tr>
            <tr style="height:30px;">
                    <td><b>Name</b></td>
                    <td><%=GetProjectManager.getUserName(appraisalUser)%></td>
                    <td><b>Designation</b></td>
                    <td><%=GetProjectManager.getUserDesignation(appraisalUser)%></td>
                    <td><b>Emp Id</b></td>
                    <td><%=app.getEmpId()%></td>
                </tr>
                <tr style="height:30px;">

                    <td><b>Period</b></td>
                    <td><%=period %></td>
                    <td><b>Status</b></td>
                    <td>
                         <%if(initiater.containsKey(userId)){%>
                         <select name="status" id="status" onchange="javascript:addAppraisal();">
                        <%
                            Collection se=status.keySet();
                    Iterator iter=se.iterator();
                   
		    while (iter.hasNext()) {

		      int key=(Integer)iter.next();
		      String nameOfStatus=(String)status.get(key);
                      if(key==statusId){

%>
                        <option value="<%=key%>" selected><%=nameOfStatus%></option>
                        
<%
                      }else{
%>
                            <option value="<%=key%>"><%=nameOfStatus%></option>
<%
                      }
                      }
%>
                        </select>
                        <%}else{
                           out.println(status.get(statusId));
                           %>
                           <input type="hidden" name="status" value="<%=statusId%>"/>
                           <%
}%>
                        
                    </td>
                    <td><b>Initiated By</b></td>
                    <td><%=GetProjectManager.getUserName(app.getInitiatedBy())%></td>

                </tr>



                <tr style="height:30px;">
                    <td><b>First Appraiser</b></td>
                    <td>
                        <%if(initiater.containsKey(userId)){%>
                            <select name="firstAppraiser" id="firstAppraiser">
                        <%

            for(int s=0;s<noOfUser;s++){
                Map.Entry entry = (Map.Entry) userArray[s];
                int Id   =   (Integer)entry.getKey();
                String name   =   (String)entry.getValue();
 //               name    =   name.substring(0, name.lastIndexOf(" ")+2);

                if(firstAppraiser==Id){
%>
                <option value="<%=Id%>" selected><%=name%></option>
<%

                }else{
%>
                <option value="<%=Id%>"><%=name%></option>
<%
                }
            }
        %>
                        </select>
                        <%}else{
%>
<%=GetProjectManager.getUserName(firstAppraiser)%>
<input type="hidden" name="firstAppraiser" value="<%=firstAppraiser%>">
<%
}%>
                    </td>
                    <td><b>Second Appraiser</b></td>
                    <td>
                        <%if(initiater.containsKey(userId)){%>
                        <select name="secondAppraiser" id="secondAppraiser">
                        <%
                   if(secondAppraiser==0){
            %>
            <option value="" selected>--Select Second Appraiser--</option>
            <%
            }
            for(int s=0;s<noOfUser;s++){
                Map.Entry entry = (Map.Entry) userArray[s];
                int Id   =   (Integer)entry.getKey();
                String name   =   (String)entry.getValue();
 //               name    =   name.substring(0, name.lastIndexOf(" ")+2);
            
        if(secondAppraiser==Id){
%>
                <option value="<%=Id%>" selected><%=name%></option>
<%

                }else{
%>
                <option value="<%=Id%>"><%=name%></option>
<%
                }
            }
        %>
                        </select>
                        <%}else{
%>
<%=GetProjectManager.getUserName(secondAppraiser)%>
<input type="hidden" name="secondAppraiser" value="<%=secondAppraiser%>">
<%
}%>

                    </td>
                    <td><b>Third Appraiser</b></td>
                    <td>
                     <%
                        if(initiater.containsKey(userId)){
%>
                        <select name="thirdAppraiser" id="thirdAppraiser">
                             
                        <%
                        if(thirdAppraiser==0){
            %>
            <option value="" selected>--Select Third Appraiser--</option>
            <%
            }
            for(int s=0;s<noOfUser;s++){
                Map.Entry entry = (Map.Entry) userArray[s];
                int Id   =   (Integer)entry.getKey();
                String name   =   (String)entry.getValue();

        if(thirdAppraiser==Id){
%>
                <option value="<%=Id%>" selected><%=name%></option>
<%

                }else{
%>
                <option value="<%=Id%>"><%=name%></option>
<%
                }
            }
        %>
                        </select>
                        <%}else{
%>
<%=GetProjectManager.getUserName(thirdAppraiser)%>
<input type="hidden" name="thirdAppraiser" value="<%=thirdAppraiser%>">
<%
}%>
                    </td>
                </tr>
                 <tr style="height:30px;">
                    <td><b>Assigned To</b></td>
                    <td>
                        
                      <select name="assignedto" id="assignedto">
                          <%
                           if(app.getAssignedto()==appraisalUser){%>
                          <option value="<%=appraisalUser%>" selected><%=GetProjectManager.getUserName(appraisalUser)%></option>
                          <%}else{%>
                          <option value="<%=appraisalUser%>" ><%=GetProjectManager.getUserName(appraisalUser)%></option>
                          <%}%>
                        <%
                  
            for(int s=0;s<noOfUser;s++){
                Map.Entry entry = (Map.Entry) userArray[s];
                int Id   =   (Integer)entry.getKey();
                String name   =   (String)entry.getValue();
 //               name    =   name.substring(0, name.lastIndexOf(" ")+2);

        if(app.getAssignedto()==Id){
%>
                <option value="<%=Id%>" selected><%=name%></option>
<%

                }else{
%>
                <option value="<%=Id%>"><%=name%></option>
<%
                }
            }
        %>
                        </select>

                    </td>
                    <td><b>Created On</b></td>
                    <td><%= created%></td>
                    <td><b>Updated On</b></td>
                    <td><%=updated%></td>
                    
                </tr>
                <%

                    if(userAppraisal!=null){
%>
                <tr>
                    <td><b>System Appraisal %</b></td>
                    <td><%=sysAppraisal%></td>
                    <td><b>Appraiser Appraisal %</b></td>
                    <td><%=userAppraisal%></td>

                </tr>
<%
            }
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
                if(currentStatus.equalsIgnoreCase("Appraisal Submission")&&appraisalUser==userId&&(accomplishmentCount==0)){
%>

                  <tr>
                   
                    <td> 
                        
                        <input type="hidden" name="comments" value="Submitting Appraisal Form">
                        <input type="hidden" name="validation" id="validation" value="submission">
                    </td>
                </tr>
                <tr>

                    <td colspan="4" align="center"><input type="button" id="showUserAccomplishment" value="Add Accomplishment" ></td>
                </tr>
<%
                }
                

                else if(currentStatus.equalsIgnoreCase("Appraisal Review")&& attendance==null){
%>
                <tr bgcolor="#C3D9FF" style="height:8px;">
                    <td colspan="6"><b>Appraisal Review Comments</b></td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table width="100%">
                            <tbody>
                                    <tr  align="left">
                                        <td><b>Attendance :</b></td> <td><b>Created Issue :</b></td>
                                    </tr>
                                    <tr bgcolor="#E8EEF7"  align="left">
                                        <td align="left">
                                            <textarea name="attendance"  cols="84" rows="2"></textarea>
                                       </td>

                                        <td align="left">
                                            <textarea name="createdIssue"  cols="84" rows="2"></textarea>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td><b>Worked Issue:</b></td> <td><b>Closed Issue</b>:</td>
                                    </tr>
                                    <tr bgcolor="#E8EEF7" align="left">
                                        <td>
                                        <textarea name="workedIssue"  cols="84" rows="2"></textarea>

                                        </td>

                                        <td align="left">
                                            <textarea name="closedIssue" cols="84" rows="2"></textarea>
                                        </td>

                                    </tr>

                                    <tr  align="left">
                                        <td><b>Approval Percentage: </b></td> <td><b>New Learning: </b></td>
                                    </tr>
                                    <tr bgcolor="#E8EEF7"  align="left">

                                         <td >
                                            <textarea name="approvalPercentage"  cols="84" rows="2"></textarea>
                                         </td>
                                         <td>
                                            <textarea name="newLearnings" cols="84" rows="2"></textarea>
                                            <script type="text/javascript">
                                                CKEDITOR.replaceAll(
                                                        function( textarea, config ){
                                                            config.width	=	550;
                                                            config.height	=	80;
                                                        }
                                                );


                                         </script>
                                             <input type="hidden" name="comments" value="Adding Review Comments">
                                             <input type="hidden" name="validation" id="validation" value="review">
                                         </td>
                                            
                                        


                                    </tr>

                                 
                                </tbody>
                            </table>
                    </td>
                </tr>
                <tr>

                    <td colspan="4" align="center"><input type="submit" id="submit" value="Submit"></td>
                </tr>
 
<%
                }
                else{
                %>
                <tr>
                    <td><b>Comments</b></td>
                    <td colspan="3">
                        <textarea rows="3" cols="68" name="comments" onKeyDown="textCounter(document.theForm.comments,document.theForm.remLen1,2000)" onKeyUp="textCounter(document.theForm.comments,document.theForm.remLen1,2000)"></textarea>
                    
                            <script type="text/javascript">
                    CKEDITOR.replace( 'comments',{toolbar:'Basic',height:100} );
                    var editor_data = CKEDITOR.instances.comments.getData();
                    CKEDITOR.instances["comments"].on("instanceReady", function()
                    {

                                    //set keyup event
                                    this.document.on("keyup", updateComments);
                                     //and paste event
                                    this.document.on("paste", updateComments);

                    });
                    function updateComments()
                    {
                            CKEDITOR.tools.setTimeout( function()
                                        {
                                            var desc    =   CKEDITOR.instances.comments.getData();
                                           var leng    =   desc.length;
                                           editorTextCounter(leng,document.theForm.remLen1,2000);

                                        }, 0);
                    }
               </script>
                    </td>
                    <td><input readonly type="text" name="remLen1" size="3" maxlength="3" value="2000">
                    <input type="hidden" name="validation" id="validation" value="yes">
                    </td>
                </tr>
                <tr>
                    
                    <td colspan="4" align="center"><input type="submit" id="submit" value="Submit"></td>
                </tr>
                <%}%>
                
                
        </table>
        </form>
                    <iframe
	src="<%=request.getContextPath()%>/appraisalComments.jsp?appId=<%= appId %>"
	scrolling="auto" frameborder="2" height="20%" width="99%"></iframe>
        
    </body>
</html>


