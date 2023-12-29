<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.* , java.applet.*,java.util.*"%>

<%
        response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
 	response.setHeader("Pragma","no-cache");
                        
                        //Configuring log4j properties
			
			
			
			Logger logger = Logger.getLogger("leadStatusDashBoard");
			
                        
                        String logoutcheck=(String)session.getAttribute("Name");
			if(logoutcheck==null)
			{
				
				%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
			}


%>

<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</TITLE>
<script language="JavaScript">
  function check(searchLead)  {  
    if ((searchLead.leadName.value==null)||(searchLead.leadName.value==""))
		{
			alert("Please Enter Name or Company ")
			searchLead.leadName.focus()
			return false
		}
                return true
                }
	function printpost(post)
	{
		pp = window.open('./profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
		pp.focus();
	}	
	</script>

</head>
<body>
<%@ include file="/header.jsp"%>

<applet code="LineGraphApplet.class" archive="Linegraph.jar" width="550"
	height="450">
	<form name="searchLead" onsubmit="return check(this);"
		action=" <%=  request.getContextPath() %>/admin/customer/searchLead.jsp">
	<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
		<tr>
			<td align="left"><font size="4" COLOR="#0000FF"><b>Lead
			Administration</b> </font>
			<td align="center"><b>Enter the Name or Company:</b></td>
			<td align="left"><input type="text" name="leadName"
				maxlength="20" size="15"></td>
			<td align="left"><input type="submit" name="submit"
				value="Search"></td>
			<td align="left"><input type="reset" name="reset" value="Reset">
			</td>
			<td></td>
		</tr>
	</table>
	</form>
	<TABLE width="100%" border="0">
		<tr>
			<td><a
				href="<%=request.getContextPath() %>/admin/customer/addnewlead.jsp">Add
			Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
				href="<%=request.getContextPath() %>/admin/customer/viewlead.jsp">View
			All Leads</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
				href="<%=request.getContextPath() %>/admin/customer/waitingLead.jsp">Approve
			Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
				href="<%=request.getContextPath() %>/admin/customer/deniedLeads.jsp">Denied
			Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
				href="<%=request.getContextPath() %>/admin/customer/disabledLead.jsp">Disabled
			Lead</a></td>
		</tr>
	</TABLE>
	<!-- Start Up Parameters -->
	<PARAM name="LOADINGMESSAGE" value="Creating Chart - Please Wait.">
	<!-- Message to be displayed on Startup -->
	<PARAM name="STEXTCOLOR" value="0,0,100">
	<!-- Message Text Color-->
	<PARAM name="STARTUPCOLOR" value="255,255,255">
	<!-- Applet Background color --> <!-- Line Graph parameters, example values -->
	<!-- All of the following properties are optional  --> <!-- Any properties which are not supplied will be -->
	<!-- automatically calculated.                     --> <!-- General Properties -->
	<PARAM name="BackgroundColor" value="#FFFFFF">
	<PARAM name="linkcursor" value="hand">
	<PARAM name="thousandseparator" value=",">
	<PARAM name="nSeries" value="3">
	<PARAM name="ndecplaces" value="0">

	<!-- Grid properties -->
	<PARAM name="grid" value="true">
	<PARAM name="axis" value="true">
	<PARAM name="nRows" value="8">
	<PARAM name="vSpace" value="30">
	<PARAM name="hSpace" value="30">
	<PARAM name="nPoints" value="12">
	<PARAM name="gridxpos" value="100">
	<PARAM name="gridypos" value="370">
	<PARAM name="gridstyle" value="2">
	<PARAM name="gridColor" value="#AAAAAA">
	<PARAM name="axisColor" value="#888888">
	<PARAM name="floorColor" value="#EEEEFF">
	<PARAM name="gridbgimage" value=" ">
	<PARAM name="gridbgcolor" value="#FFFFFF">

	<!-- Scale properties -->
	<PARAM name="autoscale" value="false">
	<PARAM name="chartScale" value="2">
	<PARAM name="chartStartY" value="0">

	<!-- 3D properties -->
	<PARAM name="3D" value="true">
	<PARAM name="outline" value="true">
	<PARAM name="lineOutlineColor" value="blue">
	<PARAM name="depth3D" value="1">

	<!-- Legend properties -->
	<PARAM name="legend" value="true">
	<PARAM name="LegendBackground" value="#FFFFFF">
	<PARAM name="LegendBorder" value="#5555AA">
	<PARAM name="LegendtextColor" value="#000000">
	<PARAM name="legendtitle" value="CRM Tracking">
	<PARAM name="legendposition" value="-1,-1">
	<PARAM name="legendfont" value="Arial,N,12">
	<PARAM name="LegendStyle" value="Vertical">

	<!-- X axis labels -->
	<PARAM name="labelOrientation" value="Up Angle">
	<PARAM name="labelsY" value="400">
	<PARAM name="xlabel_font" value="Arial,N,12">
	<PARAM name="labelColor" value="#000000">
	<PARAM name="label1" value="Apr">
	<PARAM name="label2" value="May">
	<PARAM name="label3" value="Jun">
	<PARAM name="label4" value="Jul">
	<PARAM name="label5" value="Aug">
	<PARAM name="label6" value="Sep">
	<PARAM name="label7" value="Oct">
	<PARAM name="label8" value="Nov">
	<PARAM name="label9" value="Dec">
	<PARAM name="label10" value="Jan">
	<PARAM name="label11" value="Feb">
	<PARAM name="label12" value="Mar">

	<!-- Y axis labels -->
	<PARAM name="ylabels" value="true">
	<PARAM name="ylabel_font" value="Arial,N,12">
	<PARAM name="ylabel_pre" value="INR">
	<PARAM name="ylabel_post" value=" ">

	<!-- Chart Titles --> <!-- 
<PARAM name="title"                value="Graph Title">
<PARAM name="xtitle"               value="X axis title">
<PARAM name="ytitle"               value="Y axis title">
--> <!-- PopUp Display -->
	<PARAM name="popupbgcolor" value="#AAAAFF">
	<PARAM name="popupfont" value="Arial,N,8">
	<PARAM name="popup_pre" value="INR">
	<PARAM name="popup_post" value=" ">

	<!-- Series Data -->
	<PARAM name="series1" value="#FF8000|5|6|true|Lead Potential">
	<PARAM name="series2" value="#0000FF|4|6|true|Opportunity">
	<PARAM name="series3" value="#00F000|3|6|true|Account">

	<!-- free form text --> <!-- <PARAM name="text1"           value="Note :|80,60|TimesRoman,N,12|0,0,255">  -->
	<!-- <PARAM name="text2"           value="New product range|80,80|TimesRoman,N,12|0,0,0"> -->
	<!-- <PARAM name="text3"           value="launched during|80,100|TimesRoman,N,12|0,0,0"> -->
	<!-- <PARAM name="text4"           value="quarter 2.|80,120|TimesRoman,N,12|0,0,0"> -->

	<!-- Images --> <!-- <PARAM name="image1"          value="./images/logo.gif,0,0"> -->
	<!-- <PARAM name="image2"          value="./images/legend.gif,210,0"> -->

	<!-- Trend Lines --> <!-- <PARAM name="trend1"          value="175,0,0|3|10|7500|10500|trend 1|Arial,N,10">  -->

	<!-- Target Lines --> <!--  <PARAM name="target1"         value="0,125,0|4|5500|Target|Arial,N,10">  -->

	<PARAM name="data1series1" value="9">
	<PARAM name="data2series1" value="7">
	<PARAM name="data3series1" value="6">
	<PARAM name="data4series1" value="8">

	<PARAM name="data1series2" value="8">
	<PARAM name="data2series2" value="5">
	<PARAM name="data3series2" value="3">
	<PARAM name="data4series2" value="4">

	<PARAM name="data1series3" value="5">
	<PARAM name="data2series3" value="4">
	<PARAM name="data3series3" value="3">
	<PARAM name="data4series3" value="2">



</applet>
</body>
</html>