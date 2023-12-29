/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package dashboard;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.*;
import java.util.List;
import com.eminent.hibernate.HibernateUtil;
import com.eminent.tqm.TqmTestcaseexecution;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.hibernate.Criteria;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.ProjectionList;
/**
 *
 * @author ADAL
 */
public class TestCases {
    static Logger logger = null;
    static{
        logger = Logger.getLogger("TestCases");

    }
    public static String[][] showProjectTestCases(){
        String[][] moduleTestCases  =   null;
        Connection connection       =   null;
        Statement   statement       =   null;
        ResultSet   resultset       =   null;
        int rowcount                =   0;
        try{
            connection  =   MakeConnection.getConnection();
            statement   =   connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            resultset   =   statement.executeQuery("select project.pid as projectid,pname,count(*) as nooftestcase from tqm_ptcm,project where tqm_ptcm.pid=project.pid group by project.pid,pname order by project.pid desc");
            resultset.last();
            rowcount    =   resultset.getRow();
            resultset.beforeFirst();
            String module[][]   =   new String[rowcount][3];
            int i=0;
            while(resultset.next()){
                module[i][0]    =   resultset.getString(1);
                module[i][1]    =   resultset.getString(2);
                module[i][2]    =   resultset.getString(3);

                i++;
            }
            moduleTestCases     =   module;
        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }
            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }
            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return moduleTestCases;
    }
    public static String[][] showTestCases(String pid){
        String[][] moduleTestCases  =   null;
        Connection connection       =   null;
        Statement   statement       =   null;
        ResultSet   resultset       =   null;
        int rowcount                =   0;
        try{
            connection  =   MakeConnection.getConnection();
            statement   =   connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            resultset   =   statement.executeQuery("select mid,module,count(*) as nooftestcase from tqm_ptcm,modules where tqm_ptcm.pid='"+pid+"' and tqm_ptcm.mid=modules.moduleid group by mid,module order by mid desc");
            resultset.last();
            rowcount    =   resultset.getRow();
            resultset.beforeFirst();
            String module[][]   =   new String[rowcount][3];
            int i=0;
            while(resultset.next()){
                module[i][0]    =   resultset.getString(1);
                module[i][1]    =   resultset.getString(2);
                module[i][2]    =   resultset.getString(3);

                i++;
            }
            moduleTestCases     =   module;
        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }
            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }
            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return moduleTestCases;
    }
    public static String[][] showTestcaseDetails(String pid,String mid){
        String[][] moduleTestCases  =   null;
        Connection connection       =   null;
        Statement   statement       =   null;
        ResultSet   resultset       =   null;
        int rowcount                =   0;
        try{
            connection  =   MakeConnection.getConnection();
            statement   =   connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            resultset   =   statement.executeQuery("select pname,version,module,ptcid,functionality,description,expectedresult,firstname||' ' ||substr(lastname,1,1) as createdby from tqm_ptcm,modules,project,users where tqm_ptcm.pid='"+pid+"' and tqm_ptcm.mid='"+mid+"' and tqm_ptcm.mid=modules.moduleid and tqm_ptcm.pid=project.pid and users.userid=tqm_ptcm.createdby");
            resultset.last();
            rowcount    =   resultset.getRow();
            resultset.beforeFirst();
            String module[][]   =   new String[rowcount][7];
            int i=0;
            String project      =   null;
            while(resultset.next()){
                project         =   resultset.getString(1)+" v"+resultset.getString(2);
                module[i][0]    =  project;
                module[i][1]    =  resultset.getString(3);
                module[i][2]    =  resultset.getString(4);
                module[i][3]    =  resultset.getString(5);
                module[i][4]    =  resultset.getString(6);
                module[i][5]    =  resultset.getString(7);
                module[i][6]    =  resultset.getString(8);

                i++;
            }
            moduleTestCases     =   module;
        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }
            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }
            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return moduleTestCases;
    }
     public static List executionPlanChart(String tepId){
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session =sessionFactory.openSession();
        List l  =   null;
        try{
               session.beginTransaction();
   /*             Criteria k = session.createCriteria(TqmTestcaseexecution.class);
                k.add(Restrictions.eq("tqmTestcaseexecutionplan",com.eminent.tqm.TestCasePlan.viewPlan(tepId)));
                k.addOrder(Property.forName("statusid").asc());
                 ProjectionList projList = Projections.projectionList();
                 projList.add(Projections.rowCount());
                 projList.add(Projections.groupProperty("statusid"));
                 k.setProjection(projList);
                 l =   k.list();
    */
                Query query =   session.createSQLQuery("select count(*),s.statusid,s.status from tqm_testcaseexecution e,TQM_TESTCASESTATUS s where e.tepid="+tepId+" and e.statusid=s.statusid  group by s.statusid,s.status order by s.statusid");
                l   = query.list();

           }
        catch(Exception e){
            logger.error(e.getMessage());
        }finally{
            if(session!=null){
                session.close();
            }
        }
        return l;
    }

}
