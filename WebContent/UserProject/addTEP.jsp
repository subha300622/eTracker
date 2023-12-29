<%-- 
    Document   : addTEP
    Created on : 6 Jul, 2010, 8:54:47 AM
    Author     : Tamilvelan
--%>
<%@page  import="dashboard.CheckCategory,com.pack.StringUtil,org.apache.log4j.*,java.util.LinkedHashMap,java.util.List,java.util.HashMap,java.util.Map,java.util.Iterator,com.eminent.tqm.TqmPtcm,com.eminent.tqm.TestCasePlan,com.eminent.util.GetProjectMembers,com.eminent.util.GetProjects,com.eminent.util.GetProjectManager,java.text.SimpleDateFormat"%>
<%
//Configuring log4j properties

    Logger logger = Logger.getLogger("addTEP");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>

<%@ include file="/header.jsp"%>

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">

        <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue.css">



        <script type="text/javascript">
            function setAllforAssigned() {

                var form = 'theForm';
                var len = document.theForm.elements.length;
                var i = 0;
                var flag = false;
                var assign;
                var set = true;
                var rows = document.getElementById('filtersort').getElementsByTagName('tr');
                for (var m = 2; m < rows.length; m++) {
                    var box = (m * 3) + 3;
                    if (rows[m].className === 'odd' || rows[m].className === 'even') {
                        if (document.theForm.elements[box].checked) {
                            if (set === true) {
                                assign = document.theForm.elements[box + 2].value;
                                set = false;
                            }
                        }
                    }
                }
                for (i = 0; i < len; i++) {
                    if ((document.theForm.elements[i].name == 'ptcid') && (document.theForm.elements[i].checked == 1)) {
                        flag = true;
                    }
                }

                if (flag == true) {
                } else {
                    alert("Please select atleast one record to approve");
                    return false;
                }

                if (set === true) {
                    if (assign === '' || assign === '--Select One--' || assign === 'undefined') {
                        alert('Please select first row assignedTo');
                        return false;
                    }
                } else {
                    if (assign === '' || assign === '--Select One--' || assign === 'undefined') {
                        alert('Please select first row assignedTo');
                        return false;
                    } else {
                        for (var m = 0; m < rows.length; m++) {
                            var box = (m * 3) + 3;
                            if (rows[m].className === 'odd' || rows[m].className === 'even') {
                                if (document.theForm.elements[box].checked) {
                                    document.theForm.elements[box + 2].value = assign;
                                }
                            }
                        }
                    }
                }
            }
            function resetAllforAssigned() {
                var rows = document.getElementById('filtersort').getElementsByTagName('tr');
                for (var m = 2; m < rows.length; m++) {
                    var box = (m * 3) + 3;
                    if (rows[m].className === 'odd' || rows[m].className === 'even') {

                        document.theForm.elements[box + 2].value = "--Select One--";

                    }
                }
            }

            function call(Form)
            {
                var x = document.getElementById("createdby").value;
                var pidValue = document.getElementById("pid").value;
                var edate = document.getElementById("edate").value;
                var tepId = document.getElementById("tepId").value;
                Form.action = 'addTEP.jsp?createdby=' + x + '&pid=' + pidValue + '&edate=' + edate + '&tepId=' + tepId;
                Form.submit();
            }

            function SetChecked()
            {
                //$('input:checkbox').removeAttr('checked');
                var test1 = $("tr[class=odd] input:checkbox");
                var testeven = $("tr[class=even] input:checkbox");
                var rowslen = test1.length;
                var testevenlen = testeven.length;
                for (var m = 0; m < rowslen; m++) {
                    test1[m].checked = true;
                }
                for (var m = 0; m < testevenlen; m++) {
                    testeven[m].checked = true;
                }
            }

            function resetChecked() {
                var test1 = $("tr[class=odd] input:checkbox");
                var testeven = $("tr[class=even] input:checkbox");
                var rowslen = test1.length;
                var testevenlen = testeven.length;
                for (var m = 0; m < rowslen; m++) {
                    test1[m].checked = false;
                }
                for (var m = 0; m < testevenlen; m++) {
                    testeven[m].checked = false;
                }
            }

            function validate() {

                var rows = document.getElementById('tablesorter').getElementsByTagName('tr');
                for (var v = 0; v < rows.legnth; v++) {
                    if ($("#" + rows[v] + " input:checkbox")[0].checked) {
                        alert('checked : ' + checked);
                    }
                }

                return false;
            }

            function ValidateForm(dml, chkName)
            {
                var form = 'theForm';
                var len = document.theForm.elements.length;
                //        alert(len);

                var i = 0;
                var flag = false;
                for (i = 0; i < len; i++) {

                    if ((document.theForm.elements[i].name == chkName) && (document.theForm.elements[i].checked == 1)) {

                        flag = true;
                    }

                }

                if (flag == true) {

                    count = (document.theForm.elements.length - 3) / 3;
                    check = true;
                    for (j = 0; j < count; j++) {
                        var box = (j * 3) + 3;
                        if ((document.theForm.elements[box].id === 'ptcid') && (document.theForm.elements[box].checked)) {

                            if (document.theForm.elements[box + 2].value === "--Select One--") {

                                alert('Please select Assigned To for the selected Test Cases');
                                document.theForm.elements[box + 2].focus();
                                return false;
                            }
                            /*             if (document.pid.elements[box-1].value=="--Select--") {
                             
                             check = false;
                             }
                             */
                        }
                    }



                } else {
                    alert("Please select at least one record to approve");
                    return false;
                }


                monitorSubmit();
            }
        </script>

        <script type="text/javascript">
            $(function () {
                // call the tablesorter plugin
                $("#filtersort").tablesorter({
                    theme: 'blue',
                    // hidden filter input/selects will resize the columns, so try to minimize the change
                    widthFixed: true,
                    // initialize zebra striping and filter widgets
                    widgets: ["zebra", "filter"],
                    // headers: { 5: { sorter: false, filter: false } },

                    widgetOptions: {
                        // extra css class applied to the table row containing the filters & the inputs within that row
                        filter_cssFilter: 'tablesorter-filter',
                        // If there are child rows in the table (rows with class name from "cssChildRow" option)
                        // and this option is true and a match is found anywhere in the child row, then it will make that row
                        // visible; default is false
                        filter_childRows: false,
                        // if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                        // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                        filter_hideFilters: true,
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
            });</script>

    </head>
    <body>
        <%
            String pid = request.getParameter("pid");
            String createdby = request.getParameter("createdby");
            if (createdby == null) {
                createdby = "null";
            }
            LinkedHashMap lhp = GetProjectMembers.sortHashMapByValues(GetProjectMembers.getTestMembers(pid), true);
            Map users = lhp;
            Object[] userArray = users.entrySet().toArray();
            int noOfRecords = 0;
            List ptc = null;
        %>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr  bgcolor="#C3D9FF">
                <td align="left"><b> Project Test Cases</b></td>

            </tr>

        </table>
        <br>

        <%
            String tepId = request.getParameter("tepId");
            logger.info("TEP ID" + tepId);
            String qManager = request.getParameter("qm");
            String eDate = request.getParameter("edate");
            String category = CheckCategory.getProjectCategory(pid);
            logger.info("tepId" + tepId);
            logger.info("pId" + pid);
            logger.info("eDate" + eDate);

            if (category.equalsIgnoreCase("SAP Project")) {
                if (createdby.equalsIgnoreCase("null")) {
                    ptc = TestCasePlan.listModulePTCforSAP(Integer.parseInt(pid), tepId);
                } else {
                    ptc = TestCasePlan.listModulePTCforSAPUser(Integer.parseInt(pid), tepId, createdby);
                }
            } else {

                if (createdby.equalsIgnoreCase("null")) {
                    ptc = TestCasePlan.listModulePTC(Integer.parseInt(pid), tepId);
                } else {
                    ptc = TestCasePlan.listModuleUserPTC(Integer.parseInt(pid), tepId, createdby);
                }
            }
            if (ptc != null) {
                noOfRecords = ptc.size();
            }
        %>
        <%
            try {
                int adminId = GetProjectMembers.getAdminID();
                int userId = (Integer) session.getAttribute("uid");


        %>
        <table width="100%">

            <tr >
                <td align="left" width="80%">This list shows <b> <%=noOfRecords%></b> Project Test Cases.</td>
                <td align="right"><a href="javascript:SetChecked()"><font
                            face="Arial, Helvetica, sans-serif" size="2">Select All</font></a> <a
                        href="javascript:resetChecked()"><font
                            face="Arial, Helvetica, sans-serif" size="2">Clear All</font></a></td>
            </tr>
        </table>
        <br>
        <form name="theForm" action="addTC.jsp" onsubmit="return ValidateForm('theForm', 'ptcid')" method="post">
            <table width="100%" class="tablesorter" id="filtersort" >
                <thead>
                    <tr bgcolor="#C3D9FF" >
                        <td width="10%" data-placeholder="Enter Testcase"  ><b>TestCaseId</b></td>
                        <!--<td width="10%"><b>Project</b></td>-->
                        <td width="10%" data-placeholder="" class="filter-false"><b>Module</b></td>
                        <td width="20%"  class="filter-select filter-match" data-placeholder="Select a Functionality"><b>Functionality</b></td>
                        <td width="20%" data-placeholder="" class="filter-false"><b>Test Step</b></td>
                        <td width="10%" data-placeholder="" class="filter-false"><b>Description</b></td>
                        <td width="10%" data-placeholder="" class="filter-false"><b>Expected Result</b></td>
                        <td width="10%" class="CreatedBy filter-select" data-placeholder="Select a CreatedBy"><b>Createdby</b></td>
                        <td width="10%" data-placeholder="" class="filter-false"><b>Due Date</b></td>
                        <td width="10%" data-placeholder="" class="filter-false"><b>AssignedTo</b>
                            <a href="#" onclick="setAllforAssigned();" style="size: 6px;"> All</a>&nbsp;&nbsp;
                            <a href="#" style="size: 6px;" onclick="resetAllforAssigned()
                                            ;">Clear All</a>
                        </td>
                </thead>
                </tr>
                <%
                    int k = 1;
                    String created = null;
                    if (ptc != null) {
                        for (Iterator i = ptc.iterator(); i.hasNext(); k++) {
                            TqmPtcm t = (TqmPtcm) i.next();
                            String ptcid = t.getPtcid();
                            String func = t.getFunctionality();
                            String desc = t.getDescription();
                            String reslt = t.getExpectedresult();
                            String project = GetProjects.getProjectName(((Integer) t.getPid()).toString());
                            String module = GetProjects.getModuleName((t.getMid()).toString());
                            created = GetProjectManager.getUserName(t.getCreatedby());
                            String testStep = TestCasePlan.getTestStepByPTC(ptcid);
             //           if(ptcid=="Q12052010002"){
                            //              logger.info("PTC IC-->"+ptcid);
                            //            logger.info("Fuction-->"+func);
                            //          logger.info("Desc-->"+desc);

                            //         }
                            java.util.Date date = t.getCreatedon();
                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
                            String requestedOn = sdf.format(date);

                            project = project.replace(":", " v");
                            String funcTitle = func;
                            String descTitle = desc;
                            String rsltTitle = reslt;
                            if (func.length() > 30) {
                                func = func.substring(0, 30) + "...";
                            }
                            if (desc.length() > 30) {
                                desc = desc.substring(0, 30) + "...";
                            }
                            if (reslt.length() > 30) {
                                reslt = reslt.substring(0, 30) + "...";
                            }

                            String color = "white";
                            if ((k % 2) != 0) {
                                color = "white";
                            } else {
                                color = "#E8EEF7";
                            }
                %>
                <tr bgcolor="<%=color%>" >
                    <td><input type="checkbox" name="ptcid" id="ptcid" value="<%=ptcid%>"><a href="<%=request.getContextPath()%>/admin/tqm/viewPTC.jsp?ptcID=<%=ptcid%>"><%=ptcid%></a></td>

                    <td><%=module%></td>

                    <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><%=func%></td>
                    <td title="<%=StringUtil.encodeHtmlTag(testStep)%>"><%=testStep%></td>
                    <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
                    <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>

                    <td><%=created%></td>
                    <td><input type="text" name="duedate" id="duedate" value="<%=eDate%>" readonly size="8"/></td>
                    <td>

                        <select name="assignedto" id="assignedto">
                            <option value="--Select One--">--Select One--</option>
                            <%
                                int userSize = userArray.length;
                                for (int s = 0; s < userSize; s++) {
                                    Map.Entry entry = (Map.Entry) userArray[s];
                                    String Id = (String) entry.getKey();
                                    String name = (String) entry.getValue();
                                    //                        name = name.substring(0, name.lastIndexOf(" ") + 2);
%>
                            <option value="<%=Id%>"><%=name%></option>
                            <%
                                }
                            %>
                        </select>
                    </td>

                </tr>

                <%
                            }
                        }
                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    }
                    if (noOfRecords > 0) {
                %>

                <%}%>

            </table>
            <input type="hidden" name="tepId" id="tepId" value="<%=tepId%>"><input type="hidden" name="pid" id="pid" value="<%=pid%>"><input type="hidden" name="edate" id="edate" value="<%=eDate%>">
            <div style="text-align: center;" >

                <input type="submit"  id="submit"  value="Submit"><input type="reset"  id="reset" value="Reset">
            </div>
        </form>
    </body>
</html>
