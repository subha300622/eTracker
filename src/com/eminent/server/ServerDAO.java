/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.server;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 *
 * @author vanithaalliraj
 */
public interface ServerDAO {

    List<SapServerType> getServerTypes();

    List<SapSystemType> getSystemTypes();

    List<ServerSystem> getServerMatrixByPID(int pid, int active);

    List<ServerSystem> getAllServerMatrixByPID(int pid);

    public ServerSystem getMatrix(int pid, int serverId, int systemId);

    public void addMatrix(ServerSystem ss);

    public void updateMatrix(ServerSystem ss);

    List<SapMonitoringParamaters> getAllParameters();

    List<SapMonitoringParamaters> getParametersByServerId(int serverId);

    SapMonitoringParamaters getParameter(int serverId, String parameterName);

    List<Integer> getCheckedParameters(int projectid, int serverId, int companyCode);

    List<ServerSystem> getServerMatrixByPIDAndServerId(int pid, int active, int serverId);

    public void updateMatrixParameters(int serverId, int pid, int companyCode);

    SapMatrixParameter getMatrixparam(int matrixId, int parameterId, int companyCode);

    MonitoringIssue getIssueIdbyPidNCompCode(int pid, int companyCode);

    MonitoringIssue getPIdbyIssueId(String issueid);

    Map<String, String> getBasisIssues(int pid);

    List<ParameterStatus> getMatrixParameters(int pid, int serverId, int companyCode);

    List<SapMatrixParamUpdates> getMatrixParamUpdates(int pid, int serverId, int companyCode, String date);

    public void updateIssueComments(String issueid, String userid, String comments, int projectId, int companyCode);

//   Map<Integer,Map<Integer,Map<Integer,List<ParameterStatus>>>> getMonitoringStatusByPidDate(int pid,String date);
    List<StatusHistory> getMonitoringStatusByPidDate(int pid, String date);

    List<SapLogon> getLogonByPidServerId(int pid, int serverId,int companycode);

    ApmSapVpn getVPNByPid(int pid);

    List<ApmSapLogonCredential> getCredentialByMid(int mid,int companyCode);

    ApmSapLogonCredential getCredentialByMidAndModuleId(int pid, int mid, String module,int companycode);

    List<SapConfig> getConfigByPidServerId(int pid, int serverId,int companycode);

    List<ApmSapLogonMaintain> getAll();
    
    ApmSapLogonMaintain getLogonMaintainByPid(int pid);
}
