/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminent.util.SendMail;
import com.eminentlabs.mom.MoMUtil;
import com.pack.StringUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author admin
 */
public class Addcondidtate {

    Logger logger = Logger.getLogger("add ERM Candidate");
    static String applicationid = "";

    public String addNewCandidate(HttpServletRequest request) {
        String addcandidate = "false";
        Connection connection = null;
        PreparedStatement p = null, ps = null, prjdet = null, prjrol = null, prjhdr = null, prjsum = null, prevEmp = null;
        if (request.getMethod().equalsIgnoreCase("post")) {
            try {
                HttpSession session = request.getSession();
                String apj = request.getParameter("apj");
                int apjval = 0;
                String water = request.getParameter("water");
                String rti = request.getParameter("rti");
                String rte = request.getParameter("rte");
                String habits = request.getParameter("habits");
                String social = request.getParameter("social");
                String firstname = request.getParameter("firstname");
                if (firstname == null || firstname.isEmpty()) {
                    firstname = "";
                }
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

                logger.info("firstname" + firstname);
                session.setAttribute("firstname", firstname);
                String lastname = request.getParameter("lastname");
                if (lastname == null || lastname.isEmpty()) {
                    lastname = "";
                }
                String phone = request.getParameter("phone");

                String mobile = request.getParameter("mobile");
                if (mobile == null || mobile.isEmpty()) {
                    mobile = "";
                }
                String email = request.getParameter("email");
                if (email == null || email.isEmpty() || email.equals("")) {
                    email = "";
                }
                logger.info("Email candidate Erm" + email);
                session.setAttribute("email", email);
                String location = request.getParameter("location").trim();
                if (location == null || location.isEmpty()) {
                    location = "";
                }
                String refempid = request.getParameter("refempid");
                if (refempid == null || refempid.isEmpty()) {
                    refempid = "";
                }
                String ugcourse = request.getParameter("ugcourse");
                if (ugcourse == null || ugcourse.isEmpty()) {
                    ugcourse = "";
                }
                String pgcourse = request.getParameter("pgcourse");
                String ugbranch = request.getParameter("ugbranch");
                if (ugbranch == null || ugbranch.isEmpty()) {
                    ugbranch = "";
                }
                String pgbranch = request.getParameter("pgbranch");
                String uginstitute = request.getParameter("uginstitute");
                if (uginstitute == null || uginstitute.isEmpty()) {
                    uginstitute = "";
                }
                String pginstitute = request.getParameter("pginstitute");
                String uggraduationyear = request.getParameter("uggraduationyear");
                if (uggraduationyear == null || uggraduationyear.isEmpty()) {
                    uggraduationyear = "";
                }
                String pggraduationyear = request.getParameter("pggraduationyear");
                String ugpercentage = request.getParameter("ugpercentage");
                if (ugpercentage == null || ugpercentage.isEmpty()) {
                    ugpercentage = "";
                }

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
                if (areaofexpertise == null | areaofexpertise.isEmpty()) {
                    areaofexpertise = "";
                }
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
                if (desiredlocation == null || desiredlocation.isEmpty()) {
                    desiredlocation = "";
                }
                String noticePeriod = request.getParameter("noticeperiod");
                String expectedCtc = request.getParameter("ectc");
                if (expectedCtc == null || expectedCtc.isEmpty()) {
                    expectedCtc = "";
                }
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
                if (dateofbirth == null || dateofbirth.isEmpty()) {
                    dateofbirth = "";
                }
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

                try {
                    connection = MakeConnection.getConnection();
                    applicationid = ERMUtil.getID();
                    session.setAttribute("apid", applicationid);
                    int nextValue = 0;
                    connection.setAutoCommit(false);
                    try {
                        p = connection.prepareStatement("INSERT INTO ERM_APPLICANT(APPLICANT_ID,PASSWORD,FIRSTNAME,LASTNAME,EMAIL,REFERENCE_EMPID,CURRENT_LOCATION,PHONE,MOBILE,UG,UG_BRANCH,UG_INSTITUTE,UG_YEAR,UG_PERCENTAGE,PG,PG_BRANCH,PG_INSTITUTE,PG_YEAR,PG_PERCENTAGE,SAP_EXP_YR ,SAP_EXP_MON ,TOTAL_EXP_YR ,TOTAL_EXP_MON ,CORE_COMPETENCE,AREA_OF_EXPERTISE,LANGUAGES,ERP_PACKAGES,OS,DB,TOOLS,DESIRED_JOB_TYPE,DESIRED_POSITION,DESIRED_LOCATION,NOTICE_PERIOD ,EXPECTED_CTC ,REFERENCE_NAME,REFERENCE_DESIGNATION,REFERENCE_ORG,REFERENCE_ID,REFERENCE_COUNTRY_CODE,REFERENCE_STD,REFERENCE_PHONE,REFERENCE_MOBILE,REFERENCE_EMAIL,DOB,GENDER,MARITAL_STATUS,CITY,MAILING_ADDRESS,PINCODE,PAN_NO,DRIVING_LIECENCE,VOTERID,PASSPORT_NO,PROFESSIONAL_SUMMARY,REGISTEREDON,APPLICANT_STATUS,ASSIGNEDTO,WATER,RTI,RTE,HABITS,SOCIAL,APJBOOK) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

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
                        p.setInt(58, getProjectManagerFromERM());
                        p.setString(59, water);
                        p.setString(60, rti);
                        p.setString(61, rte);
                        p.setString(62, habits);
                        p.setString(63, social);
                        p.setInt(64, apjval);
                        int i = p.executeUpdate();
                        logger.info("Executed in Applicant Creation" + i);

                        Statement expSt = null;
                        ResultSet expRs = null;

                        try {

                            prevEmp = connection.prepareStatement("INSERT INTO ERM_APPLICANT_EXPERIENCE(APPLICANT_ID,EXPERIENCE_ID,CURRENT_EMPLOYER,CURRENT_CTC,CURRENT_DOJ,CURRENT_DESIGNATION,CURRENT_ROLE,RELIEVING_DATE,JOB_PROFILE) VALUES(?,?,?,?,?,?,?,?,?)");
                            String prevEmployer = request.getParameter("maxemp");
                            int noofPrevEmployer = 1;
                            int expId = 1;
                            if (prevEmployer != null) {
                                noofPrevEmployer = Integer.parseInt(prevEmployer);
                            }
                            int count = 1;
                            for (int prevEmpNo = 1; prevEmpNo <= noofPrevEmployer; prevEmpNo++) {

                                try {
                                    expSt = connection.createStatement();
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

                            prjhdr = connection.prepareStatement("INSERT INTO ERM_APPLICANT_PROJECT(APPLICANT_ID,PROJECT_ID,PROJECT_NAME,DURATION,TEAMSIZE,CLIENT,ENVIRONMENT,DESCRIPTION,RESPONSIBILITIES) values(?,?,?,?,?,?,?,?,?)");

                            // getting no of projects to be added
                            String project[] = request.getParameterValues("noofproject");
                            int noofprojects = project.length;
                            logger.info("Total of Projects" + noofprojects);
                            int prjId = 0;
                            for (int pno = 1; pno <= noofprojects; pno++) {
                                try {
                                    expSt = connection.createStatement();
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
                                        int durati = MoMUtil.parseInteger(duration, 0);
                                        if (durati == 0) {
                                            duration = "" + 0;
                                        }
                                        String teamsize = request.getParameter(team);
                                        int tsize = MoMUtil.parseInteger(teamsize, 0);
                                        if (tsize == 0) {
                                            teamsize = "" + 0;
                                        }
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

                                    }
                                }
                            }
                            connection.commit();
                            addcandidate = "true";
                            try {
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
                                String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                                String lineBreak = "<br>";

                                String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                                adminMail = adminMail + endLine + signature + htmlTableEnd + lineBreak + emi;

                                try {

                                    SendMail.ERMIntimation(adminMail, "New Candidate has been registered in eTracker");
                                } catch (Exception e) {
                                    logger.error(e.getMessage());
                                }
                            } catch (Exception e) {
                                logger.error(e.getMessage());
                            }
                        } catch (SQLException e) {
                            try {
                                if (connection != null) {
                                    connection.rollback();
                                }
                            } catch (Exception ex) {
                                logger.error(ex.getMessage());
                            }

                        } catch (Exception e) {
                            logger.error(e.getMessage());
                        }

                    } catch (SQLException e) {
                        logger.error(e.getMessage());
                    } finally {
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
                            if (connection != null) {
                                connection.close();
                            }
                        } catch (SQLException e) {
                            logger.error(e.getMessage());
                        }

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());

                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }

        }

        return addcandidate;
    }

    public String caheckAlreadyUserExits(HttpServletRequest request) {
        String alreadyEmail = "true";
        Statement stmt = null;
        ResultSet result = null;
        Connection connection = null;
        try {
            HttpSession session = request.getSession();
            String email = request.getParameter("email");
            if (email == null || email.isEmpty() || email.equals("")) {
                email = "";
            }
            connection = MakeConnection.getConnection();
            stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select APPLICANT_ID,EMAIL from ERM_APPLICANT  where EMAIL='" + email + "'";
            result = stmt.executeQuery(sql);
            logger.info("Checking Existing user");
            if (connection != null) {
                if (result != null) {
                    if (result.next()) {
                        do {
                            String fromdb = result.getString("EMAIL");
                            String applicantid = result.getString("APPLICANT_ID");
                            if (fromdb != null || !"".equalsIgnoreCase(fromdb)) {
                                logger.info("User Exist");
                                logger.info("From DB" + fromdb);
                                logger.info("From User" + email);
                                alreadyEmail = "true";
                                session.setAttribute("existingmail", fromdb);
                                session.setAttribute("existingapid", applicantid);
                            } else {
                                alreadyEmail = "false";
                            }
                        } while (result.next());
                    } else {
                        alreadyEmail = "false";
                    }
                } else {
                    alreadyEmail = "false";
                }

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (result != null) {
                    result.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return alreadyEmail;
    }

    public String addNewCandidate(String firstname, String lastname, String db, String phone, String mobile, String email, String dateofbirth, String location, String pincode, String city, String ugcourse, String pgcourse, String uginstitute, String pginstitute, String jobtype, String summarydetails, String pgbranch, String ugbranch, String sapyears, String sapmonths, String totalyears, String totalmonths, String refempid, String pgpercentage, String ugpercentage, String gender, String maritalstatus, String pancardno, String dlNo, String passportNo, String mailingaddress, String apj, String water, String rti, String rte, String habits, String social, String uggraduationyear, String pggraduationyear, String corecompetence, String areaofexpertise, String tools, String desiredlocation, String position, String expectedCtc, String referencename, String noticePeriod, String languages, String packages, String os, String referencedesignation, String organization, String refemployeeid, String refcountrycode, String refstdcode, String refphone, String refMobile, String refmailid, String voterId, String prevEmployer, String ctc, String joiningdate, String designation, String empRole, String relievingdate, String jobprofile, String pname, String dura, String team, String cli, String env, String rol, String dess, String aadhaar) {
        String addcandidate = "false";
        Connection connection = null;
        PreparedStatement p = null, ps = null;
        Statement expSt = null;
        ResultSet expRs = null;
        String expAdd = "";
        PreparedStatement prevEmp = null, prjhdr = null;

        int apjval = 0, nextValue = 0;

        if (firstname == null || firstname.isEmpty()) {
            firstname = "";
        }
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

        try {
            connection = MakeConnection.getConnection();
            applicationid = ERMUtil.getID();

            //   connection.setAutoCommit(false);
            try {
                p = connection.prepareStatement("INSERT INTO ERM_APPLICANT(APPLICANT_ID,PASSWORD,FIRSTNAME,LASTNAME,EMAIL,REFERENCE_EMPID,CURRENT_LOCATION,PHONE,MOBILE,UG,UG_BRANCH,UG_INSTITUTE,UG_YEAR,UG_PERCENTAGE,PG,PG_BRANCH,PG_INSTITUTE,PG_YEAR,PG_PERCENTAGE,SAP_EXP_YR ,SAP_EXP_MON ,TOTAL_EXP_YR ,TOTAL_EXP_MON ,CORE_COMPETENCE,AREA_OF_EXPERTISE,LANGUAGES,ERP_PACKAGES,OS,DB,TOOLS,DESIRED_JOB_TYPE,DESIRED_POSITION,DESIRED_LOCATION,NOTICE_PERIOD ,EXPECTED_CTC ,REFERENCE_NAME,REFERENCE_DESIGNATION,REFERENCE_ORG,REFERENCE_ID,REFERENCE_COUNTRY_CODE,REFERENCE_STD,REFERENCE_PHONE,REFERENCE_MOBILE,REFERENCE_EMAIL,DOB,GENDER,MARITAL_STATUS,CITY,MAILING_ADDRESS,PINCODE,PAN_NO,DRIVING_LIECENCE,VOTERID,PASSPORT_NO,PROFESSIONAL_SUMMARY,REGISTEREDON,APPLICANT_STATUS,ASSIGNEDTO,WATER,RTI,RTE,HABITS,SOCIAL,APJBOOK,ISFAKE,AADHAAR) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                //  System.out.print("application is id:" + applicationid);
                p.setString(1, applicationid);
                String date = com.eminentlabs.erm.DateUtil.GetDate();
                String uname = lastname.substring(0, 1) + firstname;
                String password = applicationid + date;
                p.setString(2, StringUtil.fixSqlFieldValue(password));
                p.setString(3, StringUtil.fixSqlFieldValue(firstname));
                p.setString(4, StringUtil.fixSqlFieldValue(lastname));
                p.setString(5, StringUtil.fixSqlFieldValue(email));
                p.setString(6, StringUtil.fixSqlFieldValue(refempid.toUpperCase()));
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
                // System.out.print("value are in addcondidate:" + applicationid + "," + password + "," + firstname + "," + lastname + "," + email + "," + refempid + "," + location + "," + phone + "," + mobile + "," + ugcourse + "," + ugbranch + "," + uginstitute + "," + uggraduationyear + "," + ugpercentage + "," + pgcourse + "," + pgpercentage + "," + pgbranch + "," + pginstitute + "," + pggraduationyear);
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
                    totalyears = "0";
                }
                p.setString(22, totalyears);
                if (totalmonths.equals("")) {
                    totalmonths = "0";
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
                p.setInt(58, getProjectManagerFromERM());
                p.setString(59, water);
                p.setString(60, rti);
                p.setString(61, rte);
                p.setString(62, habits);
                p.setString(63, social);
                p.setInt(64, apjval);
                p.setInt(65, 0);
                p.setString(66, aadhaar);

//                System.out.print("value are in addcondidate:ts" + mailingaddress + "," + ts + "," + 0 + "," + 676 + "," + water + "," + rti + "," + rte + "," + habits + "," + social + "," + apjval);
//                System.out.println("  dsfghh hgdgh ngg" + p);
                int i = p.executeUpdate();
                addcandidate = "true" + "," + applicationid;
                int totExp = Integer.parseInt(totalmonths) + (Integer.parseInt(totalyears) * 12);
                // addNewExperience(applicationid,prevEmployer, ctc, joiningdate, designation, empRole, relievingdate, jobprofile);
                if (totExp > 0 && prevEmployer != null) {
                    int expId = 1;
                    String prevEmployers[] = prevEmployer.trim().split("@@");
                    String ctcs[] = ctc.trim().split("@@");
                    String joiningdates[] = joiningdate.trim().split("@@");
                    String designations[] = designation.trim().split("@@");
                    String empRoles[] = empRole.trim().split("@@");
                    String relievingdates[] = relievingdate.trim().split("@@");
                    String jobprofiles[] = jobprofile.split("@@");
                    String jobpro = " ";
                    prevEmp = connection.prepareStatement("INSERT INTO ERM_APPLICANT_EXPERIENCE(APPLICANT_ID,EXPERIENCE_ID,CURRENT_EMPLOYER,CURRENT_CTC,CURRENT_DOJ,CURRENT_DESIGNATION,CURRENT_ROLE,RELIEVING_DATE,JOB_PROFILE) VALUES(?,?,?,?,?,?,?,?,?)");
                    for (int j = 0; j < prevEmployers.length; j++) {
                        //  System.out.print("prevemployear ata query:" + prevEmployers[j]);
                        if (!prevEmployers[j].equals("")) {
                            expId = 1;
                            try {
                                expSt = connection.createStatement();
                                expRs = expSt.executeQuery("select EXPERIENCE_ID_SEQ.nextval as expid from dual");
                                if (expRs != null) {
                                    if (expRs.next()) {
                                        nextValue = expRs.getInt("expid");
                                        expId = nextValue;
                                        logger.error("Experience ID" + expId);
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
                            if (joiningdates[j].equals("")) {
                                joiningdates[j] = " ";
                                logger.info("Joining Date" + joiningdate);
                            } else {
                                joiningdates[j] = (com.pack.ChangeFormat.getDateFormat(joiningdates[j]));
                            }
                            if (relievingdates[j].equals("")) {
                                relievingdates[j] = " ";
                                logger.info("relievingdate" + relievingdate);
                            } else {
                                relievingdates[j] = (com.pack.ChangeFormat.getDateFormat(relievingdates[j]));
                            }
                            try {
                                jobpro = jobprofiles[j];
                            } catch (ArrayIndexOutOfBoundsException e) {
                                jobpro = " ";
                            }

                            if (ctcs[j].equals("")) {
                                ctcs[j] = "" + 0.0;
                            }
                            prevEmp.setString(1, applicationid);
                            prevEmp.setInt(2, expId);
                            prevEmp.setString(3, StringUtil.fixSqlFieldValue(prevEmployers[j]));
                            prevEmp.setDouble(4, Double.parseDouble(ctcs[j]));
                            prevEmp.setDate(5, java.sql.Date.valueOf(joiningdates[j]));
                            prevEmp.setString(6, StringUtil.fixSqlFieldValue(designations[j]));
                            prevEmp.setString(7, StringUtil.fixSqlFieldValue(empRoles[j]));
                            prevEmp.setDate(8, java.sql.Date.valueOf(relievingdates[j]));
                            prevEmp.setString(9, StringUtil.fixSqlFieldValue(jobpro));
                            prevEmp.execute();
                        }
                    }
                }
                String projectname[] = pname.trim().split("@@@@@");
                String duration[] = dura.trim().split("@@@@@");
                String teamsize[] = team.trim().split("@@@@@");
                String environment[] = env.trim().split("@@@@@");
                String roles[] = rol.trim().split("@@@@@");
                String client[] = cli.trim().split("@@@@@");
                String description[] = dess.trim().split("@@@@@");

                prjhdr = connection.prepareStatement("INSERT INTO ERM_APPLICANT_PROJECT(APPLICANT_ID,PROJECT_ID,PROJECT_NAME,DURATION,TEAMSIZE,CLIENT,ENVIRONMENT,DESCRIPTION,RESPONSIBILITIES) values(?,?,?,?,?,?,?,?,?)");

                int prjId = 0;

                for (int pno = 0; pno < projectname.length; pno++) {
                    //   System.out.print("iam here proejct execution after sql length od pname:"+projectname.length+","+projectname[pno]);
                    if (!projectname[pno].equals("")) {

                        try {
                            expSt = connection.createStatement();
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

                        int durati = MoMUtil.parseInteger(duration[pno], 0);
                        if (durati == 0) {
                            duration[pno] = "" + 0;
                        }
                        int tsize = MoMUtil.parseInteger(teamsize[pno], 0);
                        if (tsize == 0) {
                            teamsize[pno] = "" + 0;
                        }
                        prjhdr.setString(1, applicationid);
                        prjhdr.setInt(2, prjId);
                        prjhdr.setString(3, StringUtil.fixSqlFieldValue(projectname[pno]));
                        prjhdr.setString(4, StringUtil.fixSqlFieldValue(duration[pno]));
                        if (teamsize[pno] == null) {
                            teamsize[pno] = "" + 0;
                        }
                        prjhdr.setString(5, teamsize[pno]);
                        prjhdr.setString(6, StringUtil.fixSqlFieldValue(client[pno]));
                        prjhdr.setString(7, StringUtil.fixSqlFieldValue(environment[pno]));
                        prjhdr.setString(8, StringUtil.fixSqlFieldValue(description[pno]));
                        prjhdr.setString(9, StringUtil.fixSqlFieldValue(roles[pno]));
                        int headerupdate = prjhdr.executeUpdate();
                        logger.error("Project Updated" + headerupdate);

                    }
                }
                addcandidate = "true" + "," + applicationid;
            } catch (SQLException e) {
                e.printStackTrace();
                try {
                    if (prjhdr != null) {
                        prjhdr.close();;
                    }

                } catch (Exception ex) {
                    logger.error(ex.getMessage());
                }
                try {
                    if (connection != null) {
                        connection.close();
                    }
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {
                if (prevEmp != null) {
                    prevEmp.close();
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
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }

        }

        // System.out.print("add candidate value is:" + addcandidate);
        return addcandidate;
    }

    public String caheckAlreadyUserExitss(String email) {
        String alreadyEmail = "true";
        Statement stmt = null;
        ResultSet result = null;
        Connection connection = null;
        String fromdb = "", applicantid = "";
        try {

            if (email == null || email.isEmpty() || email.equals("")) {
                email = "";
            }
            connection = MakeConnection.getConnection();
            stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            String sql = "select APPLICANT_ID,EMAIL from ERM_APPLICANT  where EMAIL='" + email + "'";

            result = stmt.executeQuery(sql);
            if (connection != null) {
                if (result != null) {
                    if (result.next()) {
                        do {
                            fromdb = result.getString("EMAIL");
                            applicantid = result.getString("APPLICANT_ID");
                            if (fromdb != null || !"".equalsIgnoreCase(fromdb)) {

                                alreadyEmail = "existed";

                            } else {
                                alreadyEmail = "notexisted";
                            }
                        } while (result.next());
                    } else {
                        alreadyEmail = "notexisted";
                    }
                } else {
                    alreadyEmail = "notexisted";
                }

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (result != null) {
                    result.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return alreadyEmail + "," + fromdb + "-" + applicantid;
    }

    public Set<String> getMailIdFromERM() {
        Set<String> mailId = new LinkedHashSet<String>();
        Statement stmt = null;
        ResultSet result = null;
        Connection connection = null;
        try {
            connection = MakeConnection.getConnection();
            stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            result = stmt.executeQuery("select email from project p,users u  where pname  = 'ERM' and u.userid=p.PMANAGER and u.roleid>0\n"
                    + "union all\n"
                    + "select email from userproject up, project p,users u  where up.pid=p.pid and  pname  = 'ERM' and u.userid=up.userid and u.roleid>0");
            while (result.next()) {
                mailId.add(result.getString("email"));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (result != null) {
                    result.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return mailId;
    }

    public int getProjectManagerFromERM() {
        int pmanager = 104;
        Statement stmt = null;
        ResultSet result = null;
        Connection connection = null;
        try {

            connection = MakeConnection.getConnection();
            stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            result = stmt.executeQuery("select PMANAGER from project p where pname  = 'ERM'");
            while (result.next()) {
                pmanager = result.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (result != null) {
                    result.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return pmanager;
    }

    public String getApplicationid() {
        if (applicationid == null) {
            applicationid = "";
        }
        return applicationid;
    }

    public void setApplicationid(String applicationid) {
        this.applicationid = applicationid;
    }

}
