/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.ApmTsAttachment;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.MoMUtil;
import com.pack.StringUtil;
import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author DhanVa CompuTers
 */
public class ApmTestStepAttachmentController {

    Logger logger = Logger.getLogger("ApmTestStepAttachmentController");

    private String message;

    public void setAll(HttpServletRequest request, ServletContext context) {
        String saveFile = null;
        try {
            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);
                String filePath = context.getInitParameter("file-upload");
                String dirName = filePath;
                String optionalFileName = "", tsId = "";
                long testStepId = 0;
                FileItem fileItem = null;
                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) //your code for getting form fields
                    {
                        String name = fileItemTemp.getFieldName();
                        if (name.equalsIgnoreCase("tsid")) {
                            tsId = fileItemTemp.getString();
                        }
                    } else {
                        fileItem = fileItemTemp;
                        if (fileItem != null) {
                            String fileName = fileItem.getName();
                            /* Save the uploaded file if its size is greater than 0. */
                            if (fileItem.getSize() > 0) {

                                if (optionalFileName.trim().equals("")) {
                                    fileName = FilenameUtils.getName(fileName);
                                } else {
                                    fileName = optionalFileName;
                                }
                                testStepId = MoMUtil.parseLong(tsId, 0);
                                int count = displayTSFiles(testStepId);
                                count = count + 1;
                                File saveTo = new File(dirName + count + "." + StringUtil.convertSpecialCharacters(fileName));
                                saveFile = count + "." + StringUtil.convertSpecialCharacters(fileName);
                                try {
                                    fileItem.write(saveTo);
                                    int owner = ((Integer) request.getSession().getAttribute("uid")).intValue();
                                    ApmTsAttachment apmTsAttachment = new ApmTsAttachment();
                                    apmTsAttachment.setFilename(saveFile);
                                    apmTsAttachment.setAttacheddate(new Date());
                                    apmTsAttachment.setTsId(testStepId);
                                    apmTsAttachment.setOwner(owner);
                                    ModelDAO.save("APM_TS_ATTACHMENT", apmTsAttachment);
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

    public List<ApmTsAttachment> viewDocuments(long tscId) {

        Session session = null;
        List<ApmTsAttachment> l = null;
        if (tscId == 0l) {
            l = new ArrayList<ApmTsAttachment>();
        } else {
            try {
                session = HibernateFactory.getCurrentSession();
                Query query = session.getNamedQuery("ApmTsAttachment.findByTsId");
                query.setParameter("tsId", tscId);
                l = query.list();
                if (l == null) {
                    l = new ArrayList<ApmTsAttachment>();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            } finally {
                if (session != null) {
                    if (session.isOpen()) {
                        try {
                            session.close();
                        } catch (Exception e) {
                            logger.error(e.getMessage());
                        }
                    }
                }
            }
        }
        return l;
    }

    public int displayTSFiles(long pId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int files = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select count(*) from APM_TS_ATTACHMENT where TS_ID=" + pId);
            if (resultset.next()) {
                files = resultset.getInt(1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return files;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
