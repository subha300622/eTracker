/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.gstn;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author QSERVER
 */
public class GstnLogController {

    String startDate;
    Map<String, Map<String, Map<String, List<LogDetail>>>> projectwise = new HashMap<>();
    Map<String, Map<String, Integer>> indCount = new HashMap<>();

    public void setAll(HttpServletRequest request) {
        int count = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            DateFormat sdf = new SimpleDateFormat("MMMM yyyy");
            DateFormat sdfa = new SimpleDateFormat("yyyyMM");
            Calendar cal = new GregorianCalendar();
            Date date = cal.getTime();
            cal.setTime(date);
            if (request.getParameter("startDate") != null) {
                startDate = request.getParameter("startDate");
                cal.setTime(sdf.parse(startDate));
            } else {
                Calendar calc = new GregorianCalendar();
                calc.setTime(date);
                cal.setTime(calc.getTime());
                startDate = sdf.format(calc.getTime());
            }
            connection = MakeConnection.getESPLASPConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "SELECT  g.Project,g.AccessType,g.gstin,g.Category,g.ActionType,count(DISTINCT(g.LogId)) as API,\n"
                    + "COUNT(i.InvoiceNo) AS TotalInvoices,COUNT(DISTINCT(i.InvoiceNo)) AS OriInvoices,\n"
                    + "(COUNT(i.InvoiceNo) - COUNT(DISTINCT(i.InvoiceNo))) AS DuplicateInvoices\n"
                    + " from gstn_log g\n"
                    + "LEFT JOIN gstn_log_invoice i ON g.LogId=i.LogId\n"
                    + "where EXTRACT(YEAR_MONTH FROM g.RequestTime)='" + sdfa.format(cal.getTime()) + "'\n"
                    + "GROUP BY g.Project,g.AccessType,g.gstin,g.Category,g.ActionType ORDER BY g.Project,g.AccessType,g.gstin,g.Category,g.ActionType";
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {
                Map<String, Map<String, List<LogDetail>>> maps = projectwise.get(resultset.getString("Project"));
                if (maps == null) {
                    maps = new HashMap<>();
                }
                Map<String, List<LogDetail>> ma = maps.get(resultset.getString("AccessType"));
                if (ma == null) {
                    ma = new HashMap<>();
                }
                LogDetail ld = new LogDetail();
                ld.setGstin(resultset.getString("gstin"));
                ld.setCategory(resultset.getString("Category"));
                ld.setAction(resultset.getString("ActionType"));
                ld.setApiCount(resultset.getInt("API"));
                ld.setTotInvoices(resultset.getInt("TotalInvoices"));
                ld.setDupInvoices(resultset.getInt("DuplicateInvoices"));
                ld.setOrgInvoices(resultset.getInt("OriInvoices"));
                Map<String, Integer> counts = indCount.get(resultset.getString("Project"));
                if (counts == null) {
                    count=0;
                    counts = new HashMap<>();
                } else {
                }
                if ((resultset.getString("Category").equals("GSTR1-SAVE") || resultset.getString("Category").equals("GSTR6-SAVE"))
                        && (resultset.getString("ActionType").equals("B2B") || resultset.getString("ActionType").equals("B2BA")
                        || resultset.getString("ActionType").equals("B2CL") || resultset.getString("ActionType").equals("B2CLA")
                        || resultset.getString("ActionType").equals("EXP") || resultset.getString("ActionType").equals("EXPA")
                        || resultset.getString("ActionType").equals("CDNR") || resultset.getString("ActionType").equals("CDNRA")
                        || resultset.getString("ActionType").equals("CDNUR") || resultset.getString("ActionType").equals("CDNURA"))) {
                    ld.setTotCount(resultset.getInt("TotalInvoices"));
                } else {
                    ld.setTotCount(resultset.getInt("API"));
                }
                if (counts.containsKey(resultset.getString("AccessType"))) {
                    count = counts.get(resultset.getString("AccessType"))+ld.getTotCount();
                    counts.put(resultset.getString("AccessType"), count);
                } else {
                    counts.put(resultset.getString("AccessType"), ld.getTotCount());
                }
                indCount.put(resultset.getString("Project"), counts);
                List<LogDetail> log = ma.get(resultset.getString("gstin"));
                if (log == null) {
                    log = new ArrayList();
                }
                log.add(ld);
                ma.put(resultset.getString("gstin"), log);
                maps.put(resultset.getString("AccessType"), ma);
                projectwise.put(resultset.getString("Project"), maps);

            }
//
//            System.out.println("sql : " + sqla);
//            resultset = statement.executeQuery(sqla);
//            while (resultset.next()) {
//                Map<String, Integer> ma = indCount.get(resultset.getString("Project"));
//                if (ma == null) {
//                    ma = new HashMap<>();
//                }
//                ma.put(resultset.getString("AccessType"), resultset.getInt("counta"));
//                indCount.put(resultset.getString("Project"), ma);
//            }

        } catch (Exception e) {
            e.printStackTrace();
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
            } catch (Exception ex) {
            }
        }

    }

    public static List<LogDetail> getAccessDetail(HttpServletRequest request) {
        int count = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<LogDetail> list = new ArrayList();
        try {
            String project = request.getParameter("project");
            String type = request.getParameter("type");
            String gstin = request.getParameter("gstin");
            String category = request.getParameter("category");
            String startDate = request.getParameter("month");
            DateFormat sdf = new SimpleDateFormat("MMMM yyyy");
            DateFormat sdfa = new SimpleDateFormat("yyyyMM");
            Calendar cal = new GregorianCalendar();
            Date date = cal.getTime();
            cal.setTime(date);
            if (startDate != null) {
                cal.setTime(sdf.parse(startDate));
            } else {
                Calendar calc = new GregorianCalendar();
                calc.setTime(date);
                cal.setTime(calc.getTime());
                startDate = sdf.format(calc.getTime());
            }
            connection = MakeConnection.getESPLASPConnection();

            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String extendQury = " and g.gstin = '" + gstin + "'";
            if (gstin.equalsIgnoreCase("null")) {
                extendQury = " and g.gstin is null";
            }
            String sql = "SELECT  g.Project,g.AccessType,g.gstin,g.Category,g.ActionType,count(DISTINCT(g.LogId)) as API,\n"
                    + "COUNT(i.InvoiceNo) AS TotalInvoices,COUNT(DISTINCT(i.InvoiceNo)) AS OriInvoices,\n"
                    + "(COUNT(i.InvoiceNo) - COUNT(DISTINCT(i.InvoiceNo))) AS DuplicateInvoices\n"
                    + " from gstn_log g\n"
                    + "LEFT JOIN gstn_log_invoice i ON g.LogId=i.LogId\n"
                    + "where g.Project='" + project + "' and g.AccessType='" + type + "' and g.Category like '%" + category + "%' " + extendQury + "  and  EXTRACT(YEAR_MONTH FROM g.RequestTime)='" + sdfa.format(cal.getTime()) + "'\n"
                    + "GROUP BY g.Project,g.AccessType,g.gstin,g.Category,g.ActionType ORDER BY g.Project,g.AccessType,g.gstin,g.Category,g.ActionType";
            System.out.println("sql : " + sql);
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {

                LogDetail ld = new LogDetail();
                ld.setGstin(resultset.getString("gstin"));
                ld.setCategory(resultset.getString("Category"));
                ld.setAction(resultset.getString("ActionType"));
                ld.setApiCount(resultset.getInt("API"));
                ld.setTotInvoices(resultset.getInt("TotalInvoices"));
                ld.setDupInvoices(resultset.getInt("DuplicateInvoices"));
                ld.setOrgInvoices(resultset.getInt("OriInvoices"));

                if ((resultset.getString("Category").equals("GSTR1-SAVE") || resultset.getString("Category").equals("GSTR6-SAVE"))
                        && (resultset.getString("ActionType").equals("B2B") || resultset.getString("ActionType").equals("B2BA")
                        || resultset.getString("ActionType").equals("B2CL") || resultset.getString("ActionType").equals("B2CLA")
                        || resultset.getString("ActionType").equals("EXP") || resultset.getString("ActionType").equals("EXPA")
                        || resultset.getString("ActionType").equals("CDNR") || resultset.getString("ActionType").equals("CDNRA")
                        || resultset.getString("ActionType").equals("CDNUR") || resultset.getString("ActionType").equals("CDNURA"))) {
                    count += resultset.getInt("TotalInvoices");
                    ld.setTotCount(resultset.getInt("TotalInvoices"));
                    System.out.println("Category : " + resultset.getString("Category") + "\t ActionType : " + resultset.getString("ActionType") + "\t TotalInvoices : " + resultset.getInt("TotalInvoices"));
                } else {
                    System.out.println("Category : " + resultset.getString("Category") + "\t ActionType : " + resultset.getString("ActionType") + "\t API : " + resultset.getInt("API"));
                    ld.setTotCount(resultset.getInt("API"));
                    count += resultset.getInt("API");
                }

                list.add(ld);

            }
//
//            System.out.println("sql : " + sqla);
//            resultset = statement.executeQuery(sqla);
//            while (resultset.next()) {
//                Map<String, Integer> ma = indCount.get(resultset.getString("Project"));
//                if (ma == null) {
//                    ma = new HashMap<>();
//                }
//                ma.put(resultset.getString("AccessType"), resultset.getInt("counta"));
//                indCount.put(resultset.getString("Project"), ma);
//            }

        } catch (Exception e) {
            e.printStackTrace();
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
            } catch (Exception ex) {
            }
        }
        return list;

    }

    public List<Log> getActionDetail(HttpServletRequest request) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<Log> list = new ArrayList();
        try {
            String project = request.getParameter("project");
            String type = request.getParameter("type");
            String gstin = request.getParameter("gstin");
            String category = request.getParameter("category");
            String action = request.getParameter("action");
            String startDate = request.getParameter("month");
            DateFormat sdf = new SimpleDateFormat("MMMM yyyy");
            DateFormat sdfa = new SimpleDateFormat("yyyyMM");
            Calendar cal = new GregorianCalendar();
            Date date = cal.getTime();
            cal.setTime(date);
            if (startDate != null) {
                cal.setTime(sdf.parse(startDate));
            } else {
                Calendar calc = new GregorianCalendar();
                calc.setTime(date);
                cal.setTime(calc.getTime());
                startDate = sdf.format(calc.getTime());
            }
            connection = MakeConnection.getESPLASPConnection();

            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String extendQury = " and g.gstin = '" + gstin + "'";
            if (gstin.equalsIgnoreCase("null")) {
                extendQury = " and g.gstin is null";
            }
            String sql = "SELECT g.TransactionID,g.RequestTime,g.ResponseTime,g.RequestJson,g.ResponseJson,i.InvoiceNo\n"
                    + " from gstn_log g\n"
                    + "LEFT JOIN gstn_log_invoice i ON g.LogId=i.LogId\n"
                    + "where g.Project='" + project + "' and g.AccessType='" + type + "' and g.Category = '" + category + "' " + extendQury + " and g.ActionType='" + action + "' and  EXTRACT(YEAR_MONTH FROM g.RequestTime)='" + sdfa.format(cal.getTime()) + "'\n"
                    + "order by g.LogId ";
            System.out.println("sql : " + sql);
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {
                Log ld = new Log();
                ld.setTransId(resultset.getString("TransactionID"));
                ld.setRequestTime(resultset.getString("RequestTime"));
                ld.setResponseTime(resultset.getString("ResponseTime"));
                ld.setRequestJson(resultset.getString("RequestJson"));
                ld.setResponseJson(resultset.getString("ResponseJson"));
                ld.setInvoice(resultset.getString("InvoiceNo"));
                list.add(ld);
            }
//
//            System.out.println("sql : " + sqla);
//            resultset = statement.executeQuery(sqla);
//            while (resultset.next()) {
//                Map<String, Integer> ma = indCount.get(resultset.getString("Project"));
//                if (ma == null) {
//                    ma = new HashMap<>();
//                }
//                ma.put(resultset.getString("AccessType"), resultset.getInt("counta"));
//                indCount.put(resultset.getString("Project"), ma);
//            }
            System.out.println("list : " + list.size());
        } catch (Exception e) {
            e.printStackTrace();
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
            } catch (Exception ex) {
            }
        }
        return list;

    }

    public Set<String> gstrRequests() {
        Set<String> gstr = new LinkedHashSet<>();
        gstr.add("AUTHENTICATE");
        gstr.add("GSTR1-SAVE");
        gstr.add("GSTR1-GET");
        gstr.add("GSTR2A-GET");
        gstr.add("GSTR3B-SAVE");
        gstr.add("GSTR3B-GET");
        gstr.add("GSTR6A-GET");
        gstr.add("GSTR6-SAVE");
        gstr.add("GSTR6-GET");
        gstr.add("GSTR9-AUTOCAL");
        gstr.add("GSTR9-SAVE");
        gstr.add("GSTR9-GET");
        gstr.add("GSTR-LEDGERS");
        gstr.add("GSTR-STATUS");
//        gstr.add("GSR-SAVE");
        return gstr;
    }

    public Set<String> eInvoiceRequests() {
        Set<String> einvoice = new LinkedHashSet<>();
        einvoice.add("AUTHENTICATE");
        einvoice.add("GENERATE IRN");
        einvoice.add("GENERATE EWB");
        einvoice.add("GET IRN");
        einvoice.add("CANCEL IRN");
        return einvoice;
    }

    public Set<String> eWayRequests() {
        Set<String> eway = new LinkedHashSet<>();
        eway.add("AUTHENTICATE");
        eway.add("GENERATE E-WAY BILL");
        eway.add("GET E-WAY BILL");
        eway.add("EXTEND VALIDITY");
        eway.add("VEHICLE-UPDATE");
        eway.add("TRANSPORTER-UPDATE");
        eway.add("EXTEND VALIDITY");
        eway.add("CANCEL E-WAY BILL");
        eway.add("REJECT E-WAY BILL");
        eway.add("MULTI VEHICLE");
        eway.add("GENERATE CONSOLIDATE");
        eway.add("GET CONSOLIDATED BILL");
        eway.add("RECONSOLIDATE BILL");
        eway.add("GET REJECTED BILLS BY OTHERS");
        eway.add("GET BILLS BY DATE");
        eway.add("GET BILLS FOR TRANSPORTER");
        eway.add("GET BILLS FOR TRANSPORTER BY GSTIN");
        eway.add("GET BILLS FOR TRANSPORTER BY STATE");
        return eway;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public Map<String, Map<String, Map<String, List<LogDetail>>>> getProjectwise() {
        return projectwise;
    }

    public void setProjectwise(Map<String, Map<String, Map<String, List<LogDetail>>>> projectwise) {
        this.projectwise = projectwise;
    }

    public Map<String, Map<String, Integer>> getIndCount() {
        return indCount;
    }

    public void setIndCount(Map<String, Map<String, Integer>> indCount) {
        this.indCount = indCount;
    }

}
