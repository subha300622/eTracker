/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack.DAO;

import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.mom.MoMUtil;
import com.pack.StringUtil;
import com.pack.controller.formbean.EditmoduleFormBean;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author admin
 */
public class AdminProjectModuleDAOImpl implements AdminProjectModuleDAO {

    Logger logger = Logger.getLogger("AdminProjectModuleDAOImpl");
    DateFormat sdf = new SimpleDateFormat("MMMM yyyy");

    @Override
    public void moduleUpdate(int mid, String module, int customerOwner, int internalOwner, int pid, int target, int targetId) {
        PreparedStatement moduleUpdateps = null;
        PreparedStatement addTargets = null;
        Connection connection = null;
        try {
            connection = MakeConnection.getConnection();

            String targetMonth = sdf.format(new Date());
            moduleUpdateps = connection.prepareStatement("update modules set module=? ,customerOwner=?,internalOwner=? where pid=? and moduleid=?");
            moduleUpdateps.setString(1, StringUtil.fixSqlFieldValue(module));
            moduleUpdateps.setInt(4, pid);
            moduleUpdateps.setInt(5, mid);
            moduleUpdateps.setInt(2, customerOwner);
            moduleUpdateps.setInt(3, internalOwner);
            int x = moduleUpdateps.executeUpdate();
            logger.debug(x + ":Project Details has been updated");

            if (targetId == 0) {
                addTargets = connection.prepareStatement("insert into MODULETARGET  (MONTH, TARGET, MODULEID)VALUES (?, ?, ?)");
                addTargets.setString(1, targetMonth);
                addTargets.setInt(2, target);
                addTargets.setInt(3, mid);
            } else {
                addTargets = connection.prepareStatement("update MODULETARGET set  TARGET=? where TARGETID=?");
                addTargets.setInt(1, target);
                addTargets.setInt(2, targetId);
            }
            int y = addTargets.executeUpdate();
            logger.debug(y + ":Target Details has been updated");

        } catch (SQLException ex) {
            logger.error("Error in ModuleUpdate():" + ex.getMessage());
        } catch (Exception ex) {
            logger.error("Error in ModuleUpdate():" + ex.getMessage());
        } finally {
            if (moduleUpdateps != null) {
                try {
                    moduleUpdateps.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (addTargets != null) {
                try {
                    addTargets.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }

    }

    @Override
    public EditmoduleFormBean getEditModuleByMid(int mid) {
        EditmoduleFormBean emfb = new EditmoduleFormBean();

        Statement st = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            String targetMonth = sdf.format(new Date());
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            //rs = st.executeQuery("SELECT m.moduleid,m.module,m.pid,customerowner,internalowner,p.CATEGORY  from modules m , project p where   m.moduleid=" + mid + " and m.pid=p.pid   order by moduleid");
            String sql = "SELECT m.moduleid,m.module,m.pid,customerowner,internalowner,p.CATEGORY ,mt.TARGET,mt.TARGETID from modules m inner join project p on p.pid=m.pid   LEFT JOIN  MODULETARGET mt on  m.moduleid =mt.MODULEID and   mt.MONTH='" + targetMonth + "' where  m.moduleid=" + mid;
            rs = st.executeQuery(sql);
            if (rs != null) {
                while (rs.next()) {
                    emfb.setModuleid(rs.getInt("moduleid"));
                    emfb.setModule(rs.getString("module"));
                    emfb.setPid(rs.getInt("pid"));
                    emfb.setcOwner(rs.getInt("customerowner"));
                    emfb.setiOwner(rs.getInt("internalowner"));
                    emfb.setCategory(rs.getString("category"));

                    emfb.setTarget(rs.getInt("TARGET"));
                    emfb.setTargetId(rs.getInt("TARGETID"));
                }
            }
        } catch (Exception ex) {
            logger.error("Error in EditModule:" + ex.getLocalizedMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }

        return emfb;
    }

    @Override
    public List<EditmoduleFormBean> getModuleByPID(int pid) {
        List<EditmoduleFormBean> editModuleFromBeans = new ArrayList<EditmoduleFormBean>();
        Statement st = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT moduleid,module,modules.pid,pname,customerowner,internalowner,(select count(*) from issue i,issuestatus s where module_id=moduleid and i.issueid=s.issueid and status!='Closed') as issuecount from modules, project where modules.pid=project.pid and modules.pid=" + pid + " order by upper(module) asc");
            rs.last();
            int rowcount = rs.getRow();
            rs.beforeFirst();
            if (rs != null) {
                for (int i = 1; i <= rowcount; i++) {
                    if (rs.next()) {
                        EditmoduleFormBean emodule = new EditmoduleFormBean();
                        emodule.setPid(rs.getInt("pid"));
                        emodule.setModuleid(rs.getInt("moduleid"));
                        emodule.setModule(rs.getString("module"));
                        emodule.setPname(rs.getString("pname"));
                        emodule.setcOwner(rs.getInt("customerOwner"));
                        emodule.setiOwner(rs.getInt("internalOwner"));
                        emodule.setIssuecount(rs.getInt("issuecount"));
                        editModuleFromBeans.add(emodule);
                    }
                }

            }

        } catch (Exception e) {

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }
        return editModuleFromBeans;
    }

    @Override
    public Map<Integer, Integer> getModuletargetByMonth(int pid) {
        Map<Integer, Integer> map = new HashMap<Integer, Integer>();
        Statement st = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();
            String targetMonth = sdf.format(new Date());
            String sql = "select mt.MODULEID,mt.TARGET from MODULETARGET mt where mt.MODULEID In( select m.MODULEID from MODULES m where m.pid=" + pid + ") and mt.MONTH='" + targetMonth + "'";

            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery(sql);
            if (rs != null) {
                while (rs.next()) {
                    Integer mid = rs.getInt("MODULEID");
                    Integer target = rs.getInt("TARGET");
                    map.put(mid, target);
                }
            }
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }

        return map;
    }

    @Override
    public Integer getNoOfModuleByPid(int pid) {
        Integer count = 0;
        Statement st = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT count(*) as count from modules m where m.pid=" + pid);
            if (rs != null) {
                while (rs.next()) {
                    count = rs.getInt("count");
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }
        return count;
    }

    @Override
    public String checkExistModule(String mname, int pid) {
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        String res = "false";
        String module = mname.trim();
        module = module.replaceAll("\\s", "");
        module = module.toUpperCase();
        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select module from modules where pid=" + pid + " and module='" + module + "'";
            rs = st.executeQuery(sql);
            int count = 0;
            while (rs.next()) {
                String modules = rs.getString("module");
                count++;
            }
            if (count == 0) {
                res = "false";
            } else {
                res = "true";
            }

        } catch (Exception ex) {
            logger.error("Exception in Module Exist Method:" + ex.getMessage());
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
                if (st != null) {
                    st.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                logger.error("Exception in Module Exist Method:" + e.getMessage());
            }
        }
        return res;

    }

    @Override
    public String CreateNewModule(String mname, int pid, int target) {
        String res = "false";
        Connection connection = null;
        Statement createModulest = null;

        ResultSet createModulers = null;
        PreparedStatement createModuleps = null;

        PreparedStatement addTargets = null;

        try {
            String targetMonth = sdf.format(new Date());

            connection = MakeConnection.getConnection();
            createModulest = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            createModulers = createModulest.executeQuery("select moduleid_seq.nextval from dual");
            if (createModulers != null) {
                if (createModulers.next()) {
                    int nextValue = createModulers.getInt("nextval");
                    createModuleps = connection.prepareStatement("insert into modules(moduleid,module,pid) values(?,?,?)");
                    createModuleps.setInt(1, nextValue);
                    createModuleps.setString(2, StringUtil.fixSqlFieldValue(mname));
                    createModuleps.setInt(3, pid);
                    createModuleps.executeUpdate();

                    addTargets = connection.prepareStatement("insert into MODULETARGET  (MONTH, TARGET, MODULEID)VALUES (?, ?, ?)");
                    addTargets.setString(1, targetMonth);
                    addTargets.setInt(2, target);
                    addTargets.setInt(3, nextValue);
                    addTargets.execute();
                    res = "true";
                }

            }
        } catch (Exception ex) {
            logger.error("Exception while creating modules:" + ex.getMessage());
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
                if (createModulers != null) {
                    createModulers.close();
                }
                if (createModulest != null) {
                    createModulest.close();
                }
                if (createModuleps != null) {
                    createModuleps.close();
                }

                if (addTargets != null) {
                    addTargets.close();
                }
            } catch (SQLException e) {
                logger.error("Exception while creating modules:" + e.getMessage());
            }
        }
        return res;
    }

    @Override
    public Map<Integer, String> getAllModuleByProject(Integer pid) {
        HashMap<Integer, String> hm = new HashMap<Integer, String>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String sql = "SELECT MODULEID,MODULE  from modules m where m.pid=" + pid;
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer moduleid = 0;
                String module = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        moduleid = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 1) {
                        module = row[col].toString();
                    }
                }
                hm.put(moduleid, module);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return hm;
    }

    @Override
    public EditmoduleFormBean getTargetByMid(int mid) {
        EditmoduleFormBean emFb = new EditmoduleFormBean();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String targetMonth = sdf.format(new Date());
            String sql = "select mt.MODULEID,mt.TARGET,mt.TARGETID from MODULETARGET mt where mt.MODULEID=" + mid + " and mt.MONTH='" + targetMonth + "'";
            Query query = session.createSQLQuery(sql);

            Iterator iterator = query.list().iterator();

            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        emFb.setModule(row[col].toString());
                    } else if (col == 1) {
                        emFb.setTarget(MoMUtil.parseInteger(row[col].toString(), 0));
                    } else if (col == 2) {
                        emFb.setTargetId(MoMUtil.parseInteger(row[col].toString(), 0));
                    }
                }
            }
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException ex) {
                logger.error(ex.getMessage());
            }
        }

        return emFb;
    }

    @Override
    public Integer getOpenIssueBYMid(Integer mid) {
        Integer count = 0;

        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String sql = "select count(*) as count from issue i,issuestatus s, project p where i.issueid = s.issueid and i.pid = p.pid  and s.status!='Closed' and i.MODULE_ID=" + mid;
            Query query = session.createSQLQuery(sql);
            BigDecimal big = (BigDecimal) query.uniqueResult();
            count = big.intValue();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());

            }
        }
        return count;
    }

    @Override
    public String saveUpdate(String[] targetCount) {
        PreparedStatement addTargets = null;
        Connection connection = null;
        String res = "true";
        try {
            String targetMonth = sdf.format(new Date());
            connection = MakeConnection.getConnection();
            for (String target : targetCount) {

                String[] targetValue = target.split("-");
                int moduleTarget = MoMUtil.parseInteger(targetValue[1], 0);
                int moduleTargetId = MoMUtil.parseInteger(targetValue[2], 0);
                int mid = MoMUtil.parseInteger(targetValue[0], 0);
                if (moduleTargetId == 0 && moduleTarget == 0) {
                } else {
                    if (moduleTargetId == 0) {
                        addTargets = connection.prepareStatement("insert into MODULETARGET  (MONTH, TARGET, MODULEID)VALUES (?, ?, ?)");
                        addTargets.setString(1, targetMonth);
                        addTargets.setInt(2, moduleTarget);
                        addTargets.setInt(3, mid);
                    } else {
                        addTargets = connection.prepareStatement("update MODULETARGET set  TARGET=? where TARGETID=?");
                        addTargets.setInt(1, moduleTarget);
                        addTargets.setInt(2, moduleTargetId);
                    }
                    int y = addTargets.executeUpdate();
                    if (y > 0) {
                    } else {
                        res = "false";
                    }
                }
            }
        } catch (Exception ex) {
            logger.error("Error in TragetCountUpdate():" + ex.getMessage());
        } finally {
            try {
                if (addTargets != null) {
                    addTargets.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                logger.error(ex.getMessage());
            }
        }

        return res;
    }

    @Override
    public List<EditmoduleFormBean> getModuleTargetByPID(int pid) {
        List<EditmoduleFormBean> emFbList = new ArrayList<EditmoduleFormBean>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String targetMonth = sdf.format(new Date());
            String sql = "select mt.MODULEID,mt.TARGET,mt.targetid from MODULETARGET mt where mt.MODULEID In( select m.MODULEID from MODULES m where m.pid=" + pid + ") and mt.MONTH='" + targetMonth + "'";
            Query query = session.createSQLQuery(sql);

            Iterator iterator = query.list().iterator();

            while (iterator.hasNext()) {
                EditmoduleFormBean emFb = new EditmoduleFormBean();

                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        emFb.setModuleid(MoMUtil.parseInteger(row[col].toString(), 0));
                    } else if (col == 1) {
                        emFb.setTarget(MoMUtil.parseInteger(row[col].toString(), 0));
                    } else if (col == 2) {
                        emFb.setTargetId(MoMUtil.parseInteger(row[col].toString(), 0));
                    }
                }
                emFbList.add(emFb);
            }
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException ex) {
                logger.error(ex.getMessage());
            }
        }
        return emFbList;

    }
}
