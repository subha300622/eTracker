/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tag.dao;

import com.eminent.tags.Tags;
import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.MoMUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author EMINENT
 */
public class TagDAOImpl implements TagDAO {

    public Logger logger = Logger.getLogger("TagDAOImpl");

    @Override
    public List<Tags> findAllTags() {
        Session session = null;
        List<Tags> findAllTags = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Tags.findAll");

            findAllTags = (List<Tags>) query.list();
            if (findAllTags == null) {
                findAllTags = new ArrayList<>();
            }
        } catch (HibernateException e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (HibernateException e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return findAllTags;
    }

    @Override
    public void addTags(Tags tags) {
        ModelDAO.save(DAOConstants.ENTITY_TAGS, tags);
    }
 @Override
    public Tags saveAddTags(Tags tags) {
       ModelDAO.save(DAOConstants.ENTITY_TAGS, tags);
       
        return tags;
    }
  
    @Override
    public String findUniqueTagByUser(String tname, Integer userid) {
        Session session = null;
        String res = "false";
        try {
            session = HibernateFactory.getCurrentSession();
            String sql = "select USER_ID,TAG_TYPE from tags t,TAGSUSERS tu where t.TAG_ID=tu.TAG_ID and tu.TAG_ID in ( select Tag_id from tags where tag_name='" + tname + "') and (USERID=" + userid + " or USER_ID=" + userid + ")";
            System.out.println(sql);
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            int i=0;
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                if(row.length>0){
                  i++;
               res="false";    
                }
            }
            if(i==0){
              res="true";  
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null || session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException e) {
                logger.error(e.getMessage());
            }
        }
        return res;
    }

    @Override
    public String findByTagName(String tname) {
        Session session = null;
       String res="false";
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Tags.findByTagName");
            query.setParameter("tagName", tname);

           List<Tags> tagList = ( List<Tags>) query.list();
           if(tagList==null ||tagList.isEmpty()){
               res="true";
           }

        } catch (HibernateException e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (HibernateException e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return res;
    }

    @Override
    public String deleteTagByTagId(Long tagId) {
        String res = "false";
        PreparedStatement ps = null;
        Connection connection = null;
        try {
            connection = MakeConnection.getConnection();
            String sql = "delete from tags where TAG_ID=?";
            ps = connection.prepareStatement(sql);
            ps.setLong(1, tagId);
            int x = ps.executeUpdate();
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
    public List<Tags> findTagsByUserId(Integer userId) {
        Session session = null;
        List<Tags> tagList = new ArrayList<Tags>();
        Tags tags = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String sql = "select DISTINCT t.TAG_ID,t.USER_ID,t.TAG_NAME ,t.TAG_TYPE from Tags t,Tagsusers ts where t.TAG_ID=ts.TAG_ID and (t.USER_ID=" + userId + " or ts.USERID=" + userId + " ) ";
            Query query = session.createSQLQuery(sql);

            Iterator iterator = query.list().iterator();

            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                tags = new Tags();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        tags.setTagId(MoMUtil.parseLong(row[col].toString(), 0));
                    } else if (col == 1) {
                        tags.setUserId(MoMUtil.parseInteger(row[col].toString(), 0));
                    } else if (col == 2) {
                        tags.setTagName(row[col].toString());
                    } else if (col == 3) {
                        tags.setTagType(MoMUtil.parseInteger(row[col].toString(), 0));
                    }
                }
                tagList.add(tags);
            }
        } catch (HibernateException e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (HibernateException e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return tagList;
    }

    @Override
    public Tags findTagEntity(String tname, Integer userid) {
        Tags tags=null;
        Session session=null;
   try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Tags.findByUniqueTagByUser");
            query.setParameter("tagName", tname);
            query.setParameter("userId", userid);

         tags=(Tags)query.uniqueResult();
         
        } catch (HibernateException e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (HibernateException e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        } 
    
    return tags;}

}
