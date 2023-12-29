/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminent.util.GetProjectMembers;
import java.io.File;
import java.io.FilenameFilter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class ERMSearchResults {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ERMSearchResults");
    }
    private String buttonvalue = "Save My Search";
    private String applicantId;
    private String name;
    private String employer;
    private String mobile;
    private String location;
    private String aplstatus;
    private String refId;
    private String refName;
    private String education;
    private String skills;
    private String totalExp;
    private String sapExp;
    private String fileName;
    private String assignedTo;
    private String query = "";
    private String encodedQuery = "";
    private long qId;
    private String photoPath;
    private int isFake;

    public String getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(String applicantId) {
        this.applicantId = applicantId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmployer() {
        return employer;
    }

    public void setEmployer(String employer) {
        this.employer = employer;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getAplstatus() {
        return aplstatus;
    }

    public void setAplstatus(String aplstatus) {
        this.aplstatus = aplstatus;
    }

    public String getRefId() {
        return refId;
    }

    public void setRefId(String refId) {
        this.refId = refId;
    }

    public String getRefName() {
        return refName;
    }

    public void setRefName(String refName) {
        this.refName = refName;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public String getTotalExp() {
        return totalExp;
    }

    public void setTotalExp(String totalExp) {
        this.totalExp = totalExp;
    }

    public String getSapExp() {
        return sapExp;
    }

    public void setSapExp(String sapExp) {
        this.sapExp = sapExp;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(String assignedTo) {
        this.assignedTo = assignedTo;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public String getEncodedQuery() {
        return encodedQuery;
    }

    public void setEncodedQuery(String encodedQuery) {
        this.encodedQuery = encodedQuery;
    }

    public String getButtonvalue() {
        return buttonvalue;
    }

    public void setButtonvalue(String buttonvalue) {
        this.buttonvalue = buttonvalue;
    }

    public long getqId() {
        return qId;
    }

    public void setqId(long qId) {
        this.qId = qId;
    }

    public String getPhotoPath() {
        return photoPath;
    }

    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }

    public int getIsFake() {
        return isFake;
    }

    public void setIsFake(int isFake) {
        this.isFake = isFake;
    }

    public String getQuery(HttpServletRequest request) throws ParseException {
        String editQueryId = (String) request.getParameter("editQueryId");
        String queryId = request.getParameter("query_id");
        String equery = request.getParameter("query");
        String queryParam = (String) request.getSession().getAttribute("queryParam");
        if (request.getParameter("skill") != null) {
            queryParam = null;
        }

        if (queryId != null) {
            buttonvalue = null;
            long qid = Long.valueOf(queryId);
            MyQuery myView = ERMUtil.findByQueryId(qid);
            if (myView != null) {
                query = myView.getQueryString();
                request.getSession().setAttribute("forwardpage", "/ERM/ermSearchResults.jsp?query_id=" + qid);
            }
        } else if (equery != null) {
            query = equery;
            buttonvalue = null;
        } else if (queryParam != null && request.getParameter("ermAnalysis") == null) {
            query = queryParam;
        } else {
            if (editQueryId != null) {
                buttonvalue = "Update My Search";
                qId = Long.valueOf(editQueryId);
                request.getSession().setAttribute("forwardpage", "/ERM/ermSearchResults.jsp?editQueryId=" + editQueryId);

            }
            SimpleDateFormat sdfOutput = new SimpleDateFormat("dd-MMM-yyyy");

            SimpleDateFormat sdfInput = new SimpleDateFormat("dd-MM-yyyy");
            String skill = request.getParameter("skill");
            String module = request.getParameter("module");
            String status = request.getParameter("status");
            String refBy = request.getParameter("refEmp");
            String ug = request.getParameter("ug");
            String ugYear = request.getParameter("ugYear");
            String pg = request.getParameter("pg");
            String pgYear = request.getParameter("pgYear");
            String loc = request.getParameter("location");
            String tExp = request.getParameter("tExp");
            String sExp = request.getParameter("sExp");
            String updatedBy = request.getParameter("updatedBy");
            String assigned = request.getParameter("assignedTo");
            String ctc = request.getParameter("CTC");
            String percentage = request.getParameter("percentage");
            String updateParam = request.getParameter("updated_param");
            String modifiedon = request.getParameter("modifiedon");
            String modifiedFrom = request.getParameter("modifiedfrom");
            String modifiedTo = request.getParameter("modifiedto");
            String employer = request.getParameter("employer");
            String client = request.getParameter("client");
            String project = request.getParameter("project");
            if (skill != null && !"".equals(skill)) {
                query = query + " And (upper(Languages)='" + skill + "' OR upper(Languages) like '%" + skill + "%' OR upper(ERP_PACKAGES) like '%" + skill + "%' OR upper(OS) like '%" + skill + "%' OR upper(DB) like '%" + skill + "%')";
            }
            if (module != null && !"".equals(module)) {
                query = query + " And upper(AREA_OF_EXPERTISE) ='" + module + "'";

            }
            if (status != null && !"10".equals(status)) {

                query = query + " And ea.APPLICANT_STATUS =" + status;

            }
            if (refBy != null && !"".equals(refBy)) {

                query = query + " And upper(REFERENCE_EMPID) ='" + refBy + "'";

            }
            if (ug != null && !"".equals(ug)) {

                query = query + " And upper(UG) ='" + ug + "'";

            }
            if (ugYear != null && !"0".equals(ugYear)) {

                query = query + " And UG_YEAR ='" + ugYear + "'";

            }
            if (pg != null && !"".equals(pg)) {

                query = query + " And upper(PG) ='" + pg + "'";

            }
            if (pgYear != null && !"0".equals(pgYear)) {

                query = query + " And upper(PG_YEAR) ='" + pgYear + "'";

            }
            if (loc != null && !"".equals(loc)) {

                query = query + " And upper(CURRENT_LOCATION) ='" + loc + "'";

            }
            if (tExp != null && !"0".equals(tExp)) {

                query = query + " And TOTAL_EXP_YR =" + tExp;

            }
            if (sExp != null && !"0".equals(sExp)) {

                query = query + " And SAP_EXP_YR ='" + sExp + "'";

            }
            if (updatedBy != null && !"0".equals(updatedBy)) {

                query = query + " And COMMENTEDBY='" + updatedBy + "'";

            }
            if (assigned != null && !"0".equals(assigned)) {

                query = query + " And ASSIGNEDTO =" + assigned;

            }
            if (ctc != null && !"0".equals(ctc)) {

                query = query + " And EXPECTED_CTC =" + ctc;

            }
            if (percentage != null && !"0".equals(percentage)) {
                if (percentage.equals("<40")) {

                    query = query + " And ((UG_PERCENTAGE='<40') OR (to_number(UG_PERCENTAGE) between '35' AND '40') OR (to_number(PG_PERCENTAGE) between '35' AND '40') )";

                } else if (percentage.equals("40-60")) {

                    query = query + " And ((UG_PERCENTAGE='40-60') OR (to_number(UG_PERCENTAGE) between '40' AND '60') OR (PG_PERCENTAGE between '40' AND '60') )";

                } else if (percentage.equals("60-70")) {

                    query = query + " And ((UG_PERCENTAGE='60-70') OR (to_number(UG_PERCENTAGE) between '60' AND '70') OR (to_number(PG_PERCENTAGE) between '60' AND '70'))";

                } else if (percentage.equals("70-80")) {

                    query = query + " And ((UG_PERCENTAGE='70-80') OR (to_number(UG_PERCENTAGE) between '70' AND '80') OR (to_number(PG_PERCENTAGE) between '70' AND '80'))";

                } else if (percentage.equals(">80")) {

                    query = query + " And ((UG_PERCENTAGE='>80') OR (to_number(UG_PERCENTAGE) between '80' AND '100') OR (to_number(PG_PERCENTAGE) between '80' AND '100') )";

                }

            }
            if (updateParam != null && !"".equals(updateParam)) {
                String dat, month, year;
                if (updateParam.equalsIgnoreCase("Between")) {
                    if ((modifiedFrom != null && !"".equals(modifiedFrom)) && (modifiedTo != null && !"".equals(modifiedTo))) {
                        modifiedFrom = sdfOutput.format(sdfInput.parse(modifiedFrom));
                        modifiedTo = sdfOutput.format(sdfInput.parse(modifiedTo));
                        query = query + " And  (to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + modifiedFrom + "' and '" + modifiedTo + "')";
                    }

                } else if (updateParam.equalsIgnoreCase("After")) {
                    if (modifiedon != null && !"".equals(modifiedon)) {
                        modifiedon = modifiedon.toUpperCase();
                        dat = modifiedon.substring(0, modifiedon.indexOf("-"));
                        month = modifiedon.substring(modifiedon.indexOf("-") + 1, modifiedon.lastIndexOf("-"));
                        year = modifiedon.substring(modifiedon.lastIndexOf("-") + 3, (modifiedon.lastIndexOf("-") + 5));
                        java.util.Date data = sdfInput.parse(modifiedon);
                        modifiedon = sdfOutput.format(data);
                        query = query + " And (to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') >  '" + modifiedon + "')";
                    }
                } else if (updateParam.equalsIgnoreCase("Before")) {
                    if (modifiedon != null && !"".equals(modifiedon)) {
                        modifiedon = modifiedon.toUpperCase();
                        dat = modifiedon.substring(0, modifiedon.indexOf("-"));
                        month = modifiedon.substring(modifiedon.indexOf("-") + 1, modifiedon.lastIndexOf("-"));
                        year = modifiedon.substring(modifiedon.lastIndexOf("-") + 3, (modifiedon.lastIndexOf("-") + 5));
                        java.util.Date data = sdfInput.parse(modifiedon);
                        modifiedon = sdfOutput.format(data);

                        query = query + " And (to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') < '" + modifiedon + "')";
                    }
                } else if (updateParam.equalsIgnoreCase("Today")) {
                    query = query + " And (to_char(COMMENTEDON, 'DD-Mon-YYYY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY') FROM DUAL))";
                } else if (updateParam.equalsIgnoreCase("ON")) {
                    if (modifiedon != null && !"".equals(modifiedon)) {
                        modifiedon = modifiedon.toUpperCase();
                        dat = modifiedon.substring(0, modifiedon.indexOf("-"));
                        month = modifiedon.substring(modifiedon.indexOf("-") + 1, modifiedon.lastIndexOf("-"));
                        year = modifiedon.substring(modifiedon.lastIndexOf("-") + 3, (modifiedon.lastIndexOf("-") + 5));
                        java.util.Date data = sdfInput.parse(modifiedon);
                        modifiedon = sdfOutput.format(data);
                        query = query + " And (to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') = '" + modifiedon + "')";
                    }
                } else {
                    if (modifiedon != null && !"".equals(modifiedon)) {
                        query = query + "";
                    }
                }
            }
            if (employer != null && !"".equals(employer)) {
                query = query + " And eae.CURRENT_EMPLOYER ='" + employer + "'";
            }
            if (client != null && !"".equals(client)) {
                query = query + " And eap.CLIENT='" + client + "'";
            }
            if (project != null && !"".equals(project)) {
                query = query + " And eap.PROJECT_NAME='" + project + "'";
            }
            query = "Select distinct(ea.APPLICANT_ID) as apId,FIRSTNAME,LASTNAME,MOBILE,CURRENT_LOCATION,REFERENCE_EMPID,REGISTEREDON,UG,PG,AREA_OF_EXPERTISE,SAP_EXP_YR,SAP_EXP_MON,TOTAL_EXP_YR,TOTAL_EXP_MON,ASSIGNEDTO,ea.APPLICANT_STATUS,ISFAKE FROM ERM_APPLICANT ea LEFT JOIN ERM_APPLICANT_COMMENT eac ON eac.APPLICANTID = ea.APPLICANT_ID left join ERM_APPLICANT_EXPERIENCE eae on ea.APPLICANT_ID=eae.APPLICANT_ID left join ERM_APPLICANT_PROJECT eap on ea.APPLICANT_ID=eap.APPLICANT_ID  where ea.APPLICANT_ID=ea.APPLICANT_ID " + query;
            request.getSession().setAttribute("queryParam", query);
            request.getSession().setAttribute("forwardpage", "/ERM/ermSearchResults.jsp");
        }
        System.out.println("query : " + query);
        try {
            encodedQuery = URLEncoder.encode(query, "UTF-8");
        } catch (UnsupportedEncodingException ex) {
            java.util.logging.Logger.getLogger(ERMSearchResults.class.getName()).log(Level.SEVERE, "URL encode done wrong", ex);
        }

        return query;
    }

    public List<ERMSearchResults> getErmSearch(String query, HttpServletRequest request) {
        logger.info(query);
        String filePath = request.getSession().getServletContext().getInitParameter("upload-resume");
        String filePathone = request.getSession().getServletContext().getInitParameter("upload-user-photo");
        List<ERMSearchResults> searchResults = new ArrayList<ERMSearchResults>();

        if (!"".equals(query)) {
            File resumeDir = new File(filePath);
            File photoDir = new File(filePathone);
            Connection connection = null;
            Statement stmt1 = null;
            ResultSet rs1 = null;
            HashMap<Integer, String> member = GetProjectMembers.showUsers();
            try {
                connection = MakeConnection.getConnection();
                stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                rs1 = stmt1.executeQuery(query);
                while (rs1.next()) {
                    ERMSearchResults esr = new ERMSearchResults();

                    String apId = rs1.getString("apId");
                    String fullname = rs1.getString("FIRSTNAME") + " " + rs1.getString("LASTNAME");
                    if ((fullname.length()) > 25) {
                        fullname = fullname.substring(0, 24) + "...";
                    }
                    String mobileNo = rs1.getString("MOBILE");
                    int status = rs1.getInt("APPLICANT_STATUS");
                    final String id = apId;
                    String nameOfFile = AssignedApplicants.getFileNamewithExtension(id, resumeDir);
                    if (nameOfFile == null) {
                        nameOfFile = apId + ".doc";
                    }
                    String nameOfPhoto = AssignedApplicants.getFileNamewithExtension(id, photoDir);
                    if (nameOfPhoto == null) {
                        nameOfPhoto = "avator1.png";
                    }
                    String cloc = rs1.getString("CURRENT_LOCATION");
                    String empid = rs1.getString("REFERENCE_EMPID");
                    String registerdOn = rs1.getString("REGISTEREDON");
                    String edu = rs1.getString("UG");
                    String pgrad = rs1.getString("PG");
                    if (!(pgrad == null || pgrad.equals(""))) {
                        edu = edu + ", " + pgrad;
                    }
                    if (edu.equals(", ")) {
                        edu = "Nil";

                    }
                    if ((edu.length()) > 8) {
                        edu = edu.substring(0, 7) + "..";
                    }

                    String aoe = rs1.getString("AREA_OF_EXPERTISE");
                    if (aoe.length() > 10) {
                        aoe = aoe.substring(0, 9) + "..";
                    }
                    String sapEx = rs1.getString("SAP_EXP_YR") + "Y " + rs1.getString("SAP_EXP_MON") + "M";
                    String toEx = rs1.getString("TOTAL_EXP_YR") + "Y " + rs1.getString("TOTAL_EXP_MON") + "M";
                    String assign = rs1.getString("ASSIGNEDTO");

                    esr.setApplicantId(apId);
                    esr.setName(fullname);
                    esr.setEmployer(ERMUtil.findEmployee(apId));
                    esr.setMobile(mobileNo);
                    esr.setLocation(cloc);
                    esr.setRefId(empid);
                    esr.setRefName(GetProjectMembers.getUserNameByEid(empid));
                    esr.setEducation(edu);
                    esr.setSkills(aoe);
                    esr.setTotalExp(toEx);
                    esr.setSapExp(sapEx);
                    esr.setFileName(nameOfFile);
                    esr.setPhotoPath(nameOfPhoto);
                    esr.setAplstatus(ERMUtil.ermApplicantStatus().get(status));
                    esr.setAssignedTo(member.get(Integer.valueOf(assign)));
                    esr.setIsFake(rs1.getInt("ISFAKE"));
                    searchResults.add(esr);
                }
            } catch (Exception e) {
                logger.error("getQuery" + e.getMessage());
            } finally {
                try {
                    if (rs1 != null) {
                        rs1.close();
                    }
                    if (stmt1 != null) {
                        stmt1.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }
            }
        }
        return searchResults;
    }
}
