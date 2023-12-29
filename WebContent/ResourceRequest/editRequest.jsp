<%@ page language="java" contentType="text/html"  pageEncoding="UTF-8"%>
<%@ page import="com.pack.*,java.util.*,org.apache.log4j.*,java.sql.*,pack.eminent.encryption.*,java.text.*,com.eminent.util.*,com.eminent.resource.*, com.pack.eminent.applicant.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    Logger logger = Logger.getLogger("editRequest");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">

        <meta http-equiv="Content-Type" content="text/html ">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
        <script language=javascript	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
        <script language=javascript	src="<%= request.getContextPath()%>/eminentech support files/validateResourceRequest.js"></script>
        <script language="JavaScript">

            function createRequest() {
                var reqObj = null;
                try {
                    reqObj = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (err) {
                    try {
                        reqObj = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (err2) {
                        try {
                            reqObj = new XMLHttpRequest();
                        }
                        catch (err3) {
                            reqObj = null;
                        }
                    }
                }
                return reqObj;
            }

            function validateLock() {
                xmlhttp = createRequest();
                if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
                    xmlhttp = new XMLHttpRequest();
                }
                if (xmlhttp != null) {

                    var lockArray = document.getElementsByName("lock");
                    var index;

                    for (i = 0; i < lockArray.length; i++) {
                        if (lockArray[i].checked == true) {
                            index = i;
                        }
                    }

                    var lock = lockArray[index].value;

                    xmlhttp.open("GET", "validateLock.jsp?apId=" + lock + "&rand=" + Math.random(1, 10), true);
                    xmlhttp.onreadystatechange = lockAlert;
                    xmlhttp.send(null);
                }
            }


            function lockAlert() {
                if (xmlhttp.readyState == 4) {
                    if (xmlhttp.status == 200) {

                        var due = xmlhttp.responseText.split(",");
                        var flag = due[1];

                        if (flag != 'yes') {

                            var lockArray = document.getElementsByName("lock");
                            var index;

                            for (i = 0; i < lockArray.length; i++) {
                                if (lockArray[i].checked == true) {
                                    index = i;
                                }
                            }
                            alert("This applicant has been locked by another member before you lock");

                            theForm.lock[index].checked = false;


                        }

                    }
                }
            }


            function textCounter(field, cntfield, maxlimit)
            {
                if (field.value.length > maxlimit)
                {
                    field.value = field.value.substring(0, maxlimit);
                    alert('Comments size is exceeding 2000 characters');
                }
                else
                    cntfield.value = maxlimit - field.value.length;
            }



        </script>
    </head>
    <body>
        <%
            String requestid = request.getParameter("requestid");
        %>
        <%@ include file="../header.jsp"%>
        <form name="theForm" action="updateRequest.jsp" onsubmit="return validateUpdation(this)">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr border="2" bgcolor="#C3D9FF">
                    <td  border="1" align="left"><font size="4"> <b> Edit Resource Requisition</b></font></td>
                    <td  border="1" align="right"><font size="4"> <b> <a href="<%=request.getContextPath()%>/ResourceRequest/viewRequestDetails.jsp?requestid=<%= requestid%>" target="_blank">Print Resource Requisition</a></b></font></td>

                </tr>

            </table>
            <jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" /> 
            <%

                session.setAttribute("requestid", requestid);

                Connection connection = null, connection1 = null;
                PreparedStatement ps = null;
                ResultSet rs = null, rs1 = null;
                Statement st1 = null;
                try {

                    String project = null;
                    String team = null;
                    String position = null;
                    String skillset = null;
                    String responsibility_p1 = null;
                    String responsibility_p2 = null;
                    String responsibility_p3 = null;
                    String responsibility_p4 = null;
                    String responsibility_p5 = null;
                    String responsibility_s1 = null;
                    String responsibility_s2 = null;
                    String responsibility_s3 = null;
                    String responsibility_s4 = null;
                    String responsibility_s5 = null;

                    String createdon = null;
                    String modifiedon = null;

                    String createdby = null;
                    String assignedto = null;

                    String duedate = null;
                    String exp_years = null;
                    String exp_months = null;
                    String status = null;
                    java.sql.Date dueDateFormat = null;
                    java.sql.Date created = null;
                    java.sql.Date modified = null;

                    HashMap<String, String> hm = new HashMap<String, String>();

                    String teams[] = {"XI", "BASIS", "ABAP", "MDM", "MM", "PP", "FI", "BI", "SD", "EP", "HR", "NW ADMIN", "ADMIN", "CUSTOMER", "DIRECTOR", "SALES", "INTERN"};

                    String positions[] = {"HR", "SE", "SSE", "PM", "DBA"};

                    String statusitems[] = {"Unconfirmed", "Confirmed", "Sourcing", "In Process", "Fulfilled", "Rejected", "Closed"};

                    HashMap<String, String> Skillsets = new HashMap<String, String>();

                    Skillsets.put("ABAP", "ABAP");
                    Skillsets.put("BS", "BASIS");
                    Skillsets.put("WD", "WEBDYNPRO");
                    Skillsets.put("SD", "Sales and Distribution");
                    Skillsets.put("MM", "Material Management");
                    Skillsets.put("FI", "Finance");
                    Skillsets.put("CO", "Costing");
                    Skillsets.put("HR", "Human Resource");
                    Skillsets.put("PP", "Production Planning");
                    Skillsets.put("PM", "Plant Maintanance");
                    Skillsets.put("XI", "Exchange Infrastructure");
                    Skillsets.put("MDM", "Master Data Management");
                    Skillsets.put("APO", "Advance Plannet Optimizer");
                    Skillsets.put("PS", "Project Systems");
                    Skillsets.put("FR", "Fresher Aptitude");
                    Skillsets.put("XIA", "XI Administration");
                    Skillsets.put("NWADMIN", "Netweaver Administration");

                    int skillsize = Skillsets.size();

                    try {

                        SimpleDateFormat sdf = new SimpleDateFormat("d-M-yyyy");

                        connection = MakeConnection.getConnection();
            //		connection1=MakeConnection.getSAPConnection();

                        if (connection != null) {

                            ps = connection.prepareStatement("select * from resourcerequest where requestid='" + requestid + "'", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            rs = ps.executeQuery();
                            if (rs != null) {
                                rs.next();

                                project = rs.getString("project");
                                team = rs.getString("team");
                                position = rs.getString("position");
                                skillset = rs.getString("skillset");

                                exp_years = rs.getString("exp_years");
            //				exp_months		=	rs.getString("exp_months");
                                assignedto = rs.getString("assignedto");

                                dueDateFormat = rs.getDate("duedate");
                                created = rs.getDate("createdon");
                                modified = rs.getDate("modifiedon");

                                responsibility_p1 = rs.getString("responsibility_p1");
                                responsibility_p2 = rs.getString("responsibility_p2");
                                responsibility_p3 = rs.getString("responsibility_p3");
                                responsibility_p4 = rs.getString("responsibility_p4");
                                responsibility_p5 = rs.getString("responsibility_p5");

                                responsibility_s1 = rs.getString("responsibility_s1");
                                responsibility_s2 = rs.getString("responsibility_s2");
                                responsibility_s3 = rs.getString("responsibility_s3");
                                responsibility_s4 = rs.getString("responsibility_s4");
                                responsibility_s5 = rs.getString("responsibility_s5");

                                if (responsibility_s1 == null) {
                                    responsibility_s1 = "NA";
                                }
                                if (responsibility_s2 == null) {
                                    responsibility_s2 = "NA";
                                }
                                if (responsibility_s3 == null) {
                                    responsibility_s3 = "NA";
                                }
                                if (responsibility_s4 == null) {
                                    responsibility_s4 = "NA";
                                }
                                if (responsibility_s5 == null) {
                                    responsibility_s5 = "NA";
                                }

                                createdby = rs.getString("createdby");
                                status = rs.getString("status");

                                duedate = "NA";
                                if (dueDateFormat != null) {
                                    duedate = sdf.format(dueDateFormat);
                                }
                                createdon = "NA";
                                if (dueDateFormat != null) {
                                    createdon = sdf.format(created);
                                }
                                modifiedon = "NA";
                                if (dueDateFormat != null) {
                                    modifiedon = sdf.format(modified);
                                }

                                hm = GetProjectMembers.getMembers("ERM", "1.0", createdby, assignedto);

                            }
                        }
                    } catch (Exception e) {
                        logger.error("Edit Exception" + e);
                    }
            %>


            <table bgcolor="E8EEF7" cellpadding="2" width="100%"> 
                <tr>
                    <td><b>Position</b></td><td><%=position%></td>
                    <td><b>Project</b></td><td><%=GetProjects.getProjectName(project)%></td>
                    <td><b>Team</b></td><td> <%=team%></td>



                </tr>
                <tr>
                    <td><b>Experience</b></td><td><%=exp_years%>Years</td>
                    <td><b>Expertise</b></td><td >	<%=skillset%></td>
                    <td><b>DueDate</b></td><td><input type="text" name="duedate" value="<%=duedate%>" size=10><a href="javascript:NewCal('date','ddmmyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a></td>
                </tr>
                <tr>
                    <td><b>Assignedto</b></td><td><Select name="assignedto" size=1>
                            <%
                                Collection set = hm.keySet();
                                Iterator iter = set.iterator();
                                int assigned = 0;

                    //		  int lockedResource = ResourceCheck.getResourceId(requestid);
                                int lockedResource = 0;
                                session.setAttribute("lockedResource", lockedResource);
                                session.setAttribute("reqId", requestid);

                                while (iter.hasNext()) {

                                    String key = (String) iter.next();
                                    String nameofuser = (String) hm.get(key);
                                    logger.info("Userid" + key);
                                    logger.info("Name" + nameofuser);
                                    int useridassi = Integer.parseInt(key);
                                    if (useridassi == Integer.parseInt(assignedto)) {
                                        assigned = useridassi;
                            %>
                            <option value="<%=assigned%>" selected><%=nameofuser%></option>
                            <%
                            } else {
                                assigned = useridassi;
                            %>
                            <option value="<%=assigned%>"><%=nameofuser%></option>
                            <%
                                    }

                                }

                            %>
                        </Select>
                    </td>
                    <td><b>Status</b></td><td >
                        <Select name="status" size=1>
                            <%            for (int i = 0; i < statusitems.length; i++) {
                                    if (statusitems[i].equalsIgnoreCase(status)) {
                            %>

                            <option value="<%=statusitems[i]%>" selected><%=statusitems[i]%></option>
                            <%
                            } else {
                            %>

                            <option value="<%=statusitems[i]%>" ><%=statusitems[i]%></option>
                            <%
                                    }
                                }


                            %>
                        </Select></td>
                    <td><b>Files Attached</b></td>
                    <td>
                        <%    int fileCount = ResourceRequest.getAttachedFileCount(requestid);
                            if (fileCount > 0) {
                        %>
                        <A onclick="viewFileAttachForIssue('<%=requestid%>');" href="#"
                           >View Files</A>
                            <%
                            } else {
                            %>
                        <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font>
                            <%
                                }
                            %>
                    </td>
                </tr>
                <tr>
                <table bgcolor="E8EEF7" cellpadding="2" width="100%">
                    <tr>
                        <td align="left" width="100%" colspan="8"><font size="4" COLOR="#0000FF"><b>Job Responsibilities </b></font></td>
                    </tr>
                    <tr >
                        <td align="center" width="80%" colspan="4"><font size="4" COLOR="#0000FF"><b>Primary</b></font></td>

                        <td align="center" width="20%" colspan="4"><font size="4" COLOR="#0000FF"><b>Secondary </b></font></td>

                    </tr>
                    <tr >
                        <td align="left" width="80%" colspan="4"><font size="4" >1.<%=responsibility_p1%></font></td>
                        <td align="left" width="20%" colspan="4"><font size="4" >1.<%=responsibility_s1%></font></td>

                    </tr>
                    <tr>
                        <td align="left" width="80%" colspan="4"><font size="4" >2.<%=responsibility_p2%></font></td>
                        <td align="left" width="20%" colspan="4"><font size="4" >2.<%=responsibility_s2%></font></td>

                    </tr>
                    <tr >
                        <td align="left" width="80%" colspan="4"><font size="4" >3.<%=responsibility_p3%></font></td>
                        <td align="left" width="20%" colspan="4"><font size="4" >3.<%=responsibility_s3%></font></td>

                    </tr>
                    <tr>
                        <td align="left" width="80%" colspan="4"><font size="4" >4.<%=responsibility_p4%></font></td>
                        <td align="left" width="20%" colspan="4"><font size="4" >4.<%=responsibility_s4%></font></td>

                    </tr>
                    <tr>
                        <td align="left" width="80%" colspan="4"><font size="4" >5.<%=responsibility_p5%></font></td>
                        <td align="left" width="20%" colspan="4"><font size="4" >5.<%=responsibility_s5%></font></td>


                    </tr>
                </table>
                </tr>
            </table>
            <!-- // Code for operation on SAP DB(315) -->
            <%
                try {
                    if (connection1 != null) {
                        st1 = connection1.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                        rs1 = st1.executeQuery("SELECT apid,ANAM,LNAM,MPHN,cloc,refid,regdat,ug,pg, osta, area,spey,spem,tote,totm,atta,rtime from yapn  where osta != 'OI' and spey >= '" + exp_years + "' and (sel_status is null or sel_status != 'S') and (area = '" + skillset + "' or lang = '" + skillset + "') and (reqid is null or reqid = '" + requestid + "') and apid not in(select distinct apid from yrr_history where reqid='" + requestid + "') order by spey desc, spem desc, tote desc, totm desc ");

                        rs1.last();
                        int count = rs1.getRow();
                        logger.debug("Total No of records:" + count);
                        rs1.beforeFirst();

            %>


            <TABLE width="100%" border="0">
                <tr>
                    <%    if (count == 0) {
                    %>
                <table align="center" height="70%">
                    <tr>
                        <td>
                            <h3>No applicants are available matching this requirement.</h3>
                        </td>
                    </tr>
                </table>
                <%
                } else {
                %>

                <br>

                <table width=100%>
                    <TR bgColor="#C3D9FF" height="9">
                        <TD width="5%"><font><b>Select</b></font></TD>
                        <TD width="5%"><font><b>Ap ID</b></font></TD>
                        <TD width="16%"><font><b>Name</b></font></TD>
                        <TD width="17%"><font><b>Employer</b></font></TD>
                        <TD width="10%"><font><b>Mobile</b></font></TD>
                        <TD width="10%"><font><b>Location</b></font></TD>
                        <TD width="6%"><font><b>Status</b></font></TD>
                        <TD width="7%"><font><b>Education</b></font></TD>
                        <TD width="7%"><font><b>Expertise</b></font></TD>
                        <TD width="6%"><font><b>Total Exp</b></font></TD>
                        <TD width="6%"><font><b>SAP Exp</b></font></TD>
                        <TD width="5%"><font><b>Resume</b></font></TD>
                    </TR>

                    <%
                        int apid = 9999;
                        String fname = "", lname = "", ug = "", pg = "", email = "", mobile = "", area = "", dob = "", atta = "", apStatus = "";
                        PreparedStatement ps1 = connection1.prepareStatement("select pemp from yapn_emp_exp where apid=? and cnt=1");
                        ResultSet rsEmp = null;
                        String employer = null;
                        if (rs1 != null) {
                            for (int i = 1; i <= count; i++) {
                                if (rs1.next()) {
                                    apid = rs1.getInt("apid");

                                    ps1.setInt(1, apid);
                                    rsEmp = ps1.executeQuery();
                                    if (rsEmp != null) {
                                        if (rsEmp.next()) {
                                            employer = rsEmp.getString("pemp");
                                        } else {
                                            employer = "NA";
                                        }
                                    }

                                    apStatus = rs1.getString("osta");
                                    if (apStatus.equalsIgnoreCase("")) {
                                        apStatus = "Blank";
                                    }
                                    fname = rs1.getString("anam");
                                    if (fname == null) {
                                        fname = "";
                                    }
                                    lname = rs1.getString("lnam");
                                    if (lname == null) {
                                        lname = "";
                                    }
                                    mobile = rs1.getString("mphn");
                                    if (mobile == null) {
                                        mobile = "nil";
                                    }
                                    String refId = rs1.getString("refid");
                                    ug = rs1.getString("ug");
                                    if (ug == null) {
                                        ug = "";
                                    }
                                    if (ug != null) {
                                        ug += ", ";
                                    }
                                    pg = rs1.getString("pg");
                                    if (pg == null) {
                                        pg = "";
                                    }
                                    email = rs1.getString("cloc");
                                    if (email == null) {
                                        email = "";
                                    }
                                    area = rs1.getString("area");
                                    if (area == null) {
                                        area = "nil";
                                    }

                                    String t = rs1.getString("rtime");

                                    int totExpYears = rs1.getInt("tote");
                                    int totExpMonths = rs1.getInt("totm");

                                        //String totExp = totExpYears+"Y"+"  "+totExpMonths+"M";
                                    int sapExpYears = rs1.getInt("spey");
                                    int sapExpMonths = rs1.getInt("spem");

                                        //String sapExp = sapExpYears+"Y"+"  "+sapExpMonths+"M";
                                    atta = rs1.getString("atta");
                                    if (t.equalsIgnoreCase("000000")) {
                                        atta = apid + "_" + fname + "_" + rs1.getString("regdat") + ".doc";
                                    } else {
                                        atta = apid + "_" + fname + "_" + rs1.getString("regdat") + "_" + t + ".doc";
                                    }

                                    if (atta == null) {
                                        atta = "nil";
                                    }
                                    if ((i % 2) != 0) {
                    %>
                    <tr bgcolor="white" height="21">
                        <%
                        } else {
                        %>

                    <tr bgcolor="#E8EEF7" height="21">
                        <%
                            }

                            if (lockedResource == apid) {
                        %>
                        <td width="5%"><input type="radio" checked name="lock" value="<%= apid%>"> </td>
                            <%
                            } else {
                            %>
                        <td width="5%"><input type="radio" onclick="javascript:validateLock()" name="lock" value="<%= apid%>"> </td>
                            <%

                                }
                            %>
                        <td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><A
                                    HREF="<%= request.getContextPath()%>/admin/candidate/viewdetails.jsp?apid=<%=apid%>"><%= apid%></A></font></td>
                                    <%
                                        String fullname = fname + " " + lname;
                                        if ((fullname.length()) < 25) {
                                    %>
                        <td width="16%" title="Ref Id : <%= refId%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(fullname)%></font></td>
                                <%
                                } else {
                                %>
                        <td width="16%" title="Ref Id : <%= refId%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= fullname.substring(0, 25) + "..."%></font></td>
                                <%
                                    }
                                    if ((employer.length()) < 20) {
                                %>
                        <td width="17%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(employer)%></font></td>
                                <%
                                } else {
                                %>
                        <td width="17%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= employer.substring(0, 20) + "..."%></font></td>
                                <%
                                    }

                                %>

                        <td width="10%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(mobile)%></font></td>
                                <%
                                    if ((email.length()) < 25) {
                                %>
                        <td width="10%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email)%></font></td>
                                <%
                                } else {
                                %>
                        <td width="10%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email.substring(0, 25) + "..."%></font></td>
                                <%
                                    }
                                    String statusAcronym = Applicant.getApplicantStatusShortcut(apStatus);
                                %>
                        <td width="6%" title="<%= Applicant.getApplicantStatus(apStatus)%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                                   size="1" color="#000000"><%= statusAcronym%></font></td>
                                <%
                                    String education = ug + pg;
                                    if (education.equals(", ")) {
                                        education = "Nil";
                                    }
                                    if ((education.length()) < 10) {
                                %>
                        <td width="9%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><%= StringUtil.encodeHtmlTag(education)%></font></td>
                                <%
                                } else {
                                %>
                        <td width="9%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><%= education.substring(0, 10) + "..."%></font></td>
                                <%
                                    }
                                    if ((area.length()) < 13) {
                                %>
                        <td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><%= StringUtil.encodeHtmlTag(area)%></font></td>
                                <%
                                } else {
                                %>
                        <td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><%= area.substring(0, 13) + "..."%></font></td>
                                <%
                                    }
                                %>
                        <td width="6%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><%= totExpYears%>Y&nbsp;&nbsp;<%= totExpMonths%>M</font></td>
                        <td width="6%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><%= sapExpYears%>Y&nbsp;&nbsp;<%= sapExpMonths%>M</font></td>
                                <%

                                    if (atta.length() < 8) {

                                %>
                        <td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><a
                                    href="<%= request.getContextPath()%>/Eminentlabs/Resumes/<%=atta%>"
                                    target="_blank"><%=atta%></a></font></td>
                                <%
                                } else {
                                %>
                        <td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><a
                                    href="<%= request.getContextPath()%>/Eminentlabs/Resumes/<%=atta%>"
                                    target="_blank"><%=atta.substring(0, 8) + "..."%></a></font></td>

                        <%
                            }

                        %>

                    </tr>
                    <%                        }
                                        }
                                    }

                                }
                            }
                        } catch (Exception e) {
                            logger.error("Error while showing applicants from SAP DB" + e);
                        }
                    %>
                </table>
                <table width="100%">
                    <tr height="21">
                        <td width="100%" class="textdisplay" align="center" colspan=8>
                            <p class="textdisplay">Comments</p>
                        </td>
                    </tr>
                    <tr height="21">
                        <td width="23%" align="center" colspan=8><font size="2"
                                                                       face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                    rows="3" cols="68" name="comments" maxlength="2000"
                                    onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 2000)"
                                    onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 2000)"></textarea></font>
                            <input readonly type="text" name="remLen1"
                                   size="3" maxlength="3" value="2000">Chars Left</td>
                    </tr>
                    <tr>
                        <td align="center" width="100%" >
                            <font size="4" COLOR="#0000FF">
                                <input type="submit" value="Update">
                                <input type="reset" value="Reset" style="width:60px">
                            </font>
                        </td>


                    </tr>
                </table>
                <iframe
                    src="<%=request.getContextPath()%>/ResourceRequest/comments.jsp?requestid=<%=requestid%>"
                    scrolling="auto" frameborder="2" height="40%" width="100%"></iframe>
                    <%
                        } catch (Exception e) {
                            logger.error("Exception while viewing request" + e);
                        } finally {
                            if (connection != null) {
                                connection.close();
                            }
                            if (connection1 != null) {
                                connection1.close();
                            }
                            if (rs != null) {
                                rs.close();
                            }
                            if (ps != null) {
                                ps.close();
                            }
                            if (rs1 != null) {
                                rs1.close();
                            }
                            if (st1 != null) {
                                st1.close();
                            }
                        }

                    %>
        </form>
        <div id="MDAVpopup" class="popup">
            <h3 class="popupHeading">View Attached Files</h3>
            <div>
                <div class="clear"></div>
                <div class="tableshow">
                    <div id="IssuePopupFiles">

                    </div>
                    <button class="custom-popup-close" onclick="closeIssuePopup();" type="button">close</button>

                </div>
            </div>
        </div>
    </body>
</html>