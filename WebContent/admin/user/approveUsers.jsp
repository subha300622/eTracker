<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*"%>
<%@ page import="org.apache.log4j.*"%>
<%@ page import="com.pack.MyAuthenticator,com.eminent.util.*"%>
<%@ page import="javax.mail.*,dashboard.*"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="com.eminent.util.GetProjects"%>
<%

    //Configuring log4j properties
    Logger logger = Logger.getLogger("ApproveUsers");
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
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
</head>
<body>

    <%
        /*Enumeration names = request.getParameterNames();  
         System.out.println(names);
         int i = 0;
         if(names.hasMoreElements()){
         System.out.println("i"+i);
         System.out.println(names.nextElement());
         i++;
         }*/
        ArrayList<String> teamlist = new ArrayList<String>();
        ArrayList<String> projectlist = new ArrayList<String>();
        ArrayList<Integer> branchlist = new ArrayList<Integer>();

        String[] formname = request.getParameterValues("submit");
        String[] userid = request.getParameterValues("approve");
        String[] Teams = request.getParameterValues("Team");
        String[] project = request.getParameterValues("project");
        String[] branch = request.getParameterValues("branch");

        Connection connection = null;
        PreparedStatement ps = null, projectUpdate = null;
        connection = MakeConnection.getConnection();
        if (formname[0].equalsIgnoreCase("Approve")) {
            int noofrecords = 0;
            try {
                logger.info("Form length" + formname.length);
                logger.info("User ID Length" + userid.length);
                logger.info("Teams Lenght" + Teams.length);
                logger.info("Project Length" + project.length);
                int i = 0;
                while (i < Teams.length) {
                    //					logger.info("Team"+Teams[i]);
                    //					logger.info("Project"+project[i]);
                    if (!Teams[i].equals("--Select--")) {
                        teamlist.add(Teams[i]);
                        projectlist.add(project[i]);
                        branchlist.add(Integer.parseInt(branch[i]));
                    }

                    i++;
                }
                logger.info(teamlist);
                logger.info(projectlist);

                ps = connection.prepareStatement("update users set roleid=?,team=?,BRANCH_ID=? where userid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                projectUpdate = connection.prepareStatement("insert into userproject(pid,userid) values(?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                int assignedPid = 0;
                for (int x = 0; x < userid.length; x++) {
                    assignedPid = Integer.parseInt(projectlist.get(x));
                    if (GetProjects.getProject(assignedPid).equalsIgnoreCase("CRM")) {
                        ps.setInt(1, 3);
                    } else {
                        ps.setInt(1, 2);
                    }
                    ps.setString(2, teamlist.get(x));
                    ps.setInt(3, branchlist.get(x));
                    ps.setInt(4, Integer.parseInt(userid[x]));
                    ps.addBatch();

                    // User Project Update
                    projectUpdate.setInt(1, assignedPid);
                    projectUpdate.setInt(2, Integer.parseInt(userid[x]));
                    projectUpdate.addBatch();

                }
                int y[] = ps.executeBatch();
                int z[] = projectUpdate.executeBatch();
                connection.commit();
                noofrecords = y.length;
                //Edited by sowjnaya
                MimeMessage msg = MakeConnection.getMailConnections();
                //Edit end by sowjnaya
                msg.setFrom(new InternetAddress("admin@eminentlabs.net"));

                for (int x = 0; x < userid.length; x++) {

                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress(GetProjectMembers.getMail(userid[x])));
                    //					msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));
                    msg.setSubject("Your eTracker Account Has Been Approved by Admin!!");
                    String htmlContent = "<table width='100%'><tr><td><font color=blue >Dear User,</font><td></tr><tr><td></td></tr><tr><td><b><font color=blue >Your eTracker&trade; account has been approved. You can access <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a></font></b><td></tr><tr><td></td></tr><tr><td><font color=blue >Thanks,</font></td></tr><tr><td><font color=blue >eTracker&trade;  Team</font></td></tr></table>";

                    String emi = "<br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                    String lineBreak = "<br>";

                    htmlContent = htmlContent + emi + lineBreak;

                    msg.setContent(htmlContent, "text/html");

                    Transport.send(msg);

                    /*Edit by Mukesh*/
                    UserRegistrationMail.UserApprovedMailval(userid[x], "Approved");
                    /*Edit  end by Mukesh*/
                }

    %>
    <jsp:forward page="waitingForApproval.jsp">
        <jsp:param name="update" value="approved" />
        <jsp:param name="noofrecords" value="<%= y.length%>" />
    </jsp:forward>
    <%
    } catch (MessagingException e) {
    %>
    <jsp:forward page="waitingForApproval.jsp">
        <jsp:param name="update" value="approved" />
        <jsp:param name="noofrecords" value="<%= noofrecords%>" />
    </jsp:forward>
    <%
            logger.error(e.getMessage());
        } catch (Exception e) {

            logger.error(e.getMessage());
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    } else if (formname[0].equalsIgnoreCase("Deny")) {
        try {
            ps = connection.prepareStatement("update users set roleid=-1 where userid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            for (int x = 0; x < userid.length; x++) {
                //ps.setString(1,Teams[x]);
                ps.setInt(1, Integer.parseInt(userid[x]));
                ps.addBatch();
                /*Edit by mukesh*/
                UserRegistrationMail.UserApprovedMailval(userid[x], "Denied");
                /*Edit by mukesh*/
            }
            int y[] = ps.executeBatch();
            connection.commit();
    %>
    <jsp:forward page="deniedUsers.jsp">
        <jsp:param name="update" value="denied" />
        <jsp:param name="noofrecords" value="<%= y.length%>" />
    </jsp:forward>
    <%

            //System.out.println(y.length+"rows updated");
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    } else if (formname[0].equalsIgnoreCase("Disable")) {
        try {
            ps = connection.prepareStatement("update users set roleid=-2 where userid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            for (int x = 0; x < userid.length; x++) {
                ps.setInt(1, Integer.parseInt(userid[x]));
                ps.addBatch();
                /*Edit by mukesh*/

                UserRegistrationMail.UserApprovedMailval(userid[x], "Disabled");
                /*Edit by mukesh*/
            }
            int y[] = ps.executeBatch();
            connection.commit();
    %>
    <jsp:forward page="viewuser.jsp">
        <jsp:param name="update" value="disabled" />
        <jsp:param name="noofrecords" value="<%= y.length%>" />
    </jsp:forward>
    <%

            //				logger.info(y.length+"rows updated");
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    } else if (formname[0].equalsIgnoreCase("Enable")) {
        try {
            ps = connection.prepareStatement("update users set roleid=2 where userid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            for (int x = 0; x < userid.length; x++) {
                ps.setInt(1, Integer.parseInt(userid[x]));
                ps.addBatch();
            }
            int y[] = ps.executeBatch();
            connection.commit();
    %>
    <jsp:forward page="viewuser.jsp">
        <jsp:param name="update" value="enabled" />
        <jsp:param name="noofrecords" value="<%= y.length%>" />
    </jsp:forward>
    <%

            //System.out.println(y.length+"rows updated");
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    } else if (formname[0].equalsIgnoreCase("Request for Approval")) {

        try {
            ps = connection.prepareStatement("update users set roleid=0 where userid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            for (int x = 0; x < userid.length; x++) {
                ps.setInt(1, Integer.parseInt(userid[x]));
                ps.addBatch();
            }
            int y[] = ps.executeBatch();
            connection.commit();
    %>
    <jsp:forward page="waitingForApproval.jsp">
        <jsp:param name="update" value="enabled for approve" />
        <jsp:param name="noofrecords" value="<%= y.length%>" />
    </jsp:forward>
    <%

                //System.out.println(y.length+"rows updated");
            } catch (Exception e) {
                logger.error(e.getMessage());
            } finally {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            }

        }

    %>


</body>
</html>