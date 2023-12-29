/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack.controller;

import com.eminent.timesheet.specifiedAllUsers;
import com.eminent.util.SendMail;
import com.eminentlabs.crm.controller.ContactController;
import com.eminentlabs.crm.controller.MailCampaignController;
import com.eminentlabs.crm.dao.ContactDAOImpl;
import com.eminentlabs.crm.dto.Contact;
import com.eminentlabs.crm.persistence.MailCampaign;
import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import static com.eminentlabs.userBPM.BPMUtil.logger;
import com.pack.ReadExcel;
import com.pack.SendSms;
import com.pack.SendSmsToMobile;
import java.io.File;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import oracle.jdbc.driver.OracleTypes;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import static org.hibernate.type.descriptor.java.DateTypeDescriptor.DATE_FORMAT;
import org.jsoup.Jsoup;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author EMINENT
 */
public class MailMaintanceController {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("MailMaintanceController");
    }
    String message = "";
    String sendsmsdetails = "";
    LinkedHashMap<Integer, String> sendSmslist = new LinkedHashMap<Integer, String>();
    List<String> remainContacts = new ArrayList<String>();
    List<String> existed = new ArrayList<String>();
    List<String> mailnotSent = new ArrayList<String>();

    public void addMailContentToDB(HttpServletRequest request) {

        HttpSession session = request.getSession();

        if (request.getParameter("smsid") != null && request.getParameter("smsid").length() > 0) {

            updateMailContent(request);
        } else {

            Integer userId = (Integer) session.getAttribute("userid_curr");
            String type = request.getParameter("typeSelector");
            String subject = request.getParameter("subject");
            String content = request.getParameter("content");
            SendSms sendsms = new SendSms();
            sendsms.setId(0);
            sendsms.setAddedBy(userId);
            sendsms.setDescription(content);
            sendsms.setSubject(subject);
            sendsms.setType(type);
            ModelDAO.addMailContent(DAOConstants.Entity_SEND_SMS, sendsms);
            message = "Mail Details Added Successfully.";
        }

    }

    public List<SendSms> allMails() {
        List<SendSms> sendsmslist = new ArrayList<SendSms>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("SendSms.findAll");

            sendsmslist = (List<SendSms>) query.list();

        } catch (Exception e) {
            logger.error("allMails" + e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return sendsmslist;
    }

    public void getMailsmsDetails(HttpServletRequest request) {
        String type = request.getParameter("type");
        Session session = null;
        sendSmslist.clear();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("SendSms.findByType");
            query.setParameter("type", type);
            List<SendSms> sendsms = (List<SendSms>) query.list();
            for (SendSms sms : sendsms) {
                sendSmslist.put(sms.getId(), sms.getSubject() + "&&&%%%" + html2text(sms.getDescription()));
            }

        } catch (Exception e) {
            logger.error("getMailsmsDetails" + e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }

    }

    public void getMailsmsDetailsById(HttpServletRequest request) {

        int id = Integer.parseInt(request.getParameter("id"));
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("SendSms.findById");
            query.setParameter("id", id);
            SendSms sendsms = (SendSms) query.uniqueResult();

            sendsmsdetails = sendsms.getType() + "&&&&" + sendsms.getSubject() + "%%%%$$$$" + sendsms.getDescription();
        } catch (Exception e) {
            logger.error("getMailsmsDetails" + e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }

    }

    public void updateMailContent(HttpServletRequest request) {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userid_curr");
        String type = request.getParameter("typeSelector");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
        int smdid = Integer.parseInt(request.getParameter("smsid"));
        SendSms sendsms = new SendSms();
        sendsms.setId(smdid);
        sendsms.setAddedBy(userId);
        sendsms.setDescription(content);
        sendsms.setSubject(subject);
        sendsms.setType(type);
        ModelDAO.Update(DAOConstants.Entity_SEND_SMS, sendsms);
        message = "Mail Details Updated Successfully.";

    }

    public String deleteMailContent(HttpServletRequest request) {
        int smdid = Integer.parseInt(request.getParameter("id"));
        SendSms sendsms = new SendSms();
        sendsms.setId(smdid);
        ModelDAO.delete(DAOConstants.Entity_SEND_SMS, sendsms);
        message = "Mail Details Deleted Successfully.";
        return message;
    }

    public void sendMailContentToUsers(HttpServletRequest request) throws Exception {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        boolean sendMailStatus = false;
        String sql = "";
        Integer userId = (Integer) request.getSession().getAttribute("userid_curr");
        MailCampaignController mcc = new MailCampaignController();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        String date = sdf.format(new Date());
        int count = mcc.CountOfMailBydate(date);
        try {
            if (request.getMethod().equalsIgnoreCase("post")) {
                String mail = (String) request.getSession().getAttribute("theName");
                if (mail == null) {
                    mail = "support";
                }
                String selecetdusers[] = request.getParameterValues("send");
                StringBuilder strBuilder = new StringBuilder();
                for (int i = 0; i < selecetdusers.length; i++) {
                    strBuilder.append(selecetdusers[i] + ",");
                }
                String selectedUsers = strBuilder.toString();
                String msgContent = request.getParameter("dynradio");
                String sendstatus = request.getParameter("sms");
                String type = request.getParameter("typeSelector");

                List<specifiedAllUsers> userslist = new ArrayList<specifiedAllUsers>();

                if (type.equalsIgnoreCase("Account")) {
                    sql = "SELECT distinct(a.ACCOUNTID) as id,l.title as title,l.firstname||' '||l.lastname as name,l.company,l.phone as phone,l.email as email,to_char(l.mobile),a.roleId,'Account' as type from ACCOUNT a,lead l,opportunity o where a.roleid<3 and a.OPPORTUNITY_REFERENCE =o.OPPORTUNITYid and o.LEAD_REFERENCE = l.leadid and a.ACCOUNTID in (" + selectedUsers.substring(0, selectedUsers.length() - 1) + ")";
                } else if (type.equalsIgnoreCase("Contact")) {
                    sql = "select distinct(a.CONTACTID) as id,a.title as title,a.firstname||' '||a.lastname as name,a.company,a.phone as phone,a.email as email,to_char(a.mobile),a.roleId,'Contact' as type from CONTACT a where a.roleid<3 and a.CONTACTID in (" + selectedUsers.substring(0, selectedUsers.length() - 1) + ")";
                } else if (type.equalsIgnoreCase("Lead")) {
                    sql = " select distinct(a.LEADID) as id,a.title as title,a.firstname||' '||a.lastname as name,a.company,a.phone as phone,a.email as email,to_char(a.mobile),a.roleId,'Lead' as type from lead a where a.roleid<3 and a.LEADID in (" + selectedUsers.substring(0, selectedUsers.length() - 1) + ")";
                } else if (type.equalsIgnoreCase("Opportunity")) {
                    sql = "SELECT distinct(a.OPPORTUNITYID) as id ,l.title as title,l.firstname||' '||l.lastname as name,l.company,l.phone as phone,l.email as email,to_char(l.mobile),a.roleId,'Opportunity' as type from opportunity a,LEAD l where a.LEAD_REFERENCE=l.leadid and a.roleid<3 and a.OPPORTUNITYID in (" + selectedUsers.substring(0, selectedUsers.length() - 1) + ")";
                }
                connection = MakeConnection.getConnection();
                statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                resultset = statement.executeQuery(sql);
                while (resultset.next()) {
                    specifiedAllUsers su = new specifiedAllUsers();
                    su.setUserid(resultset.getInt(1));
                    su.setName(resultset.getString(3));
                    su.setCompany(resultset.getString(4));
                    su.setPhone(resultset.getString(5));
                    su.setEmail(resultset.getString(6));
                    su.setMobile(resultset.getString(7));
                    userslist.add(su);
                }
                remainContacts.clear();
                mailnotSent.clear();
                if (sendstatus.equalsIgnoreCase("mail")) {
                    SendSms smsmail = getMailsmsDetails(Integer.parseInt(msgContent));
                    for (specifiedAllUsers su : userslist) {
                        if (count <= 1500) {
                            sendMailStatus = SendMail.sendGSTMail(su.getEmail(), smsmail.getSubject(), smsmail.getDescription(), mail, count);
                            addToMailcampaign(sdf.parse(date), su.getEmail(), sendMailStatus, userId, smsmail.getSubject());
                        } else if (count > 1500) {
                            remainContacts.add(su.getEmail());
                        }
                        count++;
                    }
                    if (mailnotSent.size() == 0 && count <= 1500) {
                        message = "Mail has been sent successfully.";
                    } else if (mailnotSent.size() > 0 && count <= 1500) {
                        message = "Mail Not Sent";
                    } else if (mailnotSent.size() > 0 && count > 1500) {
                        message = "Mail Not Sent,Mail Sent Limit Crossed";
                    } else if (mailnotSent.size() == 0 && count > 1500) {
                        message = "Mail Sent Limit Crossed";
                    }
                } else if (sendstatus.equalsIgnoreCase("sms")) {
                    String subject = request.getParameter("smssubject");
                    for (specifiedAllUsers su : userslist) {
                        if (su.getMobile() != null && su.getMobile().length() >= 10) {
                            SendSmsToMobile.sendSMS(subject, su.getMobile());
                        }
                    }
                    message = "SMS has been sent successfully.";
                }
            }

        } catch (Exception e) {
            message = "Something went wrong.Please try again";
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

    }

    public SendSms getMailsmsDetails(int mailID) {
        SendSms sendsms = new SendSms();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("SendSms.findById");
            query.setParameter("id", mailID);
            sendsms = (SendSms) query.uniqueResult();

        } catch (Exception e) {
            logger.error("getMailsmsDetails" + e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return sendsms;
    }

    public List<specifiedAllUsers> getAllSpecificUsers(String type, String headerSortUp, String headerSortDown) throws Exception {
        List<specifiedAllUsers> usersList = new ArrayList<specifiedAllUsers>();
        Connection connection = null;
        Statement statement = null;
        CallableStatement callableStatement = null;
        ResultSet rs = null;
        String sql = "";
        try {
            connection = MakeConnection.getConnection();
            if (type.length() > 0 && headerSortUp.length() == 0 && headerSortDown.length() == 0) {
                if (type.equalsIgnoreCase("Account")) {
                    sql = "SELECT distinct(a.ACCOUNTID) as id,l.title as title,l.firstname||' '||l.lastname as name,l.company,l.phone as phone,l.email as email,to_char(l.mobile),a.roleId,'Account' as type from ACCOUNT a,lead l,opportunity o where a.roleid<3 and a.OPPORTUNITY_REFERENCE =o.OPPORTUNITYid and o.LEAD_REFERENCE = l.leadid ";
                } else if (type.equalsIgnoreCase("Contact")) {
                    sql = "select distinct(a.CONTACTID) as id,a.title as title,a.firstname||' '||a.lastname as name,a.company,a.phone as phone,a.email as email,to_char(a.mobile),a.roleId,'Contact' as type from CONTACT a where a.roleid<3";
                } else if (type.equalsIgnoreCase("Lead")) {
                    sql = " select distinct(a.LEADID) as id,a.title as title,a.firstname||' '||a.lastname as name,a.company,a.phone as phone,a.email as email,to_char(a.mobile),a.roleId,'Lead' as type from lead a where a.roleid<3  ";
                } else if (type.equalsIgnoreCase("Opportunity")) {
                    sql = "SELECT distinct(a.OPPORTUNITYID) as id ,l.title as title,l.firstname||' '||l.lastname as name,l.company,l.phone as phone,l.email as email,to_char(l.mobile),a.roleId,'Opportunity' as type from opportunity a,LEAD l where a.LEAD_REFERENCE=l.leadid and a.roleid<3 ";
                }

                statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                rs = statement.executeQuery(sql);

            } else if (type.length() == 0 && headerSortUp.length() > 0) {
                sql = "{call PROC_getAllSpecificTeamUserss(?)}";
                callableStatement = connection.prepareCall(sql);
                callableStatement.registerOutParameter(1, OracleTypes.CURSOR);
                callableStatement.executeUpdate();
                rs = (ResultSet) callableStatement.getObject(1);
            } else if (type.length() == 0 && headerSortDown.length() > 0) {
                sql = "{call PROC_getAllSpecificTeamUsersss(?)}";
                callableStatement = connection.prepareCall(sql);
                callableStatement.registerOutParameter(1, OracleTypes.CURSOR);
                callableStatement.executeUpdate();
                rs = (ResultSet) callableStatement.getObject(1);
            }
            usersList.clear();
            while (rs.next()) {
                specifiedAllUsers u = new specifiedAllUsers();

                u.setUserid(Integer.parseInt(rs.getString(1)));
                u.setTitle(rs.getString(2));
                u.setName(rs.getString(3));
                u.setCompany(rs.getString(4));
                u.setPhone(rs.getString(5));
                u.setEmail(rs.getString(6));
                u.setMobile(rs.getString(7));
                if (Integer.parseInt(rs.getString(8)) == 0) {
                    u.setRoleName("Yet To Approve");
                } else if (Integer.parseInt(rs.getString(8)) == 2) {
                    u.setRoleName("Approved");
                } else if (Integer.parseInt(rs.getString(8)) == -1) {
                    u.setRoleName("Denied");
                } else if (Integer.parseInt(rs.getString(8)) == -2) {
                    u.setRoleName("Disabled");
                }

                u.setTeam(rs.getString(9));
                usersList.add(u);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (callableStatement != null) {
                    callableStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return usersList;
    }

    public void attachUpload(HttpServletRequest request, HttpServletResponse response, ServletContext context) throws Exception {
//        String assignedTo = findUserIdByMail("rprakash@eminentlabs.net");
        MailCampaignController mcc = new MailCampaignController();
        ContactController cc = new ContactController();
        FileItem fileItem = null;
        List<FileItem> fileItemAttach = new ArrayList<FileItem>();
        FileItem fileExcel = null;
        String subject = "", content = "";
        List<Contact> contactList = new ArrayList<Contact>();
        boolean sendMailStatus = false;
        String excelreadStatus = "";
        Integer userId = (Integer) request.getSession().getAttribute("userid_curr");

        String existedMail = "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        try {

            String date = sdf.format(new Date());

            int count = mcc.CountOfMailBydate(date);
            if (count <= 1500) {
                if (request.getMethod().equalsIgnoreCase("post")) {
                    if (ServletFileUpload.isMultipartContent(request)) {
                        String mail = (String) request.getSession().getAttribute("theName");
                        if (mail == null) {
                            mail = "support";
                        }
                        ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                        List fileItemsList = servletFileUpload.parseRequest(request);
                        String filePath = request.getSession().getServletContext().getInitParameter("upload-doc");
                        Iterator it = fileItemsList.iterator();
                        while (it.hasNext()) {
                            FileItem fileItemTemp = (FileItem) it.next();
                            if (fileItemTemp.isFormField()) //your code for getting form fields
                            {
                                String name = fileItemTemp.getFieldName();
                                if (name.equalsIgnoreCase("subject")) {
                                    subject = fileItemTemp.getString().trim();
                                }
                                if (name.equalsIgnoreCase("content")) {
                                    content = fileItemTemp.getString().trim();
                                }
                            } else {
                                fileItem = fileItemTemp;
                                String fieldName = fileItem.getFieldName();
                                if (fieldName.equalsIgnoreCase("excelupload")) {
                                    fileExcel = fileItem;
                                }

                                if (fieldName.equalsIgnoreCase("docattach[]")) {
                                    fileItemAttach.add(fileItem);
                                }
                            }
                        }
                        if (fileExcel == null) {
                        } else {
                            if (fileExcel.getSize() > 0 & fileExcel.getSize() < 12582912) {
                                InputStream is = fileExcel.getInputStream();
                                Map<String, List> map = new HashMap<String, List>();
                                String ext = FilenameUtils.getExtension(fileExcel.getName());
                                if (ext.equalsIgnoreCase("xls")) {
                                    map = ReadExcel.readingXls(is);
                                } else if (ext.equalsIgnoreCase("xlsx")) {
                                    map = ReadExcel.readingXlsx(is);
                                }
                                if (map.containsKey("success")) {
                                    excelreadStatus = "success";
                                    List sheetData = map.get("success");

                                    for (int i = 1; i < sheetData.size(); i++) {
                                        List list = (List) sheetData.get(i);
                                        Contact contact = new Contact();
                                        contact.setTitle((String) list.get(0));
                                        contact.setFirstname((String) list.get(1));
                                        contact.setLastname((String) list.get(2));
                                        contact.setPhone((String) list.get(3));
                                        contact.setEmail((String) list.get(4));
                                        contact.setMobile((String) list.get(5));
                                        contact.setCompany((String) list.get(6));
                                        contact.setDuedate(sdf.format((Date) list.get(7)));
                                        contact.setErp((String) list.get(8));
                                        contact.setVendor((String) list.get(9));
                                        contact.setMailingstreet((String) list.get(10));
                                        contact.setMailingcity((String) list.get(11));
                                        contact.setMailingstate((String) list.get(12));
                                        contact.setMailingzip((String) list.get(13));
                                        contact.setAccount("Eminentlabs");
                                        contact.setOwner(userId);
                                        contact.setAssignedto(userId+"");
                                        contactList.add(contact);
                                    }
                                    remainContacts.clear();
                                    mailnotSent.clear();
                                    if (fileItemAttach.size() == 1 && "".equals(fileItemAttach.get(0).getName())) {
                                        for (Contact email : contactList) {
                                            if (count <= 1500) {
                                                sendMailStatus = SendMail.sendGSTMail(email.getEmail(), subject, content, mail, count);
                                                addToMailcampaign(sdf.parse(date), email.getEmail(), sendMailStatus, userId, subject);
                                                if (sendMailStatus) {
                                                    existedMail = cc.addToDBContacts(email);
                                                    if (!"".equals(existedMail)) {
                                                        existed.add(existedMail);
                                                        existedMail = "";
                                                    }
                                                }

                                            } else if (count > 1500) {
                                                remainContacts.add(email.getEmail());
                                            }
                                            count++;
                                        }
                                    } else {
                                        List<String> fileNameAttaches = new ArrayList<String>();
                                        for (FileItem fa : fileItemAttach) {
                                            String fileNameAttach = fa.getName();
                                            fileNameAttach = FilenameUtils.getName(fileNameAttach);
                                            File saveTo = new File(filePath + fileNameAttach);
                                            Boolean bool = saveTo.exists();
                                            if (bool == true) {
                                                saveTo.delete();
                                            }
                                            fa.write(saveTo);
                                            fileNameAttaches.add(filePath + fileNameAttach);
                                        }
                                        for (Contact email : contactList) {
                                            if (count <= 1500) {
                                                sendMailStatus = SendMail.sendGSTMailwithAttachment(email.getEmail(), subject, content, fileNameAttaches, mail, count);
                                                addToMailcampaign(sdf.parse(date), email.getEmail(), sendMailStatus, userId, subject);

                                                if (sendMailStatus) {
                                                    existedMail = cc.addToDBContacts(email);
                                                    if (!"".equals(existedMail)) {
                                                        existed.add(existedMail);
                                                        existedMail = "";
                                                    }
                                                }

                                            } else if (count > 1500) {
                                                remainContacts.add(email.getEmail());
                                            }
                                            count++;
                                        }

                                    }

                                    if (existed.size() > 0 && mailnotSent.size() == 0 && count < 1500) {
                                        message = "Already Existing Contacts are";
                                    } else if (existed.size() == 0 && mailnotSent.size() > 0 && count < 1500) {
                                        message = "Mail Not sent";
                                    } else if (existed.size() > 0 && mailnotSent.size() > 0 && count < 1500) {
                                        message = "Already Existing Contacts are,Mail Not sent";
                                    } else if (existed.size() == 0 && mailnotSent.size() == 0 && count < 1500) {
                                        message = "Mail has been sent successfully.";
                                    } else if (existed.size() > 0 && mailnotSent.size() == 0 && count > 1500) {
                                        message = "Already Existing Contacts are,Limit Crossed.";
                                    } else if (existed.size() == 0 && mailnotSent.size() > 0 && count > 1500) {
                                        message = "Mail Not sent,Limit Crossed.";
                                    } else if (existed.size() == 0 && mailnotSent.size() == 0 && count > 1500) {
                                        message = "Limit crossed";
                                    } else if (existed.size() > 0 && mailnotSent.size() > 0 && count > 1500) {
                                        message = "Already Existing Contacts are,Mail Not sent,Limit Crossed.";
                                    }
                                } else {
                                    message = map.keySet().toString();
                                }
                            } else {
                                message = "File size limit is crossed 12 MB.Please try again";

                            }
                        }

                    }

                }
            } else {
                message = "Mail Limit is crossed already,Please try on next day.  ";
            }
        } catch (Exception e) {
            message = "Something went wrong.Please try again" + e.getMessage();
            logger.error(message);
        }

    }

    public String findUserIdByMail(String mail) {
        String userId = "";
        Connection connection = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();
            stmt = connection.createStatement();

            rs = stmt.executeQuery("select userid from users where email='" + mail + "'");

            while (rs.next()) {
                userId = rs.getString("userid");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {

            try {
                if (rs != null) {

                    rs.close();

                }
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                logger.error("findUserIdByMail" + ex.getMessage());
            }
        }
        return userId;
    }

    public void addToMailcampaign(Date date, String mail, boolean sendMailStatus, int userId, String subject) {
        MailCampaign mc = new MailCampaign();
        mc.setCampaignId(0);
        mc.setMaildate(date);
        mc.setMailid(mail);
        if (sendMailStatus) {
            mc.setStatus("Yes");
        } else {
            mc.setStatus("No");
            mailnotSent.add(mail);
        }
        mc.setSentby(userId);
        mc.setSubject(subject);
        ModelDAO.addGSTMailContent(DAOConstants.Entity_MAIL_CAMPAIGN, mc);
    }

    public String html2text(String html) {
        return Jsoup.parse(html).text();
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getSendsmsdetails() {
        return sendsmsdetails;
    }

    public void setSendsmsdetails(String sendsmsdetails) {
        this.sendsmsdetails = sendsmsdetails;
    }

    public LinkedHashMap<Integer, String> getSendSmslist() {
        return sendSmslist;
    }

    public void setSendSmslist(LinkedHashMap<Integer, String> sendSmslist) {
        this.sendSmslist = sendSmslist;
    }

    public List<String> getRemainContacts() {
        return remainContacts;
    }

    public void setRemainContacts(List<String> remainContacts) {
        this.remainContacts = remainContacts;
    }

    public List<String> getExisted() {
        return existed;
    }

    public void setExisted(List<String> existed) {
        this.existed = existed;
    }

    public List<String> getMailnotSent() {
        return mailnotSent;
    }

    public void setMailnotSent(List<String> mailnotSent) {
        this.mailnotSent = mailnotSent;
    }

}
