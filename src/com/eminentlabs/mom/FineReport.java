/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import com.eminent.util.GetProjectMembers;
import com.eminentlabs.mom.formbean.FineAmountBean;
import com.eminentlabs.mom.formbean.FinePaymentBean;
import com.eminentlabs.mom.formbean.FineReportBean;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author RN.Khans
 */
public class FineReport {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("FineReport");
    }
    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    List<String> modList = Arrays.asList(noOfIds);
    HashMap<Integer, String> member = GetProjectMembers.getEminentUsers();
    HashMap<Integer, String> monthName = FineUtil.getMonthName();
    List<FineReportBean> report = new ArrayList();
    int year, month;
    List<Integer> years = FineUtil.getYears();

    public List<Integer> getYears() {
        return years;
    }

    public void setYears(List<Integer> years) {
        this.years = years;
    }

    public HashMap<Integer, String> getMonthName() {
        return monthName;
    }

    public void setMonthName(HashMap<Integer, String> monthName) {
        this.monthName = monthName;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }

    public List<FineReportBean> getReport() {
        return report;
    }

    public void setReport(List<FineReportBean> report) {
        this.report = report;
    }

    public void setAll(HttpServletRequest request) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<Integer, Integer> prevFineAmtPaid = new HashMap();
        HashMap<Integer, Integer> prevFineAmt = new HashMap();
        HashMap<Integer, Integer> currFineAmtSPaid = new HashMap();
        HashMap<Integer, Integer> currFineSAmt = new HashMap();
        List<FineAmountBean> fineAmtList = new ArrayList();
        List<FinePaymentBean> paymentList = new ArrayList();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        HashMap<Integer, List<FineAmountBean>> currFineAmt = new HashMap();
        HashMap<Integer, List<FinePaymentBean>> currFineAmtPaid = new HashMap();
        int currFineSum = 0, currFinePaidSum = 0;
        try {
            Calendar cal = new GregorianCalendar();
            String selectYear = request.getParameter("year");
            String selectMonth = request.getParameter("month");
            String start, end;
            int maxday;
            year = 0;
            month = 0;
            if (selectYear == null || selectYear.equals("")) {
                year = cal.get(Calendar.YEAR);
                month = cal.get(Calendar.MONTH);
                maxday = cal.get(Calendar.DAY_OF_MONTH);
            } else {
                year = Integer.parseInt(selectYear);
                month = Integer.parseInt(selectMonth);
                Calendar cale = Calendar.getInstance();
                cale.set(year, month, 1);
                maxday = cale.getActualMaximum(Calendar.DATE);
            }

            start = "1" + "-" + monthName.get(month) + "-" + year;
            end = maxday + "-" + monthName.get(month) + "-" + year;
            logger.info("START : " + start);
            logger.info("END : " + end);
            connection = MakeConnection.getConnection();

            String prevFineQuery = "select sum(AMOUNT),userid from FINE_AMOUNT_USERS where STATUS='Active' and fine_date < '" + start + "' group by userid ";
            logger.info(" prevFineQuery :" + prevFineQuery);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(prevFineQuery);
            while (resultset.next()) {
                prevFineAmt.put(resultset.getInt(2), resultset.getInt(1));
            }

            String prevFinePaid = "select sum(AMOUNT),userid from ERM_FINE_PAID where STATUS='Active'  and PAID_DATE < '" + start + "' group by userid";
            logger.info(" prevFinePaid :" + prevFinePaid);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(prevFinePaid);
            while (resultset.next()) {
                prevFineAmtPaid.put(resultset.getInt(2), resultset.getInt(1));
            }
            String currFineQuery = "select a.userid as userId,b.reason as reason,a.fine_date as fdate,a.amount as amount from FINE_AMOUNT_USERS a,fine b where a.reasonid=b.id and STATUS='Active'  and fine_date between '" + start + "' and '" + end + "' order by a.userid";
            logger.info(" currFineQuery :" + currFineQuery);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(currFineQuery);
            int prevFineUser = 0;
            while (resultset.next()) {
                int currFineUser = resultset.getInt("userId");
                if (prevFineUser == 0) {
                    FineAmountBean fineAmt = new FineAmountBean();
                    fineAmt.setUserId(resultset.getString("userId"));
                    fineAmt.setReason(resultset.getString("reason"));
                    fineAmt.setDate(sdf.format(resultset.getDate("fdate")));
                    fineAmt.setAmount(resultset.getString("amount"));
                    fineAmtList.add(fineAmt);
                    currFineSum = currFineSum + resultset.getInt("amount");
                    currFineSAmt.put(currFineUser, currFineSum);
                    currFineAmt.put(currFineUser, fineAmtList);
                    prevFineUser = currFineUser;
                } else if (prevFineUser != currFineUser) {
                    fineAmtList = new ArrayList();
                    FineAmountBean fineAmt = new FineAmountBean();
                    fineAmt.setUserId(resultset.getString("userId"));
                    fineAmt.setReason(resultset.getString("reason"));
                    fineAmt.setDate(sdf.format(resultset.getDate("fdate")));
                    fineAmt.setAmount(resultset.getString("amount"));
                    fineAmtList.add(fineAmt);
                    prevFineUser = currFineUser;
                    currFineSum = currFineSum + resultset.getInt("amount");
                    currFineSAmt.put(currFineUser, currFineSum);
                    currFineAmt.put(currFineUser, fineAmtList);
                } else {
                    FineAmountBean fineAmt = new FineAmountBean();
                    fineAmt.setUserId(resultset.getString("userId"));
                    fineAmt.setReason(resultset.getString("reason"));
                    fineAmt.setDate(sdf.format(resultset.getDate("fdate")));
                    fineAmt.setAmount(resultset.getString("amount"));
                    fineAmtList.add(fineAmt);
                    currFineAmt.put(currFineUser, fineAmtList);
                    currFineSum = currFineSum + resultset.getInt("amount");
                    currFineSAmt.put(currFineUser, currFineSum);
                }
            }
            if (!fineAmtList.isEmpty()) {
                currFineAmt.put(prevFineUser, fineAmtList);
            }

            String currPayQuery = "select a.userid as userId,a.PAID_DATE as pdate,a.amount as amount,a.comments as comments from erm_fine_paid a,users b where a.userid=b.userid  and a.status='Active' and PAID_DATE between '" + start + "' and '" + end + "' order by a.userid";
            logger.info(" currPayQuery :" + currPayQuery);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(currPayQuery);
            int prevPaidUser = 0;
            while (resultset.next()) {
                int currPaidUser = resultset.getInt("userId");
                if (prevPaidUser == 0) {
                    FinePaymentBean payment = new FinePaymentBean();
                    payment.setUserId(resultset.getInt("userId"));
                    payment.setComments(resultset.getString("comments"));
                    payment.setDate(sdf.format(resultset.getDate("pdate")));
                    payment.setAmount(resultset.getInt("amount"));
                    paymentList.add(payment);
                    prevPaidUser = currPaidUser;
                    currFineAmtPaid.put(currPaidUser, paymentList);
                } else if (prevPaidUser != currPaidUser) {
                    paymentList = new ArrayList();
                    FinePaymentBean payment = new FinePaymentBean();
                    payment.setUserId(resultset.getInt("userId"));
                    payment.setComments(resultset.getString("comments"));
                    payment.setDate(sdf.format(resultset.getDate("pdate")));
                    payment.setAmount(resultset.getInt("amount"));
                    paymentList.add(payment);
                    currFineAmtPaid.put(currPaidUser, paymentList);
                    prevPaidUser = currPaidUser;
                } else {
                    FinePaymentBean payment = new FinePaymentBean();
                    payment.setUserId(resultset.getInt("userId"));
                    payment.setComments(resultset.getString("comments"));
                    payment.setDate(sdf.format(resultset.getDate("pdate")));
                    payment.setAmount(resultset.getInt("amount"));
                    paymentList.add(payment);
                    currFineAmtPaid.put(currPaidUser, paymentList);
                }

            }
            if (!paymentList.isEmpty()) {
                currFineAmtPaid.put(prevPaidUser, paymentList);
            }

            for (Map.Entry<Integer, String> users : member.entrySet()) {
                FineReportBean frb = new FineReportBean();
                frb.setUserId(users.getKey());
                frb.setName(users.getValue());
                int prevBal = 0, prevPaid = 0;
                if (prevFineAmt.containsKey(users.getKey())) {
                    prevBal = prevFineAmt.get(users.getKey());
                }
                if (prevFineAmtPaid.containsKey(users.getKey())) {
                    prevPaid = prevFineAmtPaid.get(users.getKey());
                }

                frb.setPrevBalance(prevBal - prevPaid);

                if (currFineAmt.containsKey(users.getKey())) {
                    frb.setFineAmtList(currFineAmt.get(users.getKey()));
                    int sumFine = 0;
                    for (FineAmountBean bean : frb.getFineAmtList()) {
                        sumFine = sumFine + Integer.parseInt(bean.getAmount());
                    }
                    frb.setCurrMonFine(sumFine);

                }
                if (currFineAmtPaid.containsKey(users.getKey())) {
                    frb.setFinePaidList(currFineAmtPaid.get(users.getKey()));
                    int sumPaid = 0;
                    for(FinePaymentBean pay : frb.getFinePaidList()){
                        sumPaid = sumPaid + pay.getAmount();
                    }
                    frb.setCurrMonPaid(sumPaid);
                }
                frb.setCloseBalance((frb.getPrevBalance() + frb.getCurrMonFine()) - frb.getCurrMonPaid());
                if(frb.getCloseBalance() > 0  || frb.getPrevBalance() >0){
                report.add(frb);
                }
            }
       
 Collections.sort(report, new Comparator<FineReportBean>() {
            @Override
            public int compare(FineReportBean t1, FineReportBean t2) {               
                return Float.valueOf(t2.getCloseBalance()).compareTo(Float.valueOf(t1.getCloseBalance()));
            }
        }
        );
        } catch (Exception e) {
            logger.error("FineReport" +e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                logger.error("FineReport" +ex.getMessage());
            }
        }
    }

}
