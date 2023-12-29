/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dashboard.dao;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.mom.MoMUtil;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author admin
 */
public class MydashboardDAOImpl implements MydashboardDAO {

    static Logger logger = Logger.getLogger("MydashboardDAOImpl");


    @Override
    public HashMap<Integer, String> getUser() {
        HashMap<Integer, String> hm = new HashMap<Integer, String>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String sql = "Select userid,firstname, lastname from users where firstname is not NULL";
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                int userid = 0;
                String firstname = "";
                String lastname = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        userid = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 1) {
                        firstname = row[col].toString();
                    } else if (col == 2) {
                        lastname = row[col].toString();
                        lastname = lastname.substring(0, 1);
                        lastname = lastname.toUpperCase();
                    }
                }
                hm.put(userid, firstname + " " + lastname);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        }finally {
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
    public List<IssueFormBean> QueryForUser(String userId, String currentUser, String status, String priority) {
        List<IssueFormBean> issueFormBeanList = new ArrayList<>();
        IssueFormBean issueFormBean;
        Session session = null;
        String sql = "";
        try {
            session = HibernateFactory.getCurrentSession();
            if (MoMUtil.parseInteger(currentUser, 0) == 104) {
                sql = "select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and s.status ='" + status + "' and assignedto ='" + userId + "' and priority ='" + priority + "' and i.pid = p.pid order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            } else {
                sql = "select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and s.status ='" + status + "' and assignedto ='" + userId + "' and priority = '" + priority + "'  and i.pid = p.pid and i.pid in (select u.pid from userproject u where u.userid='" + userId + "' intersect select k.pid from userproject k where k.userid='" + currentUser + "') order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            }
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            priority = priority.substring(0, 2);
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                issueFormBean = new IssueFormBean();
                for (int col = 0; col < row.length; col++) {

                    if (col == 0) {
                        issueFormBean.setIssueId((row[col].toString()));
                    } else if (col == 1) {
                        issueFormBean.setpName(row[col].toString());
                    } else if (col == 2) {
                        issueFormBean.setmName(row[col].toString());
                    } else if (col == 3) {
                        issueFormBean.setSubject(row[col].toString());
                    } else if (col == 4) {
                        issueFormBean.setDescription(row[col].toString());
                    } else if (col == 5) {
                        issueFormBean.setSeverity(row[col].toString());
                    } else if (col == 6) {
                        issueFormBean.setType(row[col].toString());
                    } else if (col == 7) {
                        issueFormBean.setCreated((java.util.Date) row[col]);
                    } else if (col == 8) {
                        issueFormBean.setDuedateOn((java.util.Date) row[col]);
                    } else if (col == 9) {
                        issueFormBean.setModifiedDate((java.util.Date) row[col]);
                    } else if (col == 10) {
                        issueFormBean.setCreatedBy((String) (row[col]));
                    } else if (col == 11) {
                        issueFormBean.setAssignto(row[col].toString());
                    } else if (col == 12) {
                        issueFormBean.setStatus((String) (row[col]));
                    }
                    issueFormBean.setPriority(priority);

                }
                issueFormBeanList.add(issueFormBean);
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
        return issueFormBeanList;
    }
    
      @Override
    public List<IssueFormBean> getAllIssueMyDashBorad(String userId, Integer currentUser) {
        List<IssueFormBean> issueFormBeanList = new ArrayList<>();
        IssueFormBean issueFormBean;
        Session session = null;
        String sql = "";
        try {
            session = HibernateFactory.getCurrentSession();
            if (currentUser == 104) {
                sql = "select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status,SUBSTR(priority, 0, 2) as priority  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and assignedto ='" + userId + "' and s.status !='Closed' and i.pid = p.pid order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            } else {
                sql = "select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status,SUBSTR(priority, 0, 2) as priority  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and  assignedto ='" + userId + "' and s.status !='Closed' and  i.pid = p.pid and i.pid in (select u.pid from userproject u where u.userid='" + userId + "' intersect select k.pid from userproject k where k.userid='" + currentUser + "') order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            }
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                issueFormBean = new IssueFormBean();
                for (int col = 0; col < row.length; col++) {

                    if (col == 0) {
                        issueFormBean.setIssueId((row[col].toString()));
                    } else if (col == 1) {
                        issueFormBean.setpName(row[col].toString());
                    } else if (col == 2) {
                        issueFormBean.setmName(row[col].toString());
                    } else if (col == 3) {
                        issueFormBean.setSubject(row[col].toString());
                    } else if (col == 4) {
                        issueFormBean.setDescription(row[col].toString());
                    } else if (col == 5) {
                        issueFormBean.setSeverity(row[col].toString());
                    } else if (col == 6) {
                        issueFormBean.setType(row[col].toString());
                    } else if (col == 7) {
                        issueFormBean.setCreated((java.util.Date) row[col]);
                    } else if (col == 8) {
                        issueFormBean.setDuedateOn((java.util.Date) row[col]);
                    } else if (col == 9) {
                        issueFormBean.setModifiedDate((java.util.Date) row[col]);
                    } else if (col == 10) {
                        issueFormBean.setCreatedBy((String) (row[col]));
                    } else if (col == 11) {
                        issueFormBean.setAssignto(row[col].toString());
                    } else if (col == 12) {
                        issueFormBean.setStatus((String) (row[col]));
                    }else if(col==13){
                        issueFormBean.setPriority((String)row[col]);
                    }

                }
                issueFormBeanList.add(issueFormBean);
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
        return issueFormBeanList;
    }
}
