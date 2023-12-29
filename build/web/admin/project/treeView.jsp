<%-- 
    Document   : treeView
    Created on : 15 Oct, 2011, 7:41:07 PM
    Author     : Tamilvelan
--%>
<%@page import="org.apache.log4j.Logger,com.eminent.examples.ShowBPM" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
                response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma","no-cache");

	
	Logger logger = Logger.getLogger("ViewProject");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
	%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
	}
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.treeview.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/screen.css" />
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.cookie.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.treeview.js" type="text/javascript"></script>

<script type="text/javascript">
		$(function() {
			$("#tree").treeview({
				collapsed: true,
				animated: "medium",
				control:"#sidetreecontrol",
				persist: "location"
			});
		})

	</script>
    </head>
    <body>
        <%@ include file="/header.jsp"%>

<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr >
		<td border="1" align="left" width="100%"><font size="4"
			COLOR="#0000FF"><b>Project Test View</b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
       
<div id="main">

<div id="sidetree">
<div class="treeheader">&nbsp;</div>
<div id="sidetreecontrol"><a href="?#">Collapse All</a> | <a href="?#">Expand All</a></div>

<ul id="tree">
	<li><a href="#"><strong>Bosch</strong></a>
	<ul>
		<li><a href="#">RBEI </a>
                    <ul>
                        <li>
                            Business Process
                            <ul>
                                <li>Main Process 1
                                    <ul>
                                        <li>Sub Process 1
                                            <ul>
                                                <li>
                                                    Scenario 1
                                                    <ul>
                                                        <li>
                                                            Variant 1
                                                            <ul>
                                                                <li>
                                                                    Test Case 1
                                                                    <ul>
                                                                        <li>
                                                                            Test Step 1
                                                                            <ul>
                                                                                <li>Test Script 1
                                                                                    <ul>
                                                                                        <li>
                                                                                            <table>
                                                                                                <tr>
                                                                                            <td>Functionality1</td>
                                                                                            <td>Description1</td>
                                                                                            <td>Expected Result1</td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                            <td>Functionality2</td>
                                                                                            <td>Description2</td>
                                                                                            <td>Expected Result2</td>
                                                                                            </tr>
                                                                                            </table>
                                                                                        </li>
                                                                                        
                                                                                    </ul>
                                                                                </li>
                                                                                <li>Test Script 2</li>
                                                                            </ul>

                                                                        </li>
                                                                        <li>Test Step 2</li>
                                                                        <li>Test Step 3</li>
                                                                        <li>Test Step 4</li>
                                                                    </ul>
                                                                </li>
                                                                <li>Test Case 2</li>
                                                                <li>Test Case 3</li>
                                                                <li>Test Case 4</li>
                                                            </ul>
                                                        </li>
                                                        <li>Variant 2</li>
                                                        <li>Variant 3</li>
                                                        <li>Variant 4</li>
                                                    </ul>
                                                </li>
                                                <li>Scenario 2</li>
                                                <li>Scenario 2</li>
                                            </ul>
                                        </li>
                                        <li>Sub Process 2</li>
                                        <li>Sub Process 3</li>
                                    </ul>
                                </li>
                                <li>Main Process 2</li>
                                <li>Main Process 3</li>
                                <li>Main Process 4</li>
                            </ul>
                        </li>
                        <li>
                            Trading
                        </li>
                        <li>Import</li>
                         <li>Export</li>
                    </ul>

                </li>
                <li><a href="?/enewsletters/index.cfm">RBIN </a>
                    <ul>
                        <li>
                            Business Process
                            <ul>
                                <li>Main Process
                                    <ul>
                                        <li>Sub Process
                                            <ul>
                                                <li>
                                                    Scenario
                                                    <ul>
                                                        <li>
                                                            Variant
                                                            <ul>
                                                                <li>
                                                                    Test Case
                                                                    <ul>
                                                                        <li>
                                                                            Test Step
                                                                            <ul>
                                                                                <li>Test Script
                                                                                    <ul>
                                                                                        <li></li>
                                                                                    </ul>
                                                                                </li>
                                                                            </ul>
                                                                        </li>
                                                                    </ul>
                                                                </li>
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>

                </li>
		

	</ul>
	</li>

<%
    HashMap client  =   ShowBPM.getClient();
    Collection se=client.keySet();
    Iterator iter=se.iterator();
    while (iter.hasNext()) {
         int key=(Integer)iter.next();
	  String nameofClient=(String)client.get(key);
    %>
    <li>
        <%=nameofClient%>
        <%
            HashMap company =   ShowBPM.getCompany(key);
            if(company.size()>0){
              %>
              <ul>
              <%
                Collection comp=company.keySet();
                Iterator Comp_iter=comp.iterator();
                while (Comp_iter.hasNext()) {
                     int comp_key=(Integer)Comp_iter.next();
                     String nameofCompany=(String)company.get(comp_key);
                     %>
                      <li>
                        <%=nameofCompany%>
                        <%
                            HashMap bp =   ShowBPM.getBP(comp_key);
                            if(bp.size()>0){
                              %>
                              <ul>
                              <%
                                Collection bp_col=bp.keySet();
                                Iterator bp_iter=bp_col.iterator();
                                while (bp_iter.hasNext()) {
                                     int bp_key=(Integer)bp_iter.next();
                                     String nameofBP=(String)bp.get(bp_key);
                                     %>
                                      <li>
                                        <%=nameofBP%>
                                        <%
                                            HashMap mp =   ShowBPM.getMP(bp_key);
                                            if(mp.size()>0){
                                              %>
                                              <ul>
                                              <%
                                                Collection mp_col=mp.keySet();
                                                Iterator mp_iter=mp_col.iterator();
                                                while (mp_iter.hasNext()) {
                                                     int mp_key=(Integer)mp_iter.next();
                                                     String nameofMP=(String)mp.get(mp_key);
                                                     %>
                                                      <li>
                                                        <%=nameofMP%>
                                                        <%
                                                           HashMap sp =   ShowBPM.getSP(bp_key);
                                                            if(sp.size()>0){
                                                              %>
                                                              <ul>
                                                              <%
                                                                Collection sp_col=sp.keySet();
                                                                Iterator sp_iter=sp_col.iterator();
                                                                while (sp_iter.hasNext()) {
                                                                     int sp_key=(Integer)sp_iter.next();
                                                                     String nameofSP=(String)sp.get(sp_key);
                                                                     %>
                                                                      <li>
                                                                        <%=nameofSP%>
                                                                        <%
                                                                           HashMap scenario =   ShowBPM.getScenario(sp_key);
                                                                            if(scenario.size()>0){
                                                                              %>
                                                                              <ul>
                                                                              <%
                                                                                Collection scenario_col=scenario.keySet();
                                                                                Iterator scenario_iter=scenario_col.iterator();
                                                                                while (scenario_iter.hasNext()) {
                                                                                     int scenario_key=(Integer)scenario_iter.next();
                                                                                     String nameofScenario=(String)scenario.get(scenario_key);
                                                                                     %>
                                                                                      <li>
                                                                                        <%=nameofScenario%>
                                                                                         <%
                                                                                           HashMap variant =   ShowBPM.getVariant(scenario_key);
                                                                                            if(variant.size()>0){
                                                                                              %>
                                                                                              <ul>
                                                                                              <%
                                                                                                Collection variant_col=variant.keySet();
                                                                                                Iterator variant_iter=variant_col.iterator();
                                                                                                while (variant_iter.hasNext()) {
                                                                                                     int variant_key=(Integer)variant_iter.next();
                                                                                                     String nameofVariant=(String)variant.get(variant_key);
                                                                                                     %>
                                                                                                      <li>
                                                                                                        <%=nameofVariant%>
                                                                                                      </li>
                                                                                                     <%
                                                                                                  }
                                                                                                %>
                                                                                              </ul>
                                                                                                <%
                                                                                            }
                                                                                        %>
                                                                                      </li>
                                                                                     <%
                                                                                  }
                                                                                %>
                                                                              </ul>
                                                                                <%
                                                                            }
                                                                        %>
                                                                      </li>
                                                                     <%
                                                                  }
                                                                %>
                                                              </ul>
                                                                <%
                                                            }
                                                        %>
                                                      </li>
                                                     <%
                                                  }
                                                %>
                                              </ul>
                                                <%
                                            }
                                        %>
                                      </li>
                                     <%
                                  }
                                %>
                              </ul>
                                <%
                            }
                        %>
                      </li>
                     <%
                  }
                %>
              </ul>
                <%
            }
        %>
    </li>
    <%
    }
%>
</ul>

</div>

</div>

    </body>
</html>
