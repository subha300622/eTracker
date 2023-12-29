<%-- 
    Document   : demoProjects
    Created on : 24 Oct, 2023, 11:39:41 AM
    Author     : DhanVa CompuTers
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=17" type="text/css" rel="STYLESHEET"/>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>   
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/cupertino/jquery-ui.css">
    <script src="<%=request.getContextPath()%>/javaScript/widget-filter-formatter-jui.js"></script>
</head>
<body>
    <%@ include file="/header.jsp"%>
    <br/>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Demo Project</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <br/>
    <table width="100%" border="0">
        <tr>
            <td><a
                    href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add
                    Project</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainWrmDays.jsp" >WRM Days</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp" >Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;">Gantt Chart</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="font-weight: bold;">Demo(11)</a>
                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;">Daywise E-Invoice</a>  
            </td>
            <td></td>

        </tr>
    </table>
    <br/>
    <div class="tablecontent">
        <table id='trFormatTable' class="tablesorter"><thead>
                <tr  height="21" style="font-weight: bold;background-color: #C3D9FF;">
                    <td width="2%">S</td>
                    <td width="10%" class="filter-select filter-match" data-placeholder="Select a Project">Project</td>
                    <td width="20%">Credential</td>
                    <td width="10%" class="filter-select filter-match" data-placeholder="Select a Interface">Interface</td>
                    <td width="43%">Scope of work</td>
                    <td width="5%" class="filter-false" title="Technical Specification Document">TSD</td>
                    <td width="5%" class="filter-false" title="Functional Specification Document">FSD</td>
                    <td width="5%" class="filter-false" title="User Manual">UM</td>
                </tr>
            </thead>
            <tbody>
                <tr  class="zebralinealter"   height="21">
                    <td class="background" width="2%">1</td>
                    <td class="background" width="10%"><a href="http://eminentlabs-q.net/CKCS/search.jsp" target="_blank">EInvoice</a></td>
                    <td class="background" width="20%">No Login required</td>
                    <td class="background" width="10%">Webservice</td>
                    <td class="background" width="43%"> 1) Manage authentication<br></br>
                        2) Generate IRN<br></br>
                        3) Cancel IRN<br></br>
                        4) Display IRN<br></br>
                        5) Generate eway bill with IRN<br></br>
                    </td>
                    <td class="background" width="5%"><a href="https://docs.google.com/document/d/1nQ9beyb3kDj5eONBuJQdGzBqcrM2mNBpkhOPrCddYZg/edit" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                    <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                    <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                </tr>
                <tr  class="zebralinealter"   height="21">
                    <td class="background" width="2%">2</td>
                    <td class="background" width="10%"><a href="http://eminentlabs-q.net/CKCS/search.jsp" target="_blank">Eway Bill</a></td>
                    <td class="background" width="20%">No Login required</td>
                    <td class="background" width="10%">Webservice</td>
                    <td class="background" width="43%">1) Manage authentication<br></br>
                                                       2) Generate eway bill<br></br>
                                                       3) Display eway bill<br></br>
                                                       4) Cancel eway bill<br></br> 
                                                       5) Update transporter<br></br> 
                                                       6) Extend validity<br></br>
                    </td>
                    <td class="background" width="5%"><a href="https://docs.google.com/document/d/1nQ9beyb3kDj5eONBuJQdGzBqcrM2mNBpkhOPrCddYZg/edit" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                    <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                    <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                </tr>
                <tr  class="zebralinealter"   height="21">
                    <td class="background" width="2%">3</td>
                    <td class="background" width="10%"><a href="http://eminentlabs-q.net/CKCS/search.jsp" target="_blank">GST Filing</a></td>
                    <td class="background" width="20%">No Login required</td>
                    <td class="background" width="10%">Webservice</td>
                    <td class="background" width="45%">1) Manage authentication<br></br>
                        2) GSTR 1 filing<br></br>
                        3) GSTR 2b reconcilation<br></br>
                        4) GSTR 3b<br></br>
                        5) GSTR 6<br></br>
                        6) GSTR 9<br></br>
                    </td>
                    <td class="background" width="5%"><a href="https://docs.google.com/document/d/1nQ9beyb3kDj5eONBuJQdGzBqcrM2mNBpkhOPrCddYZg/edit" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                    <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                    <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                </tr>
                <tr  class="zebralinealter"   height="21">
                    <td class="background" width="2%">4</td>
                    <td class="background" width="10%"><a href="http://eminentlabs-q.net/CKCS/search.jsp" target="_blank">CKCS-Feedback</a></td>
                    <td class="background" width="20%">No Login required</td>
                    <td class="background" width="10%">Webservice</td>
                    <td class="background" width="43%">
                        1) Getting the customer feedback with reference to invoice.<br></br>
                        2) Syncing the customer's feedback to SAP.<br></br>
                    </td>
                    <td class="background" width="5%"><a href="https://docs.google.com/document/d/1nQ9beyb3kDj5eONBuJQdGzBqcrM2mNBpkhOPrCddYZg/edit" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                    <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                    <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-CKCS-Feedback"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                </tr>
                <tr  class="zebraline" bgcolor="#E8EEF7" height="21">
                    <td class="background" width="2%">5</td>
                    <td class="background" width="10%"><a href="http://eminentlabs-q.net/CKCS-ECOM/PriceSyncServiceImplService?" target="_blank">CKCS-Ecomm</a></td>
                    <td class="background"  width="20%">No Login required</a></td>
                    <td class="background" width="10%">Webservice</td>
                    <td class="background" width="43%">
                        1)Converting the ECOMM REST APIs to SOAP Webservice.<br></br> 

                    </td>
                    <td class="background" width="5%"><a href="https://docs.google.com/document/d/1CRpMhYchbw20U0PfH2eRulibKfJ3L4eqGURXa0j4HrY/edit" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-CKCS-Ecomm"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                    <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-CKCS-Ecomm"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                    <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-CKCS-Ecomm"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                </tr>
                <tr  class="zebralinealter"  height="21">
                    <td class="background" width="2%">6</td>
                    <td class="background" width="10%"><a href="http://eminentlabs-q.net/Schenck/login" target="_blank">Schecnk-Timesheet</a></td>
                    <td class="background" width="20%"><p><u>Admin - Login</u><br>
            Username – admin@schenckprocess.com<br>
            Password – P0rtal@2022<br>
            <u>HR – Login</u><br>
            Username – h.maruti@schenckprocess.com<br>
            Password – Schenck@2022	</p>
            </td>
            <td class="background" width="10%">SAP-Process Orchestration</td>
            <td class="background" width="43%">
                1) Syncing the bio-metric attendance  data from file to SAP.<br></br>
                2) Adding/Updating the attendance data for missed bio-metric data.<br></br>
                3) Approval for attendance.<br></br>
                4) Timesheet entry for attendance hours.<br></br>
                5) Approval for timesheet.<br></br>
                6) Timesheet report.<br></br>
                7) Daywise timesheet report.<br></br>
                8) Attendance Vs timesheet report.<br></br>
                9) Sales Order approval.<br></br>
                10) Purchase Order approval.<br></br>
            </td>
            <td class="background" width="5%"><a href="https://docs.google.com/document/d/1apJ5I8gj0ZkEIyDpHil85vLjpes2-FCSwSwpcMlCBVg/edit" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-Schecnk-Timesheet"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
            <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-Schecnk-Timesheet"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-Schecnk-Timesheet"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            </tr>       
            <tr  class="zebraline"  height="21">
                <td class="background" width="2%">7</td>
                <td class="background" width="10%" ><a href="http://eminentlabs-q.net/GEECL/login" target="_blank">GEECL</a></td>
                <td class="background" width="20%"><p>Username – admin/HR_WRITE/HR_READ<br>

                        Password – Geecl@2019</p>
                </td>
                <td class="background" width="10%">Remote Function Call</td>
                <td class="background" width="43%">
                    1) Confidential document can be uploaded to the particular users.<br></br>
                    2) Uploaded Document can be viewed by the particular users.<br></br>
                </td>
                <td class="background" width="5%"><a href="https://docs.google.com/document/d/1_6aMUY4XDdLj3WtNZyGUadvVKq0-_f2mtzfmLelwsE4/edit" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-GEECL"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-GEECL"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-GEECL"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            </tr>
            <tr  class="zebralinealter"  height="21">
                <td class="background" width="2%">8</td>
                <td class="background"width="10%"><a href="http://eminentlabs-q.net/LBIDealerPortal/login" target="_blank">LBI-Dealer Portal</a></td>
                <td class="background" width="20%"><p>

                        Username – admin<br>
                        Password – Lbi@1234</p></td>
                <td class="background" width="10%">SAP-Process Orchestration</td>
                <td class="background" width="43%">
                    1) SAP service notification creation for customer complaint.<br></br>
                    2) SAP service order creation when assigned to service engineer.<br></br>
                    3) Parts approval.<br></br>
                    4) Customer feedback while closing the service.<br></br>
                    5) Sales order creation for finished product and spart parts.<br></br>
                    6) Displaying 2 SAP reports.<br></br>
                </td>
                <td class="background" width="5%"><a href="https://docs.google.com/document/d/1IuBoUIKQOQAW0bfIA2u-j_T0xlTK-bwijnI8_whUwpg/edit" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-LBI-Dealer Portal"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-LBI-Dealer Portal"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-LBI-Dealer Portal"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            </tr>       
            <tr  class="zebraline"  height="21">
                <td class="background" width="2%">9</td>
                <td class="background" width="10%"><a href="http://eminentlabs-q.net/MIS" target="_blank">LBI-MIS</a></td>
                <td class="background" width="20%"><p>

                        Username – admin<br>
                        Password - Lbi@1234</p>
                </td>
                <td class="background" width="10%">SAP-Process Orchestration</td>
                <td class="background" width="43%">
                    1) Displaying the 19 SAP reports.<br></br>
                    2) Confidential document can be uploaded to the particular users.<br></br> 
                    3) Uploaded Document can be viewed by the particular users.<br></br>
                    4) Financial reports data can be maintained for month wise.<br></br> 
                </td>

                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-LBI-MIS"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-LBI-MIS"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-LBI-MIS"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            </tr>
            <tr  class="zebraline"  height="21">
                <td class="background" width="2%">10</td>
                <td class="background" width="10%"><a href="http://eminentlabs-q.net/SBPL" target="_blank">SBPL</a></td>
                <td class="background" width="20%"><p><u>Admin - Login</u><br>

            Username – admin<br>
            Password – sbpl@2015<br>
            <u>Level one – Service Head</u><br>
            Username – Tamilmani<br>
            Password – sbpl@2015<br>
            <u>Level two – Management</u><br>
            Username – Umesh<br>
            Password – sbpl@2015</p>
            </td>
            <td class="background" width="10%">Remote Function Call</td>
            <td class="background" width="43%">
                1) Syncing the SAP serial master from SAP.<br></br>
                2) Capture new sales for customer.<br></br>
                3) Complaint regsiter.<br></br>
                4) Approval for complaint register.<br></br>
                5) SBPL/Dealer replacement for approved complaint.<br></br>
                6) Warranty extension.<br></br> 
                7) Approval for warranty extension.<br></br>
                8) Displaying 2 SAP reports.<br></br>
            </td>
            <td class="background" width="5%"><a href="https://docs.google.com/document/d/17egJb8P-bt_3inF4W9EqiY8ofWP0piKSnXqpoO5EtzY/edit" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-SBPL"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
            <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-SBPL"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-SBPL"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            </tr>       
            <tr  class="zebralinealter"  height="21">
                <td class="background" width="2%">11</td>
                <td class="background" width="10%"><a href="http://eminentlabs-q.net/YILLM/Login.jsp" target="_blank">Yuken</a></td>
                <td class="background" width="20%"><p><u>Admin - Login</u><br>

            Username – 99999999<br>
            Password – yuken@2015<br>
            <u>Employee - Login</u><br>
            Username – 40<br>
            Password - yuken@2015</p>
            </td>
            <td class="background" width="10%">Remote Function Call</td>
            <td class="background" width="43%">
                1) Syncing the SAP employees.<br></br>
                2)  Leave creation.<br></br> 
                3) Leave approval.<br></br>
                4) Syncing approved leaves to SAP.<br></br>
            </td>
            <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-Yuken"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
            <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-Yuken"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-Yuken"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            </tr>
            <tr  class="zebraline"  height="21">
                <td class="background" width="2%">12</td>
                <td class="background" width="10%"><a href="http://eminentlabs-q.net/BGL/login" target="_blank">BGL</a></td>
                <td class="background" width="20%"><p>

                        Username – admin<br>
                        Password – admin@2016</p>
                </td>
                <td class="background" width="10%">Remote Function Call</td>
                <td class="background" width="43%">
                    1) Displaying the 2 SAP reports.
                </td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-BGL"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-BGL"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-BGL"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            </tr>       
            <tr  class="zebralinealter"  height="21">
                <td class="background" width="2%">13</td>
                <td class="background" width="10%"><a href="http://eminentlabs-q.net/DBTPortal/login" target="_blank">Adventz</a></td>
                <td class="background" width="20%"><p>

                        Username – admin<br>
                        Password – admin@2016</p>
                </td>
                <td class="background" width="10%">SAP-Process Orchestration</td>
                <td class="background" width="43%">
                    1) Syncing the SAP Dealers and SAP Company Sales.<br></br>
                    2) Uploading the IFMS sales and Wholesaler sales.<br></br>
                    3) Uploading the Stock and STO and Wholesaler Recon Stock.<br></br>
                    4) Sales reports for SAP vs IFMS by statewise, dirscritwise,regionwise, dealerwise and groupwise.<br></br>
                    5) Retailer sales reports by statewise, dirscritwise,regionwise, dealerwise and groupwise.<br></br>
                    6) Wholesales sales reports by statewise, dirscritwise,regionwise, dealerwise and groupwise.<br></br>
                    7) Retailer Sales Recon reports by statewise, dirscritwise,regionwise, dealerwise and groupwise.<br></br>
                    8) Wholesaler Sales Recon reports by statewise, dirscritwise,regionwise, dealerwise and groupwise.<br></br>
                    9) CO-WS-RT Pending Acknowledgment reports by statewise, dirscritwise,regionwise, dealerwise.<br></br>
                    10) WS-RT Pending Acknowledgment reports by statewise, dirscritwise,regionwise, dealerwise and groupwise.<br></br>
                    11) STO Balanace reports by statewise, dirscritwise,regionwise.<br></br>
                    12) Retailer Stock reports by statewise, dirscritwise,regionwise, dealerwise and groupwise.<br></br>
                    13) Wholesaler Stock reports by statewise, dirscritwise,regionwise, dealerwise and groupwise.<br></br>
                    14) Retailer Physical Stock reports by statewise, dirscritwise,regionwise, dealerwise and groupwise.<br></br>
                    15) Wholesaler Physical Stock reports by statewise, dirscritwise,regionwise, dealerwise and groupwise.<br></br>
                </td>                              
                <td class="background" width="5%"><a href="https://docs.google.com/document/d/1GYlY4N3YJlCIHGV56a0qI7m4l5RZstU-qyey0w8htuk/edit" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-Adventz"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-Adventz"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-Adventz"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            </tr>       
            <tr  class="zebraline"  height="21">
                <td class="background" width="2%">14</td>
                <td class="background" width="10%"><a href="http://eminentlabs-q.net/Luminous/" target="_blank">Luminous</a></td>
                <td class="background" width="20%">No Login required</td>
                <td class="background" width="10%">Remote Function Call</td>
                <td class="background" width="43%">
                    1) Customized SAP netweaver Login screen.<br></br>
                    2) Sales order creation for dealer.<br></br>
                    3) Capturing Secondary Sales.<br></br> 
                    4) Warranty Registration.<br></br>
                    5) Displaying 5 SAP reports.<br></br>

                </td>
                <td class="background" width="5%"><a href="" target="_blank"> <img src="<%=request.getContextPath()%>/images/tech_img_.png"  title="TSD-Luminous"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/fun_img_.png"  title="FSD-Luminous"  style="cursor: pointer;width: 40px;height: 40px;"/> </a></td>
                <td class="background" width="5%"><a href="#" target="_blank"> <img src="<%=request.getContextPath()%>/images/user_manual_.png"  title="UM-Luminous"  style="cursor: pointer;width: 40px;height: 40px"/> </a></td>
            </tr>
            </tbody>
        </table>
    </div>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=16110202">
    <script type="text/javascript">


        $(document).ready(function() {

            $("#trFormatTable").tablesorter({
                theme: 'blue',
                // hidden filter input/selects will resize the columns, so try to minimize the change
                widthFixed: true,
                // initialize zebra striping and filter widgets
                widgets: ["zebra", "filter"],
                widgetOptions: {
                    // extra css class applied to the table row containing the filters & the inputs within that row
                    filter_cssFilter: 'tablesorter-filter',
                    // If there are child rows in the table (rows with class name from "cssChildRow" option)
                    // and this option is true and a match is found anywhere in the child row, then it will make that row
                    // visible; default is false
                    filter_childRows: false,
                    // if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                    // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                    filter_hideFilters: false,
                    // Set this option to false to make the searches case sensitive
                    filter_ignoreCase: true,
                    // jQuery selector string of an element used to reset the filters
                    filter_reset: '.reset',
                    // Use the $.tablesorter.storage utility to save the most recent filters
                    filter_saveFilters: false,
                    // Delay in milliseconds before the filter widget starts searching; This option prevents searching for
                    // every character while typing and should make searching large tables faster.
                    filter_searchDelay: 300,
                    // Set this option to true to use the filter to find text from the start of the column
                    // So typing in "a" will find "albert" but not "frank", both have a's; default is false
                    filter_startsWith: false,
                    // if false, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                    // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                    // Add select box to 4th column (zero-based index)
                    // each option has an associated function that returns a boolean
                    // function variables:
                    // e = exact text from cell
                    // n = normalized value returned by the column parser
                    // f = search filter input value
                    // i = column index
                    filter_functions: {
                    }

                }

            });

        });



    </script>
</body>
</html>
