/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm.dao;

import com.eminent.util.GetProjectManager;
import com.eminent.util.SendMail;
import com.eminentlabs.crm.dto.Contact;
import static com.eminentlabs.userBPM.BPMUtil.logger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class ContactDAOImpl implements ContactDAO {

    @Override
    public boolean checkOut(String userEmail) {
        Connection connection = null;
        Statement statement1 = null;
        ResultSet resultset1 = null;
        try {

            connection = MakeConnection.getConnection();
            statement1 = connection.createStatement();

            resultset1 = statement1.executeQuery("select email from contact");
            if (resultset1 != null) {
                while (resultset1.next()) {
                    String uname = resultset1.getString("email");

                    if (uname.equals(userEmail)) {
                        return true;
                    }
                }
            }
        } catch (SQLException ex) {
            logger.error("CheckContact" + ex.getMessage());
        } catch (Exception ex) {
            Logger.getLogger(ContactDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {

            try {
                if (resultset1 != null) {

                    resultset1.close();

                }
                if (statement1 != null) {
                    statement1.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                logger.error("CheckContact" + ex.getMessage());
            }
        }
        return false;
    }

    @Override
    public void saveContact(Contact contact) {

        Connection connection = null;
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
            connection = MakeConnection.getConnection();

            statement1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset1 = statement1.executeQuery("select contactid_seq.nextval from dual");
            if (resultset1 != null) {
                while (resultset1.next()) {
                    int nextValue = resultset1.getInt("nextval");

                    // statement2 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    // resultSet2 = statement2.executeQuery("select roleid from role where role='Unconfirmed'");
                    String storeDate = com.pack.ChangeFormat.getDateFormat(contact.getDuedate());

//                    PreparedStatement ps = connection.prepareStatement("insert into contact (contact_owner,firstname,lastname,accountname,title,phone,mobile,email,reportsto,mailingstreet,mailingcity,mailingstate,mailingzip,mailingcountry,otherstreet,othercity,otherstate,otherzip,othercountry,fax,homephone,otherphone,assistant,asstphone,leadsource,birthdate,department,description,contactid,roleid,company,duedate,createdon,modifiedon,assignedto,rating) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                    ps = connection.prepareStatement("insert into contact (contactid,title,firstname,lastname,phone,email,assignedto,mobile,company,accountname,contact_owner,duedate,mailingstreet,mailingcity,mailingstate,mailingzip,mailingcountry,createdon,modifiedon,roleid,erp,vendor) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                    ps.setInt(1, nextValue);
                    ps.setString(2, contact.getTitle());
                    ps.setString(3, contact.getFirstname());
                    if (contact.getLastname().equalsIgnoreCase("NA")) {
                        ps.setString(4, " ");
                    } else {
                        ps.setString(4, contact.getLastname());
                    }
                    ps.setString(5, contact.getPhone());
                    ps.setString(6, contact.getEmail());
                    ps.setInt(7, Integer.parseInt(contact.getAssignedto()));
                    ps.setString(8, contact.getMobile());
                    ps.setString(9, contact.getCompany());
                    ps.setString(10, contact.getAccount());
                    ps.setString(11, String.valueOf(contact.getOwner()));
                    ps.setDate(12, java.sql.Date.valueOf(storeDate));
                    ps.setString(13, contact.getMailingstreet());
                    ps.setString(14, contact.getMailingcity());
                    ps.setString(15, contact.getMailingstate());
                    ps.setString(16, contact.getMailingzip());
                    ps.setString(17, contact.getMailingcountry());
                    ps.setTimestamp(18, ts);
                    ps.setTimestamp(19, ts);
                    ps.setInt(20, 2);
                    ps.setString(21, contact.getErp());
                    ps.setString(22, contact.getVendor());
                    ps.executeUpdate();

                    try {

                        ArrayList<String> al = dashboard.Project.getDetails("CRM" + ":" + "1.0");
                        ArrayList<String> dateTime = dashboard.CurrentDay.getDateTime();

                        String Name = GetProjectManager.getUserName(contact.getOwner());
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
                                + "<td width = 32% >" + contact.getFirstname() + " " + contact.getLastname() + "</td>"
                                + "<td width = 18% ><b>Company </b> </td>"
                                + "<td width = 32% >" + contact.getCompany() + "</td>"
                                + "</tr>"
                                + "<tr>"
                                + "<td width   = 18% ><b>Mobile</b> </td>"
                                + "<td width  = 32% >" + contact.getMobile() + "</td>"
                                + "<td width  = 18% ><b>Email</b> </td>"
                                + "<td width = 32% >" + contact.getEmail() + "</td>"
                                + "</tr>"
                                + "<tr bgcolor='#E8EEF7' >"
                                + "<td width  = 18% ><b>Due Date</b> </td>"
                                + "<td width  = 32%  >" + contact.getDuedate() + "</td>"
                                + "<td width = 18% ><b>ERP </b> </td>"
                                + "<td width = 32% >" + contact.getErp() + "</td>"
                                + "</tr>"
                                + "<tr >"
                                + "<td width  = 18% ><b>Vendor</b> </td>"
                                + "<td width  = 32%  >" + contact.getVendor() + "</td>"
                                + "<td width  = 18% ><b>Created By</b> </td>"
                                + "<td width  = 32%  >" + Name + "</td>"
                                + "</tr>"
                                + "<tr bgcolor='#E8EEF7'>"
                                + "<td width  = 18% ><b>Created On</b> </td>"
                                + "<td width  = 32%  >" + dateTime.get(0) + " " + dateTime.get(1) + "</td>"
                                + "<td width = 18% ><b>Updated By </b> </td>"
                                + "<td width = 32% >" + Name + "</td>"
                                + "</tr>"
                                + "<tr >"
                                + "<td width  = 18% ><b>Updated On</b> </td>"
                                + "<td width  = 32%  >" + dateTime.get(0) + " " + dateTime.get(1) + "</td>"
                                + "<td width  = 18% ><b>Assigned To</b> </td>"
                                + "<td width  = 32%  >" + GetProjectManager.getUserFullName(Integer.parseInt(contact.getAssignedto())) + "</td>"
                                + "</tr>";
                        String endLine = "</table><br>Thanks,";
                        String signature = "<br>eTracker&trade;<br>";
                        String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                        String lineBreak = "<br>";

                        String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";

                        htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;
                        SendMail.CRMContacts(htmlContent, subject, Name, contact.getAssignedto(), al.get(0), String.valueOf(contact.getOwner()));
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
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                logger.error("CheckContact" + ex.getMessage());
            }
        }
    }

}
