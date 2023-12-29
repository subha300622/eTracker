<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8" import="java.util.*,org.apache.log4j.*,com.eminent.util.*,javax.mail.*,javax.mail.internet.MimeMessage,javax.mail.internet.*,java.util.Properties"%>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
    Logger logger = Logger.getLogger("updatecontact");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html ">
    <TITLE>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS
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
                        <%@ page import="java.sql.*,pack.eminent.encryption.*,com.pack.*,java.util.Calendar"%>
                        <jsp:useBean id="Contact" class="com.eminent.customer.ContactRegistration">
                            <jsp:setProperty name="Contact" property="*" />
                        </jsp:useBean>
                        <%!
                            String recipientMobile, recipientOperator, from, subject, host;
                                                                                                                                                                                                                                            %>
                        <%
                            Connection connection = null;
                            PreparedStatement ps = null, ps1 = null, ps2 = null, ps3 = null;

                            Statement stInsert = null;
                            ResultSet rsInsert = null;

                            String firstname = "";
                            String lastname = "";
                            String accounts = "";
                            String title = "";
                            String phone = "";
                            String mobile = "";
                            String email = "";
                            String pmail = "";
                            String reportsto = "";
                            String mailingstreet = "";
                            String mailingcity = "";
                            String mailingstate = "";
                            String mailingzip = "";
                            String mailingcountry = "";

                            String otherstreet = "";
                            String othercity = "";
                            String otherstate = "";
                            String otherzip = "";
                            String othercountry = "";
                            String fax = "";
                            String homephone = "";
                            String otherphone = "";
                            String assistant = "";
                            String asstphone = "";
                            String leadsource = "";
                            String birthdate = "";
                            String department = "";

                            String company = null;
                            String assignedto = null;
                            String duedate = null;
                            String rating = null;
                            String product = null;
                            String movelead = null;
                            String erp = null;
                            String vendor = null;

                            int potential = 1;
                            int leadrole = 2;
                            String leadstatus = "Open";
                            String annualrevenue = null;
                            String noofemployees = null;
                            String industry = null;
                            String website = null;
                            String description = null;
                            String contactOwner = null;
                            String mailingarea = "";

                            int contactId = 9999;
                            contactId = Integer.parseInt(request.getParameter("contactid"));
                            firstname = request.getParameter("firstname");
                            lastname = request.getParameter("lastname");
                            accounts = request.getParameter("accounts");
                            title = request.getParameter("title");
                            phone = request.getParameter("phone");
                            mobile = request.getParameter("mobile");
                            email = request.getParameter("email");
                            pmail = request.getParameter("personalemail");
                            reportsto = request.getParameter("reportsto");

                            mailingstreet = request.getParameter("mailingstreet");
                            mailingcity = request.getParameter("mailingcity");
                            mailingstate = request.getParameter("mailingstate");
                            mailingzip = request.getParameter("mailingzip");
                            mailingcountry = request.getParameter("mailingcountry");
                            otherstreet = request.getParameter("otherstreet");
                            othercity = request.getParameter("othercity");
                            otherstate = request.getParameter("otherstate");
                            otherzip = request.getParameter("otherzip");
                            othercountry = request.getParameter("othercountry");

                            fax = request.getParameter("fax");
                            homephone = request.getParameter("homephone");
                            otherphone = request.getParameter("otherphone");
                            assistant = request.getParameter("assistant");
                            asstphone = request.getParameter("asstphone");

                            leadsource = request.getParameter("leadsource");
                            birthdate = request.getParameter("birthdate");
                            department = request.getParameter("department");

                            company = request.getParameter("company");
                            assignedto = request.getParameter("assignedto");
                            duedate = request.getParameter("duedate");
                            rating = request.getParameter("rating");
                            product = request.getParameter("product");
                            movelead = request.getParameter("movetolead");
                            contactOwner = request.getParameter("contactowner");
                            erp = request.getParameter("erp");
                            vendor = request.getParameter("vendor");
                            mailingarea = request.getParameter("mailingarea");
                            industry = request.getParameter("industry");
                            String newIndustry = request.getParameter("newIndustry");
                            String newVendor = request.getParameter("newVendor");
                            String newMailingarea = request.getParameter("newMailingarea");
                            String newMailingcity = request.getParameter("newMailingcity");
                            String newMailingcountry = request.getParameter("newMailingcountry");
                            String newMailingstate = request.getParameter("newMailingstate");
                            String newDepartment = request.getParameter("newDepartment");
                            logger.info("Move to lead value" + movelead);

                            String storeDate = com.pack.ChangeFormat.getDateFormat(duedate);

                            java.util.Date d = new java.util.Date();

                            Calendar cal = Calendar.getInstance();
                            cal.setTime(d);
                            //Timestamp ts = new Timestamp(cal.getTimeInMillis());
                            Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());

                            try {
                                connection = MakeConnection.getConnection();
                                if (industry.equalsIgnoreCase("new")) {
                                    industry = Contact.addIndustry(connection, newIndustry) + "";
                                }
                                if (vendor.equalsIgnoreCase("new")) {
                                    vendor = newVendor;
                                }
                                if (mailingarea.equalsIgnoreCase("new")) {
                                    mailingarea = newMailingarea;
                                }
                                if (mailingcity.equalsIgnoreCase("new")) {
                                    mailingcity = newMailingcity;
                                }
                                if (mailingstate.equalsIgnoreCase("new")) {
                                    mailingstate = newMailingstate;
                                }
                               if (mailingcountry.equalsIgnoreCase("new")) {
                                    mailingcountry = newMailingcountry;
                                }
                                if (department.equalsIgnoreCase("new")) {
                                    department = newDepartment;
                                }
                                if (connection != null) {
                                    ps = connection.prepareStatement("update contact set title=?,firstname=?, lastname=?, phone=?,email=?,assignedto=?, mobile=?,company=?, reportsto=?,rating=?,accountname=?,duedate=?, mailingstreet=?, mailingcity=?, mailingstate=?, mailingzip=?, mailingcountry=?, fax=?, homephone=?, otherphone=?,department=?, assistant=?, asstphone=?, leadsource=?, birthdate=?,modifiedon=?,interested=?,personalemail=?,erp=?,vendor=?,mailingarea=?,industry=? where contactid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                    ps.setString(1, StringUtil.fixSqlFieldValue(title));
                                    ps.setString(2, StringUtil.fixSqlFieldValue(firstname));
                                    ps.setString(3, StringUtil.fixSqlFieldValue(lastname));
                                    ps.setString(4, StringUtil.fixSqlFieldValue(phone));
                                    ps.setString(5, StringUtil.fixSqlFieldValue(email));
                                    ps.setInt(6, Integer.parseInt(assignedto));
                                    ps.setString(7, StringUtil.fixSqlFieldValue(mobile));
                                    ps.setString(8, StringUtil.fixSqlFieldValue(company));
                                    ps.setString(9, StringUtil.fixSqlFieldValue(reportsto));
                                    ps.setString(10, StringUtil.fixSqlFieldValue(rating));
                                    ps.setString(11, StringUtil.fixSqlFieldValue(accounts));
                                    ps.setDate(12, java.sql.Date.valueOf(storeDate));
                                    ps.setString(13, StringUtil.fixSqlFieldValue(mailingstreet));
                                    ps.setString(14, StringUtil.fixSqlFieldValue(mailingcity));
                                    ps.setString(15, StringUtil.fixSqlFieldValue(mailingstate));
                                    ps.setString(16, StringUtil.fixSqlFieldValue(mailingzip));
                                    ps.setString(17, StringUtil.fixSqlFieldValue(mailingcountry));
                                    ps.setString(18, StringUtil.fixSqlFieldValue(fax));
                                    ps.setString(19, StringUtil.fixSqlFieldValue(homephone));
                                    ps.setString(20, StringUtil.fixSqlFieldValue(otherphone));
                                    ps.setString(21, StringUtil.fixSqlFieldValue(department));
                                    ps.setString(22, StringUtil.fixSqlFieldValue(assistant));
                                    ps.setString(23, StringUtil.fixSqlFieldValue(asstphone));
                                    ps.setString(24, StringUtil.fixSqlFieldValue(leadsource));
                                    ps.setString(25, StringUtil.fixSqlFieldValue(birthdate));
                                    ps.setTimestamp(26, ts);
                                    ps.setString(27, StringUtil.fixSqlFieldValue(product));
                                    ps.setString(28, StringUtil.fixSqlFieldValue(pmail));
                                    ps.setString(29, StringUtil.fixSqlFieldValue(erp));
                                    ps.setString(30, StringUtil.fixSqlFieldValue(vendor));
                                    ps.setString(31, StringUtil.fixSqlFieldValue(mailingarea));
                                    ps.setInt(32, Integer.parseInt(industry));
                                    ps.setInt(33, contactId);

                                    ps.executeUpdate();
                                    connection.commit();

                                    int x = 0;

                                    Integer user = (Integer) session.getAttribute("uid");
                                    String userId = String.valueOf(user);

                                    String comments = request.getParameter("comments");
                                    if (comments.length() > 0) {
                                        try {
                                            ps1 = connection.prepareStatement("insert into contact_comments(contactid,commentedby,comment_date,comments,rating,duedate,commentedto) values(?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                            ps1.setInt(1, contactId);
                                            ps1.setString(2, userId);
                                            ps1.setTimestamp(3, ts);
                                            ps1.setString(4, comments);
                                            ps1.setString(5, rating);
                                            ps1.setDate(6, java.sql.Date.valueOf(storeDate));
                                            ps1.setInt(7, Integer.parseInt(assignedto));

                                            x = ps1.executeUpdate();
                                            logger.info("Inserted one row:\t" + x);
                                        } catch (Exception e) {
                                            logger.error("Exception in Comments:" + e);
                                            logger.error(e.getMessage());
                                        } finally {
                                            if (ps1 != null) {
                                                ps1.close();
                                            }
                                            logger.debug("Comments are not empty");
                                        }
                                    }
                                    if (movelead != null) {

                                        stInsert = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                        rsInsert = stInsert.executeQuery("select leadid_seq.nextval from dual");
                                        if (rsInsert != null) {
                                            if (rsInsert.next()) {
                                                logger.info("creation of lead ");
                                                int nextValue = rsInsert.getInt("nextval");
                                                //				ps=connection.prepareStatement("insert into lead (lead_owner,firstname,lastname,company,title,leadstatus,phone,email,rating,street,city,state,zip,country,website,noofemployees,annualrevenue,leadsource,industry,description,leadid,roleid,mobile,leadpotential,createdon) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                                                ps2 = connection.prepareStatement("insert into lead (lead_owner,title,firstname,lastname,phone,email,company,mobile,leadstatus,assignedto,rating,website,leadpotential,duedate,interested,street,city,state,zip,country,annualrevenue,noofemployees,industry,leadsource,description,leadid,roleid,createdon,modifiedon,contact_reference,erp,vendor,area) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

                                                ps2.setString(1, StringUtil.fixSqlFieldValue(contactOwner));

                                                ps2.setString(2, StringUtil.fixSqlFieldValue(title));
                                                ps2.setString(3, StringUtil.fixSqlFieldValue(firstname));
                                                ps2.setString(4, StringUtil.fixSqlFieldValue(lastname));

                                                ps2.setString(5, StringUtil.fixSqlFieldValue(phone));
                                                ps2.setString(6, StringUtil.fixSqlFieldValue(email));
                                                ps2.setString(7, StringUtil.fixSqlFieldValue(company));

                                                ps2.setString(8, mobile);
                                                ps2.setString(9, StringUtil.fixSqlFieldValue(leadstatus));
                                                ps2.setInt(10, Integer.parseInt(assignedto));

                                                ps2.setString(11, StringUtil.fixSqlFieldValue(rating));
                                                ps2.setString(12, StringUtil.fixSqlFieldValue(website));
                                                ps2.setInt(13, potential);

                                                ps2.setDate(14, java.sql.Date.valueOf(storeDate));
                                                ps2.setString(15, StringUtil.fixSqlFieldValue(product));

                                                ps2.setString(16, StringUtil.fixSqlFieldValue(mailingstreet));
                                                ps2.setString(17, StringUtil.fixSqlFieldValue(mailingcity));
                                                ps2.setString(18, StringUtil.fixSqlFieldValue(mailingstate));

                                                ps2.setString(19, StringUtil.fixSqlFieldValue(mailingzip));
                                                ps2.setString(20, StringUtil.fixSqlFieldValue(mailingcountry));

                                                ps2.setString(21, StringUtil.fixSqlFieldValue(annualrevenue));
                                                ps2.setString(22, StringUtil.fixSqlFieldValue(noofemployees));

                                                ps2.setString(23, StringUtil.fixSqlFieldValue(industry));
                                                ps2.setString(24, StringUtil.fixSqlFieldValue(leadsource));

                                                ps2.setString(25, StringUtil.fixSqlFieldValue(description));

                                                ps2.setInt(26, nextValue);
                                                ps2.setInt(27, leadrole);

                                                ps2.setTimestamp(28, ts);
                                                ps2.setTimestamp(29, ts);
                                                ps2.setInt(30, contactId);
                                                ps2.setString(31, StringUtil.fixSqlFieldValue(erp));
                                                ps2.setString(32, StringUtil.fixSqlFieldValue(vendor));
                                                ps.setString(33, StringUtil.fixSqlFieldValue(mailingarea));

                                                int k = ps2.executeUpdate();
                                                logger.info("moving contact to lead" + k);
                                            }
                                        }

                                        int roleidUpdate = 3;
                                        ps3 = connection.prepareStatement("update contact set roleid=? where contactid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                        ps3.setInt(1, roleidUpdate);
                                        ps3.setInt(2, contactId);

                                        int y = ps3.executeUpdate();
                                        logger.info("Contact update " + y);

                                    }

                                    Session ses1 = null;
                                    ResultSet res = null;
                                    Statement username = null;
                                    try {

                                        ArrayList<String> al = dashboard.Project.getDetails("CRM" + ":" + "1.0");
                                        ArrayList<String> dateTime = dashboard.CurrentDay.getDateTime();

                                        String fnme = (String) session.getAttribute("fName");
                                        String lname = (String) session.getAttribute("lName");
                                        String Name = fnme + lname;
                                        String subject = "eTracker CRM Contact has been Updated :  " + firstname + " " + lastname;
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
                                                + "</tr></table><br><font color=blue><b>Updated CRM Contact details</b></font><table width=100% >"
                                                + "<tr bgcolor=#E8EEF7><td width = 18%  ><b>Name</b></td>"
                                                + "<td width = 32% >" + firstname + " " + lastname + "</td>"
                                                + "<td width = 18% ><b>Company </b> </td>"
                                                + "<td width = 32% >" + company + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<td width   = 18% ><b>Mobile</b> </td>"
                                                + "<td width  = 32% >" + mobile + "</td>"
                                                + "<td width  = 18% ><b>Email</b> </td>"
                                                + "<td width = 32% >" + email + "</td>"
                                                + "</tr>"
                                                + "<tr bgcolor=#E8EEF7 >"
                                                + "<td width = 18% ><b>Rating </b> </td>"
                                                + "<td width = 32% >" + rating + "</td>"
                                                + "<td width  = 18% ><b>Due Date</b> </td>"
                                                + "<td width  = 32%  >" + duedate + "</td>"
                                                + "</tr>"
                                                + "<tr  >"
                                                + "<td width = 18% ><b>ERP </b> </td>"
                                                + "<td width = 32% >" + erp + "</td>"
                                                + "<td width  = 18% ><b>Vendor</b> </td>"
                                                + "<td width  = 32%  >" + vendor + "</td>"
                                                + "</tr>"
                                                + "<tr bgcolor=#E8EEF7>"
                                                + "<td width  = 18% ><b>Created By</b> </td>"
                                                + "<td width  = 32%  >" + GetProjectManager.getUserFullName(Integer.parseInt(contactOwner)) + "</td>"
                                                + "<td width  = 18% ><b>Interested In</b> </td>"
                                                + "<td width  = 32%  >" + product + "</td>"
                                                + "</tr>"
                                                + "<tr  >"
                                                + "<td width = 18% ><b>Updated By </b> </td>"
                                                + "<td width = 32% >" + session.getAttribute("fName") + " " + session.getAttribute("lName") + "</td>"
                                                + "<td width  = 18% ><b>Updated On</b> </td>"
                                                + "<td width  = 32%  >" + dateTime.get(0) + " " + dateTime.get(1) + "</td>"
                                                + "</tr>"
                                                + "<tr >"
                                                + "<td width  = 18% ><b>Assigned To</b> </td>"
                                                + "<td width  = 32%  >" + GetProjectManager.getUserFullName(Integer.parseInt(assignedto)) + "</td>"
                                                + "</tr>"
                                                + "<tr bgcolor=#E8EEF7><td width  = 18%  ><b>Comments</b> </td>"
                                                + "<td width  = 82% colspan=3 >" + comments + "</td>"
                                                + "</tr>";
                                        String endLine = "</table><br>Thanks,";
                                        String signature = "<br>eTracker&trade;<br>";
                                        String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                                        String lineBreak = "<br>";

                                        String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";

                                        htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;
                                        SendMail.CRMContacts(htmlContent, subject, Name, assignedto, al.get(0), userId);

                                    } catch (Exception exec) {
                                        logger.error("Exception in Sending Mail:" + exec);
                                    } finally {
                                        if (res != null) {
                                            res.close();
                                        }
                                        if (username != null) {
                                            username.close();
                                        }
                                    }
                                    /*
                                     Sending SMS while Updating issue

                                     */
                        %>

            <jsp:forward page="viewcontact.jsp" >
                <jsp:param name="email" value="<%=email%>"/>
                <jsp:param name="newcontact" value="Updated"/>
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
                        ps2.close();
                    }
                    if (ps3 != null) {
                        ps3.close();
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