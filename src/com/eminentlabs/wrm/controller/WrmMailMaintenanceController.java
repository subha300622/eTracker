/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.wrm.controller;

import com.eminent.issue.WrmMailMaintenance;
import com.eminent.util.GetProjects;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.wrm.User;
import com.eminentlabs.wrm.WRMMailMaintainDAO;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Muthu
 */
public class WrmMailMaintenanceController {

    private String message = "";
    Map<Long, String> internalUsers = null;
    Map<Long, String> clientUsers = null;
    List<User> wrmMailUsers = null;
    private long pid = 0l;
    private String pname="";

    public void setAll(HttpServletRequest request) {

        pid = Long.parseLong(request.getParameter("pid"));
        if (request.getMethod().equalsIgnoreCase("post")) {
            String userIds[] = request.getParameterValues("userIds");
            if (userIds!=null) {
                for (String user : userIds) {
                    if (pid != 0l) {
                        WrmMailMaintenance wmm = new WrmMailMaintenance(pid, Long.parseLong(user));
                        ModelDAO.save("WrmMailMaintenance", wmm);
                    }
                }
                message = "WRM Mail User has been added";
            }
        }

        if (pid != 0l) {
            internalUsers = new HashMap<>();
            clientUsers = new HashMap<>();
            pname = GetProjects.getProjectName(request.getParameter("pid"));
            wrmMailUsers = WRMMailMaintainDAO.getWRMMailUserByPid(pid);
            List<User> users = WRMMailMaintainDAO.getUsersByPid(pid);
            for (User u : users) {
                if (u.getEmailId().contains("@eminentlabs.net")) {
                    internalUsers.put(u.getId(), u.getFirstName() + " " + u.getLastName());
                } else {
                    clientUsers.put(u.getId(), u.getFirstName() + " " + u.getLastName());
                }
            }

        }

    }
    
    public String deleteWRMMailId(HttpServletRequest request){
        String res="";
        try{
           long id = Long.parseLong(request.getParameter("id"));
           if(id==0l){
               res="ID is not available";
           }else{
               res= WRMMailMaintainDAO.deleteWrmMailId(id);
           }
        }catch(Exception e){
            res="Error in delete wrm of user's mail id";
            e.printStackTrace();
        }
        return res;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<Long, String> getInternalUsers() {
        return internalUsers;
    }

    public void setInternalUsers(Map<Long, String> internalUsers) {
        this.internalUsers = internalUsers;
    }

    public Map<Long, String> getClientUsers() {
        return clientUsers;
    }

    public void setClientUsers(Map<Long, String> clientUsers) {
        this.clientUsers = clientUsers;
    }

    public List<User> getWrmMailUsers() {
        return wrmMailUsers;
    }

    public void setWrmMailUsers(List<User> wrmMailUsers) {
        this.wrmMailUsers = wrmMailUsers;
    }

    public long getPid() {
        return pid;
    }

    public void setPid(long pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }
    

}
