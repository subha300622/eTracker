/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm.controller;

import com.eminent.customer.ContactRegistration;
import com.eminentlabs.crm.CRMUtil;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author vanithaalliraj
 */
public class IndustryController {

    Map<Integer, String> industries = null;
    String industryId = null;
    String industryName = null;
    String message = null;
    ContactRegistration cr = new ContactRegistration();

    public Map<Integer, String> getIndustries() {
        return industries;
    }

    public void setIndustries(Map<Integer, String> industries) {
        this.industries = industries;
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId;
    }

    public String getIndustryName() {
        return industryName;
    }

    public void setIndustryName(String industryName) {
        this.industryName = industryName;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setAll(HttpServletRequest request) {

        industryId = request.getParameter("industryId");
        Connection connection = null;
        try {
            if (request.getMethod().equalsIgnoreCase("post")) {
                industryName = request.getParameter("industryName");
                if (industryName != null) {
                    connection = MakeConnection.getConnection();
                    if (industryId == null) {
                        cr.addIndustry(connection, industryName);
                    } else {
                        cr.updateIndustry(connection, industryName, Integer.parseInt(industryId));
                    }
                    industryId = null;
                    industryName = null;
                    message = "Industry maintained successfully";
                }
            }
            industries = CRMUtil.getIndustry();
            if (industryId != null) {
                if (industries.containsKey(Integer.parseInt(industryId))) {
                    industryName = industries.get(Integer.parseInt(industryId));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "An Error Occured." + e.getMessage();

        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
}
