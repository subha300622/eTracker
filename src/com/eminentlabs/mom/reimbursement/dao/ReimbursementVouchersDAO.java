/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.reimbursement.dao;

import com.eminentlabs.mom.reimbursement.ReimbursementVouchers;
import java.util.Date;
import java.util.List;

/**
 *
 * @author EMINENT
 */
public interface ReimbursementVouchersDAO {

    public List<ReimbursementVouchers> findAll();

    public List<ReimbursementVouchers> findByRequestedBy(Integer requestedBy);
    
    public List<ReimbursementVouchers> findForAccountant(Integer requestedBy);

    public void saveReimbursementVouchers(ReimbursementVouchers reimbursementVouchers);

    public Integer monthlyFileCount(String countKeyWord);

    public ReimbursementVouchers findReimbursementVouchersByrvId(Long rvId);

    public boolean deleteReimbursementVouchers(ReimbursementVouchers reimbursementVouchers);

    public ReimbursementVouchers findByFileName(String fileName);

    public void updateReimbursementVouchers(ReimbursementVouchers reimbursementVouchers);

    public List<ReimbursementVouchers> findBetweenPeriod(Date startMonth, Date endMonth);

}
