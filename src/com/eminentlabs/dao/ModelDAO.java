/**
 *
 * @author Tamilvelan
 */
package com.eminentlabs.dao;

import com.eminentlabs.appraisal.ErmAppraisal;

import org.hibernate.Session;
import org.apache.log4j.Logger;

/**
 *
 * This class must be extended by other specific DAO classes to inherit the
 * basic functionalities.
 */
public class ModelDAO {

    static Logger logger = Logger.getLogger("ModelDAO");

    public static void save(String entityName, Object obj) {
        Session session = HibernateFactory.getCurrentSession();

        session.save(entityName, obj);
        //Below piece fo code needs to be removed & Should call the generic method in Hibernate Factory
        session.flush();
        HibernateFactory.commitAndClose();
    }

    public static Object load(Class entityClassName, Integer primaryKey) {
        Session session = HibernateFactory.getCurrentSession();
        return session.load(entityClassName, primaryKey);
    }

    public static int createErmAppraisal(ErmAppraisal appraisal) {
        Session session = HibernateFactory.getCurrentSession();
        session.saveOrUpdate(DAOConstants.ENTITY_ErmAppraisal, appraisal);
        session.flush();

        int appraisalId = appraisal.getAppraisalId();
        logger.info("######### Appraisal Created  #############");
        return appraisalId;
    }

    public static void saveOrUpdate(String entityName, Object obj) {
        Session session = HibernateFactory.getCurrentSession();
        session.saveOrUpdate(entityName, obj);
        session.flush();
        HibernateFactory.commitAndClose();
    }

    public static void Update(String entityName, Object obj) {
        Session session = HibernateFactory.getCurrentSession();
        session.merge(entityName, obj);
        session.flush();
        HibernateFactory.commitAndClose();
    }

    public static void update(String entityName, Object obj) {
        Session session = HibernateFactory.getCurrentSession();
        session.update(entityName, obj);
        session.flush();
        HibernateFactory.commitAndClose();
    }

    public static void delete(String entityName, Object obj) {
        Session session = HibernateFactory.getCurrentSession();

        session.delete(entityName, obj);
        session.flush();
        HibernateFactory.commitAndClose();
    }

    public static void addMailContent(String entityName, Object obj) {
        Session session = HibernateFactory.getCurrentSession();
        session.save(entityName, obj);
        session.flush();
        HibernateFactory.commitAndClose();
    }

    public static void addGSTMailContent(String entityName, Object obj) {
        Session session = HibernateFactory.getCurrentSession();
        session.save(entityName, obj);
        session.flush();
        HibernateFactory.commitAndClose();
    }
}
