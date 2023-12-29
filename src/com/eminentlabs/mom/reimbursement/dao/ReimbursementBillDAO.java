/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.reimbursement.dao;

import com.eminentlabs.mom.reimbursement.ReimbursementBill;

/**
 *
 * @author EMINENT
 */
public interface ReimbursementBillDAO {

    public void saveReimbursementBill(ReimbursementBill reimbursementBill);

    public boolean deleteReimbursementBill(ReimbursementBill reimbursementBill);
    
    public ReimbursementBill findReimbursementBillByrbId(Long rbId);
    
    public Integer monthlyFileCount(String countKeyWord, Long rvId);
    
    public ReimbursementBill findByFileName(String fileName);
}
