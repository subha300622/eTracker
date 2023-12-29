<%-- 
    Document   : addCandidate
    Created on : Mar 13, 2012, 10:22:02 AM
    Author     : Tamilvelan
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" errorPage="/unexpectedNotify.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <TITLE>eOutsource &trade;- Eminent Product Development Life Cycle Management</TITLE>
            <%@ include file="../noScript.jsp" %>
        <script type="text/javasctipt">
            window.history.forward(1);
            function fun(theForm){
            if (trim(theForm.file1.value)=='' ){
            alert('Please attach the file');
            document.theForm.file1.value="";
            theForm.file1.focus();
            return false;
            }
            return true;
            }

        </script>

    </head>
    <body>
        <%@ page import="com.eminent.util.*,org.apache.log4j.*" %>
        <%@ page import="pack.eminent.encryption.MakeConnection" %>
        <%@ page import="com.pack.StringUtil" %>
        <%@ page import="com.eminentlabs.erm.ERMUtil" %>
        <%@ page import="java.sql.Timestamp" %>
        <%@ page import="java.sql.Connection" %>
        <%@ page import="java.sql.Statement" %>
        <%@ page import="java.sql.PreparedStatement" %>
        <%@ page import="java.sql.ResultSet" %>
        <%@ page import="java.sql.SQLException" %>
        <%@ page import="com.eminent.util.SendMail" %>
        <%!
            String applicationid = null;
        %>
        <%
                //String check = null;
            //if(check.equals("guru")){

            //}
            Logger logger = Logger.getLogger("add Candidate");


        %>

        <%    Connection connection = null, connect = null;
            PreparedStatement ps = null, ps1 = null, p = null, prjdet = null, prjrol = null, prjhdr = null, prjsum = null, prevEmp = null;;
            Statement st = null, st1 = null;
            ResultSet rs = null, rs1 = null;

            String apj = request.getParameter("apj");
            int apjval = 0;
            String water = request.getParameter("water");
            String rti = request.getParameter("rti");
            String rte = request.getParameter("rte");
            String habits = request.getParameter("habits");
            String social = request.getParameter("social");
            String firstname = request.getParameter("firstname");
            if (apj == null) {
                water = "";
                rti = "";
                rte = "";
                habits = "";
                social = "";
                apjval = 0;
            } else {
                if (apj.equalsIgnoreCase("no")) {
                    water = "";
                    rti = "";
                    rte = "";
                    habits = "";
                    social = "";

                }
                apjval = MoMUtil.parseInteger(apj, apjval);
            }

            logger.info("Application Id" + firstname);
            session.setAttribute("firstname", firstname);
            // Retrieving form parameters
            String lastname = request.getParameter("lastname");
            String phone = request.getParameter("phone");
            String mobile = request.getParameter("mobile");
            String email = request.getParameter("email");
            logger.info("From Jsp" + email);
            session.setAttribute("email", email);
            String location = request.getParameter("location").trim();
            String refempid = request.getParameter("refempid");
            String ugcourse = request.getParameter("ugcourse");
            String pgcourse = request.getParameter("pgcourse");
            String ugbranch = request.getParameter("ugbranch");
            String pgbranch = request.getParameter("pgbranch");
            String uginstitute = request.getParameter("uginstitute");
            String pginstitute = request.getParameter("pginstitute");
            String uggraduationyear = request.getParameter("uggraduationyear");
            String pggraduationyear = request.getParameter("pggraduationyear");
            String ugpercentage = request.getParameter("ugpercentage");

            String pgpercentage = request.getParameter("pgpercentage");
            String sapyears = request.getParameter("sapyears");
            String sapmonths = request.getParameter("sapmonths");
            String totalyears = request.getParameter("totalyears");
            String totalmonths = request.getParameter("totalmonths");

            String corecompetence = request.getParameter("corecompetence");
            if (corecompetence.equalsIgnoreCase("XX")) {
                corecompetence = " ";
            }
            String areaofexpertise = request.getParameter("areaofexpertise");
            String proglanguages[] = request.getParameterValues("proglanguages");
            String languages = "";
            if (proglanguages != null) {
                for (int i = 0; i < proglanguages.length; i++) {
                    if (i == 0) {
                        languages = proglanguages[i];
                    } else {
                        languages = languages + "," + proglanguages[i];
                    }

                }
            }
            String erppackages[] = request.getParameterValues("erppackages");
            String packages = "";
            if (erppackages != null) {
                for (int i = 0; i < erppackages.length; i++) {
                    if (i == 0) {
                        packages = erppackages[i];
                    } else {
                        packages = packages + "," + erppackages[i];
                    }
                }

            }
            String operatingsystem[] = request.getParameterValues("operatingsystem");
            String os = "";
            if (operatingsystem != null) {
                for (int i = 0; i < operatingsystem.length; i++) {
                    if (i == 0) {
                        os = operatingsystem[i];
                    } else {
                        os = os + "," + operatingsystem[i];
                    }

                }
            }
            String database[] = request.getParameterValues("database");
            String db = "";
            if (database != null) {
                for (int i = 0; i < database.length; i++) {
                    if (i == 0) {
                        db = database[i];
                    } else {
                        db = db + "," + database[i];
                    }
                }

            }
            String tools = request.getParameter("tools");

            String jobtype = request.getParameter("jobtype");
            String position = request.getParameter("position");
            String desiredlocation = request.getParameter("desiredlocation");
            String noticePeriod = request.getParameter("noticeperiod");
            String expectedCtc = request.getParameter("ectc");
            String referencename = request.getParameter("referencename");
            String referencedesignation = request.getParameter("referencedesignation");
            String organization = request.getParameter("organization");
            String refemployeeid = request.getParameter("refemployeeid");
            String refcountrycode = request.getParameter("refcountrycode");
            String refstdcode = request.getParameter("refstdcode");
            String refphone = request.getParameter("refphone");
            String refMobile = request.getParameter("refmobileno");
            String refmailid = request.getParameter("refmailid");
            String dateofbirth = request.getParameter("dateofbirth").trim();
            String voterId = request.getParameter("voteridno");
            String dlNo = request.getParameter("dlno");
            String passportNo = request.getParameter("passportno");
            String gender = request.getParameter("gender");
            String maritalstatus = request.getParameter("maritalstatus");
            String pancardno = request.getParameter("pancardno");
            String mailingaddress = request.getParameter("mailingaddress");
            String city = request.getParameter("city");
            String pincode = request.getParameter("pincode");
            String summarydetails = request.getParameter("summarydetails");

            Timestamp ts = new Timestamp(new java.util.Date().getTime());

            String grad = ugcourse;
            String grdYear = uggraduationyear;
            String percentage = ugpercentage;

            if (!pgcourse.equals("")) {
                grad = pgcourse;
                if (!pggraduationyear.equals("")) {
                    grdYear = pggraduationyear;
                } else {
                    grdYear = "NA";
                }
                if (!pgpercentage.equals("")) {
                    percentage = pgpercentage;
                } else {
                    percentage = "NA";
                }
            }

            //				 Creating connection with SAP DB
            try {

                //               	Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
                //           	 	connect=DriverManager.getConnection("jdbc:sapdb://192.168.1.215/nsp","sapnsp","emi1");
                connect = MakeConnection.getConnection();

            } catch (Exception e) {
                logger.error(e.getMessage());
        %>
        <jsp:forward page="/notify.jsp"/>
        <%
            }

            int nextValue = 0;

// Checking whether the user is already registered or not
            String saveFile = "file";
            String jobprofile1 = "";
            Statement stmt = null;
            ResultSet result = null;
            try {

                stmt = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                result = stmt.executeQuery("select APPLICANT_ID,EMAIL from ERM_APPLICANT where Upper(email) like Upper('%"+email+"%')");
                logger.info("Checking Existing user");
                if (connect != null) {
                    if (result != null) {
                        if (result.next()) {
                            result.first();
                            do {
                                String fromdb = result.getString("EMAIL");
                                if (fromdb.equals(email)) {

                                    logger.info("User Exist");
                                    logger.info("From DB" + fromdb);
                                    logger.info("From User" + email);
                                    String applicantid = result.getString("APPLICANT_ID");
                                    session.setAttribute("existingmail", email);
                                    session.setAttribute("existingapid", applicantid);
        %>
        <jsp:forward page="userexist.jsp"/>
        <%
                            }
                        } while (result.next());
                    }
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        %>
        <jsp:forward page="/notify.jsp"/>
        <%
            } finally {
                try {
                    if (result != null) {
                        result.close();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }

                try {
                    if (stmt != null) {
                        stmt.close();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }

            }

            // Getting New Applicant Id from SAP Database
            try {
                applicationid = ERMUtil.getID();
                try {
                    session.setAttribute("apid", applicationid);
                    // Inserting Applicant details
                    connect.setAutoCommit(false);
                    p = connect.prepareStatement("INSERT INTO ERM_APPLICANT(APPLICANT_ID,PASSWORD,FIRSTNAME,LASTNAME,EMAIL,REFERENCE_EMPID,CURRENT_LOCATION,PHONE,MOBILE,UG,UG_BRANCH,UG_INSTITUTE,UG_YEAR,UG_PERCENTAGE,PG,PG_BRANCH,PG_INSTITUTE,PG_YEAR,PG_PERCENTAGE,SAP_EXP_YR ,SAP_EXP_MON ,TOTAL_EXP_YR ,TOTAL_EXP_MON ,CORE_COMPETENCE,AREA_OF_EXPERTISE,LANGUAGES,ERP_PACKAGES,OS,DB,TOOLS,DESIRED_JOB_TYPE,DESIRED_POSITION,DESIRED_LOCATION,NOTICE_PERIOD ,EXPECTED_CTC ,REFERENCE_NAME,REFERENCE_DESIGNATION,REFERENCE_ORG,REFERENCE_ID,REFERENCE_COUNTRY_CODE,REFERENCE_STD,REFERENCE_PHONE,REFERENCE_MOBILE,REFERENCE_EMAIL,DOB,GENDER,MARITAL_STATUS,CITY,MAILING_ADDRESS,PINCODE,PAN_NO,DRIVING_LIECENCE,VOTERID,PASSPORT_NO,PROFESSIONAL_SUMMARY,REGISTEREDON,APPLICANT_STATUS,ASSIGNEDTO,WATER,RTI,RTE,HABITS,SOCIAL,APJBOOK) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

                    p.setString(1, applicationid);
                    String date = com.eminentlabs.erm.DateUtil.GetDate();
                    logger.info("Registration Date" + date);
                    session.setAttribute("Date", date);
                    String uname = lastname.substring(0, 1) + firstname;
                    String password = applicationid + date;
                    p.setString(2, StringUtil.fixSqlFieldValue(password));
                    p.setString(3, StringUtil.fixSqlFieldValue(firstname));
                    p.setString(4, StringUtil.fixSqlFieldValue(lastname));
                    p.setString(5, StringUtil.fixSqlFieldValue(email));
                    p.setString(6, StringUtil.fixSqlFieldValue(refempid));
                    p.setString(7, StringUtil.fixSqlFieldValue(location));
                    p.setString(8, StringUtil.fixSqlFieldValue(phone));
                    p.setString(9, StringUtil.fixSqlFieldValue(mobile));
                    p.setString(10, StringUtil.fixSqlFieldValue(ugcourse));
                    p.setString(11, StringUtil.fixSqlFieldValue(ugbranch));
                    p.setString(12, StringUtil.fixSqlFieldValue(uginstitute));
                    p.setString(13, uggraduationyear);
                    if (ugpercentage.equals("")) {
                        ugpercentage = " " + 0;
                    }
                    p.setString(14, ugpercentage);
                    p.setString(15, StringUtil.fixSqlFieldValue(pgcourse));
                    p.setString(16, StringUtil.fixSqlFieldValue(pgbranch));
                    p.setString(17, StringUtil.fixSqlFieldValue(pginstitute));
                    p.setString(18, pggraduationyear);
                    if (pgpercentage.equals("")) {
                        pgpercentage = " " + 0;
                    }
                    p.setString(19, pgpercentage);
                    if (sapyears.equals("")) {
                        sapyears = "" + 0;
                    }
                    p.setString(20, sapyears);
                    if (sapmonths.equals("")) {
                        sapmonths = "" + 0;
                    }
                    p.setString(21, sapmonths);
                    if (totalyears.equals("")) {
                        totalyears = "" + 0;
                    }
                    p.setString(22, totalyears);
                    if (totalmonths.equals("")) {
                        totalmonths = "" + 0;
                    }
                    p.setString(23, totalmonths);
                    if (corecompetence.equals("")) {
                        corecompetence = " ";
                    }
                    p.setString(24, corecompetence);

                    p.setString(25, areaofexpertise);

                    p.setString(26, StringUtil.fixSqlFieldValue(languages));
                    if (packages.equals("")) {
                        packages = " ";
                    }
                    p.setString(27, StringUtil.fixSqlFieldValue(packages));
                    if (os.equals("")) {
                        os = " ";
                    }
                    p.setString(28, StringUtil.fixSqlFieldValue(os));
                    if (db.equals("")) {
                        db = " ";
                    }
                    p.setString(29, StringUtil.fixSqlFieldValue(db));
                    if (tools.equals("")) {
                        tools = " ";
                    }
                    p.setString(30, StringUtil.fixSqlFieldValue(tools));

                    if (jobtype == null) {
                        jobtype = " ";
                        logger.info("jobtype" + jobtype);
                    }
                    p.setString(31, StringUtil.fixSqlFieldValue(jobtype));
                    if (position.equals("")) {
                        position = " ";
                    }
                    p.setString(32, StringUtil.fixSqlFieldValue(position));
                    if (desiredlocation.equals("")) {
                        desiredlocation = " ";
                    }
                    p.setString(33, StringUtil.fixSqlFieldValue(desiredlocation));
                    if (referencename.equals("")) {
                        referencename = " ";
                    }
                    p.setString(34, noticePeriod);
                    if (expectedCtc.equals("")) {
                        expectedCtc = "" + 0.0;
                    }
                    p.setDouble(35, Double.parseDouble(expectedCtc));

                    p.setString(36, StringUtil.fixSqlFieldValue(referencename));
                    if (referencedesignation.equals("")) {
                        referencedesignation = " ";
                    }
                    p.setString(37, StringUtil.fixSqlFieldValue(referencedesignation));
                    if (organization.equals("")) {
                        organization = " ";
                    }
                    p.setString(38, StringUtil.fixSqlFieldValue(organization));

                    if (refemployeeid.equals("")) {
                        refemployeeid = " ";
                    }
                    p.setString(39, StringUtil.fixSqlFieldValue(refemployeeid));
                    if (refcountrycode.equals("")) {
                        refcountrycode = "" + 0;
                    }
                    p.setInt(40, Integer.parseInt(refcountrycode));
                    if (refstdcode.equals("")) {
                        refstdcode = "" + 0;
                    }
                    p.setInt(41, Integer.parseInt(refstdcode));
                    if (refphone.equals("")) {
                        refphone = " ";
                    }
                    p.setString(42, refphone);
                    if (refmailid.equals("")) {
                        refmailid = " ";
                    }
                    p.setString(43, StringUtil.fixSqlFieldValue(refMobile));
                    if (refmailid.equals("")) {
                        refmailid = " ";
                    }
                    p.setString(44, StringUtil.fixSqlFieldValue(refmailid));
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                    p.setDate(45, new java.sql.Date(sdf.parse(dateofbirth).getTime()));
                    if (gender.equals("")) {
                        gender = " ";
                    }
                    p.setString(46, StringUtil.fixSqlFieldValue(gender));
                    if (maritalstatus.equalsIgnoreCase("X")) {
                        maritalstatus = " ";
                    }
                    p.setString(47, StringUtil.fixSqlFieldValue(maritalstatus));
                    if (city.equalsIgnoreCase("X")) {
                        city = " ";
                    }
                    p.setString(48, StringUtil.fixSqlFieldValue(city));
                    if (pincode.equals("")) {
                        pincode = " ";
                    }
                    p.setString(49, StringUtil.fixSqlFieldValue(mailingaddress));
                    p.setString(50, pincode);
                    if (pancardno.equals("")) {
                        pancardno = " ";
                    }
                    p.setString(51, pancardno);

                    p.setString(52, dlNo);
                    if (voterId.equals("")) {
                        voterId = " ";
                    }
                    p.setString(53, voterId);
                    if (passportNo.equals("")) {
                        passportNo = " ";
                    }
                    p.setString(54, passportNo);
                    if (noticePeriod.equals("")) {
                        noticePeriod = "" + 0;
                    }
                    p.setString(55, StringUtil.fixSqlFieldValue(mailingaddress));
                    p.setTimestamp(56, ts);
                    p.setInt(57, 0);
                    p.setInt(58, 676);
                    p.setString(59, water);
                    p.setString(60, rti);
                    p.setString(61, rte);
                    p.setString(62, habits);
                    p.setString(63, social);
                    p.setInt(64, apjval);
                    int i = p.executeUpdate();
                    logger.info("Executed in Applicant Creation" + i);
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }

                Statement expSt = null;
                ResultSet expRs = null;
                // Inserting Previous Employer details
                try {

                    prevEmp = connect.prepareStatement("INSERT INTO ERM_APPLICANT_EXPERIENCE(APPLICANT_ID,EXPERIENCE_ID,CURRENT_EMPLOYER,CURRENT_CTC,CURRENT_DOJ,CURRENT_DESIGNATION,CURRENT_ROLE,RELIEVING_DATE,JOB_PROFILE) VALUES(?,?,?,?,?,?,?,?,?)");
                    String prevEmployer = request.getParameter("maxemp");
                    int noofPrevEmployer = 1;
                    int expId = 1;
                    if (prevEmployer != null) {
                        noofPrevEmployer = Integer.parseInt(prevEmployer);
                    }
                    int count = 1;
                    for (int prevEmpNo = 1; prevEmpNo <= noofPrevEmployer; prevEmpNo++) {

                        try {
                            expSt = connect.createStatement();
                            expRs = expSt.executeQuery("select EXPERIENCE_ID_SEQ.nextval as expid from dual");
                            if (expRs != null) {
                                if (expRs.next()) {
                                    nextValue = expRs.getInt("expid");
                                    expId = nextValue;
                                    logger.info("Experience ID" + expId);
                                }
                            } else {
                                expId = 1;
                            }
                        } catch (Exception e) {
                            logger.error(e.getMessage());
                        } finally {
                            try {
                                if (expSt != null) {
                                    expSt.close();
                                }
                            } catch (Exception e) {
                                logger.error(e.getMessage());
                            }

                            try {
                                if (expRs != null) {
                                    expRs.close();
                                }
                            } catch (SQLException e) {
                                logger.error(e.getMessage());
                            }
                        }
                        String previousemployer = "previousemployer" + prevEmpNo;

                        previousemployer = request.getParameter(previousemployer);

                        if (previousemployer != null) {

                            if (!previousemployer.equals("")) {

                                String ctc = "ctc" + prevEmpNo;
                                String designation = "designation" + prevEmpNo;
                                String empRole = "role" + prevEmpNo;
                                String jobprofile = "jobprofile" + prevEmpNo;
                                String joiningdate = "joiningdate" + prevEmpNo;
                                String relievingdate = "relievingdate" + prevEmpNo;

                                ctc = request.getParameter(ctc);
                                designation = request.getParameter(designation);
                                empRole = request.getParameter(empRole);
                                jobprofile = request.getParameter(jobprofile);
                                joiningdate = request.getParameter(joiningdate).trim();
                                relievingdate = request.getParameter(relievingdate).trim();

                                String profileFirst = null;
                                String profileSecond = null;
                                if (joiningdate.equals("")) {
                                    joiningdate = " ";
                                    logger.info("Joining Date" + joiningdate);
                                } else {

                                    joiningdate = (com.pack.ChangeFormat.getDateFormat(joiningdate));
                                }
                                if (relievingdate.equals("")) {
                                    relievingdate = " ";
                                    logger.info("relievingdate" + relievingdate);
                                } else {
                                    relievingdate = (com.pack.ChangeFormat.getDateFormat(relievingdate));
                                }
                                if (jobprofile.equals("")) {
                                    jobprofile = " ";
                                }

                                if (ctc.equals("")) {
                                    ctc = "" + 0.0;
                                }
                                logger.info("Applicant Id" + applicationid);
                                logger.info("Experience Id" + expId);
                                logger.info("CTC" + ctc);
                                logger.info("Previous Employer" + previousemployer);
                                logger.info("Joining Date" + joiningdate);
                                logger.info("designation" + designation);
                                logger.info("Emp Role" + empRole);
                                logger.info("Relieving Date" + relievingdate);
                                logger.info("Job Pfofile" + profileFirst);

                                prevEmp.setString(1, applicationid);
                                prevEmp.setInt(2, expId);
                                prevEmp.setString(3, StringUtil.fixSqlFieldValue(previousemployer));
                                prevEmp.setDouble(4, Double.parseDouble(ctc));
                                prevEmp.setDate(5, java.sql.Date.valueOf(joiningdate));
                                prevEmp.setString(6, StringUtil.fixSqlFieldValue(designation));
                                prevEmp.setString(7, StringUtil.fixSqlFieldValue(empRole));
                                prevEmp.setDate(8, java.sql.Date.valueOf(relievingdate));
                                prevEmp.setString(9, StringUtil.fixSqlFieldValue(profileFirst));

                                prevEmp.execute();

                            }
                        }

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }

                // Adding Project Details
                prjhdr = connect.prepareStatement("INSERT INTO ERM_APPLICANT_PROJECT(APPLICANT_ID,PROJECT_ID,PROJECT_NAME,DURATION,TEAMSIZE,CLIENT,ENVIRONMENT,DESCRIPTION,RESPONSIBILITIES) values(?,?,?,?,?,?,?,?,?)");

                // getting no of projects to be added
                String project[] = request.getParameterValues("noofproject");
                int noofprojects = project.length;
                logger.info("Total of Projects" + noofprojects);
                int prjId = 0;
                for (int pno = 1; pno <= noofprojects; pno++) {
                    try {
                        expSt = connect.createStatement();
                        expRs = expSt.executeQuery("select PROJECT_ID_SEQ.nextval as expid from dual");
                        if (expRs != null) {
                            if (expRs.next()) {
                                nextValue = expRs.getInt("expid");
                                prjId = nextValue;
                                logger.info("Project ID" + prjId);
                            }
                        } else {
                            prjId = 1;
                        }
                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    } finally {
                        try {
                            if (expSt != null) {
                                expSt.close();
                            }
                        } catch (Exception e) {
                            logger.error(e.getMessage());
                        }

                        try {
                            if (expRs != null) {
                                expRs.close();
                            }
                        } catch (SQLException e) {
                            logger.error(e.getMessage());
                        }
                    }

                    String pname = "projectname" + pno;
                    String projectname = request.getParameter(pname);

                    if (pname != null) {

                        if (!pname.equals("")) {

                            String dura = "duration" + pno;
                            String team = "teamsize" + pno;
                            String cli = "client" + pno;
                            String env = "environment" + pno;
                            String des = "description" + pno;
                            String rol = "roles" + pno;

                            String duration = request.getParameter(dura);
                            String teamsize = request.getParameter(team);
                            String client = request.getParameter(cli);
                            String environment = request.getParameter(env);
                            String description = request.getParameter(des);
                            String roles = request.getParameter(rol);

                            logger.info("PNAME" + projectname);
                            logger.info("Duration" + duration);
                            logger.info("Team Size" + teamsize);
                            logger.info("Client" + client);
                            logger.info("Environment" + environment);
                            logger.info("Description" + description);
                            logger.info("Project Roles" + roles);

//                              Inserting Value in  Project Header
                            prjhdr.setString(1, applicationid);
                            prjhdr.setInt(2, prjId);
                            prjhdr.setString(3, StringUtil.fixSqlFieldValue(projectname));
                            prjhdr.setString(4, StringUtil.fixSqlFieldValue(duration));
                            if (teamsize == null) {
                                teamsize = "" + 0;
                            }

                            prjhdr.setString(5, teamsize);
                            prjhdr.setString(6, StringUtil.fixSqlFieldValue(client));
                            prjhdr.setString(7, StringUtil.fixSqlFieldValue(environment));
                            prjhdr.setString(8, StringUtil.fixSqlFieldValue(description));
                            prjhdr.setString(9, StringUtil.fixSqlFieldValue(roles));
                            int headerupdate = prjhdr.executeUpdate();
                            logger.info("Project Updated" + headerupdate);

                            // Inserting Values into role
                        }
                    }
                }
                connect.commit();

            } catch (SQLException e) {
                try {
                    if (connect != null) {
                        connect.rollback();
                    }
                } catch (Exception ex) {
                    logger.error(e.getMessage());
                }

                logger.error(e.getMessage());
        %>
        <jsp:forward page="/notify.jsp"/>
        <%
            } finally {

                try {
                    if (st != null) {
                        st.close();
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }

                try {
                    if (rs != null) {
                        rs.close();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }

                try {
                    if (p != null) {
                        p.close();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }

                try {
                    if (prevEmp != null) {
                        prevEmp.close();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }

                try {
                    if (prjsum != null) {
                        prjsum.close();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }

                try {
                    if (prjhdr != null) {
                        prjhdr.close();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }

                try {
                    if (prjdet != null) {
                        prjdet.close();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }

                try {
                    if (prjrol != null) {
                        prjrol.close();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }

                try {
                    if (connect != null) {
                        connect.close();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }

            }

            // Sending Mail to Gopal and Tamil
            String adminMail = "<table>"
                    + "<tr>"
                    + "<td>Dear Gopal,</td>"
                    + "</tr>"
                    + "<tr>"
                    + "<td>New Candidate has been registered</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7>"
                    + "<td>Name</td><td>" + firstname + " " + lastname + "</td>"
                    + "<td>Location</td><td>" + location + "</td>"
                    + "</tr>"
                    + "<tr>"
                    + "<td>Qualification</td><td>" + grad + "</td>"
                    + "<td>Graduation Year</td><td>" + grdYear + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7>"
                    + "<td>Percentage</td><td>" + percentage + "</td>"
                    + "<td>Module</td><td>" + areaofexpertise + "</td>"
                    + "</tr>"
                    + "<tr  >"
                    + "<td>SAP Experience</td><td>" + sapyears + "Y " + sapmonths + "M</td>"
                    + "<td>Overall Experience</td><td>" + totalyears + "Y " + totalmonths + "M</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7>"
                    + "<td>Applicant Id</td><td>" + applicationid + "</td>"
                    + "<td>Referred By</td><td>" + refempid + "</td>"
                    + "</tr>"
                    + "</table>";
            String endLine = "</table><br>Thanks,";
            String signature = "<br>eTracker&trade;<br>";
            String emi = "<br><b><a href=https://www.eminentlabs.net/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
            String lineBreak = "<br>";

            String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.net/eTracker/login.jsp target=_new>eTracker&trade;</a>";
            adminMail = adminMail + endLine + signature + htmlTableEnd + lineBreak + emi;

            try {

                SendMail.ERMIntimation(adminMail, "New Candidate has been registered in eTracker");
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        %>
        <FORM name=theForm onsubmit="return fun(this)" action="<%=request.getContextPath()%>/ERM/uploadresume.jsp" method=post method="post"  enctype="multipart/form-data">
            <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
            <table width="80%" align=center border="0" bgcolor="#E8EEF7">
                <tr>
                    <td width="18%"><strong>Resume Attachment<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="file" name="file1" size="80"/></td>
                    <td><input type="hidden" name="apid" size="80"  value="<%=applicationid%>"/></td>
                </tr>
            </table>
            <TABLE width="80%" align=center  bgColor=#E8EEF7 border="0">
                <tr>
                    <TD>&nbsp;</TD>
                    <TD align=right><INPUT  type=submit value=Submit name=submit></TD>
                    <TD><INPUT  type=reset value=" Reset "></TD>
                </tr>
            </TABLE>
        </FORM>
    </body>
</html>