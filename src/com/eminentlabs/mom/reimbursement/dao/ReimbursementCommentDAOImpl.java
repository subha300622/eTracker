/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.reimbursement.dao;

import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.reimbursement.ReimbursementComments;

/**
 *
 * @author EMINENT
 */
public class ReimbursementCommentDAOImpl implements ReimbursementCommentDAO {

    @Override
    public void saveReimbursementComment(ReimbursementComments reimbursementComment) {

        ModelDAO.save(DAOConstants.ENTITY_REIMBURSEMENT_COMMENTS, reimbursementComment);
    }

}
