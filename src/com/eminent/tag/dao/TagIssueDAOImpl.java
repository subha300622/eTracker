/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tag.dao;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.tags.TagIssues;
import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.MoMUtil;
import static com.eminentlabs.userBPM.BPMUtil.logger;
import java.awt.BorderLayout;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author EMINENT
 */
public class TagIssueDAOImpl implements TagIssueDAO {

    @Override
    public void addTagIssues(TagIssues tagIssue) {
        ModelDAO.save(DAOConstants.ENTITY_TAGISSUES, tagIssue);
    }

    @Override
    public List<String> findAllIssuesByTagId(Long tagid) {
        Session session = null;
        List<String> issuelist = new ArrayList<String>();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("TagIssues.findByTagId");
            query.setLong("tagId", tagid);
            List<TagIssues> tagIssueselist = (List<TagIssues>) query.list();
            if (tagIssueselist == null || tagIssueselist.isEmpty()) {
            } else {
                for (TagIssues tagIssues : tagIssueselist) {
                    issuelist.add(tagIssues.getIssueId());
                }
            }
        } catch (HibernateException e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException e) {
                logger.error(e.getMessage());

            }
        }
        return issuelist;
    }

    @Override
    public String findAllTagIsuueByIssueAndTag(String issueId, Long tagid, Integer userId) {
        Session session = null;
        String res = "false";
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("TagIssues.findByIssueIdAndTag");
            query.setLong("tagId", tagid);
            query.setParameter("issueId", issueId);
            query.setInteger("userId", userId);
            List<TagIssues> tagIssueselist = (List<TagIssues>) query.list();
            if (tagIssueselist == null || tagIssueselist.isEmpty()) {
            } else {
                res = "true";
            }
        } catch (HibernateException e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException e) {
                logger.error(e.getMessage());

            }
        }
        return res;
    }

    @Override
    public String deleteTagIssueByIssue(String issueId, Long tagid) {
        String res = "false";
        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = MakeConnection.getConnection();
            String sql = "delete from TAGISSUES WHERE ISSUE_ID=? and TAG_ID=?";
            ps = connection.prepareStatement(sql);
            ps.setString(1, issueId);
            ps.setLong(2, tagid);
            ps.executeUpdate();
            res = "true";
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());

            }
        }

        return res;
    }

    @Override
    public List<IssueFormBean> getAllIssueByTag(List<Long> tagIds) {

        List<IssueFormBean> issueFormBeanList = new ArrayList<>();
        IssueFormBean issueFormBean;
        Session session = null;
        String sql = "";
        try {
            String tagids = "";
            int i = 0;
            for (Long listString : tagIds) {
                if (i == 0) {
                    tagids = tagids + listString;
                } else {
                    tagids = tagids + "," + listString;
                }
                i++;
            }
            session = HibernateFactory.getCurrentSession();

            sql = "select i.issueid, pname as project,module, subject,description, severity, type, createdon, due_date, modifiedon,  createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age,priority ,rating from project p, issue i, issuestatus s,modules m where  s.issueid=i.issueid and i.pid = p.pid and i.module_id=m.moduleid  and i.issueid in (select ISSUE_ID  from TAGISSUES WHERE  TAG_ID in (" + tagids + "))  order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
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
                    } else if (col == 13) {
                        issueFormBean.setAge(MoMUtil.parseInteger(row[col].toString(), 0));
                    } else if (col == 14) {
                        issueFormBean.setPriority((String) row[col]);
                    } else if (col == 15) {
                        issueFormBean.setRating((String) row[col]);
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

    @Override
    public List<String> findAllIssuesByTagIdAndUser(Long tagid, Integer currentuser) {
        Session session = null;
        List<String> issuelist = new ArrayList<String>();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("TagIssues.findByUserIdAndTag");
            query.setLong("tagId", tagid);
            query.setParameter("userId", currentuser);
            List<TagIssues> tagIssueselist = (List<TagIssues>) query.list();
            if (tagIssueselist == null || tagIssueselist.isEmpty()) {
            } else {
                for (TagIssues tagIssues : tagIssueselist) {
                    issuelist.add(tagIssues.getIssueId());
                }
            }
        } catch (HibernateException e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException e) {
                logger.error(e.getMessage());

            }
        }
        return issuelist;
    }

    @Override
    public Map<Long, Integer> getCountIssueforTag() {
        Map<Long, Integer> map = new HashMap<Long, Integer>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String sql = "select tagId,count(tagId ) from (select ISSUE_ID as isId,TAG_ID as tagId from  TAGISSUES  group by ISSUE_ID,TAG_ID )  group by tagId ";
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                Long tagId = 0l;
                Integer count = 0;
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        tagId = MoMUtil.parseLong(row[col].toString(), 0l);
                    } else if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    }
                }
                map.put(tagId, count);
            }

        } catch (HibernateException e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException e) {
                logger.error(e.getMessage());

            }
        }
        return map;
    }

    @Override
    public String deleteTagIssueByTagId(Long tagId) {
        String res = "false";
        PreparedStatement ps = null;
        Connection connection = null;
        try {
            connection = MakeConnection.getConnection();
            String sql = "delete from TAGISSUES where TAG_ID=?";
            ps = connection.prepareStatement(sql);
            ps.setLong(1, tagId);
            int x = ps.executeUpdate();
            System.out.println("TagIsssue delete " + x);
            res = "true";
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());

            }
        }

        return res;
    }

}
