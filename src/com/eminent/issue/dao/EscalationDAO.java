/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.controller.Escalation;
import java.util.List;
import java.util.Map;

/**
 *
 * @author vanithaalliraj
 */
public interface EscalationDAO {

    public String getEscalationCount();

    public List<String> escalationList(int projectId);

    public List<String> AllEscalations(int projectId);

    public List<Integer> escalationProejctList();

    public List<Escalation> getEscalation();

    public String getEscalationStatus(String issue);
    
    Map<Integer, String> getEscalationAnswer(String issue);
    
    public List<Escalation> getWRMPlannedIssues();
    public List<Escalation> getTodayUntouchedIssues();
    public List<Escalation> getESPLEscalation();
    

}
