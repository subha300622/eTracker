package com.eminent.examples;

import org.apache.log4j.Logger;

import com.pack.MyAuthenticator;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author ttamilvelan
 */
public class SendMail {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(SendMail.class);
    
    /** Creates a new instance of SendMail */
    public static void main(String args[]) throws Exception {
    	String host = "smtp.office365.com";
  		Properties prop=System.getProperties();
		prop.put("mail.smtp.host",host);
		prop.put("mail.smtp.auth", "true");
                prop.put("mail.smtp.port", 587);
                prop.put("mail.debug", "true");
		prop.put("mail.smtp.starttls.enable", "true");
							
		long startTime  =   System.currentTimeMillis();
		Authenticator auth = new MyAuthenticator();
               
		Session ses1=Session.getInstance(prop,auth);
		MimeMessage msg=new MimeMessage(ses1);


        String endLine="</table><br>Thanks,";
        String signature="<br>eTracker&trade;<br>";
        String emi      =   "<br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
        String lineBreak =  "<br>";
        String htmlContent =   "<table><tr><td>Hi,</td></tr><tr> Tamilvelan has registered in the eTracker&trade; . Please log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a> to approve or deny.</tr>";
        htmlContent = htmlContent+endLine+signature+lineBreak+emi;
        int i=0;
 //       while(i<10){
		msg.setFrom(new InternetAddress("yil.erp@yukenindia.com","Eminentlabs™ eTracker™"));
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
//		msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));
		msg.setSubject("eTracker™ Issue Updated ");
		msg.setContent(htmlContent,"text/html");
        Transport.send(msg);
         long endTime  =   System.currentTimeMillis();
                long time   =   (endTime-startTime)/1000;
        logger.info("Send Completed");
        i++;
 //       }
    }
    
}

