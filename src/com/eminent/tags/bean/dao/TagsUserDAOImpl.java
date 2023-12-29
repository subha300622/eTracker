/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tags.bean.dao;

import com.eminent.tags.bean.TagsUsersEntity;
import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author admin
 */
public class TagsUserDAOImpl implements TagsUserDAO {

    public Logger logger = Logger.getLogger("TagsUserEntityDAOImpl");

    @Override
    public void saveTagUser(List<TagsUsersEntity> listTagUser) {
        try {
            for (TagsUsersEntity objEntity : listTagUser) {
                ModelDAO.save(DAOConstants.ENTITY_TAGS, objEntity);
            }

            //Below piece fo code needs to be removed & Should call the generic method in Hibernate Factory
            
        } catch (Exception e) {
            e.printStackTrace();
        }
      
  

    }

    @Override
    public String deleteUserByTag(Long tagId) {
        String res = "false";
        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = MakeConnection.getConnection();
            String sql = "delete from  TAGSUSERS where TAG_ID=?";
            ps = connection.prepareStatement(sql);
            ps.setLong(1, tagId);
           int x= ps.executeUpdate();
            System.out.println("tagsUsers delete "+x);
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
    public List<TagsUsersEntity> findByTagId(Long TagId) {
        Session session = null;
        List<TagsUsersEntity> tagsUserslist = new ArrayList<TagsUsersEntity>();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("TagsUsersEntity.findByTagId");
            query.setLong("tagId", TagId);
            tagsUserslist = (List<TagsUsersEntity>) query.list();

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
        return tagsUserslist;
    }

}
