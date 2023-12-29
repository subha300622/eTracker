/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.timesheet.dao;

import com.eminent.timesheet.TimesheetMaintanance;
import java.util.List;

/**
 *
 * @author EMINENT
 */
public interface TimesheetDAO {

    public List<TimesheetMaintanance> findAll();
    public TimesheetMaintanance findByRequester(int requesterId);
     public TimesheetMaintanance findById(Long id);

  
    public List<Integer> findRoleByUserId(Integer userId);

}
