<%--
    Document   : defineValue
    Created on : Feb 1, 1009, 1:14:18 PM
    Author     : Tamilvelan
--%>

<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
    <%@page import="java.util.*,com.eminent.util.*,org.apache.log4j.*" %>

    <%
        //log4j configuration

      
		Logger logger = Logger.getLogger("defineValue");
		
        String logoutcheck=(String)session.getAttribute("Name");
        if(logoutcheck==null)
        {
             logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

        }


    %>
<!DOCTYPE HTML PUBLIC "-//W1C//DTD HTML 4.01 Transitional//EN"
   "http://www.w1.org/TR/html4/loose.dtd">
 <%@ include file="/header.jsp"%>

 <table>
     <tr></tr>
 </table>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type=text/css rel=STYLESHEET>
        <script language=javascript	src="<%= request.getContextPath() %>/javaScript/validateValues.js"></script>
        <title>eTracker&#158; - Eminentlabs&#158; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <script>
                  </script>
    </head>

    <body>
        <%
            String tablename    =   null;
            String header       =   "Value Administration";
            String pageToDisplay    =   request.getParameter("viewpage");

            logger.info("Define page"+pageToDisplay);

            if(pageToDisplay.equals("bug")){
                tablename   =   "VALUE_NONSAP_BUG";
                header      =   "Define Non SAP Bug Value";
            }
            else if(pageToDisplay.equals("enhancement"))
            {
                 tablename  =   "VALUE_NONSAP_ENHANCEMENT";
                 header     =   "Define Non SAP Enhancement Value";
            }
            else if(pageToDisplay.equals("newtask"))
            {
                tablename="VALUE_NONSAP_NEWTASK";
                header      =   "Define Non SAP New Task Value";
            }


            HashMap<String,Integer> hm=GetValues.checkValue();

            int bug         =   hm.get("bug");
            int enhancement =   hm.get("enhancement");
            int newtask     =   hm.get("newtask");


            logger.info("Bug"+bug);
            logger.info("Enhancement"+enhancement);
            logger.info("New Task"+newtask);


// variable to specify the type of table(whether bug,enhancement or newtask table)
            String insertPage       =   "No";


            //Getting the statuses from the status master table
            HashMap<Integer,String> status   =GetValues.getStatus();
            int noOfStatus  =   status.size();
            logger.info("No of Status"+noOfStatus);
            String statusName   =   null;




        %>
         <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
            <tr border="2">
                <td border="1" align="left"><font size="4" COLOR="#0000FF"><b><%=header%></b> </font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>

                <td border="1" align="right"><font size="4" COLOR="#0000FF"> </font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
            </tr>
        </table>
        
        <form name="theForm" onsubmit="return fun(this)" action="<%=request.getContextPath()%>/admin/user/createValue.jsp" method="post" onReset="return setFocus()">
         <table>
             <tr>
                 <td>
                     <%
                     if(bug==0 && !pageToDisplay.equals("bug")){
                      %>
                       <a href="<%=request.getContextPath() %>/admin/user/defineValue.jsp?viewpage=bug">Define Bug Value</a>&nbsp;&nbsp;&nbsp;&nbsp;


                      <%
                        }
                     %>
                 </td>
                 <td>
                      <%
                        if(enhancement==0 && !pageToDisplay.equals("enhancement")){
                        %>
                         <a href="<%=request.getContextPath() %>/admin/user/defineValue.jsp?viewpage=enhancement">Define Enhancement Value</a>&nbsp;&nbsp;&nbsp;&nbsp;
                      <%
                        }
                     %>
                 </td>
                 <td>
                      <%
                        if(newtask==0 && !pageToDisplay.equals("newtask")){
                       %>
                       <a href="<%=request.getContextPath() %>/admin/user/defineValue.jsp?viewpage=newtask">Define New Task Value</a>&nbsp;&nbsp;&nbsp;&nbsp;
                      <%
                        }



                     %>
                 </td>
             </tr>
         </table>
        <br>
        <table align="center">
            <tr bgColor="#C3D9FF" height="9"><td><b>Status</b></td>                     <td><b>P1S1</b></td>                                                               <td><b>P1S2</b></td>                                             <td><b>P1S3</b></td>                 <td><b>P1S4</b></td>                                    <td><b>P2S1</b></td>                                                <td><b>P2S2</b></td>                                       <td><b>P2S3</b></td>                                 <td><b>P2S4</b></td>                                <td><b>P3S1</b></td>                                            <td><b>P3S2</b></td>                                    <td><b>P3S3</b></td>                                    <td><b>P3S4</b></td>                                    <td><b>P4S1</b></td>                        <td><b>P4S2</b></td><td><b>P4S3</b></td><td><b>P4S4</b></td></tr>
            <%



            for(int k=1;k<=noOfStatus;k++){


            statusName=(String)status.get(k);


            statusName=statusName.replaceAll(" ","");
            logger.info("Status Name"+statusName);
%>
<tr><td><input type="hidden" name="status<%=k%>" value="<%=k%>"/><b><%=statusName%></b></td>         <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p1s1"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p1s2"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p1s3"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p1s4"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p2s1"/></td>           <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p2s2"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p2s3"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p2s4"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p3s1"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p3s2"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p3s3"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p3s4"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p4s1"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p4s2"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p4s3"/></td>       <td><input type="text" size="1" maxlength="4"  name="<%=statusName.toLowerCase()%>p4s4"/></td></tr>
            <%}%>
            <tr><td colspan="8" align="right"><input name="submit" type="submit" value="Submit" /></td><td colspan="9" align="left"><input type="reset" name="Reset"/><input type="hidden" name="tablename" value="<%=tablename%>"/></td></tr>



        </table>
        </form>
    </body>
</html>
