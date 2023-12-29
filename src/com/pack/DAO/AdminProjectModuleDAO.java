/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack.DAO;

import com.pack.controller.formbean.EditmoduleFormBean;
import java.util.List;
import java.util.Map;

/**
 *
 * @author admin
 */
public interface AdminProjectModuleDAO {

    public void moduleUpdate(int mid, String module, int customerOwner, int internalOwner, int pid, int target, int targetId);

    public EditmoduleFormBean getEditModuleByMid(int mid);

    public EditmoduleFormBean getTargetByMid(int mid);

    public List<EditmoduleFormBean> getModuleByPID(int pid);

    public Map<Integer, Integer> getModuletargetByMonth(int pid);

    public Integer getNoOfModuleByPid(int pid);

    public String checkExistModule(String mname, int pid);

    public String CreateNewModule(String mname, int pid, int target);

    public Map<Integer, String> getAllModuleByProject(Integer pid);

    public Integer getOpenIssueBYMid(Integer mid);

    public List<EditmoduleFormBean> getModuleTargetByPID(int pid);

    public String saveUpdate(String[] target);
}
