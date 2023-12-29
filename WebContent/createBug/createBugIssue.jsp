<%@page import="com.eminentlabs.dao.DAOFactory"%>
<%@page import="com.eminent.issue.ApmIssueTeststepId"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@ page
    import="org.apache.log4j.*,pack.eminent.encryption.*,java.util.*,dashboard.*,com.eminent.util.*"%>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
    <%@page import="com.pack.MyAuthenticator"%>
    <HTML>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
            <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
                Solution</TITLE>
            <LINK title=STYLE
                  href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
                  type="text/css" rel="STYLESHEET">
   <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
            <script language="text/javascript">
               parent.document.getElementById("treeframe").contentWindow.location.reload();     
                  $('#progressbar').fadeIn('slow');
            </script>


        </HEAD>
        <%
            
            Logger logger = Logger.getLogger("CreateBugIssue");
            
            String logoutcheck = (String) session.getAttribute("Name");
            if (logoutcheck == null) {
                logger.fatal("=========================Session Expired======================");
        %>
        <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
        <%        
            }
        %>
        <jsp:useBean id="ic" class="com.eminent.issue.controller.IssueController"/>

        <BODY >
            <div>
                <img id="progressbar" style='display: none;' src='/eTracker/images/file-progress.gif'/>
            </div>
            
            <%        
                if (session.getAttribute("bug") == null) {
            %>
            <%@ include file="../header.jsp"%>
            <%    }
                
            %>

            <div align="center">
                <FORM name="theForm" METHOD=POST>
                    <table width="100%">

                        <%            String issueId = ic.createIssue(request, pageContext.getServletContext());
            

                        %>
                        <tr>
                            <td align="center">
                                <%       if (issueId != null || !"".equals(issueId)) {
                                %>
                                <center><FONT SIZE="4" COLOR="#0000ff">The issue has
                                        been created successfully.Issue id : <%= issueId%> </FONT>
                                   <%       if (ic.getMessage() != null) {
                                %>
                                &nbsp; <FONT SIZE="4" COLOR="red"><%=ic.getMessage()%></FONT>
                                 <%                                
                                            }                           
                                        %>
                                </center>
                                        <%                                
                                            } else{                          
                                        %>
                                        <FONT SIZE="4" COLOR="red"><%=ic.getMessage()%></FONT>
                                         <%                                
                                            }                           
                                        %>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center"><input type="button" name="close"
                                                                  value="Close" onclick="window.close()"></td>
                        </tr>

                    </table>
                    <br>

                </FORM>
            </div>
                              <script language="text/javascript">
               $('#progressbar').fadeOut('slow');       
            </script>
        </BODY>
         
    </HTML>