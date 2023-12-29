/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.user.controller;

import com.eminent.util.GetProjectMembers;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Random;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import pack.eminent.encryption.Encryption;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class UserController {

    public String resetPasswordForUser(HttpServletRequest request) {
        String result = "success";
        ResourceBundle rb = ResourceBundle.getBundle("Resources");

        try {
            String userid = request.getParameter("userid");
            String type = request.getParameter("type");
            String manualPassword = request.getParameter("password");
            HashMap<String, String> hm = GetProjectMembers.getUserDetail(Integer.parseInt(userid));
            if (type != null) {
                if (type.equalsIgnoreCase("manual")) {
                    result = updateResetPassword(manualPassword, Integer.parseInt(userid));
                } else {
                    String password = generateNew();
                    String contentHead = "Dear " + hm.get("username") + ",<br/> <br/> <div style='margin-left:4%;clear:both;'>Your eTracker password has been reset to  <b>" + password + "</b></div><br>"
                            + "<u>Change to your own password</u><br>"
                            + "After login, go to profile and then click on change password link"
                            + "<br><br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker";
                    MimeMessage msg = MakeConnection.getMailConnections();
                    msg.setContent(contentHead, "text/html");
                    msg.setSubject("eTracker - Reset Password");
                    msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Admin Eminentlabs"));
                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress(hm.get("email")));
                    String mail = rb.getString("mail");
                    System.out.println(contentHead);
                    if (mail.equalsIgnoreCase("yes")) {
                        Transport.send(msg);
                        result = updateResetPassword(password, Integer.parseInt(userid));
                    } else {
                        result = "Send mail option is disabled. Please check the properties file";
                    }
                }
            }
        } catch (Exception e) {
            result = e.getMessage();
        }
        return result;
    }

    public static String generateNew() {
        StringBuffer sb = new StringBuffer();
        try {
            String onlyNumbers = new String(
                    "1234567890");
            String onlyAlpha = new String(
                    "GHIJdefgPQRSTUVWXYZabchijklmnopqABCDEFKLMNOrstuvwxyz");
            String special = new String(
                    "!@#$%&*");
            Random r = new Random();
            int te = 0;
            for (int i = 1; i <= 10; i++) {

                if (i > 0 && i < 5) {
                    te = r.nextInt(52);
                    sb.append(onlyAlpha.charAt(te));
                } else if (i > 5 && i < 9) {
                    te = r.nextInt(10);
                    sb.append(onlyNumbers.charAt(te));
                } else {
                    te = r.nextInt(7);
                    sb.append(special.charAt(te));
                }
            }
        } catch (Exception ex) {
            sb = new StringBuffer("P@ssw0rd");
        }
        String newPassword = sb.toString();
        return newPassword;
    }

    public String updateResetPassword(String password, int userId) {
        String result = "success";
        Connection connection = null;
        PreparedStatement ps = null, ps1 = null;
        try {
            connection = MakeConnection.getConnection();

            ps1 = connection.prepareStatement("update users set password=? where userid=?");
            ps1.setString(1, Encryption.encrypt(password));
            ps1.setInt(2, userId);
            int x = ps1.executeUpdate();
            if (x > 0) {
                result = "success";
            }
        } catch (Exception e) {
            result = e.getMessage();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (ps1 != null) {
                try {
                    ps1.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result;
    }

}
