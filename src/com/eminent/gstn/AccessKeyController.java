/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.gstn;

import com.eminent.leaveUtil.LeaveUtil;
import com.eminentlabs.mom.JsonOb;
import com.google.gson.Gson;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.TreeMap;
import javax.servlet.http.HttpServletRequest;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class AccessKeyController {

    private String message;
    List<AccessKey> accessKeys = null;
    private String project, server, startDate, endDate = "";
    List<String> accessTypes = new ArrayList<>();
    List<Log> logList = new ArrayList<>();
    Set<String> uniqueInvoice = new HashSet<>();
    Map<String, Integer> categoryWise = new TreeMap<>();

    public void setAll(HttpServletRequest request) {
        Connection connection = null;
        CallableStatement statement = null;
        try {
            project = request.getParameter("projectName");
            server = request.getParameter("server");
            String accessId = request.getParameter("accessId");
            if (project != null && server != null && request.getMethod().equalsIgnoreCase("get")) {
                List<AccessKey> accesss = getByProject(project, server);
                for (AccessKey ak : accesss) {
                    accessTypes.add(ak.getAccessType());
                }
            }
            if (accessId != null) {
                AccessKey accessKey = getById(Integer.parseInt(accessId));
                project = accessKey.getProjectName();
                server = accessKey.getServerType();
                accessTypes.add(accessKey.getAccessType());
            }

            if (request.getMethod().equalsIgnoreCase("post")) {
                String types[] = request.getParameterValues("type");
                connection = MakeConnection.getESPLASPConnection();
                Calendar cal = Calendar.getInstance();
                for (String type : types) {
                    statement = connection.prepareCall("{call access_key_sp(?,?,?,?,?,?)}");
                    statement.setString(1, project);
                    statement.setString(2, type);
                    statement.setString(3, generateRandomValue());
                    cal.add(Calendar.MONTH, 3);
                    statement.setDate(4, new java.sql.Date(cal.getTime().getTime()));
                    cal = Calendar.getInstance();
                    statement.setTimestamp(5, new java.sql.Timestamp(cal.getTime().getTime()));
                    statement.setString(6, server);
                    statement.executeUpdate();
                }
                message = "Access key maintained successfully";
                project = null;
            }

        } catch (Exception e) {
            message = "An error occured." + e.getMessage();
            e.printStackTrace();
        } finally {
            try {

                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                message = "An error occured." + ex.getMessage();
                ex.printStackTrace();
            }
        }

        accessKeys = getAll();
    }

    private List<AccessKey> getAll() {
        List<AccessKey> list = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            connection = MakeConnection.getESPLASPConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select * from access_key");
            while (resultset.next()) {
                AccessKey ak = new AccessKey();
                ak.setKeyId(resultset.getInt(1));
                ak.setProjectName(resultset.getString(2));
                ak.setServerType(resultset.getString(3));
                ak.setAccessType(resultset.getString(4));
                ak.setAccessKey(resultset.getString(5));
                ak.setExpiryDate(resultset.getDate(6));
                ak.setChangedOn(resultset.getTimestamp(7));
                list.add(ak);
            }
        } catch (Exception e) {
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

    public List<AccessKey> getExpirySoon() {
        List<AccessKey> list = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            connection = MakeConnection.getESPLASPConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("SELECT * from access_key WHERE servertype='Producation' and ExpiryDate <= NOW() + INTERVAL 5 DAY ORDER BY projectname;");
            while (resultset.next()) {
                AccessKey ak = new AccessKey();
                ak.setKeyId(resultset.getInt(1));
                ak.setProjectName(resultset.getString(2));
                ak.setServerType(resultset.getString(3));
                ak.setAccessType(resultset.getString(4));
                ak.setAccessKey(resultset.getString(5));
                ak.setExpiryDate(resultset.getDate(6));
                ak.setChangedOn(resultset.getTimestamp(7));
                list.add(ak);
            }
        } catch (Exception e) {
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

    private List<AccessKey> getByProject(String projectName, String server) {
        List<AccessKey> list = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            connection = MakeConnection.getESPLASPConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select * from access_key where ProjectName='" + projectName + "' and ServerType='" + server + "'");
            while (resultset.next()) {
                AccessKey ak = new AccessKey();
                ak.setKeyId(resultset.getInt(1));
                ak.setProjectName(resultset.getString(2));
                ak.setServerType(resultset.getString(3));
                ak.setAccessType(resultset.getString(4));
                ak.setAccessKey(resultset.getString(5));
                ak.setExpiryDate(resultset.getDate(6));
                ak.setChangedOn(resultset.getTimestamp(7));
                list.add(ak);
            }
        } catch (Exception e) {
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

    private AccessKey getById(Integer id) {
        AccessKey ak = new AccessKey();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            connection = MakeConnection.getESPLASPConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select * from access_key where KeyId=" + id + "");
            while (resultset.next()) {
                ak.setKeyId(resultset.getInt(1));
                ak.setProjectName(resultset.getString(2));
                ak.setServerType(resultset.getString(3));
                ak.setAccessType(resultset.getString(4));
                ak.setAccessKey(resultset.getString(5));
                ak.setExpiryDate(resultset.getDate(6));
            }
        } catch (Exception e) {
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
        return ak;
    }

    public List<String> getAccessType() {
        List<String> list = new ArrayList<>();
        list.add("e-Invoice");
        list.add("e-Way");
        list.add("GSTR");
        return list;
    }

    public List<String> getServerType() {
        List<String> list = new ArrayList<>();
        list.add("Sandbox");
        list.add("Producation");
        return list;
    }

    public String generateRandomValue() {
        final String alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        final String numeric = "0123456789";

        final int N = alphabet.length();
        final int m = numeric.length();
        String result = null;
        Random r = new Random();
        StringBuffer sb = new StringBuffer();
        try {
            for (int i = 0; i < 20; i++) {
                sb.append((char) (int) alphabet.charAt(r.nextInt(N)));
            }
            for (int i = 0; i < 5; i++) {
                sb.append((char) (int) numeric.charAt(r.nextInt(m)));
            }
            result = "Eminent" + new String(sb);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<String> getEInvoicingproject() {
        List<String> list = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connection = MakeConnection.getESPLASPConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultSet = statement.executeQuery("SELECT ProjectName FROM access_key WHERE servertype='Producation' AND  AccessType='e-Invoice' order BY ProjectName");
            while (resultSet.next()) {
                list.add(resultSet.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
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

    public void getEInvoicingCount(HttpServletRequest request) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        DateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        DateFormat sdfa = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        try {
            project = request.getParameter("projectName");
            startDate = request.getParameter("startDate");
            if (project == null) {
                project = "Halonix CIP:1.0";
            }
            if (startDate == null) {
                startDate = sdf.format(cal.getTime());
            }

            connection = MakeConnection.getESPLASPConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "SELECT g.GSTIN,g.Category,g.RequestTime,g.ResponseTime,g.RequestJson,g.ResponseJson,JSON_EXTRACT(g.RequestJson, \"$.DocDtls.No\") as invoice FROM gstn_log g where Project ='" + project + "' AND DATE(RequestTime)=DATE('" + sdfa.format(sdf.parse(startDate)) + "') AND  AccessType='e-Invoice'";
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                Log ld = new Log();
                ld.setGstin(resultSet.getString("GSTIN"));
                ld.setCategory(resultSet.getString("Category"));
                ld.setRequestTime(resultSet.getString("RequestTime"));
                ld.setResponseTime(resultSet.getString("ResponseTime")); 
                ld.setRequestJson(resultSet.getString("RequestJson"));
                ld.setResponseJson(resultSet.getString("ResponseJson"));
                ld.setInvoice(resultSet.getString("invoice"));
                uniqueInvoice.add(ld.getInvoice());
                logList.add(ld);
                if (categoryWise.containsKey(ld.getCategory())) {
                    categoryWise.put(ld.getCategory(), categoryWise.get(ld.getCategory()) + 1);
                } else {
                    categoryWise.put(ld.getCategory(), 1);

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
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

    public String getEInvoicingcalender(HttpServletRequest request) {
        String ajaxResponse = "";
        List<JsonOb> list = new ArrayList<JsonOb>();
        Connection connection = null;
        Statement statement = null;

        ResultSet resultSet = null;
        try {
            project = request.getParameter("project");
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            String start = request.getParameter("start");
            String end = request.getParameter("end");
            SimpleDateFormat sdb = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sda = new SimpleDateFormat("yyyy-MM");
            String query = "";
            Date current = new Date();
            if (project == null) {
                project = "Halonix CIP:1.0";
            }
            if (end != null) {
                if (sdb.parse(end).after(current)) {
                    toDate = sdb.format(new Date());
                } else {
                    toDate = end;
                }
            } else {
                toDate = sdb.format(new Date());
            }
            System.out.println("start : " + start);
            System.out.println("toDate : " + toDate);

            if (start != null) {
                fromDate = start;
            } else {
                fromDate = sda.format(sdb.parse(toDate)) + "-01";
            }
            System.out.println("fromDate : " + fromDate);
            connection = MakeConnection.getESPLASPConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (project.equalsIgnoreCase("Select All")) {
                query = "SELECT DATE(RequestTime),g.Category,COUNT(*)  FROM gstn_log g where  DATE(RequestTime)  Between DATE('" + fromDate + "') and DATE('" + toDate + "') AND  AccessType='e-Invoice' \n" + "GROUP BY DATE(RequestTime),g.Category";
            } else {
                query = "SELECT DATE(RequestTime),g.Category,COUNT(*)  FROM gstn_log g where Project ='" + project + "' AND DATE(RequestTime)  Between DATE('" + fromDate + "') and DATE('" + toDate + "') AND  AccessType='e-Invoice' \n" + "GROUP BY DATE(RequestTime),g.Category";

            }
            resultSet = statement.executeQuery(query);
            System.out.println("query : " + query);
            while (resultSet.next()) {
                Log l = new Log();
                l.setRequestTime(resultSet.getString(1));
                l.setCategory(resultSet.getString(2));
                l.setInvoice(resultSet.getString(3));
                logList.add(l);

            }
            Map<String, String> calenderCount = new HashMap<>();
            for (Log l : logList) {
                if (calenderCount.containsKey(l.getRequestTime())) {
                    calenderCount.put(l.getRequestTime(), calenderCount.get(l.getRequestTime()) + "<br>" + l.getCategory() + "-" + l.getInvoice());
                } else {
                    calenderCount.put(l.getRequestTime(), l.getCategory() + "-" + l.getInvoice());
                }
            }
            for (Map.Entry<String, String> entry : calenderCount.entrySet()) {
                JsonOb cal = new JsonOb();
                cal.setStart(entry.getKey());
                cal.setTitle(entry.getValue());
                list.add(cal);
            }

            ajaxResponse = new Gson().toJson(list);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
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
        return ajaxResponse;

    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<AccessKey> getAccessKeys() {
        return accessKeys;
    }

    public void setAccessKeys(List<AccessKey> accessKeys) {
        this.accessKeys = accessKeys;
    }

    public String getProject() {
        return project;
    }

    public void setProject(String project) {
        this.project = project;
    }

    public List<String> getAccessTypes() {
        return accessTypes;
    }

    public void setAccessTypes(List<String> accessTypes) {
        this.accessTypes = accessTypes;
    }

    public String getServer() {
        return server;
    }

    public void setServer(String server) {
        this.server = server;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public List<Log> getLogList() {
        return logList;
    }

    public void setLogList(List<Log> logList) {
        this.logList = logList;
    }

    public Map<String, Integer> getCategoryWise() {
        return categoryWise;
    }

    public void setCategoryWise(Map<String, Integer> categoryWise) {
        this.categoryWise = categoryWise;
    }

    public Set<String> getUniqueInvoice() {
        return uniqueInvoice;
    }

    public void setUniqueInvoice(Set<String> uniqueInvoice) {
        this.uniqueInvoice = uniqueInvoice;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

}
