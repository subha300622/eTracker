<%-- 
    Document   : createLeaveAjax
    Created on : 17 Apr, 2020, 12:45:12 PM
    Author     : vanithaalliraj
--%>
<%@page import="java.util.List"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@ page import="org.apache.log4j.*,com.eminent.leaveUtil.*,java.util.Calendar,com.eminent.util.GetProjectManager,java.util.Date,java.util.Calendar,java.sql.Connection,java.sql.PreparedStatement,java.sql.Statement,java.sql.ResultSet,pack.eminent.encryption.MakeConnection,com.eminent.util.SendMail"%>
<%
    //Configuring log4j properties

    Logger logger = Logger.getLogger("Create Leave");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%
            Connection connection = null;
            PreparedStatement stmt = null;
            Statement st = null;
            ResultSet rs = null;
            String to_date = null;
            String from_date = null;
            String project = null;
            String version = null;

            int approval = 0;
            int assignedto = 112;

            int approvalLevel = 1;
            //int hrId                 =      LeaveUtil.getHrLeaveApprover();
            int leaveId = 0;
            if (request.getParameter("leaveid") != null) {
                leaveId = Integer.parseInt(request.getParameter("leaveid"));
            }
            int approva = 0;
            if (request.getParameter("approval") != null) {
                approva = Integer.parseInt(request.getParameter("approval"));
            }
            String fromdate = request.getParameter("fromdate");
            String todate = request.getParameter("todate");
            String leaveType = request.getParameter("reason");
            String description = request.getParameter("description");
            String duration = request.getParameter("duration");
            logger.info("From Date" + fromdate);
            logger.info("To Date" + todate);
            logger.info("Leave Type" + leaveType);
            logger.info("Desc" + description);

            Date date = new Date();
            String projectVersion = com.eminent.util.ProjectFinder.findProject((Integer) session.getAttribute("userid_curr"));
            if (projectVersion != null) {
                project = projectVersion.substring(0, projectVersion.indexOf(":"));
                version = projectVersion.substring(projectVersion.indexOf(":") + 1, projectVersion.length());
                //             assignedto       =   Integer.parseInt(com.eminent.util.GetProjectManager.getManager(project, version));
                //all leave request centrally assigned to Gopal
                // assignedto  =  LeaveUtil.getLeaveApprover();
            } else {
                // assignedto  =   LeaveUtil.getLeaveApprover();;
            }
            int requestedby = (Integer) session.getAttribute("userid_curr");

            List<LeaveApproverMaintenance> list = LeaveApproverDAO.findByRequester(requestedby);
            if (list == null) {
            } else {
                for (LeaveApproverMaintenance lam : list) {
                    if (lam.getApprovalLevel() == 1) {
                        assignedto = lam.getApprover();
                        approvalLevel = 1;
                        break;
                    }
                }
            }
 //        if(requestedby==assignedto){
            //            if(requestedby!=hrId){
            //                    assignedto=hrId;
            //               }
            //        }

            java.util.Date d = new java.util.Date();

            Calendar cal = Calendar.getInstance();
            cal.setTime(d);

            int leaveid = 0;

            try {
                connection = MakeConnection.getConnection();
                stmt = connection.prepareStatement("insert into leave(leaveid,fromdate,todate,type,description,createdon,modifiedon,requestedby,assignedto,approval,duration) values(?,?,?,?,?,?,?,?,?,?,?)");

                todate = todate.trim();
                to_date = com.pack.ChangeFormat.getDateFormat(todate);
                from_date = com.pack.ChangeFormat.getDateFormat(fromdate.trim());

                Date dat = cal.getTime();
                java.sql.Timestamp timeStampDate = new java.sql.Timestamp(dat.getTime());

                st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                rs = st.executeQuery("select leaveid_seq.nextval from dual");
                if (rs != null) {
                    if (rs.next()) {
                        leaveid = rs.getInt("nextval");
                    }
                    logger.info("LeaveId" + leaveid);
                }
                if (leaveId != 0) {
                    LeaveUtil.deleteleave(leaveId);
                    leaveid = leaveId;
                }
                if (approva != 0) {
                    approval = approva;
                }
                stmt.setInt(1, leaveid);
                stmt.setDate(2, java.sql.Date.valueOf(from_date));
                stmt.setDate(3, java.sql.Date.valueOf(to_date));
                stmt.setString(4, leaveType);
                stmt.setString(5, description);
                stmt.setTimestamp(6, timeStampDate);
                stmt.setTimestamp(7, timeStampDate);
                stmt.setInt(8, requestedby);
                stmt.setInt(9, assignedto);
                stmt.setInt(10, approval);
                stmt.setString(11, duration);
                stmt.executeQuery();

                stmt = connection.prepareStatement("insert into LEAV_APPROVAL_HISTORY (LEAVEID,APPROVALLEVEL,APPROVER,UPDATEON,UPDATEDBY,COMMENTS) values(?,?,?,?,?,?)");
                stmt.setLong(1, leaveid);
                stmt.setInt(2, approvalLevel);
                stmt.setInt(3, assignedto);
                stmt.setTimestamp(4, timeStampDate);
                stmt.setInt(5, requestedby);
                stmt.setString(6, description);
                stmt.executeQuery();

                int i = 0;
                String leaveDetails[][] = LeaveUtil.getEditRequest(leaveid);
                String from = leaveDetails[i][1];
                String to = leaveDetails[i][2];
                String type = leaveDetails[i][3];
                String desc = leaveDetails[i][4];
                String created = leaveDetails[i][5];
                String modified = leaveDetails[i][6];

                String fname = (String) session.getAttribute("fName");
                String lname = (String) session.getAttribute("lName");
                String Name = fname + " " + lname;

                String htmlContent = "<b><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue >Leave Details</font></b><table align='center'>"
                        + "<tr bgcolor=#E8EEF7>"
                        + "<td ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >From Date</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + from + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >To Date</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + to + "</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Leave Type</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + leaveType + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Status</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Yet To Approve</td>"
                        + "</tr>"
                        + "<tr bgcolor=#E8EEF7><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested by</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Name + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Assigned To</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectManager.getUserName(assignedto) + "</td>"
                        + "</tr>"
                        + "<tr><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Created On</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + created + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Updated On</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + modified + "</td>"
                        + "</tr>"
                        + "<tr bgcolor=#E8EEF7><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Duratiuon</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + duration + "</td>"
                        + "</tr>"
                        + "<tr >"
                        + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Reason</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + description + "</td>"
                        + "</tr>"
                        + "</table>";

                String endLine = "</table><br>Thanks,";
                String signature = "<br>eTracker&trade;<br>";
                String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                String lineBreak = "<br>";

                String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";

                htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;

                String Subject = Name + " Leave Request Created";

                SendMail.leaveMailUpdate(htmlContent, requestedby, assignedto, Name, Subject);

            } catch (Exception e) {
                logger.error(e.getMessage());
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }

                } catch (Exception ex) {
                    logger.error(ex.getMessage());
                }
                try {
                    if (st != null) {
                        st.close();
                    }

                } catch (Exception ex) {
                    logger.error(ex.getMessage());
                }
                try {
                    if (stmt != null) {
                        stmt.close();
                    }

                } catch (Exception ex) {
                    logger.error(ex.getMessage());
                }
                try {
                    if (connection != null) {
                        connection.close();
                        logger.info("Connection Closed");
                    }

                } catch (Exception ex) {
                    logger.error(ex.getMessage());
                }
            }

        %>