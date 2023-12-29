/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author E0288
 */
public class ERMEditView {

    static org.apache.log4j.Logger logger = null;

    static {
        logger = org.apache.log4j.Logger.getLogger("ERMEditView");
    }
    private String queryString;
    private String skill;
    private String module;
    private String status;
    private String refBy;
    private String ug;
    private String ugYear;
    private String pg;
    private String pgYear;
    private String location;
    private String tExp;
    private String sExp;
    private String updatedBy;
    private String assignedTo;
    private String ctc;
    private String per;
    private String updatedParam;
    private String updatedOn;
    private String updatedFrom;
    private String updatedTo;
    private String upercentage;
    private ERMSearch eRMSearch=new ERMSearch();        
    public ERMSearch convertQueryToObject(HttpServletRequest request) {
        
        String qId=request.getParameter("queryId");
        long queryId=Long.valueOf(qId);
        MyQuery myQuery = ERMUtil.findByQueryId(queryId);
        String qryToSplit = "";
        String COLUMN_ARRAY = "COLUMN_ARRAY";
        String VALUE_ARRAY = "VALUE_ARRAY";
        ArrayList<String> nameList = new ArrayList<String>();
        ArrayList<String> valueList = new ArrayList<String>();
        HashMap<String, ArrayList> separatedTokensHashMap = new HashMap<String, ArrayList>();

        qryToSplit = myQuery.getQueryString();
        String strWhere = "where";
        int whereIndex = qryToSplit.indexOf(strWhere);
        int indexToScan = whereIndex + strWhere.length() + 1;
        qryToSplit = qryToSplit.substring(indexToScan);
        String tokenArray[] = qryToSplit.split("And");
        String tokenToSeparate = "=";
        String tokenToSeparate1 = "like";
        String token = "";
        int j = 0;

        for (j = 0; j < tokenArray.length; j++) {
            token = tokenArray[j];

                nameList.add(j, token.split(tokenToSeparate)[0].trim());
                valueList.add(j, token.split(tokenToSeparate)[1].trim());
        }
       
        if (nameList.size() > 0) {
            separatedTokensHashMap.put(COLUMN_ARRAY, nameList);
        }
        if (valueList.size() > 0) {
            separatedTokensHashMap.put(VALUE_ARRAY, valueList);
        }
        String s = "";
        //    String checks="select * from issue, issuestatus  where issue.issueid=issuestatus.issueid";

        for (int i = 0; i < tokenArray.length; i++) {
            logger.info("Name List" + nameList.get(i));

            if (nameList.get(i).equals("(upper(Languages)")) {
                //         logger.info("inside customer");
                s = valueList.get(i).toString();
                skill = s.replace('\'', ' ').toUpperCase().trim();
                eRMSearch.setSkill(skill);
                //           logger.info("Inside Customer"+customers);
            }
            if (nameList.get(i).equals("upper(AREA_OF_EXPERTISE)")) {
                s = valueList.get(i).toString();
                module = s.replace('\'', ' ').toUpperCase().trim();
                eRMSearch.setModule(module);
            }
            if (nameList.get(i).equals("ea.APPLICANT_STATUS")) {
                s = valueList.get(i).toString();
                status = s.replace('\'', ' ').toUpperCase().trim();
            }
            if (nameList.get(i).equals("upper(REFERENCE_EMPID)")) {
                s = valueList.get(i).toString();
                refBy = s.replace('\'', ' ').toUpperCase().trim();
                eRMSearch.setRefBy(refBy);
            }
            if (nameList.get(i).equals("upper(UG)")) {
                s = valueList.get(i).toString();
                ug = s.replace('\'', ' ').toUpperCase().trim();
                eRMSearch.setUg(ug);
            }
            if (nameList.get(i).equals("UG_YEAR")) {
                s = valueList.get(i).toString();
                ugYear = s.replace('\'', ' ').toUpperCase().trim();
                eRMSearch.setUgYear(ugYear);
            }
            if (nameList.get(i).equals("upper(PG)")) {
                s = valueList.get(i).toString();
                pg = s.replace('\'', ' ').toUpperCase().trim();
                eRMSearch.setPg(pg);
            }
            if (nameList.get(i).equals("upper(PG_YEAR)")) {
                s = valueList.get(i).toString();
                pgYear = s.replace('\'', ' ').toUpperCase().trim();
                eRMSearch.setPgYear(pgYear);
            }
            if (nameList.get(i).equals("upper(CURRENT_LOCATION)")) {
                s = valueList.get(i).toString();
                location = s.replace('\'', ' ').toUpperCase().trim();
                eRMSearch.setLocation(location);
            }
            if (nameList.get(i).equals("TOTAL_EXP_YR")) {
                 s = valueList.get(i).toString();
                tExp = s.replace('\'', ' ').toUpperCase().trim();
            }
            if (nameList.get(i).equals("SAP_EXP_YR")) {
                s = valueList.get(i).toString();
                sExp = s.replace('\'', ' ').toUpperCase().trim();
            }
            if (nameList.get(i).equals("COMMENTEDBY")) {
                s = valueList.get(i).toString();
                updatedBy = s.replace('\'', ' ').toUpperCase().trim();
            }
            if (nameList.get(i).equals("ASSIGNEDTO")) {
                s = valueList.get(i).toString();
                assignedTo = s.replace('\'', ' ').toUpperCase().trim();
            }
            if (nameList.get(i).equals("EXPECTED_CTC")) {
//                                System.out.println("In Created On");
                s = valueList.get(i).toString();
                ctc = s.replace('\'', ' ').toUpperCase().trim();
                //                              System.out.println(createdons);
            }
            if (nameList.get(i).equals("((to_number(UG_PERCENTAGE)")) {
                s = valueList.get(i).toString();
                upercentage = s.replace('\'', ' ').toUpperCase().trim();
            }
            
            
        }
        logger.info("skill-->" + skill);
        logger.info("module-->" + module);
        logger.info("status-->" + status);
        logger.info("refBy-->" + refBy);
        logger.info("ug-->" + ug);
        logger.info("ugYear-->" + ugYear);
        logger.info("pg-->" + pg);
        logger.info("pgYear-->" + pgYear);
        logger.info("location-->" + location);
        logger.info("tExp-->" + tExp);
        logger.info("sExp-->" + sExp);
        logger.info("updatedBy-->" + updatedBy);
        logger.info("assignedTo-->" + assignedTo);
        nameList.clear();
        valueList.clear();
        for (int i = 0; i < nameList.size(); i++) {
            nameList.remove(i);
            valueList.remove(i);
        }
        return eRMSearch;




    }

    public static Logger getLogger() {
        return logger;
    }

    public static void setLogger(Logger logger) {
        ERMEditView.logger = logger;
    }

    public String getQueryString() {
        return queryString;
    }

    public void setQueryString(String queryString) {
        this.queryString = queryString;
    }

    public String getSkill() {
        return skill;
    }

    public void setSkill(String skill) {
        this.skill = skill;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRefBy() {
        return refBy;
    }

    public void setRefBy(String refBy) {
        this.refBy = refBy;
    }

    public String getUg() {
        return ug;
    }

    public void setUg(String ug) {
        this.ug = ug;
    }

    public String getUgYear() {
        return ugYear;
    }

    public void setUgYear(String ugYear) {
        this.ugYear = ugYear;
    }

    public String getPg() {
        return pg;
    }

    public void setPg(String pg) {
        this.pg = pg;
    }

    public String getPgYear() {
        return pgYear;
    }

    public void setPgYear(String pgYear) {
        this.pgYear = pgYear;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String gettExp() {
        return tExp;
    }

    public void settExp(String tExp) {
        this.tExp = tExp;
    }

    public String getsExp() {
        return sExp;
    }

    public void setsExp(String sExp) {
        this.sExp = sExp;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public String getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(String assignedTo) {
        this.assignedTo = assignedTo;
    }

    public String getCtc() {
        return ctc;
    }

    public void setCtc(String ctc) {
        this.ctc = ctc;
    }

    public String getPer() {
        return per;
    }

    public void setPer(String per) {
        this.per = per;
    }

    public String getUpdatedParam() {
        return updatedParam;
    }

    public void setUpdatedParam(String updatedParam) {
        this.updatedParam = updatedParam;
    }

    public String getUpdatedOn() {
        return updatedOn;
    }

    public void setUpdatedOn(String updatedOn) {
        this.updatedOn = updatedOn;
    }

    public String getUpdatedFrom() {
        return updatedFrom;
    }

    public void setUpdatedFrom(String updatedFrom) {
        this.updatedFrom = updatedFrom;
    }

    public String getUpdatedTo() {
        return updatedTo;
    }

    public void setUpdatedTo(String updatedTo) {
        this.updatedTo = updatedTo;
    }

    public String getUpercentage() {
        return upercentage;
    }

    public void setUpercentage(String upercentage) {
        this.upercentage = upercentage;
    }

    public ERMSearch geteRMSearch() {
        return eRMSearch;
    }

    public void seteRMSearch(ERMSearch eRMSearch) {
        this.eRMSearch = eRMSearch;
    }
    
}
