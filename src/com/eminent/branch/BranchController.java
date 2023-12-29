/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.branch;

import com.eminentlabs.dao.ModelDAO;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author Muthu
 */
public class BranchController {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("BranchController");
    }

    private String message;
    List<Branches> branches = null;
    Branches branch = null;
    String branchId = null;
    Map<Integer,String> branchMap=null;
    public void setAll(HttpServletRequest request) {
        BranchDAO branchDAO = new BranchDAOImpl();
        branchId = request.getParameter("branchId");
        try {
            if (branchId != null) {
                branch = branchDAO.findByBranchId(Integer.parseInt(branchId));
            } else {
                branch = null;
            }
            if (request.getMethod().equalsIgnoreCase("post")) {
                String location = request.getParameter("location");
                Branches newbranch = new Branches();
                newbranch.setLocation(location);
                if (branchId == null) {
                    ModelDAO.save("Branches", newbranch);
                    message = "New branch added successfuly";
                } else {
                    newbranch.setBranchId(Integer.parseInt(branchId));
                    ModelDAO.update("Branches", newbranch);
                    message = "Branch updated successfuly";
                }
            }
        } catch (Exception e) {
            message = "An Error Occured." + e.getMessage();
            logger.error(e.getMessage());
        }
        branches = branchDAO.findAll();
    }

    public void getAllBranches() {
          BranchDAO branchDAO = new BranchDAOImpl();
        branches = branchDAO.findAll();
    }
public void getAllBranchMap() {
        BranchDAO branchDAO = new BranchDAOImpl();
        List<Branches> branchesa = branchDAO.findAll();
        branchMap = new HashMap<>();
        for(Branches b:branchesa){
            branchMap.put(b.getBranchId(), b.getLocation());
        }
    }
    public static Logger getLogger() {
        return logger;
    }

    public static void setLogger(Logger logger) {
        BranchController.logger = logger;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<Branches> getBranches() {
        return branches;
    }

    public void setBranches(List<Branches> branches) {
        this.branches = branches;
    }

    public Branches getBranch() {
        return branch;
    }

    public void setBranch(Branches branch) {
        this.branch = branch;
    }

    public String getBranchId() {
        return branchId;
    }

    public void setBranchId(String branchId) {
        this.branchId = branchId;
    }

    public Map<Integer, String> getBranchMap() {
        return branchMap;
    }

    public void setBranchMap(Map<Integer, String> branchMap) {
        this.branchMap = branchMap;
    }

    
}
