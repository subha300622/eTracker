/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminent.util.GetProjectMembers;
import static com.eminentlabs.erm.AssignedApplicants.getFileNamewithExtension;
import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author E0288
 */
public class Applicants {

    private String requestpag;
    int requestpage, pageone, pageremain, rowcount;
    static int totalpage, pagemanipulation, presentpage, issuenofrom, issuenoto, extra;
    private String applicantId;
    private String name;
    private String employer;
    private String mobile;
    private String location;
    private String refId;
    private String refName;
    private String education;
    private String skills;
    private String totalExp;
    private String sapExp;
    private String fileName;
    private String assignedTo;
    private int usCount;
    private int scCount;
    private int shCount;
    private int reCount;
    private int joCount;
    private int offCount;
    private int disCount;
    private int holdCount;
    int aStatus = 0;
    private String photoPath;
    private int isFake = 0;

    List<Applicants> assigendApplicants = new ArrayList<Applicants>();
    HashMap<Integer, String> member = GetProjectMembers.showUsers();
    Map<Integer, Integer> applicantByStatus = new HashMap<Integer, Integer>();
    Map<Integer, String> statuses = new HashMap<Integer, String>();
    List<ErmApplicant> apllicantList = new ArrayList<ErmApplicant>();

    public void setAll(HttpServletRequest request) {
        HttpSession session = request.getSession();
        requestpag = request.getParameter("manipulation");
        String appStatus = request.getParameter("applicantStatus");
        String filePath = request.getSession().getServletContext().getInitParameter("upload-resume");
        String filePathone = request.getSession().getServletContext().getInitParameter("upload-user-photo");
        session.setAttribute("forwardpage", "/admin/candidate/wholeApplicants.jsp?applicantStatus=" + appStatus + "");
        applicantByStatus = ERMUtil.getCountsByStaus();

        if (applicantByStatus.get(0) != null) {
            usCount = applicantByStatus.get(0);
        }
        if (applicantByStatus.get(2) != null) {
            shCount = applicantByStatus.get(2);

        }
        if (applicantByStatus.get(1) != null) {
            scCount = applicantByStatus.get(1);

        }
        if (applicantByStatus.get(3) != null) {

            reCount = applicantByStatus.get(3);
        }
        if (applicantByStatus.get(4) != null) {
            joCount = applicantByStatus.get(4);
        }
        if (applicantByStatus.get(5) != null) {
            offCount = applicantByStatus.get(5);
        }
        if (applicantByStatus.get(6) != null) {
            disCount = applicantByStatus.get(6);
        }
        if (applicantByStatus.get(7) != null) {
            holdCount = applicantByStatus.get(7);
        }
        if (applicantByStatus.get(0) != null) {
            aStatus = 0;
        } else if (applicantByStatus.get(2) != null) {
            aStatus = 2;

        } else if (applicantByStatus.get(1) != null) {
            aStatus = 1;

        } else if (applicantByStatus.get(3) != null) {
            aStatus = 3;

        } else if (applicantByStatus.get(4) != null) {
            aStatus = 4;
        } else if (applicantByStatus.get(5) != null) {
            aStatus = 5;

        } else if (applicantByStatus.get(6) != null) {
            aStatus = 6;
        } else if (applicantByStatus.get(7) != null) {
            aStatus = 7;
        }
        if (appStatus != null) {
            aStatus = Integer.valueOf(appStatus);
        }
        apllicantList = ERMUtil.findERMByStatus(aStatus);

        File resumeDir = new File(filePath);
        File photoDir = new File(filePathone);
        for (ErmApplicant ep : apllicantList) {

            Applicants aa = new Applicants();
            aa.setApplicantId(ep.getApplicantId());
            String fullname = ep.getFirstname() + " " + ep.getLastname();
            if ((fullname.length()) > 25) {
                fullname = fullname.substring(0, 24) + "...";
            }
            String emp = ERMUtil.findEmployee(ep.getApplicantId());
            String tExp = ep.getTotalExpYr() + "Y " + ep.getTotalExpMon() + "M";
            String sExp = ep.getSapExpYr() + "Y " + ep.getSapExpMon() + "M";
            String are = ep.getAreaOfExpertise();
            final String id = ep.getApplicantId();
//            String nameOfFile = AssignedApplicants.getFileNamewithExtension(id, resumeDir);
//            if (nameOfFile == null) {
//                nameOfFile = ep.getApplicantId() + ".doc";
//            }

//            String nameOfPhoto = AssignedApplicants.getFileNamewithExtension(id, photoDir);
//            if (nameOfPhoto == null) {
//                nameOfPhoto =  "avator1.png";
//            }
            if (are.length() > 10) {
                are = are.substring(0, 9) + "..";
            }
            String edu = ep.getUg();
            String pg = ep.getPg();
            if (!(pg == null || pg.equals(""))) {
                edu = edu + ", " + pg;
            }
            if (edu.equals(", ")) {
                edu = "Nil";

            }
            if ((edu.length()) > 8) {
                edu = edu.substring(0, 7) + "..";
            }

            aa.setName(fullname);
            aa.setEmployer(emp);
            aa.setMobile(ep.getMobile());
            aa.setLocation(ep.getCurrentLocation());
            aa.setRefId(ep.getReferenceEmpid());
            aa.setRefName(GetProjectMembers.getUserNameByEid(ep.getReferenceEmpid()));
            aa.setEducation(edu);
            aa.setSkills(ep.getAreaOfExpertise());
            aa.setTotalExp(tExp);
            aa.setSapExp(sExp);
//            aa.setFileName(nameOfFile);
//            aa.setPhotoPath(nameOfPhoto);
            aa.setAssignedTo(member.get(ep.getAssignedto()));
            aa.setIsFake(ep.getIsFake());
            assigendApplicants.add(aa);

        }
    }

    public List<Applicants> getApllicantList() {

        return assigendApplicants;
    }

    public void setApllicantList(List<ErmApplicant> apllicantList) {
        this.apllicantList = apllicantList;
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

    public List<Applicants> getAssigendApplicants() {
        return assigendApplicants;
    }

    public void setAssigendApplicants(List<Applicants> assigendApplicants) {
        this.assigendApplicants = assigendApplicants;
    }

    public Map<Integer, String> getStatuses() {
        statuses = ERMUtil.ermApplicantStatus();
        return statuses;
    }

    public void setStatuses(Map<Integer, String> statuses) {
        this.statuses = statuses;
    }

    public Map<Integer, Integer> getApplicantByStatus() {

        return applicantByStatus;
    }

    public void setApplicantByStatus(Map<Integer, Integer> applicantByStatus) {
        this.applicantByStatus = applicantByStatus;
    }

    public int getUsCount() {
        return usCount;
    }

    public void setUsCount(int usCount) {
        this.usCount = usCount;
    }

    public int getScCount() {
        return scCount;
    }

    public void setScCount(int scCount) {
        this.scCount = scCount;
    }

    public int getShCount() {
        return shCount;
    }

    public void setShCount(int shCount) {
        this.shCount = shCount;
    }

    public int getReCount() {
        return reCount;
    }

    public void setReCount(int reCount) {
        this.reCount = reCount;
    }

    public int getJoCount() {
        return joCount;
    }

    public void setJoCount(int joCount) {
        this.joCount = joCount;
    }

    public int getOffCount() {
        return offCount;
    }

    public void setOffCount(int offCount) {
        this.offCount = offCount;
    }

    public int getDisCount() {
        return disCount;
    }

    public void setDisCount(int disCount) {
        this.disCount = disCount;
    }

    public int getaStatus() {
        return aStatus;
    }

    public void setaStatus(int aStatus) {
        this.aStatus = aStatus;
    }

    public String getRequestpag() {
        return requestpag;
    }

    public void setRequestpag(String requestpag) {
        this.requestpag = requestpag;
    }

    public int getRequestpage() {
        return requestpage;
    }

    public void setRequestpage(int requestpage) {
        this.requestpage = requestpage;
    }

    public int getPageone() {
        return pageone;
    }

    public void setPageone(int pageone) {
        this.pageone = pageone;
    }

    public int getPageremain() {
        return pageremain;
    }

    public void setPageremain(int pageremain) {
        this.pageremain = pageremain;
    }

    public int getRowcount() {
        return rowcount;
    }

    public void setRowcount(int rowcount) {
        this.rowcount = rowcount;
    }

    public static int getTotalpage() {
        return totalpage;
    }

    public static void setTotalpage(int totalpage) {
        Applicants.totalpage = totalpage;
    }

    public static int getPagemanipulation() {
        return pagemanipulation;
    }

    public static void setPagemanipulation(int pagemanipulation) {
        Applicants.pagemanipulation = pagemanipulation;
    }

    public static int getPresentpage() {
        return presentpage;
    }

    public static void setPresentpage(int presentpage) {
        Applicants.presentpage = presentpage;
    }

    public static int getIssuenofrom() {
        return issuenofrom;
    }

    public static void setIssuenofrom(int issuenofrom) {
        Applicants.issuenofrom = issuenofrom;
    }

    public static int getIssuenoto() {
        return issuenoto;
    }

    public static void setIssuenoto(int issuenoto) {
        Applicants.issuenoto = issuenoto;
    }

    public static int getExtra() {
        return extra;
    }

    public static void setExtra(int extra) {
        Applicants.extra = extra;
    }

    public int getHoldCount() {
        return holdCount;
    }

    public void setHoldCount(int holdCount) {
        this.holdCount = holdCount;
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

}
