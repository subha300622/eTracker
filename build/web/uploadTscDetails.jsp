<%-- 
    Document   : uploadTsc
    Created on : Apr 10, 2014, 11:55:42 AM
    Author     : E0288
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="org.apache.commons.fileupload.*,org.apache.log4j.*, org.apache.commons.fileupload.servlet.ServletFileUpload, org.apache.commons.fileupload.disk.DiskFileItemFactory, org.apache.commons.io.FilenameUtils, java.util.*, java.io.File, java.lang.Exception,com.pack.StringUtil"%>
<%@ page import="java.io.*,pack.eminent.encryption.*,com.eminent.examples.UploadTest,com.eminent.examples.ReadExcel,com.eminent.bpm.BpmUtil"%>

<%
    Logger logger = Logger.getLogger("Upload Tsc Details");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <script language="JavaScript">
            <%
                String pid = (String) session.getAttribute("testMapPid");
                logger.info(pid);
            %>
            function check()
            {
                if (confirm("Do you want to upload another Test Script"))
                {
                    var attach = 'yes';
                    location = 'uploadTscExcel.jsp?attach=' + attach
                }
                else
                {
                    var attach = 'no';
                    location = 'testMap.jsp?pid=' +<%=pid%>
                }

            }
            function printpost(post)
            {
                pp = window.open('UserProfile/profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
                pp.focus();
            }
        </script>
    </head>
    <body onload="check()">
        <%@ include file="header.jsp"%>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgColor="#C3D9FF">
                <td bgcolor="#C3D9FF" border="1" align="left" width="100%"><font
                        size="4" COLOR="#0000FF"><b>Upload BPM Excel </b></font></td>
            </tr>
        </table>
        <br>

        <%

            String saveFile = null;

            Integer userid_curr = (Integer) session.getAttribute("userid_curr");
            int userId = userid_curr.intValue();
            String tstId = (String) session.getAttribute("uploadtsid");
            logger.info("teststepid" + tstId);
            int tsId = Integer.parseInt(tstId);
            try {

                if (ServletFileUpload.isMultipartContent(request)) {
                    ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                    List fileItemsList = servletFileUpload.parseRequest(request);

                    String optionalFileName = "", feedback = "";

                    FileItem fileItem = null;

                    Iterator it = fileItemsList.iterator();
                    while (it.hasNext()) {
                        FileItem fileItemTemp = (FileItem) it.next();
                        if (fileItemTemp.isFormField()) {
        %> <!--
        <b>Name-value Pair Info:</b><br/>
        Field name: <%= fileItemTemp.getFieldName()%><br/>
        Field value: <%= fileItemTemp.getString()%><br/><br/>
        --> <%
                    if (fileItemTemp.getFieldName().equals("filename")) {
                        optionalFileName = fileItemTemp.getString();
                    }
                } else
                    fileItem = fileItemTemp;
            }

            if (fileItem != null) {
                String fileName = fileItem.getName();

                /* Save the uploaded file if its size is greater than 0. */
                if (fileItem.getSize() > 0 & fileItem.getSize() < 6291460) {

                    try {
                        String location = fileItem.getName();
                        InputStream is = fileItem.getInputStream();
                        String ext = FilenameUtils.getExtension(fileItem.getName());
                       logger.info("fileItem.Type()--->Yes" + ext);
                        if (ext.equalsIgnoreCase("xls")) {

                            feedback = BpmUtil.readTsExcel(is, userId, tsId, pid);
                        } else if (ext.equalsIgnoreCase("xlsx")) {
                            logger.info("fileItem.Type()--->Yes" + ext);
                            feedback = BpmUtil.readTsXlsx(is, userId, tsId, pid);
                        }
                        if (feedback.equalsIgnoreCase("Success")) {
        %> 
        <b>Uploaded File Info:</b><br />
        Content type: <%= fileItem.getContentType()%><br />
        <!--              Field name: <%= fileItem.getFieldName()%><br/>    -->
        File name: <%= fileName%><br />
        File size: <%= fileItem.getSize()%><br />
        <br />

        <%
        } else {
        %> 
        <b>Uploaded File Status:</b><br />
        Content type: <%= fileItem.getContentType()%><br />
        File name: <%= fileName%><br />
        File size: <%= fileItem.getSize()%><br />
        <b><font color="red"><%=feedback%></font></b>
        <br />

        <%
            }

        } catch (Exception e) {
        %> <b><font color="red">An error occurred
                when we tried to save the uploaded file.</font></b> <%
                        logger.error(e.getMessage());
                    }
                } else if (fileItem.getSize() == 0) {
                %>
        <b><font color="red">
                The size of the file you were trying to upload is 0. Please upload file with content</font></b>
                <%                         } else {
                %>
        <b><font color="red">
                The file you were trying to upload exceeds 12MB.Please upload file less than 12MB</font></b>
                <%                                         }
                            }
                        }







                    } catch (Exception ex) {
                       logger.error(ex.getMessage());
                    }
                %>
    </body>
</html>
