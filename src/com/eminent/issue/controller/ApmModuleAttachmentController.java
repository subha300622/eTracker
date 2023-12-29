/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.ApmModuleAttachment;
import com.eminent.util.GetProjects;
import com.eminent.util.IssueDetails;
import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.MoMUtil;
import com.pack.StringUtil;
import java.io.File;
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

/**
 *
 * @author EMINENT
 */
public class ApmModuleAttachmentController {

    Logger logger = Logger.getLogger("ApmModuleAttachmentController");

    private String message;

    public void setAll(HttpServletRequest request, ServletContext context) {
        String saveFile = null;
        try {

            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);

                String filePath = context.getInitParameter("file-upload");
                String dirName = filePath;
                String optionalFileName = "", pId = "", moduleId = "";

                FileItem fileItem = null;

                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) //your code for getting form fields
                    {
                        String name = fileItemTemp.getFieldName();
                        if (name.equalsIgnoreCase("pId")) {
                            pId = fileItemTemp.getString();
                        } else if (name.equalsIgnoreCase("moduleId")) {
                            moduleId = fileItemTemp.getString();
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
                                String project = GetProjects.getProjectName(pId);
                                project=project.replace(":", "_");
                                String module = GetProjects.getModuleName(moduleId);
                                 int count=IssueDetails.displayModuleFiles(pId);
                                 count=count+1;
                                File saveTo = new File(dirName +count+"."+project+"_"+ module + "_" + StringUtil.convertSpecialCharacters(fileName));
                                saveFile = count+"."+project+"_"+module + "_" + StringUtil.convertSpecialCharacters(fileName);
                                logger.info("File Name" + saveFile);
                                try {
                                    fileItem.write(saveTo);
                                    message = "The uploaded file has been saved successfully";

                                    int owner = ((Integer) request.getSession().getAttribute("uid")).intValue();
                                    String status = "0";
                                    int tceid = 0;
                                    ApmModuleAttachment apmModuleAttachment = new ApmModuleAttachment();
                                    apmModuleAttachment.setFilename(saveFile);
                                    apmModuleAttachment.setAttacheddate(new Date());
                                    apmModuleAttachment.setModuleid(MoMUtil.parseInteger(moduleId, 0));
                                    apmModuleAttachment.setProjectId(MoMUtil.parseLong(pId, 0));
                                    apmModuleAttachment.setOwner(owner);
                                    ModelDAO.save(DAOConstants.ENTITY_APM_MODULE_ATTACHMENT, apmModuleAttachment);

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

    public List<ApmModuleAttachment> viewDocuments(HttpServletRequest request) {
        String project = request.getParameter("pId");
        long pId = MoMUtil.parseLong(project, 0l);

        Session session = null;
        List<ApmModuleAttachment> l = null;
        if (pId == 0l) {
            l = new ArrayList<ApmModuleAttachment>();
        } else {
            try {

                session = HibernateFactory.getCurrentSession();
                Query query = session.getNamedQuery("ApmModuleAttachment.findByProjectId");
                query.setParameter("projectId", pId);
                l = query.list();
                if (l == null) {
                    l = new ArrayList<ApmModuleAttachment>();
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

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    
}
