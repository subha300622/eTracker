<%-- 
    Document   : crmSearch
    Created on : 6 Feb, 2014, 4:13:35 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.crm.CRMUtil"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminentlabs.crm.ContactBean"%>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    int assignedto = (Integer) session.getAttribute("userid_curr");

    if (logoutcheck == null) {%>
<jsp:forward page="SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="cs" class="com.eminentlabs.crm.CRMSearch"></jsp:useBean>

    <!DOCTYPE html>
    <html>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
    <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>

    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>

    <script type="text/javascript">
        function callCreatedOn() {
            var createdon = document.getElementById('createdon').value;
            if (createdon === "Between") {

                document.getElementById('createdon_input').style.display = 'none';
                document.getElementById('createdRange').style.display = 'block';
            } else {
                document.getElementById('createdon_input').style.display = 'block';
                document.getElementById('createdRange').style.display = 'none';
            }
        }

        function callModifiedOn() {
            var modifiedon = document.getElementById('modifiedon').value;
            if (modifiedon === "Between") {

                document.getElementById('modifiedon_input').style.display = 'none';
                document.getElementById('modifiedRange').style.display = 'block';
            } else {
                document.getElementById('modifiedon_input').style.display = 'block';
                document.getElementById('modifiedRange').style.display = 'none';
            }
        }

        function callDueDateOn() {
            var duedate = document.getElementById('duedateon').value;
            if (duedate === "Between") {

                document.getElementById('duedate_input').style.display = 'none';
                document.getElementById('dueDateRange').style.display = 'block';
            } else {
                document.getElementById('duedate_input').style.display = 'block';
                document.getElementById('dueDateRange').style.display = 'none';
            }
        }
        function val(theForm) {
            if ((theForm.crmType.value) === '') {
                alert('Select the CRM Type ');
                theForm.crmType.focus();
                return false;
            }


            disableSubmit();
        }
    </script>

    <script type="text/javascript">
        function createRequest() {
            var reqObj = null;
            try
            {
                reqObj = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (err)
            {
                try {
                    reqObj = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (err2) {
                    try {
                        reqObj = new XMLHttpRequest();
                    } catch (err3) {
                        reqObj = null;
                    }
                }
            }
            return reqObj;
        }

        function getCRMCompany() {
            xmlhttp = createRequest();
            if (xmlhttp !== null) {
                var crmType = document.getElementById('crmType').value;
                xmlhttp.open("GET", "/eTracker/admin/customer/getCRMCompany.jsp?crmType=" + crmType + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = callBackCRMCompany;
                xmlhttp.send(null);
            }
        }
        function callBackCRMCompany()
        {
            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var result = xmlhttp.responseText.split(";");
                    var results = result[1].split(",");
                    objLinkList = eval("document.theForm.company");
                    objLinkList.length = 0;
                    for (i = 0; i < results.length - 1; i++) {
                        objLinkList.length++;
                        if (results[i] === "All Information") {
                            objLinkList[i].text = results[i];
                            objLinkList[i].value = "";
                        } else {
                            objLinkList[i].text = results[i];
                            objLinkList[i].value = results[i];
                        }
                    }

                }
            }
        }

        function getCRMCity() {
            xmlhttp = createRequest();
            if (xmlhttp !== null) {
                var crmType = document.getElementById('crmType').value;
                xmlhttp.open("GET", "/eTracker/admin/customer/getCRMCity.jsp?crmType=" + crmType + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = callBackCRMCity;
                xmlhttp.send(null);
            }
        }
        function callBackCRMCity()
        {
            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var result = xmlhttp.responseText.split(";");
                    var results = result[1].split(",");
                    objLinkList = eval("document.theForm.city");
                    objLinkList.length = 0;
                    for (i = 0; i < results.length - 1; i++) {
                        objLinkList.length++;
                        if (results[i] === "All Information") {
                            objLinkList[i].text = results[i];
                            objLinkList[i].value = "";
                        } else {
                            objLinkList[i].text = results[i];
                            objLinkList[i].value = results[i];
                        }
                    }

                }
            }
        }
        function getCRMState() {
            xmlhttp = createRequest();
            if (xmlhttp !== null) {
                var crmType = document.getElementById('crmType').value;
                xmlhttp.open("GET", "/eTracker/admin/customer/getCRMState.jsp?crmType=" + crmType + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = callBackCRMState;
                xmlhttp.send(null);
            }
        }
        function callBackCRMState()
        {
            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var result = xmlhttp.responseText.split(";");
                    var results = result[1].split(",");
                    objLinkList = eval("document.theForm.state");
                    objLinkList.length = 0;
                    for (i = 0; i < results.length - 1; i++) {
                        objLinkList.length++;
                        if (results[i] === "All Information") {
                            objLinkList[i].text = results[i];
                            objLinkList[i].value = "";
                        } else {
                            objLinkList[i].text = results[i];
                            objLinkList[i].value = results[i];
                        }
                    }

                }
            }
        }

        function getCRMArea() {
            xmlhttp = createRequest();
            if (xmlhttp !== null) {
                var crmType = document.getElementById('crmType').value;
                xmlhttp.open("GET", "/eTracker/admin/customer/getCRMArea.jsp?crmType=" + crmType + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = callBackCRMArea;
                xmlhttp.send(null);
            }
        }
        function callBackCRMArea()
        {
            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var result = xmlhttp.responseText.split(";");
                    var results = result[1].split(",");
                    objLinkList = eval("document.theForm.area");
                    objLinkList.length = 0;
                    for (i = 0; i < results.length - 1; i++) {
                        objLinkList.length++;
                        if (results[i] === "All Information") {
                            objLinkList[i].text = results[i];
                            objLinkList[i].value = "";
                        } else {
                            objLinkList[i].text = results[i];
                            objLinkList[i].value = results[i];
                        }
                    }

                }
            }
        }

        function getCRMVendor() {
            xmlhttp = createRequest();
            if (xmlhttp !== null) {
                var crmType = document.getElementById('crmType').value;
                xmlhttp.open("GET", "/eTracker/admin/customer/getCRMVendor.jsp?crmType=" + crmType + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = callBackCRMVendor;
                xmlhttp.send(null);
            }
        }
        function callBackCRMVendor()
        {
            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var result = xmlhttp.responseText.split(";");
                    var results = result[1].split(",");
                    objLinkList = eval("document.theForm.vendor");
                    objLinkList.length = 0;
                    for (i = 0; i < results.length - 1; i++) {
                        objLinkList.length++;
                        if (results[i] === "All Information") {
                            objLinkList[i].text = results[i];
                            objLinkList[i].value = "";
                        } else {
                            objLinkList[i].text = results[i];
                            objLinkList[i].value = results[i];
                        }
                    }

                }
            }
        }

    </script>


</head>

<body onload="javascript:getCRMCompany();
        javascript:getCRMCity();
        javascript:getCRMState();
        javascript:getCRMArea();
        javascript:getCRMVendor();
      ">
    <%@ include file="/header.jsp"%>

    <%if (cs.getAl().containsKey(((Integer) assignedto).toString())) {
    %>

    <%cs.getAll(request);%>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#C3D9FF">
            <td border="1" align="left" width="30%">
                <font size="4" COLOR="#0000FF"><b>CRM Search   </b></font>

            </td>
        </tr>

    </table>
    <br/><br/>
    <!--edit by mukesh-->
    <style>

        #alinga td{
            vertical-align: top;
        }
    </style>
    <jsp:useBean id="Contact" class="com.eminent.customer.ContactRegistration"/>

    <!--edit by mukesh-->
    <form name="theForm" onsubmit="return val(this);"  action="<%=request.getContextPath()%>/MyCRM/crmSearchResults.jsp">
        <table width="100%" bgColor="#E8EEF7" cellspacing="2" cellpadding="2" align="center" id="alinga">
            <tr>
                <td width="25%">
                    <b>CRM Type</b>
                </td>
                <td width="25%">
                    <b>Company</b>  
                </td>
                <td width="25%">
                    <b>City</b>  
                </td>
                <td width="25%">
                    <b>State</b>  
                </td>
            </tr>
            <tr>
                <td width="25%">
                    <select id="crmType" name="crmType" onchange="
                            javascript:getCRMArea();
                            javascript:getCRMCompany();
                            javascript:getCRMCity();
                            javascript:getCRMState();
                            javascript:getCRMVendor();">
                        <%for (String crm : cs.getCrmType()) {%>
                        <option value="<%=crm%>"><%=crm%></option>
                        <%}%>
                    </select>
                </td>
                <td width="25%">
                    <select id="company" name="company">

                    </select>             </td>
                <td width="25%">
                    <select id="city" name="city">

                    </select> 
                </td>
                <td width="25%">
                    <select id="state" name="state">

                    </select>
                </td>
            </tr>
            <tr>
                <td width="25%">
                    <b>Created By</b>
                </td>
                <td width="25%">
                    <b>Created on</b>  
                    <select id="createdon" name="createdon" onchange="javascript:callCreatedOn();">
                        <%for (String dateType : cs.getDateList()) {%>
                        <option value="<%=dateType%>"><%=dateType%></option>
                        <%}%>
                    </select>
                </td>
                <td width="25%">
                    <b>Modified By</b>  
                </td>
                <td width="25%">
                    <b>Modified on</b>
                    <select id="modifiedon" name="modifiedon" onchange="javascript:callModifiedOn();">
                        <%for (String dateType : cs.getDateList()) {%>
                        <option value="<%=dateType%>"><%=dateType%></option>
                        <%}%>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="25%">
                    <select id="createdby" name="createdby">
                        <option value="">All Information</option>
                        <%for (Map.Entry<String, String> users : cs.getAl().entrySet()) {%>
                        <option value="<%=users.getKey()%>"><%=users.getValue()%></option>
                        <%}%>
                    </select>
                </td>
                <td width="25%">
                    <span id="createdon_input">
                        <input type="Text" id="created" name="created"  readonly="true" maxlength="25"	size="15"/><a href="javascript:NewCal('created','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                    </span>
                    <span id="createdRange" style="display: none;">
                        <!--edit by mukesh--> 
                        <div>
                            <b>From:</b>    <input type="text" id="createdFrom" name="createdFrom" readonly="true" maxlength="25"	size="8"/><a href="javascript:NewCal('createdFrom','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                        </div>
                        &nbsp;&nbsp;&nbsp;
                        <div style="margin-left: 13px;">
                            <b>To: </b><input type="text" id="createdTo" name="createdTo" readonly="true" maxlength="25"	size="8"/><a href="javascript:NewCal('createdTo','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                        </div>
                        <!--edit by mukesh-->
                    </span>
                </td>
                <td width="25%">
                    <select id="modifiedby" name="modifiedby" >
                        <option value="">All Information</option>
                        <%for (Map.Entry<String, String> users : cs.getAl().entrySet()) {%>
                        <option value="<%=users.getKey()%>"><%=users.getValue()%></option>
                        <%}%>
                    </select>
                </td>
                <td width="25%">
                    <span id="modifiedon_input">
                        <input type="Text" id="modified" name="modified"  readonly="true" maxlength="25"	size="15"/><a href="javascript:NewCal('modified','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                    </span>
                    <span id="modifiedRange" style="display: none;">
                        <!--edit by mukesh-->
                        <div>
                            <b>From:</b>    <input type="text" id="modifiedFrom" name="modifiedFrom" readonly="true" maxlength="25"	size="8"/><a href="javascript:NewCal('modifiedFrom','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                        </div>
                        &nbsp;&nbsp;&nbsp;
                        <div style="margin-left: 13px;">
                            <b>To:</b><input type="text" id="modifiedTo" name="modifiedTo" readonly="true" maxlength="25"	size="8"/><a href="javascript:NewCal('modifiedTo','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                        </div>
                        <!--edit by mukesh-->
                    </span>
                </td>
            </tr>
            <tr>
                <td width="25%">
                    <b>Assigned To</b>
                </td>
                <td width="25%">
                    <b>Due Date</b>  
                    <select id="duedateon" name="duedateon" onchange="javascript:callDueDateOn();">
                        <%for (String dateType : cs.getDateList()) {%>
                        <option value="<%=dateType%>"><%=dateType%></option>
                        <%}%>
                    </select>
                </td>
                <td width="25%">
                    <b>Rating</b>  
                </td>
                <td width="25%">
                    <b>Interested In</b>  
                </td>
            </tr>
            <%-- Assignedto --%>
            <tr>
                <td width="25%">
                    <select id="assignedTo" name="assignedTo">
                        <option value="">All Information</option>
                        <%for (Map.Entry<String, String> users : cs.getAl().entrySet()) {%>
                        <option value="<%=users.getKey()%>"><%=users.getValue()%></option>
                        <%}%>
                    </select>
                </td>
                <td width="25%">
                    <span id="duedate_input">
                        <input type="Text" id="duedate" name="duedate"  readonly="true" maxlength="25"	size="15"/><a href="javascript:NewCal('duedate','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                    </span>
                    <span id="dueDateRange" style="display: none;">
                        <!--edit by mukesh-->
                        <div>
                            <b>From:</b>    <input type="text" id="duedateFrom" name="duedateFrom" readonly="true" maxlength="25" size="8"/><a href="javascript:NewCal('duedateFrom','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                        </div> 
                        &nbsp;&nbsp;&nbsp;
                        <div style="margin-left: 13px;">
                            <b>To: </b><input type="text" id="duedateTo" name="duedateTo" readonly="true" maxlength="25"	size="8"/><a href="javascript:NewCal('duedateTo','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                        </div>
                        <!--edit by mukesh-->
                    </span>
                </td>
                <td width="25%">
                    <select id="rating" name="rating">
                        <option value="">All Information</option>

                        <%for (String rating : cs.getRatingType()) {%>
                        <option value="<%=rating%>"><%=rating%></option>
                        <%}%>
                    </select>                </td>
                <td width="25%">
                    <select id="product" name="product">
                        <option value="">All Information</option>

                        <%for (String product : cs.getInterestedType()) {%>
                        <option value="<%=product%>"><%=product%></option>
                        <%}%>
                    </select>                </td>
            </tr>
            <tr >
                <td width="10%" class="vendor-erp"><strong>ERP</td>
                <td width="10%" class="vendor-erp"><strong>Vendor</td>
                <td width="10%" class="area"><strong>Area
                </td>
                <td width="10%" class="industry"><strong>Industry
                </td>
            </tr>
            <tr >
                <td width="25%" class="vendor-erp">
                    <select name="erp" id="erp" size="1">
                        <option value=""  selected>All Information</option>
                        <%for (String erpName : Contact.erpList()) {%>
                        <option value="<%=erpName%>"
                                ><%=erpName%></option>
                        <%}%>
                    </select>
                </td>

                <td width="25%" class="vendor-erp">
                    <select name="vendor" id="vendor" >

                    </select>                
                </td>
                <td width="25%" class="area">
                    <select id="area" name="area">

                    </select>
                </td>

                <td width="25%" class="industry">
                    <select id="industry" name="industry">
                        <option value=""  selected>All Information</option>
                        <%for (Map.Entry<Integer, String> ind : CRMUtil.getIndustry().entrySet()) {%>
                        <option value="<%=ind.getKey()%>"><%=ind.getValue()%></option>
                        <% }%>
                    </select>
                </td>

            </tr>
            <tr >
                <td width="10%" class="department"><strong>Department</strong></td>              
                <td width="10%" class="contactType"><strong>Type</strong></td>              
            </tr>
            <tr>
                <td width="25%" class="department">
                    <select id="department" name="department">
                        <option value=""  selected>All Information</option>
                        <%for (String department : CRMUtil.getDepartments("contact")) {%>
                        <option ><%=department%></option>
                        <% }%>
                    </select>
                </td>
                <td width="25%" class="contactType">
                    <select id="contactType" name="contactType">
                        <option value=""  selected>All Information</option>
                        <%for (String contactType : CRMUtil.contactType()) {%>
                        <option ><%=contactType%></option>
                        <% }%>
                    </select>
                </td>
            </tr>
            <!--
                        <tr>
                            <td width="25%">
                                <b>Status</b>  
                            </td>
                            <td width="25%">
                                <b>Stage</b>  
                            </td>
                        </tr>
                        <tr>
                            <td width="25%">
                                <b>Status</b>  
                            </td>
                            <td width="25%">
                                <b>Stage</b>  
                            </td>
                        </tr>-->
            <tr style="text-align: center;">
                <td colspan="3">
                    <input type="submit" id="submit" value="Search"


                </td>
            </tr>
        </table>

    </form>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.min.js"></script>  

    <script type="text/javascript">
                        $(document).on("change", "#crmType", function () {
                            if ($(this).val() == 'Contact' || $(this).val() == 'Lead') {
                                $(".vendor-erp").show();
                                $(".industry").show(); 
                                   $(".contactType").show();
                                if ($(this).val() == 'Contact') {
                                    $(".department").show();
                                } else {
                                    $(".department").hide();
                                }
                            } else {
                                $(".vendor-erp").hide();
                                $(".industry").hide();
                                $(".department").hide();
                                $(".contactType").hide();

                            }

                            if ($(this).val() == 'Account') {
                                $(".area").hide();
                            } else {
                                $(".area").show();
                            }
                        });

    </script>
    <%} else {%>
    <div style="text-align: center; color: red;">          
        <p style="alignment-adjust: central"> You are not authorized to access this page.
        </p>
    </div>
    <%}%>
</body>
</html>
