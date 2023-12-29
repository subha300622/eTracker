<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>
<%

    Logger logger = Logger.getLogger("moduleupdate");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>
    </head>

    <body>

        <table width="100%" bgcolor="#EEEEEE" valign="right" height="5%"
               border="0">

            <tr>
                <td border="0" align="left" width="800"><b><font size="3"
                                                                 COLOR="#0000FF"> Current User: </font></b><FONT SIZE="3" COLOR="#0000FF">
                        &nbsp;<b>&nbsp;<%=session.getAttribute("fName")%>&nbsp; <%=session.getAttribute("lName")%>
                        </b></FONT></td>

                <td width="6%" border="1" align="center"><font size="2"
                                                               face="Verdana, Arial, Helvetica, sans-serif"> <a
                            href="<%=request.getContextPath()%>/profile.jsp">Profile</a></font></td>

                <td width="6%" align="center" border="1"><font size="2"
                                                               face="Verdana, Arial, Helvetica, sans-serif"> <A
                            HREF="<%= request.getContextPath()%>/logout.jsp" target="_parent">Logout</A></font>
                </td>


                <jsp:useBean id="apmController" class="com.pack.controller.AdminEditModuleController" />

                <%
                    /*	int mid=Integer.parseInt(request.getParameter("mid"));
                     String module=request.getParameter("module");
                     String customerOwner=request.getParameter("customerOwner");
                     String internalOwner=request.getParameter("internalOwner");
                
                     int cOwner=0;
                     int iOwner=0;
                     if(customerOwner!=null && customerOwner.length()!=0){
                     cOwner=Integer.parseInt(customerOwner);
                            
                     }if(internalOwner!=null && internalOwner.length()!=0){
                     iOwner=Integer.parseInt(internalOwner);
                     }
                     if( module != null) {
                     module = module.trim();
                     }
                     int pid=Integer.parseInt(request.getParameter("pid"));

                     logger.info("Module Id"+mid);
                     logger.info("Project Id"+pid);
                     logger.info("Module Name"+module);

                     Connection connection = null;
                     try  {
                     connection=MakeConnection.getConnection();
                     if(connection != null)  {
				
                     Admin.ModuleUpdate(connection,mid,module,cOwner,iOwner, pid);
                     */
                    apmController.setAllModuleByProject(request);
                %>

                <jsp:forward page="/admin/project/viewmodules.jsp" />



            </tr>

        </table>

        <br>
    </body>

</html>