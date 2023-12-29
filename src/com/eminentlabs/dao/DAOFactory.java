/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.dao;

import com.eminent.holidays.Holidays;
import com.eminent.bpm.BpmPrintaccess;
import com.eminent.issue.ApmIssueTeststepId;
import com.eminent.issue.ApmTrFormat;
import com.eminent.issue.ApmWrmDay;
import com.eminent.issue.ProjectPlannedIssue;
import org.apache.log4j.Logger;
import com.eminentlabs.appraisal.ErmAppraisal;
import com.eminentlabs.appraisal.ErmAppraisalComment;
import com.eminentlabs.appraisal.ErmAppraisalAchievement;
import com.eminentlabs.mom.ApmWrmPlan;
import com.eminentlabs.mom.ErmFinePaid;
import com.eminentlabs.mom.ErmFinePaymentHistory;
import com.eminentlabs.mom.FineAmountUsers;
import com.eminentlabs.mom.Fine;
import com.eminentlabs.mom.MomFeedback;
import com.eminentlabs.mom.MomForClient;
import com.eminentlabs.mom.MomUserTask;
import com.eminentlabs.mom.MomUserDetail;
import com.eminentlabs.mom.PmPerformance;
import com.eminentlabs.mom.UsersPerformance;
import com.pack.ApmTargetIssueCount;

/**
 *
 * @author Tamilvelan
 */
public class DAOFactory {

    private static final Logger logger = Logger.getLogger("DAO Factory");

    public static boolean createErmAppraisal(ErmAppraisal appraisal) {
        ModelDAO.save(DAOConstants.ENTITY_ErmAppraisal, appraisal);
        logger.info("######### Appraisal Created  #############");
        return true;
    }

    public static boolean createErmAppraisalComment(ErmAppraisalComment comments) {
        ModelDAO.save(DAOConstants.ENTITY_ErmAppraisalComment, comments);
        logger.info("######### Appraisal Comments Created  #############");
        return true;
    }

    public static boolean updateErmAppraisal(ErmAppraisal appraisal) {
        ModelDAO.Update(DAOConstants.ENTITY_ErmAppraisal, appraisal);
        logger.info("######### Appraisal Updated  #############");
        return true;
    }

    public static boolean createErmAchievement(ErmAppraisalAchievement achievement) {
        ModelDAO.save(DAOConstants.ENTITY_ErmAppraisalAchievement, achievement);
        logger.info("######### Appraisal Achievemet created  #############");
        return true;
    }

    public static boolean createTask(MomUserTask userTask) {
        ModelDAO.save(DAOConstants.ENTITY_MomUserTask, userTask);
        logger.info("######### User Task created  #############");
        return true;
    }

    public static boolean updateTask(MomUserTask userTask) {
        ModelDAO.saveOrUpdate(DAOConstants.ENTITY_MomUserTask, userTask);
        logger.info("######### User Task update  #############");
        return true;
    }

    public static boolean createMOMUser(MomUserDetail userDetails) {
        ModelDAO.saveOrUpdate(DAOConstants.ENTITY_MomUserDetail, userDetails);
        logger.info("######### User Detail created  #############");
        return true;
    }

    public static boolean createMOMFeedBack(MomFeedback momFeedback) {
        ModelDAO.saveOrUpdate(DAOConstants.ENTITY_MOM_FEEDBACK, momFeedback);
        logger.info("######### MOMFeedBack created  #############");
        return true;
    }

    public static boolean createUsersPerformance(UsersPerformance usersPerformance) {
        ModelDAO.saveOrUpdate(DAOConstants.ENTITY_USERS_PERFORMANCE, usersPerformance);
        logger.info("######### Users Performance created  #############");
        return true;
    }

    public static boolean saveUserPerformance(UsersPerformance usersPerformance) {
        ModelDAO.save(DAOConstants.ENTITY_USERS_PERFORMANCE, usersPerformance);
        logger.info("######### Users Performance created  #############");
        return true;
    }

    public static boolean saveProjectPlannedIssue(ProjectPlannedIssue projectPlannedIssue) {
        ModelDAO.save(DAOConstants.ENTITY_PROJECT_PLANNNED_ISSUE, projectPlannedIssue);
        logger.info("######### Project Planned Issue created  #############");
        return true;
    }

    public static boolean updateProjectPlannedIssue(ProjectPlannedIssue projectPlannedIssue) {
        ModelDAO.Update(DAOConstants.ENTITY_PROJECT_PLANNNED_ISSUE, projectPlannedIssue);
        logger.info("######### Project Planned Issue update  #############");
        return true;
    }

    public static boolean addHoliday(Holidays holiday) {
        ModelDAO.save(DAOConstants.ENTITY_HOLIDAYS, holiday);
        logger.info("######### Holiday is added  #############");
        return true;
    }

    public static boolean updateHoliday(Holidays holiday) {
        ModelDAO.Update(DAOConstants.ENTITY_HOLIDAYS, holiday);
        logger.info("######### Holiday is added  #############");
        return true;
    }

    public static boolean deleteHoliday(Holidays holidays) {
        ModelDAO.delete(DAOConstants.ENTITY_HOLIDAYS, holidays);
        logger.info("######### Holiday is added  #############");
        return true;
    }

    public static boolean createBPA(BpmPrintaccess bpa) {
        ModelDAO.save(DAOConstants.ENTITY_BPM_PRINTACCESS, bpa);
        logger.info("######### BpmPrintaccess create  #############");
        return true;
    }

    public static boolean updateBPA(BpmPrintaccess bpa) {
        ModelDAO.Update(DAOConstants.ENTITY_BPM_PRINTACCESS, bpa);
        logger.info("######### BpmPrintaccess update  #############");
        return true;
    }

    public static boolean createMOMForClient(MomForClient momForClient) {
        ModelDAO.saveOrUpdate(DAOConstants.ENTITY_MOM_FOR_CLIENT, momForClient);
        logger.info("######### MOM ForClient created  #############");
        return true;
    }

    public static boolean updateMomForClient(MomForClient momForClient) {
        ModelDAO.update(DAOConstants.ENTITY_MOM_FOR_CLIENT, momForClient);
        logger.info("######### MOM ForClient updated  #############");
        return true;
    }

    public static boolean createWRMDay(ApmWrmDay awd) {
        ModelDAO.save(DAOConstants.ENTITY_APM_WRM_DAY, awd);
        logger.info("######### ApmWrmDay create  #############");
        return true;
    }

    public static boolean updateAWD(ApmWrmDay apmWrmDay) {
        ModelDAO.Update(DAOConstants.ENTITY_APM_WRM_DAY, apmWrmDay);
        logger.info("######### ApmWrmDay update  #############");
        return true;
    }

    public static boolean createApmTrFormat(ApmTrFormat atf) {
        ModelDAO.save(DAOConstants.ENTITY_APM_TR_FORMAT, atf);
        logger.info("######### ApmTrFormat create  #############");
        return true;
    }

    public static boolean updateApmTrFormat(ApmTrFormat atf) {
        ModelDAO.Update(DAOConstants.ENTITY_APM_TR_FORMAT, atf);
        logger.info("######### ApmTrFormat update  #############");
        return true;
    }

    public static boolean createApmWrmPlan(ApmWrmPlan awp) {
        ModelDAO.save(DAOConstants.ENTITY_APM_WRM_PLAN, awp);
        logger.info("######### ApmWrmPlan create  #############");
        return true;
    }

    public static boolean upateApmWrmPlan(ApmWrmPlan awp) {
        ModelDAO.update(DAOConstants.ENTITY_APM_WRM_PLAN, awp);
        logger.info("######### ApmWrmPlan create  #############");
        return true;
    }

    public static boolean createPMPerformance(PmPerformance pmPerformance) {
        ModelDAO.saveOrUpdate(DAOConstants.ENTITY_PM_PERFORMANCE, pmPerformance);
        logger.info("######### PM Performance created  #############");
        return true;
    }

    public static boolean savePMPerformance(PmPerformance pmPerformance) {
        ModelDAO.save(DAOConstants.ENTITY_PM_PERFORMANCE, pmPerformance);
        logger.info("######### PM Performance created  #############");
        return true;
    }

    public static boolean addFineAmtUser(FineAmountUsers fineAmountUsers) {
        ModelDAO.save(DAOConstants.ENTITY_FINE_AMOUNT_USERS, fineAmountUsers);
        logger.info("######### Fine Amt for User Added  #############");
        return true;
    }

    public static boolean updateFineAmtUser(FineAmountUsers fineAmountUsers) {
        ModelDAO.Update(DAOConstants.ENTITY_FINE_AMOUNT_USERS, fineAmountUsers);
        logger.info("######### Fine Amt for User Added  #############");
        return true;
    }

    public static boolean addReason(Fine reason) {
        ModelDAO.save(DAOConstants.ENTITY_FINE, reason);
        logger.info("######### Reason Added  #############");
        return true;
    }

    public static boolean addFinePayment(ErmFinePaid payment) {
        ModelDAO.save(DAOConstants.ENTITY_ERM_FINE_PAID, payment);
        logger.info("######### Payment Added  #############");
        return true;
    }

    public static boolean updateFinePayment(ErmFinePaid payment) {
        ModelDAO.Update(DAOConstants.ENTITY_ERM_FINE_PAID, payment);
        logger.info("######### Payment updated  #############");
        return true;
    }

    public static boolean addFinePaymentHistory(ErmFinePaymentHistory payment) {
        ModelDAO.save(DAOConstants.ERM_FINE_PAYMENT_HISTORY, payment);
        logger.info("######### Payment History Added  #############");
        return true;
    }

    public static boolean addTargetCount(ApmTargetIssueCount atc) {
        ModelDAO.save(DAOConstants.ENTITY_APM_TARGET_ISSUE_COUNT, atc);
        logger.info("######### Target Count Added  #############");
        return true;
    }

    public static boolean updateTargetCount(ApmTargetIssueCount atc) {
        ModelDAO.update(DAOConstants.ENTITY_APM_TARGET_ISSUE_COUNT, atc);
        logger.info("######### Target Count updated  #############");
        return true;
    }

    public static boolean addTESTSTEPID(ApmIssueTeststepId aiti) {
        ModelDAO.save(DAOConstants.ENTITY_APM_ISSUE_TESTSTEP_ID, aiti);
        logger.info("######### Test step id is added for ISSUE  #############");
        return true;
    }
}
