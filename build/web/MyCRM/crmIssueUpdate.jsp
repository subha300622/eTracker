<%@page import="com.eminentlabs.crm.CRMUtil"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8" import="com.eminent.util.*,java.util.*,org.apache.log4j.*,java.util.Calendar,javax.mail.*,javax.mail.internet.*,javax.mail.internet.MimeMessage"%>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
    Logger logger = Logger.getLogger("CRM Lead Update");
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
                PreparedStatement ps = null, ps1 = null, ps2 = null;

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
                String industry = null;
                String mobile = null;
                String leadpotential = null;
                String leadowner = null;

                String assignedto = null;
                String duedate = null;

                String product = null;
                String meetingDate = null;
                String meetingTime = null;
                String area = null;
                String leadType = "Normal";
                int leadid = 9999;

                String movetoopportunity = request.getParameter("movetoopportunity");

                String stage = "Prospecting";
                String probability = "10";
                String amount = "100";
                int leadrole = 2;

                leadid = Integer.parseInt(request.getParameter("leadid"));
                firstname = request.getParameter("firstname");
                lastname = request.getParameter("lastname");
                title = request.getParameter("title");
                company = request.getParameter("company");
                leadstatus = request.getParameter("leadstatus");
                phone = request.getParameter("phone");
                email = request.getParameter("email");
                rating = request.getParameter("rating");

                assignedto = request.getParameter("assignedto");

                logger.info("Assigned to" + assignedto);
                duedate = request.getParameter("duedate");
                product = request.getParameter("product");

                street = request.getParameter("street");
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
                String erp = request.getParameter("erp");
                String vendor = request.getParameter("vendor");
                area = request.getParameter("mailingarea");

                if (description == null) {
                    description = "Nil";
                }
                mobile = request.getParameter("mobile");
                leadpotential = request.getParameter("leadpotential");

                leadowner = request.getParameter("owner");

                String storeDate = com.pack.ChangeFormat.getDateFormat(duedate);

                java.util.Date d = new java.util.Date();

                Calendar cal = Calendar.getInstance();
                cal.setTime(d);
                //Timestamp ts = new Timestamp(cal.getTimeInMillis());
                Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());
                meetingTime = request.getParameter("meetingtime");
                meetingDate = request.getParameter("meetingdate");
                String newIndustry = request.getParameter("newIndustry");
                String newVendor = request.getParameter("newVendor");
                String newMailingarea = request.getParameter("newMailingarea");
                String newMailingcity = request.getParameter("newMailingcity");
                String newMailingcountry = request.getParameter("newMailingcountry");
                String newMailingstate = request.getParameter("newMailingstate");

                leadType = request.getParameter("leadType");
                String empCompany[] = request.getParameterValues("empCompany");
                String newempCompany[] = request.getParameterValues("newempCompany");
                String fromYear[] = request.getParameterValues("fromYear");
                String toYear[] = request.getParameterValues("toYear");
                String role[] = request.getParameterValues("role");
                String newrole[] = request.getParameterValues("newrole");
                String companyCompetitors[] = request.getParameterValues("companyCompetitors");
                String newcompanyCompetitors[] = request.getParameterValues("newcompanyCompetitors");
                String competitorcity[] = request.getParameterValues("competitorcity");
                String newcompetitorcity[] = request.getParameterValues("newcompetitorcity");
                String competitorstate[] = request.getParameterValues("competitorstate");
                String newcompetitorstate[] = request.getParameterValues("newcompetitorstate");
                String newcompetitorcountry[] = request.getParameterValues("newcompetitorcountry");
                String competitorcountry[] = request.getParameterValues("competitorcountry");
                String year[] = request.getParameterValues("year");
                String employees[] = request.getParameterValues("employees");
                String sales[] = request.getParameterValues("sales");
                String itSpend[] = request.getParameterValues("itSpend");
                String erpSpend[] = request.getParameterValues("erpSpend");
                String currency[] = request.getParameterValues("currency");
                String metDate = com.pack.ChangeFormat.getDateFormat(meetingDate);
                try {
                    connection = MakeConnection.getConnection();
                    if (connection != null) {

                        if (industry.equalsIgnoreCase("new")) {
                            int indId = Contact.addIndustry(connection, newIndustry);
                            industry = CRMUtil.getIndustry().get(indId);
                        }
                        if (vendor.equalsIgnoreCase("new")) {
                            vendor = newVendor;
                        }
                        if (area.equalsIgnoreCase("new")) {
                            area = newMailingarea;
                        }

                        if (city.equalsIgnoreCase("new")) {
                            city = newMailingcity;
                        }

                        if (state.equalsIgnoreCase("new")) {
                            state = newMailingstate;
                        }

                        if (country.equalsIgnoreCase("new")) {
                            country = newMailingcountry;
                        }

                        ps = connection.prepareStatement("update lead set firstname=?, lastname=?, title=?, leadstatus=?, phone=?, email=?, rating=?, street=?, city=?, state=?, zip=?, country=?, website=?, noofemployees=?, annualrevenue=?, leadsource=?, industry=?, description=?,company=?,mobile=?,leadpotential=?,assignedto=?,duedate=?,interested=?,modifiedon=?,erp=?,vendor=?,meeting_time=?,meeting_date=?,area=?,lead_type=? where leadid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
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
                        ps.setString(17, StringUtil.fixSqlFieldValue(industry));
                        ps.setString(18, StringUtil.fixSqlFieldValue(description));
                        ps.setString(19, StringUtil.fixSqlFieldValue(company));
                        ps.setString(20, mobile);
                        ps.setInt(21, Integer.parseInt(leadpotential));
                        ps.setInt(22, Integer.parseInt(assignedto));
                        ps.setDate(23, java.sql.Date.valueOf(storeDate));
                        ps.setString(24, product);
                        ps.setTimestamp(25, ts);
                        ps.setString(26, erp);
                        ps.setString(27, vendor);
                        ps.setString(28, StringUtil.fixSqlFieldValue(meetingTime));
                        ps.setDate(29, java.sql.Date.valueOf(metDate));
                        ps.setString(30, StringUtil.fixSqlFieldValue(area));
                        ps.setString(31, leadType);

                        ps.setInt(32, leadid);
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

                        if (leadType.equalsIgnoreCase("Normal")) {
                        } else {
                            int contactId = 0;
                            stInsert = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            rsInsert = stInsert.executeQuery("select contact_reference from lead where leadid=" + leadid + "");
                            if (rsInsert != null) {
                                if (rsInsert.next()) {
                                    contactId = rsInsert.getInt("contact_reference");
                                }
                            }
                            ps1 = connection.prepareStatement("delete from CONTACT_WORK_HISTORY where leadid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            ps1.setInt(1, leadid);
                            x = ps1.executeUpdate();
                            for (int i = 0; i < empCompany.length; i++) {
                                ps1 = connection.prepareStatement("insert into CONTACT_WORK_HISTORY(CONTACTID,COMPANY,FROM_YEAR,TO_YEAR,ROLE,leadid) values(?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                ps1.setInt(1, contactId);
                                ps1.setString(2, empCompany[i].equalsIgnoreCase("new") == true ? newempCompany[i] : empCompany[i]);
                                ps1.setInt(3, fromYear[i].equals("") == true ? 10 : Integer.parseInt(fromYear[i], 10));
                                ps1.setInt(4, toYear[i].equals("") == true ? 10 : Integer.parseInt(toYear[i], 10));
                                ps1.setString(5, role[i].equals("new") == true ? newrole[i] : (role[i] == null ? "" : role[i]));
                                ps1.setInt(6, leadid);
                                x = ps1.executeUpdate();
                            }
                            if (leadType.equalsIgnoreCase("Decision Maker")) {
                                ps1 = connection.prepareStatement("delete from CRM_COMPETITORS where COMPANY=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                ps1.setString(1, company);
                                x = ps1.executeUpdate();
                                if (companyCompetitors != null) {

                                    for (int i = 0; i < companyCompetitors.length; i++) {
                                        ps1 = connection.prepareStatement("insert into CRM_COMPETITORS(COMPANY,COMPETITOR,CITY,STATE,COUNTRY) values(?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                        ps1.setString(1, company);
                                        ps1.setString(2, companyCompetitors[i].equalsIgnoreCase("new") == true ? newcompanyCompetitors[i] : companyCompetitors[i]);
                                        ps1.setString(3, competitorcity[i].equalsIgnoreCase("new") == true ? newcompetitorcity[i] : competitorcity[i]);
                                        ps1.setString(4, competitorstate[i].equalsIgnoreCase("new") == true ? newcompetitorstate[i] : competitorstate[i]);
                                        ps1.setString(5, competitorcountry[i].equalsIgnoreCase("new") == true ? newcompetitorcountry[i] : competitorcountry[i]);
                                        x = ps1.executeUpdate();
                                    }
                                }
                                for (int i = 0; i < year.length; i++) {
                                    ps1 = connection.prepareStatement("delete from CRM_COMPANY_SALES  where COMPANY=? and SALES_YEAR=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                    ps1.setString(1, company);
                                    ps1.setInt(2, Integer.parseInt(year[i]));
                                    x = ps1.executeUpdate();
                                    ps1 = connection.prepareStatement("insert into CRM_COMPANY_SALES(COMPANY,SALES_YEAR,SALES,EMPLOYEES,IT_SPEND,ERP_SPEND,CURRENCY) values(?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                    ps1.setString(1, company);
                                    ps1.setInt(2, Integer.parseInt(year[i]));
                                    ps1.setLong(3, sales[i].equals("") == true ? 0 : Long.parseLong(sales[i]));
                                    ps1.setInt(4, employees[i].equals("") == true ? 0 : Integer.parseInt(employees[i]));
                                    ps1.setLong(5, itSpend[i].equals("") == true ? 0 : Long.parseLong(itSpend[i]));
                                    ps1.setLong(6, erpSpend[i].equals("") == true ? 0 : Long.parseLong(erpSpend[i]));
                                    ps1.setString(7, currency[i]);
                                    x = ps1.executeUpdate();
                                }
                            }
                        }

                        if (movetoopportunity != null) {
                            stInsert = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            rsInsert = stInsert.executeQuery("select opportunityid_seq.nextval from dual");
                            if (rsInsert != null) {
                                if (rsInsert.next()) {
                                    logger.info("creation of OPPORTUNITY ");
                                    int nextValue = rsInsert.getInt("nextval");
                                    ps2 = connection.prepareStatement("insert into opportunity (opportunity_owner,opportunityname,stage,probability,amount,leadsource,close_date,opportunityid,createdon,modifiedon,assignedto,lead_reference,roleid,meeting_time,meeting_date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
                                    ps2.setString(14, StringUtil.fixSqlFieldValue(meetingTime));
                                    ps2.setDate(15, java.sql.Date.valueOf(metDate));
                                    ps2.executeUpdate();

                                }
                            }

                            int roleidUpdate = 3;
                            ps1 = connection.prepareStatement("update lead set roleid=? where leadid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            ps1.setInt(1, roleidUpdate);
                            ps1.setInt(2, leadid);

                            int y = ps1.executeUpdate();
                            logger.info("lead update " + y);
                        }
                        Session ses1 = null;
                        ResultSet res = null;
                        Statement username = null;
                        try {

                            from = (String) session.getAttribute("theName");

                            ArrayList<String> al = dashboard.Project.getDetails("CRM" + ":" + "1.0");
                            ArrayList<String> dateTime = dashboard.CurrentDay.getDateTime();

                            String createdOn = (String) session.getAttribute("createdOn");
                            String foundVersion = (String) session.getAttribute("foundVersion");
                            String fixVersion = (String) session.getAttribute("fixVersion");

                            String fnme = (String) session.getAttribute("fName");
                            String lname = (String) session.getAttribute("lName");
                            String Name = fnme + lname;

                            subject = "eTracker CRM Lead has been Updated :  " + firstname + " " + lastname;
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
                                    + "<tr bgcolor=#E8EEF7 >"
                                    + "<td width = 18% ><b>Updated On </b> </td>"
                                    + "<td width = 32% >" + dateTime.get(0) + "</td>"
                                    + "<td width  = 18% ><b>Updated Time</b> </td>"
                                    + "<td width  = 32%  >" + dateTime.get(1) + "</td>"
                                    + "</tr>"
                                    + "<tr >"
                                    + "<td width  = 18% ><b>Sender</b> </td>"
                                    + "<td width  = 32%  >" + session.getAttribute("fName") + session.getAttribute("lName") + "</td>"
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

                        String pag = (String) session.getAttribute("forwardpage");
                        logger.info("page to forward" + pag);
                        String link = pag;
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
                    if (rsInsert != null) {
                        rsInsert.close();
                    }
                    if (ps != null) {
                        ps.close();
                    }
                    if (ps1 != null) {
                        ps1.close();
                    }
                    if (ps2 != null) {
                        ps2.close();
                    }
                    if (stInsert != null) {
                        stInsert.close();
                    }

                    if (connection != null) {
                        connection.close();
                        logger.info("connection closed");
                    }
                    if (connection.isClosed()) {
                        logger.info("Connection is Closed");
                    } else {
                        logger.info("Connection not Closed");
                    }

                }
            %>
        </tr>
    </table>
    <br>
</body>
</html>