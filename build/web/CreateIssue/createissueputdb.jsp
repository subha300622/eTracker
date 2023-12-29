<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,java.util.*,dashboard.*,com.eminent.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="com.pack.MyAuthenticator"%>
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>

        <script type="text/javascript">
            //Disable right mouse click Script
            document.onmousedown = "if (event.button==2) return false";
            document.oncontextmenu = new Function("return false");

            document.onkeydown = showDown;

            function showDown(evt) {
                evt = (evt) ? evt : ((event) ? event : null);
                if (evt) {
                    if (event.keyCode == 8 && (event.srcElement.type != "text" && event.srcElement.type != "textarea" && event.srcElement.type != "password")) {
                        // When backspace is pressed but not in form element
                        cancelKey(evt);
                    }
                    else if (event.keyCode == 116) {
                        // When F5 is pressed
                        cancelKey(evt);
                    }
                    else if (event.keyCode == 122) {
                        // When F11 is pressed
                        cancelKey(evt);
                    }
                    else if (event.ctrlKey && (event.keyCode == 78 || event.keyCode == 82)) {
                        // When ctrl is pressed with R or N
                        cancelKey(evt);
                    }
                    else if (event.altKey && event.keyCode == 37) {
                        // stop Alt left cursor
                        return false;
                    }
                }
            }

            function cancelKey(evt) {
                if (evt.preventDefault) {
                    evt.preventDefault();
                    return false;
                }
                else {
                    evt.keyCode = 0;
                    evt.returnValue = false;
                }
            }
            function check()
            {
                if (confirm("Do you want to upload a File"))
                {
                    var attach = 'yes';
                    location = '/eTracker/fileAttach.jsp?attach=' + attach
                }
                else
                {
                    var attach = 'no';
                    location = '/eTracker/fileAttach.jsp?attach=' + attach
                }

            }
            function printpost(post)
            {
                pp = window.open('UserProfile/profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
                pp.focus();
            }
        </script>
    </HEAD>
    <%
        Logger logger = Logger.getLogger("CreateIssuePutDB");

        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
            logger.fatal("=========================Session Expired======================");
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }
    %>
    <BODY onload="check()">
        <%
            if (session.getAttribute("bug") == null) {
        %>
        <%@ include file="../header.jsp"%>
        <%    }
        %>

        <div align="center">
            <center><%@ page
                    import="java.sql.*,java.util.Properties,javax.mail.*,javax.mail.internet.*,javax.mail.internet.MimeMessage"%>
                    <%@ page language="java"%> <%!    String to = "";
                        String operator = null, sms, mobile, Recipient;
                        String pmanager = null;
                    %> <%

                        String fname = (String) session.getAttribute("fName");
                        String lname = (String) session.getAttribute("lName");
                        String Name = fname + " " + lname;

                        session.setAttribute("forwardpage", "/CreateIssue/createissuenew.jsp");

                        String product = request.getParameter("product");
                        String version = request.getParameter("version");
                        String type = request.getParameter("type");
                        String module = request.getParameter("module").trim();
                        String severity = request.getParameter("severity");
                        String priority = request.getParameter("priority");
                        String dueDate = request.getParameter("date");
                        String subject = request.getParameter("subject");
                        String desc = request.getParameter("description");
                        String rootCause = request.getParameter("rootCause");
                        String expectedResult = request.getParameter("expectedResult");
                        if (expectedResult == null || expectedResult == "") {
                            logger.warn("expected Result value came wrong:" + expectedResult);
                            expectedResult = subject;
                        }

                        String customer = "NA", platform = "NA", projecttype = null;

                        // declaring local variables
                        int day, month, year, pid = 0;
                        String issueidFormat = "";
                        String assignedTo="";

                        Statement st = null, statementDate = null, stForProject = null, stForType = null, st5 = null;
                        ResultSet rs = null, fetchDate = null, rsForProject = null, rsForType = null, rs5 = null;
                        Connection connection = null;

                        int uid = 0;
                        String firstname = "";
                        String lastname = "";
                        String moduleId = "NA";
                        String storeDate = null;

                        try {
                            connection = MakeConnection.getConnection();

                            //Fetching Customer, Platform from project table
                            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            rsForProject = stForProject.executeQuery("select customer, platform, p.pid, moduleid from project p, modules m where p.pid = m.pid and pname = '" + product + "' and version = '" + version + "' and module = '" + module + "'");
                            if (rsForProject.next()) {

                                pid = rsForProject.getInt("pid");
                                customer = rsForProject.getString("customer");
                                platform = rsForProject.getString("platform");
                                moduleId = rsForProject.getString("moduleid");
                            }

                            //Fetching Type of Project from Project_type table
                            stForType = connection.createStatement();
                            rsForType = stForProject.executeQuery("select type from project_type where pid = " + pid);
                            if (rsForType.next()) {

                                projecttype = rsForType.getString("type");

                            }

                            //Generating Issue Id using sequence
                            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            statementDate = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            fetchDate = statementDate.executeQuery("select extract(day from sysdate) as day,extract(month from sysdate) as month,extract(year from sysdate) as year from dual");
                            rs = st.executeQuery("select issueid from ISSUE where createdon like (select to_date(sysdate,'dd-mm-yyyy') from dual)");//CHANGED since 24th Nov 2006
                            fetchDate.next();
                            day = fetchDate.getInt("day");
                            month = fetchDate.getInt("month");
                            year = fetchDate.getInt("year");
                            if (day < 10) {
                                issueidFormat = "E0" + day;
                            } else {
                                issueidFormat = "E" + day;
                            }
                            if (month < 10) {
                                issueidFormat = issueidFormat + "0" + month + year;
                            } else {
                                issueidFormat = issueidFormat + month + year;
                            }
                            if (rs.next()) {
                                Statement seqStatement = connection.createStatement();
                                ResultSet seqResultSet = seqStatement.executeQuery("select issueid_seq.nextval as nextvalue from dual");

                                seqResultSet.next();
                                int nextValue = seqResultSet.getInt("nextvalue");
                                if (nextValue < 10) {
                                    issueidFormat = issueidFormat + "00" + nextValue;
                                } else if (nextValue >= 10 && nextValue <= 99) {
                                    issueidFormat = issueidFormat + "0" + nextValue;
                                } else {
                                    issueidFormat = issueidFormat + nextValue;
                                }
                                logger.info("IssueID:\t" + issueidFormat);
                                if (seqResultSet != null) {
                                    seqResultSet.close();
                                }

                                if (seqStatement != null) {
                                    seqStatement.close();
                                }
                            } else {
                                Statement dropSeqeunceSt = connection.createStatement();
                                boolean b = dropSeqeunceSt.execute("drop sequence issueid_seq");
                                logger.info("Sequence has been dropped:" + b);
                                ResultSet dropSequence = dropSeqeunceSt.executeQuery("create sequence issueid_seq start with 1 increment by 1 nocache nocycle");
                                dropSequence = dropSeqeunceSt.executeQuery("select issueid_seq.nextval as nextvalue from dual");
                                dropSequence.next();
                                int nextValue = dropSequence.getInt("nextvalue");
                                if (nextValue < 10) {
                                    issueidFormat = issueidFormat + "00" + nextValue;
                                } else if (nextValue >= 10 && nextValue <= 99) {
                                    issueidFormat = issueidFormat + "0" + nextValue;
                                } else {
                                    issueidFormat = issueidFormat + nextValue;
                                }
                                logger.info("IssueID:\t" + issueidFormat);

                                if (dropSequence != null) {
                                    dropSequence.close();
                                }

                                if (dropSeqeunceSt != null) {
                                    dropSeqeunceSt.close();
                                }

                            }




                            st5 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            rs5 = st5.executeQuery("select userid,firstname,lastname from users where roleid=1");
                            if (rs5.next()) {
                                firstname = rs5.getString("firstname");
                                session.setAttribute("firstname", firstname);
                                lastname = rs5.getString("lastname");
                                session.setAttribute("lastname", lastname);
                                uid = rs5.getInt("userid");
                                session.setAttribute("userid_admin", new Integer(uid));
                            }


                        } catch (Exception e) {
                            logger.error("Exception:" + e);
                        } finally {

                            try {
                                if (rsForProject != null) {
                                    rsForProject.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (stForProject != null) {
                                    stForProject.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (rsForType != null) {
                                    rsForType.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (stForType != null) {
                                    stForType.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (rs != null) {
                                    rs.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (st != null) {
                                    st.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (fetchDate != null) {
                                    fetchDate.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (statementDate != null) {
                                    statementDate.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (rs5 != null) {
                                    rs5.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (st5 != null) {
                                    st5.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (connection != null) {
                                    connection.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                        }

                        Statement issuestatusSt = null, fetchProjectManagerSt = null;
                        PreparedStatement insertStatus_St = null, insertSeq = null, insertPhase_St = null, psComment = null,prposalComment=null,prposalissue=null;;
                        ResultSet issuestatus = null, fetchProjectManager = null;
                        String user2 = "", tempFromCc = "";
                        int userid_curri = 0, userid_admin1 = 0;
                        Integer userid_curr = null;
                        try {
                            connection = MakeConnection.getConnection();
                            connection.setAutoCommit(false);

                            if (dueDate != null) {
                                dueDate = dueDate.trim();
                            }
                            storeDate = com.pack.ChangeFormat.getDateFormat(dueDate);

                            session.setAttribute("theissu", issueidFormat);
                            insertSeq = connection.prepareStatement("insert into issue(issueid,pid,found_version,type,module_id,severity,priority,subject,description,createdby,modifiedon,assignedto,createdon,rootcause,expected_result,due_date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");//CHANGED
                            insertSeq.setString(1, issueidFormat);
                            insertSeq.setInt(2, pid);
                            insertSeq.setString(3, version.trim());
                            insertSeq.setString(4, type.trim());
                            insertSeq.setString(5, moduleId);
                            insertSeq.setString(6, severity.trim());
                            insertSeq.setString(7, priority.trim());
                            insertSeq.setString(8, subject.trim());
                            insertSeq.setString(9, desc.trim());


                            userid_curr = (Integer) session.getAttribute("userid_curr");
                            userid_curri = userid_curr.intValue();
                            user2 = userid_curr.toString();
                            insertSeq.setString(10, user2.trim());

                            java.util.Date d = new java.util.Date();
                            Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());

                            insertSeq.setTimestamp(11, ts);
                            Integer userid_admin = (Integer) session.getAttribute("userid_admin");
                            userid_admin1 = userid_admin.intValue();

                            String admin = Integer.toString(uid);
                            pmanager = GetProjectManager.getManager(product, version);
                            logger.debug("AdminID:" + admin);
                            insertSeq.setString(12, pmanager.trim());
                            insertSeq.setTimestamp(13, ts);

                            insertSeq.setString(14, rootCause.trim());
                            insertSeq.setString(15, expectedResult.trim());
                            insertSeq.setDate(16, java.sql.Date.valueOf(storeDate));
                            insertSeq.executeUpdate();


                            issuestatusSt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            issuestatus = issuestatusSt.executeQuery("select statusid_seq.nextval from dual");
                            issuestatus.next();
                            int issuestatus_nextval = issuestatus.getInt("nextval");
                            logger.info("Next IssueStatus Value:\t" + issuestatus_nextval);

                            insertStatus_St = connection.prepareStatement("insert into issuestatus(statusid,issueid,status,owner) values(?,?,?,?)");//CHANGED
                            insertStatus_St.setInt(1, issuestatus_nextval);
                            insertStatus_St.setString(2, issueidFormat);
                            insertStatus_St.setString(3, "Unconfirmed");
                            userid_admin = (Integer) session.getAttribute("userid_admin");
                            userid_admin1 = userid_admin.intValue();
                            fetchProjectManagerSt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            fetchProjectManager = fetchProjectManagerSt.executeQuery("Select firstname,lastname,email,userid,mobile,mobileoperator from users where userid =" + pmanager);
                            fetchProjectManager.next();

                            firstname = fetchProjectManager.getString("firstname");
                            lastname = fetchProjectManager.getString("lastname");
                            tempFromCc = fetchProjectManager.getString("email");
                            operator = fetchProjectManager.getString("mobileoperator");
                            mobile = fetchProjectManager.getString("mobile");
                            mobile = mobile.replaceAll("-", "");
                            insertStatus_St.setString(4, Integer.toString(fetchProjectManager.getInt("userid")));
                            insertStatus_St.executeUpdate();


                            psComment = connection.prepareStatement("insert into issuecomments(issueid,commentedby,comment_date,comments,status,commentedto,duedate,priority,severity) values(?,?,?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);


                            psComment.setString(1, issueidFormat);
                            psComment.setString(2, user2.trim());
                            psComment.setTimestamp(3, ts);
                            psComment.setString(4, "Assigning to PM");
                            psComment.setString(5, "Unconfirmed");
                            psComment.setString(6, pmanager.trim());
                            psComment.setDate(7, java.sql.Date.valueOf(storeDate));
                            psComment.setString(8, priority);
                            psComment.setString(9, severity);
                            psComment.executeUpdate();

                            String phase = null, subphase = null, subsubphase = null, subsubsubphase = null;
                            if (projecttype != null) {
                                phase = "Project Preparation";
                                subphase = "Actual situation analysis";
                                if (projecttype.equals("Implementation")) {

                                    subphase = "Implementation Scope";
                                    subsubphase = "Project deliverables";
                                    insertPhase_St = connection.prepareStatement("insert into issue_implementation(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                                    insertPhase_St.setString(1, issueidFormat);
                                    insertPhase_St.setString(2, phase);
                                    insertPhase_St.setString(3, subphase);
                                    insertPhase_St.setString(4, subsubphase);
                                    insertPhase_St.setString(5, subsubsubphase);
                                    insertPhase_St.setString(6, projecttype);
                                    insertPhase_St.executeUpdate();


                                } else if (projecttype.equals("Upgradation")) {

                                    insertPhase_St = connection.prepareStatement("insert into issue_upgradation(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                                    insertPhase_St.setString(1, issueidFormat);
                                    insertPhase_St.setString(2, phase);
                                    insertPhase_St.setString(3, subphase);
                                    insertPhase_St.setString(4, subsubphase);
                                    insertPhase_St.setString(5, subsubsubphase);
                                    insertPhase_St.setString(6, projecttype);
                                    insertPhase_St.executeUpdate();


                                } else if (projecttype.equals("Support")) {

                                    insertPhase_St = connection.prepareStatement("insert into issue_support(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                                    insertPhase_St.setString(1, issueidFormat);
                                    insertPhase_St.setString(2, phase);
                                    insertPhase_St.setString(3, subphase);
                                    insertPhase_St.setString(4, subsubphase);
                                    insertPhase_St.setString(5, subsubsubphase);
                                    insertPhase_St.setString(6, projecttype);
                                    insertPhase_St.executeUpdate();


                                }
                            }
                            String status="";
                            
                            String seve="";
                            String pri="";
                            String dued="";
                            String prposalDate=  IssueDetails.proposeDuedate(product, module,version,severity,priority);
                           int days=MoMUtil.getDays(prposalDate, dueDate);
                            if(days>0){
                            HashMap resolutioDays=IssueDetails.getResolutionDays();
                            String sev = severity.substring(0, severity.indexOf("-")).trim();
                            String prio = priority.substring(0, severity.indexOf("-")).trim();
                            String finalval = prio + sev;
                            int rdays =(Integer) resolutioDays.get(finalval);
                                String prposalIssues[][]= IssueDetails.prposalIssues(pid, moduleId, rdays);
                           String issueno="";
                           for(int i=0;i<prposalIssues.length;i++){
                               issueno=prposalIssues[i][0];
                               status=prposalIssues[i][1];
                               assignedTo=prposalIssues[i][2];
                               seve=prposalIssues[i][3];
                               pri=prposalIssues[i][4];
                               dued=prposalIssues[i][5];
                              String dueda=com.pack.ChangeFormat.getDateFormat(dued);
                                 
                             logger.info("ssssss"+issueno+ " ,due date"+dueda);
                           prposalComment=connection.prepareStatement("insert into issuecomments(issueid,commentedby,comment_date,comments,status,commentedto,duedate,priority,severity) values(?,?,?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                           logger.info("comment update:"+"issueno"+issueno+","+GetProjectMembers.getAdminID()+","+ts+"due date is realigned because of"+issueidFormat+""); 
                           logger.info("comment update:"+"status"+status+","+assignedTo+","+java.sql.Date.valueOf(dueda)+","+pri+","+seve+""); 
                           
                            prposalComment.setString(1, issueno);
                            prposalComment.setString(2,user2.trim());
                            prposalComment.setTimestamp(3, ts);
                            prposalComment.setString(4, "Due date is realigned because of issue# "+issueidFormat);
                            prposalComment.setString(5, status);
                            prposalComment.setString(6, assignedTo.trim());
                            prposalComment.setDate(7, java.sql.Date.valueOf(dueda));
                            prposalComment.setString(8, pri);
                            prposalComment.setString(9, seve);
                            prposalComment.executeUpdate();
                            
                            prposalissue=connection.prepareStatement("Update issue set due_date=? where issueid =?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            prposalissue.setDate(1, java.sql.Date.valueOf(dueda));
                            prposalissue.setString(2, issueno);
                            prposalissue.executeUpdate();
                           }
                           }
                            //Committing the database
                            connection.commit();
                            connection.setAutoCommit(true);
                            session.setAttribute("createIssueId", issueidFormat);


                        } catch (Exception e) {
                            try {
                                if (connection != null) {
                                    connection.rollback();
                                }
                            } catch (SQLException ex) {
                                logger.error("Exception:" + ex);
                            }

                            logger.error("Exception:" + e);
                        } finally {

                            try {
                                if (issuestatus != null) {
                                    issuestatus.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (fetchProjectManager != null) {
                                    fetchProjectManager.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (issuestatusSt != null) {
                                    issuestatusSt.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (fetchProjectManagerSt != null) {
                                    fetchProjectManagerSt.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (insertStatus_St != null) {
                                    insertStatus_St.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (insertSeq != null) {
                                    insertSeq.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (psComment != null) {
                                    psComment.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }
                            try {
                                if (prposalComment != null) {
                                    prposalComment.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }
                            try {
                                if (prposalissue != null) {
                                    prposalissue.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }
                            try {
                                if (connection != null) {
                                    connection.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }
                        }



                        String s1 = request.getParameter("product").trim();
                        String s2 = customer;
                        String s3 = request.getParameter("version").trim();
                        String s4 = request.getParameter("type");
                        String s5 = request.getParameter("priority");
                        String s6 = request.getParameter("severity");
                        String s7 = request.getParameter("subject");
                        String s8 = request.getParameter("description");
                        String s9 = request.getParameter("module");
                        String s10 = platform;

                        ArrayList<String> al = dashboard.Project.getDetails(s1 + ":" + s3);
                        ArrayList<String> dateAndTime = CurrentDay.getDateTime();
                      String from = tempFromCc;

                        Session ses1 = null;
                        Statement statementEmail = null;
                        ResultSet resultSetEmail = null;
                        try {
                            connection = MakeConnection.getConnection();
                            statementEmail = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            logger.info("Created user" + user2);

                            userid_curri = userid_curr.intValue();
                            resultSetEmail = statementEmail.executeQuery("select email from users where userid=" + userid_curri);
                            if (resultSetEmail.next()) {
                                to = resultSetEmail.getString("email");
                                //Edited by sowjanya
                                 MimeMessage msg= MakeConnection.getMailConnections();
                                 //Edit end by sowjanya
                                ArrayList<String> hm  = MailReceiverDetails.getDetails(issueidFormat);
                                msg.setFrom(new InternetAddress(to, Name));
                                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(from));
                                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(to));
                                if(hm.contains(pmanager)){
                                    hm.remove((String)pmanager);
                                 }
                                if(hm.contains(user2)){
                                        hm.remove((String)user2);
                                    }
                                for(String s:hm){
                                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress(GetProjectMembers.getMail(s)));
                      //              logger.info("Email"+s);
                                }
                                
                                msg.setSubject("eTracker Unconfirmed Issue :" + s7);

                                String htmlContent = "<b><font color=blue >Project Details</font></b><br>"
                                        + "<table width=100% ><tr  bgcolor=#E8EEF7>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Project</b></td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + s1 + "</td>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b> Customer </b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + s2 + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b> Version </b></td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + s3 + "</td>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Manager</b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + GetProjectMembers.getUserName(al.get(0)) + "</td>"
                                        + "</tr>"
                                        + "<tr  bgcolor=#E8EEF7>"
                                        + "<td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b> Status </b></td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + al.get(4) + "</td>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Phase</b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + al.get(1) + "</td>"
                                        + "</tr>"
                                        + "<tr><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Start Date</b> </td>"
                                        + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + al.get(2) + "</td>"
                                        + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>End Date</b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + al.get(3) + "</td>"
                                        + "</tr>"
                                        + "</table>"
                                        + "<br><b><font color=blue>Issue Details</font></b>"
                                        + "<table width=100% ><tr  bgcolor=#E8EEF7>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Issue ID</b></td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + issueidFormat + "</td>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Type </b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + s4 + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>CreatedBy </b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + GetProjectMembers.getUserName(user2) + "</td>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Created On</b></td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + dateAndTime.get(0) + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Priority </b></td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + s5 + "</td>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Severity</b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + s6 + "</td>"
                                        + "</tr>"
                                        + "<tr ><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Module</b> </td>"
                                        + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + s9 + "</td>"
                                        + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Platform</b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + s10 + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Issue Status </b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Unconfirmed</td>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Due Date</b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + com.pack.ChangeFormat.changeDateFormat(dueDate) + "</font></td>"
                                        + "</tr>"
                                        + "<tr ><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Assigned To</b> </td>"
                                        + "<td width  = 32%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(assignedTo) + "</td>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Fix Version </b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + s3 + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Updated By</b> </td>"
                                        + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Name + "</td>"
                                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Updated On </b> </td>"
                                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + dateAndTime.get(0) + " " + dateAndTime.get(1) + "</td>"
                                        + "</tr>"
                                        + "<tr >"
                                        + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Subject</b> </td>"
                                        + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + s7 + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Description</b> </td>"
                                        + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + s8 + "</td>"
                                        + "</tr>"
                                        + "<tr >"
                                        + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Root Cause</b> </td>"
                                        + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + rootCause + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Expected Result</b> </td>"
                                        + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2>" + expectedResult + "</td>"
                                        + "</tr>";

                                String endLine = "</table><br>Thanks,";
                                String signature = "<br>eTracker&trade;<br>";
                                String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                                String lineBreak = "<br>";

                                String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                                htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;
                                msg.setContent(htmlContent, "text/html");
                                ResourceBundle rb = ResourceBundle.getBundle("Resources");
                                String mail = rb.getString("mail");
            if(mail.equalsIgnoreCase("yes")){
                                Transport.send(msg);
            }
                            }
                        } catch (Exception s) {
                            logger.error("Exception:" + s);
                        } finally {
                            try {
                                if (resultSetEmail != null) {
                                    resultSetEmail.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (statementEmail != null) {
                                    statementEmail.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }

                            try {
                                if (connection != null) {
                                    connection.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception:" + e);
                            }
                        }

                        
                    %> <BR>
                    <BR>
                </center>
            </div>
        </BODY>
    </HTML>