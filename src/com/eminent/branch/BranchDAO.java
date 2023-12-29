/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.branch;

import java.util.List;

/**
 *
 * @author Muthu
 */
public interface BranchDAO {

    public List<Branches> findAll();

    public Branches findByBranchId(int branchId);

    public Branches findByLocation(String location);

}
