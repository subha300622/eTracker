/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.ModelDAO;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author E0288
 */
public class ERMDeleteView {

    private String status;
    private String errormessage;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getErrormessage() {
        return errormessage;
    }

    public void setErrormessage(String errormessage) {
        this.errormessage = errormessage;
    }

    public void deleteView(HttpServletRequest request) {
        String qId = request.getParameter("queryId");
        if (qId != null) {
            try {
                long queryId = Long.valueOf(qId);
                MyQuery myQuery = ERMUtil.findByQueryId(queryId);
                if (myQuery != null) {
                    ModelDAO.delete(DAOConstants.ENTITY_MYQUERY, myQuery);
                    status = myQuery.getName();
                } else {
                    errormessage = "Url Is wrong";
                }
            } catch (NumberFormatException ex) {
                errormessage = "Url Is wrong";
            }


        } else {
            errormessage = "Url Is wrong";
        }
    }
}
