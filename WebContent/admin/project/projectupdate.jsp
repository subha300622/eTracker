<%@page import="com.pack.ApmTargetIssueCount"%>

<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8" import="org.apache.log4j.*"%>

<%
    //Configuring log4j properties

    Logger logger = Logger.getLogger("Project Update");

    //After the session is expired, when the user tries to access the page one will be forwarded to the session expired page
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
    </head>

    <body>


        <%@ page import="java.sql.*,pack.eminent.encryption.*,java.util.ArrayList,com.eminent.util.GetProjectMembers,com.eminent.util.GetProjects"%>

        <jsp:useBean id="Admin" class="com.pack.AdminBean" />
        <%
            Connection connection = null;
            PreparedStatement ps = null;
            PreparedStatement ps1 = null, projectComments = null, ps2 = null;
            Statement seqStatement = null;
            ResultSet seqResultSet = null;
            String pname = null;
            String version = null;
            String platform = null;
            String pmanager = null;
            String customer = null;
            String startdate = null;
            String enddate = null;
            String totalhours = null;
            String phase = null;
            String category = null;
            String projecttype = null;
            String status = null;
            String wrmDay = "", startHour = "", startMin = "", endHour = "", endMin = "";
            int targetCount = 0;
            String project_domain = "";

            //Getting the form input parameters and trimming to avoid whitespace at both the ends
            category = request.getParameter("category").trim();
            projecttype = request.getParameter("projecttype");
            if (projecttype != null) {
                projecttype = projecttype.trim();
            }
            boolean showDetails = Boolean.valueOf(request.getParameter("details"));
            pname = request.getParameter("pname").trim();
            version = request.getParameter("versionInfo").trim();
            platform = request.getParameter("platform").trim();
            pmanager = request.getParameter("projectManager").trim();
            customer = request.getParameter("customer").trim();
            startdate = request.getParameter("startdate").trim();
            enddate = request.getParameter("enddate").trim();
            phase = request.getParameter("phase").trim();
            totalhours = request.getParameter("totalhours").trim();
            status = request.getParameter("status").trim();
            String existingPhase = request.getParameter("currentphase");
            logger.info("Status" + status);
            String dmanager = request.getParameter("deliveryManager").trim();
            String amanager = request.getParameter("accountManager").trim();
            String sponsorer = request.getParameter("executiveSponsorer").trim();
            String stakeholder = request.getParameter("projectStakeholder").trim();
            String coordinator = request.getParameter("projectCoordinator").trim();
            wrmDay = request.getParameter("wrmday");
            startHour = request.getParameter("startH");
            startMin = request.getParameter("startM");
            endHour = request.getParameter("endH");
            endMin = request.getParameter("endM");
            logger.info("WRM Day" + wrmDay);
            targetCount = Integer.parseInt(request.getParameter("targetCount"));
            project_domain = request.getParameter("domain_name");

            int spon = Integer.parseInt(sponsorer);
            int stkh = Integer.parseInt(stakeholder);
            int coor = Integer.parseInt(coordinator);
            int amng = Integer.parseInt(amanager);
            int dmng = Integer.parseInt(dmanager);

            ArrayList al = new ArrayList<Integer>();

            if (!al.contains(spon)) {
                al.add(spon);
            }
            if (!al.contains(stkh)) {
                al.add(stkh);
            }
            if (!al.contains(coor)) {
                al.add(coor);
            }
            if (!al.contains(amng)) {
                al.add(amng);
            }
            if (!al.contains(dmng)) {
                al.add(dmng);
            }

            int pid = Integer.parseInt(request.getParameter("pid").trim());

            GetProjectMembers.UpdateEmailAlerts(al, pid);

            try {
                connection = MakeConnection.getConnection();
                if (connection != null) {

                    //Turning the autocommit off
                    connection.setAutoCommit(false);

                    //Updating the project table
                    Admin.ProjectUpdate(connection, pid, pname, pmanager, amanager, dmanager, sponsorer, stakeholder, coordinator, version, platform, customer, startdate, enddate, totalhours, phase, category, projecttype, status, wrmDay, startHour, startMin, endHour, endMin, project_domain);

                    //Updating the user project table
                    String[] selected = request.getParameterValues("teamFinal");
                    if (selected != null) {
                        int[] selectedmembers = new int[selected.length];
                        ps1 = connection.prepareStatement("delete from userproject where pid=?");
                        ps1.setInt(1, pid);
                        ps1.executeUpdate();
                        for (int i = 0; i < selected.length; i++) {
                            try {

                                //Updating user project table
                                selectedmembers[i] = Integer.parseInt(selected[i]);

                                ps = connection.prepareStatement("insert into userproject(pid,userid) values(?,?)");
                                ps.setInt(1, pid);
                                ps.setInt(2, selectedmembers[i]);
                                ps.executeUpdate();
                            } catch (Exception e) {
                                logger.error("Exception is Caught in updateProject : " + e);
                            }
                            try {
                                if (ps != null) {
                                    ps.close();
                                }
                            } catch (SQLException e) {
                                logger.error("Exception is Caught in updateProject : " + e);
                            }
                        }
                    }
                    seqStatement = connection.createStatement();
                    seqResultSet = seqStatement.executeQuery("select PROJECTCOMMENTID_SEQ.nextval as nextvalue from dual");
                    seqResultSet.next();
                    int nextValue = seqResultSet.getInt("nextvalue");
                    int adminId = 104;
                    Timestamp date = new Timestamp(new java.util.Date().getTime());
                    String comments = request.getParameter("comments");
                    projectComments = connection.prepareStatement("insert into APM_PROJECTCOMMENTS(COMMENTID ,PROJECTID ,COMMENTEDBY ,COMMENTS ,STATUS ,COMMENTEDON) values(?,?,?,?,?,?)");
                    projectComments.setInt(1, nextValue);
                    projectComments.setInt(2, pid);
                    projectComments.setInt(3, adminId);
                    projectComments.setString(4, comments);
                    projectComments.setString(5, status);
                    projectComments.setTimestamp(6, date);

                    projectComments.executeUpdate();

                    connection.commit();
                    connection.setAutoCommit(true);

                    if (projecttype != null) {
                        if (!existingPhase.equalsIgnoreCase(phase)) {
                            GetProjects.updateEndPhasedate(pid, existingPhase);
                            GetProjects.updateStartPhasedate(pid, phase);
                        }
                        if (status.equalsIgnoreCase("Finished")) {
                            GetProjects.updateEndPhasedate(pid, phase);
                        }
                    }
                    ApmTargetIssueCount atic = new ApmTargetIssueCount();
                    atic.setPid(pid);
                    atic.setCount(targetCount);
                    atic.setTargetDate(new java.util.Date());
                    GetProjects.updateTargetCount(atic);
                    // Added By sowjanya
                    if (showDetails == true) {
                        String sd = String.valueOf(showDetails);
                        ps2 = connection.prepareStatement("update project  set SHOWDETAILS='" + sd + "'  where pid=?");
                        ps2.setInt(1, pid);
                        ps2.executeUpdate();
                    } else if (showDetails == false) {
                        String sd = String.valueOf(showDetails);
                        ps2 = connection.prepareStatement("update project  set SHOWDETAILS='" + sd + "'  where pid=?");
                        ps2.setInt(1, pid);
                        ps2.executeUpdate();
                    }
             //added by sowjnaya
        %>

        <jsp:forward page="/admin/project/viewproject.jsp" />
        <%
                }
            } catch (Exception e) {
                connection.rollback();
                logger.error("Exception is Caught in updateProject : " + e);
            } finally {
                try {
                    if (seqStatement != null) {
                        seqStatement.close();
                    }
                } catch (SQLException e) {
                    logger.error("Exception is Caught in updateProject : " + e);
                }
                try {
                    if (seqResultSet != null) {
                        seqResultSet.close();
                    }
                } catch (SQLException e) {
                    logger.error("Exception is Caught in updateProject : " + e);
                }
                try {
                    if (ps1 != null) {
                        ps1.close();
                    }
                } catch (SQLException e) {
                    logger.error("Exception is Caught in updateProject : " + e);
                }

                try {
                    if (ps != null) {
                        ps.close();
                    }
                } catch (SQLException e) {
                    logger.error("Exception is Caught in updateProject : " + e);
                }
                try {
                    if (projectComments != null) {
                        projectComments.close();
                    }
                } catch (SQLException e) {
                    logger.error("Exception is Caught in updateProject : " + e);
                }
                try {
                    if (ps2 != null) {
                        ps2.close();
                    }
                } catch (SQLException e) {
                    logger.error("Exception is Caught in updateProject : " + e);
                }
                try {
                    if (connection != null) {
                        connection.close();
                    }
                } catch (SQLException e) {
                    logger.error("Exception is Caught in updateProject : " + e);
                }

            }
        %>


    </body>

</html>