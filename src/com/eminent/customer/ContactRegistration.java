package com.eminent.customer;

import com.eminent.util.GetProjectManager;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.SendMail;
import com.pack.StringUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import org.apache.log4j.Logger;

//import pack.eminent.encryption.Encryption;
public class ContactRegistration {

    static Logger logger = Logger.getLogger("Contact Registration");

    String uname = null;

    private String firstname = null;
    private String lastname = null;
    private String phone = null;
    private String mobile = null;
    private String email = null;
    private String personalemail = null;
    private String account = null;
    private String reportsto = null;
    private String rating = null;
    private String title = null;
    private String owner = null;
    private String mailingstreet = null;
    private String mailingzip = null;
    private String otherstreet = null;
    private String othercity = null;
    private String otherstate = null;
    private String otherzip = null;
    private String othercountry = null;
    private String fax = null;
    private String homephone = null;
    private String otherphone = null;
    private String assistant = null;
    private String asstphone = null;
    private String leadsource = null;
    private String birthdate = null;
    private String department = null;
    private String description = null;
    private String company = null;
    private String duedate = null;
    private String assignedto = null;
    private String erp;

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPhone() {
        return phone;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getMobile() {
        return mobile;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setPersonalemail(String personalemail) {
        this.personalemail = personalemail;
    }

    public String getPersonalemail() {
        return personalemail;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getAccount() {
        return account;
    }

    public void setReportsto(String reportsto) {
        this.reportsto = reportsto;
    }

    public String getReportsto() {
        return reportsto;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getRating() {
        return rating;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getOwner() {
        return owner;
    }

    public void setMailingstreet(String mailingstreet) {
        this.mailingstreet = mailingstreet;
    }

    public String getMailingstreet() {
        return mailingstreet;
    }

    public void setMailingzip(String mailingzip) {
        this.mailingzip = mailingzip;
    }

    public String getMailingzip() {
        return mailingzip;
    }

    public void setOtherstreet(String otherstreet) {
        this.otherstreet = otherstreet;
    }

    public String getOtherstreet() {
        return otherstreet;
    }

    public void setOthercity(String othercity) {
        this.othercity = othercity;
    }

    public String getOthercity() {
        return othercity;
    }

    public void setOtherstate(String otherstate) {
        this.otherstate = otherstate;
    }

    public String getOtherstate() {
        return otherstate;
    }

    public void setOtherzip(String otherzip) {
        this.otherzip = otherzip;
    }

    public String getOtherzip() {
        return otherzip;
    }

    public void setOthercountry(String othercountry) {
        this.othercountry = othercountry;
    }

    public String getOthercountry() {
        return othercountry;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getFax() {
        return fax;
    }

    public void setHomephone(String homephone) {
        this.homephone = homephone;
    }

    public String getHomephone() {
        return homephone;
    }

    public void setOtherphone(String otherphone) {
        this.otherphone = otherphone;
    }

    public String getOtherphone() {
        return otherphone;
    }

    public void setAssistant(String assistant) {
        this.assistant = assistant;
    }

    public String getAssistant() {
        return assistant;
    }

    public void setAsstphone(String asstphone) {
        this.asstphone = asstphone;
    }

    public String getAsstphone() {
        return asstphone;
    }

    public void setLeadsource(String leadsource) {
        this.leadsource = leadsource;
    }

    public String getLeadsource() {
        return leadsource;
    }

    public void setBirthdate(String birthdate) {
        this.birthdate = birthdate;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getDepartment() {
        return department;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getCompany() {
        return company;
    }

    public void setDuedate(String duedate) {
        this.duedate = duedate;
    }

    public String getDuedate() {
        return duedate;
    }

    public void setAssignedto(String assignedto) {
        this.assignedto = assignedto;
    }

    public String getAssignedto() {
        return assignedto;
    }

    public String getErp() {
        return erp;
    }

    public void setErp(String erp) {
        this.erp = erp;
    }

    public boolean CheckContact(Connection connection, String UserEmail) {
        Statement statement1 = null;
        ResultSet resultset1 = null;
        try {
            statement1 = connection.createStatement();

            resultset1 = statement1.executeQuery("select email from contact");
            if (resultset1 != null) {
                while (resultset1.next()) {
                    uname = resultset1.getString("email");

                    if (uname.equals(UserEmail)) {
                        return true;
                    }
                }
            }
        } catch (SQLException ex) {
            logger.error("CheckContact" + ex.getMessage());
        } finally {

            try {
                if (resultset1 != null) {

                    resultset1.close();

                }
                if (statement1 != null) {
                    statement1.close();
                }
            } catch (SQLException ex) {
                logger.error("CheckContact" + ex.getMessage());
            }
        }
        return false;
    }

    @SuppressWarnings("deprecation")
    public void CreateContact(Connection connection, String email, String industry, String vendor, String mailingarea, String mailingcity, String mailingstate, String mailingcountry, String department) {
        Statement statement1 = null, statement2 = null;
        ResultSet resultset1 = null, resultSet2 = null;
        PreparedStatement ps = null;
        int roleUser = 0;

        java.util.Date d = new java.util.Date();

        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        //Timestamp ts = new Timestamp(cal.getTimeInMillis());
        Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());

        try {
            statement1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset1 = statement1.executeQuery("select contactid_seq.nextval from dual");
            if (resultset1 != null) {
                while (resultset1.next()) {
                    int nextValue = resultset1.getInt("nextval");

                    statement2 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    resultSet2 = statement2.executeQuery("select roleid from role where role='Unconfirmed'");

                    if (resultSet2 != null) {
                        while (resultSet2.next()) {
                            roleUser = resultSet2.getInt("roleid");
                        }
                    }

                    logger.info(duedate);
                    String storeDate = com.pack.ChangeFormat.getDateFormat(duedate);
                    logger.info(account);

//                    PreparedStatement ps = connection.prepareStatement("insert into contact (contact_owner,firstname,lastname,accountname,title,phone,mobile,email,reportsto,mailingstreet,mailingcity,mailingstate,mailingzip,mailingcountry,otherstreet,othercity,otherstate,otherzip,othercountry,fax,homephone,otherphone,assistant,asstphone,leadsource,birthdate,department,description,contactid,roleid,company,duedate,createdon,modifiedon,assignedto,rating) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                    ps = connection.prepareStatement("insert into contact (contactid,title,firstname,lastname,phone,email,assignedto,mobile,company,reportsto,rating,accountname,contact_owner,duedate,mailingstreet,mailingcity,mailingstate,mailingzip,mailingcountry,fax,homephone,otherphone,department,assistant,asstphone,birthdate,leadsource,description,createdon,modifiedon,roleid,personalemail,erp,vendor,mailingarea,industry,contact_type) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                    ps.setInt(1, nextValue);
                    ps.setString(2, StringUtil.fixSqlFieldValue(title));
                    ps.setString(3, StringUtil.fixSqlFieldValue(firstname));
                    ps.setString(4, StringUtil.fixSqlFieldValue(lastname));
                    ps.setString(5, StringUtil.fixSqlFieldValue(phone));
                    ps.setString(6, StringUtil.fixSqlFieldValue(email));
                    ps.setInt(7, Integer.parseInt(assignedto));
                    ps.setString(8, StringUtil.fixSqlFieldValue(mobile));
                    ps.setString(9, StringUtil.fixSqlFieldValue(company));
                    ps.setString(10, StringUtil.fixSqlFieldValue(reportsto));
                    ps.setString(11, StringUtil.fixSqlFieldValue(rating));
                    ps.setString(12, StringUtil.fixSqlFieldValue(account));
                    ps.setString(13, StringUtil.fixSqlFieldValue(owner));
                    ps.setDate(14, java.sql.Date.valueOf(storeDate));
                    ps.setString(15, StringUtil.fixSqlFieldValue(mailingstreet));
                    ps.setString(16, mailingcity);
                    ps.setString(17, mailingstate);
                    ps.setString(18, StringUtil.fixSqlFieldValue(mailingzip));
                    ps.setString(19, mailingcountry);
                    ps.setString(20, StringUtil.fixSqlFieldValue(fax));
                    ps.setString(21, StringUtil.fixSqlFieldValue(homephone));
                    ps.setString(22, StringUtil.fixSqlFieldValue(otherphone));
                    ps.setString(23, department);
                    ps.setString(24, StringUtil.fixSqlFieldValue(assistant));
                    ps.setString(25, StringUtil.fixSqlFieldValue(asstphone));
                    ps.setString(26, StringUtil.fixSqlFieldValue(birthdate));
                    ps.setString(27, StringUtil.fixSqlFieldValue(leadsource));
                    ps.setString(28, StringUtil.fixSqlFieldValue(description));
                    ps.setTimestamp(29, ts);
                    ps.setTimestamp(30, ts);
                    ps.setInt(31, roleUser);
                    ps.setString(32, StringUtil.fixSqlFieldValue(personalemail));
                    ps.setString(33, StringUtil.fixSqlFieldValue(erp));
                    ps.setString(34, vendor);
                    ps.setString(35, mailingarea);
                    ps.setInt(36, Integer.parseInt(industry));
                    ps.setString(37, "Normal");

                    ps.executeUpdate();

                    try {

                        ArrayList<String> al = dashboard.Project.getDetails("CRM" + ":" + "1.0");
                        ArrayList<String> dateTime = dashboard.CurrentDay.getDateTime();

                        String Name = GetProjectManager.getUserName(Integer.parseInt(owner));
                        String subject = "eTracker CRM Contact has been Created :  " + Name;
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
                                + "<tr bgcolor='#E8EEF7' >"
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
                                + "<tr bgcolor='#E8EEF7'>"
                                + "<td width  = 18% ><b>Created By</b> </td>"
                                + "<td width  = 32%  >" + Name + "</td>"
                                + "<td width  = 18% ><b>Created On</b> </td>"
                                + "<td width  = 32%  >" + dateTime.get(0) + " " + dateTime.get(1) + "</td>"
                                + "</tr>"
                                + "<tr  >"
                                + "<td width = 18% ><b>Updated By </b> </td>"
                                + "<td width = 32% >" + Name + "</td>"
                                + "<td width  = 18% ><b>Updated On</b> </td>"
                                + "<td width  = 32%  >" + dateTime.get(0) + " " + dateTime.get(1) + "</td>"
                                + "</tr>"
                                + "<tr bgcolor='#E8EEF7'>"
                                + "<td width  = 18% ><b>Assigned To</b> </td>"
                                + "<td width  = 32%  >" + GetProjectManager.getUserFullName(Integer.parseInt(assignedto)) + "</td>"
                                + "</tr>";
                        String endLine = "</table><br>Thanks,";
                        String signature = "<br>eTracker&trade;<br>";
                        String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                        String lineBreak = "<br>";

                        String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";

                        htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;
                        SendMail.CRMContacts(htmlContent, subject, Name, assignedto, al.get(0), owner);

                    } catch (Exception exec) {
                        logger.error("Exception in Sending Mail:" + exec);
                    }
                }
            }
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            try {
                if (resultset1 != null) {

                    resultset1.close();

                }
                if (resultSet2 != null) {

                    resultSet2.close();

                }
                if (ps != null) {
                    ps.close();
                }
                if (statement1 != null) {
                    statement1.close();
                }
                if (statement2 != null) {
                    statement2.close();
                }
            } catch (SQLException ex) {
                logger.error("CheckContact" + ex.getMessage());
            }
        }
    }

    public List<String> erpList() {
        List<String> erpList = new ArrayList<String>();
        erpList.add("SAP");
        erpList.add("ORACLE");
        erpList.add("MS Dynamics");
        erpList.add("INFOR");
        erpList.add("TALLY");
        erpList.add("RAMCO");
        erpList.add("Home Grown");
        return erpList;
    }

    public int addIndustry(Connection connection, String industry) {
        Statement statement1 = null;
        ResultSet resultset1 = null;
        int industryId = 0;
        try {
            statement1 = connection.createStatement();

            resultset1 = statement1.executeQuery("select industry_id from CRM_Industry where industry='" + industry.trim() + "'");
            while (resultset1.next()) {
                industryId = resultset1.getInt(1);
            }
            if (industryId == 0) {
                statement1.executeUpdate("insert into CRM_Industry (industry,addedon) values('" + industry.trim() + "',(select sysdate from dual))");
                resultset1 = statement1.executeQuery("select industry_id from CRM_Industry where industry='" + industry.trim() + "'");
                while (resultset1.next()) {
                    industryId = resultset1.getInt(1);
                }
            }

        } catch (SQLException ex) {
            logger.error("addIndustry" + ex.getMessage());
        } finally {

            try {
                if (resultset1 != null) {

                    resultset1.close();

                }
                if (statement1 != null) {
                    statement1.close();
                }
            } catch (SQLException ex) {
                logger.error("CheckContact" + ex.getMessage());
            }
        }

        return industryId;
    }

    public int updateIndustry(Connection connection, String industry, Integer industryId) {
        Statement statement1 = null;
        ResultSet resultset1 = null;
        try {
            statement1 = connection.createStatement();
            statement1.executeUpdate("update CRM_Industry set industry ='" + industry.trim() + "' ,addedon=(select sysdate from dual) where industry_id=" + industryId + "");
            resultset1 = statement1.executeQuery("select industry_id from CRM_Industry where industry='" + industry.trim() + "'");
            while (resultset1.next()) {
                industryId = resultset1.getInt(1);
            }
        } catch (SQLException ex) {
            logger.error("addIndustry" + ex.getMessage());
        } finally {
            try {
                if (resultset1 != null) {
                    resultset1.close();
                }
                if (statement1 != null) {
                    statement1.close();
                }
            } catch (SQLException ex) {
                logger.error("CheckContact" + ex.getMessage());
            }
        }
        return industryId;
    }

    public List<String> contactType() {
        List<String> contactType = new ArrayList<String>();
        contactType.add("Normal");
        contactType.add("Influencer");
        contactType.add("Decision Maker");
        return contactType;
    }
}
