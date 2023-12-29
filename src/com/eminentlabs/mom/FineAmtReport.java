/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import com.eminent.issue.PlanStatus;
import com.eminentlabs.mom.formbean.FineAmountBean;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author RN.Khans
 */
public class FineAmtReport {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("FineAmtReport");
    }

    private String startDate;
    private String endDate;
    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    List<String> modList = Arrays.asList(noOfIds);
    String planMods = rb.getString("mom-plan-mod");
    String noOfplanMods[] = planMods.split(",");
    List<String> revokeUsers = Arrays.asList(noOfplanMods);
    List<FineAmountBean> fineList = new ArrayList();
    FineAmountBean fineAmt = new FineAmountBean();
    String result;

    public void setAll(HttpServletRequest request) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        SimpleDateFormat sdfs = new SimpleDateFormat("dd-MM-yyyy");
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        Date start = c.getTime();
        c.add(Calendar.DATE, -2);
        start = c.getTime();
        c.add(Calendar.DATE, 2);
        c.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
        Date end = c.getTime();
        startDate = sdfs.format(start);
        endDate = sdfs.format(end);
        String startParam = sdf.format(start);
        String endParam = sdf.format(end);

        String revokeId = request.getParameter("revokeId");
        String comment = request.getParameter("comment");

        if (revokeId != null && comment != null) {
            String method = request.getMethod();
            if (method.equalsIgnoreCase("post")) {
                String status = PlanStatus.INACTIVE.getStatus();

                HttpSession session = request.getSession();
                int addedBy = (Integer) session.getAttribute("userid_curr");
                Date date = c.getTime();
                FineAmountUsers fau = new FineAmountUsers();
                fau.setId(Long.valueOf(revokeId));
                fau.setAddedby(addedBy);
                fau.setAddedon(date);
                fau.setStatus(status);
                fau.setComments(comment);
                result = FineUtil.fineAmtRevoke(fau);
            }
        }

        if (request.getParameter("fromdate") != null && request.getParameter("todate") != null) {
            startDate = request.getParameter("fromdate");
            startParam = com.pack.ChangeFormat.changeDateFormat(startDate);
            endDate = request.getParameter("todate");
            endParam = com.pack.ChangeFormat.changeDateFormat(endDate);
        }

        fineList = FineUtil.getFineAmtUsers(startParam, endParam);

    }

    public void fineDetail(HttpServletRequest request) {
        String fineId = request.getParameter("fineId");
        if (fineId != null) {
            startDate = request.getParameter("sDate");
            endDate = request.getParameter("eDate");
            fineAmt = FineUtil.getFineAmtUser(fineId);
        }
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }

    public List<FineAmountBean> getFineList() {
        return fineList;
    }

    public void setFineList(List<FineAmountBean> fineList) {
        this.fineList = fineList;
    }

    public FineAmountBean getFineAmt() {
        return fineAmt;
    }

    public void setFineAmt(FineAmountBean fineAmt) {
        this.fineAmt = fineAmt;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public List<String> getRevokeUsers() {
        return revokeUsers;
    }

    public void setRevokeUsers(List<String> revokeUsers) {
        this.revokeUsers = revokeUsers;
    }

}
