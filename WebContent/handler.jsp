<%-- 
    Document   : handler
    Created on : 5 Dec, 2014, 1:27:42 PM
    Author     : Tamilvelan
--%>

<%@ page import="com.eminent.tqm.FileAttach,org.apache.commons.fileupload.*,org.apache.log4j.*, org.apache.commons.fileupload.servlet.ServletFileUpload, org.apache.commons.fileupload.disk.DiskFileItemFactory, org.apache.commons.io.FilenameUtils, java.util.*, java.io.File,com.eminent.util.StatusSelector, java.lang.Exception"%>
<%@ page import="java.io.*,com.pack.StringUtil"%>

                        <%

		String saveFile = null;
		
		Logger logger = Logger.getLogger("PTC File Upload");
		
                try {

                if (ServletFileUpload.isMultipartContent(request)) {
                        ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                        List fileItemsList = servletFileUpload.parseRequest(request);
                        ServletContext context = pageContext.getServletContext();
                        String filePath = context.getInitParameter("file-upload");
                        String dirName = filePath;
                        String optionalFileName = "", issueId = "";
                        FileItem fileItem = null;

                        Iterator it = fileItemsList.iterator();
                        while (it.hasNext()) {
                            FileItem fileItemTemp = (FileItem) it.next();
                            if (fileItemTemp.isFormField()) //your code for getting form fields
                            {
                                String name = fileItemTemp.getFieldName();
                                issueId = fileItemTemp.getString();
                                logger.info(" Form Fields" + name + issueId);
                            } else {
                                fileItem = fileItemTemp;
                                    if (fileItem != null) {
                                            String fileName = fileItem.getName();


                                            /* Save the uploaded file if its size is greater than 0. */
                                            if (fileItem.getSize() > 0 & fileItem.getSize() < 12582912) {

                                                if (optionalFileName.trim().equals("")) {
                                                    fileName = FilenameUtils.getName(fileName);
                                                } else {
                                                    fileName = optionalFileName;
                                                }



                                                logger.info("Dir Name" + dirName);
                                                File saveTo = new File(dirName + issueId + "_" + StringUtil.convertSpecialCharacters(fileName));
                                                saveFile = issueId + "_" + StringUtil.convertSpecialCharacters(fileName);
                                                logger.info("File Name" + saveFile);
                                                try {
                                                    fileItem.write(saveTo);
                                                    out.println("The uploaded file has been saved successfully");

                                                    int owner = ((Integer) session.getAttribute("uid")).intValue();
                                                    String status = "0";
                                                    int tceid = 0;
                                                    FileAttach.createFile(issueId, saveFile, owner, status, tceid);

                                                } catch (Exception e) {
                                                    out.println("An Error Occured");
                                                    logger.error(e.getMessage());
                                                }
                                            } else if (fileItem.getSize() == 0) {
                                                out.println("An Error Occured");
                                            } else {
                                                out.println("The file you were trying to upload exceeds 12MB.Please upload file less than 12MB.");

                                            }
                                        }
                            }



                        }
                    }
                } catch (Exception ex) {
                logger.error(ex.getMessage());
                }
%>

