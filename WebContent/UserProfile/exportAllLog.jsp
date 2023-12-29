<%-- 
    Document   : exportAllLog
    Created on : 15 Mar, 2016, 6:25:35 PM
    Author     : admin
--%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="org.apache.log4j.Logger"%>
<%@ page trimDirectiveWhitespaces="true" %>
<jsp:useBean id="log" class="pack.eminent.encryption.GetServerLog"></jsp:useBean>

<%

    Logger logger = Logger.getLogger("log");
    ResourceBundle rb = ResourceBundle.getBundle("Resources");

    try {
        String folderpath = rb.getString("LogFilepath");
      String path=  folderpath.substring(0,folderpath.lastIndexOf("\\"));
       File directory = new File(path);
        String[] files = directory.list();

        //check if directories have files
        if (files != null && files.length > 0) {

            //create zip stream
            byte[] zip = log.zipFiles(directory, files,request);

            // Sends the response back to the user / browser with zip content
            ServletOutputStream sos = response.getOutputStream();
            response.setContentType("application/zip");
            response.setHeader("Content-Disposition", "attachment; filename=\"serverlogs.ZIP\"");

            sos.write(zip);
            sos.close();
            sos.flush();
return;
        }
    } catch (Exception e) {
        logger.error(e.getMessage());
    }

%>
