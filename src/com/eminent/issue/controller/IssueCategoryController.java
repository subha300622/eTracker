/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.IssueCategory;
import com.eminent.issue.dao.IssueCategoryDAO;
import com.eminent.issue.dao.IssueCategoryDAOImpl;
import com.eminent.util.GetProjectMembers;
import com.eminentlabs.dao.ModelDAO;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Eminent
 */
public class IssueCategoryController {

    private String message;
    List<IssueCategory> issueCategorys = null;
    IssueCategory issueCategory = null;

    public void setAll(HttpServletRequest request) {
        IssueCategoryDAO issueCategoryDAO = new IssueCategoryDAOImpl();
        try {
            String project = request.getParameter("project");
            String category = request.getParameter("category");
            String categoryId = request.getParameter("categoryId");

            if (categoryId != null && !categoryId.equals("")) {
                issueCategory = issueCategoryDAO.getByID(Integer.parseInt(categoryId));
            }

            if (request.getMethod().equalsIgnoreCase("post")) {
                //  IssueCategory ic = issueCategoryDAO.getByPidNCategory(Integer.parseInt(project), category);

                IssueCategory ic = new IssueCategory();
                ic.setPid(Integer.parseInt(project));
                ic.setCategoryName(category);

                if (categoryId != null && !categoryId.equals("")) {
                    ic.setId(issueCategory.getId());
                    ModelDAO.update("IssueCategory", ic);
                    int count = GetProjectMembers.updateIssueCategory(issueCategory.getPid(), issueCategory.getCategoryName(), category);

                    message = "Issue category updated successfully and agreed table also updated successfully";
                } else {
                    ModelDAO.save("IssueCategory", ic);
                    message = "Issue category added  successfully";
                }
                issueCategory = null;

            }

        } catch (Exception e) {
            message = "An error occured." + e.getMessage();
            e.printStackTrace();
        }

        issueCategorys = issueCategoryDAO.getAll();
    }

    public void getIssueCategoryByPid(int pid) {
        issueCategorys = new IssueCategoryDAOImpl().getByPid(pid);
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<IssueCategory> getIssueCategorys() {
        return issueCategorys;
    }

    public void setIssueCategorys(List<IssueCategory> issueCategorys) {
        this.issueCategorys = issueCategorys;
    }

    public IssueCategory getIssueCategory() {
        return issueCategory;
    }

    public void setIssueCategory(IssueCategory issueCategory) {
        this.issueCategory = issueCategory;
    }

}
