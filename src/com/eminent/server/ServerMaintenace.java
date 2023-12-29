/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.server;

import com.eminent.util.SendMail;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.userBPM.ViewBPM;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author vanithaalliraj
 */
public class ServerMaintenace {

    List<SapServerType> allServers = new ArrayList<>();
    List<SapSystemType> allSystems = new ArrayList<>();
    List<ServerSystem> serverMatrix = new ArrayList<>();
    String pid, messge, issueid = "", moniDate = null;
    List<String> allInputTypes = new ArrayList<>();
    List<SapMonitoringParamaters> sapMonitoringParamaterses = new ArrayList<>();
    int serverId = 1, companyCode = 0;
    Set<Integer> matrixServers = new TreeSet<>();
    Set<Integer> matrixSystems = new TreeSet<>();
    List<Integer> checkedParameters = new ArrayList<>();
    Map<Integer, List<ParameterStatus>> map = new TreeMap<>();
    Map<Integer, String> companyCodes = null;
    Map<Integer, Map<Integer, Map<Integer, List<StatusHistory>>>> moniStat = null;
    Map<Integer, List<SapMonitoringParamaters>> parameters = null;
    List<SapLogon> sapLogons = new ArrayList<>();
    List<SapConfig> sapConfigs = new ArrayList<>();

    public void getTypes(HttpServletRequest request) {
        ServerDAO serverDAO = new ServerDAOImpl();
        pid = request.getParameter("pid");
        serverMatrix = serverDAO.getServerMatrixByPID(Integer.parseInt(pid), 1);
        allServers = serverDAO.getServerTypes();
        allSystems = serverDAO.getSystemTypes();

    }

    public void getERPDetail(HttpServletRequest request) {
        ServerDAO serverDAO = new ServerDAOImpl();
        pid = request.getParameter("pid");
        String server = request.getParameter("serverId");
        String companyId = request.getParameter("companyCode");
        if (server == null) {
            serverId = 1;
        } else {
            serverId = Integer.parseInt(server);
        }
        companyCodes = (Map<Integer, String>) ViewBPM.getCompany(Integer.parseInt(pid));
        if (companyId == null) {
            for (int compId : companyCodes.keySet()) {
                companyCode = compId;
                break;
            }
        } else {
            companyCode = Integer.parseInt(companyId);
        }
        serverMatrix = serverDAO.getServerMatrixByPID(Integer.parseInt(pid), 1);
        allServers = serverDAO.getServerTypes();
        for (SapServerType sst : allServers) {
            for (ServerSystem ss : serverDAO.getServerMatrixByPID(Integer.parseInt(pid), 1)) {
                if (sst.getSId() == ss.getServerId()) {
                    matrixServers.add(sst.getSId());
                }
            }
        }
        if (request.getMethod().equalsIgnoreCase("post")) {
            String[] mids = request.getParameterValues("matrixId");
            String[] lids = request.getParameterValues("lid");
            if (mids != null) {
                for (int i = 0; i < mids.length; i++) {
                    ApmSapConfig apmSapLogon = new ApmSapConfig();
                    if (!lids[i].equals("0")) {
                        apmSapLogon.setId(Integer.parseInt(lids[i]));
                        apmSapLogon.setMId(Integer.parseInt(mids[i]));
                        apmSapLogon.setOsName(request.getParameter("os" + mids[i]));
                        apmSapLogon.setErpVersion(request.getParameter("erp" + mids[i]));
                        apmSapLogon.setEhpVersion(request.getParameter("ehp" + mids[i]));
                        apmSapLogon.setDbVersion(request.getParameter("db" + mids[i]));
                        apmSapLogon.setCompanyCode(companyCode);
                        ModelDAO.update("ApmSapConfig", apmSapLogon);
                    } else {
                        apmSapLogon.setMId(Integer.parseInt(mids[i]));
                        apmSapLogon.setOsName(request.getParameter("os" + mids[i]));
                        apmSapLogon.setErpVersion(request.getParameter("erp" + mids[i]));
                        apmSapLogon.setEhpVersion(request.getParameter("ehp" + mids[i]));
                        apmSapLogon.setDbVersion(request.getParameter("db" + mids[i]));
                        apmSapLogon.setCompanyCode(companyCode);
                        ModelDAO.save("ApmSapConfig", apmSapLogon);
                    }
                }
                messge = "SAP system config has been maintained successfully";
            }
        }
        sapConfigs = serverDAO.getConfigByPidServerId(Integer.parseInt(pid), serverId, companyCode);
    }

    public void getAllTypes(HttpServletRequest request) {
        ServerDAO serverDAO = new ServerDAOImpl();
        pid = request.getParameter("pid");
        String companyId = request.getParameter("companyCode");
        String server = request.getParameter("serverId");
        if (server == null) {
            serverId = 1;
        } else {
            serverId = Integer.parseInt(server);
        }
        allServers = serverDAO.getServerTypes();
        companyCodes = (Map<Integer, String>) ViewBPM.getCompany(Integer.parseInt(pid));
        if (companyId == null) {
            for (int compId : companyCodes.keySet()) {
                companyCode = compId;
                break;
            }
        } else {
            companyCode = Integer.parseInt(companyId);
        }
        for (SapServerType sst : allServers) {
            for (ServerSystem ss : serverDAO.getServerMatrixByPID(Integer.parseInt(pid), 1)) {
                if (sst.getSId() == ss.getServerId()) {
                    matrixServers.add(sst.getSId());
                }
            }
        }
        if (request.getMethod().equalsIgnoreCase("post")) {
            String[] mids = request.getParameterValues("matrixId");
            String[] lids = request.getParameterValues("lid");
            if (mids != null) {
                for (int i = 0; i < mids.length; i++) {
                    ApmSapLogon apmSapLogon = new ApmSapLogon();
                    if (!lids[i].equals("0")) {
                        apmSapLogon.setId(Integer.parseInt(lids[i]));
                        apmSapLogon.setMId(Integer.parseInt(mids[i]));
                        apmSapLogon.setAppServer(request.getParameter("applServer" + mids[i]));
                        apmSapLogon.setSId(request.getParameter("systemId" + mids[i]));
                        apmSapLogon.setInstNo(Integer.parseInt(request.getParameter("instanceNo" + mids[i])));
                        apmSapLogon.setRoutStr(request.getParameter("router" + mids[i]));
                        apmSapLogon.setCompanyCode(companyCode);
                        ModelDAO.update("ApmSapLogon", apmSapLogon);
                    } else {
                        apmSapLogon.setMId(Integer.parseInt(mids[i]));
                        apmSapLogon.setAppServer(request.getParameter("applServer" + mids[i]));
                        apmSapLogon.setSId(request.getParameter("systemId" + mids[i]));
                        apmSapLogon.setInstNo(Integer.parseInt(request.getParameter("instanceNo" + mids[i])));
                        apmSapLogon.setRoutStr(request.getParameter("router" + mids[i]));
                        apmSapLogon.setCompanyCode(companyCode);
                        ModelDAO.save("ApmSapLogon", apmSapLogon);
                    }
                }
                messge = "SAP system detail has been maintained successfully";
            }
        }
        sapLogons = serverDAO.getLogonByPidServerId(Integer.parseInt(pid), serverId, companyCode);
    }

    public String getMonitoringIssue(int projectId, int companyCode) {
        ServerDAO serverDAO = new ServerDAOImpl();
        MonitoringIssue mi = serverDAO.getIssueIdbyPidNCompCode(projectId, companyCode);
        return mi == null ? "" : mi.getIssueid();
    }

    public String getMonitoringIssue(HttpServletRequest request) {
        String issueId = request.getParameter("issueid");
        ServerDAO serverDAO = new ServerDAOImpl();
        MonitoringIssue mi = serverDAO.getPIdbyIssueId(issueId);
        if (mi == null) {
            return "0";
        } else {
            return mi.getPid() + "-" + mi.getCompanyCode();
        }

    }

    public void getMonitoringStatus(HttpServletRequest request) {
        DateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        ServerDAO serverDAO = new ServerDAOImpl();
        allServers = serverDAO.getServerTypes();
        allSystems = serverDAO.getSystemTypes();
        moniDate = request.getParameter("moniDate");
        pid = request.getParameter("pid");
        companyCodes = (Map<Integer, String>) ViewBPM.getCompany(Integer.parseInt(pid));
        Calendar c = new GregorianCalendar();
        Date date = c.getTime();
        if (moniDate != null) {
            Date moniDateFormat = null;
            try {
                moniDateFormat = sdf.parse(moniDate);
            } catch (ParseException ex) {
                Logger.getLogger(ServerMaintenace.class.getName()).log(Level.SEVERE, null, ex);
            }
            moniDate = sdf.format(moniDateFormat);
        } else {
            moniDate = sdf.format(date);
        }
        if (pid == null) {
            pid = "0";
        }

        List<StatusHistory> historys = serverDAO.getMonitoringStatusByPidDate(Integer.parseInt(pid), moniDate);
        sapMonitoringParamaterses = serverDAO.getAllParameters();

        moniStat = new TreeMap<>();
        for (StatusHistory sh : historys) {
            if (!checkedParameters.contains(sh.getParameterId())) {
                checkedParameters.add(sh.getParameterId());
            }
            Map<Integer, Map<Integer, List<StatusHistory>>> maps = moniStat.get(sh.getServerId());
            if (maps == null) {
                maps = new TreeMap<>();
            }
            Map<Integer, List<StatusHistory>> ma = maps.get(sh.getCompayCode());
            if (ma == null) {
                ma = new TreeMap<>();
            }

            List<StatusHistory> list = ma.get(sh.getSystemId());
            if (list == null) {
                list = new ArrayList<>();
            }
            list.add(sh);
            ma.put(sh.getSystemId(), list);
            maps.put(sh.getCompayCode(), ma);
            moniStat.put(sh.getServerId(), maps);

        }

    }

    public void getParameterInputTypes(HttpServletRequest request) {
        ServerDAO serverDAO = new ServerDAOImpl();
        HttpSession session = request.getSession();
        getParameterType();
        allServers = serverDAO.getServerTypes();
        allSystems = serverDAO.getSystemTypes();
        String server = request.getParameter("serverId");
        pid = request.getParameter("pid");
        String uid = "" + session.getAttribute("uid");
        Date today = new Date();
        if (server == null) {
            serverId = 1;
        } else {
            serverId = Integer.parseInt(server);
        }
        try {
            if (request.getMethod().equalsIgnoreCase("post")) {

                String paramaterName[] = request.getParameterValues("paramaterName");
                String paramaterType[] = request.getParameterValues("parameterType");
                String paramaterValue[] = request.getParameterValues("parameterValue");
                //   String abnormalValue[] = request.getParameterValues("abnormalValue");
                String paramaterId[] = request.getParameterValues("parameterId");
                for (int i = 0; i < paramaterName.length; i++) {
                    if (!paramaterId[i].equals("0")) {
                        SapMonitoringParamaters smp = new SapMonitoringParamaters();
                        smp.setParameterId(Integer.parseInt(paramaterId[i]));
                        smp.setServerId(serverId);
                        smp.setParameterName(paramaterName[i]);
                        smp.setParameterType(paramaterType[i]);
                        if (paramaterType[i].equalsIgnoreCase("text")) {
                            smp.setParameterValues("");
                        } else if (paramaterType[i].equalsIgnoreCase("radio")) {
                            if (!paramaterValue[i].endsWith(",NA")) {
                                smp.setParameterValues(paramaterValue[i] + ",NA");
                            } else {
                                smp.setParameterValues(paramaterValue[i]);
                            }
                        } else {
                            smp.setParameterValues(paramaterValue[i]);
                        }
                        //      smp.setAbnormalValue(abnormalValue[i]);

                        smp.setUpdateBy(Integer.parseInt(uid));
                        smp.setUpdateOn(today);
                        ModelDAO.update("SapMonitoringParamaters", smp);
                    } else {
//                        SapMonitoringParamaters smp = serverDAO.getParameter(serverId, paramaterName[i]);
//                        if (smp == null) {
                        SapMonitoringParamaters smp = new SapMonitoringParamaters();

                        smp.setServerId(serverId);
                        smp.setParameterName(paramaterName[i]);
                        smp.setParameterType(paramaterType[i]);
                        if (paramaterType[i].equalsIgnoreCase("text")) {
                            smp.setParameterValues("");
                        } else {
                            smp.setParameterValues(paramaterValue[i]);
                        }
                        //      smp.setAbnormalValue(abnormalValue[i]);
                        smp.setAddedBy(Integer.parseInt(uid));
                        smp.setUpdateBy(smp.getAddedBy());
                        smp.setAddedOn(today);
                        smp.setUpdateOn(today);
                        ModelDAO.save("SapMonitoringParamaters", smp);
//                        } else {
//                            smp.setServerId(serverId);
//                            smp.setParameterName(paramaterName[i]);
//                            smp.setParameterType(paramaterType[i]);
//                            if (paramaterType[i].equalsIgnoreCase("text")) {
//                                smp.setParameterValues("");
//                            } else {
//                                smp.setParameterValues(paramaterValue[i]);
//                            }
//                            smp.setUpdateBy(Integer.parseInt(uid));
//                            smp.setUpdateOn(today);
//                            ModelDAO.update("SapMonitoringParamaters", smp);
//                        }
                    }
                }
                messge = "Parameter setup maintained successfully";
            }
        } catch (Exception e) {
            e.printStackTrace();
            messge = "Parameter setup maintained faliure" + e.getMessage();

        }
        if (serverId
                > 0) {
            sapMonitoringParamaterses = serverDAO.getParametersByServerId(serverId);
        }
    }

    public void getMatrixParameters(HttpServletRequest request) {
        ServerDAO serverDAO = new ServerDAOImpl();
        HttpSession session = request.getSession();
        getParameterType();
        allServers = serverDAO.getServerTypes();
        allSystems = serverDAO.getSystemTypes();
        String server = request.getParameter("serverId");
        pid = request.getParameter("pid");
        issueid = request.getParameter("issueid");
        String companyId = request.getParameter("companyCode");
        companyCodes = (Map<Integer, String>) ViewBPM.getCompany(Integer.parseInt(pid));
        String uid = "" + session.getAttribute("uid");
        Date today = new Date();
        if (server == null) {
            serverId = 1;
        } else {
            serverId = Integer.parseInt(server);
        }
        if (companyId == null) {
            for (int compId : companyCodes.keySet()) {
                companyCode = compId;
                break;
            }
        } else {
            companyCode = Integer.parseInt(companyId);
        }
        serverMatrix = serverDAO.getServerMatrixByPID(Integer.parseInt(pid), 1);
        try {
            if (request.getMethod().equalsIgnoreCase("post") && server != null) {
                String checkedParams[] = request.getParameterValues("parameterId");
                if (checkedParams != null) {
                    serverDAO.updateMatrixParameters(serverId, Integer.parseInt(pid), companyCode);
                    //   List<ServerSystem> sses = serverDAO.getServerMatrixByPIDAndServerId(Integer.parseInt(pid), 1, serverId);
                    for (String param : checkedParams) {
                        for (ServerSystem ss : serverMatrix) {
                            if (ss.getServerId() == serverId) {
                                SapMatrixParameter smp = serverDAO.getMatrixparam(ss.getMId(), Integer.parseInt(param), companyCode);
                                if (smp == null) {
                                    smp = new SapMatrixParameter();
                                    smp.setMatrixId(ss.getMId());
                                    smp.setCompanyCode(companyCode);
                                    smp.setParameterId(Integer.parseInt(param));
                                    smp.setIsActive(1);
                                    smp.setAddedBy(Integer.parseInt(uid));
                                    smp.setAddedOn(today);
                                    smp.setUpdatedBy(Integer.parseInt(uid));
                                    smp.setUpdatedOn(today);
                                    ModelDAO.save("SapMatrixParameter", smp);
                                } else {
                                    smp.setMatrixId(ss.getMId());
                                    smp.setParameterId(Integer.parseInt(param));
                                    smp.setCompanyCode(companyCode);
                                    smp.setIsActive(1);
                                    smp.setUpdatedBy(Integer.parseInt(uid));
                                    smp.setUpdatedOn(today);
                                    ModelDAO.update("SapMatrixParameter", smp);
                                }
                            }
                        }
                    }
                    messge = "Parameter setup maintained successfully";
                }
                issueid = request.getParameter("issueid");
                if (issueid != null) {
                    MonitoringIssue mi = serverDAO.getIssueIdbyPidNCompCode(Integer.parseInt(pid), companyCode);
                    if (mi == null) {
                        mi = new MonitoringIssue();
                        mi.setIssueid(issueid);
                        mi.setPid(Integer.parseInt(pid));
                        mi.setCompanyCode(companyCode);
                        mi.setAddedBy(Integer.parseInt(uid));
                        mi.setAddedon(today);
                        ModelDAO.save("MonitoringIssue", mi);
                    } else {
                        mi.setIssueid(issueid);
                        mi.setPid(Integer.parseInt(pid));
                        mi.setCompanyCode(companyCode);
                        mi.setAddedBy(Integer.parseInt(uid));
                        mi.setAddedon(today);
                        ModelDAO.update("MonitoringIssue", mi);
                    }
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            messge = "Parameter setup maintained faliure" + e.getMessage();
        }
        for (SapServerType sst : allServers) {
            for (ServerSystem ss : serverMatrix) {
                if (sst.getSId() == ss.getServerId()) {
                    matrixServers.add(sst.getSId());
                }
            }
        }
        if (serverId > 0 && companyCode > 0) {
            sapMonitoringParamaterses = serverDAO.getParametersByServerId(serverId);
            checkedParameters = serverDAO.getCheckedParameters(Integer.parseInt(pid), serverId, companyCode);

        }
        MonitoringIssue mi = serverDAO.getIssueIdbyPidNCompCode(Integer.parseInt(pid), companyCode);
        if (mi != null) {
            issueid = mi.getIssueid();
        }
    }

    public void updateParameterStatus(HttpServletRequest request) {
        ServerDAO serverDAO = new ServerDAOImpl();
        HttpSession session = request.getSession();
        allServers = serverDAO.getServerTypes();
        allSystems = serverDAO.getSystemTypes();
        String server = request.getParameter("serverId");
        pid = request.getParameter("pid");
        String uid = "" + session.getAttribute("uid");
        String companyId = request.getParameter("companyCode");
        List<SapMatrixParamUpdates> matrixParamUpdates = null;
        String abnormalParameters = "";
        String servername = "";
        Date today = new Date();
        if (server == null) {
            serverId = 1;
        } else {
            serverId = Integer.parseInt(server);
        }
        companyCodes = (Map<Integer, String>) ViewBPM.getCompany(Integer.parseInt(pid));
        if (companyId == null) {
            for (int compId : companyCodes.keySet()) {
                companyCode = compId;
                break;
            }
        } else {
            companyCode = Integer.parseInt(companyId);
        }
        String statusDate = new SimpleDateFormat("dd-MMM-yyyy").format(today);

        serverMatrix = serverDAO.getServerMatrixByPID(Integer.parseInt(pid), 1);
        sapMonitoringParamaterses = serverDAO.getParametersByServerId(serverId);
        List<ParameterStatus> matrixParameters = serverDAO.getMatrixParameters(Integer.parseInt(pid), serverId, companyCode);
        for (SapServerType sst : allServers) {
            for (ServerSystem ss : serverMatrix) {
                if (sst.getSId() == ss.getServerId()) {
                    matrixServers.add(sst.getSId());
                }
            }
        }
        try {
            if (request.getMethod().equalsIgnoreCase("post")) {
//                MonitoringIssue mi = serverDAO.getIssueIdbyPidNCompCode(Integer.parseInt(pid), companyCode);
//                if (mi != null) {
//                    issueid = mi.getIssueid();
//                }
                String matrixParamId[] = request.getParameterValues("matrixParamId");
                if (matrixParamId != null) {
                    matrixParamUpdates = serverDAO.getMatrixParamUpdates(Integer.parseInt(pid), serverId, companyCode, statusDate);
                    if (matrixParamUpdates.isEmpty()) {
                        for (String id : matrixParamId) {
                            if (request.getParameterValues(id + "val") != null) {
                                SapMatrixParamUpdates paramUpdates = new SapMatrixParamUpdates();
                                StringBuilder nameBuilder = new StringBuilder();
                                for (String n : request.getParameterValues(id + "val")) {
                                    nameBuilder.append(n).append(",");
                                }
                                nameBuilder.deleteCharAt(nameBuilder.length() - 1);
                                paramUpdates.setMatrixParamId(Integer.parseInt(id));
                                paramUpdates.setParamStatus(nameBuilder.toString());
                                paramUpdates.setStatusDate(today);
                                paramUpdates.setAddedby(Integer.parseInt(uid));
                                paramUpdates.setUpdatedby(Integer.parseInt(uid));
                                paramUpdates.setAddedon(today);
                                paramUpdates.setUpdatedon(today);
                                ModelDAO.save("SapMatrixParamUpdates", paramUpdates);
                            }
                        }
                    } else {
                        Set<String> updated = new TreeSet<>();
                        for (String id : matrixParamId) {
                            if (request.getParameterValues(id + "val") != null) {
                                for (SapMatrixParamUpdates smpu : matrixParamUpdates) {
                                    if (smpu.getMatrixParamId() == Integer.parseInt(id)) {
                                        updated.add(id);
                                        StringBuilder nameBuilder = new StringBuilder();
                                        for (String n : request.getParameterValues(id + "val")) {
                                            nameBuilder.append(n).append(",");
                                        }
                                        nameBuilder.deleteCharAt(nameBuilder.length() - 1);
                                        smpu.setMatrixParamId(Integer.parseInt(id));
                                        smpu.setParamStatus(nameBuilder.toString());
                                        smpu.setStatusDate(today);
                                        // smpu.setAddedby(Integer.parseInt(uid));
                                        smpu.setUpdatedby(Integer.parseInt(uid));
                                        //smpu.setAddedon(today);
                                        smpu.setUpdatedon(today);
                                        ModelDAO.update("SapMatrixParamUpdates", smpu);
                                    }
                                }
                            }
                        }
                        for (String id : matrixParamId) {
                            if (request.getParameterValues(id + "val") != null) {
                                if (!updated.contains(id)) {
                                    SapMatrixParamUpdates paramUpdates = new SapMatrixParamUpdates();
                                    StringBuilder nameBuilder = new StringBuilder();
                                    for (String n : request.getParameterValues(id + "val")) {
                                        nameBuilder.append(n).append(",");
                                    }
                                    nameBuilder.deleteCharAt(nameBuilder.length() - 1);
                                    paramUpdates.setMatrixParamId(Integer.parseInt(id));
                                    paramUpdates.setParamStatus(nameBuilder.toString());
                                    paramUpdates.setStatusDate(today);
                                    paramUpdates.setAddedby(Integer.parseInt(uid));
                                    paramUpdates.setUpdatedby(Integer.parseInt(uid));
                                    paramUpdates.setAddedon(today);
                                    paramUpdates.setUpdatedon(today);
                                    ModelDAO.save("SapMatrixParamUpdates", paramUpdates);
                                }
                            }
                        }
                    }
                    for (SapServerType s : allServers) {
                        if (s.getSId() == serverId) {
                            servername = s.getServerName();
                        }
                    }
                    StringBuilder nameBuilder = new StringBuilder();
                    for (ServerSystem ss : serverMatrix) {
                        for (SapSystemType sst : allSystems) {
                            if (sst.getSId() == ss.getSyId() && ss.getServerId() == serverId) {
                                nameBuilder.append(sst.getSName()).append(", ");
                            }
                        }
                    }
                    nameBuilder.deleteCharAt(nameBuilder.length() - 1);
                    messge = servername + " Parameters status updated successfully for " + nameBuilder + " systems for " + companyCodes.get(companyCode);
                    serverDAO.updateIssueComments(issueid, uid, messge, Integer.parseInt(pid), companyCode);

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            messge = "Something went wrong. Please try again";
        }

        if (serverId > 0 && companyCode > 0) {
            matrixParamUpdates = serverDAO.getMatrixParamUpdates(Integer.parseInt(pid), serverId, companyCode, statusDate);

            for (ParameterStatus ps : matrixParameters) {
                if (!checkedParameters.contains(ps.getParameterId())) {
                    checkedParameters.add(ps.getParameterId());
                }
                for (SapMatrixParamUpdates smpu : matrixParamUpdates) {
                    if (ps.getMatrixParamId() == smpu.getMatrixParamId()) {
                        ps.setParamStatus(smpu.getParamStatus());
                    }
                }
                List<ParameterStatus> list = map.get(ps.getSystemId());
                if (list == null) {
                    list = new ArrayList<>();
                }
                list.add(ps);
                map.put(ps.getSystemId(), list);
            }
            if (request.getMethod().equalsIgnoreCase("post")) {

                try {
                    String htmlContent = "<table width=100% ><tr style=\"background-color: #E8EEF7;text-align: left;\"><th style=\"width:60%\">Parameter</th>", htmlContenta = "", htmlContentb = "", htmlContentc = "";

                    for (Integer systemId : map.keySet()) {
                        for (SapSystemType ss : getAllSystems()) {
                            if (systemId == ss.getSId()) {
                                htmlContenta = htmlContenta + " <th>" + ss.getSName() + "</th>";
                            }
                        }
                    }
                    htmlContenta += "</tr>";
                    int a = 0, b = 0;
                    String color = "#E8EEF7", radioApp = "";
                    //htmlContenta="";
                    for (SapMonitoringParamaters smp : getSapMonitoringParamaterses()) {
                        if (getCheckedParameters().contains(smp.getParameterId())) {

                            if (a % 2 == 0) {
                                color = "white";
                            } else {
                                color = "#E8EEF7";
                            }
                            htmlContentb += "  <tr style='background-color: " + color + "'> <td>" + smp.getParameterName() + "</td>";
                            for (Integer systemId : map.keySet()) {
                                for (ParameterStatus ss : map.get(systemId)) {
                                    if (smp.getParameterId() == ss.getParameterId()) {
                                        htmlContentb = htmlContentb + " <td>" + ss.getParamStatus() + "</td>";

                                    }
                                }
                            }
//                            for (ParameterStatus ss : map.get(3)) {
//
//                                if (smp.getParameterId() == ss.getParameterId()) {
//
//                                    if (smp.getAbnormalValue() != null) {
//                                        if (smp.getAbnormalValue().trim().equalsIgnoreCase(ss.getParamStatus().trim())) {
//                                            abnormalParameters += smp.getParameterName() + "-" + ss.getParamStatus() + System.lineSeparator();
//                                        }
//                                    }
//
//                                }
//                            }

                            htmlContentb += "</tr>";
                            a++;
                        }
                    }
                    htmlContent = htmlContent + htmlContenta + htmlContentb + "</table>";

                    String name = (String) session.getAttribute("fName") + " " + (String) session.getAttribute("lName");
                    String subject = "eTracker Monitoring Issue :  " + servername + "-" + companyCodes.get(companyCode);
                       
                    SendMail.monitoringissueUpdate(issueid, subject, htmlContent, name, uid);
//                    if (!abnormalParameters.equals("")) {
//                        new AutoIssueCreationController().createIssueForAbnormalValues(abnormalParameters, pid, uid);
//                    }
                } catch (Exception ex) {
                    Logger.getLogger(ServerMaintenace.class.getName()).log(Level.SEVERE, null, ex);
                }

            }

        }
    }

    public void getParameterType() {
        allInputTypes = new ArrayList<>();
        allInputTypes.add("Radio");
        allInputTypes.add("Checkbox");
        allInputTypes.add("Text");
    }

    public void manageServerTypes(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String uid = "" + session.getAttribute("uid");
        String server[] = request.getParameterValues("server[]");
        try {
            for (String val : server) {
                SapServerType sst = new SapServerType();
                sst.setAddedby(Integer.parseInt(uid));
                sst.setAddedon(new Date());
                sst.setServerName(val);
                ModelDAO.save("SapServerType", sst);

            }
            messge = "success";
        } catch (Exception e) {
            messge = "Failure." + e.getMessage();
        }

    }

    public void maintainMatirx(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String uid = "" + session.getAttribute("uid");

        String marix[] = request.getParameterValues("marix[]");

        pid = request.getParameter("pid");
        ServerDAO serverDAO = new ServerDAOImpl();
        serverMatrix = serverDAO.getAllServerMatrixByPID(Integer.parseInt(pid));
        String serverId, systemId;

        if (serverMatrix.isEmpty()) {
            for (String val : marix) {
                serverId = val.split("-")[0];
                systemId = val.split("-")[1];
                ServerSystem ss = new ServerSystem();
                ss.setIsActive(1);
                ss.setAddedby(Integer.parseInt(uid));
                ss.setPid(Integer.parseInt(pid));
                ss.setServerId(Integer.parseInt(serverId));
                ss.setSyId(Integer.parseInt(systemId));
                ss.setAddedon(new Date());
                ModelDAO.save("ServerSystem", ss);
            }
        } else {
            for (ServerSystem ss : serverMatrix) {
                ss.setAddedby(Integer.parseInt(uid));
                ss.setIsActive(0);
                ss.setAddedon(new Date());
                ModelDAO.update("ServerSystem", ss);
            }

            for (String val : marix) {
                serverId = val.split("-")[0];
                systemId = val.split("-")[1];
                ServerSystem ss = serverDAO.getMatrix(Integer.parseInt(pid), Integer.parseInt(serverId), Integer.parseInt(systemId));

                if (ss == null) {
                    ss = new ServerSystem();
                    ss.setIsActive(1);
                    ss.setAddedby(Integer.parseInt(uid));
                    ss.setPid(Integer.parseInt(pid));
                    ss.setServerId(Integer.parseInt(serverId));
                    ss.setSyId(Integer.parseInt(systemId));
                    ss.setAddedon(new Date());
                    ModelDAO.save("ServerSystem", ss);
                } else {
                    ss.setAddedby(Integer.parseInt(uid));
                    ss.setIsActive(1);
                    ss.setAddedon(new Date());
                    ModelDAO.update("ServerSystem", ss);
                }
            }
        }

        messge = "suceess";
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

    public List<ServerSystem> getServerMatrix() {
        return serverMatrix;
    }

    public void setServerMatrix(List<ServerSystem> serverMatrix) {
        this.serverMatrix = serverMatrix;
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

    public List<String> getAllInputTypes() {
        return allInputTypes;
    }

    public void setAllInputTypes(List<String> allInputTypes) {
        this.allInputTypes = allInputTypes;
    }

    public int getServerId() {
        return serverId;
    }

    public void setServerId(int serverId) {
        this.serverId = serverId;
    }

    public List<SapMonitoringParamaters> getSapMonitoringParamaterses() {
        return sapMonitoringParamaterses;
    }

    public void setSapMonitoringParamaterses(List<SapMonitoringParamaters> sapMonitoringParamaterses) {
        this.sapMonitoringParamaterses = sapMonitoringParamaterses;
    }

    public Set<Integer> getMatrixServers() {
        return matrixServers;
    }

    public void setMatrixServers(Set<Integer> matrixServers) {
        this.matrixServers = matrixServers;
    }

    public List<Integer> getCheckedParameters() {
        return checkedParameters;
    }

    public void setCheckedParameters(List<Integer> checkedParameters) {
        this.checkedParameters = checkedParameters;
    }

    public String getIssueid() {
        return issueid;
    }

    public void setIssueid(String issueid) {
        this.issueid = issueid;
    }

    public Map<Integer, List<ParameterStatus>> getMap() {
        return map;
    }

    public void setMap(Map<Integer, List<ParameterStatus>> map) {
        this.map = map;
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

    public Map<Integer, Map<Integer, Map<Integer, List<StatusHistory>>>> getMoniStat() {
        return moniStat;
    }

    public void setMoniStat(Map<Integer, Map<Integer, Map<Integer, List<StatusHistory>>>> moniStat) {
        this.moniStat = moniStat;
    }

    public String getMoniDate() {
        return moniDate;
    }

    public void setMoniDate(String moniDate) {
        this.moniDate = moniDate;
    }

    public List<SapLogon> getSapLogons() {
        return sapLogons;
    }

    public void setSapLogons(List<SapLogon> sapLogons) {
        this.sapLogons = sapLogons;
    }

    public List<SapConfig> getSapConfigs() {
        return sapConfigs;
    }

    public void setSapConfigs(List<SapConfig> sapConfigs) {
        this.sapConfigs = sapConfigs;
    }

}
