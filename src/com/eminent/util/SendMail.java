package com.eminent.util;

import com.eminent.issue.dao.IssueDAO;
import com.eminent.issue.dao.IssueDAOImpl;
import com.eminentlabs.wrm.User;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Transport;
import javax.mail.internet.*;
import javax.mail.internet.MimeMessage;
import org.apache.log4j.*;
import pack.eminent.encryption.MakeConnection;

public class SendMail {

    static Logger logger = null;
    private static ResourceBundle rb = null;

    static {
        rb = ResourceBundle.getBundle("Resources");
    }

    static {
        logger = Logger.getLogger("SendMail");

    }

    public static void mailUpdate(String issueid, String subject, String content, String UpdatedBy, String assignedTO) {
        IssueDAO issueDAO = new IssueDAOImpl();
        String mailId = null;
        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {

                ArrayList<String> hm = MailReceiverDetails.getDetails(issueid);

                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setHeader("Content-Type", "text/plain;charset=UTF-8");
                String status = (subject.substring(subject.indexOf(" "), subject.indexOf("I"))).trim();
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", UpdatedBy));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(GetProjectMembers.getMail(assignedTO)));
                if (hm.contains(assignedTO)) {
                    hm.remove((String) assignedTO);
                }
                for (String s : hm) {
                    mailId = GetProjectMembers.getMailForAcvtiveUser(s);
                    if (mailId != null) {
                        msg.addRecipient(Message.RecipientType.CC, new InternetAddress(mailId));
                    }
                }
                // added for SRIPL project
//                HashMap<String, String> pidandstatus = issueDAO.getPIDandStatus(issueid);
//                if (!pidandstatus.isEmpty()) {
//                    if (pidandstatus.get("pid").equals("10144") && pidandstatus.get("status").equalsIgnoreCase("closed")) {
//                        msg.addRecipient(Message.RecipientType.CC, new InternetAddress("g.thantry@schenckprocess.com"));
//                    }
//                }

                msg.setSubject(subject, "UTF-8");
                msg.setContent(content, "text/html");

                Transport.send(msg);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void leaveMailUpdate(String content, int updatedBy, int assignedTO, String sender, String subject) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("Yes")) {
                int hrId = 112;
                MimeMessage msg = MakeConnection.getMailConnections();
                long startTime = System.currentTimeMillis();
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", GetProjectMembers.getUserName(((Integer) updatedBy).toString())));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(GetProjectMembers.getMail(((Integer) updatedBy).toString())));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(GetProjectMembers.getMail(((Integer) hrId).toString())));

                msg.setSubject(subject);
                msg.setContent(content, "text/html");

                Transport.send(msg);
                logger.info("Eminentlabs Leave Approval - Send mail");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void leaveMailTeamUpdate(String content, int UpdatedBy, int assignedTO, String sender, String subject) {

        try {

            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", sender));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("mail2all@eminentlabs.net"));

                msg.setSubject(subject);
                msg.setContent(content, "text/html");

                Transport.send(msg);
                logger.info("Eminentlabs Leave Approval - Send mail");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void reassigningIssue(String content, int receiver, String subject) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                //           receiver    =   112;
                HashMap userDetails = GetProjectMembers.getUserDetail(receiver);
                String sender = (String) userDetails.get("username");
                String email = (String) userDetails.get("email");
                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", sender));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                msg.setSubject(subject);
                msg.setContent(content, "text/html");

                Transport.send(msg);
                logger.info("Reassigning Issues - Send mail");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void testCaseUpdateMail(String content, int assign, int userId, String pId, String planmanager, String subject) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                //                         receiver    =   112;
                HashMap userDetails = GetProjectMembers.getUserDetail(userId);
                String sender = (String) userDetails.get("username");
                String email = (String) userDetails.get("email");

                ArrayList<String> al = new ArrayList<String>();

                al.add(planmanager);

                if (!al.contains(((Integer) assign).toString())) {
                    al.add(((Integer) assign).toString());
                }

                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", sender));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                for (String s : al) {
                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress(GetProjectMembers.getMail(s)));
                    logger.info("Email" + s);
                }
                msg.setSubject(subject);
                msg.setContent(content, "text/html");

                Transport.send(msg);
                logger.info("Test Case - Send mail");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void CRMContacts(String content, String subject, String sender, String assignedTo, String pm, String updatedBy) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", sender));

                ArrayList<String> governers = MailReceiverDetails.getCRMGoverners(assignedTo, pm, updatedBy);
                for (String s : governers) {
                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress(GetProjectMembers.getMail(s)));
                    logger.info("Email" + s);
                }
                msg.setSubject(subject);
                msg.setContent(content, "text/html");

                Transport.send(msg);
                logger.info("CRM Update - Send mail");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void InformExceptions(String content) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Admin Eminentlabs"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
                msg.setSubject("There is an exception occured in eTracker");
                msg.setContent(content, "text/html");

                Transport.send(msg);
                logger.info("Reassigning Issues - Send mail");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void ERMIntimation(String content, String subject) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Admin Eminentlabs"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("tgopal@eminentlabs.net"));
                msg.setSubject(subject);
                msg.setContent(content, "text/html");

                Transport.send(msg);
                logger.info("ERM Intimation - Send mail");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void WRMMail(String content, String subject, String createdBy, String email, List<User> wrmMailIds) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", createdBy));
                if (email == null) {
                } else {
                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                }
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("tgopal@eminentlabs.net"));
                if (!wrmMailIds.isEmpty()) {
                    for (User u : wrmMailIds) {
                        msg.addRecipient(Message.RecipientType.CC, new InternetAddress(u.getEmailId()));
                    }
                }
                msg.setSubject(subject);
                msg.setContent(content, "text/html");
                Transport.send(msg);
                logger.info("WRMMail - Send mail");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void ERMUpdation(String updatedBy, String content, String subject, String assignedEmail, String updatedEmail) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", updatedBy));
                //  msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("tgopal@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(assignedEmail));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(updatedEmail));
                msg.setSubject(subject);
                msg.setContent(content, "text/html");

                Transport.send(msg);
                logger.info("ERM Updation - Send mail");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void MOMMail(String content, String subject) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                MimeMessage msg = MakeConnection.getMailConnections();

                msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Admin Eminentlabs"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("vsrinivasaranganath@eminentlabs.net"));
                msg.setSubject(subject, "UTF-8");
                msg.setContent(content, "text/html");

                Transport.send(msg);
                logger.info("MOM Update - Send mail");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void tceMailUpdate(String issueid, String subject, String content, String UpdatedBy, String assignedTO) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("Yes")) {

                ArrayList<String> hm = MailReceiverDetails.getDetails(issueid);

                MimeMessage msg = MakeConnection.getMailConnections();

                msg.setHeader("Content-Type", "text/plain;charset=UTF-8");
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", UpdatedBy));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(GetProjectMembers.getMail(assignedTO)));
                if (hm.contains(assignedTO)) {
                    hm.remove((String) assignedTO);
                }
                for (String s : hm) {
                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress(GetProjectMembers.getMail(s)));
                    logger.info("Email" + s);
                }

                msg.setSubject(subject, "UTF-8");
                msg.setContent(content, "text/html");
                logger.info("sending tce mail ....");
                Transport.send(msg);
                logger.info("Mail has sent ....");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void testCaseMail(String subject, String content, String UpdatedBy, String assignedTO) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("Yes")) {
                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setHeader("Content-Type", "text/plain;charset=UTF-8");
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", UpdatedBy));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(GetProjectMembers.getMail(assignedTO)));
                msg.setSubject(subject, "UTF-8");
                msg.setContent(content, "text/html");
                logger.info("sending testcase mail ....");
                Transport.send(msg);
                logger.info("Mail has sent ....");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void sendMOMMail(String content, String subject) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("Yes")) {

                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setHeader("Content-Type", "text/plain;charset=UTF-8");

                msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Admin Eminentlabs"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress("vanaja@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress("accounts@eminentlabs.net"));
                msg.setSubject(subject);
                msg.setContent(content, "text/html");

                Transport.send(msg);
                logger.info("Eminentlabs Leave Approval - Send mail");
            }
        } catch (Exception e) {

            logger.error(e.getMessage());
        }

    }

    public static boolean sendGSTMail(String receiver, String subject, String content, String fromMail, int count) {

        boolean sentMailStatus = false;
        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                MimeMessage msg = null;
                if (count >= 0 && count <= 500) {
                    msg = MakeConnection.getSalesMailConnections();
                    msg.setFrom(new InternetAddress("sale@eminentlabs.net"));
                } else if (count > 500 && count <= 1000) {
                    msg = MakeConnection.getGSTMailConnections();
                    msg.setFrom(new InternetAddress("gst@eminentlabs.net"));
                } else if (count > 1000 && count <= 1500) {
                    msg = MakeConnection.getSupportMailConnections();
                    msg.setFrom(new InternetAddress("support@eminentlabs.net"));
                }
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress("rprakash@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress("jsreeja@eminentlabs.net"));

                msg.setSubject(subject);
                msg.setContent(content, "text/html");
                Transport.send(msg);
                sentMailStatus = true;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return sentMailStatus;
    }

    public static boolean sendGSTMailwithAttachment(String receiver, String subject, String content, List<String> filePath, String fromMail, int count) {
        boolean sentMailStatus = false;
        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                Multipart multipart = new MimeMultipart();

                MimeMessage msg = null;

                if (count >= 0 && count <= 500) {
                    msg = MakeConnection.getSalesMailConnections();
                    msg.setFrom(new InternetAddress("sale@eminentlabs.net"));
                } else if (count > 500 && count <= 1000) {
                    msg = MakeConnection.getGSTMailConnections();
                    msg.setFrom(new InternetAddress("gst@eminentlabs.net"));
                } else if (count > 1000 && count <= 1500) {
                    msg = MakeConnection.getSupportMailConnections();
                    msg.setFrom(new InternetAddress("support@eminentlabs.net"));
                }
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress("rprakash@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress("jsreeja@eminentlabs.net"));

                MimeBodyPart messageBodyPart = new MimeBodyPart();
                msg.setSubject(subject);
                messageBodyPart.setContent(content, "text/html");
                multipart.addBodyPart(messageBodyPart);
                for (String filename : filePath) {
                    messageBodyPart = new MimeBodyPart();
                    DataSource source = new FileDataSource(filename);
                    messageBodyPart.setDataHandler(new DataHandler(source));
                    messageBodyPart.setFileName(new File(filename).getName());
                    multipart.addBodyPart(messageBodyPart);

                }
                msg.setContent(multipart);
                Transport.send(msg);
                sentMailStatus = true;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return sentMailStatus;
    }

    public static void escalationMail(String content, String subject, String updatedby, String assignedTO) {
        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", updatedby));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(GetProjectMembers.getMail(assignedTO)));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("psaravanan@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("athuyavan@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("naarayanaa@eminentlabs.net"));
                msg.setSubject(subject);
                msg.setContent(content, "text/html");
                Transport.send(msg);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void mailUpdateNew(String issueid, String subject, String content, String UpdatedBy, String assignedTO, List<String> managers, String thantry) {
        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("Yes")) {
                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setHeader("Content-Type", "text/plain;charset=UTF-8");
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", UpdatedBy));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(GetProjectMembers.getMail(assignedTO)));
                if (managers.contains(assignedTO)) {
                    managers.remove((String) assignedTO);
                }
                for (String s : managers) {
                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress(GetProjectMembers.getMail(s)));
                }
                if (thantry.equalsIgnoreCase("yes")) {
                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress("g.thantry@schenckprocess.com"));
                }

                msg.setSubject(subject, "UTF-8");
                msg.setContent(content, "text/html");

                Transport.send(msg);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void monitoringissueUpdate(String issueid, String subject, String content, String UpdatedBy, String assignedTO) {
        try {
            if (rb.getString("mail").equalsIgnoreCase("yes")) {
                MimeMessage msg = MakeConnection.getMailConnections();
                msg.setHeader("Content-Type", "text/plain;charset=UTF-8");
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", UpdatedBy));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress("basis@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress("ttamilvelan@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress("admin@eminentlabs.net"));
                msg.setSubject(subject, "UTF-8");
                msg.setContent(content, "text/html");
                Transport.send(msg);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }
    

}
