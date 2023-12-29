/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.formbean.FileAttachBean;
import com.eminent.util.IssueDetails;
import com.eminent.util.StatusSelector;
import com.pack.StringUtil;
import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;

/**
 *
 * @author Muthu
 */
public class AttachFileController {

    FileAttachDAO fileAttachDAO = new FileAttachDAO();
    static Logger logger = null;

    static {
        logger = Logger.getLogger("AttachFileController");
    }

    private String message;
    List<String> fileList=null;
    public List<FileAttachBean> getFilesByIssueId(HttpServletRequest request) {

        List<FileAttachBean> attachedFiles = new ArrayList<FileAttachBean>();
        String issueId = request.getParameter("issueId");
        try {
            if (issueId != null) {
                attachedFiles = fileAttachDAO.getFilesForIssue(issueId);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return attachedFiles;
    }

    public void setAll(HttpServletRequest request, ServletContext context) {
        String saveFile = null;
        try {

            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);

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
                        if (name.equalsIgnoreCase("issueId")) {
                            issueId = fileItemTemp.getString();
                        }
                    } else {
                        fileItem = fileItemTemp;
                        if (fileItem != null) {
                            String fileName = fileItem.getName();

                            // trucncate the file name 
                            String[] arr_filename = fileName.split("[.]");
                            String file_ex = arr_filename[ arr_filename.length - 1];
                            if (fileName.length() > 99) {
                                fileName = fileName.substring(0, 99) + "." + file_ex;;
                            }
                            /* Save the uploaded file if its size is greater than 0. */
                            if (fileItem.getSize() > 0 & fileItem.getSize() < 12582912) {

                                if (optionalFileName.trim().equals("")) {
                                    fileName = FilenameUtils.getName(fileName);
                                } else {
                                    fileName = optionalFileName;
                                }
                                logger.info("Dir Name" + dirName);
                                int count = IssueDetails.displayFiles(issueId);
                                count = count + 1;
                                File saveTo = new File(dirName + count + "." + issueId + "_" + StringUtil.convertSpecialCharacters(fileName));
                                saveFile = count + "." + issueId + "_" + StringUtil.convertSpecialCharacters(fileName);
                                logger.info("File Name" + saveFile);
                                try {
                                    fileItem.write(saveTo);
                                    message = "The uploaded file has been saved successfully";

                                    int owner = ((Integer) request.getSession().getAttribute("uid")).intValue();
                                    int fileId = fileAttachDAO.getFilesIdIssue();
                                    String status = null;
                                    if (issueId.startsWith("E")) {
                                        status = StatusSelector.getStatus(issueId);
                                    } else if (issueId.startsWith("R")) {
                                        status = StatusSelector.getResourceRequestStatus(issueId);
                                    } else {
                                        status = StatusSelector.getStatus(issueId);
                                    }
                                    fileAttachDAO.saveFilesForIssue(fileId, issueId, saveFile, owner, status);
                                } catch (Exception e) {
                                    message = "An Error Occured";
                                    logger.error(e.getMessage());
                                }
                            } else if (fileItem.getSize() == 0) {
                                message = "An Error Occured";
                            } else {
                                message = "The file you were trying to upload exceeds 12MB.Please upload file less than 12MB.";
                            }
                        }
                    }

                }
            }
        } catch (Exception e1) {
            logger.error(e1.getMessage());
        }
    }

    public String setAllForSingle(HttpServletRequest request, ServletContext context) {
        String saveFile = null, issueId = null, url = null;
        try {
            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);

                String filePath = context.getInitParameter("file-upload");
                String dirName = filePath;
                String optionalFileName = "";

                FileItem fileItem = null;

                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) //your code for getting form fields
                    {
                        String name = fileItemTemp.getFieldName();
                        if (name.equalsIgnoreCase("issueId")) {
                            issueId = fileItemTemp.getString();
                        }
                        if (name.equalsIgnoreCase("url")) {
                            url = fileItemTemp.getString();
                        }
                    } else {
                        fileItem = fileItemTemp;
                    }
                }
                if (fileItem != null) {
                    String fileName = fileItem.getName();
                    String[] arr_filename = fileName.split("[.]");
                    String file_ex = arr_filename[ arr_filename.length - 1];
                    if (fileName.length() > 99) {
                        fileName = fileName.substring(0, 99) + "." + file_ex;;
                    }
                    if (fileItem.getSize() > 0 & fileItem.getSize() < 12582912) {
                        System.out.println("fileItem.getSize()  : " + fileItem.getSize());
                        if (optionalFileName.trim().equals("")) {
                            fileName = FilenameUtils.getName(fileName);
                        } else {
                            fileName = optionalFileName;
                        }
                        logger.info("Dir Name" + dirName);
                        int count = IssueDetails.displayFiles(issueId);
                        count = count + 1;
                        File saveTo = new File(dirName + count + "." + issueId + "_" + StringUtil.convertSpecialCharacters(fileName));
                        saveFile = count + "." + issueId + "_" + StringUtil.convertSpecialCharacters(fileName);
                        logger.info("File Name" + saveFile);
                        try {
                            fileItem.write(saveTo);
                            message = "The uploaded file has been saved successfully";
                            int owner = ((Integer) request.getSession().getAttribute("uid")).intValue();
                            int fileId = fileAttachDAO.getFilesIdIssue();
                            String status = null;
                            if (issueId.startsWith("E")) {
                                status = StatusSelector.getStatus(issueId);
                            } else if (issueId.startsWith("R")) {
                                status = StatusSelector.getResourceRequestStatus(issueId);
                            } else {
                                status = StatusSelector.getStatus(issueId);
                            }
                            fileAttachDAO.saveFilesForIssue(fileId, issueId, saveFile, owner, status);
                        } catch (Exception e) {
                            message = "An Error Occured." + e.getMessage();
                            logger.error(e.getMessage());
                        }
                    } else if (fileItem.getSize() == 0) {
                        message = "An Error Occured";
                    } else {
                        message = "The file you were trying to upload exceeds 12MB.Please upload file less than 12MB.";
                    }
                }

            }
        } catch (Exception e1) {
            logger.error(e1.getMessage());
        }
        return url;
    }

    public int getFileCountByIssueId(HttpServletRequest request) {
        int count = 0;
        String issueId = request.getParameter("issueId");
        try {
            if (issueId != null) {
                count = fileAttachDAO.findFileCountForIssue(issueId);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return count;
    }
    
    public void updateImageinComment(HttpServletRequest request, ServletContext context) {
        String saveFile = null;
        fileList = new ArrayList<>();
        try {

            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);

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
                        if (name.equalsIgnoreCase("issueId")) {
                            issueId = fileItemTemp.getString();
                        }
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
                                int count = IssueDetails.displayFiles(issueId);
                                count = count + 1;
                                File saveTo = new File(dirName + count + "." + issueId + "_" + StringUtil.convertSpecialCharacters(fileName));
                                saveFile = count + "." + issueId + "_" + StringUtil.convertSpecialCharacters(fileName);
                                logger.info("File Name" + saveFile);
                                try {
                                    fileItem.write(saveTo);
                                    message = "success";
                                    fileList.add(saveFile);
                                    int owner = ((Integer) request.getSession().getAttribute("uid")).intValue();
                                    int fileId = fileAttachDAO.getFilesIdIssue();
                                    String status = null;
                                    if (issueId.startsWith("E")) {
                                        status = StatusSelector.getStatus(issueId);
                                    } else if (issueId.startsWith("R")) {
                                        status = StatusSelector.getResourceRequestStatus(issueId);
                                    } else {
                                        status = StatusSelector.getStatus(issueId);
                                    }
                                    fileAttachDAO.saveFilesForIssue(fileId, issueId, saveFile, owner, status);
                                } catch (Exception e) {
                                    message = "An Error Occured";
                                    logger.error(e.getMessage());
                                }
                            } else if (fileItem.getSize() == 0) {
                                message = "An Error Occured";
                            } else {
                                message = "The file you were trying to upload exceeds 12MB.Please upload file less than 12MB.";
                            }
                        }
                    }

                }
             
            }
        } catch (Exception e1) {
            logger.error(e1.getMessage());
        }
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<String> getFileList() {
        return fileList;
    }

    public void setFileList(List<String> fileList) {
        this.fileList = fileList;
    }

}
