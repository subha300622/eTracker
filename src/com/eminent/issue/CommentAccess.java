/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.issue;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import com.eminent.hibernate.HibernateUtil;
import java.util.List;
import java.util.Date;
import java.sql.Timestamp;
import org.apache.log4j.Logger;
/**
 *
 * @author Administrator
 */
public class CommentAccess {
    static Logger logger =Logger.getLogger("CommentAccess");
    public static List GetCommentDetails(String issueId){

        Session session     =   null;
        SessionFactory sessionFactory   =   null;
        List l=null;
        try{
            sessionFactory = HibernateUtil.getSessionFactory();
            session =sessionFactory.openSession();
            session.beginTransaction();
            Criteria c = session.createCriteria("velan");
            c.add(Restrictions.eq("issueid",issueId));
            l  =   c.list();
       
        }
        catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            if(session!=null){
                session.close();
            }
        }
       return l;

    }
    public static void UpdateComments(String issueId,String commentedby,String comments,String priority,String severity,Date dueDate,String commentedto,String status){
        Session session     =   null;
        SessionFactory sessionFactory   =   null;
        int i=0;
        try{
            sessionFactory = HibernateUtil.getSessionFactory();
            session =sessionFactory.openSession();
            session.beginTransaction();

             Timestamp date=new Timestamp(new java.util.Date().getTime());

            Issuecomments comment=new Issuecomments();
            comment.setIssue(IssueAccess.GetIssueDetails(issueId));
            comment.setCommentedby(commentedby);
            comment.setComments(comments);
            comment.setCommentedto(commentedto);
            comment.setSeverity(severity);
            comment.setPriority(priority);
            comment.setStatus(status);
            comment.setDuedate(dueDate);
            comment.setCommentDate(date);
            session.save(comment);
            session.getTransaction().commit();
            logger.info("Comment Inserted");
            
        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            if(session!=null){
                session.close();
            }
        }
       
    }

}
