/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import com.eminent.issue.PlanStatus;
import com.eminentlabs.mom.formbean.FinePaymentBean;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
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
public class FinePayment {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("FinePayment");
    }

    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    List<String> modList = Arrays.asList(noOfIds);
    //HashMap<Integer, String> member = FineUtil.getUsers();
    HashMap<Integer, String> member = FineUtil.getPaymentUsers();

    List<FinePaymentBean> paymentList = FineUtil.getPaymentList();
    FinePaymentBean paymentById = new FinePaymentBean();
    String result = "";

    public void setAll(HttpServletRequest request) throws Exception {
        String paymentId = request.getParameter("paymentId");

        if (paymentId != null) {
            paymentById = FineUtil.getPaymentId(paymentId);
        }

    }

    public String savePayment(HttpServletRequest request) throws Exception {

        HttpSession session = request.getSession();
        result = "failure";
        String method = request.getMethod();
        logger.info("TYpe : "+request.getParameter("type"));
        if (method.equalsIgnoreCase("post")) {
            /**
             *  add Payment 
             */
            if (request.getParameter("type").equalsIgnoreCase("add")) {
                String userId = request.getParameter("userId");
                String fineDate = request.getParameter("date");
                String amount = request.getParameter("amount");
                String comments = request.getParameter("comments");
                int addedBy = (Integer) session.getAttribute("userid_curr");
                String status = PlanStatus.ACTIVE.getStatus();
                if (userId != null && fineDate != null && amount != null && comments != null) {
                    ErmFinePaid fau = new ErmFinePaid();
                    int fineamount = Integer.parseInt(amount);
                    fau.setUserid(Integer.parseInt(userId));
                    fau.setAmount(fineamount);
                    fau.setPaidDate(java.sql.Date.valueOf(com.pack.ChangeFormat.getDateFormat(fineDate)));
                    fau.setCollectedby(addedBy);
                    fau.setComments(comments);
                    fau.setStatus(status);
                    FineUtil.addFinePayment(fau);
                    result = "success";
                }
            } else {
                String userId = request.getParameter("userId");
                String fineDate = request.getParameter("date");
                String amount = request.getParameter("amount");
                String comments = request.getParameter("comments");
                int addedBy = Integer.parseInt(request.getParameter("collectedById"));
                long paymentId = Long.valueOf(request.getParameter("paymentId"));
                String type = request.getParameter("type");
                int modifiedby = (Integer) session.getAttribute("userid_curr");
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                Date date = new Date();
                Date modifiedon = sdf.parse(sdf.format(date));
                ErmFinePaid fau = new ErmFinePaid();
                int fineamount = Integer.parseInt(amount);
                String status = "";

                fau.setId(paymentId);
                fau.setUserid(Integer.parseInt(userId));
                fau.setAmount(fineamount);
                fau.setPaidDate(java.sql.Date.valueOf(com.pack.ChangeFormat.getDateFormat(fineDate)));
                fau.setCollectedby(addedBy);
                fau.setModifiedby(modifiedby);
                fau.setModifiedon(modifiedon);
                fau.setComments(comments);
                logger.info("type" + type);
                if (type.equalsIgnoreCase("edit")) {
                    status = PlanStatus.ACTIVE.getStatus();
                } else if (type.equalsIgnoreCase("delete")) {
                    status = PlanStatus.INACTIVE.getStatus();
                } else {
                    status = "";
                }
                if (status != "") {
                    fau.setStatus(status);
                }
                FineUtil.updateFinePayment(fau);

            }
        }
        member = FineUtil.getPaymentUsers();
        paymentList = FineUtil.getPaymentList();

        return result;
    }

    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }

    public HashMap<Integer, String> getMember() {
        return member;
    }

    public void setMember(HashMap<Integer, String> member) {
        this.member = member;
    }

    public List<FinePaymentBean> getPaymentList() {
        return paymentList;
    }

    public void setPaymentList(List<FinePaymentBean> paymentList) {
        this.paymentList = paymentList;
    }

    public FinePaymentBean getPaymentById() {
        return paymentById;
    }

    public void setPaymentById(FinePaymentBean paymentById) {
        this.paymentById = paymentById;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

}
