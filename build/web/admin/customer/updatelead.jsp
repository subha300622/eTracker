<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8" import="java.util.*,org.apache.log4j.*,java.util.Calendar,com.eminent.util.*,javax.mail.*,javax.mail.internet.*"%>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
    Logger logger = Logger.getLogger("updatelead");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html ">
    <TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
        Solution</TITLE>
</head>
<body>
    <table width="100%" bgcolor="#EEEEEE" height="5%" border="0">
        <tr>
            <td align="left" width="800"><b><font size="3"
                                                  COLOR="#0000FF"> Current User: </font></b> <FONT SIZE="3" COLOR="#0000FF">
                    &nbsp; <b> &nbsp;<%=session.getAttribute("fName")%>&nbsp; <%=session.getAttribute("lName")%></b></FONT></td>
            <td width="6%" align="center"><font size="2"
                                                face="Verdana, Arial, Helvetica, sans-serif"> <a
                        href="<%=request.getContextPath()%>/profile.jsp">Profile</a></font></td>
            <td width="6%" align="center"><font size="2"
                                                face="Verdana, Arial, Helvetica, sans-serif"> <A
                        HREF="<%= request.getContextPath()%>/logout.jsp" target="_parent">Logout</A></font></td>
                        <%@ page import="java.sql.*,pack.eminent.encryption.*,com.pack.*"%>
                       <jsp:useBean id="Contact" class="com.eminent.customer.ContactRegistration"/>
                        <%!
                            String recipientMobile, recipientOperator, from, subject, host;
                        %>
                        <%
                            Connection connection = null;
                            PreparedStatement ps = null, ps1 = null, ps2 = null, ps3 = null;
                            Statement stInsert = null;
                            ResultSet rsInsert = null;

                            String firstname = null;
                            String lastname = null;
                            String company = null;
                            String title = null;
                            String leadstatus = null;
                            String phone = null;
                            String email = null;
                            String rating = null;
                            String street = null;
                            String city = null;
                            String state = null;
                            String zip = null;
                            String country = null;
                            String website = null;
                            String noofemployees = null;
                            String annualrevenue = null;
                            String leadsource = null;
                            String industry = "";
                            String mobile = null;
                            String leadpotential = null;
                            String erp = null;
                            String vendor = null;
                            String area = null;

                            String movetoopportunity = request.getParameter("movetoopportunity");
                            String leadowner = request.getParameter("owner");

                            String stage = "Prospecting";
                            String probability = "10";
                            String amount = "100";
                            int leadrole = 2;

                            String assignedto = null;
                            String duedate = null;

                            String product = null;

                            int leadid = 9999;

                            leadid = Integer.parseInt(request.getParameter("leadid"));
                            firstname = request.getParameter("firstname");
                            lastname = request.getParameter("lastname");
                            title = request.getParameter("title");
                            company = request.getParameter("company");
                            leadstatus = request.getParameter("leadstatus");
                            phone = request.getParameter("phone");
                            email = request.getParameter("email");
                            rating = request.getParameter("rating");
                            erp = request.getParameter("erp");
                            vendor = request.getParameter("vendor");
                            assignedto = request.getParameter("assignedto");

                            logger.info("Assigned to" + assignedto);
                            duedate = request.getParameter("duedate");
                            product = request.getParameter("product");

                            street = request.getParameter("mailingstreet");
                            city = request.getParameter("mailingcity");
                            state = request.getParameter("mailingstate");
                            zip = request.getParameter("zip");
                            country = request.getParameter("mailingcountry");
                            website = request.getParameter("website");
                            noofemployees = request.getParameter("noofemployees");
                            annualrevenue = request.getParameter("annualrevenue");
                            leadsource = request.getParameter("leadsource");
                            industry = request.getParameter("industry");
                            String description = request.getParameter("description");
                            if (description == null) {
                                description = "Nil";
                            }
                            mobile = request.getParameter("mobile");
                            leadpotential = request.getParameter("leadpotential");
                            description = request.getParameter("description");

                            String storeDate = com.pack.ChangeFormat.getDateFormat(duedate);
                            area = request.getParameter("mailingarea");
                            String newIndustry = request.getParameter("newIndustry");
                            String newMailingarea = request.getParameter("newMailingarea");
                            String newMailingcity = request.getParameter("newMailingcity");
                            String newMailingcountry = request.getParameter("newMailingcountry");
                            String newMailingstate = request.getParameter("newMailingstate");
                            String newVendor = request.getParameter("newVendor");
                            java.util.Date d = new java.util.Date();

                            Calendar cal = Calendar.getInstance();
                            cal.setTime(d);
                            //Timestamp ts = new Timestamp(cal.getTimeInMillis());
                            Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());

                            try {
                                connection = MakeConnection.getConnection();
                                if (connection != null) {
                                    
                                     if (industry.equals("new")) {
                                    industry = Contact.addIndustry(connection, newIndustry) + "";
                                }
                                if (vendor.equals("new")) {
                                    vendor = newVendor;
                                }
                                if (area.equals("new")) {
                                    area = newMailingarea;
                                }
                                if (city.equals("new")) {
                                    city = newMailingcity;
                                }
                                if (state.equals("new")) {
                                    state = newMailingstate;
                                }
                                if (country.equals("new")) {
                                    country = newMailingcountry;
                                }
                                    ps = connection.prepareStatement("update lead set firstname=?, lastname=?, title=?, leadstatus=?, phone=?, email=?, rating=?, street=?, city=?, state=?, zip=?, country=?, website=?, noofemployees=?, annualrevenue=?, leadsource=?, industry=?, description=?,company=?,mobile=?,leadpotential=?,assignedto=?,duedate=?,interested=?,modifiedon=?,erp=?,vendor=?,area=? where leadid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                    ps.setString(1, StringUtil.fixSqlFieldValue(firstname));
                                    ps.setString(2, StringUtil.fixSqlFieldValue(lastname));
                                    ps.setString(3, StringUtil.fixSqlFieldValue(title));
                                    ps.setString(4, StringUtil.fixSqlFieldValue(leadstatus));
                                    logger.info("Lead Status" + leadstatus);
                                    ps.setString(5, StringUtil.fixSqlFieldValue(phone));
                                    ps.setString(6, StringUtil.fixSqlFieldValue(email));
                                    ps.setString(7, StringUtil.fixSqlFieldValue(rating));
                                    logger.info("Lead Rating" + rating);
                                    ps.setString(8, StringUtil.fixSqlFieldValue(street));
                                    ps.setString(9, StringUtil.fixSqlFieldValue(city));
                                    ps.setString(10, StringUtil.fixSqlFieldValue(state));
                                    ps.setString(11, StringUtil.fixSqlFieldValue(zip));
                                    ps.setString(12, StringUtil.fixSqlFieldValue(country));
                                    ps.setString(13, StringUtil.fixSqlFieldValue(website));
                                    ps.setString(14, StringUtil.fixSqlFieldValue(noofemployees));
                                    ps.setString(15, StringUtil.fixSqlFieldValue(annualrevenue));
                                    ps.setString(16, StringUtil.fixSqlFieldValue(leadsource));
                                    ps.setInt(17, Integer.parseInt(industry));
                                    ps.setString(18, StringUtil.fixSqlFieldValue(description));
                                    ps.setString(19, StringUtil.fixSqlFieldValue(company));
                                    ps.setString(20, mobile);
                                    ps.setInt(21, Integer.parseInt(leadpotential));
                                    ps.setInt(22, Integer.parseInt(assignedto));
                                    ps.setDate(23, java.sql.Date.valueOf(storeDate));
                                    ps.setString(24, product);
                                    ps.setTimestamp(25, ts);
                                    ps.setString(26, StringUtil.fixSqlFieldValue(erp));
                                    ps.setString(27, StringUtil.fixSqlFieldValue(vendor));
                                    ps.setString(28, StringUtil.fixSqlFieldValue(area));
                                    ps.setInt(29, leadid);
                                    ps.executeUpdate();

                                    int x = 0;

                                    Integer user = (Integer) session.getAttribute("uid");
                                    String userId = String.valueOf(user);

                                    String comments = request.getParameter("comments");
                                    if (comments.length() > 0) {
                                        try {
                                            ps1 = connection.prepareStatement("insert into lead_comments(leadid,commentedby,commentedto,comment_date,lead_status,comments,duedate) values(?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                            ps1.setInt(1, leadid);
                                            ps1.setString(2, userId);
                                            ps1.setInt(3, Integer.parseInt(assignedto));
                                            ps1.setTimestamp(4, ts);
                                            ps1.setString(5, StringUtil.fixSqlFieldValue(leadstatus));
                                            ps1.setString(6, comments);
                                            ps1.setDate(7, java.sql.Date.valueOf(storeDate));
                                            x = ps1.executeUpdate();
                                            logger.info("Inserted one row:\t" + x);
                                        } catch (Exception e) {
                                            logger.error("Exception in Comments:" + e);
                                        } finally {
                                            if (ps1 != null) {
                                                ps1.close();
                                            }
                                            logger.debug("Comments are not empty");
                                        }
                                    }
                                    if (movetoopportunity != null) {
                                        stInsert = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                        rsInsert = stInsert.executeQuery("select opportunityid_seq.nextval from dual");
                                        if (rsInsert != null) {
                                            if (rsInsert.next()) {
                                                logger.info("creation of OPPORTUNITY ");
                                                int nextValue = rsInsert.getInt("nextval");
                                                ps2 = connection.prepareStatement("insert into opportunity (opportunity_owner,opportunityname,stage,probability,amount,leadsource,close_date,opportunityid,createdon,modifiedon,assignedto,lead_reference,roleid,phone,website) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                                                ps2.setString(1, StringUtil.fixSqlFieldValue(leadowner));
                                                ps2.setString(2, StringUtil.fixSqlFieldValue(company));
                                                ps2.setString(3, StringUtil.fixSqlFieldValue(stage));
                                                ps2.setString(4, StringUtil.fixSqlFieldValue(probability));
                                                ps2.setString(5, StringUtil.fixSqlFieldValue(amount));
                                                ps2.setString(6, StringUtil.fixSqlFieldValue(leadsource));
                                                ps2.setDate(7, java.sql.Date.valueOf(storeDate));
                                                ps2.setInt(8, nextValue);
                                                ps2.setTimestamp(9, ts);
                                                ps2.setTimestamp(10, ts);
                                                ps2.setInt(11, Integer.parseInt(assignedto));
                                                ps2.setInt(12, leadid);
                                                ps2.setInt(13, leadrole);
                                                ps2.setString(14, StringUtil.fixSqlFieldValue(phone));
                                                ps2.setString(15, StringUtil.fixSqlFieldValue(website));
                                                ps2.executeUpdate();

                                            }
                                        }

                                        int roleidUpdate = 3;
                                        ps3 = connection.prepareStatement("update lead set roleid=? where leadid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                        ps3.setInt(1, roleidUpdate);
                                        ps3.setInt(2, leadid);

                                        int y = ps3.executeUpdate();
                                        logger.info("lead update " + y);
                                    }
                                    Session ses1 = null;
                                    ResultSet res = null;
                                    Statement username = null;
                                    try {

                                        username = connection.createStatement();
                                        res = username.executeQuery("select email,mobile,mobileoperator from users where userid=" + assignedto);

                                        res.next();
                                        String to = res.getString(1);
                                        recipientMobile = res.getString(2);
                                        recipientOperator = res.getString(3);

                                        /* Eliminating hyphen in mobile no*/
                                        recipientMobile = recipientMobile.replaceAll("-", "");

                                        logger.info("Mail to" + to);
                                        logger.info("Mail to Mobile " + recipientMobile);
                                        logger.info("Mail to Mobile Operator" + recipientOperator);

                                        logger.info("Mail to Subject" + company);

                                        //	  			String mail = (String)application.getAttribute("MailServerName");
                                        // host = "smtp.gmail.com";
                                        //   host = "mail.eminentlabs.net";
                                        from = (String) session.getAttribute("theName");

                                        ArrayList<String> al = dashboard.Project.getDetails("CRM" + ":" + "1.0");
                                        ArrayList<String> dateTime = dashboard.CurrentDay.getDateTime();

                                        String createdOn = (String) session.getAttribute("createdOn");
                                        String foundVersion = (String) session.getAttribute("foundVersion");
                                        String fixVersion = (String) session.getAttribute("fixVersion");

                                        String fnme = (String) session.getAttribute("fName");
                                        String lname = (String) session.getAttribute("lName");
                                        String Name = fnme + lname;

                                        MimeMessage msg = MakeConnection.getMailConnections();
                                        msg.setFrom(new InternetAddress(from, Name));
                                        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                                        //	  				msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));
                                        msg.setSubject("eTracker CRM Lead has been Updated :  " + firstname + " " + lastname);
                                        String htmlContent = "<b><font color=blue >Project Details</font></b><table width=100% >"
                                                + "<tr bgcolor=#E8EEF7 ><td width = 18% ><b>Project</b></td>"
                                                + "<td width = 32% >CRM</td>"
                                                + "<td width = 18% ><b> Customer </b> </td>"
                                                + "<td width = 32% >Eminentlabs Software Pvt Ltd</td>"
                                                + "</tr>"
                                                + "<tr><td width   = 18% ><b> Version </b></td>"
                                                + "<td width = 32% >1.0</td>"
                                                + "<td width = 18% ><b>Manager</b> </td>"
                                                + "<td width = 32% >" + GetProjectManager.getUserName(Integer.parseInt(al.get(0))) + "</td> "
                                                + "</tr>"
                                                + "<tr  bgcolor=#E8EEF7><td width   = 18% ><b> Status </b></td>"
                                                + "<td width = 32% >" + al.get(4) + "</td>"
                                                + "<td width = 18% ><b>Phase</b> </td>"
                                                + "<td width = 32% >" + al.get(1) + "</td> "
                                                + "</tr>"
                                                + "<tr><td width   = 18% ><b>Start Date</b> </td>"
                                                + "<td width  = 32% >" + al.get(2) + "</td>"
                                                + "<td width  = 18% ><b>End Date</b> </td>"
                                                + "<td width = 32% >" + al.get(3) + "</td>"
                                                + "</tr></table><br><font color=blue><b>Updated CRM Lead details</b></font><table width=100% >"
                                                + "<tr bgcolor=#E8EEF7><td width = 18%  ><b>Name</b></td>"
                                                + "<td width = 32% >" + firstname + " " + lastname + "</td>"
                                                + "<td width = 18% ><b>Company </b> </td>"
                                                + "<td width = 32% >" + company + "</td>"
                                                + "</tr>"
                                                + "<tr ><td width   = 18% ><b>Mobile</b> </td>"
                                                + "<td width  = 32% >" + mobile + "</td>"
                                                + "<td width  = 18% ><b>Email</b> </td>"
                                                + "<td width = 32% >" + email + "</td>"
                                                + "</tr>"
                                                + "<tr bgcolor='#E8EEF7' >"
                                                + "<td width = 18% ><b>ERP </b> </td>"
                                                + "<td width = 32% >" + erp + "</td>"
                                                + "<td width  = 18% ><b>Vendor</b> </td>"
                                                + "<td width  = 32%  >" + vendor + "</td>"
                                                + "</tr>"
                                                + "<tr  >"
                                                + "<td width = 18% ><b>Updated On </b> </td>"
                                                + "<td width = 32% >" + dateTime.get(0) + "</td>"
                                                + "<td width  = 18% ><b>Updated Time</b> </td>"
                                                + "<td width  = 32%  >" + dateTime.get(1) + "</td>"
                                                + "</tr>"
                                                + "<tr bgcolor='#E8EEF7'>"
                                                + "<td width  = 18% ><b>Sender</b> </td>"
                                                + "<td width  = 32%  >" + session.getAttribute("fName") + session.getAttribute("lName") + "</td>"
                                                + "</tr>"
                                                + "<tr ><td width  = 18%  ><b>Comments</b> </td>"
                                                + "<td width  = 82% colspan=3 >" + comments + "</td>"
                                                + "</tr>"
                                                + "</table><br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;";
                                        msg.setContent(htmlContent, "text/html");
                                        Transport.send(msg);

                                    } catch (Exception exec) {
                                        exec.printStackTrace();
                                        logger.error("Exception in Sending Mail:" + exec);
                                    } finally {
                                        if (res != null) {
                                            res.close();
                                        }
                                        if (username != null) {
                                            username.close();
                                        }
                                    }

                                    String pag = (String) session.getAttribute("forwardpage");
                                    logger.info("page to forward" + pag);
                                    String link = "/admin/customer/" + pag;
                                    String link1 = "/contact/" + pag;
                        %>
                        <jsp:forward page="<%=link%>" >
                            <jsp:param name="email" value="<%=email%>"/>
                            <jsp:param name="newlead" value="Updated"/>
                        </jsp:forward>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                logger.error(e.getMessage());
                            } finally {
                                if (ps != null) {
                                    ps.close();
                                }
                                if (ps1 != null) {
                                    ps1.close();
                                }
                                if (ps2 != null) {
                                    ps1.close();
                                }
                                if (ps3 != null) {
                                    ps1.close();
                                }
                                if (stInsert != null) {
                                    stInsert.close();
                                }
                                if (rsInsert != null) {
                                    rsInsert.close();
                                }
                                if (connection != null) {
                                    connection.close();
                                }

                            }
                        %>
        </tr>
    </table>
    <br>
</body>
</html>