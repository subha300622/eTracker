/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminent.util.GetProjectMembers;
import com.pack.StringUtil;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class ApplicantView {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ApplicantView");
    }
    private String applicantId;
    private String name, fullName;
    private String phone;
    private String mobile;
    private String mail, mailId;
    private String location;
    private String refBy;
    private String ug;
    private String ugBranch;
    private String ugInstitue;
    private String ugYear;
    private String ugPer;
    private String pg;
    private String pgBranch;
    private String pgInstitue;
    private String pgYear;
    private String pgPer;
    private String sapExp;
    private String functionalArea;
    private String totalExp;
    private String expertise;
    private String languages, fullLang;
    private String erpPackages;
    private String os;
    private String dataBase;
    private String toolsAndUtil;
    private String prevEmployer;
    private String prevDesignation;
    private String prevCtc;
    private String prevJoinDate;
    private String prevRelDate;
    private String prevRole;
    private String jobProfile;
    private String jobType;
    private String desiredPosition;
    private String desiredLocation;
    private Integer status = 10;
    private Integer assignedTo;
    private String comment;
    private String areaOfExpertise;
    private String sapExpyr;
    private String sapExpMo;
    private String totExpyr;
    private String totExpMo;
    private String apj;
    private String water;
    private String rti;
    private String rte;
    private String habits;
    private String social;
    private String photoFile;
    private int fileCount;
    private int isFake;
    private String aadhaar;

    Map<Integer, String> statuses = new LinkedHashMap<Integer, String>();
    Map<Integer, String> eminentUsers = GetProjectMembers.getEminentUsers();

    public void viewApplicant(HttpServletRequest request) {
        String filePathone = request.getSession().getServletContext().getInitParameter("upload-user-photo");
        File photoDir = new File(filePathone);
        FileAttachDAO attachDAO = new FileAttachDAO();
        applicantId = (String) request.getParameter("apid");
        ErmApplicant ep = ERMUtil.findByApplicantId(applicantId);
        fileCount = attachDAO.findFileCountForApplicantId(applicantId);
        name = ep.getFirstname() + " " + ep.getLastname();
        fullName = name;
        if ((name.length()) > 20) {
            name = name.substring(0, 19) + "...";
        }
        if (ep.getPhone() != null) {
            phone = ep.getPhone();
        } else {
            phone = "";
        }
        mobile = ep.getMobile();
        mail = ep.getEmail();
        mailId = mail;
        if ((mail.length()) > 20) {
            mail = mail.substring(0, 19) + "...";
        }
        if (ep.getCurrentLocation() != null) {
            location = ep.getCurrentLocation();
        } else {
            location = "";
        }
        refBy = GetProjectMembers.getUserNameByEid(ep.getReferenceEmpid()) + " - " + ep.getReferenceEmpid();
        if (ep.getUg() != null) {
            ug = ep.getUg();
        } else {
            ug = "";
        }
        if (ep.getUgBranch() != null) {
            ugBranch = ep.getUgBranch();
        } else {
            ugBranch = "";
        }
        if (ep.getUgInstitute() != null) {
            ugInstitue = ep.getUgInstitute();
        } else {
            ugInstitue = "";
        }
        if (ep.getUgYear() != null) {
            ugYear = ep.getUgYear();
        } else {
            ugYear = "";
        }
        if (ep.getUgPercentage() != null) {
            ugPer = ep.getUgPercentage();
        } else {
            ugPer = "";
        }

        if (ep.getPg() != null) {
            pg = ep.getPg();
        } else {
            pg = "";
        }
        if (ep.getPgBranch() != null) {
            pgBranch = ep.getPgBranch();
        } else {
            pgBranch = "";
        }
        if (ep.getPgInstitute() != null) {
            pgInstitue = ep.getPgInstitute();
        } else {
            pgInstitue = "";
        }
        if (ep.getPgYear() != null) {
            pgYear = ep.getPgYear();
        } else {
            pgYear = "";
        }
        if (ep.getPgPercentage() != null) {

            pgPer = ep.getPgPercentage();
        } else {
            pgPer = "";
        }
        if (ep.getSapExpYr() == null) {
            sapExpyr = "0";
        } else {
            sapExpyr = ep.getSapExpYr().toString();
        }
        if (ep.getSapExpMon() == null) {
            sapExpMo = "0";
        } else {
            sapExpMo = ep.getSapExpMon().toString();
        }
        sapExp = sapExpyr + "Y " + sapExpMo + "M";
        if (ep.getAreaOfExpertise() != null) {
            areaOfExpertise = ep.getAreaOfExpertise();
        } else {
            areaOfExpertise = "";
        }
        if (ep.getCoreCompetence().equals("T")) {
            functionalArea = "Technical";
        }else
        if (ep.getCoreCompetence().equals("F")) {
            functionalArea = "Functional";
        }else
        if (ep.getCoreCompetence().equals("TF")) {
            functionalArea = "Techno Functional";
        }else{
            functionalArea = ep.getCoreCompetence();
        }
        if (ep.getTotalExpYr() == null) {
            totExpyr = "0";
        } else {
            totExpyr = ep.getTotalExpYr().toString();
        }
        if (ep.getTotalExpMon() == null) {
            totExpMo = "0";
        } else {
            totExpMo = ep.getTotalExpMon().toString();
        }
        totalExp = totExpyr + "Y " + totExpMo + "M";
        expertise = ep.getAreaOfExpertise();
        if (ep.getLanguages() != null) {
            fullLang = ep.getLanguages();
            if (ep.getLanguages().length() > 20) {
                languages = ep.getLanguages().substring(0, 19) + "...";
            } else {
                languages = StringUtil.encodeHtmlTag(ep.getLanguages());
            }
        } else {
            languages = "";
            fullLang = "";
        }

        if (ep.getErpPackages() != null) {
            erpPackages = StringUtil.encodeHtmlTag(ep.getErpPackages());
        } else {
            erpPackages = "";
        }
        if (ep.getOs() != null) {
            os = StringUtil.encodeHtmlTag(ep.getOs());
        } else {
            os = "";
        }
        if (ep.getDb() != null) {
            dataBase = StringUtil.encodeHtmlTag(ep.getDb());
        } else {
            dataBase = "";
        }
        if (ep.getTools() != null) {
            toolsAndUtil = StringUtil.encodeHtmlTag(ep.getTools());
        } else {
            toolsAndUtil = "";
        }
        findExpirienceByPrev(applicantId);
        if (ep.getDesiredJobType() != null) {
            jobType = ep.getDesiredJobType();
        } else {
            jobType = "";
        }

        if (ep.getDesiredPosition() != null) {
            desiredPosition = ep.getDesiredPosition();
        } else {
            desiredPosition = "";
        }

        if (ep.getLanguages() != null) {
            desiredLocation = ep.getDesiredLocation();
        } else {
            desiredLocation = "";
        }
        if (ep.getWater() != null) {
            water = ep.getWater();
        } else {
            water = "NA";
        }
        if (ep.getRti() != null) {
            rti = ep.getRti();
        } else {
            rti = "NA";
        }
        if (ep.getRte() != null) {
            rte = ep.getRte();
        } else {
            rte = "NA";
        }
        if (ep.getHabits() != null) {
            habits = ep.getHabits();
        } else {
            habits = "NA";
        }
        if (ep.getSocial() != null) {
            social = ep.getSocial();
        } else {
            social = "NA";
        }
        if (ep.getApjBook() == 0) {
            apj = "No";
        } else {
            apj = "Yes";
        }

        photoFile = AssignedApplicants.getFileNamewithExtension(applicantId, photoDir);
        if (photoFile == null) {
            photoFile = applicantId + ".jpg";
        }
//
//        final String id = applicantId;
//        System.out.println("filePathone : "+filePathone);
//        File dir = new File(filePathone);
//        FilenameFilter filter = new FilenameFilter() {
//            @Override
//            public boolean accept(File dir, String name) {
//                return name.startsWith(id);
//            }
//        };
//        String[] children = dir.list(filter);
//        if (children == null) {
//            System.out.println("Either dir does not exist or is not a directory");
//        } else {
//            for (String file : children) {
//                System.out.println(" file : "+file);
//                photoFile = file;
//            }
//        }
        status = ep.getApplicantStatus();
        assignedTo = ep.getAssignedto();
        isFake = ep.getIsFake();
        aadhaar = ep.getAadhaar();
        statuses.putAll(ERMUtil.ermApplicantStatus());

    }

    public void findExpirienceByPrev(String applicantId) {

        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = MakeConnection.getConnection();
            String query = "select CURRENT_EMPLOYER,CURRENT_CTC,CURRENT_DESIGNATION,CURRENT_ROLE,JOB_PROFILE,to_char(CURRENT_DOJ, 'DD-Mon-YY') as CURRENT_DOJ, to_char(RELIEVING_DATE, 'DD-Mon-YY') as RELIEVING_DATE,EXPERIENCE_ID from ERM_APPLICANT_EXPERIENCE where APPLICANT_ID=? ORDER BY EXPERIENCE_ID";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, applicantId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                prevEmployer = rs.getString("CURRENT_EMPLOYER");
                if (prevEmployer == null) {
                    prevEmployer = "";
                }
                prevCtc = rs.getString("CURRENT_CTC");
                if (prevCtc == null) {
                    prevCtc = "";
                }
                prevDesignation = rs.getString("CURRENT_DESIGNATION");
                if (prevDesignation == null) {
                    prevDesignation = "";
                }
                prevRole = rs.getString("CURRENT_ROLE");
                if (prevRole == null) {
                    prevRole = "";
                }
                jobProfile = rs.getString("JOB_PROFILE");
                if (jobProfile == null) {
                    jobProfile = "";
                }
                prevJoinDate = rs.getString("CURRENT_DOJ");
                if (prevJoinDate == null) {
                    prevJoinDate = "";
                } else {
                    //       pJdat   = sdf.format(pJdat);
                }
                prevRelDate = rs.getString("RELIEVING_DATE");
                if (prevRelDate == null) {
                    prevRelDate = "";
                }
            } else {
                prevEmployer = "";
                prevCtc = "";
                prevDesignation = "";
                prevRole = "";
                jobProfile = "";
                prevJoinDate = "";
                prevRelDate = "";
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

    }

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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
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

    public String getUgBranch() {
        return ugBranch;
    }

    public void setUgBranch(String ugBranch) {
        this.ugBranch = ugBranch;
    }

    public String getUgInstitue() {
        return ugInstitue;
    }

    public void setUgInstitue(String ugInstitue) {
        this.ugInstitue = ugInstitue;
    }

    public String getUgYear() {
        return ugYear;
    }

    public void setUgYear(String ugYear) {
        this.ugYear = ugYear;
    }

    public String getUgPer() {
        return ugPer;
    }

    public void setUgPer(String ugPer) {
        this.ugPer = ugPer;
    }

    public String getPg() {
        return pg;
    }

    public void setPg(String pg) {
        this.pg = pg;
    }

    public String getPgBranch() {
        return pgBranch;
    }

    public void setPgBranch(String pgBranch) {
        this.pgBranch = pgBranch;
    }

    public String getPgInstitue() {
        return pgInstitue;
    }

    public void setPgInstitue(String pgInstitue) {
        this.pgInstitue = pgInstitue;
    }

    public String getPgYear() {
        return pgYear;
    }

    public void setPgYear(String pgYear) {
        this.pgYear = pgYear;
    }

    public String getPgPer() {
        return pgPer;
    }

    public void setPgPer(String pgPer) {
        this.pgPer = pgPer;
    }

    public String getSapExp() {
        return sapExp;
    }

    public void setSapExp(String sapExp) {
        this.sapExp = sapExp;
    }

    public String getFunctionalArea() {
        return functionalArea;
    }

    public void setFunctionalArea(String functionalArea) {
        this.functionalArea = functionalArea;
    }

    public String getTotalExp() {
        return totalExp;
    }

    public void setTotalExp(String totalExp) {
        this.totalExp = totalExp;
    }

    public String getExpertise() {
        return expertise;
    }

    public void setExpertise(String expertise) {
        this.expertise = expertise;
    }

    public String getLanguages() {
        return languages;
    }

    public void setLanguages(String languages) {
        this.languages = languages;
    }

    public String getErpPackages() {
        return erpPackages;
    }

    public void setErpPackages(String erpPackages) {
        this.erpPackages = erpPackages;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
    }

    public String getDataBase() {
        return dataBase;
    }

    public void setDataBase(String dataBase) {
        this.dataBase = dataBase;
    }

    public String getToolsAndUtil() {
        return toolsAndUtil;
    }

    public void setToolsAndUtil(String toolsAndUtil) {
        this.toolsAndUtil = toolsAndUtil;
    }

    public String getPrevEmployer() {
        return prevEmployer;
    }

    public void setPrevEmployer(String prevEmployer) {
        this.prevEmployer = prevEmployer;
    }

    public String getPrevDesignation() {
        return prevDesignation;
    }

    public void setPrevDesignation(String prevDesignation) {
        this.prevDesignation = prevDesignation;
    }

    public String getPrevCtc() {
        return prevCtc;
    }

    public void setPrevCtc(String prevCtc) {
        this.prevCtc = prevCtc;
    }

    public String getPrevJoinDate() {
        return prevJoinDate;
    }

    public void setPrevJoinDate(String prevJoinDate) {
        this.prevJoinDate = prevJoinDate;
    }

    public String getPrevRelDate() {
        return prevRelDate;
    }

    public void setPrevRelDate(String prevRelDate) {
        this.prevRelDate = prevRelDate;
    }

    public String getPrevRole() {
        return prevRole;
    }

    public void setPrevRole(String prevRole) {
        this.prevRole = prevRole;
    }

    public String getJobProfile() {
        return jobProfile;
    }

    public void setJobProfile(String jobProfile) {
        this.jobProfile = jobProfile;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public String getDesiredPosition() {
        return desiredPosition;
    }

    public void setDesiredPosition(String desiredPosition) {
        this.desiredPosition = desiredPosition;
    }

    public String getDesiredLocation() {
        return desiredLocation;
    }

    public void setDesiredLocation(String desiredLocation) {
        this.desiredLocation = desiredLocation;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(Integer assignedTo) {
        this.assignedTo = assignedTo;
    }

    public Map<Integer, String> getStatuses() {
        return statuses;
    }

    public void setStatuses(Map<Integer, String> statuses) {
        this.statuses = statuses;
    }

    public String getWater() {
        return water;
    }

    public void setWater(String water) {
        this.water = water;
    }

    public String getRti() {
        return rti;
    }

    public void setRti(String rti) {
        this.rti = rti;
    }

    public String getRte() {
        return rte;
    }

    public void setRte(String rte) {
        this.rte = rte;
    }

    public String getHabits() {
        return habits;
    }

    public void setHabits(String habits) {
        this.habits = habits;
    }

    public String getSocial() {
        return social;
    }

    public void setSocial(String social) {
        this.social = social;
    }

    public Map<Integer, String> getEminentUsers() {
        return eminentUsers;
    }

    public void setEminentUsers(Map<Integer, String> eminentUsers) {
        this.eminentUsers = eminentUsers;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getAreaOfExpertise() {
        return areaOfExpertise;
    }

    public void setAreaOfExpertise(String areaOfExpertise) {
        this.areaOfExpertise = areaOfExpertise;
    }

    public String getSapExpyr() {
        return sapExpyr;
    }

    public void setSapExpyr(String sapExpyr) {
        this.sapExpyr = sapExpyr;
    }

    public String getSapExpMo() {
        return sapExpMo;
    }

    public void setSapExpMo(String sapExpMo) {
        this.sapExpMo = sapExpMo;
    }

    public String getTotExpyr() {
        return totExpyr;
    }

    public void setTotExpyr(String totExpyr) {
        this.totExpyr = totExpyr;
    }

    public String getTotExpMo() {
        return totExpMo;
    }

    public void setTotExpMo(String totExpMo) {
        this.totExpMo = totExpMo;
    }

    public String getApj() {
        return apj;
    }

    public void setApj(String apj) {
        this.apj = apj;
    }

    public String getPhotoFile() {
        return photoFile;
    }

    public void setPhotoFile(String photoFile) {
        this.photoFile = photoFile;
    }

    public int getFileCount() {
        return fileCount;
    }

    public void setFileCount(int fileCount) {
        this.fileCount = fileCount;
    }

    public int getIsFake() {
        return isFake;
    }

    public void setIsFake(int isFake) {
        this.isFake = isFake;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getMailId() {
        return mailId;
    }

    public void setMailId(String mailId) {
        this.mailId = mailId;
    }

    public String getFullLang() {
        return fullLang;
    }

    public void setFullLang(String fullLang) {
        this.fullLang = fullLang;
    }

    public String getAadhaar() {
        return aadhaar;
    }

    public void setAadhaar(String aadhaar) {
        this.aadhaar = aadhaar;
    }

}
