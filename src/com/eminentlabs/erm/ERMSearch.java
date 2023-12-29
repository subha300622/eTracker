/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminent.util.GetProjectMembers;
import static com.eminentlabs.erm.ERMEditView.logger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author E0288
 */
public class ERMSearch {

    private long queryId;
    private String skill;
    private String module;
    private Integer status = 10;
    private String refBy;
    private String ug;
    private String ugYear;
    private String pg;
    private String pgYear;
    private String location;
    private Integer tExp = 0;
    private Integer sExp = 0;
    private Integer updatedBy = 0;
    private Integer assignedTo = 0;
    private Integer ctc = 0;
    private String per;
    private String updatedParam;
    private String updatedOn;
    private String updatedFrom;
    private String updatedTo;
    private String errorMessage;
    private String employer;
    private String client;
    private String project;

    private Set<String> skillsList = new TreeSet<String>();
    private Set<String> modulesList = new TreeSet<String>();
    private Set<String> ugList = new HashSet<String>();
    private Set<String> pgList = new HashSet<String>();
    private Set<String> ugyearList = new TreeSet<String>();
    private Set<String> pgyearList = new TreeSet<String>();
    private Set<String> locationList = new TreeSet<String>();
    private Set<Integer> tExpList = new TreeSet<Integer>();
    private Set<Integer> sExpList = new TreeSet<Integer>();
    private HashMap<String, String> refByList = new HashMap<String, String>();
    private Set<Integer> ctcList = new HashSet<Integer>();
    private Map<Integer, String> statusList = new HashMap<Integer, String>();
    private List<String> percentageList = new ArrayList<String>();
    private Map<Integer, String> updatedByList = new LinkedHashMap<Integer, String>();
    private Map<Integer, String> assignedToList = new LinkedHashMap<Integer, String>();
    private List<ErmApplicant> totalList = ERMUtil.findAll();
    private List<String> dataParamList = new ArrayList<String>();
    private List<ErmApplicantExperience> totalExpList = ERMUtil.findAllEmployer();
    private List<ErmApplicantProject> totalProjectList = ERMUtil.findAllProjects();

    private Set<String> employerList = new TreeSet<String>();
    private Set<String> clientList = new TreeSet<String>();
    private Set<String> projectList = new TreeSet<String>();

    public void setAll(HttpServletRequest request) {
        try {
            String qId = request.getParameter("queryId");
            if (qId != null) {
                DateFormat sdfoutput = new SimpleDateFormat("dd-MM-yyyy");
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
                queryId = Long.valueOf(qId);

                MyQuery myQuery = ERMUtil.findByQueryId(queryId);
                String qryToSplit = "";
                String COLUMN_ARRAY = "COLUMN_ARRAY";
                String VALUE_ARRAY = "VALUE_ARRAY";
                ArrayList<String> nameList = new ArrayList<String>();
                ArrayList<String> valueList = new ArrayList<String>();
                HashMap<String, ArrayList> separatedTokensHashMap = new HashMap<String, ArrayList>();

                qryToSplit = myQuery.getQueryString();
                logger.info(myQuery.getQueryString());
                String strWhere = "where";
                int whereIndex = qryToSplit.indexOf(strWhere);
                int indexToScan = whereIndex + strWhere.length() + 1;
                qryToSplit = qryToSplit.substring(indexToScan);
                String tokenArray[] = qryToSplit.split("And");
                String tokenToSeparate = "=";
                String token = "";
                int j = 0;

                for (j = 0; j < tokenArray.length; j++) {
                    token = tokenArray[j];
                    logger.info(token);
                    if (token.contains(tokenToSeparate)) {
                        nameList.add(j, token.split(tokenToSeparate)[0].trim());
                        valueList.add(j, token.split(tokenToSeparate)[1].trim());
                    } else if (token.split(tokenToSeparate)[0].contains("(to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') <")) {
                        updatedParam = "Before";
                        nameList.add(j, "(to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') <");
                        valueList.add(j, token.split("<")[1].trim());
                    } else if (token.split(tokenToSeparate)[0].contains("(to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') >")) {
                        updatedParam = "After";
                        nameList.add(j, "(to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') >");
                        valueList.add(j, token.split(">")[1].trim());
                    } else if (token.split(tokenToSeparate)[0].contains("(to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') between")) {
                        updatedParam = "Between";
                        nameList.add(j, "(to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') between");
                        valueList.add(j, token.split("between")[1].trim());
                    }

                }

                if (nameList.size() > 0) {
                    separatedTokensHashMap.put(COLUMN_ARRAY, nameList);
                }
                if (valueList.size() > 0) {
                    separatedTokensHashMap.put(VALUE_ARRAY, valueList);
                }
                logger.info(nameList);
                String s = "";
                //    String checks="select * from issue, issuestatus  where issue.issueid=issuestatus.issueid";

                for (int i = 0; i < nameList.size(); i++) {
                    logger.info("Name List" + nameList.get(i));

                    if (nameList.get(i).equals("(upper(Languages)")) {
                        //         logger.info("inside customer");
                        s = valueList.get(i).toString();
                        String[] split = s.split("OR");

                        skill = split[0].replace('\'', ' ').toUpperCase().trim();
                        //           logger.info("Inside Customer"+customers);
                    }
                    if (nameList.get(i).equals("upper(AREA_OF_EXPERTISE)")) {
                        s = valueList.get(i).toString();
                        module = s.replace('\'', ' ').toUpperCase().trim();
                    }
                    if (nameList.get(i).equals("ea.APPLICANT_STATUS")) {
                        s = valueList.get(i).toString();
                        status = Integer.valueOf(s.replace('\'', ' ').toUpperCase().trim());

                    }
                    if (nameList.get(i).equals("upper(REFERENCE_EMPID)")) {
                        s = valueList.get(i).toString();
                        refBy = s.replace('\'', ' ').toUpperCase().trim();
                    }
                    if (nameList.get(i).equals("upper(UG)")) {
                        s = valueList.get(i).toString();
                        ug = s.replace('\'', ' ').toUpperCase().trim();
                    }
                    if (nameList.get(i).equals("UG_YEAR")) {
                        s = valueList.get(i).toString();
                        ugYear = s.replace('\'', ' ').toUpperCase().trim();
                    }
                    if (nameList.get(i).equals("upper(PG)")) {
                        s = valueList.get(i).toString();
                        pg = s.replace('\'', ' ').toUpperCase().trim();
                    }
                    if (nameList.get(i).equals("upper(PG_YEAR)")) {
                        s = valueList.get(i).toString();
                        pgYear = s.replace('\'', ' ').toUpperCase().trim();
                    }
                    if (nameList.get(i).equals("upper(CURRENT_LOCATION)")) {
                        s = valueList.get(i).toString();
                        location = s.replace('\'', ' ').toUpperCase().trim();
                    }
                    if (nameList.get(i).equals("TOTAL_EXP_YR")) {
                        s = valueList.get(i).toString();
                        tExp = Integer.valueOf(s.replace('\'', ' ').toUpperCase().trim());

                    }
                    if (nameList.get(i).equals("SAP_EXP_YR")) {
                        s = valueList.get(i).toString();
                        sExp = Integer.valueOf(s.replace('\'', ' ').toUpperCase().trim());
                    }
                    if (nameList.get(i).equals("COMMENTEDBY")) {
                        s = valueList.get(i).toString();
                        updatedBy = Integer.valueOf(s.replace('\'', ' ').toUpperCase().trim());
                    }
                    if (nameList.get(i).equals("ASSIGNEDTO")) {
                        s = valueList.get(i).toString();
                        assignedTo = Integer.valueOf(s.replace('\'', ' ').toUpperCase().trim());
                    }
                    if (nameList.get(i).equals("EXPECTED_CTC")) {
//                                System.out.println("In Created On");
                        s = valueList.get(i).toString();
                        ctc = Integer.valueOf(s.replace('\'', ' ').toUpperCase().trim());
                        //                              System.out.println(createdons);
                    }
                    if (nameList.get(i).equals("((UG_PERCENTAGE")) {

                        s = valueList.get(i).toString();
                        String[] split = s.split("OR");
                        String re = split[0].trim();
                        String req = re.substring(0, re.length() - 1);
                        per = req.replace('\'', ' ').toUpperCase().trim();
                    }
                    if (nameList.get(i).equals("(to_char(COMMENTEDON, 'DD-Mon-YYYY')")) {
                        updatedParam = "Today";
                    }

                    if (nameList.get(i).equals("(to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY')")) {
                        updatedParam = "On";
                        s = valueList.get(i).toString();
                        logger.info(s.substring(1, 12));
                        logger.info(sdf.parse(s.substring(1, 12)));
                        updatedOn = sdfoutput.format(sdf.parse(s.substring(1, 12)));
                    }
                    if (nameList.get(i).equals("(to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') <")) {
                        s = valueList.get(i).toString();
                        logger.info(s.substring(1, 12));
                        logger.info(sdf.parse(s.substring(1, 12)));
                        updatedOn = sdfoutput.format(sdf.parse(s.substring(1, 12)));
                    }
                    if (nameList.get(i).equals("(to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') >")) {
                        s = valueList.get(i).toString();
                        logger.info(s.substring(1, 12));
                        logger.info(sdf.parse(s.substring(1, 12)));
                        updatedOn = sdfoutput.format(sdf.parse(s.substring(1, 12)));
                    }
                    if (nameList.get(i).equals("(to_date(to_char(COMMENTEDON, 'DD-Mon-YYYY'),'DD-Mon-YYYY') between")) {
                        s = valueList.get(i).toString();
                        String[] split = s.split("and");
                        if (split != null) {
                            updatedFrom = sdfoutput.format(sdf.parse(split[0].substring(1, 13)));
                            updatedTo = sdfoutput.format(sdf.parse(split[1].substring(2, 13)));
                        }
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
                logger.info("per-->" + per);
                logger.info("updatedParam-->" + updatedParam);
                logger.info("updatedOn-->" + updatedOn);
                logger.info("updatedFrom-->" + updatedFrom);
                logger.info("updatedTo-->" + updatedTo);
                nameList.clear();
                valueList.clear();
                for (int i = 0; i < nameList.size(); i++) {
                    nameList.remove(i);
                    valueList.remove(i);
                }
            }
            HashMap<Integer, String> users = GetProjectMembers.getEminentUsers();
            LinkedHashMap<Integer, String> orusers = GetProjectMembers.sortHashMapByValues(GetProjectMembers.getEminentUsers(), true);
            for (ErmApplicant ea : totalList) {
                if (ea.getUg() != null && !"".equals(ea.getUg())) {
                    ugList.add(ea.getUg().toUpperCase());
                }
                if (ea.getPg() != null && !"".equals(ea.getPg())) {
                    pgList.add(ea.getPg().toUpperCase());
                }

                ugyearList.add(ea.getUgYear());
                if ((ea.getPgYear() != null && !"".equals(ea.getPgYear())) && (!"0".equals(ea.getPgYear()))) {
                    pgyearList.add(ea.getPgYear());
                }
                locationList.add(ea.getCurrentLocation().toUpperCase());
                if (ea.getTotalExpYr() != null && ea.getTotalExpYr() != 0) {
                    tExpList.add(ea.getTotalExpYr());
                }
                if (ea.getTotalExpYr() != null && ea.getSapExpYr() != 0) {
                    sExpList.add(ea.getSapExpYr());
                }
                String empId = ea.getReferenceEmpid();

                if ((empId != null && !"".equals(empId))) {
                    String empName = GetProjectMembers.getUserNameByEid(ea.getReferenceEmpid());
                    if ((empName != null && !"".equals(empName))) {
                        refByList.put(ea.getReferenceEmpid(), GetProjectMembers.getUserNameByEid(ea.getReferenceEmpid()));
                    }
                }

                ctcList.add(Integer.valueOf(ea.getExpectedCtc()));
                statusList.putAll(ERMUtil.ermApplicantStatus());
                updatedByList.putAll(orusers);
                assignedToList.put(ea.getAssignedto(), users.get(ea.getAssignedto()));
                modulesList.add(ea.getAreaOfExpertise());
            }
            for (ErmApplicantExperience eae : totalExpList) {
                employerList.add(eae.getCurrentEmployer());
            }
            for (ErmApplicantProject eap : totalProjectList) {
                if (eap.getProjectName() != null) {
                    projectList.add(eap.getProjectName());
                }
                 if (eap.getClient()!= null) {
                clientList.add(eap.getClient());
                }
            }
            refByList = GetProjectMembers.sortHashMapByValues(refByList, true);
        } catch (Exception ex) {
            ex.printStackTrace();
            errorMessage = "Error Occured";
            logger.error(ex.getMessage());
        }
    }

    public Set<String> getSkillsList() {
        skillsList.add("ABAP");
        skillsList.add("C");
        skillsList.add("C++");
        skillsList.add("J2EE");
        skillsList.add("JAVA");
        skillsList.add("MS.NET");
        skillsList.add("OOABAP");
        skillsList.add("WEBDYNPRO");
        skillsList.add("BAAN");
        skillsList.add("I2");
        skillsList.add("SAP");
        skillsList.add("MS AXAPTA");
        skillsList.add("ORACLE");
        skillsList.add("MANUGSTICS");
        skillsList.add("AIX");
        skillsList.add("HP-UX");
        skillsList.add("ABAP");
        skillsList.add("LINUX");
        skillsList.add("MACNITOSH");
        skillsList.add("UNIX");
        skillsList.add("WINDOWS");
        skillsList.add("DB2");
        skillsList.add("MAX DB");
        skillsList.add("MY SQL");
        skillsList.add("SQL SERVER");

        return skillsList;
    }

    public void setSkillsList(Set<String> skillsList) {
        this.skillsList = skillsList;
    }

    public Set<String> getModulesList() {

        return modulesList;
    }

    public void setModulesList(Set<String> modulesList) {
        this.modulesList = modulesList;
    }

    public Set<String> getUgList() {

        return ugList;
    }

    public void setUgList(Set<String> ugList) {
        this.ugList = ugList;
    }

    public Set<String> getPgList() {
        return pgList;
    }

    public void setPgList(Set<String> pgList) {
        this.pgList = pgList;
    }

    public Set<String> getUgyearList() {
        return ugyearList;
    }

    public void setUgyearList(Set<String> ugyearList) {
        this.ugyearList = ugyearList;
    }

    public Set<String> getPgyearList() {
        return pgyearList;
    }

    public void setPgyearList(Set<String> pgyearList) {
        this.pgyearList = pgyearList;
    }

    public Set<String> getLocationList() {
        return locationList;
    }

    public void setLocationList(Set<String> locationList) {
        this.locationList = locationList;
    }

    public Set<Integer> gettExpList() {
        return tExpList;
    }

    public void settExpList(Set<Integer> tExpList) {
        this.tExpList = tExpList;
    }

    public Set<Integer> getsExpList() {
        return sExpList;
    }

    public void setsExpList(Set<Integer> sExpList) {
        this.sExpList = sExpList;
    }

    public HashMap<String, String> getRefByList() {
        return refByList;
    }

    public void setRefByList(HashMap<String, String> refByList) {
        this.refByList = refByList;
    }

    public Set<Integer> getCtcList() {
        return ctcList;
    }

    public void setCtcList(Set<Integer> ctcList) {
        this.ctcList = ctcList;
    }

    public Map<Integer, String> getStatusList() {
        return statusList;
    }

    public void setStatusList(Map<Integer, String> statusList) {
        this.statusList = statusList;
    }

    public List<String> getPercentageList() {
        percentageList.add("<40");
        percentageList.add("40-60");
        percentageList.add("60-70");
        percentageList.add("70-80");
        percentageList.add(">80");
        return percentageList;
    }

    public void setPercentageList(List<String> percentageList) {
        this.percentageList = percentageList;
    }

    public Map<Integer, String> getUpdatedByList() {
        return updatedByList;
    }

    public void setUpdatedByList(Map<Integer, String> updatedByList) {
        this.updatedByList = updatedByList;
    }

    public Map<Integer, String> getAssignedToList() {
        return assignedToList;
    }

    public void setAssignedToList(Map<Integer, String> assignedToList) {
        this.assignedToList = assignedToList;
    }

    public List<ErmApplicant> getTotalList() {
        return totalList;
    }

    public void setTotalList(List<ErmApplicant> totalList) {
        this.totalList = totalList;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
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

    public Integer gettExp() {
        return tExp;
    }

    public void settExp(Integer tExp) {
        this.tExp = tExp;
    }

    public Integer getsExp() {
        return sExp;
    }

    public void setsExp(Integer sExp) {
        this.sExp = sExp;
    }

    public Integer getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(Integer updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Integer getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(Integer assignedTo) {
        this.assignedTo = assignedTo;
    }

    public Integer getCtc() {
        return ctc;
    }

    public void setCtc(Integer ctc) {
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

    public long getQueryId() {
        return queryId;
    }

    public void setQueryId(long queryId) {
        this.queryId = queryId;
    }

    public List<String> getDataParamList() {
        dataParamList.add("On");
        dataParamList.add("Today");
        dataParamList.add("After");
        dataParamList.add("Before");
        dataParamList.add("Between");
        return dataParamList;
    }

    public void setDataParamList(List<String> dataParamList) {
        this.dataParamList = dataParamList;
    }

    public Set<String> getEmployerList() {
        return employerList;
    }

    public void setEmployerList(Set<String> employerList) {
        this.employerList = employerList;
    }

    public Set<String> getClientList() {
        return clientList;
    }

    public void setClientList(Set<String> clientList) {
        this.clientList = clientList;
    }

    public Set<String> getProjectList() {
        return projectList;
    }

    public void setProjectList(Set<String> projectList) {
        this.projectList = projectList;
    }

    public String getEmployer() {
        return employer;
    }

    public void setEmployer(String employer) {
        this.employer = employer;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getProject() {
        return project;
    }

    public void setProject(String project) {
        this.project = project;
    }

    public List<ErmApplicantExperience> getTotalExpList() {
        return totalExpList;
    }

    public void setTotalExpList(List<ErmApplicantExperience> totalExpList) {
        this.totalExpList = totalExpList;
    }

    public List<ErmApplicantProject> getTotalProjectList() {
        return totalProjectList;
    }

    public void setTotalProjectList(List<ErmApplicantProject> totalProjectList) {
        this.totalProjectList = totalProjectList;
    }

}
