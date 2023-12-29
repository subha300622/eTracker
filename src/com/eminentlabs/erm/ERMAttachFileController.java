/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminent.issue.controller.*;
import com.eminent.issue.formbean.FileAttachBean;
import com.eminent.util.IssueDetails;
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
public class ERMAttachFileController {

    FileAttachDAO fileAttachDAO = new FileAttachDAO();
    static Logger logger = null;

    static {
        logger = Logger.getLogger("AttachFileController");
    }

    private String message;

    public List<FileAttachBean> getFilesByApplicantId(String applicantId) {

        List<FileAttachBean> attachedFiles = new ArrayList<FileAttachBean>();
        try {
            if (applicantId != null) {
                attachedFiles = fileAttachDAO.getFilesForApplicantId(applicantId);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return attachedFiles;
    }

    public String getResumeByApplicantId(String applicantId, String filePath) {
        File resumeDir = new File(filePath);
        String nameOfFile = AssignedApplicants.getFileNamewithExtension(applicantId, resumeDir);
        if (nameOfFile == null) {
            nameOfFile = applicantId + ".doc";
        }
        return nameOfFile;
    }

    public String getPhotoByApplicantId(String applicantId, String filePath) {
        File photoDir = new File(filePath);
        String nameOfPhoto = AssignedApplicants.getFileNamewithExtension(applicantId, photoDir);
        if (nameOfPhoto == null) {
            nameOfPhoto = "avator1.png";
        }
        return nameOfPhoto;
    }

    public void setAll(HttpServletRequest request, ServletContext context) {
        String saveFile = null;
        try {

            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);

                String filePath = context.getInitParameter("upload-user-doc");
                String dirName = filePath;
                String optionalFileName = "", applicantId = "";

                FileItem fileItem = null;
                int owner = ((Integer) request.getSession().getAttribute("uid")).intValue();

                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) //your code for getting form fields
                    {
                        String name = fileItemTemp.getFieldName();
                        if (name.equalsIgnoreCase("applicantId")) {
                            applicantId = fileItemTemp.getString();
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
                                int count = fileAttachDAO.findFileCountForApplicantId(applicantId);
                                count = count + 1;
                                File saveTo = new File(dirName + count + "." + applicantId + "_" + StringUtil.convertSpecialCharacters(fileName));
                                saveFile = count + "." + applicantId + "_" + StringUtil.convertSpecialCharacters(fileName);
                                logger.info("File Name" + saveFile);
                                try {
                                    fileItem.write(saveTo);
                                    fileAttachDAO.saveFilesForIssue(applicantId, saveFile, owner);
                                    message = "The uploaded file has been saved successfully";

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
        String saveFile = null, applicantId = null, url = null;
        try {
            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);

                String filePath = context.getInitParameter("upload-user-doc");
                String dirName = filePath;
                String optionalFileName = "";

                FileItem fileItem = null;

                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) //your code for getting form fields
                    {
                        String name = fileItemTemp.getFieldName();
                        if (name.equalsIgnoreCase("applicantId")) {
                            applicantId = fileItemTemp.getString();
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
                    if (fileItem.getSize() > 0 & fileItem.getSize() < 12582912) {
                        System.out.println("fileItem.getSize()  : " + fileItem.getSize());
                        if (optionalFileName.trim().equals("")) {
                            fileName = FilenameUtils.getName(fileName);
                        } else {
                            fileName = optionalFileName;
                        }
                        logger.info("Dir Name" + dirName);
                        int count = fileAttachDAO.findFileCountForApplicantId(applicantId);
                        count = count + 1;
                        File saveTo = new File(dirName + count + "." + applicantId + "_" + StringUtil.convertSpecialCharacters(fileName));
                        saveFile = count + "." + applicantId + "_" + StringUtil.convertSpecialCharacters(fileName);
                        logger.info("File Name" + saveFile);
                        try {
                            fileItem.write(saveTo);
                            int owner = ((Integer) request.getSession().getAttribute("uid")).intValue();
                            fileAttachDAO.saveFilesForIssue(applicantId, saveFile, owner);
                            message = "The uploaded file has been saved successfully";

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

    public int getFileCountByApplicantId(String applicantId) {
        int count = 0;
        try {
            if (applicantId != null) {
                count = fileAttachDAO.findFileCountForApplicantId(applicantId);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return count;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
