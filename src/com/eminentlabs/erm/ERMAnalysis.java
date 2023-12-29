/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminentlabs.crm.CRMAnalysisBean;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class ERMAnalysis {

    static Logger logger = Logger.getLogger("ERMAnalysis");
    Map<String, Integer> statewise;
    Map<String, Integer> skillwise;
    Map<String, Map<String, Integer>> ermAnalysis;

    public void getAll(HttpServletRequest request) {
        ermAnalysis = new LinkedHashMap();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        statewise = new LinkedHashMap();
        skillwise = new LinkedHashMap();
        List<CRMAnalysisBean> analysisBeans = new ArrayList();

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select sum(count) as count,skills from  erm_analysis group by skills order by count desc";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                skillwise.put(resultset.getString(2), resultset.getInt(1));
            }
            query = "select sum(count) as count,location from  erm_analysis group by location order by count desc";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                statewise.put(resultset.getString(2), resultset.getInt(1));
            }
            query = "select * from erm_analysis";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                CRMAnalysisBean bean = new CRMAnalysisBean();
                bean.setCount(resultset.getInt(1));
                bean.setState(resultset.getString(2));
                bean.setIndustry(resultset.getString(3));
                analysisBeans.add(bean);
            }
            for (String state : statewise.keySet()) {
                Map<String, Integer> m = new LinkedHashMap<>();
                for (String skill : skillwise.keySet()) {
                    for (CRMAnalysisBean bean : analysisBeans) {
                        if (bean.getState().equals(state) && bean.getIndustry().equals(skill)) {
                            m.put(bean.getIndustry(), bean.getCount());
                        }
                    }
                }
                ermAnalysis.put(state, m);
            }

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
    }

    public void getAllDetail(HttpServletRequest request) {
        ermAnalysis = new LinkedHashMap();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        statewise = new LinkedHashMap();
        skillwise = new LinkedHashMap();
        List<CRMAnalysisBean> analysisBeans = new ArrayList();

        try {
            String location = request.getParameter("location");
            String module = request.getParameter("module");

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select count(*) as count,CURRENT_EMPLOYER from ERM_CURRENT_EMPLOYER_PROJECT where APPLICANT_ID in (select APPLICANT_ID from ERM_APPLICANT where UPPER(CURRENT_LOCATION) ='"+location+"' and UPPER(AREA_OF_EXPERTISE)='"+module+"') group by CURRENT_EMPLOYER order by count desc";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                skillwise.put(resultset.getString(2), resultset.getInt(1));
            }
            query = "select count(*) as count,CLIENT from ERM_CURRENT_EMPLOYER_PROJECT where APPLICANT_ID in (select APPLICANT_ID from ERM_APPLICANT where UPPER(CURRENT_LOCATION) ='"+location+"' and UPPER(AREA_OF_EXPERTISE)='"+module+"') group by CLIENT order by count desc";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                statewise.put(resultset.getString(2), resultset.getInt(1));
            }
            query = "select count(*) as count,CLIENT,CURRENT_EMPLOYER from ERM_CURRENT_EMPLOYER_PROJECT where APPLICANT_ID in (select APPLICANT_ID from ERM_APPLICANT where UPPER(CURRENT_LOCATION) ='"+location+"' and UPPER(AREA_OF_EXPERTISE)='"+module+"') group by CLIENT,CURRENT_EMPLOYER order by count desc";
            System.out.println("query : "+query);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                CRMAnalysisBean bean = new CRMAnalysisBean();
                bean.setCount(resultset.getInt(1));
                bean.setState(resultset.getString(2));
                bean.setIndustry(resultset.getString(3));
                analysisBeans.add(bean);
            }
            for (String state : statewise.keySet()) {
                Map<String, Integer> m = new LinkedHashMap<>();
                for (String skill : skillwise.keySet()) {
                    for (CRMAnalysisBean bean : analysisBeans) {
                        if (bean.getState().equals(state) && bean.getIndustry().equals(skill)) {
                            m.put(bean.getIndustry(), bean.getCount());
                        }
                    }
                }
                ermAnalysis.put(state, m);
            }

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
    }

    public Map<String, Integer> getStatewise() {
        return statewise;
    }

    public void setStatewise(Map<String, Integer> statewise) {
        this.statewise = statewise;
    }

    public Map<String, Integer> getSkillwise() {
        return skillwise;
    }

    public void setSkillwise(Map<String, Integer> skillwise) {
        this.skillwise = skillwise;
    }

    public Map<String, Map<String, Integer>> getErmAnalysis() {
        return ermAnalysis;
    }

    public void setErmAnalysis(Map<String, Map<String, Integer>> ermAnalysis) {
        this.ermAnalysis = ermAnalysis;
    }

}
