/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util;

import javax.mail.internet.*;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Authenticator;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;
import java.util.*;
import com.pack.*;
import dashboard.CountIssue;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Tamilvelan
 */
public class UserRegistrationMail {

    static Logger logger = null;
    private static ResourceBundle rb = null;

    static {
        rb = ResourceBundle.getBundle("Resources");
    }

    static {
        logger = Logger.getLogger("UserRegistrationMail");

    }


    /*edit by mukesh*/
    public static void IntimatingAdmin(String content) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                //Edit by sowjanya
                MimeMessage msg= MakeConnection.getMailConnections();
                //edit end by sowjanya
                msg.setHeader("Content-Type", "text/plain;charset=UTF-8");

                msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Eminentlabs™ eTracker™"));
                          msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
//             msg.addRecipient(Message.RecipientType.TO, new InternetAddress("naarayanaa@eminentlabs.net"));
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress("tgopal@eminentlabs.net"));

                msg.setSubject("New User Registered in eTracker™");
                msg.setContent(content, "text/html");
                Transport.send(msg);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    public static void UserApprovedMailval(String userId, String status) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                String Name = GetProjectMembers.getUserName(userId);
                String htmlContent = null;
                //Edited by sowjanya
                MimeMessage msg= MakeConnection.getMailConnections();
                //Edit end by sowjanya
                msg.setHeader("Content-Type", "text/plain;charset=UTF-8");

                String endLine = "</table><br>Thanks,";
                String signature = "<br>eTracker&trade;<br>";
                String emi = "<br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                String lineBreak = "<br>";
                String subject = null;

                if (status.equalsIgnoreCase("Approved")) {
                    htmlContent = "<table><tr><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Hi,</td></tr><tr><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Name + " has been approved by Admin in the eTracker&trade; . Please log on to <a href=http://www.eminentlabs.net/eTracker/login.jsp target=_new>eTracker&trade;</a>  to view the user details.<td></tr>";
                    subject = "New User Approved in eTracker™";

                } else if (status.equalsIgnoreCase("Denied")) {
                    htmlContent = "<table><tr><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Hi,</td></tr><tr><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Name + " has been denied by Admin in the eTracker&trade; . Please log on to <a href=http://www.eminentlabs.net/eTracker/login.jsp target=_new>eTracker&trade;</a>  to view the user details.<td></tr>";
                    subject = "New User Denied in eTracker™";

                } else if (status.equalsIgnoreCase("Disabled")) {
                    int uid = Integer.parseInt(userId);
                    ArrayList<String> al = null;
                    al = CountIssue.getProjectForUser(uid);
                    String[] userdetail = GetProjectMembers.getDisableUserDetail(userId);

                    StringBuilder b = new StringBuilder();
                    int a = al.size();
                    if (a == 1) {
                        for (String projecta : al) {
                            b.append(projecta);
                        }
                    } else {
                        int count = 1;
                        for (String projecta : al) {
                            if (a - 1 >= count) {
                                b.append(projecta).append(" \n ,   ");
                            } else {
                                b.append(projecta);
                            }
                            count++;
                        }
                    }

                    String projectdetail = b.toString();
                    if (projectdetail == null) {
                        projectdetail = "  ";
                    }
                    htmlContent = "<table>"
                            + "<tr><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Hi,</td></tr>"
                            + "<tr><td colspan='4'><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + userdetail[0] + "  has been disabled by Admin in the eTracker&trade;.</td></tr>"
                            + "<br>"
                            + "<tr><td style='width:110px;'>First Name</td><td>" + userdetail[0] + "</td></tr>"
                            + "<tr><td style='width:110px;'>Last Name</td><td>" + userdetail[1] + "</td></tr>"
                            + "<tr><td>Email</td><td>" + userdetail[2] + "</td></tr>"
                            + "<tr><td>Company </td><td>" + userdetail[3] + "</td></tr>"
                            + "<tr><td>Project</td><td>" + projectdetail + "</td><tr>"
                            + "<br>"
                            + "<tr><td colspan='3'> Please log on to <a href=http://www.eminentlabs.net/eTracker/login.jsp target=_new>eTracker&trade;</a>  to view the user details.<td></tr>";
                    subject = "User Disabled in eTracker™";

                } else {
                    htmlContent = "<table><tr><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Hi,</td></tr><tr><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Name + " has been approved by Admin in the eTracker&trade; . Please log on to <a href=http://www.eminentlabs.net/eTracker/login.jsp target=_new>eTracker&trade;</a>  to view the user details.<td></tr>";
                    subject = "New User Approved in eTracker™";
                }

                htmlContent = htmlContent + endLine + signature + lineBreak + emi;

                msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Eminentlabs™ eTracker™"));
                  msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
                 msg.addRecipient(Message.RecipientType.CC, new InternetAddress("tgopal@eminentlabs.net"));

                msg.setSubject(subject);
                msg.setContent(htmlContent, "text/html");
                Transport.send(msg);

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }
    /*edit end by mukesh*/

}
