/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import org.apache.log4j.Logger;
import java.math.BigDecimal;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Property;
import com.eminent.hibernate.HibernateUtil;
import com.eminent.issue.Issue;
import com.eminent.issue.Project;
import com.eminent.tqm.*;
import java.util.List;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import org.hibernate.FetchMode;
import java.sql.Timestamp;

/**
 *
 * @author Administrator
 */
public class TestHibernation {
    static{
        Logger logger=Logger.getLogger("Hibernate Test");
    }
    public static void main(String[] args){
        Session session     =   null;
        SessionFactory sessionFactory   =   null;
        List l=null;
        String issueId="E28032009003";
        Issue issue=null;
        TqmPtcm ptcm=null;
        Project test=null;
        int i   =0;
        TqmTestcaseexecution status=null;
        TqmTestcaseresult reslt=new TqmTestcaseresult();
        TqmTestcaseexecutionplan plan=new TqmTestcaseexecutionplan();
        TqmPtcm module    =   new TqmPtcm();
        ArrayList al    =   new ArrayList<Integer>();
        try{
            sessionFactory = HibernateUtil.getSessionFactory();
            session =sessionFactory.openSession();
            session.beginTransaction();
            /*
            DetachedCriteria query = DetachedCriteria.forClass(TqmTestcaseexecution.class);
            query.add(Property.forName("tepid").eq("6") );

            List results = query.getExecutableCriteria(session).setMaxResults(100).list();
   
            Criteria k = session.createCriteria(TqmTestcaseexecution.class);
            k.add(Restrictions.eq("tqmTestcaseexecutionplan",com.eminent.tqm.TestCasePlan.viewPlan("3")));
            
             ProjectionList projList = Projections.projectionList();
             projList.add(Projections.rowCount());
             projList.add(Projections.groupProperty("statusid"));
             k.setProjection(projList);
             List c =   k.list();
             *

  
      //      Query query =   session.createQuery("from Issue where issueid='E20112009003'");
*/
            Timestamp date=new Timestamp(new java.util.Date().getTime());
                String hql = "insert into executionresult(comments,ptcid,commentedby,commentedto,commentedon,statusid,tceid) values(?,?,?,?,?,?,?)";
                Query query = session.createQuery(hql);

                query.setString(1,"Test");
                query.setString(2,"Q14072010003");
                query.setInteger(3,112);
                query.setInteger(4,112);
                query.setTimestamp(5, date);
                query.setInteger(6,3);
                query.setInteger(7,1);
                query.executeUpdate();
                
//            Query query =   session.createSQLQuery("Select p.tepid,p.actualstart from Tqm_testcaseexecutionplan p,Tqm_testcaseexecution e where p.tepid=e.tepid and tceid='2'");
 //           Query query =   session.createSQLQuery("select count(*),s.statusid,s.status from tqm_testcaseexecution e,TQM_TESTCASESTATUS s where e.tepid=2 and e.statusid=s.statusid  group by s.statusid,s.status order by s.statusid");
  //          l  =   query.list();
 //           List k  =   query.list();
//            Iterator it=k.iterator();
//                      while(it.hasNext()){
//                          Object[] obj = (Object[]) it.next();
//  //                         String status   =   ((TqmTestcasestatus)obj[1]).getStatus();
////                            int noOfCases   =   ((Integer)obj[0]).intValue();
//                          System.out.println("NO Of Test Cases"+((BigDecimal)obj[0]));
//                           System.out.println("Status "+((String)obj[2]));
//  //                         System.out.println(((java.util.Date)obj[1]));
//
////                          l.add((Integer)module.getMid());
//                          i++;
//                      }
    //         System.out.println(i);
             /*
              TqmPtcm ptc                     =  TqmUtil.viewPTC("Q13072010009");
              Query c =   session.createQuery("from isstestcases where ptcid='Q13072010009'");
             l  =c.list();
             if(l.size()>0){
                TqmIssuetestcases iss = (TqmIssuetestcases)l.get(0);
                issueId =   iss.getIssueid();
            }
            System.out.println("Test case issue--->"+issueId);
            /*
  //          int size=l.size();
    //         System.out.print(size);
    //        if(size>0){
 
      //    status = (TqmTestcaseexecution)c.get(i);
   //           test = (Project)l.get(i);
   //           System.out.print(status.);

              
      //      }
  /*          String stat[] ={"Passed","Failed","Not Applicable","Not Run","Yet to Test"};
             Iterator iter = c.iterator();
             HashMap<String,Integer> hm  =   new HashMap<String,Integer>();
        if (!iter.hasNext())
        {
            System.out.println("No objects to display.");
            return;
        }
        while (iter.hasNext())
        {
            System.out.println("New object");
            Object[] obj = (Object[]) iter.next();

                hm.put(((TqmTestcasestatus)obj[1]).getStatus(),(Integer)obj[0]);
               


        }
              for(String s:stat){
            if(!hm.containsKey(s)){
                hm.put(s, (Integer)(0));
                System.out.println("Added"+s);
            }
        }
             for(String s:stat){
                 System.out.println(hm.get(s));
             }




  //          session.close();
 //            System.out.println(issue.getModules().getModule());
 /*           for (Iterator i = l.iterator(); i.hasNext(); ) {
            Project t =(Project)i.next();
            Set s   =   t.getIssues();
            Iterator sk=s.iterator();
            while(sk.hasNext()){
                Issue k=(Issue)sk.next();
                System.out.println(k.getAssignedto());
            }

            }
*/
        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally{
            if(session!=null){
                session.close();
            }
        }

    }

}
