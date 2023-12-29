<%-- 
    Document   : userAppraisalInitiation
    Created on : Dec 21, 2011, 3:16:37 PM
    Author     : Tamilvelan
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/header.jsp"%>
<%@ page import="org.apache.log4j.*"%>
<%@page import="com.eminent.util.GetProjectMembers" %>
<%@page import="com.eminentlabs.appraisal.AppraisalUtil" %>
<%@page import="java.util.ArrayList,java.util.HashMap,java.util.Collection,java.util.Iterator,java.util.Calendar,java.util.GregorianCalendar" %>
<%!
    private static HashMap<Integer,String> monthSelect = new HashMap<Integer,String>();

	    static{

	    monthSelect.put(0,"Jan");
	    monthSelect.put(1,"Feb");
	    monthSelect.put(2,"Mar");
	    monthSelect.put(3,"Apr");
	    monthSelect.put(4,"May");
	    monthSelect.put(5,"Jun");
	    monthSelect.put(6,"Jul");
	    monthSelect.put(7,"Aug");
	    monthSelect.put(8,"Sep");
	    monthSelect.put(9,"Oct");
	    monthSelect.put(10,"Nov");
	    monthSelect.put(11,"Dec");

	}
%>
<%
//Configuring log4j properties

			

			Logger logger = Logger.getLogger("PerformanceChart");
			
                        int userId                  =   (Integer)session.getAttribute("uid");
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <style type="text/css">
        #accomplishments {width: 698px; height: 100px; border: 3px solid #E0ECFF;}
        #accomplishments label, #saveChanges input[type="text"], #comppopup input[type="password"] {margin: 15px 10px 5px;}
        #accomplishments label {font-weight: bold; width: 45px; margin-left: 40px}
        #accomplishments .save {margin-left: 10px;}
        #accomplishments div {overflow: hidden; margin: 10px;}
        #accomplishments a {display: block; text-align: right; width: 320px; font-size: 0.9em;}
        #scrollbar_content{width: 745px; height: 137px;}
        #scrollbar_container{width: 741px;}
        #issue{width: 741px;background-image: yellow;height: 30px;}
        </style>
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath() %>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/addSummary.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/jquery.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/jquery.nicescroll.min.js"></script>
        <script type="text/javascript">
        $(document).ready(function() {

                    $("#scrollbar_content").niceScroll({cursorcolor:"#A1A1A1"});
                    
        });
			
        function showAccomplishment() {        
		$('#overlay').fadeIn('fast', 'swing');
		$('#accomplishments').center().fadeIn('fast', 'swing');

	};
        function closeAccomplishment() {
		$('#overlay').fadeOut('fast', 'swing');
		$('#accomplishments').center().fadeOut('fast', 'swing');

	};
          function trim(str)  {
  		while (str.charAt(str.length - 1)==" ")
                    str = str.substring(0, str.length - 1);
  		while (str.charAt(0)==" ")
                    str = str.substring(1, str.length);
  		return str;
            }
            function validateProcess(){
                                    
                disableSubmit();
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
        </script>
        <style type="text/css">
            .app tr{height:25px;margin-left: 50px;}
        </style>
    </head>
    <body>
        <table cellpadding="0" cellspacing="0" width="100%" align="center">
	<tr bgcolor="#C3D9FF">
		<td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Appraisal Form of <%=GetProjectMembers.getUserName(((Integer)userId).toString())%></b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
	</tr>
        </table>
        <%
            
            HashMap initiater           =   AppraisalUtil.getIntiater();
            HashMap firstAppraiser      =   (HashMap)initiater.clone();
            HashMap secondAppraiser     =   (HashMap)initiater.clone();
            HashMap thirdAppraiser      =   (HashMap)initiater.clone();
            HashMap userDetails         =   AppraisalUtil.getUserDetails(userId);
            HashMap accountDetails      =   AppraisalUtil.getAccounts();
            //calculating start and end date of this month
		Calendar cal = new GregorianCalendar();
                int currentYear  = cal.get(Calendar.YEAR);
                int month        = cal.get(Calendar.MONTH);
                int year         = currentYear;

                String period   =   AppraisalUtil.getLastAppraisalPeriod(userId);
                logger.info("Start Period"+period);
                String startMonth      =   period.substring(period.indexOf("-")+1, period.lastIndexOf("-"));
                logger.info("Start Month"+startMonth);

                String stYear      =   period.substring(period.lastIndexOf("-")+1, period.length());
                logger.info("Start Year"+stYear);
%>
<form id="theForm" name="theForm" action="createUserRequest.jsp" onsubmit="javascript:validateProcess(this)">
        <table width="100%" align="center" bgcolor="#E8EEF7" class="app">
            <tr>
                <td><b>Name</b></td>
                <td><%=GetProjectMembers.getUserName(((Integer)userId).toString())%><input type="hidden" name="userId" id="userId" value="<%=userId%>"/></td>
            </tr>
            <tr>
                <td><b>Designation</b></td>
                <td><%=userDetails.get("designation")%><input type="hidden" name="designation" id="designation" value="<%=userDetails.get("designation")%>"/></td>
            </tr>
            <tr>
                <td><b>Employee ID</b></td>
                <td><%=userDetails.get("employeeId")%><input type="hidden" name="employeeId" id="employeeId" value="<%=userDetails.get("employeeId")%>"/></td>
            </tr>
            <tr>
                <td><b>Period</b></td>
                <td>
                     <select name="frommonth" id="frommonth">
                         <%

                            for(int k=Integer.parseInt(startMonth)-1;k<monthSelect.size();k++){
                                    if(k==(Integer.parseInt(startMonth)-1)){
                                     %>
                                     <option value='<%=k%>' selected><%=monthSelect.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=k%>'><%=monthSelect.get(k)%></option>
                                     <%
                                    }

                                }
%>

                    </select>

                    <%
                        ArrayList<Integer> selectYears=new ArrayList<Integer>();
                        int startYear = Integer.parseInt(stYear);

                        while(startYear<=currentYear){
                            selectYears.add(startYear);
                            startYear++;
                        }
                    %>

                    <select name='fromyear' id='fromyear' >
                        <%
                        for(int k=0,selected=2008;k<selectYears.size();k++,selected++){
                                    if(selected==Integer.parseInt(stYear)){
                                     %>
                                     <option value='<%=selectYears.get(k)%>' selected><%=selectYears.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=selectYears.get(k)%>'><%=selectYears.get(k)%></option>
                                     <%
                                    }

                                }

                       %>
                    </select>
                     <span style="width:25px;">To</span>
                     <select name="tomonth" id="tomonth">
                         <%

                            for(int k=0;k<monthSelect.size();k++){
                                    if(k==month){
                                     %>
                                     <option value='<%=k%>' selected><%=monthSelect.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=k%>'><%=monthSelect.get(k)%></option>
                                     <%
                                    }

                                }
%>

                    </select>

                    <%
                        ArrayList<Integer> listYears=new ArrayList<Integer>();
                        startYear=Integer.parseInt(stYear);
                        while(startYear<=currentYear){
                            listYears.add(startYear);
                            startYear++;
                        }
                    %>

                    <select name='toyear' id='toyear' >
                        <%
                        for(int k=0,selected=2008;k<listYears.size();k++,selected++){
                                    if(selected==year){
                                     %>
                                     <option value='<%=listYears.get(k)%>' selected><%=listYears.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=listYears.get(k)%>'><%=listYears.get(k)%></option>
                                     <%
                                    }

                                }

                       %>
                    </select>

                </td>
            </tr>
<!--            <tr bgcolor="#C3D9FF" style="height:8px;">
                    <td colspan="3"><b>Project Summary</b></td>
                    <td ><b><a href="#" onclick="javascript:showAccomplishment();">Show Accomplishment</a></b></td>
            </tr>-->
                
                


            <tr><td><b></b></td><td></td></tr>
            <tr><td colspan="1" align="right"><input type="submit" name="Initiate" id="submit" value="Initiate"/></td></tr>
        </table>
</form>
<!--                    <div id="overlay"></div>
                    <div  style="clear: both;width:745px;height:237px;font-size:11px;margin-top:5px;position:relative;">
			<h3 class="popupHeading">Accomplishment Issues</h3>
                        <div id="scrollbar_container">
                        <div id="scrollbar_content" >
			<div style="background-color: cyan;">

                                <div id="issue" style="position: relative;">
                                    <div style="float:left;width: 125px;">E03032008016</div><div style="float:right;width: 325px;">Creating Installer for eTracker</div>
                                </div>
                                 <div id="issue"  style="position: relative;">
                                    <div style="float:left;width: 125px;">E03032008016</div><div style="float:right;width: 325px;">Creating Installer for eTracker</div>
                                </div>
                                 <div id="issue"  style="position: relative;">
                                 <div style="float:left;width: 125px;">E03032008016</div><div style="float:right;width: 325px;">Creating Installer for eTracker</div>
                                </div>
                                 <div id="issue"  style="position: relative;">
                                 <div style="float:left;width: 125px;">E03032008016</div><div style="float:right;width: 325px;">Creating Installer for eTracker</div>
                                </div>
                                 <div id="issue"  style="position: relative;">
                                 <div style="float:left;width: 125px;">E03032008016</div><div style="float:right;width: 325px;">Creating Installer for eTracker</div>
                                </div>
                                 <div id="issue"  style="position: relative;">
                                 <div style="float:left;width: 125px;">E03032008016</div><div style="float:right;width: 325px;">Creating Installer for eTracker</div>
                                </div>
                                 <div id="issue"  style="position: relative;">
                                 <div style="float:left;width: 125px;">E03032008016</div><div style="float:right;width: 325px;">Creating Installer for eTracker</div>
                                </div>
			</div>
                        </div>
                        <div id="scrollbar_track">
                               <div id="scrollbar_handle" class="selected" style="top: 0px; position: relative; height: 91.3743px;"></div>

                        </div>
                    </div>
                            </div>-->

    </body>
</html>

