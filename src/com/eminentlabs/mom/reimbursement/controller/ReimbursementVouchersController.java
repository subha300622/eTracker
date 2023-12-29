/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.reimbursement.controller;

import com.eminent.timesheet.TimesheetMaintanance;
import com.eminent.util.GetProjectMembers;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.mom.reimbursement.ReimbursementBill;
import com.eminentlabs.mom.reimbursement.ReimbursementComments;
import com.eminentlabs.mom.reimbursement.ReimbursementVouchers;
import com.eminentlabs.mom.reimbursement.dao.ReimbursementBillDAO;
import com.eminentlabs.mom.reimbursement.dao.ReimbursementBillDAOImpl;
import com.eminentlabs.mom.reimbursement.dao.ReimbursementVouchersDAO;
import com.eminentlabs.mom.reimbursement.dao.ReimbursementVouchersDAOImpl;
import com.eminentlabs.timesheet.dao.TimesheetDAO;
import com.eminentlabs.timesheet.dao.TimesheetDAOImpl;
import com.pack.StringUtil;
import java.io.File;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;

/**
 *
 * @author EMINENT
 */
public class ReimbursementVouchersController {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ReimbursementVouchersController");
    }
    SimpleDateFormat sdf = new SimpleDateFormat("MMMyyyy");
    private List<Integer> reimbursementModerator = new ArrayList<Integer>(0);
    private String message;
    private String startMonth;
    private String endMonth;
    List<ReimbursementVouchers> reimbursementVoucherses = new ArrayList<ReimbursementVouchers>(0);
    ReimbursementVouchersDAO reimbursementVouchersDAO = new ReimbursementVouchersDAOImpl();
    TimesheetDAO timesheetDAO = new TimesheetDAOImpl();
    ReimbursementBillDAO reimbursementBillDAO = new ReimbursementBillDAOImpl();
    ReimbursementVouchers reimbursementVoucher = new ReimbursementVouchers();
    Map<Integer, String> statusMapCollectionByLogiUser = new LinkedHashMap<Integer, String>();

    Map<Integer, String> member = new LinkedHashMap<Integer, String>();
    Map<Integer, String> allEminentMembers = new LinkedHashMap<Integer, String>();
TimesheetMaintanance approverMaintanance = null;
    public void setAll(HttpServletRequest request, ServletContext context) {
        String method = request.getMethod();
        HttpSession session = request.getSession();
        Integer userid_curr = (Integer) session.getAttribute("userid_curr");

        if (method.equalsIgnoreCase("post")) {
            String saveFile = null;
            String billSaveFile = null;
            FileItem excelFileItem = null;
            FileItem billFileItem = null;
            Integer status = 0;
            Date periodDate = null;
            Integer assignedTo = 0;
            Integer requestedBy = 0;
            try {
                if (ServletFileUpload.isMultipartContent(request)) {
                    ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                    List fileItemsList = servletFileUpload.parseRequest(request);

                    String requestedByParam = request.getParameter("requestedBy");
                    String filePath = context.getInitParameter("Reimbursement_vouchers");
                    String dirName = filePath;
                    String optionalFileName = "";

                    Iterator it = fileItemsList.iterator();
                    while (it.hasNext()) {
                        FileItem fileItemTemp = (FileItem) it.next();
                        if (fileItemTemp.isFormField()) //your code for getting form fields
                        {
                            String name = fileItemTemp.getFieldName();
                            if (name.equalsIgnoreCase("requestedBy")) {
                                requestedByParam = fileItemTemp.getString().trim();
                                requestedBy = MoMUtil.parseInteger(requestedByParam, 0);
                                if (requestedBy == 0) {
                                    requestedBy = userid_curr;
                                }
                            }
                            if (name.equalsIgnoreCase("period")) {
                                periodDate = sdf.parse(fileItemTemp.getString().trim());
                            }
                            if (name.equalsIgnoreCase("status")) {
                                status = MoMUtil.parseInteger(fileItemTemp.getString().trim(), 0);

                            }
                        } else {
                            String expenceType = fileItemTemp.getFieldName();
                            if (expenceType.equalsIgnoreCase("files")) {
                                excelFileItem = fileItemTemp;
                            } else if (expenceType.equalsIgnoreCase("bills")) {
                                billFileItem = fileItemTemp;
                            }
                        }
                    }
                    if (requestedBy == 0) {
                        requestedBy = userid_curr;
                    }
                    approverMaintanance = timesheetDAO.findByRequester(requestedBy);
                    if (status == 3) {
                        assignedTo = approverMaintanance.getReimbursementApprover();
                    } else if (status == 1 || status == 4) {
                        assignedTo = approverMaintanance.getAccountsApprover();
                    } else {
                        assignedTo = userid_curr;
                    }
                    if (excelFileItem == null) {
                    } else {
                        String fileName = excelFileItem.getName();
                        if (excelFileItem.getSize() > 0 & excelFileItem.getSize() < 12582912) {
                            if (optionalFileName.equals("")) {
                                fileName = FilenameUtils.getName(fileName);
                            } else {
                                fileName = optionalFileName;
                            }

                            String period = sdf.format(new Date());
                            String format = period + "_" + GetProjectMembers.getUserName(requestedBy.toString());

                            int count = reimbursementVouchersDAO.monthlyFileCount(format);
                            count = count + 1;
                            File saveTo = new File(dirName + count + "." + format + "_" + StringUtil.convertSpecialCharacters(fileName));
                            saveFile = count + "." + format + "_" + StringUtil.convertSpecialCharacters(fileName);
                            try {
                                excelFileItem.write(saveTo);
                                ReimbursementVouchers reimbursementVouchers = new ReimbursementVouchers(0l, saveFile, requestedBy, userid_curr, periodDate, new Date(), new Date(), status, assignedTo);

                                reimbursementVouchersDAO.saveReimbursementVouchers(reimbursementVouchers);
                                message = "Reimbursement voucher generated successfully.";
                                String billOptionalFileName = "";
                                if (billFileItem == null) {
                                } else {
                                    String billFileName = billFileItem.getName();
                                    if (billFileItem.getSize() > 0 & billFileItem.getSize() < 12582912) {
                                        if (billOptionalFileName.equals("")) {
                                            billFileName = FilenameUtils.getName(billFileName);
                                        } else {
                                            billFileName = billOptionalFileName;
                                        }
                                        String billFormat = period + "_" + GetProjectMembers.getUserName(requestedBy.toString()) + "_Bill";

                                        int billCount = reimbursementVouchersDAO.monthlyFileCount(billFormat);
                                        billCount = billCount + 1;
                                        File billSaveTo = new File(dirName + billCount + "." + billFormat + "_" + StringUtil.convertSpecialCharacters(billFileName));
                                        billSaveFile = billCount + "." + billFormat + "_" + StringUtil.convertSpecialCharacters(billFileName);
                                        try {
                                            billFileItem.write(billSaveTo);
                                            ReimbursementVouchers reimbursementVouchersa = reimbursementVouchersDAO.findByFileName(reimbursementVouchers.getFileName());
                                            ReimbursementBill reimbursementBill = new ReimbursementBill();
                                            reimbursementBill.setBid(0l);
                                            reimbursementBill.setFilename(billSaveFile);
                                            reimbursementBill.setRvid(reimbursementVouchersa);
                                            reimbursementBillDAO.saveReimbursementBill(reimbursementBill);
                                        } catch (Exception e) {
                                            message = "Error Occured in file upload";
                                            logger.error(e.getMessage());
                                            e.printStackTrace();
                                        }

                                    } else if (billFileItem.getSize() == 0) {
                                    } else {
                                        message = "The file you were trying to upload exceeds 12MB.Please upload file less than 12MB.";
                                    }
                                }

                            } catch (Exception e) {
                                message = "Error Occured in file upload";
                                logger.error(e.getMessage());
                                e.printStackTrace();
                            }

                        } else if (excelFileItem.getSize() == 0) {
                        } else {
                            message = "The file you were trying to upload exceeds 12MB.Please upload file less than 12MB.";
                        }
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        member = GetProjectMembers.getEminentUsersShortName();
        allEminentMembers = GetProjectMembers.getAllEminentMembers();
        List<Integer> timeSheetRole = new ArrayList<Integer>(0);
        timeSheetRole.add(2);
        timeSheetRole.add(3);
        reimbursementModerator = timesheetDAO.findRoleByUserId(userid_curr);
        if (userid_curr.equals(104)) {
            reimbursementModerator.add(2);
        }
        statusMapCollectionByLogiUser = statusMapCollectionUserRole();
        if (reimbursementModerator.contains(2)) {
            statusMapCollectionByLogiUser.putAll(statusMapAccountCollection());
            reimbursementVoucherses = reimbursementVouchersDAO.findForAccountant(userid_curr);
        } else {
            reimbursementVoucherses = reimbursementVouchersDAO.findByRequestedBy(userid_curr);

        }

    }

    public void editAll(HttpServletRequest request, ServletContext context) {
        String method = request.getMethod();
        HttpSession session = request.getSession();
        Integer userid_curr = (Integer) session.getAttribute("userid_curr");
        String rvidParam = request.getParameter("rvid");
        Long rvId = MoMUtil.parseLong(rvidParam, 0l);
        Integer status = 0;
        Integer assignedTo = 0;
        String comments = null;
         approverMaintanance = null;
        if (rvId == 0l) {

        } else {
            reimbursementVoucher = reimbursementVouchersDAO.findReimbursementVouchersByrvId(rvId);
            approverMaintanance = timesheetDAO.findByRequester(reimbursementVoucher.getRequestedBy());
        }
        if (method.equalsIgnoreCase("post")) {
            String saveFile = null;
            String billSaveFile = null;
            FileItem excelFileItem = null;
            FileItem billFileItem = null;
            Date periodDate = null;
            try {
                if (ServletFileUpload.isMultipartContent(request)) {
                    ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                    List fileItemsList = servletFileUpload.parseRequest(request);

                    String filePath = context.getInitParameter("Reimbursement_vouchers");
                    String dirName = filePath;
                    String optionalFileName = "";

                    Iterator it = fileItemsList.iterator();
                    while (it.hasNext()) {
                        FileItem fileItemTemp = (FileItem) it.next();
                        if (fileItemTemp.isFormField()) //your code for getting form fields
                        {
                            String name = fileItemTemp.getFieldName();
                            if (name.equalsIgnoreCase("assignedTo")) {
                                assignedTo = MoMUtil.parseInteger(fileItemTemp.getString().trim(), 0);
                            }
                            if (name.equalsIgnoreCase("period")) {
                                periodDate = sdf.parse(fileItemTemp.getString().trim());
                            }
                            if (name.equalsIgnoreCase("status")) {
                                status = MoMUtil.parseInteger(fileItemTemp.getString().trim(), 2);
                            }
                            if (name.equalsIgnoreCase("comments")) {
                                comments = fileItemTemp.getString().trim();
                            }
                            if (name.equalsIgnoreCase("rvId")) {
                                rvidParam = fileItemTemp.getString().trim();
                                rvId = MoMUtil.parseLong(rvidParam, 0l);
                                if (rvId == 0l) {

                                } else {
                                    reimbursementVoucher = reimbursementVouchersDAO.findReimbursementVouchersByrvId(rvId);
                                    approverMaintanance = timesheetDAO.findByRequester(reimbursementVoucher.getRequestedBy());
                                }
                            }
                        } else {
                            String expenceType = fileItemTemp.getFieldName();
                            if (expenceType.equalsIgnoreCase("files")) {
                                excelFileItem = fileItemTemp;
                            } else if (expenceType.equalsIgnoreCase("bills")) {
                                billFileItem = fileItemTemp;
                            }
                        }
                    }

                    String period = sdf.format(new Date());
                    if (excelFileItem == null) {
                    } else {
                        String fileName = excelFileItem.getName();
                        if (excelFileItem.getSize() > 0 & excelFileItem.getSize() < 12582912) {

                            if (optionalFileName.equals("")) {
                                fileName = FilenameUtils.getName(fileName);
                            } else {
                                fileName = optionalFileName;
                            }

                            String format = period + "_" + GetProjectMembers.getUserName(reimbursementVoucher.getRequestedBy().toString());

                            int count = reimbursementVouchersDAO.monthlyFileCount(format);
                            count = count + 1;
                            File saveTo = new File(dirName + count + "." + format + "_" + StringUtil.convertSpecialCharacters(fileName));
                            saveFile = count + "." + format + "_" + StringUtil.convertSpecialCharacters(fileName);
                            try {
                                excelFileItem.write(saveTo);
                                reimbursementVoucher.setFileName(saveFile);

                            } catch (Exception e) {
                                message = "Error Occured in file upload";
                                logger.error(e.getMessage());
                                e.printStackTrace();
                            }

                        } else if (excelFileItem.getSize() == 0) {
                        } else {
                            message = "The file you were trying to upload exceeds 12MB.Please upload file less than 12MB.";
                        }
                    }
                    reimbursementVoucher.setModifiedon(new Date());
                    System.out.println("status : "+status);
                    if (status == 2) {
                                                reimbursementVoucher.setStatus(status);
                    }  else if (status == 2) {
                                                reimbursementVoucher.setStatus(status);
                    } else {
                        reimbursementVoucher.setStatus(status);
                    }
                    if (assignedTo == 0) {

                        if (reimbursementVoucher.getStatus() > 1) {
                            assignedTo = approverMaintanance.getReimbursementApprover();
                        } else {
                            assignedTo = approverMaintanance.getAccountsApprover();
                        }
                    }
                    if (status == 5 || status == -1) {
                        assignedTo = reimbursementVoucher.getRequestedBy();
                    } else if (status == 3 || status == 0) {
                        assignedTo = approverMaintanance.getReimbursementApprover();
                    } else if (status == 4) {
                        assignedTo = approverMaintanance.getAccountsApprover();
                    }
                    if (periodDate == null) {

                    } else {
                        reimbursementVoucher.setPeriod(periodDate);
                    }

                    reimbursementVoucher.setAssignedTo(assignedTo);
                    if (comments != null && !"".equals(comments)) {
                        ReimbursementComments reimbursementComments = new ReimbursementComments(0l, userid_curr, new Date(), comments, status, assignedTo, reimbursementVoucher);
                        reimbursementVoucher.getReimbursementCommentsList().add(reimbursementComments);
                    }

                    String billOptionalFileName = "";
                    if (billFileItem == null) {
                    } else {
                        if (billFileItem.getSize() > 0 & billFileItem.getSize() < 12582912) {

                            String billFileName = billFileItem.getName();
                            if (billFileItem.getSize() > 0 & billFileItem.getSize() < 12582912) {

                                if (billOptionalFileName.equals("")) {
                                    billFileName = FilenameUtils.getName(billFileName);
                                } else {
                                    billFileName = billOptionalFileName;
                                }
                                String billFormat = period + "_" + GetProjectMembers.getUserName(reimbursementVoucher.getRequestedBy().toString()) + "_Bill";

                                int billCount = reimbursementBillDAO.monthlyFileCount(billFormat, reimbursementVoucher.getRvid());
                                billCount = billCount + 1;
                                File billSaveTo = new File(dirName + billCount + "." + billFormat + "_" + StringUtil.convertSpecialCharacters(billFileName));
                                billSaveFile = billCount + "." + billFormat + "_" + StringUtil.convertSpecialCharacters(billFileName);
                                try {
                                    billFileItem.write(billSaveTo);
                                    ReimbursementVouchers reimbursementVouchersa = reimbursementVouchersDAO.findByFileName(reimbursementVoucher.getFileName());
                                    ReimbursementBill reimbursementBill = new ReimbursementBill();
                                    reimbursementBill.setBid(0l);
                                    reimbursementBill.setFilename(billSaveFile);
                                    reimbursementBill.setRvid(reimbursementVouchersa);
                                    reimbursementVoucher.getReimbursementBillList().add(reimbursementBill);
                                } catch (Exception e) {
                                    message = "Error Occured in file upload";
                                    logger.error(e.getMessage());
                                    e.printStackTrace();
                                }

                            } else if (excelFileItem.getSize() == 0) {
                            } else {
                                message = "The file you were trying to upload exceeds 12MB.Please upload file less than 12MB.";
                            }
                        }
                    }
                    reimbursementVouchersDAO.updateReimbursementVouchers(reimbursementVoucher);
                    message = "Reimbursement voucher updated successfully.";
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        member = GetProjectMembers.getEminentUsersShortName();
        allEminentMembers = GetProjectMembers.getAllEminentMembers();     
        reimbursementModerator = timesheetDAO.findRoleByUserId(userid_curr);
        if (userid_curr.equals(104)) {
            reimbursementModerator.add(2);
        }
        statusMapCollectionByLogiUser = statusMapCollectionUserRole();
        if (reimbursementModerator.contains(2)) {
            statusMapCollectionByLogiUser.putAll(statusMapAccountCollection());
        }
        if (reimbursementModerator.contains(3) && (reimbursementVoucher.getStatus() == 3 || reimbursementVoucher.getStatus() == 4)) {
            statusMapCollectionByLogiUser.putAll(statusMapCollectionApproverRole());
        }
    }

    public void getAll(HttpServletRequest request) throws SQLException, ParseException {
        HttpSession session = request.getSession();
        Integer userid_curr = (Integer) session.getAttribute("userid_curr");
        startMonth = request.getParameter("fromDate");
        endMonth = request.getParameter("toDate");
        DateFormat sdfa = new SimpleDateFormat("MMMM yyyy");
        try {
            String startdate = "";
            String endDate = "";
            int month = 0;
            int year = 0;
            Calendar cal = Calendar.getInstance();

            if (startMonth == null && endMonth == null) {
                cal.add((Calendar.MONTH), -1);
                startMonth = sdfa.format(cal.getTime());
                endMonth = sdfa.format(cal.getTime());
            }
            SimpleDateFormat sdff = new SimpleDateFormat("dd-MMM-yyyy");
            Date statrtdt = sdfa.parse(startMonth);
            Date endDt = sdfa.parse(endMonth);
            cal.setTime(statrtdt);

            cal.set(Calendar.DAY_OF_MONTH, 1);
            startdate = sdff.format(cal.getTime());
            month = cal.get(Calendar.MONTH);
            year = cal.get(Calendar.YEAR);

            cal.setTime(endDt);
            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DATE));
            endDate = sdff.format(cal.getTime());
            reimbursementVoucherses = reimbursementVouchersDAO.findBetweenPeriod(statrtdt, endDt);
            allEminentMembers = GetProjectMembers.getAllEminentMembers();
        } catch (Exception ex) {

        }
        reimbursementModerator = timesheetDAO.findRoleByUserId(userid_curr);
    }

    public String deleteReimbursement(HttpServletRequest request) {
        Long rvId = MoMUtil.parseLong(request.getParameter("rvid"), 0l);
        String res = "false";
        if (rvId > 0l) {
            ReimbursementVouchers rv = reimbursementVouchersDAO.findReimbursementVouchersByrvId(rvId);

            boolean flag = reimbursementVouchersDAO.deleteReimbursementVouchers(rv);
            if (flag == true) {
                res = "true";
            }

        }
        return res;
    }

    public String deleteReimbursementBill(HttpServletRequest request) {
        Long rbid = MoMUtil.parseLong(request.getParameter("rbid"), 0l);
        String res = "false";
        if (rbid > 0l) {
            ReimbursementBill reimbursementBill = reimbursementBillDAO.findReimbursementBillByrbId(rbid);
            boolean flag = reimbursementBillDAO.deleteReimbursementBill(reimbursementBill);
            if (flag == true) {
                res = "true";
            }

        }
        return res;
    }

    public Map<Integer, String> statusMapAccountCollection() {
        Map<Integer, String> statusMapCollection = new LinkedHashMap<Integer, String>();
        statusMapCollection.put(2, "Need Info");
        statusMapCollection.put(3, "Verified");
        statusMapCollection.put(5, "Paid");
        statusMapCollection.put(-1, "Rejected");
        return statusMapCollection;
    }

    public Map<Integer, String> statusMapCollectionUserRole() {
        Map<Integer, String> statusMapCollection = new LinkedHashMap<Integer, String>();
        statusMapCollection.put(0, "Uploading");
        statusMapCollection.put(1, "Request Submitted");
        return statusMapCollection;
    }

    public Map<Integer, String> statusMapCollectionApproverRole() {
        Map<Integer, String> statusMapCollection = new LinkedHashMap<Integer, String>();
        statusMapCollection.put(2, "Need Info");
        statusMapCollection.put(4, "Approved");
        statusMapCollection.put(-1, "Rejected");
        return statusMapCollection;
    }

    public Map<Integer, String> statusMapCollection() {
        Map<Integer, String> statusMapCollection = new LinkedHashMap<Integer, String>();
        statusMapCollection.put(0, "Uploading");
        statusMapCollection.put(1, "Request Submitted");
        statusMapCollection.put(2, "Need Info");
        statusMapCollection.put(3, "Verified");
        statusMapCollection.put(4, "Approved");
        statusMapCollection.put(5, "Paid");
        statusMapCollection.put(-1, "Rejected");
        return statusMapCollection;
    }

    public Map<Integer, String> getMember() {
        return member;
    }

    public void setMember(Map<Integer, String> member) {
        this.member = member;
    }

    public List<Integer> getReimbursementModerator() {
        return reimbursementModerator;
    }

    public void setReimbursementModerator(List<Integer> reimbursementModerator) {
        this.reimbursementModerator = reimbursementModerator;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStartMonth() {
        return startMonth;
    }

    public void setStartMonth(String startMonth) {
        this.startMonth = startMonth;
    }

    public String getEndMonth() {
        return endMonth;
    }

    public void setEndMonth(String endMonth) {
        this.endMonth = endMonth;
    }

    public List<ReimbursementVouchers> getReimbursementVoucherses() {
        return reimbursementVoucherses;
    }

    public void setReimbursementVoucherses(List<ReimbursementVouchers> reimbursementVoucherses) {
        this.reimbursementVoucherses = reimbursementVoucherses;
    }

    public Map<Integer, String> getAllEminentMembers() {
        return allEminentMembers;
    }

    public void setAllEminentMembers(Map<Integer, String> allEminentMembers) {
        this.allEminentMembers = allEminentMembers;
    }

    public ReimbursementVouchers getReimbursementVoucher() {
        return reimbursementVoucher;
    }

    public void setReimbursementVoucher(ReimbursementVouchers reimbursementVoucher) {
        this.reimbursementVoucher = reimbursementVoucher;
    }

    public Map<Integer, String> getStatusMapCollectionByLogiUser() {
        return statusMapCollectionByLogiUser;
    }

    public void setStatusMapCollectionByLogiUser(Map<Integer, String> statusMapCollectionByLogiUser) {
        this.statusMapCollectionByLogiUser = statusMapCollectionByLogiUser;
    }

    public TimesheetMaintanance getApproverMaintanance() {
        return approverMaintanance;
    }

    public void setApproverMaintanance(TimesheetMaintanance approverMaintanance) {
        this.approverMaintanance = approverMaintanance;
    }

}
