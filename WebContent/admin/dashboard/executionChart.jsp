<%-- 
    Document   : executionChart
    Created on : 8 Jul, 2010, 4:53:05 PM
    Author     : Tamilvelan
--%>
<%@page  import="java.math.BigDecimal,com.eminent.tqm.TqmTestcaseexecutionplan,com.eminent.tqm.TestCasePlan,dashboard.*,org.apache.log4j.*,com.eminent.util.GetProjects,com.eminent.tqm.TqmTestcasestatus,com.eminent.util.IssueDetails,java.util.*,java.util.HashMap,com.eminent.util.GetProjectManager"%>
<%
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setHeader("Pragma","no-cache");
        response.setDateHeader("Expires", 0);

        //Configuring log4j properties
     
        Logger logger       =   Logger.getLogger("Test Case Chart");
       
        String sessionCheck =   (String)session.getAttribute("Name");
        if(sessionCheck ==  null){
%>
                <jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
        }

        %>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
                <script type="text/javascript" src="<%= request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>


<script>
        function call(theForm)
			{
				var x   =   document.getElementById("planId").value;
                                var pid =   document.getElementById("pid").value;
				theForm.action='executionChart.jsp?planId='+x+'&pid='+pid;
                                theForm.submit();

			}
    </script>
    </head>
    <body>
        <%
        int noOfTestcases           =   0;
        String planId                  =   request.getParameter("planId");
        String pid                  =   request.getParameter("pid");
        logger.info("Planid--->"+planId);
        List  testCase=   TestCases.executionPlanChart(planId);
        TqmTestcaseexecutionplan plan   =   TestCasePlan.viewPlan(planId);
        int pId   =   plan.getPid();
        String planStatus   =   plan.getTqmTestcaseplanstatus().getStatus();
        String planName     =   plan.getPlanname();
        noOfTestcases           =   testCase.size();
        logger.info("No fo Modules"+noOfTestcases);
        int TotalCases      =   0;
         int closed  =   0;
         LinkedHashMap characteristics = new LinkedHashMap<String,Integer>();
        %>
        <%@ include file="/header.jsp"%>
        <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
            <tr  bgColor="#C3D9FF">
                <td  align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Test Execution Result of Test Plan - <%=planName%></b></font></td>
            </tr>
        </table>
         <table width="100%" >
            <tr><td >
<%

%>              <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pId%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pId%>">View Project Performance</a> &nbsp;&nbsp;&nbsp;
                <b><a href="<%=request.getContextPath()%>/admin/tqm/listExecutionPlan.jsp?pid=<%=pid%>">View Test Plans</a></b>

        </td>
            </tr>
        </table>
  <!--
        <table width="100%">
            <tr>

            <td width="20%"><a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=planId%>">View Project Performance</a></td>
 
   </tr>
    </table>
    -->
      
<%
        if(noOfTestcases>0){

                 Iterator iter = testCase.iterator();
                 HashMap status = new HashMap<String,Integer>();
                 String stat[] ={"Yet to Test","Not Applicable","Could Not Run","Failed","Passed"};
        while (iter.hasNext())
        {
            
            Object[] obj = (Object[]) iter.next();

                status.put((String)obj[2],(Integer)((BigDecimal)obj[0]).intValue());
                characteristics.put((String)obj[2],(Integer)((BigDecimal)obj[0]).intValue());
//                logger.info("Status-->"+((TqmTestcasestatus)obj[1]).getStatus());

        }
        for(String s:stat){
            if(!status.containsKey(s)){
                status.put(s, (Integer)(0));
                logger.info("Added"+s);
            }
        }
           
              
%>


       
    <script type="text/javascript">
                FusionCharts.ready(function() {
                    var ageGroupChart = new FusionCharts({
                        type: 'pie3d',
                        renderAt: 'chart-container2',
                        width: '850',
                        height: '500',
                        dataFormat: 'json',
                        dataSource: {
                            "chart": {
                                "caption": "Test Execution Statistics",
                                //                                    "paletteColors": "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000",
                                "bgColor": "#ffffff",
                                "use3DLighting": "0",
                                "showShadow": "0",
                                "pieslicedepth": "30",
                                "enableSmartLabels": "0",
                                "startingAngle": "0",
                                "showPercentValues": "1",
                                "showPercentInTooltip": "0",
                                "decimals": "1",
                                "captionFontSize": "14",
                                "subcaptionFontSize": "14",
                                "subcaptionFontBold": "0",
                                "toolTipColor": "#ffffff",
                                "toolTipBorderThickness": "0",
                                "toolTipBgColor": "#000000",
                                "toolTipBgAlpha": "80",
                                "toolTipBorderRadius": "2",
                                "toolTipPadding": "5",
                                "showHoverEffect": "1",
                                "showLegend": "1",
                                "legendBgColor": "#ffffff",
                                "legendBorderAlpha": '0',
                                "legendShadow": '0',
                                "legendItemFontSize": '10',
                                "legendPosition": "RIGHT",
                                "exportEnabled": "1",
                                "legendItemFontColor": '#666666'
                            },
                            "data": [
                <%
                             int k=0;
           
                for(String s:stat){
               
                 logger.info("Displayed"+stat[k]);
                 
                   if(s.equalsIgnoreCase("Passed")||s.equalsIgnoreCase("Not Applicable")){
                       closed   =   closed+((Integer)status.get(stat[k])).intValue();
                   }
                   TotalCases   =   TotalCases+((Integer)status.get(stat[k])).intValue();
                %>
                                {
                                    "label": "<%=stat[k]%>",
                                    "value": "<%= status.get(stat[k])%>",
                                    "link": '<%=request.getContextPath()%>/admin/dashboard/listTestcaseStatus.jsp?status=<%= stat[k]%>&planId=<%=planId%>'
                                                        },
                <%k++;}%>
                                                    ]
                                                }
                                            }
                                            );
                                            ageGroupChart.render();
                                        });</script>
    <div id="chart-container2" class="chartarea">FusionCharts XT will load here!</div>
<%
        }else{
%>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<table cellpadding="0" cellspacing="0" width="100%" datapagesize="25">
                    <tr>
                        <td  align="center" width="100%"><font size="4" COLOR="#0000FF"><b>No Test Cases Available</b></font></td>
                    </tr>
                </table>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%
        }
%>
<form name="theForm" onSubmit='return fun(this)'>
<table width="100%" bgcolor="#C3D9FF">
            <tr align="left">

                <td><input type="hidden" name="pid" id="pid" value="<%=pid%>"><b>Test Execution Plan    </b>  :
                
                       <select id="planId" name="planId" size=1 onchange="javascript:call(this.form)">


				<%
                                        //Getting User Id and Role
                                        Integer role  = (Integer)session.getAttribute("Role");
                                        Integer uid   = (Integer)session.getAttribute("userid_curr");
                                        int roleValue = role.intValue();
                                        int uidValue  = uid.intValue();

                                        //Displaying all the projects for Admin role
                                            HashMap <String,String> planList = null;
                                       /*
                                            if(roleValue == 1) {
                                                planList = TestCasePlan.listAdminExecutionPlan();
                                            }else{
                                        //Displaying only assigned projects to other roles
                                                planList = TestCasePlan.listUserExecutionPlan(uidValue);
                                            }
                                       */
                                        if(pid!=null){
                                            planList   =   TestCasePlan.listProjectExecutionPlan(pid);
                                        }else if(roleValue==1){
                                              planList = TestCasePlan.listAdminExecutionPlan();
                                        }
                                        else{
                                             planList = TestCasePlan.listUserExecutionPlan(uidValue);
                                        }

                    Collection se=planList.keySet();
                    Iterator iter=se.iterator();
                    int projectId   =   0;
		    while (iter.hasNext()) {

		      String key=(String)iter.next();
		      String nameofproject=(String)planList.get(key);
		//      logger.info("Userid"+key);
		//      logger.info("Name"+nameofuser);
		      projectId=Integer.parseInt(key);
				if (projectId==Integer.parseInt(planId))
   				{

%>
			<option value="<%=planId%>" selected><%=nameofproject%></option>
			<%
			}
			else
			{

%>
			<option value="<%=projectId%>"><%=nameofproject%></option>
			<%
			}

		    }
                   int f=0;
                    if(TotalCases>0){
                        f =   ((closed*100)/TotalCases);
                    }
                 
%>
                </select>
                </td>
                <td ><b>Status :</b> <%=planStatus%></td>
               
                 <%
                 Collection set=characteristics.keySet();
                    Iterator itera=set.iterator();

		    while (itera.hasNext()) {

		      String key=(String)itera.next();
		      int nameofproject=(Integer)characteristics.get(key);
		      logger.info("Userid"+key);
		//      logger.info("Name"+nameofuser);
		      

%>
			<td ><b><%=key%>  :</b> <%=nameofproject%></td>
			<%

		    }
                    %>
                <td ><b>Completion  :</b> <%=f%> %</td>
              
                
            </tr>
        </table>
</form>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
    </body>
</html>
