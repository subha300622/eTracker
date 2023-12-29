/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.IssueCategory;
import java.util.List;

/**
 *
 * @author DhanVa CompuTers
 */
public interface IssueCategoryDAO {

    public List<IssueCategory> getAll();

    public IssueCategory getByID(int categoryId);

    public List<IssueCategory> getByPid(int pid);

    public IssueCategory getByPidNCategory(int pid, String category);

}
