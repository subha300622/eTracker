/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm;

import static com.eminentlabs.crm.CRMUtil.logger;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class CRMAnalysis {

    Map<String, Integer> statewise;
    Map<String, Integer> industrywise;
    List<CRMAnalysisBean> analysisBeans;
    Map<String, Map<String, Integer>> crmAnalysis;

    public void getAll(HttpServletRequest request) {
        crmAnalysis = new LinkedHashMap();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        statewise = new LinkedHashMap();
        industrywise = new LinkedHashMap();
        analysisBeans = new ArrayList();
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select sum(counta) as count,industry from  crm_analysis group by industry order by count desc";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                industrywise.put(resultset.getString(2), resultset.getInt(1));
            }
            query = "select sum(counta) as count,state from  crm_analysis group by state order by count desc";
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                statewise.put(resultset.getString(2), resultset.getInt(1));
            }
            query = "select * from crm_analysis";
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
                for (String industry : industrywise.keySet()) {
                    for (CRMAnalysisBean bean : analysisBeans) {
                        if (bean.getState().equals(state) && bean.getIndustry().equals(industry)) {
                                m.put(bean.getIndustry(), bean.getCount());
                            }
                    }
                }
                crmAnalysis.put(state, m);
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

    public Map<String, Integer> getIndustrywise() {
        return industrywise;
    }

    public void setIndustrywise(Map<String, Integer> industrywise) {
        this.industrywise = industrywise;
    }

    public List<CRMAnalysisBean> getAnalysisBeans() {
        return analysisBeans;
    }

    public void setAnalysisBeans(List<CRMAnalysisBean> analysisBeans) {
        this.analysisBeans = analysisBeans;
    }

    public Map<String, Map<String, Integer>> getCrmAnalysis() {
        return crmAnalysis;
    }

    public void setCrmAnalysis(Map<String, Map<String, Integer>> crmAnalysis) {
        this.crmAnalysis = crmAnalysis;
    }

}
