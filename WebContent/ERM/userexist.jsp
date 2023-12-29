<%@page import="pack.eminent.encryption.MakeConnection"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.util.*,javax.mail.*,javax.mail.internet.*,javax.mail.internet.MimeMessage,com.pack.MyAuthenticator,java.sql.*,com.eminent.util.*,org.apache.log4j.*" %>
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs CRM, APM, ERM and PTS Solution</TITLE>
        <META http-equiv=Content-Type content="text/htmlcharset=windows-1252">
        <META http-equiv=Expires content=-1>
        <META http-equiv=Pragma content=no-cache>
        <META http-equiv=Cache-Control content=no-cache>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <META content="MSHTML 6.00.2600.0" name=GENERATOR>
    </HEAD>

    <body>
        <%

            Logger logger = Logger.getLogger("Add Candidate");

            String to = (String) session.getAttribute("existingmail");
            String apids = (String) session.getAttribute("existingapid");
            //int applicantid=apids.intValue();
            logger.info("Applicant Id" + apids);
            logger.info("Existing User" + to);
            try {

               
                String from = "admin@eminentlabs.com";
//Edited by sowjanya
                     MimeMessage msg= MakeConnection.getMailConnections();
                     //Edit end by sowjanya
                msg.setFrom(new InternetAddress(to));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(from));
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(to));
                msg.setSubject("Your Resume is already present in Eminentlabs Resource Management!!!");
                String htmlContent = "<table   bgcolor=#E8EEF7 width=100% ><tr>Your Resume is present in Eminentlabs Resource Manangement.</tr>"
                        + "<tr>Your Applicant id is " + apids + "</tr>"
                        + "<tr>For any further Information Please donot hesistate to contact hr@eminentlabs.net</tr>"
                        + "</table>";
                msg.setContent(htmlContent, "text/html");
                Transport.send(msg);
            } catch (Exception mailexception) {
                logger.error(mailexception.getMessage());
            }
        %>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br> 

        <TABLE bgColor=#E8EEF7 align="center">
            <TBODY>

                <tr>
                    <TD align="center"><B><FONT SIZE="5" COLOR="#FF0000"> Your Profile Already Exist in our database. Please Contact <a href="mailto:hr@eminentlabs.net"><font color="#006699">hr@eminentlabs.net</font></a> with your Applicant ID.</FONT></B></TD>
                </tr>
                <tr>
                    <td colspan="2">
                        <div align="Left">Return to Candidate Registration page <a href="<%=request.getContextPath()%>/ERM/register.jsp">Click
                                Here </a></div>
                    </td>
                </tr>
            </TBODY>
        </TABLE>
        <P></P>
        <P></P>
    </BODY>
</HTML>
