/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.server;

import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.userBPM.ViewBPM;
import com.pack.DAO.AdminProjectModuleDAOImpl;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DhanVa CompuTers
 */
public class VpnController {

    String pid, messge, mid, moduleid, client, serverid;
    ApmSapVpn vpn = null;
    List<ApmSapLogonCredential> credentials = null;
    Map<Integer, String> modules = null;
    List<SapServerType> allServers = null;
    List<SapSystemType> allSystems = null;
    Set<Integer> matrixServers = null;
    Set<Integer> matrixSystems = null;
    List<ServerSystem> serverMatrix = null;
    ApmSapLogonCredential credential = null;
    int companyCode = 0;
    Map<Integer, String> companyCodes = null;

    public void setAll(HttpServletRequest request) {
        pid = request.getParameter("pid");
        try {
            if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("id") != null) {
                ApmSapVpn apmSapVpn = new ApmSapVpn();
                if (!request.getParameter("id").equals("")) {
                    apmSapVpn.setId(Integer.parseInt(request.getParameter("id")));
                    apmSapVpn.setPid(Integer.parseInt(pid));
                    apmSapVpn.setVIpAdd(request.getParameter("ipaddress"));
                    apmSapVpn.setVPort(Integer.parseInt(request.getParameter("port")));
                    apmSapVpn.setVUname(request.getParameter("username"));
                    apmSapVpn.setVPwd(request.getParameter("password"));
                    apmSapVpn.setVName(request.getParameter("url"));
                    ModelDAO.Update("ApmSapVpn", apmSapVpn);
                } else {
                    apmSapVpn.setPid(Integer.parseInt(pid));
                    apmSapVpn.setVIpAdd(request.getParameter("ipaddress"));
                    apmSapVpn.setVPort(Integer.parseInt(request.getParameter("port")));
                    apmSapVpn.setVUname(request.getParameter("username"));
                    apmSapVpn.setVPwd(request.getParameter("password"));
                    apmSapVpn.setVName(request.getParameter("url"));

                    ModelDAO.save("ApmSapVpn", apmSapVpn);
                }
                messge = "VPN detail has been maintained successfully";
            }
            vpn = new ServerDAOImpl().getVPNByPid(Integer.parseInt(pid));
        } catch (Exception e) {
            messge = "Something went wrong. " + e.getMessage();
        }
    }

    public void setLogonCre(HttpServletRequest request) {
        pid = request.getParameter("pid");
        mid = request.getParameter("mid");
        serverid = request.getParameter("serverid");
        String companyId = request.getParameter("companyCode");
        ServerDAO serverDAO = new ServerDAOImpl();
        matrixServers = new TreeSet<>();
        companyCodes = (Map<Integer, String>) ViewBPM.getCompany(Integer.parseInt(pid));
        if (companyId == null) {
            for (int compId : companyCodes.keySet()) {
                companyCode = compId;
                break;
            }
        } else {
            companyCode = Integer.parseInt(companyId);
        }
        try {
            if (request.getMethod().equalsIgnoreCase("post") && request.getParameterValues("id") != null) {
                String moduleId[] = request.getParameterValues("moduleId");
                String ids[] = request.getParameterValues("id");
                client = request.getParameter("clientno");
                for (int i = 0; i < moduleId.length; i++) {
                    if (ids[i].equals("")) {
                        ApmSapLogonCredential aslc = new ApmSapLogonCredential();
                        aslc.setMId(Integer.parseInt(mid));
                        aslc.setCompanyCode(companyCode);
                        aslc.setModuleId(Integer.parseInt(moduleId[i]));
                        aslc.setClinetNo(Integer.parseInt(client));
                        aslc.setUname(request.getParameter("username" + moduleId[i]));
                        aslc.setPwd(request.getParameter("password" + moduleId[i]));
                        ModelDAO.save("ApmSapLogonCredential", aslc);
                    } else {
                        ApmSapLogonCredential aslc = new ApmSapLogonCredential();
                        aslc.setId(Integer.parseInt(ids[i]));
                        aslc.setCompanyCode(companyCode);
                        aslc.setMId(Integer.parseInt(mid));
                        aslc.setModuleId(Integer.parseInt(moduleId[i]));
                        aslc.setClinetNo(Integer.parseInt(client));
                        aslc.setUname(request.getParameter("username" + moduleId[i]));
                        aslc.setPwd(request.getParameter("password" + moduleId[i]));
                        ModelDAO.update("ApmSapLogonCredential", aslc);
                    }
                }
                messge = "SAP Logon credeantial has been maintained successfully";
            }
            allServers = serverDAO.getServerTypes();
            allSystems = serverDAO.getSystemTypes();
            for (SapServerType sst : allServers) {
                for (ServerSystem ss : serverDAO.getServerMatrixByPID(Integer.parseInt(pid), 1)) {
                    if (sst.getSId() == ss.getServerId()) {
                        matrixServers.add(sst.getSId());
                        if (serverid == null) {
                            serverid = sst.getSId() + "";
                        }
                        if (mid == null) {
                            mid = ss.getMId() + "";
                        }
                    }
                }
            }
            if (!matrixServers.isEmpty()) {
                serverMatrix = serverDAO.getServerMatrixByPIDAndServerId(Integer.parseInt(pid), 1, Integer.parseInt(serverid));
                credentials = serverDAO.getCredentialByMid(Integer.parseInt(mid),companyCode);
                modules = new AdminProjectModuleDAOImpl().getAllModuleByProject(Integer.parseInt(pid));
                if (credentials != null && !credentials.isEmpty()) {
                    for (ApmSapLogonCredential aslc : credentials) {
                        client = aslc.getClinetNo() + "";
                    }
                }
            }

        } catch (Exception e) {
            messge = "Something went wrong. " + e.getMessage();
        }
    }

    public void getCredentialByModule(HttpServletRequest request) {
        mid = request.getParameter("mid");
        pid = request.getParameter("pid");
        HttpSession session = request.getSession();
        moduleid = "" + session.getAttribute("team");
        String companyId = request.getParameter("companyCode");
        matrixServers = new TreeSet<>();
        companyCodes = (Map<Integer, String>) ViewBPM.getCompany(Integer.parseInt(pid));
        if (companyId == null) {
            for (int compId : companyCodes.keySet()) {
                companyCode = compId;
                break;
            }
        } else {
            companyCode = Integer.parseInt(companyId);
        }

        credential = new ServerDAOImpl().getCredentialByMidAndModuleId(Integer.parseInt(pid), Integer.parseInt(mid), moduleid,companyCode);

    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getMessge() {
        return messge;
    }

    public void setMessge(String messge) {
        this.messge = messge;
    }

    public ApmSapVpn getVpn() {
        return vpn;
    }

    public void setVpn(ApmSapVpn vpn) {
        this.vpn = vpn;
    }

    public String getMid() {
        return mid;
    }

    public void setMid(String mid) {
        this.mid = mid;
    }

    public String getModuleid() {
        return moduleid;
    }

    public void setModuleid(String moduleid) {
        this.moduleid = moduleid;
    }

    public List<ApmSapLogonCredential> getCredentials() {
        return credentials;
    }

    public void setCredentials(List<ApmSapLogonCredential> credentials) {
        this.credentials = credentials;
    }

    public Map<Integer, String> getModules() {
        return modules;
    }

    public void setModules(Map<Integer, String> modules) {
        this.modules = modules;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getServerid() {
        return serverid;
    }

    public void setServerid(String serverid) {
        this.serverid = serverid;
    }

    public List<SapServerType> getAllServers() {
        return allServers;
    }

    public void setAllServers(List<SapServerType> allServers) {
        this.allServers = allServers;
    }

    public List<SapSystemType> getAllSystems() {
        return allSystems;
    }

    public void setAllSystems(List<SapSystemType> allSystems) {
        this.allSystems = allSystems;
    }

    public Set<Integer> getMatrixServers() {
        return matrixServers;
    }

    public void setMatrixServers(Set<Integer> matrixServers) {
        this.matrixServers = matrixServers;
    }

    public Set<Integer> getMatrixSystems() {
        return matrixSystems;
    }

    public void setMatrixSystems(Set<Integer> matrixSystems) {
        this.matrixSystems = matrixSystems;
    }

    public List<ServerSystem> getServerMatrix() {
        return serverMatrix;
    }

    public void setServerMatrix(List<ServerSystem> serverMatrix) {
        this.serverMatrix = serverMatrix;
    }

    public ApmSapLogonCredential getCredential() {
        return credential;
    }

    public void setCredential(ApmSapLogonCredential credential) {
        this.credential = credential;
    }

    public int getCompanyCode() {
        return companyCode;
    }

    public void setCompanyCode(int companyCode) {
        this.companyCode = companyCode;
    }

    public Map<Integer, String> getCompanyCodes() {
        return companyCodes;
    }

    public void setCompanyCodes(Map<Integer, String> companyCodes) {
        this.companyCodes = companyCodes;
    }

}
