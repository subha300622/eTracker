/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.ProjectionList;
import com.eminent.hibernate.HibernateUtil;
import com.eminent.issue.Issue;
import com.eminent.issue.Project;
import com.eminent.tqm.*;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import org.hibernate.FetchMode;
import org.hibernate.type.Type;
import java.sql.Timestamp;
import com.eminent.tqm.TqmTestcaseexecutionresult;
/**
 *
 * @author Tamilvelan
 */
public class HibenateRelation {
    public static void Test(String[] args){
         Session session     =   null;
        SessionFactory sessionFactory   =   null;

        TqmTestcaseexecutionplan plan=new TqmTestcaseexecutionplan();
        
        try{
             sessionFactory = HibernateUtil.getSessionFactory();
            session =sessionFactory.openSession();
            session.beginTransaction();
            Timestamp date=new Timestamp(new java.util.Date().getTime());

            Set s   =new HashSet();
            

                int k=10546;
                int t=10547;
                s.add((Integer)k);
                s.add((Integer)t);
                plan.setPid(10071);
                plan.setPlanname("Tamilvelan");
                plan.setBuildno("42");

                plan.setCreatedon(date);
                plan.setModifiedon(date);

                
                
                
               
    //            plan.setTqmModuleplans(new HashSet());
  //              plan.getTqmModuleplans().add(s);

                session.save("executionplan", plan);

               
               int ta=10548;
               while(ta<10552){
                   TqmModuleplan module    =   new TqmModuleplan();
                    module.setTepid(plan);
                    module.setMid(ta);
                    session.save("moduleplan",module);
                    ta++;
                                    
               }
                 

        }catch(Exception e){
            e.printStackTrace();
        }
        finally{
             session.getTransaction().commit();
            if(session!=null){
                session.close();
            }
        }
    }
    public static void hiberQuery(){
          long startTime  =   System.currentTimeMillis();
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
            Session session =sessionFactory.openSession();
            List l  =   null;
            try{
                session.beginTransaction();
                Query query =   session.createQuery("select new com.eminent.tqm.TqmTestcaseexecutionresult(comments, commentedby, commentedon,statusid) from executionresult where ptcid='Q30052010009' and tceid='1' order by COMMENTEDON desc");
                l  =   query.list();
            }
            catch(Exception e){
                e.printStackTrace();
            }finally{
                if(session!=null){
                    session.close();
                }
            }
    }
     public static void main(String[] args){
         Session session     =   null;
        SessionFactory sessionFactory   =   null;

        TqmTestcaseexecutionplan plan=new TqmTestcaseexecutionplan();

        try{
            hiberQuery();
//             sessionFactory = HibernateUtil.getSessionFactory();
//            session =sessionFactory.openSession();
//            session.beginTransaction();
//            Query query =   session.createQuery("from department where account=10004 order by departmentname asc");
//            List l  =   query.list();
//           if(l.size()>0){
//                BpmDepartments iss = (BpmDepartments)l.get(0);
//                System.out.println("Name"+iss.getDepartmentname());
//
//            }else{
//                System.out.println("No Value available");
//            }
           /*
	//
	// Prepare a Hibernate query
	//
	Query query = session.createQuery("");
	//
	// Determine the return type for this query
	//
	Type beanType = query.getReturnTypes()[0];
        
	Class beanClass = beanType.getReturnedClass();
	//
	// Extract the list of columns returned by this query
	//
	String[] columns = extractColumns("");
	//
	// Pre-process bean attribute names, stripping spaces 'as' clauses
	//
	String[] attributeNames = getAttributeFieldNames(columns);
	//
	// Pre-process result field names, stripping spaces and retaining
	// alias field names instead of the original column names where necessary
	//
	String[] resultFieldNames = getResultFieldNames(columns);
	//
	// Execute query and build result list
	//
	Iterator iter = query.iterate();
	while(iter.hasNext()) {
		  Object[] row = (Object[]) iter.next();
		  Object bean = beanClass.newInstance();
		  for (int j = 0; j < row.length; j++) {
			if (row[j] != null) {
				initialisePath(bean, attributeNames[j]);
				PropertyUtils.setProperty(bean, attributeNames[j], row[j]);
			}
		  }
		  results.add(bean);
	}
	

*/

        }catch(Exception e){
            e.printStackTrace();
        }
        finally{
//             session.getTransaction().commit();
            if(session!=null){
                session.close();
            }
        }
    }

}
