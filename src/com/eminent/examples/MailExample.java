/*
 * MailExample.java
 *
 * Created on January 16, 2008, 3:56 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.eminent.examples;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class MailExample {
public static void main (String args[]) throws Exception, java.net.UnknownHostException {
String host = "mail.eminentlabs.net";
String from = "admin@eminentlabs.com";
String to = "pgabriel19@gmail.com";
int port=587;

// Get system properties
Properties props = System.getProperties();

// Setup mail server
props.put("mail.smtp.host", host);
props.put("mail.smtp.port", port);
props.put("mail.smtp.auth", "true");

props.put("mail.debug", "true");
props.put("mail.smtp.starttls.enable", "true");

Authenticator auth = new MyAuthenticator();

// Get session
Session session = Session.getInstance(props,auth);

// Define message
MimeMessage message = new MimeMessage(session);

// Set the from address
message.setFrom(new InternetAddress(from));

// Set the to address
message.addRecipient(Message.RecipientType.TO,
new InternetAddress(to));

// Set the subject
message.setSubject("Hello");

// Set the content
message.setText("Welcome");

// Send message
Transport.send(message);
}

static class MyAuthenticator extends Authenticator {
PasswordAuthentication l = new PasswordAuthentication("admin@eminentlabs.com", "eminent123");
protected PasswordAuthentication getPasswordAuthentication() {
return l;
}

}
}