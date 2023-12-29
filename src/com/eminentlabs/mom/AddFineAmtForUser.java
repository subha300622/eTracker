/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import com.eminent.issue.PlanStatus;
import com.eminent.util.GetProjectMembers;

import com.eminentlabs.mom.formbean.MomTeamWiseFormBean;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author RN.Khans
 */
public class AddFineAmtForUser {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("AddFineAmount");
    }

    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    List<String> modList = Arrays.asList(noOfIds);
    HashMap<Integer, String> member = GetProjectMembers.getEminentUsers();
    List<Fine> fineAmtList = FineUtil.getFineAmount();
    String result = null;

    public void setAll(HttpServletRequest request) throws Exception {
        String method = request.getMethod();
        if (method.equalsIgnoreCase("post")) {
            String status = PlanStatus.ACTIVE.getStatus();
            String userId = request.getParameter("userId");
            String reasonId = request.getParameter("reasonId");
            if (userId != null && reasonId != null) {
                HttpSession session = request.getSession();
                String fineDate = request.getParameter("finedate");
                String amount = request.getParameter("amount");
                int addedBy = (Integer) session.getAttribute("userid_curr");
                Calendar c = new GregorianCalendar();
                Date date = c.getTime();
                FineAmountUsers fau = new FineAmountUsers();
                int fineamount = Integer.parseInt(amount);
                fau.setUserid(Integer.parseInt(userId));
                fau.setReasonid(Integer.parseInt(reasonId));
                fau.setAmount(fineamount);
                fau.setFineDate(java.sql.Date.valueOf(com.pack.ChangeFormat.getDateFormat(fineDate)));
                fau.setAddedby(addedBy);
                fau.setAddedon(date);
                fau.setStatus(status);
                result = FineUtil.addFineAmtForUser(fau);
            }
        }
    }

    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }

    public List<Fine> getFineAmtList() {
        return fineAmtList;
    }

    public void setFineAmtList(List<Fine> fineAmtList) {
        this.fineAmtList = fineAmtList;
    }

    public HashMap<Integer, String> getMember() {
        return member;
    }

    public void setMember(HashMap<Integer, String> member) {
        this.member = member;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

}
