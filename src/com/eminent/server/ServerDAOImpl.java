/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.server;

import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author vanithaalliraj
 */
public class ServerDAOImpl implements ServerDAO {

    @Override
    public List<SapServerType> getServerTypes() {
        Session session = null;
        List<SapServerType> notifications = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("SapServerType.findAll");
            notifications = (List<SapServerType>) query.list();
            if (notifications == null) {
                notifications = new ArrayList<SapServerType>();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public List<SapSystemType> getSystemTypes() {
        Session session = null;
        List<SapSystemType> notifications = new ArrayList<SapSystemType>();;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("SapSystemType.findAll");
            notifications = (List<SapSystemType>) query.list();
            if (notifications == null) {
                notifications = new ArrayList<SapSystemType>();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public List<ServerSystem> getServerMatrixByPID(int pid, int active) {
        Session session = null;
        List<ServerSystem> notifications = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("ServerSystem.findByPid");
            query.setParameter("pid", pid);
            query.setParameter("isActive", active);
            notifications = (List<ServerSystem>) query.list();
            if (notifications == null) {
                notifications = new ArrayList<ServerSystem>();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;

    }

    @Override
    public List<ServerSystem> getAllServerMatrixByPID(int pid) {
        Session session = null;
        List<ServerSystem> notifications = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("ServerSystem.findAllByPId");
            query.setParameter("pid", pid);
            notifications = (List<ServerSystem>) query.list();
            if (notifications == null) {
                notifications = new ArrayList<ServerSystem>();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public void addMatrix(ServerSystem ss) {
        ModelDAO.save(DAOConstants.ENTITY_SERVER_SYSTEM, ss);
    }

    @Override
    public void updateMatrix(ServerSystem ss) {
        ModelDAO.update(DAOConstants.ENTITY_SERVER_SYSTEM, ss);
    }

    @Override
    public ServerSystem getMatrix(int pid, int serverId, int systemId) {
        ServerSystem notifications = null;
        Session session = null;

        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("ServerSystem.findByPIdServerNSystem");
            query.setParameter("pid", pid);
            query.setParameter("serverId", serverId);
            query.setParameter("syId", systemId);
            notifications = (ServerSystem) query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public List<SapMonitoringParamaters> getAllParameters() {
        Session session = null;
        List<SapMonitoringParamaters> notifications = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("SapMonitoringParamaters.findAll");
            notifications = (List<SapMonitoringParamaters>) query.list();
            if (notifications == null) {
                notifications = new ArrayList<SapMonitoringParamaters>();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public List<SapMonitoringParamaters> getParametersByServerId(int serverId) {
        Session session = null;
        List<SapMonitoringParamaters> notifications = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("SapMonitoringParamaters.findByServerId");
            query.setParameter("serverId", serverId);
            notifications = (List<SapMonitoringParamaters>) query.list();
            if (notifications == null) {
                notifications = new ArrayList<SapMonitoringParamaters>();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public SapMonitoringParamaters getParameter(int serverId, String parameterName) {
        Session session = null;
        SapMonitoringParamaters notifications = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("SapMonitoringParamaters.findByServerIdNParameter");
            query.setParameter("serverId", serverId);
            query.setParameter("parameterName", parameterName);
            notifications = (SapMonitoringParamaters) query.uniqueResult();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public List<Integer> getCheckedParameters(int projectid, int serverId, int companyCode) {
        Session session = null;
        List<Integer> checkedParamters = new ArrayList<>();

        try {
            session = HibernateFactory.getCurrentSession();
            String sql = "select distinct(mp.PARAMETER_ID) from SAP_MATRIX_PARAMETER mp left join SERVER_SYSTEM ss on mp.MATRIX_ID=ss.M_ID left join SAP_MONITORING_PARAMATERS smp \n"
                    + "on ss.SERVER_ID=smp.SERVER_ID and mp.PARAMETER_ID= smp.PARAMETER_ID where mp.IS_ACTIVE=1 and mp.COMPANY_CODE=" + companyCode + " and smp.SERVER_ID=" + serverId + " and ss.PID=" + projectid + "";
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();

            while (iterator.hasNext()) {
                BigDecimal row = (BigDecimal) iterator.next();
                checkedParamters.add(row.intValueExact());
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return checkedParamters;

    }

    @Override
    public List<ServerSystem> getServerMatrixByPIDAndServerId(int pid, int active, int serverId) {
        Session session = null;
        List<ServerSystem> notifications = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("ServerSystem.findByPIdServer");
            query.setParameter("pid", pid);
            query.setParameter("serverId", serverId);
            query.setParameter("isActive", active);
            notifications = (List<ServerSystem>) query.list();
            if (notifications == null) {
                notifications = new ArrayList<ServerSystem>();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public void updateMatrixParameters(int serverId, int pid, int companyCode) {
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
//            String sql = "update SAP_MATRIX_PARAMETER set IS_ACTIVE=0 where COMPANY_CODE="+companyCode;
            String sql = "update SAP_MATRIX_PARAMETER set IS_ACTIVE=0 where COMPANY_CODE=" + companyCode + " and MATRIX_ID in (select M_ID from SERVER_SYSTEM where SERVER_ID=" + serverId + " and PID=" + pid + ")";
            SQLQuery query = session.createSQLQuery(sql);
            query.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    @Override
    public SapMatrixParameter getMatrixparam(int matrixId, int parameterId, int companyCode) {
        SapMatrixParameter notifications = null;
        Session session = null;

        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("SapMatrixParameter.findByMatrixIdNparamId");
            query.setParameter("matrixId", matrixId);
            query.setParameter("parameterId", parameterId);
            query.setParameter("companyCode", companyCode);
            notifications = (SapMatrixParameter) query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public MonitoringIssue getIssueIdbyPidNCompCode(int pid, int companyCode) {
        MonitoringIssue notifications = null;
        Session session = null;

        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("MonitoringIssue.findByPidNCompCode");
            query.setParameter("pid", pid);
            query.setParameter("companyCode", companyCode);
            notifications = (MonitoringIssue) query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public MonitoringIssue getPIdbyIssueId(String issueid) {
        MonitoringIssue notifications = null;
        Session session = null;

        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("MonitoringIssue.findByIssueid");
            query.setParameter("issueid", issueid);
            notifications = (MonitoringIssue) query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public Map<String, String> getBasisIssues(int pid) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<ParameterStatus> getMatrixParameters(int pid, int serverId, int companyCode) {
        Session session = null;
        List<ParameterStatus> checkedParamters = null;

        try {
            session = HibernateFactory.getCurrentSession();
            String sql = "select mp.ID,mp.PARAMETER_ID,ss.SY_ID from \n"
                    + "SAP_MATRIX_PARAMETER mp left join \n"
                    + "SERVER_SYSTEM ss on mp.MATRIX_ID=ss.M_ID left join \n"
                    + "SAP_MONITORING_PARAMATERS smp on ss.SERVER_ID=smp.SERVER_ID and mp.PARAMETER_ID= smp.PARAMETER_ID where mp.IS_ACTIVE=1 and ss.IS_ACTIVE=1 and \n"
                    + "smp.SERVER_ID=" + serverId + " and mp.COMPANY_CODE=" + companyCode + " and ss.PID=" + pid + " order by ss.SY_ID,PARAMETER_ID";

            SQLQuery query = session.createSQLQuery(sql);
            checkedParamters = new ArrayList<>();
            List<Object[]> rows = query.list();
            for (Object[] row : rows) {
                ParameterStatus emp = new ParameterStatus();
                emp.setMatrixParamId(Integer.parseInt(row[0].toString()));
                emp.setParameterId(Integer.parseInt(row[1].toString()));
                emp.setSystemId(Integer.parseInt(row[2].toString()));
                checkedParamters.add(emp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return checkedParamters;
    }

    @Override
    public List<SapMatrixParamUpdates> getMatrixParamUpdates(int pid, int serverId, int companyCode, String date) {
        Session session = null;
        List<SapMatrixParamUpdates> checkedParamters = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String sql = "select mpu.* from SAP_MATRIX_PARAM_UPDATES mpu left join SAP_MATRIX_PARAMETER mp\n"
                    + "on mpu.MATRIX_PARAM_ID=mp.ID\n"
                    + "left join SERVER_SYSTEM ss on mp.MATRIX_ID=ss.M_ID where ss.IS_ACTIVE=1 and mp.COMPANY_CODE=" + companyCode + "  and ss.SERVER_ID=" + serverId + " and ss.PID=" + pid + " and mpu.STATUS_DATE='" + date + "' ";

            SQLQuery query = session.createSQLQuery(sql);
            query.addEntity(SapMatrixParamUpdates.class);
            checkedParamters = (List<SapMatrixParamUpdates>) query.list();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return checkedParamters;
    }

    @Override
    public void updateIssueComments(String issueid, String userid, String comments, int projectId, int companyCode) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rsForType = null;
        Map<String, String> map = new HashMap<>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        Timestamp ts = new Timestamp(new java.util.Date().getTime());
        try {
//             java.sql.Date dbDate = null;
//            if (dueDate != null) {
//                if (!dueDate.equalsIgnoreCase("NA")) {
//                    dueDate = dueDate.trim();
//                    storeDate = com.pack.ChangeFormat.getDateFormat(dueDate);
//                    dbDate = java.sql.Date.valueOf(storeDate);
//                }
//            }
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("select i.ISSUEID,i.SEVERITY,i.PRIORITY,i.DUE_DATE,s.STATUS from issue i  left join ISSUESTATUS s\n"
                    + "on i.ISSUEID=s.ISSUEID  where i.ISSUEID = (select issueid from MONITORING_ISSUE where PID=? and COMPANY_CODE=?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setInt(1, projectId);
            ps.setInt(2, companyCode);
            rsForType = ps.executeQuery();
            while (rsForType.next()) {
                map.put("ISSUEID", rsForType.getString(1));
                map.put("SEVERITY", rsForType.getString(2));
                map.put("PRIORITY", rsForType.getString(3));
                String dueDateFormat = rsForType.getDate("due_date").toString();
                if (dueDateFormat != null) {
                    map.put("DUE_DATE", sdf.format(dateConversion.parse(dueDateFormat)));
                }
                map.put("STATUS", rsForType.getString(5));
            }
            ps = connection.prepareStatement("insert into issuecomments(issueid,commentedby,comment_date,comments,status,commentedto,duedate,priority,severity) values(?,?,?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, map.get("ISSUEID"));
            ps.setString(2, userid);
            ps.setTimestamp(3, ts);
            ps.setString(4, comments);
            ps.setString(5, map.get("STATUS"));
            ps.setString(6, userid);
            ps.setDate(7, new java.sql.Date(sdf.parse(map.get("DUE_DATE")).getTime()));
            ps.setString(8, map.get("SEVERITY"));
            ps.setString(9, map.get("PRIORITY"));
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//    @Override
//    @Override
//    public Map<Integer, Map<Integer, Map<Integer, List<ParameterStatus>>>> getMonitoringStatusByPidDate(int pid, String date) {
//        Session session = null;
//        Map<Integer, Map<Integer, Map<Integer, List<ParameterStatus>>>> checkedParamters = new TreeMap<>();
//
//        try {
//            session = HibernateFactory.getCurrentSession();
//            String sql = "select ss.SERVER_ID,mp.COMPANY_CODE,ss.SY_ID,mp.PARAMETER_ID,mpu.PARAM_STATUS from SAP_MATRIX_PARAM_UPDATES mpu left join SAP_MATRIX_PARAMETER mp on mpu.MATRIX_PARAM_ID=mp.ID left join SERVER_SYSTEM ss on mp.MATRIX_ID=ss.M_ID where mpu.STATUS_DATE='" + date + "' and ss.PID=" + pid + " order by mp.COMPANY_CODE,mpu.ID";
//
//            SQLQuery query = session.createSQLQuery(sql);
//            List<Object[]> rows = query.list();
//            for (Object[] row : rows) {
//                ParameterStatus emp = new ParameterStatus();
//                emp.setMatrixParamId(Integer.parseInt(row[1].toString()));
//                emp.setParameterId(Integer.parseInt(row[2].toString()));
//                emp.setSystemId(Integer.parseInt(row[3].toString()));
//                emp.setParamStatus(row[4].toString());
//
//                Map<Integer, Map<Integer, List<ParameterStatus>>> maps = checkedParamters.get(Integer.parseInt(row[0].toString()));
//                if (maps == null) {
//                    maps = new TreeMap<>();
//                }
//                Map<Integer, List<ParameterStatus>> ma = maps.get(Integer.parseInt(row[1].toString()));
//                if (ma == null) {
//                    ma = new TreeMap<>();
//                }
//
//                List<ParameterStatus> list = ma.get(Integer.parseInt(row[2].toString()));
//                if (list == null) {
//                    list = new ArrayList<>();
//                }
//                list.add(emp);
//                ma.put(Integer.parseInt(row[2].toString()), list);
//                maps.put(Integer.parseInt(row[1].toString()), ma);
//                checkedParamters.put(Integer.parseInt(row[0].toString()), maps);
//
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (session != null) {
//                if (session.isOpen()) {
//                    try {
//                        session.close();
//                    } catch (Exception e) {
//                        e.printStackTrace();
//                    }
//                }
//            }
//        }
//        return checkedParamters;
//    }
    @Override
    public List<StatusHistory> getMonitoringStatusByPidDate(int pid, String date) {
        Session session = null;
        List<StatusHistory> checkedParamters = new ArrayList<>();

        try {
            session = HibernateFactory.getCurrentSession();
            String sql = null;
            if (pid == 0) {
                sql = "select ss.SERVER_ID,mp.COMPANY_CODE,ss.SY_ID,mp.PARAMETER_ID,mpu.PARAM_STATUS from SAP_MATRIX_PARAM_UPDATES mpu left join SAP_MATRIX_PARAMETER mp on mpu.MATRIX_PARAM_ID=mp.ID left join SERVER_SYSTEM ss on mp.MATRIX_ID=ss.M_ID where mpu.STATUS_DATE='" + date + "'  order by mp.COMPANY_CODE,mpu.ID";
            } else {
                sql = "select ss.SERVER_ID,mp.COMPANY_CODE,ss.SY_ID,mp.PARAMETER_ID,mpu.PARAM_STATUS from SAP_MATRIX_PARAM_UPDATES mpu left join SAP_MATRIX_PARAMETER mp on mpu.MATRIX_PARAM_ID=mp.ID left join SERVER_SYSTEM ss on mp.MATRIX_ID=ss.M_ID where mpu.STATUS_DATE='" + date + "' and ss.PID=" + pid + " order by mp.COMPANY_CODE,mpu.ID";
            }

            SQLQuery query = session.createSQLQuery(sql);
            List<Object[]> rows = query.list();
            for (Object[] row : rows) {
                StatusHistory emp = new StatusHistory();
                emp.setServerId(Integer.parseInt(row[0].toString()));
                emp.setCompayCode(Integer.parseInt(row[1].toString()));
                emp.setParameterId(Integer.parseInt(row[3].toString()));
                emp.setSystemId(Integer.parseInt(row[2].toString()));
                emp.setParamStatus(row[4].toString());
                checkedParamters.add(emp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return checkedParamters;

    }

    @Override
    public List<SapLogon> getLogonByPidServerId(int pid, int serverId,int companycode) {
        Session session = null;
        List<SapLogon> checkedParamters = new ArrayList<>();
        try {
            session = HibernateFactory.getCurrentSession();

            SQLQuery query = session.createSQLQuery("select asl.id,ss.M_ID,ss.SERVER_ID,ss.SY_ID,sst.S_NAME,asl.APP_SERVER,asl.INST_NO,asl.S_ID,asl.ROUT_STR from APM_SAP_LOGON asl right join SERVER_SYSTEM ss on ss.M_ID=asl.M_ID\n"
                    + "left join SAP_SYSTEM_TYPE sst on sst.S_ID=ss.SY_ID where ss.SERVER_ID=" + serverId + " and ss.PID=" + pid + "  and asl.COMPANY_CODE="+companycode+" order by ss.M_ID asc ");
            List<Object[]> rows = query.list();
            for (Object[] row : rows) {
                SapLogon emp = new SapLogon();
                if (row[0] != null) {
                    emp.setId(Integer.parseInt(row[0].toString()));
                }
                emp.setmId(Integer.parseInt(row[1].toString()));
                emp.setServerId(Integer.parseInt(row[2].toString()));
                emp.setSystemId(Integer.parseInt(row[3].toString()));
                emp.setSystemName(row[4].toString());
                if (row[5] != null) {
                    emp.setAppServer(row[5].toString());
                }
                if (row[6] != null) {
                    emp.setInstNo(Integer.parseInt(row[6].toString()));
                }
                if (row[7] != null) {
                    emp.setSystemNo(row[7].toString());
                }
                if (row[8] != null) {
                    emp.setRoutStr(row[8].toString());
                }
                checkedParamters.add(emp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return checkedParamters;

    }

    @Override
    public ApmSapVpn getVPNByPid(int pid) {
        ApmSapVpn notifications = null;
        Session session = null;

        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("ApmSapVpn.findByPid");
            query.setParameter("pid", pid);
            notifications = (ApmSapVpn) query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public List<ApmSapLogonCredential> getCredentialByMid(int mid,int companyCode) {
        List<ApmSapLogonCredential> notifications = null;
        Session session = null;

        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("ApmSapLogonCredential.findByMIdComp");
            query.setParameter("mId", mid);
            query.setParameter("companyCode", companyCode);
            notifications = (List<ApmSapLogonCredential>) query.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public ApmSapLogonCredential getCredentialByMidAndModuleId(int pid, int mid, String moduleId,int companycode) {
        ApmSapLogonCredential notifications = null;
        Session session = null;

        try {

            session = HibernateFactory.getCurrentSession();
            SQLQuery query = session.createSQLQuery("select * from APM_SAP_LOGON_CREDENTIAL where M_ID=" + mid + " and  COMPANY_CODE=" + companycode + " and MODULE_ID=(select MODULEID from MODULES where \"MODULE\"='" + moduleId + "' and pid=" + pid + ") ");
            query.addEntity(ApmSapLogonCredential.class);
            notifications = (ApmSapLogonCredential) query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    @Override
    public List<SapConfig> getConfigByPidServerId(int pid, int serverId,int companycode) {
        Session session = null;
        List<SapConfig> checkedParamters = new ArrayList<>();
        try {
            session = HibernateFactory.getCurrentSession();

            SQLQuery query = session.createSQLQuery("select asl.id,ss.M_ID,ss.SERVER_ID,ss.SY_ID,sst.S_NAME,asl.OS_NAME,asl.ERP_VERSION,asl.EHP_VERSION,asl.DB_VERSION from APM_SAP_CONFIG asl right join SERVER_SYSTEM ss on ss.M_ID=asl.M_ID\n"
                    + "left join SAP_SYSTEM_TYPE sst on sst.S_ID=ss.SY_ID where ss.SERVER_ID=" + serverId + " and ss.PID=" + pid + " order by ss.M_ID asc ");
            
            List<Object[]> rows = query.list();
            for (Object[] row : rows) {
                SapConfig emp = new SapConfig();
                if (row[0] != null) {
                    emp.setId(Integer.parseInt(row[0].toString()));
                }
                emp.setmId(Integer.parseInt(row[1].toString()));
                emp.setServerId(Integer.parseInt(row[2].toString()));
                emp.setSystemId(Integer.parseInt(row[3].toString()));
                emp.setSystemName(row[4].toString());
                if (row[5] != null) {
                    emp.setOsName(row[5].toString());
                }
                if (row[6] != null) {
                    emp.setErpVersion(row[6].toString());
                }
                if (row[7] != null) {
                    emp.setEhpVersion(row[7].toString());
                }
                if (row[8] != null) {
                    emp.setDbVersion(row[8].toString());
                }
                checkedParamters.add(emp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return checkedParamters;

    }

    @Override
    public List<ApmSapLogonMaintain> getAll() {
        List<ApmSapLogonMaintain> notifications = null;
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("ApmSapLogonMaintain.findAll");
            notifications = (List<ApmSapLogonMaintain>) query.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return notifications;

    }

    @Override
    public ApmSapLogonMaintain getLogonMaintainByPid(int pid) {
        ApmSapLogonMaintain notifications = null;
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("ApmSapLogonMaintain.findByPid");
            query.setParameter("pid", pid);
            notifications = (ApmSapLogonMaintain) query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

}
