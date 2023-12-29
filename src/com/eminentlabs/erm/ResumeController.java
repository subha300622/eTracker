package com.eminentlabs.erm;

//import static com.eminentlabs.erm.Addcondidtate.applicationid;
import static com.eminentlabs.erm.Addcondidtate.applicationid;
import com.eminentlabs.mom.MoMUtil;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Message;
import pack.eminent.encryption.MakeConnection;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author EMINENT
 */
public class ResumeController {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ResumeController");
    }

    String message = "";
    String apids = "", existingmail = "", existingapid = "";
    // private Object response;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String resumeUpload(HttpServletRequest request, HttpServletResponse response, ServletContext context) throws Exception {
        if (request.getMethod().equalsIgnoreCase("post")) {
            Addcondidtate adc = new Addcondidtate();

            String firstname = "", lastname = "", db = "", phone = "", mobile = "", email = "", dateofbirth = "", location = "", pincode = "", city = "", ugcourse = "", pgcourse = "", uginstitute = "", pginstitute = "", jobtype = "", summarydetails = "", pgbranch = "", ugbranch = "", sapyears = "0", sapmonths = "0", totalyears = "0", totalmonths = "0", refempid = "", pgpercentage = "", ugpercentage = "", gender = "", maritalstatus = "", pancardno = "", dlNo = "", passportNo = "", mailingaddress = "", aadhaar = "";
            String apj = "", water = "", rti = "", rte = "", habits = "", social = "", uggraduationyear = "", pggraduationyear = "", corecompetence = "", areaofexpertise = "", tools = "", desiredlocation = "", position = "", expectedCtc = "", referencename = "", noticePeriod = "", proglanguages = "", erppackages = "", os = "";
            String saveFile = null, referencedesignation = "", organization = "", refemployeeid = "", refcountrycode = "", refstdcode = "", refphone = "", refMobile = "", refmailid = "", voterId = "";
            FileItem fileItem = null;
            FileItem fileItemResume = null;
            FileItem fileItemPic = null;
            String prevEmployer = "", ctc = "", designation = "", empRole = "", jobprofile = "", joiningdate = "", relievingdate = "";
            String prevEmployers = "", ctcs = "", designations = "", empRoles = "", jobprofiles = "", joiningdates = "", relievingdates = "";
            String pname = "", dura = "", team = "", cli = "", env = "", dess = "", rol = "";
            String pnames = "", duras = "", teams = "", clis = "", envs = "", desss = "", rols = "";
            int apjval = 0;
            int i = 0;
            PreparedStatement prjhdr = null;
            Statement expSt = null;
            ResultSet expRs = null;
            Connection connection = null;

            int noofprojects = 1;
            int maxemp = 1;

            try {
                if (ServletFileUpload.isMultipartContent(request)) {
                    ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                    List fileItemsList = servletFileUpload.parseRequest(request);
                    HttpSession session = request.getSession();
                    String filePath = request.getSession().getServletContext().getInitParameter("upload-resume");
                    String filePathone = request.getSession().getServletContext().getInitParameter("upload-user-photo");

                    String dirName = filePath;
                    String dirNameone = filePathone;
                    // String optionalFileName = "";

                    Iterator it = fileItemsList.iterator();
                    while (it.hasNext()) {
                        FileItem fileItemTemp = (FileItem) it.next();
                        if (fileItemTemp.isFormField()) //your code for getting form fields
                        {
                            String name = fileItemTemp.getFieldName();

                            if (name.equalsIgnoreCase("apj")) {
                                apj = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("water")) {

                                water = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("rti")) {

                                rti = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("rte")) {
                                rte = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("habits")) {
                                habits = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("social")) {
                                social = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("firstname")) {
                                firstname = fileItemTemp.getString().trim();

                                if (firstname == null || firstname.isEmpty()) {
                                    firstname = "";
                                }

                            }
                            if (name.equalsIgnoreCase("lastname")) {
                                lastname = fileItemTemp.getString().trim();
                                if (lastname == null || lastname.isEmpty()) {
                                    lastname = "";
                                }

                            }
                            if (name.equalsIgnoreCase("phone")) {
                                phone = fileItemTemp.getString().trim();
                                if (phone == null || phone.isEmpty()) {
                                    phone = "";
                                }

                            }

                            if (name.equalsIgnoreCase("mobile")) {
                                mobile = fileItemTemp.getString().trim();

                                if (mobile == null || mobile.isEmpty()) {
                                    mobile = "";
                                }

                            }

                            if (name.equalsIgnoreCase("email")) {
                                email = fileItemTemp.getString().trim();

                                if (email == null || email.isEmpty() || email.equals("")) {
                                    email = "";
                                }

                            }

                            if (name.equalsIgnoreCase("location")) {
                                location = fileItemTemp.getString().trim();
                                if (location == null || location.isEmpty()) {
                                    location = "";
                                }

                            }

                            if (name.equalsIgnoreCase("refempid")) {
                                refempid = fileItemTemp.getString().trim().toUpperCase();
                                if (refempid == null || refempid.isEmpty()) {
                                    refempid = "";
                                }

                            }
                            if (name.equalsIgnoreCase("ugcourse")) {
                                ugcourse = fileItemTemp.getString().trim();
                                if (ugcourse == null || ugcourse.isEmpty()) {
                                    ugcourse = "";
                                }

                            }

                            if (name.equalsIgnoreCase("pgcourse")) {
                                pgcourse = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("ugbranch")) {
                                ugbranch = fileItemTemp.getString().trim();
                                if (ugbranch == null || ugbranch.isEmpty()) {
                                    ugbranch = "";
                                }

                            }

                            if (name.equalsIgnoreCase("pgbranch")) {
                                pgbranch = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("uginstitute")) {
                                uginstitute = fileItemTemp.getString().trim();
                                if (uginstitute == null || uginstitute.isEmpty()) {
                                    uginstitute = "";
                                }

                            }

                            if (name.equalsIgnoreCase("pginstitute")) {
                                pginstitute = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("uggraduationyear")) {
                                uggraduationyear = fileItemTemp.getString().trim();
                                if (uggraduationyear == null || uggraduationyear.isEmpty()) {
                                    uggraduationyear = "";
                                }

                            }
                            if (name.equalsIgnoreCase("pggraduationyear")) {
                                pggraduationyear = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("ugpercentage")) {
                                ugpercentage = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("pgpercentage")) {
                                pgpercentage = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("sapyears")) {
                                sapyears = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("sapmonths")) {
                                sapmonths = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("totalyears")) {
                                totalyears = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("totalmonths")) {
                                totalmonths = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("corecompetence")) {
                                corecompetence = fileItemTemp.getString().trim();
                                if (corecompetence.equalsIgnoreCase("XX")) {
                                    corecompetence = " ";
                                }

                            }
                            if (name.equalsIgnoreCase("areaofexpertise")) {
                                areaofexpertise = fileItemTemp.getString().trim();
                                if (areaofexpertise == null | areaofexpertise.isEmpty()) {
                                    areaofexpertise = "";
                                }

                            }
                            if (name.equalsIgnoreCase("tools")) {
                                tools = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("maxemp")) {
                                maxemp = Integer.parseInt(fileItemTemp.getString().trim());

                            }
                            prevEmployers = "previousemployer" + maxemp;
                            ctcs = "ctc" + maxemp;
                            designations = "designation" + maxemp;
                            empRoles = "role" + maxemp;
                            jobprofiles = "jobprofile" + maxemp;
                            joiningdates = "joiningdate" + maxemp;
                            relievingdates = "relievingdate" + maxemp;

                            if (name.equalsIgnoreCase(prevEmployers)) {
                                String pe = fileItemTemp.getString().trim();
                                prevEmployer = prevEmployer + "@@" + pe;

                            }

                            if (!prevEmployer.equals("")) {
                                if (name.equalsIgnoreCase(ctcs)) {
                                    String CTC = fileItemTemp.getString().trim();
                                    ctc = ctc + "@@" + CTC;

                                }
                                if (name.equalsIgnoreCase(joiningdates)) {
                                    String jd = fileItemTemp.getString().trim();
                                    joiningdate = joiningdate + "@@" + jd;

                                }
                                if (name.equalsIgnoreCase(designations)) {
                                    String des = fileItemTemp.getString().trim();
                                    designation = designation + "@@" + des;

                                }
                                if (name.equalsIgnoreCase(empRoles)) {
                                    String eRole = fileItemTemp.getString().trim();
                                    empRole = empRole + "@@" + eRole;

                                }
                                if (name.equalsIgnoreCase(relievingdates)) {
                                    String rdate = fileItemTemp.getString().trim();
                                    relievingdate = relievingdate + "@@" + rdate;

                                }
                                if (name.equalsIgnoreCase(jobprofiles)) {
                                    String jprofile = fileItemTemp.getString().trim();
                                    jobprofile = jobprofile + "@@" + jprofile;

                                }

                            }

                            if (name.equalsIgnoreCase("jobtype")) {
                                jobtype = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("position")) {
                                position = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("desiredlocation")) {
                                desiredlocation = fileItemTemp.getString().trim();
                                if (desiredlocation == null || desiredlocation.isEmpty()) {
                                    desiredlocation = "";
                                }

                            }
                            if (name.equalsIgnoreCase("noticePeriod")) {
                                noticePeriod = fileItemTemp.getString().trim();

                                if (noticePeriod.equals("") || noticePeriod == null) {
                                    noticePeriod = "" + 0;
                                }
                            }
                            if (name.equalsIgnoreCase("ectc")) {
                                expectedCtc = fileItemTemp.getString().trim();
                                if (expectedCtc == null || expectedCtc.isEmpty()) {
                                    expectedCtc = "";
                                }

                            }

                            if (name.equalsIgnoreCase("referencename")) {
                                referencename = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("referencedesignation")) {
                                referencedesignation = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("organization")) {
                                organization = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("refemployeeid")) {
                                refemployeeid = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("refcountrycode")) {
                                refcountrycode = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("refstdcode")) {
                                refstdcode = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("refphone")) {
                                refphone = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("refmobileno")) {
                                refMobile = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("refmailid")) {
                                refmailid = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("dateofbirth")) {
                                dateofbirth = fileItemTemp.getString().trim();
                                if (dateofbirth == null || dateofbirth.isEmpty()) {
                                    dateofbirth = "";
                                }

                            }
                            
                             if (name.equalsIgnoreCase("aadhaar")) {
                                aadhaar = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("voteridno")) {
                                voterId = fileItemTemp.getString().trim();
 
                           }
                            if (name.equalsIgnoreCase("dlNo")) {
                                dlNo = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("passportno")) {
                                passportNo = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("gender")) {
                                gender = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("maritalstatus")) {
                                maritalstatus = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("pancardno")) {
                                pancardno = fileItemTemp.getString().trim();
                                if (pancardno == null | pancardno.isEmpty() || pancardno.equals("")) {
                                    pancardno = " ";
                                }

                            }
                            if (name.equalsIgnoreCase("mailingaddress")) {
                                mailingaddress = fileItemTemp.getString().trim();

                            }

                            if (name.equalsIgnoreCase("city")) {
                                city = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("pincode")) {
                                pincode = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("summarydetails")) {
                                summarydetails = fileItemTemp.getString().trim();

                            }
                            if (name.equalsIgnoreCase("proglanguages")) {

                                String lang = fileItemTemp.getString().trim();
                                proglanguages = proglanguages + "," + lang;

                            }
                            if (name.equalsIgnoreCase("erppackages")) {
                                String erppkg = fileItemTemp.getString().trim();
                                erppackages = erppackages + "," + erppkg;

                            }
                            if (name.equalsIgnoreCase("operatingsystem")) {
                                String ops = fileItemTemp.getString().trim();
                                os = os + "," + ops;

                            }
                            if (name.equalsIgnoreCase("database")) {

                                String database = fileItemTemp.getString().trim();
                                db = db + "," + database;
                            }

                            if (name.equalsIgnoreCase("noofproject")) {
                                noofprojects = Integer.parseInt(fileItemTemp.getString().trim());

                            }

                            pnames = "projectname" + noofprojects;

                            if (name.equalsIgnoreCase(pnames)) {

                                String pnam = fileItemTemp.getString().trim();
                                pname = pname + "@@@@@" + pnam;

                            }

                            if (pname != null) {

                                if (!pname.equals("")) {

                                    duras = "duration" + noofprojects;
                                    teams = "teamsize" + noofprojects;
                                    clis = "client" + noofprojects;
                                    envs = "environment" + noofprojects;
                                    desss = "description" + noofprojects;
                                    rols = "roles" + noofprojects;

                                    if (name.equalsIgnoreCase(duras)) {
                                        String dur = fileItemTemp.getString().trim();
                                        dura = dura + "@@@@@" + dur;

                                    }
                                    String duration = dura;
                                    int durati = MoMUtil.parseInteger(duration, 0);

                                    if (name.equalsIgnoreCase(teams)) {

                                        String teamss = fileItemTemp.getString().trim();
                                        team = team + "@@@@@" + teamss;

                                    }
                                    String teamsize = team;

                                    if (name.equalsIgnoreCase(clis)) {
                                        String cliss = fileItemTemp.getString().trim();
                                        cli = cli + "@@@@@" + cliss;

                                    }
                                    if (name.equalsIgnoreCase(envs)) {
                                        String envss = fileItemTemp.getString().trim();
                                        env = env + "@@@@@" + envss;

                                    }
                                    if (name.equalsIgnoreCase(desss)) {
                                        String dessss = fileItemTemp.getString().trim();
                                        dess = dess + "@@@@@" + dessss;

                                    }
                                    if (name.equalsIgnoreCase(rols)) {
                                        String rolss = fileItemTemp.getString().trim();
                                        rol = rol + "@@@@@" + rolss;

                                    }

                                }

                            }

                        } else {
                            fileItem = fileItemTemp;
                            String fieldName = fileItem.getFieldName();
                            if (fieldName.equalsIgnoreCase("Resume")) {
                                fileItemResume = fileItem;
                            }
                            if (fieldName.equalsIgnoreCase("userPhoto")) {
                                fileItemPic = fileItem;
                            }

                        }
                    }
                    message = adc.caheckAlreadyUserExitss(email);
                    existingmail = message.substring(message.indexOf(",") + 1, message.indexOf("-"));
                    existingapid = message.substring(message.indexOf("-") + 1, message.length());
                    message = message.substring(0, message.indexOf(","));
                    if (message.equalsIgnoreCase("existed")) {
                        message = message + "," + existingmail + "-" + existingapid;
                        return message;
                    }

                    message = adc.addNewCandidate(firstname, lastname, db.substring(db.indexOf(",") + 1, db.length()), phone, mobile, email, dateofbirth, location, pincode, city, ugcourse, pgcourse, uginstitute, pginstitute, jobtype, summarydetails, pgbranch, ugbranch, sapyears, sapmonths, totalyears, totalmonths, refempid, pgpercentage, ugpercentage, gender, maritalstatus, pancardno, dlNo, passportNo, mailingaddress, apj, water, rti, rte, habits, social, uggraduationyear, pggraduationyear, corecompetence, areaofexpertise, tools, desiredlocation, position, expectedCtc, referencename, noticePeriod, proglanguages.substring(proglanguages.indexOf(",") + 1, proglanguages.length()), erppackages.substring(erppackages.indexOf(",") + 1, erppackages.length()), os.substring(os.indexOf(",") + 1, os.length()), referencedesignation, organization, refemployeeid, refcountrycode, refstdcode, refphone, refMobile, refmailid, voterId, prevEmployer, ctc, joiningdate, designation, empRole, relievingdate, jobprofile, pname, dura, team, cli, env, rol, dess,aadhaar);

                    apids = message.substring(message.indexOf(",") + 1, message.length());
                    message = message.substring(0, message.indexOf(","));

                    if (fileItemResume != null && fileItemPic != null) {

                        String fileNameResume = fileItemResume.getName();
                        String fileNamePic = fileItemPic.getName();
                        if (fileItem.getSize() > 0 & fileItem.getSize() < 12582912) {
                            fileNameResume = FilenameUtils.getName(fileNameResume);
                            fileNamePic = FilenameUtils.getName(fileNamePic);
                            dirName = filePath;
                            dirNameone = filePathone;

                            File saveTo = new File(dirName + apids + "." + FilenameUtils.getExtension(fileNameResume));
                            File saveTopic = new File(dirNameone + apids + "." + FilenameUtils.getExtension(fileNamePic));

                            try {
                                fileItemResume.write(saveTo);
                                fileItemPic.write(saveTopic);
                                MimeMessage msg = MakeConnection.getMailConnections();
                                msg.setFrom(new InternetAddress(email));
                                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("admin@eminentlabs.com"));
                                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(email));
                                msg.setSubject("Your Resume is Uploaded in Eminentlabs Resource Management!!!");
                                String htmlContent = "<table   bgcolor=#E8EEF7 width=100% ><tr><td>Your Resume is Uploaded in Eminentlabs Resource Management Successfully.!!!</td></tr>"
                                        + "<tr><td>Your Applicant id is " + apids + "</td></tr>"
                                        + "<tr><td>For any further Information Please donot hesistate to contact hr@eminentlabs.net</td></tr>"
                                        + "</table>";
                                msg.setContent(htmlContent, "text/html");
                              Transport.send(msg);

                                MimeMessage msga = MakeConnection.getMailConnections();
                                msga.setFrom(new InternetAddress("admin@eminentlabs.com"));
                                Set<String> mailIda = adc.getMailIdFromERM();
                                int a = 0;
                                for (String em : mailIda) {
                                    if (a == 0) {
                                        msga.addRecipient(Message.RecipientType.TO, new InternetAddress(em));
                                    } else {
                                        if(!em.equalsIgnoreCase("ttamilvelan@eminentlabs.net")){
                                        msga.addRecipient(Message.RecipientType.CC, new InternetAddress(em));
                                        }
                                    }
                                    a++;
                                }
                                msga.setSubject("New Candidate has been registered in eTracker");
                               String adminMail = "<table>"
                                        + "<tr>"
                                        + "<td>Dear Project Manager,</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td>New Candidate has been registered</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td>Name</td><td>" + firstname + " " + lastname + "</td>"
                                        + "<td>Location</td><td>" + location + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td>UG Qualification</td><td>" + ugcourse + "</td>"
                                        + "<td>Graduation Year</td><td>" + uggraduationyear + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td>UG Percentage</td><td>" + ugpercentage + "</td>"
                                        + "<td>Module</td><td>" + areaofexpertise + "</td>"
                                        + "</tr>"
                                        + "<tr  >"
                                        + "<td>SAP Experience</td><td>" + sapyears + "Y " + sapmonths + "M</td>"
                                        + "<td>Overall Experience</td><td>" + totalyears + "Y " + totalmonths + "M</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td>Applicant Id</td><td>" + apids + "</td>"
                                        + "<td>Referred By</td><td>" + refempid + "</td>"
                                        + "</tr>"
                                        + "</table>";
                                String endLine = "</table><br>Thanks,";
                                String signature = "<br>eTracker&trade;<br>";
                                String emi = "<br><b><a href=http://www.eminentlabs.net/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                                String lineBreak = "<br>";

                                String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.net/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                                adminMail = adminMail + endLine + signature + htmlTableEnd + lineBreak + emi;
                                msga.setContent(adminMail, "text/html");
                               Transport.send(msga);

                            } catch (Exception e) {
                                message = "Error Occured in file upload";
                                logger.error(e.getMessage());
                            } finally {

                            }
                        }
                    }

                } else {
                    message = "Problem in Resume upload.";
                    message = "false";
                    logger.error(message);
                }
            } catch (Exception e1) {
                logger.error(e1.getMessage());
                e1.printStackTrace();
            } finally {

                try {
                    if (prjhdr != null) {
                        prjhdr.close();
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

        }

        if (message.equalsIgnoreCase("true")) {
            message = message + "," + apids;
        }
        return message;
    }

    public List<String> getCoreCompetence() {
        List<String> map = new ArrayList<String>();
        map.add("Accounts");
        map.add("Admin");
        map.add("Coding/Development");
        map.add("Design & UI");
        map.add("Delivery Manager");
        map.add("HR");
        map.add("Interns/New College Graduates");
        map.add("Legal");
        map.add("Marketing");
        map.add("Project Coordinator");
        map.add("Project Management");
        map.add("Quality/Testing");
        map.add("Sales");
        map.add("SAP Technical");
        map.add("SAP Functional");
        map.add("SAP Techno Functional");
        map.add("System Admin");
        return map;
    }
}
