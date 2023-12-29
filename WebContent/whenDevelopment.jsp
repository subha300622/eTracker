<%-- 
    Document   : whenDevelopment
    Created on : May 29, 2014, 11:56:14 AM
    Author     : E0288
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>
    </head>
    <body >
        <table align="center" width="100%" cellpadding="0" cellspacing="0">
            <tr style="height: 20px;">

                <td width="145" align="left"><a
                        href="https://www.eminentlabs.net" target="_new"><img border="0" height="28"
                                                                         alt="Eminentlabs Software Pvt. Ltd."
                                                                         src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
                <td align="right">
                    <img alt="Eminentlabs Software Pvt Ltd" height="25" src="<%= request.getContextPath()%>/eminentech support files/Eminentlabs_logo.gif">
                </td>
            </tr>
        </table>
    <center><h3 style="color: blue;"><marquee direction="left" >Development is going on for this functionality.Wait couple of days ....</marquee></h3></center>
    </body>
</html>
