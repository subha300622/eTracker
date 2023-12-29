/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import java.util.ArrayList;
import java.util.HashMap;
import org.apache.log4j.*;

/**
 *
 * @author ADAL
 */
public class editViews {
    static Logger logger    =   null;
    static{
        logger  =Logger.getLogger("QueryEdit");
    }
public static void main(String[] args){
    try{
          int value   =   16777215;
        for(int i=0;i<10;i++){
              
                value   =   value+100;
                String incHex = Integer.toHexString(value);
                System.out.println("Value--->"+value+"   Hexa value--->"+incHex);

//                 System.out.println(Integer.parseInt("FFFFFF",16));
       }
        /*
    String COLUMN_ARRAY = "COLUMN_ARRAY";
    String VALUE_ARRAY = "VALUE_ARRAY";
    HashMap<String,ArrayList> separatedTokensHashMap = new HashMap<String,ArrayList>();
    String query_string="";
    String query_name="";
    String description="";
    String customers="All Information";
    String products="All Information";
    String versions="All Information";
    String fixversions="All Information";
    String modules="All Information";
    String platforms="All Information";
    String severitys="All Information";
    String prioritys="All Information";
    String createdbys="All Information";
    String assignedtos="All Information";
    String types="All Information";
    String statuss="All Information";
    String createdons="All Information";
    String qryToSplit="select distinct i.issueid, pname as project, subject, description, priority, severity, type, createdon, due_date, modifiedon,createdby,assignedto,s.status from issue i,issuestatus s, project p, modules m where i.issueid = s.issueid and (to_char(createdon, 'DD-Mon-YY')= '17-Jun-10' or to_char(modifiedon, 'DD-Mon-YY')='17-Jun-10') and i.pid = p.pid and p.pid in (select p.pid from project p, userproject up where p.pid = up.pid and userid = 112) order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
    ArrayList<String> nameList=new ArrayList<String>();
    ArrayList<String> valueList=new ArrayList<String>();

    String strWhere = "where";
    int whereIndex= qryToSplit.indexOf(strWhere);
    int indexToScan = whereIndex + strWhere.length()+1;
    // Taking Sub String to get the Condition
    qryToSplit = qryToSplit.substring(indexToScan);
    
    String tokenArray[] = qryToSplit.split("and");
/*
    for(String s:tokenArray){
        System.out.println(s);
    }
 
    String tokenToSeparate  = "=";
    String tokenToSeparate1  = "!=";

    String token="";
    int j=0;

    for(j=0; j<tokenArray.length;j++)
    {
        token=tokenArray[j];
  //       System.out.println(token);
        nameList.add(j,(token.split(tokenToSeparate)[0]).trim());
        valueList.add(j,(token.split(tokenToSeparate)[1]).trim());
        System.out.println("Name List-->"+nameList);
        System.out.println("Value List-->"+valueList);
    }
//            token=tokenArray[j];
//          nameList.add(j,token.split(tokenToSeparate1)[0].trim());
//        valueList.add(j,token.split(tokenToSeparate1)[1].trim());

    if(nameList.size()>0){
        separatedTokensHashMap.put(COLUMN_ARRAY,nameList);
    }
    if(valueList.size()>0){
        separatedTokensHashMap.put(VALUE_ARRAY,valueList);
    }
    String s="";
//    String checks="select * from issue, issuestatus  where issue.issueid=issuestatus.issueid";

    for( int i=0; i<tokenArray.length;i++)
    {
        System.out.println("Name List"+nameList.get(i));

        if (nameList.get(i).equals("upper(customer)"))
        {
       //         System.out.println("inside customer");
                s=valueList.get(i).toString();
                customers=s.replace('\'',' ').toLowerCase().trim();
     //           System.out.println("Inside Customer"+customers);
        }
        if (nameList.get(i).equals("upper(pname)"))
        {
                s=valueList.get(i).toString();
                products=s.replace('\'',' ').toLowerCase().trim();
        }
        if (nameList.get(i).equals("upper(found_version)"))
        {
                s=valueList.get(i).toString();
                versions=s.replace('\'',' ').toLowerCase().trim();
        }
        if (nameList.get(i).equals("upper(version)"))
        {
                s=valueList.get(i).toString();
                fixversions=s.replace('\'',' ').toLowerCase().trim();
        }
        if (nameList.get(i).equals("upper(platform)"))
        {
                s=valueList.get(i).toString();
                platforms=s.replace('\'',' ').toLowerCase().trim();
        }
        if (nameList.get(i).equals("upper(m.module)"))
        {
                s=valueList.get(i).toString();
                modules=s.replace('\'',' ').toLowerCase().trim();
        }
        if (nameList.get(i).equals("upper(severity)"))
        {
                s=valueList.get(i).toString();
                severitys=s.replace('\'',' ').toLowerCase().trim();
        }
        if (nameList.get(i).equals("upper(priority)"))
        {
                s=valueList.get(i).toString();
                prioritys=s.replace('\'',' ').toLowerCase().trim();
        }
        if (nameList.get(i).equals("upper(s.status)"))
        {
                s=valueList.get(i).toString();
                System.out.println("Status"+s);
                statuss=s.replace('\'',' ').toLowerCase().trim();
        }
        if (nameList.get(i).equals("upper(s.status)!"))
        {

                statuss="Open Issues";
        }
        if (nameList.get(i).equals("upper(assignedto)"))
        {
                s=valueList.get(i).toString();
                assignedtos=s.replace('\'',' ').toLowerCase().trim();
        }
        if (nameList.get(i).equals("upper(createdby)"))
        {
                s=valueList.get(i).toString();
                createdbys=s.replace('\'',' ').toLowerCase().trim();
        }
        if (nameList.get(i).equals("upper(type)"))
        {
                s=valueList.get(i).toString();
                types=s.replace('\'',' ').toLowerCase().trim();
        }
        if (nameList.get(i).equals("(to_char(createdon, 'DD-Mon-YY')"))
        {
                System.out.println("In Created On");
                s=valueList.get(i).toString();
                createdons=s.substring(1, 10);
                System.out.println(createdons);
        }
    }
    System.out.println("customer"+customers);
    System.out.println("product"+products);
    System.out.println("found version"+versions);
    System.out.println("fix version"+fixversions);
    System.out.println("module"+modules);
    System.out.println("Status--->"+statuss);
    System.out.println("platform"+platforms);
    System.out.println("createdby"+createdbys);
    System.out.println("type"+types);
    System.out.println("severity"+severitys);
    System.out.println("type"+prioritys);
    System.out.println("assignedto"+assignedtos);
    System.out.println("createdon"+createdons);
    nameList.clear();
    valueList.clear();
    for(int i=0; i<nameList.size();i++)
    {
        nameList.remove(i);
        valueList.remove(i);
    }
    */
    }catch(Exception e){
        e.printStackTrace();
    }
}
}
