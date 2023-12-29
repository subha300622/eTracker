package com.eminent.issue;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import com.eminent.hibernate.HibernateUtil;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author Administrator
 */
public class IssueAccess {
    static Logger logger =Logger.getLogger("IssueAccess");
    public static Issue GetIssueDetails(String issueId){
        SessionFactory sessionFactory    =   null;
        Session session                 =   null;
        Issue issue =null;
        try{
        sessionFactory = HibernateUtil.getSessionFactory();
        session =sessionFactory.openSession();
        session.beginTransaction();
        
        Query query =   session.createQuery("from Issue where issueid='"+issueId+"'");
        List l  =   query.list();
        int size=l.size();
        if(size>0){
            int i=0;
            issue = (Issue)l.get(i);
        }
      }catch(Exception e){
          logger.error(e.getMessage());
      }
      finally{
         if(session!=null){
          session.close();
      }
        return issue;

    }

    }
    public static Issue GetDetails(String issueId){
        SessionFactory sessionFactory    =   null;
        Session session                 =   null;
        Issue issue =null;
        try{
        sessionFactory = HibernateUtil.getSessionFactory();
        session =sessionFactory.openSession();
        session.beginTransaction();
        Criteria c = session.createCriteria("velan");
        c.add(Restrictions.eq("issueid",issueId));
        List l  =   c.list();
        int size=l.size();
        if(size>0){
            int i=0;
            issue = (Issue)l.get(i);

        }
      }catch(Exception e){
          logger.error(e.getMessage());
      }
      finally{
         if(session!=null){
          session.close();
      }
        return issue;

    }

    }
}
