/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack;

import com.eminent.util.UserRegistrationMail;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import java.util.ResourceBundle;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author admin
 */
public class RegisterNewUser {

    RegisterBean register = new RegisterBean();
    Logger logger = Logger.getLogger("RegisterNewUser");
    private static ResourceBundle rb = null;

    static {
        rb = ResourceBundle.getBundle("Resources");
    }

    public String registernewUser(HttpServletRequest request) {
        String res = "";

        if (request.getMethod().equalsIgnoreCase("POST")) {
            Connection connection = null;
            try {
                connection = MakeConnection.getConnection();
                String UserEmail = request.getParameter("userEmail");
                String name = request.getParameter("firstName");
                String lName = request.getParameter("lastName");
                String password = request.getParameter("password");
                String secretQus = request.getParameter("secret");
                String answer = request.getParameter("answer");
                String phone = request.getParameter("phone");
                String phoneone = request.getParameter("phone1");
                String phoneTwo = request.getParameter("phone2");
                String ucompany = request.getParameter("company");

                String Operator = request.getParameter("operator");
                String mobile = request.getParameter("mobile");
                String mobileone = request.getParameter("mobile1");

                logger.info("Registered User Name" + name);
                if (connection != null) {
                    boolean state = register.UserExist(connection, UserEmail);
                    if (state == true) {
                        res = "alreadyusersExits";
                    } else {
                        register.setFirstName(name);
                        register.setLastName(lName);
                        register.setCompany(ucompany);
                        register.setOperator(Operator);
                        register.setPhone(phone);
                        register.setPhone1(phoneone);
                        register.setPhone2(phoneTwo);
                        register.setUserEmail(UserEmail);
                        register.setPassword(password);
                        register.setSecret(secretQus);
                        register.setAnswer(answer);
                        register.setMobile(mobile);
                        register.setMobile1(mobileone);

                        register.createUser(connection, register);
                        IntimatedToEminent(register);
                        res = "create";
                    }

                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            } finally {
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException ex) {
                        logger.error(ex.getMessage());
                    }
                }
            }
        }
        return res;
    }

    public void IntimatedToEminent(RegisterBean registerBean) {

        try {
            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                //Edited by sowjanya
                MimeMessage msg = MakeConnection.getMailConnections();
                //Edit end by sowjanya
                msg.setHeader("Content-Type", "text/plain;charset=UTF-8");
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Eminentlabs eTracker"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(registerBean.getUserEmail()));

                //				msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));
                msg.setSubject("Your eTracker Account Has Been Created Successfully!!");
                String htmlContent = "<table width='100%'><tr><font color=blue >Dear Mr." + registerBean.getFirstName() + ",</font></tr><tr><b><font color=blue >Your eTracker&trade; account has been created successfully. Please wait for Admin to approve your registration</font></tr><tr><font color=blue >Thanks,</font></tr><tr><font color=blue >eTracker&trade;  Team</font></tr></table>";
                msg.setContent(htmlContent, "text/html");

                Transport.send(msg);
                /*Edit by mukesh*/
                String Content = "";
                String endLine = "</table><br>Thanks,";
                String signature = "<br>eTracker&trade;<br>";
                String emi = "<br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                String lineBreak = "<br>";

                Content = "<table><tr><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Hi,</td></tr>"
                        + "<tr><td colspan='4'><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + registerBean.getFirstName() + " has registered in the eTracker&trade;.<td></tr>"
                        + "<br>"
                        + "<tr><td >First Name</td><td>" + registerBean.getFirstName() + "</td>"
                        + "</tr><tr ><td>Last Name</td><td>" + registerBean.getLastName() + "</td></tr>"
                        + "<tr><td>Email</td><td> " + registerBean.getUserEmail() + " </td></tr>"
                        + "<tr><td>Company</td><td> " + registerBean.getCompany() + "</td></tr>"
                        + "<br>"
                        + "<tr><td colspan='3'> Please log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>  to view the user details.<td></tr>";

                Content = Content + endLine + signature + lineBreak + emi;
                UserRegistrationMail.IntimatingAdmin(Content);
            }
        } catch (Exception ex) {
            logger.info("New User registeration mail Exceptio:" + ex.getMessage());
        }

    }

    public RegisterBean getRegister() {
        return register;
    }

    public void setRegister(RegisterBean register) {
        this.register = register;
    }

}
