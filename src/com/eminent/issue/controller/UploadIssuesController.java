/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.dao.IssueDAO;
import com.eminent.issue.dao.IssueDAOImpl;
import com.eminent.util.GetProjectMembers;
import com.eminentlabs.mom.controller.MomMaintananceController;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Muthu
 */
public class UploadIssuesController {

    private String status = null;
   
    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    List<String> modList = Arrays.asList(noOfIds);
    MomMaintananceController mmc = new MomMaintananceController();
    List totUsers = new ArrayList();
   String pid;
    public void setAll(HttpServletRequest request, ServletContext context) {
        String method = request.getMethod();
        HttpSession session = request.getSession();
        Integer userid_curr = (Integer) session.getAttribute("userid_curr");
        IssueDAO issueDAO = new IssueDAOImpl();
        if (method.equalsIgnoreCase("post")) {
            try {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);
                FileItem fileItem = null;
                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) //your code for getting form fields
                    {
                        String name = fileItemTemp.getFieldName();
                        if (name.equalsIgnoreCase("pid")) {
                            pid = fileItemTemp.getString().trim();
                            System.out.println("pid : "+pid);
                        }
                    } else {
                        String expenceType = fileItemTemp.getFieldName();
                        if (expenceType.equalsIgnoreCase("files")) {
                            fileItem = fileItemTemp;
                        }
                    }
                }
                if (fileItem != null) {
                    String fileName = fileItem.getName();
                    System.out.println("fileName" + fileName);
                    if (fileItem.getSize() > 0 & fileItem.getSize() < 6291460) {
                        InputStream is = fileItem.getInputStream();
                        String ext = FilenameUtils.getExtension(fileItem.getName());
                        if (ext.equalsIgnoreCase("xls")) {
                            status = issueDAO.readIssuesFromExcel(is, pid, userid_curr);
                        } else if (ext.equalsIgnoreCase("xlsx")) {
                            status = issueDAO.readIssuesFromXlsx(is, pid, userid_curr);
                        }
                    }
                }
            } catch (FileUploadException ex) {
                status = "The source downloaded excel structure seems to be tampered, the upload cannot be processed";
            } catch (IOException ex) {
                status = "The source downloaded excel structure seems to be tampered, the upload cannot be processed";
            }
        }
    }
    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }
     public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
      public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

}
