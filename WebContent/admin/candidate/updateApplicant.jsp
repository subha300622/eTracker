<%-- 
    Document   : updateApplicant
    Created on : Apr 5, 2012, 5:39:39 PM
    Author     : Tamilvelan
--%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList,dashboard.CurrentDay,com.eminentlabs.erm.ERMUtil,com.eminent.util.GetProjectMembers,java.util.HashMap,com.eminent.util.SendMail" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<% Logger logger = Logger.getLogger("updateApplicant");
try{
    String comments     =   request.getParameter("comments");
    String applicantId  =   request.getParameter("applicantId");
    String statusId     =   request.getParameter("statusid");
    String assTo        =   request.getParameter("assignedto");
        String isFake =   request.getParameter("isfake");
    int userId          =   (Integer)session.getAttribute("uid");
    ERMUtil.addERMComments(comments, userId, Integer.parseInt(statusId), userId,applicantId,Integer.parseInt(assTo),Integer.parseInt(isFake));
    
    
    
    String name     =   request.getParameter("name");
    String location =   request.getParameter("location");
    String grad     =   request.getParameter("grd");
    String grdYear =   request.getParameter("gradyear");
    String percentage     =   request.getParameter("percentage");
    String areaofexpertise =   request.getParameter("areaofexpertise");
    String sapyears     =   request.getParameter("sapyears");
    String sapmonths =   request.getParameter("sapmonths");
    String totalyears     =   request.getParameter("totalyears");
    String totalmonths =   request.getParameter("totalmonths");

            
                        Map hm =new HashMap<Integer,String>();
                        hm=ERMUtil.ermApplicantStatus();
 ArrayList<String> dateAndTime = CurrentDay.getDateTime();
    
  // Sending Mail to Gopal and Tamil
        String adminMail ="<table>"+

	"<tr>"+
		"<td colspan=4><b><font color=blue >Candidate Details</font></b></td>"+
	"</tr>"+
        "<tr bgcolor=#E8EEF7>"+
		"<td>Name</td><td>"+name+"</td>"+
                "<td>Location</td><td>"+location+"</td>"+
	"</tr>"+
	"<tr>"+
		"<td>Qualification</td><td>"+grad+"</td>"+
                "<td>Graduation Year</td><td>"+grdYear+"</td>"+
	"</tr>"+
	"<tr bgcolor=#E8EEF7>"+
                "<td>Percentage</td><td>"+percentage+"</td>"+
                "<td>Module</td><td>"+areaofexpertise+"</td>"+
	"</tr>"+
	"<tr  >"+
		"<td>SAP Experience</td><td>"+sapyears+"Y "+sapmonths+"M</td>"+
                "<td>Overall Experience</td><td>"+totalyears+"Y "+totalmonths+"M</td>"+
	"</tr>"+
        "<tr  bgcolor=#E8EEF7>"+
		"<td>Update By</td><td>"+GetProjectMembers.getUserName(((Integer)userId).toString()) +"</td>"+
                "<td>Assigned To</td><td>"+GetProjectMembers.getUserName(assTo) +"</td>"+
	"</tr>"+
        "<tr  >"+
		"<td>Status</td><td>"+hm.get(Integer.parseInt(statusId))+"</td>"+
                "<td>Updated On</td><td>"+dateAndTime.get(0)+" "+dateAndTime.get(1)+"</td>"+
	"</tr>"+
         "<tr bgcolor=#E8EEF7 >"+
		"<td>Comments</td>"+
                "<td colspan=3>"+comments+"</td>"+
	"</tr>"+
"</table>";
                       String endLine="</table><br>Thanks,";
                            String signature="<br>eTracker&trade;<br>";
                            String emi      =   "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                            String lineBreak =  "<br>";

                            String htmlTableEnd="<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                            adminMail = adminMail+endLine+signature+htmlTableEnd+lineBreak+emi; 
                             String senderName = (String)session.getAttribute("fName")+" "+ (String)session.getAttribute("lName");
                             String content = "eTracker ERM "+hm.get(Integer.parseInt(statusId))+": "+applicantId;
                              try{
                         SendMail.ERMUpdation(senderName,adminMail,content,GetProjectMembers.getMail(assTo),GetProjectMembers.getMail(((Integer)userId).toString()));
                       }catch(Exception e){
                           logger.error(e.getMessage());
                       }
}catch(Exception e){
    logger.error(e.getMessage());
} 
         String link=(String)session.getAttribute("forwardpage");
	//Please add below line when issue id is missed this page is link to createissueup.jsp
        
//        link    =   link+"?issueId="+issueId;

                //session.getAttribute("forwardpage") is null by default page is forwarding to My Assignment page 
                if(link==null){
                    link="assignedApplicants.jsp";
                }
%>
<jsp:forward page="<%=link%>">
    <jsp:param name="flag" value="true"/>
</jsp:forward>

	
<%   
%>


<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
