<%-- 
    Document   : comments
    Created on : Nov 20, 2009, 10:57:58 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.eminent.timesheet.*,java.util.*,com.eminent.util.GetProjectMembers"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{

		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
        String timeSheetId=request.getParameter("timeSheetId");
        List l =CreateTimeSheet.GetCommentDetails(timeSheetId);
        int noOfRecords =   l.size();
%>

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>Timesheet Comments</title>
        <LINK title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
    <style type="text/css">
TH {
    font-weight:  bold;
    font-size:  11px;
    background:#000099;
    color:  white;
    font-family:  Arial, Helvetica;
    text-align:  left;
}
</style>
    </head>
    <body>
        <table width="100%" >
	<tr>
		<th align="center" >Info By</th>
		<th align="center" >TimeStamp</th>
		<th align="center" >Info History</th>
               	<th align="center" >Info To</th>
		
	</tr>
        <%
            for (Iterator i = l.iterator(); i.hasNext(); ) {
            Timesheetinfo t =(Timesheetinfo)i.next();
            Users users=t.getUsersByInfoby();
            Users user=t.getUsersByInfoto();
            int commentedtouserid =user.getUserid();
            int commentedbyuserid =users.getUserid();
            String commentedby=GetProjectMembers.getUserName(((Integer)commentedbyuserid).toString());
            String commentedto=GetProjectMembers.getUserName(((Integer)commentedtouserid).toString());
            String comments=t.getInfo();
            String commentedon=new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(t.getInfoaddedon());
            commentedby=commentedby.substring(0,commentedby.indexOf(" ")+2);
            commentedto=commentedto.substring(0,commentedto.indexOf(" ")+2);
            %>
            <tr>
                <td width="15%"><%=commentedby%></td>
                <td width="10%"><%=commentedon%></td>
                <td width="60%"><%=comments%></td>
                <td width="15%"><%=commentedto%></td>

            </tr>
            <tr>
		<td width="100%" colspan="4" align="center">-----------------------------------------------------------------------------------------------------------------------------------------</td>
	</tr>
        <%
            }
        %>
        </table>
    </body>
</html>
