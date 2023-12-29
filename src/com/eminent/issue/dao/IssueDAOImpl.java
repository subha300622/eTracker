/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.IssueImageUrl;
import com.eminent.issue.PlanStatus;
import com.eminent.issue.ProjectDetail;
import com.eminent.issue.ProjectPlannedIssue;
import com.eminent.issue.controller.ApmComponentIssueController;
import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.issue.formbean.LastAssginForm;
import static com.eminent.issue.formbean.PlannedIssueReport.severityColor;
import com.eminent.tqm.TqmUtil;
import com.eminent.util.GetAge;
import com.eminent.util.GetProjectManager;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.GetProjects;
import com.eminent.util.IssueDetails;
import com.eminent.util.ProjectFinder;
import com.eminent.util.ProjectPlanUtil;
import com.eminent.util.SendMail;
import com.eminent.util.UpdateIssue;
import com.eminent.util.UpdateValue;
import com.eminent.validation.StatusValidation;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.ApmAdditionalClosed;
import com.eminentlabs.mom.ApmWrmPlan;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.mom.TeamWiseMom;
import dashboard.CheckDate;
import dashboard.CurrentDay;
import java.io.IOException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class IssueDAOImpl implements IssueDAO {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("IssueDAOImpl");
    }

    @Override
    public String generateIssueIdSeq() {
        Statement st = null, statementDate = null, stForProject = null, stForType = null, st5 = null;
        ResultSet rs = null, fetchDate = null, rsForProject = null, rsForType = null, rs5 = null;
        Connection connection = null;
        int day, month, year;
        String issueidFormat = null;

        try {
            connection = MakeConnection.getConnection();

            //Generating Issue Id using sequence
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            statementDate = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            fetchDate = statementDate.executeQuery("select extract(day from sysdate) as day,extract(month from sysdate) as month,extract(year from sysdate) as year from dual");
            rs = st.executeQuery("select issueid from ISSUE where createdon like (select to_date(sysdate,'dd-mm-yyyy') from dual)");//CHANGED since 24th Nov 2006
            fetchDate.next();
            day = fetchDate.getInt("day");
            month = fetchDate.getInt("month");
            year = fetchDate.getInt("year");
            if (day < 10) {
                issueidFormat = "E0" + day;
            } else {
                issueidFormat = "E" + day;
            }
            if (month < 10) {
                issueidFormat = issueidFormat + "0" + month + year;
            } else {
                issueidFormat = issueidFormat + month + year;
            }
            if (rs.next()) {
                Statement seqStatement = connection.createStatement();
                ResultSet seqResultSet = seqStatement.executeQuery("select issueid_seq.nextval as nextvalue from dual");

                seqResultSet.next();
                int nextValue = seqResultSet.getInt("nextvalue");
                if (nextValue < 10) {
                    issueidFormat = issueidFormat + "00" + nextValue;
                } else if (nextValue >= 10 && nextValue <= 99) {
                    issueidFormat = issueidFormat + "0" + nextValue;
                } else {
                    issueidFormat = issueidFormat + nextValue;
                }
                logger.info("IssueID:\t" + issueidFormat);
                if (seqResultSet != null) {
                    seqResultSet.close();
                }

                if (seqStatement != null) {
                    seqStatement.close();
                }
            } else {
                Statement dropSeqeunceSt = connection.createStatement();
                boolean b = dropSeqeunceSt.execute("drop sequence issueid_seq");
                logger.info("Sequence has been dropped:" + b);
                ResultSet dropSequence = dropSeqeunceSt.executeQuery("create sequence issueid_seq start with 1 increment by 1 nocache nocycle");
                dropSequence = dropSeqeunceSt.executeQuery("select issueid_seq.nextval as nextvalue from dual");
                dropSequence.next();
                int nextValue = dropSequence.getInt("nextvalue");
                if (nextValue < 10) {
                    issueidFormat = issueidFormat + "00" + nextValue;
                } else if (nextValue >= 10 && nextValue <= 99) {
                    issueidFormat = issueidFormat + "0" + nextValue;
                } else {
                    issueidFormat = issueidFormat + nextValue;
                }
                logger.info("IssueID:\t" + issueidFormat);

                if (dropSequence != null) {
                    dropSequence.close();
                }

                if (dropSeqeunceSt != null) {
                    dropSeqeunceSt.close();
                }

            }

        } catch (Exception e) {
            logger.error("Exception:" + e);
        } finally {

            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (rsForType != null) {
                    rsForType.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForType != null) {
                    stForType.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (st != null) {
                    st.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (fetchDate != null) {
                    fetchDate.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (statementDate != null) {
                    statementDate.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (rs5 != null) {
                    rs5.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (st5 != null) {
                    st5.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

        }
        return issueidFormat;

    }

    @Override
    public String createIssue(String dueDate, String issueidFormat, int pid, String version, String type, String moduleId, String severity, String priority, String subject, String desc, String product, String rootCause, String expectedResult, String module, String user2, String pmanager) {

        Connection connection = null;
        Statement issuestatusSt = null, stForType = null, fetchProjectManagerSt = null;
        PreparedStatement insertStatus_St = null, insertSeq = null, insertPhase_St = null, psComment = null, prposalComment = null, prposalissue = null;
        ResultSet issuestatus = null, fetchProjectManager = null;
        String result = null;
        String projecttype = null;
        try {
            connection = MakeConnection.getConnection();
            connection.setAutoCommit(false);

            if (dueDate != null) {
                dueDate = dueDate;
            }
            String storeDate = com.pack.ChangeFormat.getDateFormat(dueDate);

            //Fetching Type of Project from Project_type table
            stForType = connection.createStatement();
            issuestatus = stForType.executeQuery("select type from project_type where pid = " + pid);
            if (issuestatus.next()) {
                projecttype = issuestatus.getString("type");
            }

            insertSeq = connection.prepareStatement("insert into issue(issueid,pid,found_version,type,module_id,severity,priority,subject,description,createdby,modifiedon,assignedto,createdon,rootcause,expected_result,due_date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");//CHANGED
            insertSeq.setString(1, issueidFormat);
            insertSeq.setInt(2, pid);
            insertSeq.setString(3, version);
            insertSeq.setString(4, type);
            insertSeq.setString(5, moduleId);
            insertSeq.setString(6, severity);
            insertSeq.setString(7, priority);
            insertSeq.setString(8, subject);
            insertSeq.setString(9, desc);
            insertSeq.setString(10, user2);
            java.util.Date d = new java.util.Date();
            Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());
            insertSeq.setTimestamp(11, ts);
            insertSeq.setString(12, pmanager);
            insertSeq.setTimestamp(13, ts);
            insertSeq.setString(14, rootCause);
            insertSeq.setString(15, expectedResult);
            insertSeq.setDate(16, java.sql.Date.valueOf(storeDate));
            insertSeq.executeUpdate();

            issuestatusSt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            issuestatus = issuestatusSt.executeQuery("select statusid_seq.nextval from dual");
            issuestatus.next();
            int issuestatus_nextval = issuestatus.getInt("nextval");
            insertStatus_St = connection.prepareStatement("insert into issuestatus(statusid,issueid,status,owner) values(?,?,?,?)");//CHANGED
            insertStatus_St.setInt(1, issuestatus_nextval);
            insertStatus_St.setString(2, issueidFormat);
            insertStatus_St.setString(3, "Unconfirmed");
            insertStatus_St.setString(4, pmanager);
            insertStatus_St.executeUpdate();

            psComment = connection.prepareStatement("insert into issuecomments(issueid,commentedby,comment_date,comments,status,commentedto,duedate,priority,severity) values(?,?,?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            psComment.setString(1, issueidFormat);
            psComment.setString(2, user2);
            psComment.setTimestamp(3, ts);
            psComment.setString(4, "Assigning to PM");
            psComment.setString(5, "Unconfirmed");
            psComment.setString(6, pmanager);
            psComment.setDate(7, java.sql.Date.valueOf(storeDate));
            psComment.setString(8, priority);
            psComment.setString(9, severity);
            psComment.executeUpdate();
            String phase = null, subphase = null, subsubphase = null, subsubsubphase = null;
            if (projecttype != null) {
                phase = "Project Preparation";
                subphase = "Actual situation analysis";
                if (projecttype.equals("Implementation")) {

                    subphase = "Implementation Scope";
                    subsubphase = "Project deliverables";
                    insertPhase_St = connection.prepareStatement("insert into issue_implementation(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                    insertPhase_St.setString(1, issueidFormat);
                    insertPhase_St.setString(2, phase);
                    insertPhase_St.setString(3, subphase);
                    insertPhase_St.setString(4, subsubphase);
                    insertPhase_St.setString(5, subsubsubphase);
                    insertPhase_St.setString(6, projecttype);
                    insertPhase_St.executeUpdate();

                } else if (projecttype.equals("Upgradation")) {

                    insertPhase_St = connection.prepareStatement("insert into issue_upgradation(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                    insertPhase_St.setString(1, issueidFormat);
                    insertPhase_St.setString(2, phase);
                    insertPhase_St.setString(3, subphase);
                    insertPhase_St.setString(4, subsubphase);
                    insertPhase_St.setString(5, subsubsubphase);
                    insertPhase_St.setString(6, projecttype);
                    insertPhase_St.executeUpdate();

                } else if (projecttype.equals("Support")) {

                    insertPhase_St = connection.prepareStatement("insert into issue_support(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                    insertPhase_St.setString(1, issueidFormat);
                    insertPhase_St.setString(2, phase);
                    insertPhase_St.setString(3, subphase);
                    insertPhase_St.setString(4, subsubphase);
                    insertPhase_St.setString(5, subsubsubphase);
                    insertPhase_St.setString(6, projecttype);
                    insertPhase_St.executeUpdate();
                }
            }

            String status = "";
            String assignedTo = "";
            String seve = "";
            String pri = "";
            String dued = "";
            String prposalDate = IssueDetails.proposeDuedate(product, module, version, severity, priority);
            int days = MoMUtil.getDays(prposalDate, dueDate);
            if (days > 0) {
                HashMap resolutioDays = IssueDetails.getResolutionDays();
                String sev = severity.substring(0, severity.indexOf("-"));
                String prio = priority.substring(0, severity.indexOf("-"));
                String finalval = prio + sev;
                int rdays = (Integer) resolutioDays.get(finalval);
                String prposalIssues[][] = IssueDetails.prposalIssues(pid, moduleId, rdays);
                String issueno = "";
                for (int i = 0; i < prposalIssues.length; i++) {
                    issueno = prposalIssues[i][0];
                    status = prposalIssues[i][1];
                    assignedTo = prposalIssues[i][2];
                    seve = prposalIssues[i][3];
                    pri = prposalIssues[i][4];
                    dued = prposalIssues[i][5];
                    String dueda = com.pack.ChangeFormat.getDateFormat(dued);

                    logger.info("ssssss" + issueno + " ,due date" + dueda);
                    prposalComment = connection.prepareStatement("insert into issuecomments(issueid,commentedby,comment_date,comments,status,commentedto,duedate,priority,severity) values(?,?,?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    logger.info("comment update:" + "issueno" + issueno + "," + GetProjectMembers.getAdminID() + "," + ts + "Due date is realigned because of issue # " + issueidFormat + "");
                    logger.info("comment update:" + "status" + status + "," + assignedTo + "," + java.sql.Date.valueOf(dueda) + "," + pri + "," + seve + "");
                    prposalComment.setString(1, issueno);
                    prposalComment.setString(2, user2);
                    prposalComment.setTimestamp(3, ts);
                    prposalComment.setString(4, "Due date is realigned because of issue# " + issueidFormat);
                    prposalComment.setString(5, status);
                    prposalComment.setString(6, assignedTo);
                    prposalComment.setDate(7, java.sql.Date.valueOf(dueda));
                    prposalComment.setString(8, pri);
                    prposalComment.setString(9, seve);
                    prposalComment.executeUpdate();

                    prposalissue = connection.prepareStatement("Update issue set due_date=? where issueid =?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    prposalissue.setDate(1, java.sql.Date.valueOf(dueda));
                    prposalissue.setString(2, issueno);
                    prposalissue.executeUpdate();
                }
            }

            //Committing the database
            connection.commit();
            connection.setAutoCommit(true);
            result = "created";

        } catch (Exception e) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                logger.error("Exception:" + ex);
            }
            logger.error("Exception:" + e);
        } finally {
            try {
                if (issuestatus != null) {
                    issuestatus.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (fetchProjectManager != null) {
                    fetchProjectManager.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (issuestatusSt != null) {
                    issuestatusSt.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (fetchProjectManagerSt != null) {
                    fetchProjectManagerSt.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (insertStatus_St != null) {
                    insertStatus_St.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (prposalComment != null) {
                    prposalComment.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (prposalissue != null) {
                    prposalissue.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (insertSeq != null) {
                    insertSeq.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (psComment != null) {
                    psComment.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return result;
    }

    @Override
    public ProjectDetail getProjectDetailByProduct(String product, String version, String module) {
        ProjectDetail detail = new ProjectDetail();
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rsForProject = stForProject.executeQuery("select customer, platform, p.pid, moduleid from project p, modules m where p.pid = m.pid and pname = '" + product + "' and version = '" + version + "' and module = '" + module + "'");
            if (rsForProject.next()) {

                detail.setPid(rsForProject.getInt("pid"));
                detail.setCustomer(rsForProject.getString("customer"));
                detail.setPlatform(rsForProject.getString("platform"));
                detail.setModuleId(rsForProject.getString("moduleid"));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }

        return detail;
    }

    @Override
    public List<String> getAllDomainsByProjectId(String pid) {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        List<String> domains = new ArrayList<String>();
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rsForProject = stForProject.executeQuery("SELECT project_domain from project where pid=" + pid);
            if (rsForProject.next()) {
                domains.add(rsForProject.getString("project_domain"));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return domains;
    }

    @Override
    public String readIssuesFromExcel(InputStream file, String projectId, Integer createdBy) {
        List sheetData = new ArrayList();
        int noOfRows = 0, noOfColumn = 0;
        String status = "";
        String process[] = {"Module", "Subject", "Description", "Root Cause", "Expected Result"};
        String excelProcess[] = new String[5];
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file);
            HSSFSheet sheet = workbook.getSheetAt(0);
            Iterator rows = sheet.rowIterator();
            while (rows.hasNext()) {
                HSSFRow row = (HSSFRow) rows.next();
                logger.info("NO of Cell" + row.getLastCellNum());
                Iterator cells = row.cellIterator();

                List data = new ArrayList();
                while (cells.hasNext()) {
                    HSSFCell cell = (HSSFCell) cells.next();
                    data.add(cell.getStringCellValue());
                    if (noOfRows == 0) {
                        excelProcess[noOfColumn] = cell.getStringCellValue();
                        noOfColumn++;
                    }
                }
                sheetData.add(data);
                noOfRows++;
            }
        } catch (IOException e) {
            logger.error(e.getMessage());

        }

        logger.info("No of Column Available is" + noOfColumn);
        if (noOfRows < 2) {
            status = "No Rows Available. Please Upload a Valid File";
        } else if (noOfColumn < 5) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for colums more than 5";
        } else if (!compareHeader(excelProcess, process)) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for header is not matching";
        } else {
            status = storeExcelData(sheetData, projectId, createdBy);
        }
        return status;

    }

    @Override
    public String readIssuesFromXlsx(InputStream file, String projectId, Integer createdBy) {
        List sheetData = new ArrayList();
        int noOfRows = 0, noOfColumn = 0;
        String status = "";
        String process[] = {"Module", "Subject", "Description", "Root Cause", "Expected Result"};
        String excelProcess[] = new String[5];
        try {
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            XSSFSheet sheet = workbook.getSheetAt(0);
            Iterator rows = sheet.rowIterator();
            while (rows.hasNext()) {
                XSSFRow row = (XSSFRow) rows.next();
                Iterator cells = row.cellIterator();
                List data = new ArrayList();
                while (cells.hasNext()) {
                    XSSFCell cell = (XSSFCell) cells.next();
                    data.add(cell.getStringCellValue());
                    if (noOfRows == 0) {
                        excelProcess[noOfColumn] = cell.getStringCellValue();
                        noOfColumn++;
                    }
                }
                sheetData.add(data);
                noOfRows++;
            }

        } catch (IOException e) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for IO Exception";
            e.printStackTrace();
        } catch (Exception e1) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for exception";
            e1.printStackTrace();
        }
        System.out.println("noOfColumn" + noOfColumn);
        if (noOfRows < 2) {
            status = "No Rows Available. Please Upload a Valid File";
        } else if (noOfColumn < 5) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for colums more than 5";
        } else if (!compareHeader(excelProcess, process)) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for header is not matching";
        } else {
            status = storeExcelData(sheetData, projectId, createdBy);
        }
        return status;
    }

    private boolean compareHeader(String[] excelProcess, String[] process) {
        boolean flag = true;
        for (int i = 0; i < process.length; i++) {
            if (!process[i].equalsIgnoreCase(excelProcess[i])) {
                flag = false;
            }
        }
        return flag;
    }

    private String storeExcelData(List sheetData, String projectId, Integer createdBy) {
        String status = "";
        String issueidFormat = null;
        String to = "", from = "", result;
        String pmanager = null;
        int pid = Integer.parseInt(projectId), count;
        String module = "", subject = "";
        String prjectName = GetProjects.getProjectName(projectId);
        try {
            Date addedOn = new Date();
            for (int i = 1; i < sheetData.size(); i++) {
                IssueFormBean ifb = new IssueFormBean();
                List list = (List) sheetData.get(i);
                ifb.setmName((String) list.get(0));
                ifb.setType("New Task");
                ifb.setSeverity("S3- Important");
                ifb.setPriority("P3-Medium");
                ifb.setSubject((String) list.get(1));
                ifb.setDescription((String) list.get(2));
                ifb.setRootCause((String) list.get(3));
                ifb.setExpResult((String) list.get(4));
                ifb.setpName(prjectName.split(":")[0]);
                ifb.setVersion(prjectName.split(":")[1]);
                ifb.setCreated(addedOn);
                ifb.setCreatedBy(createdBy + "");
                ifb.setModifiedDate(addedOn);
                ifb.setpId(pid);
                issueidFormat = generateIssueIdSeq();
                if (ifb.getSubject().length() > 200) {
                    ifb.setSubject(ifb.getSubject().substring(0, 199));
                }
                if (ifb.getDescription().length() > 4000) {
                    ifb.setDescription(ifb.getDescription().substring(0, 3999));
                }
                if (ifb.getRootCause().length() > 200) {
                    ifb.setRootCause(ifb.getRootCause().substring(0, 199));
                }
                if (ifb.getExpResult().length() > 2000) {
                    ifb.setExpResult(ifb.getExpResult().substring(0, 1999));
                }
                ifb.setDueDate(IssueDetails.proposeDuedate(ifb.getpName(), ifb.getmName(), ifb.getVersion(), ifb.getSeverity(), ifb.getPriority()));
                if (ifb.getDueDate() == null || "".equals(ifb.getDueDate())) {

                } else {
                    pmanager = GetProjectManager.getManager(ifb.getpName(), ifb.getVersion());
                    ProjectDetail projectDetail = getProjectDetailByProduct(ifb.getpName(), ifb.getVersion(), ifb.getmName());
                    if (projectDetail.getModuleId().equals("NA")) {
                        module = module + "," + ifb.getmName();
                    } else {
                        if (checkDuplicateIssue(ifb.getpId(), ifb.getSubject()) > 0) {
                            subject = subject + "," + ifb.getSubject();
                        } else {
                            result = createIssue(ifb.getDueDate(), issueidFormat, pid, ifb.getVersion(), ifb.getType(), projectDetail.getModuleId(), ifb.getSeverity(), ifb.getPriority(), ifb.getSubject(), ifb.getDescription(), ifb.getpName(), ifb.getRootCause(), ifb.getExpResult(), ifb.getmName(), ifb.getCreatedBy(), pmanager);
                        }
                    }
                }
            }
            if (module.length() == 0 && subject.length() == 0) {
                status = "The issues are uploaded successfully";
            } else if (module.length() > 0 && subject.length() > 0) {
                status = "Problem occured in issue creation because of module not available. " + module + ". Duplication issues. " + subject;
            } else if (module.length() > 0 && subject.length() == 0) {
                status = "Problem occured in issue creation because of module not available. " + module;
            } else if (subject.length() > 0 && module.length() == 0) {
                status = "The issues are uploaded successfully. Duplication subject avaialble. " + subject;
            }

        } catch (Exception ex) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed in storeExcelData ";
            ex.printStackTrace();
        }
        return status;
    }

    @Override
    public int checkDuplicateIssue(int projectId, String subject) {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        int count = 0;
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rsForProject = stForProject.executeQuery("select count(issueid) from issue where  subject = '" + subject + "' and PID=" + projectId);
            if (rsForProject.next()) {

                count = rsForProject.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return count;
    }

    @Override
    public String readIssuesFromExcelByAdmin(InputStream file, Integer createdBy) {
        List sheetData = new ArrayList();
        int noOfRows = 0, noOfColumn = 0;
        String status = "";
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file);
            HSSFSheet sheet = workbook.getSheetAt(0);
            Iterator rows = sheet.rowIterator();
            while (rows.hasNext()) {
                HSSFRow row = (HSSFRow) rows.next();
                Iterator cells = row.cellIterator();
                List data = new ArrayList();
                while (cells.hasNext()) {
                    HSSFCell cell = (HSSFCell) cells.next();
                    if (cell.getColumnIndex() == 0 || cell.getColumnIndex() == 2) {
                        data.add(cell.getStringCellValue());
                    }
                }
                sheetData.add(data);
                noOfRows++;
            }
        } catch (IOException e) {
            logger.error(e.getMessage());

        }

        logger.info("No of Column Available is" + noOfColumn);
        if (noOfRows < 2) {
            status = "No Rows Available. Please Upload a Valid File";
        } else {
            status = storeExcelDataByAdmin(sheetData, createdBy);
        }
        return status;
    }

    @Override
    public String readIssuesFromXlsxByAdmin(InputStream file, Integer createdBy) {
        List sheetData = new ArrayList();
        int noOfRows = 0, noOfColumn = 0;
        String status = "";

        try {
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            XSSFSheet sheet = workbook.getSheetAt(0);
            Iterator rows = sheet.rowIterator();
            while (rows.hasNext()) {
                XSSFRow row = (XSSFRow) rows.next();
                Iterator cells = row.cellIterator();
                List data = new ArrayList();
                while (cells.hasNext()) {
                    XSSFCell cell = (XSSFCell) cells.next();
                    if (cell.getColumnIndex() == 0 || cell.getColumnIndex() == 2) {
                        data.add(cell.getStringCellValue());
                    }

                }
                sheetData.add(data);
                noOfRows++;
            }

        } catch (IOException e) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for IO Exception";
            e.printStackTrace();
        } catch (Exception e1) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for exception";
            e1.printStackTrace();
        }
        System.out.println("noOfColumn" + noOfColumn);
        if (noOfRows < 2) {
            status = "No Rows Available. Please Upload a Valid File";
        } else {
            status = storeExcelDataByAdmin(sheetData, createdBy);
        }
        return status;
    }

    private String storeExcelDataByAdmin(List sheetData, Integer createdBy) {
        String status = "";
        String issueidFormat = null;
        String pmanager = null;
        int count;
        String module = "", subject = "", result, pidVersion, project = "";
        Set<String> projectList = new HashSet<String>();
        Set<String> moduleList = new HashSet<String>();
        Set<String> subjectList = new HashSet<String>();
        HashMap<String, String> projectdetails = GetProjects.getWorkingInProgressProjects();
        try {
            Date addedOn = new Date();
            for (int i = 1; i < sheetData.size(); i++) {
                IssueFormBean ifb = new IssueFormBean();
                List list = (List) sheetData.get(i);
                ifb.setpName((String) list.get(0));
                if (projectdetails.containsKey(ifb.getpName())) {
                    ifb.setmName("ABAP");
                    ifb.setType("New Task");
                    ifb.setSeverity("S3- Important");
                    ifb.setPriority("P3-Medium");
                    ifb.setSubject((String) list.get(1));
                    pidVersion = projectdetails.get(ifb.getpName());
                    ifb.setVersion(pidVersion.split(":")[1]);
                    ifb.setCreated(addedOn);
                    ifb.setCreatedBy(createdBy + "");
                    ifb.setModifiedDate(addedOn);
                    ifb.setpId(Integer.parseInt(pidVersion.split(":")[0]));
                    issueidFormat = generateIssueIdSeq();
                    if (ifb.getSubject().length() > 200) {
                        ifb.setSubject(ifb.getSubject().substring(0, 199));
                    }

                    ifb.setDueDate(IssueDetails.proposeDuedate(ifb.getpName(), ifb.getmName(), ifb.getVersion(), ifb.getSeverity(), ifb.getPriority()));
                    if (ifb.getDueDate() == null || "".equals(ifb.getDueDate())) {

                    } else {
                        pmanager = GetProjectManager.getManager(ifb.getpName(), ifb.getVersion());
                        ProjectDetail projectDetail = getProjectDetailByProduct(ifb.getpName(), ifb.getVersion(), ifb.getmName());
                        if (projectDetail.getModuleId().equals("NA")) {
                            moduleList.add(ifb.getmName());
                        } else {
                            if (checkDuplicateIssue(ifb.getpId(), ifb.getSubject()) > 0) {
                                subjectList.add(ifb.getSubject());
                            } else {
                                result = createIssue(ifb.getDueDate(), issueidFormat, ifb.getpId(), ifb.getVersion(), ifb.getType(), projectDetail.getModuleId(), ifb.getSeverity(), ifb.getPriority(), ifb.getSubject(), ifb.getSubject(), ifb.getpName(), ifb.getSubject(), ifb.getSubject(), ifb.getmName(), ifb.getCreatedBy(), pmanager);
                            }
                        }
                    }
                } else {
                    projectList.add(ifb.getpName());
                }
            }

            if (moduleList.isEmpty() && projectList.isEmpty()) {
                status = "The issues are uploaded successfully";
            }
            if (projectList.size() > 0) {
                status
                        = status + "\n - project not available. " + projectList.toString();
            }
            if (moduleList.size() > 0) {
                status = status + "\n - module not available. " + moduleList.toString();
            }

        } catch (Exception ex) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed in storeExcelData ";
            ex.printStackTrace();
        }
        return status;
    }

    @Override
    public List<IssueImageUrl> getIssueImagecommentswithRowid() {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        List<IssueImageUrl> issues = new ArrayList<IssueImageUrl>();
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select  a.ISSUEID,a.COMMENTS,rowid from issuecomments a where comments like '%googleusercontent%' and rowid not in (select distinct(issue_row_id) from issue_image_url)";
            rsForProject = stForProject.executeQuery(query);
            while (rsForProject.next()) {
                IssueImageUrl iiu = new IssueImageUrl();
                iiu.setIssueId(rsForProject.getString(1));
                iiu.setOrginialUrl(rsForProject.getString(2));
                iiu.setIssueRowId(rsForProject.getString(3));

                issues.add(iiu);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return issues;

    }

    @Override
    public int getAllImageURLCount() {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        int count = -1;
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rsForProject = stForProject.executeQuery("select count(*) from ISSUE_IMAGE_URL");
            if (rsForProject.next()) {

                count = rsForProject.getInt(1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return count;
    }

    @Override
    public int getImageURLCountByURL(String url, String issueRowId) {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        int count = -1;
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select count(*) from ISSUE_IMAGE_URL where ORGINIAL_URL='" + url + "' and issue_row_id='" + issueRowId + "'";
            rsForProject = stForProject.executeQuery(query);
            if (rsForProject.next()) {

                count = rsForProject.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return count;
    }

    @Override
    public void updateLocalURLinComments(String googleUrl, String localUrl, String rowid) {
        Connection connection = null;
        Statement stForProject = null;
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "update issuecomments set comments=Replace(comments,'" + googleUrl + "','" + localUrl + "') where rowid='" + rowid + "'";
            stForProject.executeUpdate(query);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
    }

    @Override
    public List<IssueImageUrl> getAllImageURLs() {
        Session session = null;
        Transaction trns = null;
        List<IssueImageUrl> urlList = new ArrayList<>();
        try {
            session = HibernateFactory.getCurrentSession();
            trns = session.beginTransaction();
            Query query = session.getNamedQuery("IssueImageUrl.findAll");
            urlList = (List<IssueImageUrl>) query.list();
        } catch (HibernateException e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return urlList;
    }

    @Override
    public List<IssueImageUrl> getImageURLByIds(List<Long> imageIds) {
        Session session = null;
        Transaction trns = null;
        List<IssueImageUrl> urlList = new ArrayList<>();
        try {
            session = HibernateFactory.getCurrentSession();
            trns = session.beginTransaction();
            Query query = session.getNamedQuery("IssueImageUrl.findByImageIds");
            query.setParameterList("imageIds", imageIds);
            urlList = (List<IssueImageUrl>) query.list();
        } catch (HibernateException e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return urlList;
    }

    @Override
    public HashMap<String, Integer> getPIdForIssues(String issues) {

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;

        HashMap<String, Integer> member = new HashMap<String, Integer>();

        try {
            connection = MakeConnection.getConnection();
            String query = "select issueid,pid from issue where issueid in (" + issues + ") ";
            ps = connection.prepareStatement(query);
            resultset = ps.executeQuery();
            while (resultset.next()) {
                member.put(resultset.getString(1), resultset.getInt(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return member;

    }

    @Override
    public HashMap<String, String> getPIDandStatus(String issue) {

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;

        HashMap<String, String> member = new HashMap<String, String>();

        try {
            connection = MakeConnection.getConnection();
            String query = "select i.pid,s.status from issue i,project p,issuestatus s where i.issueid=s.issueid and p.pid=i.pid and i.issueid='" + issue + "' ";
            ps = connection.prepareStatement(query);
            resultset = ps.executeQuery();
            while (resultset.next()) {
                member.put("pid", resultset.getString(1));
                member.put("status", resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return member;

    }

    @Override
    public void updateMainIssue(String mainIssue, String subIssue) {
        Connection connection = null;
        CallableStatement statement = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.prepareCall("{call SUB_ISSUE_LINK(?,?)}");
            statement.setString(1, mainIssue);
            statement.setString(2, subIssue);
            statement.executeUpdate();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException ex) {
                logger.error("Exception in updateMainIssue  Method" + ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                logger.error("Exception in updateMainIssue Method" + ex.getMessage());
            }
        }
    }

    @Override
    public String getMainIssue(String subIssue) {

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;

        String mainIssue = "";

        try {
            connection = MakeConnection.getConnection();
            String query = "select main_issue_id from issue_link where sub_issue_id='" + subIssue + "' ";
            ps = connection.prepareStatement(query);
            resultset = ps.executeQuery();
            while (resultset.next()) {
                mainIssue = resultset.getString(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return mainIssue;
    }

    @Override
    public List<IssueFormBean> getMyassignmentissues(int userId) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;
        List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();
        try {
            connection = MakeConnection.getConnection();
            String query ="select i.issueid,  CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age  from issue i,issuestatus s,project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and  i.pid = p.pid and i.ASSIGNEDTO="+userId+" and s.STATUS !='Closed'    order by pname, due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            ps = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = ps.executeQuery();
            String totalissuenos = "";
            while (resultset.next()) {
                totalissuenos = totalissuenos + "'" + resultset.getString("issueid").trim() + "',";
            }
            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
            Map<String, Integer> fileCountList = new HashMap<String, Integer>();
            List<LastAssginForm> lastAssign = new ArrayList<LastAssginForm>();
            if (totalissuenos.contains(",")) {
                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                lastAssign = IssueDetails.lastAssign();
            }
            resultset.beforeFirst();
            String p = "NA", sub = "", dueDateFormat = "", dueDate = "NA", dateString1 = "", create = "";
            int filesCount = 0,  lastAsigneeAge = 1;

            while (resultset.next()) {
                IssueFormBean isfb = new IssueFormBean();
                isfb.setSeverity(severityColor(resultset.getString("severity")));
                isfb.setIssueId(resultset.getString("issueid"));
                isfb.setType(resultset.getString("type"));
                String pri = resultset.getString("priority");
                p = "NA";
                if (pri != null) {
                    p = pri.substring(0, 2);
                }
                isfb.setPriority(p);

                isfb.setpName(resultset.getString("project"));
                if (isfb.getpName().length() >= 15) {
                    isfb.setRedPName(isfb.getpName().substring(0, 14) + "..");
                } else {
                    isfb.setRedPName(resultset.getString("project"));
                }
                isfb.setmName(resultset.getString("module"));
                if (isfb.getmName().length() >= 10) {
                    isfb.setRedMName(isfb.getmName().substring(0, 9) + "..");
                } else {
                    isfb.setRedMName(resultset.getString("module"));
                }
                sub = resultset.getString("subject");
                if (sub.length() > 42) {
                    sub = sub.substring(0, 42) + "...";
                }
                isfb.setSubject(sub);
                isfb.setDescription(resultset.getString("description"));
                isfb.setStatus(resultset.getString("status"));
                dueDateFormat = resultset.getDate("due_date").toString();
                dueDate = "NA";
                if (dueDateFormat != null) {
                    dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                }
                dateString1 = sdf.format(dateConversion.parse(resultset.getDate("modifiedon").toString()));
                create = sdf.format(dateConversion.parse(resultset.getDate("createdon").toString()));

                isfb.setDueDate(dueDate);
                if ((isfb.getStatus() != null) && (!isfb.getStatus().equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {
                    isfb.setDueDateColor("red");
                } else if ((isfb.getStatus().equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                    isfb.setDueDateColor("red");
                } else {
                    isfb.setDueDateColor("#000000");
                }
                isfb.setModifiedOn(dateString1);
                isfb.setCreatedOn(create);
                if (resultset.getString("createdby") != null) {
                    isfb.setCreatedBy(resultset.getString("createdby"));
                }
                if (resultset.getString("assignedto") != null) {
                    isfb.setAssignto(resultset.getString("assignedto"));
                }
                filesCount = 0;
                if (fileCountList.containsKey(resultset.getString("issueid"))) {
                    filesCount = fileCountList.get(resultset.getString("issueid"));
                }

                if (filesCount > 0) {
                    isfb.setRefer("View Files(" + filesCount + ")");
                } else {
                    isfb.setRefer("No Files");
                }
                 lastAsigneeAge = 1;
                if (lastAsigneeAgeList.containsKey(resultset.getString("issueid"))) {
                    lastAsigneeAge = lastAsigneeAgeList.get(resultset.getString("issueid"));
                }
                if (lastAsigneeAge == 1) {
                    lastAsigneeAge = resultset.getInt("age");
                }

                if (lastAsigneeAge == 0) {
                    lastAsigneeAge = lastAsigneeAge + 1;
                }
                isfb.setAge(resultset.getInt("age"));
                isfb.setLastAssigneeAge(lastAsigneeAge);

                for (LastAssginForm lastAssignForm : lastAssign) {
                    if (resultset.getString("issueid").equals(lastAssignForm.getIssueId())) {
                        isfb.setLastAssigneeName(lastAssignForm.getLastAssigneeName());
                        isfb.setLastModifiedOn(lastAssignForm.getLastModifiedOn());
                    }
                }
                issuesList.add(isfb);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return issuesList;

    }

    @Override
    public void updateIssue(HttpServletRequest request) {
        java.util.Date d = new java.util.Date();
        String recipientMobile, recipientOperator, from, subject, host;
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        //Timestamp ts = new Timestamp(cal.getTimeInMillis());
        Timestamp ts = new Timestamp(new java.util.Date().getTime());
        Connection connection = null;
        PreparedStatement ps = null, insertPhase_St_A = null;
        Statement stForType = null, ischeckTypeIssue = null;
        ResultSet rsForType = null, isRPtypeIssue = null;
        String pid = null, mid = null;
        ApmComponentIssueController atc = new ApmComponentIssueController();


        String estimatedTime = null;

        String fname = (String) request.getSession().getAttribute("fName");
        String lname = (String) request.getSession().getAttribute("lName");
        String Name = fname + " " + lname;
        String uid = (String) request.getSession().getAttribute("uid");
        try {
            connection = MakeConnection.getConnection();
            String issueId = request.getParameter("issueId");
            // session.setAttribute("myAssignmentIssueId", issueId);
            String pName = null;
            String mName = null;
            if (request.getParameter("project") != null) {
                pName = request.getParameter("project");
            }
            if (request.getParameter("module") != null) {
                mName = request.getParameter("module");
            }
            String severity = request.getParameter("severity");
            String priority = request.getParameter("priority");
            String issueStatus = request.getParameter("issuestatus");

            String assignedto = request.getParameter("assignedto");
            String[] issueComponent = request.getParameterValues("issues");
            String comments = request.getParameter("comments");
            String fix_version = request.getParameter("fix_version");
            logger.info("---------" + fix_version);
            String dueDate = request.getParameter("date");
            if (request.getParameter("timeestimation") != null) {
                estimatedTime = request.getParameter("timeestimation");
            }
            if (estimatedTime == null) {
                estimatedTime = "0";
            }
            if (estimatedTime.equalsIgnoreCase("null")) {
                estimatedTime = "0";
                logger.info("estimatedTime" + estimatedTime);
            }
            String sapIssueType = request.getParameter("sapissuetype");

            logger.info("Sap Issue Type" + sapIssueType);
            String storeDate = null;
            java.sql.Date dbDate = null;
            if (dueDate != null) {
                if (!dueDate.equalsIgnoreCase("NA")) {
                    dueDate = dueDate.trim();
                    storeDate = com.pack.ChangeFormat.getDateFormat(dueDate);
                    dbDate = java.sql.Date.valueOf(storeDate);
                }
            }
            String projecttype = request.getParameter("projecttype");
            String phase = request.getParameter("phase");
            String subphase = request.getParameter("subphase");
            String subsubphase = request.getParameter("subsubphase");
            String subsubsubphase = request.getParameter("subsubsubphase");
            String escalator = request.getParameter("escalation");
            String mainIssue = request.getParameter("mainIssue");
            String que1 = request.getParameter("que1");
            String que2 = request.getParameter("que2");
            String que3 = request.getParameter("que3");
            String que4 = request.getParameter("que4");
            String que5 = request.getParameter("que5");
            String que6 = request.getParameter("que6");
            String que7 = request.getParameter("que7");
            String que8 = request.getParameter("que8");
            String que9 = request.getParameter("que9");
            String que10 = request.getParameter("que10");

            if (subphase != null) {
                if (subphase.equalsIgnoreCase("--Select One--")) {
                    subphase = null;
                }
            }
            if (subsubphase != null) {
                if (subsubphase.equalsIgnoreCase("--Select One--")) {
                    subsubphase = null;
                }
            }
            if (subsubsubphase != null) {
                if (subsubsubphase.equalsIgnoreCase("--Select One--")) {
                    subsubsubphase = null;
                }
            }

            int x = 0, y = 0, z = 0;

            //Checking the status to make sure that it's a valid
            if (projecttype != null) {
                issueStatus = StatusValidation.isSAPStatusCorrect(projecttype, issueStatus, issueId);
            } else {
                issueStatus = StatusValidation.isStatusCorrect(issueStatus, issueId);
            }
            EscalationDAO escalationDAO = new EscalationDAOImpl();
            String escStaus = escalationDAO.getEscalationStatus(issueId);
            if (escalator == null) {
                escalator = escStaus;
            }
            if (comments != "") {
                try {
                    //                        CommentAccess.UpdateComments(issueId, uid, comments, priority, severity, dbDate, assignedto, issueStatus);
                    ps = connection.prepareStatement("insert into issuecomments(issueid,commentedby,comment_date,comments,status,commentedto,duedate,priority,severity) values(?,?,?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ps.setString(1, issueId);
                    ps.setString(2, uid);
                    ps.setTimestamp(3, ts);
                    ps.setString(4, request.getParameter("comments"));
                    ps.setString(5, issueStatus);
                    ps.setString(6, assignedto);
                    ps.setDate(7, dbDate);
                    ps.setString(8, priority);
                    ps.setString(9, severity);

                    x = ps.executeUpdate();
                    //		logger.info("Inserted one row:\t"+l);

                } catch (Exception e) {
                    logger.error("Exception in comment insertion:" + e);
                } finally {
                    if (ps != null) {
                        ps.close();
                    }
                }
            }

            String rating = request.getParameter("feedback");
            String newModule = request.getParameter("newModule");
            String feedback = request.getParameter("feedbackString");
            String type = request.getParameter("newType");
            try {
                // When issue is moved to new version need to update project id and module id
                pid = ProjectFinder.getProjectId(pName, fix_version);
                mid = ProjectFinder.getModuleId(pName, fix_version, mName);

                String fversion = request.getParameter("oldfixversion");
                String usub = request.getParameter("usub");
                String udes = request.getParameter("udes");
                String uexpected_result = request.getParameter("uexpected_result");

                String extendedQuery = "";
                int newModuleId = 0;
                if (newModule != null) {
                    newModuleId = MoMUtil.parseInteger(newModule, newModuleId);
                }
                if (!fversion.equalsIgnoreCase(fix_version)) {

                    extendedQuery = ",pid=?,module_id=?";

                }
                if (newModuleId > 0) {
                    mid = newModule;
                    extendedQuery = extendedQuery + ",module_id=?";
                }
                if (issueStatus.equalsIgnoreCase("Closed")) {
                    if (rating == null || rating == "") {
                        rating = "Good";
                    }
                }
                if (type == null) {
                    type = "New Task";
                }
                logger.info("DATE:" + new java.sql.Date(cal.getTimeInMillis()));
                if (usub != null && udes != null && uexpected_result != null) {
                    ps = connection.prepareStatement("update issue set severity=?, priority=?, assignedto=?, modifiedon=?, due_date = ?, rating = ?, feedback = ?,estimated_time=?,sap_issue_type=?, subject =?, description=?,EXPECTED_RESULT=?,ESCALATION=?,type=?  " + extendedQuery + "where issueid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ps.setString(1, severity);
                    ps.setString(2, priority);
                    ps.setString(3, assignedto);
                    ps.setDate(4, new java.sql.Date(cal.getTimeInMillis()));
                    ps.setDate(5, dbDate);
                    ps.setString(6, rating);
                    ps.setString(7, feedback);
                    ps.setString(8, estimatedTime);
                    ps.setString(9, sapIssueType);
                    ps.setString(10, usub);
                    ps.setString(11, udes);
                    ps.setString(12, uexpected_result);
                    ps.setString(13, escalator);
                    ps.setString(14, type);
                    int i = 15;
                    logger.info("fuVersion!=fxVersion" + fversion + "," + fix_version);
                    if (!fversion.equalsIgnoreCase(fix_version)) {
                        logger.info("fuVersion!=fxVersion" + fversion + "," + fix_version);
                        ps.setString(i, pid);
                        ps.setString(i + 1, mid);
                        i = i + 2;
                    } else if (newModuleId > 0) {
                        ps.setString(i, mid);
                        i++;
                    }
                    ps.setString(i, issueId);
                } else {
                    ps = connection.prepareStatement("update issue set severity=?, priority=?, assignedto=?, modifiedon=?, due_date = ?, rating = ?, feedback = ?,estimated_time=?,sap_issue_type=?,ESCALATION=?,type=? " + extendedQuery + "where issueid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ps.setString(1, severity);
                    ps.setString(2, priority);
                    ps.setString(3, assignedto);
                    ps.setDate(4, new java.sql.Date(cal.getTimeInMillis()));
                    ps.setDate(5, dbDate);
                    ps.setString(6, rating);
                    ps.setString(7, feedback);
                    ps.setString(8, estimatedTime);
                    ps.setString(9, sapIssueType);
                    ps.setString(10, escalator);
                    ps.setString(11, type);
                    int i = 12;
                    logger.info("fuVersion!=fxVersion" + fversion + "," + fix_version);
                    if (!fversion.equalsIgnoreCase(fix_version)) {
                        logger.info("fuVersion!=fxVersion" + fversion + "," + fix_version);
                        ps.setString(10, pid);
                        ps.setString(11, mid);
                        i = 12;
                    } else if (newModuleId > 0) {
                        ps.setString(i, mid);
                        i++;
                    }
                    ps.setString(i, issueId);
                }
                y = ps.executeUpdate();

            } catch (Exception e) {
                logger.error("Exception in issue update:" + e);
            } finally {
                if (ps != null) {
                    ps.close();
                }
            }

            try {
                ps = connection.prepareStatement("update issuestatus set status=? where issueid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ps.setString(1, issueStatus);
                ps.setString(2, issueId);
                z = ps.executeUpdate();
                logger.info("Updated the issue status:\t" + z);
            } catch (Exception e) {
                logger.error("Exception in issue status update:" + e);
            } finally {
                if (ps != null) {
                    ps.close();
                }
            }
            try {
                if (projecttype != null) {
                    if (projecttype.equals("Implementation")) {
                        PreparedStatement insertPhase_St = connection.prepareStatement("update issue_implementation set phase=?,subphase=?,subsubphase=?,subsubsubphase=?,projecttype=? where issueid=?");//CHANGED
                        insertPhase_St.setString(1, phase);
                        insertPhase_St.setString(2, subphase);
                        insertPhase_St.setString(3, subsubphase);
                        insertPhase_St.setString(4, subsubsubphase);
                        insertPhase_St.setString(5, projecttype);
                        insertPhase_St.setString(6, issueId);
                        insertPhase_St.executeUpdate();
                        connection.commit();
                    } else if (projecttype.equals("Upgradation")) {
                        PreparedStatement insertPhase_St3 = connection.prepareStatement("update issue_upgradation set phase=?,subphase=?,subsubphase=?,subsubsubphase=?,projecttype=? where issueid=?");//CHANGED
                        insertPhase_St3.setString(1, phase);
                        insertPhase_St3.setString(2, subphase);
                        insertPhase_St3.setString(3, subsubphase);
                        insertPhase_St3.setString(4, subsubsubphase);
                        insertPhase_St3.setString(5, projecttype);
                        insertPhase_St3.setString(6, issueId);
                        insertPhase_St3.executeUpdate();
                        connection.commit();
                    } else if (projecttype.equals("Support")) {
                        PreparedStatement insertPhase_St6 = connection.prepareStatement("update issue_support set phase=?,subphase=?,subsubphase=?,subsubsubphase=?,projecttype=? where issueid=?");//CHANGED
                        insertPhase_St6.setString(1, phase);
                        insertPhase_St6.setString(2, subphase);
                        insertPhase_St6.setString(3, subsubphase);
                        insertPhase_St6.setString(4, subsubsubphase);
                        insertPhase_St6.setString(5, projecttype);
                        insertPhase_St6.setString(6, issueId);
                        insertPhase_St6.executeUpdate();
                        connection.commit();
                    }
                }
            } catch (Exception e) {
                logger.error("Exception in Phase Details:" + e);
            } finally {
                if (ps != null) {
                    ps.close();
                }
            }
            // Adding Test Cases
            try {
                int userId = Integer.parseInt(uid);
                String addTestCase = request.getParameter("testcaseindev");
                logger.info("Dev Test case" + addTestCase);
                if (issueStatus.equalsIgnoreCase("QA-BTC") || addTestCase != null) {
                    String descriptionComments = "";
                    String[] functionality = request.getParameterValues("functionality");
                    String[] expectedresult = request.getParameterValues("expectedresult");
                    String[] description = request.getParameterValues("description");
                    int pId = Integer.parseInt(pid);
                    int mId = Integer.parseInt(mid);
                    if (functionality != null) {
                        for (int i = 0; i < functionality.length; i++) {
                            logger.info("Func->" + functionality[i] + "--Result->" + expectedresult[i] + "-->Desc" + description[i]);
                            TqmUtil.createIssuePTC(pId, mId, functionality[i], description[i], expectedresult[i], userId, issueId);
                            descriptionComments = description[i];
                        }
                        comments = "Added Test Case: " + descriptionComments;
                    }
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }

            try {

                String fversion = request.getParameter("oldfixversion");
                String newprojecttype = null;
                if (!fversion.equalsIgnoreCase(fix_version)) {
                    pid = ProjectFinder.getProjectId(pName, fix_version);
                    logger.info("pid------------>" + pid);
                    stForType = connection.createStatement();
                    rsForType = stForType.executeQuery("select type from project_type where pid = " + pid);
                    if (rsForType.next()) {
                        newprojecttype = rsForType.getString("type");
                        logger.info("pid------------>" + newprojecttype);
                    }
                    ischeckTypeIssue = connection.createStatement();
                    isRPtypeIssue = ischeckTypeIssue.executeQuery("select issueid from Issue_" + newprojecttype + " where issueid = '" + issueId + "'");
                    boolean createIssueType = true;
                    if (isRPtypeIssue.next()) {
                        createIssueType = false;
                    }
                    if (createIssueType == true) {
                        String fixphase = null, fixsubphase = null, fixsubsubphase = null, fixsubsubsubphase = null;
                        if (newprojecttype != null) {
                            fixphase = "Project Preparation";
                            fixsubphase = "Actual situation analysis";
                            if (newprojecttype.equals("Implementation")) {

                                fixsubphase = "Implementation Scope";
                                fixsubsubphase = "Project deliverables";
                                insertPhase_St_A = connection.prepareStatement("insert into issue_implementation(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                                insertPhase_St_A.setString(1, issueId);
                                insertPhase_St_A.setString(2, fixphase);
                                insertPhase_St_A.setString(3, fixsubphase);
                                insertPhase_St_A.setString(4, fixsubsubphase);
                                insertPhase_St_A.setString(5, fixsubsubsubphase);
                                insertPhase_St_A.setString(6, newprojecttype);
                                insertPhase_St_A.executeUpdate();

                            } else if (newprojecttype.equals("Upgradation")) {

                                insertPhase_St_A = connection.prepareStatement("insert into issue_upgradation(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                                insertPhase_St_A.setString(1, issueId);
                                insertPhase_St_A.setString(2, fixphase);
                                insertPhase_St_A.setString(3, fixsubphase);
                                insertPhase_St_A.setString(4, fixsubsubphase);
                                insertPhase_St_A.setString(5, fixsubsubsubphase);
                                insertPhase_St_A.setString(6, newprojecttype);
                                insertPhase_St_A.executeUpdate();

                            } else if (newprojecttype.equals("Support")) {

                                insertPhase_St_A = connection.prepareStatement("insert into issue_support(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                                insertPhase_St_A.setString(1, issueId);
                                insertPhase_St_A.setString(2, fixphase);
                                insertPhase_St_A.setString(3, fixsubphase);
                                insertPhase_St_A.setString(4, fixsubsubphase);
                                insertPhase_St_A.setString(5, fixsubsubsubphase);
                                insertPhase_St_A.setString(6, newprojecttype);
                                insertPhase_St_A.executeUpdate();

                            }
                        }
                    }
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            } finally {
                if (stForType != null) {
                    stForType.close();
                }
                if (rsForType != null) {
                    rsForType.close();
                }
                if (insertPhase_St_A != null) {
                    insertPhase_St_A.close();
                }
                if (ischeckTypeIssue != null) {
                    ischeckTypeIssue.close();
                }
                if (isRPtypeIssue != null) {
                    isRPtypeIssue.close();
                }

            }
            try {
                if (connection != null) {
                    UpdateValue.updateUserValue(connection, Integer.parseInt(uid));
                }
            } catch (Exception e) {
                logger.error("Exception in User Value update" + e);
            }
            try {
                if (issueStatus.equalsIgnoreCase("Closed")) {
                    pid = ProjectFinder.getProjectId(pName, fix_version);
                    TeamWiseMom t = new TeamWiseMom();
                    long prid = MoMUtil.parseLong(pid, 0l);
                    int wrmid = t.findMaxWRMDay(prid);
                    if (wrmid != 0) {
                        ApmWrmPlan apmWrmPlan = new ApmWrmPlan();
                        apmWrmPlan = t.findByWRMId(wrmid);
                        ApmAdditionalClosed apmAdditionalClosed = new ApmAdditionalClosed(0l, issueId, apmWrmPlan);
                        ModelDAO.save("ApmAdditionalClosed", apmAdditionalClosed);
                    }
                }

                if (mainIssue != null && !mainIssue.equals("")) {
                    new IssueDAOImpl().updateMainIssue(mainIssue, issueId);
                }
                if (comments.contains("googleusercontent")) {
                    UpdateIssue.updateIssueImageURL(issueId, comments);
                }
            } catch (Exception e) {
                logger.error("Exception in ApmAdditionalClosed" + e);
            }
            try {
                atc.addIssues(issueComponent, issueId);
            } catch (Exception e) {
                logger.error("Exception in component" + e);
            }
            Session ses1 = null;
            if (x > 0 || y > 0 || z > 0) {
                Statement username = connection.createStatement();
                ResultSet res = username.executeQuery("select email,mobile,mobileoperator from users where userid=" + assignedto);
                try {

                    res.next();
                    String to = res.getString(1);
                    recipientMobile = res.getString(2);
                    recipientOperator = res.getString(3);

                    /* Eliminating hyphen in mobile no*/
                    recipientMobile = recipientMobile.replaceAll("-", "");

                    subject = request.getParameter("sub").trim();
                    String issStatus = request.getParameter("issuestatus");
                    String description = request.getParameter("des");
                    String customer = request.getParameter("customer");
                    String project = request.getParameter("project");
                    String version = request.getParameter("version");
                    String module = request.getParameter("module");
                    String platform = request.getParameter("platform");
                    String createdby = request.getParameter("creby");
                    String rootCause = request.getParameter("rootcause");
                    String expectedResult = request.getParameter("expected_result");

                    ArrayList<String> al = dashboard.Project.getDetails(project + ":" + version);
                    ArrayList<String> dateAndTime = CurrentDay.getDateTime();

                    //     logger.error(dateAndTime.toString());
                    String createdOn = (String) request.getSession().getAttribute("createdOn");
//                String foundVersion = (String) session.getAttribute("foundVersion");
                    String font = "#000000";
                    DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                    java.util.Date da = df.parse(dueDate);
                    String viewDueDate = sdf.format(da);

                    if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(viewDueDate) == true)) {
                        font = "RED";
                    }
                    String Subject = "eTracker " + issStatus + " Issue :  " + subject;

                    if (issStatus.equalsIgnoreCase("Closed")) {
                        Subject = "eTracker " + issStatus + " Issue with " + rating + " Rating :  " + subject;
                    }
                    HashMap cr = IssueDetails.getCRID(issueId);
                    logger.info("No Of CR" + cr);
                    String crHtml = "";
                    if (cr.size() > 0) {
                        Collection setCR = cr.keySet();
                        Iterator iterCR = setCR.iterator();
                        while (iterCR.hasNext()) {
                            String key = (String) iterCR.next();
                            String desc = (String) cr.get(key);
                            crHtml = "<tr height='21'><td width='13%'><B><font face=Verdana, Arial, Helvetica, sans-serif size=2 >CR ID </B></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + key + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >CR ID Desc.</b></td><td colspan=2><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + desc + "</td></tr>";
                        }
                    }
                    String htmlContent = "<b><font color=blue >Project Details</font></b><table width=100% > <font face=Verdana, Arial, Helvetica, sans-serif size=2 >"
                            + "<tr bgcolor=#E8EEF7 ><td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Project</b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + project + "</font></td>"
                            + "<td width = 18% ><b> <font face=Verdana, Arial, Helvetica, sans-serif size=2 >Customer </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + customer + "</td>"
                            + "</tr>"
                            + "<tr><td width   = 18% ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 > Version </b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + version + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Manager</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(al.get(0)) + "</td> "
                            + "</tr>"
                            + "<tr  bgcolor=#E8EEF7><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b> Status </b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(4) + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Phase</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(1) + "</td> "
                            + "</tr>"
                            + "<tr><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Start Date</b> </td>"
                            + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(2) + "</td>"
                            + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>End Date</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(3) + "</td>"
                            + "</tr></table><br><font color=blue><b>Updated Issue details</b></font><table width=100% >"
                            + "<tr bgcolor=#E8EEF7><td width = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Issue ID</b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + issueId + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Type </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + type + "</td>"
                            + "</tr>" + "<tr  >"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Created By</b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(createdby) + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Created On</b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + createdOn + "</td>"
                            + "</tr>"
                            + "<tr bgcolor=#E8EEF7><td width   = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Priority </b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + priority + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Severity</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + severity + "</td> "
                            + "</tr>"
                            + "<tr ><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Module</b> </td>"
                            + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + module + "</td>"
                            + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Platform</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + platform + "</td>"
                            + "</tr>"
                            + "<tr bgcolor=#E8EEF7><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Assigned To</b> </td>"
                            + "<td width  = 32%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(assignedto) + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Fix Version </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + fix_version + "</td>"
                            + "</tr>"
                            + "<tr ><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Updated By</b> </td>"
                            + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Name + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Updated On </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + dateAndTime.get(0) + " " + dateAndTime.get(1) + "</td>"
                            + "</tr>"
                            + "<tr bgcolor=#E8EEF7>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Issue Status </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + issStatus + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Due Date</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=" + font + ">" + viewDueDate + "</font></td>"
                            + "</tr>" + crHtml
                            + "<tr><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Subject</b> </td>"
                            + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + subject + "</td>"
                            + "</tr>"
                            + "<tr bgcolor=#E8EEF7><td width  = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Description</b> </td>"
                            + "<td width  = 82%  colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + description + "</td>"
                            + "</tr>"
                            + "<tr ><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Root Cause</b> </td>"
                            + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + rootCause + "</td>"
                            + "</tr>"
                            + "<tr ><td width  = 18% bgcolor=#E8EEF7><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Expected Result</b> </td>"
                            + "<td width  = 82% colspan=3  bgcolor=#E8EEF7><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + expectedResult + "</td>"
                            + "</tr>"
                            + "<tr><td width  = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Comments</b> </td>"
                            + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + comments + "</td>"
                            + "</tr>"
                            + "</font>";
                    if (issStatus.equalsIgnoreCase("Closed")) {
                        String ratingColor = "#000000";
                        if (rating == "Excellent") {
                            ratingColor = "#74DF00";
                        } else if (rating == "Need Improvement") {
                            ratingColor = "#FF0000";
                        } else if (rating == "Average") {
                            ratingColor = "#F78181";
                        } else if (rating == "Good") {
                            ratingColor = "#088A4B";
                        }

                        htmlContent = htmlContent + "<tr><td width  = 18%  bgcolor=#E8EEF7><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Rating</b> </td>"
                                + "<td width  = 82% colspan=3 bgcolor=#E8EEF7><font color='" + ratingColor + "' face=Verdana, Arial, Helvetica, sans-serif size=2 >" + rating + "</td>"
                                + "</tr>";
                        if (feedback != null && feedback != "") {
                            htmlContent = htmlContent + "<tr><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Feedback</b> </td>"
                                    + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + feedback + "</td>"
                                    + "</tr>";
                        }
                    }

                    String endLine = "</table><br>Thanks,";
                    String signature = "<br>eTracker&trade;<br>";
                    String emi = "<br><b><a href=http://www.eminentlabs.net/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                    String lineBreak = "<br>";

                    String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.net/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                    htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;
                    SendMail.mailUpdate(issueId, Subject, htmlContent, Name, assignedto);

                    if ((escalator != null && "yes".equalsIgnoreCase(escalator)) && ("no".equalsIgnoreCase(escStaus))) {
                        MoMUtil.createTask(Integer.parseInt(assignedto), issueId, Integer.parseInt(uid), "Issue", "Planned");
                        java.util.Date plann = new java.util.Date();
                        long plannedId = ProjectPlanUtil.uniqueProjectPlan(Long.parseLong(pid), issueId, plann);
                        if (plannedId == 0l) {
                            ProjectPlannedIssue projectPlannedIssue = new ProjectPlannedIssue(Long.valueOf(pid), issueId, Integer.parseInt(uid), plann, plann, plann, PlanStatus.ACTIVE.getStatus());
                            ProjectPlanUtil.createProjectPlanIssue(projectPlannedIssue);
                        } else {
                            ProjectPlannedIssue ppi = new ProjectPlannedIssue();
                            ppi.setId(plannedId);
                            ppi.setIssueId(issueId);
                            ppi.setpId(Long.valueOf(pid));
                            ppi.setPlannedBy(Integer.parseInt(uid));
                            ppi.setStatus(PlanStatus.getACTIVE().getStatus());
                            ppi.setPlannedOn(plann);
                            ppi.setCreatedOn(plann);
                            ppi.setModifiedOn(plann);
                            ProjectPlanUtil.updateProjectPlanIssue(ppi);
                        }

                        try {
                            ps = connection.prepareStatement("insert into ESCALATION_ISSUE values(?,?,?,?,?,?,?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            ps.setString(1, issueId);
                            ps.setString(2, que1);
                            ps.setString(3, que2);
                            ps.setString(4, que3);
                            ps.setString(5, que4);
                            ps.setString(6, que5);
                            ps.setString(7, que6);
                            ps.setString(8, que7);
                            ps.setString(9, que8);
                            ps.setString(10, que9);
                            ps.setString(11, que10);
                            ps.setTimestamp(12, ts);
                            ps.setInt(13, Integer.parseInt(uid));
                            x = ps.executeUpdate();

                        } catch (Exception e) {
                            logger.error("Exception in comment insertion:" + e);
                        } finally {
                            if (ps != null) {
                                ps.close();
                            }
                        }
                        Subject = "Escalation Issue : " + issueId + " - " + subject;
                        htmlContent = "<table style='width:99%;'><tr style='background-color: #E8EEF7;height:21px;'><td style='font-weight: bold;'>Question</td><td style='font-weight: bold;'>Answer</td><tr>"
                                + "<tr style='height:21px;background-color: white;'><td><b>Is requirement provided clearly?</b></td><td>" + que1 + "</td></tr>"
                                + "<tr style='height:21px;background-color: #E8EEF7;'><td><b>Is QA-BTC reviewed to make the requirement understandable to all?</b></td><td>" + que2 + "</td></tr>"
                                + "<tr style='height:21px;background-color: white;'><td><b>Is the issue highlighted in WRM before escalation?</b></td><td>" + que3 + "</td></tr>"
                                + "<tr style='height:21px;background-color: #E8EEF7;'><td><b>Is the  WRM highlighted issue planned daily?</b></td><td>" + que4 + "</td></tr>"
                                + "<tr style='height:21px;background-color: white;'><td><b>Is the issue escalated in production?</b></td><td>" + que5 + "</td></tr>"
                                + "<tr style='height:21px;background-color: #E8EEF7;'> <td><b>Is the issue replicable in quality?</b></td><td>" + que6 + "</td></tr>"
                                + "<tr style='height:21px;background-color: white;'>  <td><b>Is access to Development,Quality and Production provided?</b></td><td>" + que7 + "</td></tr>"
                                + "<tr style='height:21px;background-color: #E8EEF7;'><td><b>Is sufficient authorization provided with debug option to resolve this issue?</b></td><td>" + que8 + "</td></tr>"
                                + "<tr style='height:21px;background-color: white;'> <td><b>Is sufficient time provided to resolve this issue?</b></td><td>" + que9 + "</td></tr>"
                                + "<tr style='height:21px;background-color: #E8EEF7;'> <td><b>Is the issue escalated questioning the capability of Eminentlabs?</b></td><td>" + que10 + "</td></tr>";
                        htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;
                        SendMail.escalationMail(htmlContent, Subject, Name, assignedto);
                    }

                } catch (Exception exec) {
                    logger.error("Exception in mail sending:" + exec.getMessage());

                } finally {
                    if (username != null) {
                        username.close();
                    }
                    if (res != null) {
                        res.close();
                    }

                }

            }
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            try {

                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

    }

    @Override
    public String updatIssue() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
