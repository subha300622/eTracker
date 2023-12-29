<%-- 
    Document   : viewFiles
    Created on : 13 Aug, 2010, 8:14:03 PM
    Author     : Tamilvelan
--%>
<%@page import="org.apache.log4j.Logger"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%Logger logger = Logger.getLogger("viewFiles");
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
<META http-equiv=Content-Type content="text/htmlcharset=windows-1252">
<META http-equiv=Expires content=-1>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Cache-Control content=no-cache>
<LINK title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css" 	type="text/css" rel=STYLESHEET>


<META content="MSHTML 6.00.2600.0" name=GENERATOR>
</HEAD>

<%@ page import="java.util.Iterator,java.util.HashMap,com.eminent.util.*,java.util.List,java.text.*,com.eminent.tqm.TqmPtcfileattach,com.eminent.tqm.FileAttach"%>
<%@ page language="java"%>

<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
	marginwidth="0">
<table width="100%" valign="right" height="5%" border="0">
	<tr>
		<td border="0" align="left" width="800"><b><font size="3"
			COLOR="#0000FF"> Welcome</font></b> <FONT SIZE="3" COLOR="#0000FF">
		<b><%=session.getAttribute("fName")%>&nbsp;<%=session.getAttribute("lName")%>,
		</b></FONT> <FONT SIZE="2" COLOR="#00CC00"> <b><%=session.getAttribute("company")%>
		</b></FONT></td>

                <td width="15%" border="1" align="center"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <IMG
			SRC="<%=request.getContextPath()%>/images/New.jpg" ALT="New Features"
			width="25" height="15" align="middle">&nbsp;&nbsp;<a
			href="<%=request.getContextPath() %>/newFeatures.jsp">New Features</a></font></td>
        <td width="8%" border="1" align="center"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <IMG
			SRC="<%=request.getContextPath()%>/images/update.gif" ALT="about"
			width="20" height="21" align="middle">&nbsp;&nbsp;<a
			href="<%=request.getContextPath() %>/help.jsp ">Help</a></font></td>
		<td width="8%" border="1" align="center"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <IMG
			SRC="<%=request.getContextPath()%>/images/help.gif" ALT="about"
			width="20" height="21" align="middle">&nbsp;&nbsp;<a
			href="javascript:detail() ">About</a></font></td>
		<td width="8%" border="1" align="center"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <IMG
			SRC="<%=request.getContextPath()%>/images/profile.jpeg" ALT="profile"
			width="17" height="18" align="middle">&nbsp;&nbsp;<a
			href="<%=request.getContextPath() %>/UserProfile/profile.jsp">Profile</a></font>
		</td>

		<td width="8%" align="center" border="1"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <IMG
			SRC="<%=request.getContextPath()%>/images/logout.gif" ALT="logout"
			width="20" height="21" align="middle">&nbsp;&nbsp;<A
			HREF="<%= request.getContextPath() %>/logout.jsp" target="_parent">Logout</A></font>
		</td>
	</tr>
</table>
<br>


<div align="center">
<center>


<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#C3D9FF">
		<td border="1" align="left" width="100%"><font size="4"
			COLOR="#0000FF"><b>Test Case Attached Files </b></font> <FONT SIZE="3"
			COLOR="#0000FF"></FONT></td>
	</tr>
	<tr>
		<td height="10"></td>
	</tr>
</table>
<br>


<table bgColor=#E8EEF7 align="center" width="100%">
	<TBODY>
		<tr>
			<th>Attached On</th>
			<th>Owner</th>
			<th>File Name</th>
                        <th>Issue Status</th>
		</tr>


		<%
                String tceId    =   request.getParameter("tceId");
 
	try
	{
		 HashMap hm =new HashMap<Integer,String>();
		 List file   =   FileAttach.getFiles(Integer.parseInt(tceId));
                 TqmPtcfileattach   attachedFile =   null;
			String filename=null;
			String attachdate=null;
                        int owner=0;
                        String status=null;
			String name=null;
			
			
			
				for (Iterator i = file.iterator(); i.hasNext(); ) {
                                attachedFile    =   (TqmPtcfileattach)i.next();
                                filename	=	attachedFile.getFilename();
	         java.util.Date attach          =	attachedFile.getAttacheddate();
	        		status          =       attachedFile.getPtcstatus().toString();
	        		owner		=	attachedFile.getOwner();


	        		SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy hh:mm:ss");
	        		if( attach!=null){
	        			attachdate=sdf.format(attach);
	        		}else{
	        			attachdate="NA";
	        		}
					
				name=GetProjectManager.getUserName(owner);
					
                                int statusId    =   Integer.parseInt(status);
                                hm.put(new Integer(0), "Yet to Test");
                                hm.put(new Integer(1), "Not Applicable");
                                hm.put(new Integer(2), "Could Not Run");
                                hm.put(new Integer(3), "Failed");
                                hm.put(new Integer(4), "Passed");
                                String stat = (String)hm.get(statusId);
%>
		<tr>

			<td  width="14%"><%=attachdate %></td>

			<td  width="17%"><%=name%></td>
			<td height="10"><font
				face="Verdana, Arial, Helvetica, sans-serif" size="1"
				color="#000000"> <a
				href="<%=request.getContextPath()%>/Etracker_AttachedFiles/<%=filename%>"
				target="_blank"><%=filename%></a></font></td>
                                <td><%=stat%></td>
		</tr>
		<%
				
			}
			
		
	}
	catch(Exception e)
	{
			logger.error(e.getMessage());
	}
	
%>

</table>
<br>
<br>
<P></P>
<P></P>
</center>
</div>
</BODY>
</HTML>

