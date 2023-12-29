/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.ApmIssueAssignment;
import java.util.List;

/**
 *
 * @author DhanVa CompuTers
 */
public interface ApmIssueAssignDAO {
    
    ApmIssueAssignment getApmIssueAssignmentByPid(int pid);
    
    List<ApmIssueAssignment> getAll();
}
