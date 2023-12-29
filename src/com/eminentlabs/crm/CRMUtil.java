/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm;

import com.eminentlabs.crm.persistence.ContactWorkHistory;
import com.eminentlabs.crm.persistence.CrmCompanyPlants;
import com.eminentlabs.crm.persistence.CrmCompanySales;
import com.eminentlabs.crm.persistence.CrmCompetitors;
import com.google.gson.Gson;
import org.apache.log4j.Logger;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.concurrent.TimeUnit;
import javax.servlet.http.HttpServletRequest;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Tamilvelan
 */
public class CRMUtil {

    static Logger logger = Logger.getLogger("CRM Util");

    public static int getUnapprovedContacts(int userId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int contactCount = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*) from contact where roleid=0 and assignedto=" + userId);
            while (resultset.next()) {
                contactCount = resultset.getInt(1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return contactCount;
    }

    public static List<ContactBean> getStateCityCompany(String crmType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<ContactBean> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query;
            if (crmType.equalsIgnoreCase("account")) {
                query = "select BILLINGCITY as city,BILLINGSTATE as state,ACCOUNTNAME as company from ACCOUNT where roleid=2 and BILLINGCITY is not null or  BILLINGSTATE is not null";
            } else if (crmType.equalsIgnoreCase("opportunity")) {
                query = "select l.city as city ,l.state as state ,o.OPPORTUNITYNAME as comapny from OPPORTUNITY o,lead l where o.LEAD_REFERENCE=l.leadid and o.roleid=2 and l.city is not null or l.state is not null";
            } else if (crmType.equalsIgnoreCase("lead")) {
                query = "select city,state,company from lead where roleid=2 and city is not null or state is not null";
            } else {
                query = "select MAILINGCITY as city,MAILINGSTATE as state,company from contact where MAILINGSTATE is not null or MAILINGCITY is not null and roleid=2";
            }
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                ContactBean bean = new ContactBean();
                bean.setCity(resultset.getString("city"));
                bean.setCompany(resultset.getString("company"));
                bean.setState(resultset.getString("state"));
                list.add(bean);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    static List<String> getDateTypes() {
        List<String> dateList = new ArrayList();
        dateList.add("On");
        dateList.add("Today");
        dateList.add("After");
        dateList.add("Before");
        dateList.add("Between");
        return dateList;
    }

    static List<String> getRatings() {
        List<String> ratingList = new ArrayList();
        ratingList.add("Hot");
        ratingList.add("Warm");
        ratingList.add("Cold");
        return ratingList;
    }

    static List<String> getInterstedIn() {
        List<String> interestedList = new ArrayList();
        interestedList.add("eTracker");
        interestedList.add("eOutSource");
        interestedList.add("ERPDS");
        return interestedList;
    }

    static List<String> getCrmType() {
        List<String> crmType = new ArrayList();
        crmType.add("Contact");
        crmType.add("Lead");
        crmType.add("Opportunity");
        crmType.add("Account");
        return crmType;
    }

    public static List<String> getCity(String crmType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query;
            if (crmType.equalsIgnoreCase("account")) {
                query = "select distinct(BILLINGCITY) from ACCOUNT where roleid=2 and BILLINGCITY is not null order by BILLINGCITY";
            } else if (crmType.equalsIgnoreCase("opportunity")) {
                query = "select distinct(l.city)  from OPPORTUNITY o,lead l where o.LEAD_REFERENCE=l.leadid and o.roleid=2 and l.city is not null order by l.city ";
            } else if (crmType.equalsIgnoreCase("lead")) {
                query = "select distinct(city) from lead where roleid=2 and city is not null order by city";
            } else {
                query = "select distinct(MAILINGCITY) from contact where roleid=2 and MAILINGCITY is not null order by MAILINGCITY";
            }
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> getState(String crmType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query;
            if (crmType.equalsIgnoreCase("account")) {
                query = "select distinct(BILLINGSTATE) from ACCOUNT where roleid=2 and BILLINGSTATE is not null order by BILLINGSTATE ";
            } else if (crmType.equalsIgnoreCase("opportunity")) {
                query = "select distinct(l.state)  from OPPORTUNITY o,lead l where o.LEAD_REFERENCE=l.leadid and o.roleid=2 and l.state is not null order by l.state";
            } else if (crmType.equalsIgnoreCase("lead")) {
                query = "select distinct(state) from lead where roleid=2 and state is not null order by state";
            } else {
                query = "select distinct(MAILINGSTATE) from contact where roleid=2 and MAILINGSTATE is not null order by MAILINGSTATE";
            }
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                logger.info("State" + resultset.getString(1));
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> getCompany(String crmType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query;
            if (crmType.equalsIgnoreCase("account")) {
                query = "select distinct(ACCOUNTNAME) from ACCOUNT where roleid=2 order by ACCOUNTNAME";
            } else if (crmType.equalsIgnoreCase("opportunity")) {
                query = "select distinct(OPPORTUNITYNAME) from OPPORTUNITY where roleid=2 order by OPPORTUNITYNAME";
            } else if (crmType.equalsIgnoreCase("lead")) {
                query = "select distinct(company) from lead where roleid=2 order by company";
            } else {
                query = "select distinct(company) from contact where roleid=2  and company is not null   order by company";
            }
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> getCRMCreatedUsers(String crmType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        String table = crmType;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select distinct(a." + crmType + "_owner),b.firstname||' '||b.lastname as name from " + table + " a,users b where a." + crmType + "_owner=b.userid and a.roleid=2 order by name ";
            logger.info("QUERY : " + query);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1) + "-" + resultset.getString(2));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> getArea(String crmType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "";
//            if (crmType.equalsIgnoreCase("account")) {
//            } else 
            if (crmType.equalsIgnoreCase("opportunity")) {
                query = "select distinct(l.area)  from OPPORTUNITY o,lead l where o.LEAD_REFERENCE=l.leadid and o.roleid=2 and l.area is not null order by l.area ";
            } else if (crmType.equalsIgnoreCase("lead")) {
                query = "select distinct(area) from lead where roleid=2 and area is not null order by area";
            } else {
                query = "select distinct(MAILINGAREA) from contact where roleid=2 and MAILINGAREA is not null order by MAILINGAREA";
            }
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> getCRMAssignedUsers(String crmType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
//        String table =crmType;
//        try {
//            connection = MakeConnection.getConnection();
//            statement = connection.createStatement();
//            String query ="select distinct(a."+crmType+"_owner),b.firstname||' '||b.lastname as name from "+table+" a,users b where a."+crmType+"_owner=b.userid and a.roleid=2 order by name ";
//            logger.info("QUERY : "+query);
//            resultset = statement.executeQuery(query);
//            while (resultset.next()) {                
//                list.add(resultset.getString(1)+"-"+resultset.getString(2));
//            }
//        } catch (Exception e) {
//            logger.error(e.getMessage());
//        } finally {
//            try {
//
//                if (resultset != null) {
//                    resultset.close();
//                }
//                if (statement != null) {
//                    statement.close();
//                }
//                if (connection != null) {
//                    connection.close();
//                }
//            } catch (Exception ex) {
//                logger.error(ex.getMessage());
//            }
//        }
        return list;
    }

    public static Map<Integer, String> getIndustry() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<Integer, String> map = new HashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select INDUSTRY_ID,INDUSTRY from CRM_INDUSTRY order by INDUSTRY asc");
            while (resultset.next()) {
                map.put(resultset.getInt(1), resultset.getString(2));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return map;
    }

    public static int getIndustry(String industry) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int industryId = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select INDUSTRY_ID from CRM_INDUSTRY where INDUSTRY='" + industry + "'");
            industryId = resultset.getInt(1);
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return industryId;
    }

    public static List<String> getVendors(String crmType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query;
            if (crmType.equalsIgnoreCase("lead")) {
                query = "select distinct(vendor) from lead where vendor is not null and roleid=2 order by vendor";
            } else {
                query = "select distinct(vendor) from contact where vendor is not null and roleid=2 order by vendor";
            }
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> getCountry(String crmType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "";
//            if (crmType.equalsIgnoreCase("account")) {
//            } else 
            if (crmType.equalsIgnoreCase("opportunity")) {
                query = "select distinct(l.COUNTRY)  from OPPORTUNITY o,lead l where o.LEAD_REFERENCE=l.leadid and o.roleid=2 and l.COUNTRY is not null order by l.COUNTRY ";
            } else if (crmType.equalsIgnoreCase("lead")) {
                query = "select distinct(COUNTRY) from lead where COUNTRY is not null and roleid=2 order by COUNTRY";
            } else {
                query = "select distinct(mailingcountry) from contact where mailingcountry is not null and roleid=2 order by mailingcountry";
            }
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> getDepartments(String crmType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "";
//            if (crmType.equalsIgnoreCase("account")) {
//            } else 
            if (crmType.equalsIgnoreCase("opportunity")) {
                query = "select distinct(l.COUNTRY)  from OPPORTUNITY o,lead l where o.LEAD_REFERENCE=l.leadid and o.roleid=2 and l.COUNTRY is not null order by l.COUNTRY ";
            } else if (crmType.equalsIgnoreCase("lead")) {
                query = "select distinct(COUNTRY) from lead where COUNTRY is not null and roleid=2 order by COUNTRY";
            } else {
                query = "select distinct(department) from contact where department is not null and roleid=2 order by department";
            }
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> contactType() {
        List<String> contactType = new ArrayList<String>();
        contactType.add("Normal");
        contactType.add("Influencer");
        contactType.add("Decision Maker");
        return contactType;
    }

    public static List<String> getCompany() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select d.company from (select distinct(company) as company from CONTACT_WORK_HISTORY union (select distinct(COMPETITOR)as company  from CRM_COMPETITORS) )d order by company";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> getRoles() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select distinct(role) from CONTACT_WORK_HISTORY order by role";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<Integer> getYears() {
        List<Integer> years = new ArrayList<Integer>();
        int year = Calendar.getInstance().get(Calendar.YEAR);
        years.add(year);
        for (int i = 0; i <= 40; i++) {
            years.add(--year);
        }
        return years;
    }

    public static List<ContactWorkHistory> getContactWorkHistory(Connection connection, int contactid) {
        Statement statement = null;
        ResultSet resultset = null;
        List<ContactWorkHistory> cwhs = new ArrayList();
        try {
            statement = connection.createStatement();
            resultset = statement.executeQuery("select * from Contact_Work_History where contactid=" + contactid + " order by CON_WORK_ID");
            while (resultset.next()) {
                ContactWorkHistory cwh = new ContactWorkHistory();
                cwh.setCompany(resultset.getString("COMPANY"));
                cwh.setFromYear(resultset.getInt("FROM_YEAR"));
                cwh.setToYear(resultset.getInt("TO_YEAR"));
                cwh.setRole(resultset.getString("ROLE"));
                cwhs.add(cwh);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return cwhs;
    }

    public static List<ContactWorkHistory> getLeadWorkHistory(Connection connection, int leadid) {
        Statement statement = null;
        ResultSet resultset = null;
        List<ContactWorkHistory> cwhs = new ArrayList();
        try {
            statement = connection.createStatement();
            resultset = statement.executeQuery("select * from Contact_Work_History where leadid=" + leadid + " order by CON_WORK_ID");
            while (resultset.next()) {
                ContactWorkHistory cwh = new ContactWorkHistory();
                cwh.setCompany(resultset.getString("COMPANY"));
                cwh.setFromYear(resultset.getInt("FROM_YEAR"));
                cwh.setToYear(resultset.getInt("TO_YEAR"));
                cwh.setRole(resultset.getString("ROLE"));
                cwhs.add(cwh);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return cwhs;
    }

    public static String getDecisionMaker(Connection connection, String company) {
        Statement statement = null;
        ResultSet resultset = null;
        String decisionMaker = "";
        try {
            statement = connection.createStatement();
            String query = "select contactid,FIRSTNAME,LASTNAME from CONTACT where contact_type='Decision Maker' and company='" + company + "'";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                decisionMaker = resultset.getInt(1) + "-" + resultset.getString(2) + " " + resultset.getString(3);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return decisionMaker;
    }

    public static String getDecisionMakerLead(Connection connection, String company) {
        Statement statement = null;
        ResultSet resultset = null;
        String decisionMaker = "";
        try {
            statement = connection.createStatement();
            String query = "select leadid,FIRSTNAME,LASTNAME from lead where lead_type='Decision Maker' and company='" + company + "'";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                decisionMaker = resultset.getInt(1) + "-" + resultset.getString(2) + " " + resultset.getString(3);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return decisionMaker;
    }

    public static List<CrmCompetitors> getCompetitors(Connection connection, String company) {
        Statement statement = null;
        ResultSet resultset = null;
        List<CrmCompetitors> cwhs = new ArrayList();
        try {
            statement = connection.createStatement();
            resultset = statement.executeQuery("select * from CRM_COMPETITORS where COMPANY='" + company + "' order by COMPETITOR_ID");
            while (resultset.next()) {
                CrmCompetitors cwh = new CrmCompetitors();
                cwh.setCompetitor(resultset.getString("COMPETITOR"));
                cwh.setCity(resultset.getString("CITY"));
                cwh.setState(resultset.getString("STATE"));
                cwh.setCountry(resultset.getString("COUNTRY"));
                cwhs.add(cwh);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return cwhs;
    }

    public static List<CrmCompanySales> getCompanySales(Connection connection, String company) {
        Statement statement = null;
        ResultSet resultset = null;
        List<CrmCompanySales> cwhs = new ArrayList();
        try {
            statement = connection.createStatement();
            resultset = statement.executeQuery("select * from CRM_COMPANY_SALES where COMPANY='" + company + "' order by SALES_ID");
            while (resultset.next()) {
                CrmCompanySales cwh = new CrmCompanySales();
                cwh.setSalesYear(resultset.getInt("SALES_YEAR"));
                cwh.setSales(resultset.getLong("SALES"));
                cwh.setEmployees(resultset.getInt("EMPLOYEES"));
                cwh.setItSpend(resultset.getLong("IT_SPEND"));
                cwh.setErpSpend(resultset.getLong("ERP_SPEND"));
                cwh.setCurrency(resultset.getString("CURRENCY"));
                cwhs.add(cwh);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return cwhs;
    }

    public static List<CrmCompanyPlants> getCompanyPlants(Connection connection, String company) {
        Statement statement = null;
        ResultSet resultset = null;
        List<CrmCompanyPlants> cwhs = new ArrayList();
        try {
            statement = connection.createStatement();
            resultset = statement.executeQuery("select * from CRM_COMPANY_PLANTS where COMPANY='" + company + "' order by PLANT_ID");
            while (resultset.next()) {
                CrmCompanyPlants cwh = new CrmCompanyPlants();
                cwh.setPlantId(resultset.getLong("PLANT_ID"));
                cwh.setPlantArea(resultset.getString("PLANT_AREA"));
                cwh.setPlantCity(resultset.getString("PLANT_CITY"));
                cwh.setPlantState(resultset.getString("PLANT_STATE"));
                cwh.setPlantCountry(resultset.getString("PLANT_COUNTRY"));
                cwhs.add(cwh);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return cwhs;
    }

    public static List<String> getAllCities() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select d.city from(select distinct(MAILINGCITY) as city  from contact where roleid=2 and MAILINGCITY is not null union (select distinct(city)as city from CRM_COMPETITORS) )d order by d.city";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> getAllStates() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select d.state from(select distinct(MAILINGSTATE) as state from contact where roleid=2 and MAILINGSTATE is not null union (select distinct(state)as state from CRM_COMPETITORS) )d order by d.state";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> getAllCountries() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> list = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select d.COUNTRY from(select distinct(MAILINGCOUNTRY) as COUNTRY from contact where roleid=2 and MAILINGCOUNTRY is not null union (select distinct(COUNTRY)as COUNTRY from CRM_COMPETITORS) )d order by d.COUNTRY";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public static List<String> currencyTypes() {
        List<String> currencyType = new ArrayList<String>();
        currencyType.add("INR");
        currencyType.add("USD");
        currencyType.add("EUR");
        currencyType.add("GBP");
        currencyType.add("JPY");
        currencyType.add("CHF");
        currencyType.add("CAD");
        currencyType.add("AUD");
        currencyType.add("NZD");
        currencyType.add("ZAR");
        return currencyType;
    }

    public static Set<String> getCompetitorByIndustry(Connection connection, String company, int industryid) {
        Statement statement = null;
        ResultSet resultset = null;
        Set<String> list = new TreeSet<String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select distinct(company) from contact where industry = " + industryid + " union select distinct(company) from lead where industry =" + industryid + " union select distinct(COMPETITOR)  from CRM_COMPETITORS where COMPANY='" + company + "'";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }
            query = "select distinct(competitor) as company from CRM_COMPETITORS where company in (select distinct(company) from contact where industry = " + industryid + " union select distinct(company) from lead where industry =" + industryid + " union select distinct(COMPETITOR)  from CRM_COMPETITORS where COMPANY='" + company + "') ";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                list.add(resultset.getString(1));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return list;
    }

    public String getAddressByCompany(HttpServletRequest request) {
        String ajaxResponse = null;
        String company = request.getParameter("company");
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<String, String> address = new HashMap<String, String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select mailingcity,mailingstate,mailingcountry from contact where company='" + company + "'";
            resultset = statement.executeQuery(query);
            if (resultset.next()) {
                address.put("city", resultset.getString(1));
                address.put("state", resultset.getString(2));
                address.put("country", resultset.getString(3));
            }

            if (address.isEmpty()) {
                query = "select city,state,country from lead where company='" + company + "'";
                resultset = statement.executeQuery(query);
                if (resultset.next()) {
                    address.put("city", resultset.getString(1));
                    address.put("state", resultset.getString(2));
                    address.put("country", resultset.getString(3));
                }
            }

            if (address.isEmpty()) {
                query = "select city,state,country from CRM_COMPETITORS where COMPETITOR='" + company + "'";
                resultset = statement.executeQuery(query);
                while (resultset.next()) {
                    address.put("city", resultset.getString(1));
                    address.put("state", resultset.getString(2));
                    address.put("country", resultset.getString(3));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
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
                logger.error(ex.getMessage());
            }
        }
        ajaxResponse = new Gson().toJson(address);
        return ajaxResponse;

    }

    public Map<String, List<CRMSearchBean>> getAllBycompany(HttpServletRequest request) {
        Map<String, List<CRMSearchBean>> map = new HashMap();
        String company = request.getParameter("company").trim();
        String state = request.getParameter("state").trim();
        String industry = request.getParameter("industry").trim();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<CRMSearchBean> contact = new ArrayList<CRMSearchBean>();
        List<CRMSearchBean> lead = new ArrayList<CRMSearchBean>();
        List<CRMSearchBean> opportunity = new ArrayList<CRMSearchBean>();

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
            Date date = new Date();
            Date createdon;
            date = sdf.parse(sdf.format(date));
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String querya = "";
            if (!company.equals("")) {
                querya = " and a.company='" + company + "'";
            } else {
                if (state != null && !"YET TO UPDATE".equals(state)) {
                    querya = querya + " and a.MAILINGSTATE = '" + state + "'";
                } else {
                    querya = querya + " and a.MAILINGSTATE is null";
                }
                if (industry != null && !"YET TO UPDATE".equals(industry)) {
                    querya += " and a.industry in (select industry_id from crm_industry where industry like '%" + industry + "%')";
                } else {
                    querya = querya + " and a.industry is null";
                }
            }
            String query = "select distinct(a.CONTACTID) as id,a.firstname||' '||a.lastname as name,a.title as title,c.firstname||' '||c.lastname as ownerName,	d.firstname||' '||d.lastname as assignedtoName,a.ACCOUNTNAME as accountName,	a.phone as phone,a.email as email,	a.DUEDATE as duedate,	a.createdon as createdon,industry,contact_type from CONTACT a left join CONTACT_COMMENTS b on a.contactid = b.contactid ,users c,users d where c.userid = a.CONTACT_OWNER and d.userid = a.assignedto and a.roleid=2 ";
            query = query + querya;
            System.out.println("query contact"+query);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                CRMSearchBean bean = new CRMSearchBean();
                bean.setId(resultset.getString("id"));
                bean.setContactType(resultset.getString("contact_type"));
                bean.setAccountName(resultset.getString("accountName"));
                bean.setName(resultset.getString("name"));
                bean.setTitle(resultset.getString("title"));
                bean.setPhone(resultset.getString("phone"));
                bean.setEmail(resultset.getString("email"));
                bean.setOwnerName(resultset.getString("ownerName"));
                bean.setDuedate(resultset.getDate("duedate") == null ? "" : sdf.format(resultset.getDate("duedate")));
                bean.setAssingedTo(resultset.getString("assignedtoName"));
                createdon = sdf.parse(sdf.format(resultset.getDate("createdon")));
                long diff = date.getTime() - createdon.getTime();
                String days = String.valueOf(TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) + 1);
                bean.setAge(days);
                contact.add(bean);
            }
            map.put("contact", contact);
            query = "select distinct(a.LEADID) as id,a.firstname||' '||a.lastname as name,a.title as title,c.firstname||' '||c.lastname as ownerName,d.firstname||' '||d.lastname as assignedtoName ,a.phone as phone,a.email as email,a.DUEDATE as duedate,	a.createdon as createdon,a.rating as rating,a.LEADSTATUS as status,a.modifiedon as modifiedon,a.company as company,lead_type from lead a left join LEAD_COMMENTS b on a.leadid = b.leadid ,users c,users d where c.userid = a.LEAD_OWNER and d.userid = a.assignedto and a.roleid=2 ";

            querya = "";
            if (!company.equals("")) {
                querya = " and a.company='" + company + "'";
            } else {
                if (state != null && !"YET TO UPDATE".equals(state)) {
                    querya = querya + " and a.state = '" + state + "'";
                } else {
                    querya = querya + " and a.state is null";
                }
                if (industry != null && !"YET TO UPDATE".equals(industry)) {
                    querya += " and a.industry in (select industry_id from crm_industry where industry like '%" + industry + "%')";
                } else {
                    querya = querya + " and a.industry is null";
                }
            }
            query = query + querya;
            System.out.println("query lead"+query);

            resultset = statement.executeQuery(query);

            while (resultset.next()) {
                CRMSearchBean bean = new CRMSearchBean();
                bean.setId(resultset.getString("id"));
                bean.setContactType(resultset.getString("lead_type"));
                bean.setCompany(resultset.getString("COMPANY"));
                bean.setModifiedon(sdf.format(resultset.getDate("MODIFIEDON")));
                bean.setRating(resultset.getString("RATING"));
                bean.setStatus(resultset.getString("STATUS"));
                bean.setName(resultset.getString("name"));
                bean.setTitle(resultset.getString("title"));
                bean.setPhone(resultset.getString("phone"));
                bean.setEmail(resultset.getString("email"));
                bean.setOwnerName(resultset.getString("ownerName"));
                bean.setDuedate(resultset.getDate("duedate") == null ? "" : sdf.format(resultset.getDate("duedate")));
                bean.setAssingedTo(resultset.getString("assignedtoName"));
                createdon = sdf.parse(sdf.format(resultset.getDate("createdon")));
                long diff = date.getTime() - createdon.getTime();
                String days = String.valueOf(TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) + 1);
                bean.setAge(days);
                lead.add(bean);
            }
            map.put("lead", lead);
            query = "SELECT distinct(a.OPPORTUNITYID) as id ,a.OPPORTUNITYNAME as name, c.firstname||' '||c.lastname as assignedtoName , a.CLOSE_DATE as duedate,a.STAGE as status,a.PROBABILITY as prob,a.MODIFIEDON as modifiedon from opportunity a left join OPPORTUNITY_COMMENTS b on a.OPPORTUNITYID=b.OPPORTUNITYID,users c,LEAD l where a.LEAD_REFERENCE=l.leadid and c.userid = a.assignedto and a.roleid=2  ";
             querya = "";
            if (!company.equals("")) {
                querya = "  and a.OPPORTUNITYNAME='" + company + "'";
            } else {
                if (state != null && !"YET TO UPDATE".equals(state)) {
                    querya = querya + " and l.state = '" + state + "'";
                } else {
                    querya = querya + " and l.state is null";
                }
                if (industry != null && !"YET TO UPDATE".equals(industry)) {
                    querya += " and l.industry in (select industry_id from crm_industry where industry like '%" + industry + "%')";
                } else {
                    querya = querya + " and l.industry is null";
                }
            }
            query = query + querya;
                        System.out.println("query oppor"+query);

            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                CRMSearchBean bean = new CRMSearchBean();
                bean.setId(resultset.getString("id"));
                bean.setName(resultset.getString("name"));
                bean.setAssingedTo(resultset.getString("assignedtoName"));
                bean.setProbability(resultset.getString("prob"));
                bean.setDuedate(resultset.getDate("duedate") == null ? "" : sdf.format(resultset.getDate("duedate")));
                bean.setModifiedon(sdf.format(resultset.getDate("MODIFIEDON")));
                bean.setStatus(resultset.getString("STATUS"));
                opportunity.add(bean);
            }
            map.put("opportunity", opportunity);

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
                logger.error(ex.getMessage());
            }
        }
        return map;
    }

}
