<%-- 
    Document   : uploadresume
    Created on : Mar 13, 2012, 10:46:51 AM
    Author     : Tamilvelan
--%>
<%@page import="pack.eminent.encryption.MakeConnection"%>
<%@ page import="java.util.*,javax.mail.*,javax.mail.internet.*,javax.mail.internet.MimeMessage,com.eminent.util.*,java.io.*,java.sql.*,org.apache.log4j.*,com.pack.StringUtil" errorPage="unexpectedNotify.jsp" %>
<%@ page import="org.apache.commons.fileupload.*,org.apache.log4j.*, org.apache.commons.fileupload.servlet.ServletFileUpload, org.apache.commons.fileupload.disk.DiskFileItemFactory, org.apache.commons.io.FilenameUtils, java.util.*, java.io.File,com.eminent.util.StatusSelector, java.lang.Exception"%>
<%@page import="com.pack.MyAuthenticator" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<TITLE>eOutsource &trade;- Eminent Product Development Life Cycle Management</TITLE>
</head>
<body>
<%

        

	Logger logger = Logger.getLogger("Upload Resume");
	
%>
<%

                PreparedStatement ps = null;
                String saveFile=null;
                String apids=(String)session.getAttribute("apid");
                String firstname=(String)session.getAttribute("firstname");
                String date=(String)session.getAttribute("Date");
                logger.info("Session Date"+date);
                logger.info("Session Ap id"+apids);
                logger.info("Session First Name"+firstname);
				


		try{
                if (ServletFileUpload.isMultipartContent(request))
                {
                  ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                  List fileItemsList = servletFileUpload.parseRequest(request);
                  ServletContext context = pageContext.getServletContext();
                  String filePath = context.getInitParameter("upload-resume");
                  String optionalFileName = "";
                  FileItem fileItem = null;

                  Iterator it = fileItemsList.iterator();
                  while (it.hasNext()){
                    FileItem fileItemTemp = (FileItem)it.next();
                    if (fileItemTemp.isFormField()){
                %>
<!--                <b>Name-value Pair Info:</b><br/>
                Field name: <%= fileItemTemp.getFieldName() %><br/>
                Field value: <%= fileItemTemp.getString() %><br/><br/>-->
                <%
                      if (fileItemTemp.getFieldName().equals("filename"))
                        optionalFileName = fileItemTemp.getString();
                    }
                    else
                      fileItem = fileItemTemp;
                  }

                  if (fileItem!=null){
                    String fileName = fileItem.getName();
                %> <b>Uploaded File Info:</b><br />
		Content type: <%= fileItem.getContentType() %><br />
		<!--              Field name: <%= fileItem.getFieldName() %><br/>    -->
		File name: <%= fileName %><br />
		File size: <%= fileItem.getSize() %><br />
		<br />

		<%
                    /* Save the uploaded file if its size is greater than 0. */
                    if (fileItem.getSize() > 0& fileItem.getSize()<12582912)
                    {
                      if (optionalFileName.trim().equals(""))
                        fileName = FilenameUtils.getName(fileName);
                      else
                        fileName = optionalFileName;

                     String contextRootPath = this.getServletContext().getRealPath("/");
                     File outputFile1 = new File(contextRootPath, "/Etracker_AttachedFiles/");
                     boolean dir=outputFile1.mkdir();
 //                     String dirName = contextRootPath+"/Etracker_AttachedFiles/";
                      String dirName    =   filePath;
                      logger.info("Dir Name"+dirName);
                       String fileExtension		=	".doc";
                      File saveTo = new File(dirName +(String)session.getAttribute("apid")+fileExtension);
                      
                      logger.info("File Name"+saveFile);
                      try {
                        fileItem.write(saveTo);
                         String email=(String)session.getAttribute("email");
                               String from = "admin@eminentlabs.com";
                                String to = email;
                                //Edited by sowjanya
			        MimeMessage msg= MakeConnection.getMailConnections();
                                //Edit end by sowjanya
                                msg.setFrom(new InternetAddress(to));
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(from));
				msg.addRecipient(Message.RecipientType.CC, new InternetAddress(to));
				msg.setSubject("Your Resume is Uploaded in Eminentlabs Resource Management!!!");
                                String htmlContent="<table   bgcolor=#E8EEF7 width=100% ><tr><td>Your Resume is Uploaded in Eminentlabs Resource Management Successfully.!!!</td></tr>" +
                                                            "<tr><td>Your Applicant id is "+apids+"</td></tr>" +
                                                            "<tr><td>For any further Information Please donot hesistate to contact hr@eminentlabs.net</td></tr>"+
                                                    "</table>";
                               msg.setContent(htmlContent,"text/html");
                               Transport.send(msg);
                %> 

		<%
                      
                      }
                      catch (Exception e){
                %> <b><font color="red">An error occurred
		when we tried to save the uploaded file.</font></b> <%
                      logger.error(e.getMessage());
                      }
                    } else if(fileItem.getSize() == 0) {
                         %>
                            <b><font color="red">
                                The size of the file you were trying to upload is 0. Please upload file with content</font></b>
                         <%
                    } else {
                         %>
                            <b><font color="red">
                                The file you were trying to upload exceeds 12MB.Please upload file less than 12MB</font></b>
                         <%
                    }
                  }
                }


                           
                 }catch(Exception e){
                     logger.error(e.getMessage());

                  }

%>
                                        <jsp:forward page="closeWindow.jsp">
					<jsp:param  name= "flag" value="true"/>
					</jsp:forward>
