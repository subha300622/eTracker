<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>
<%! Connection connection;
Statement stmt;
ArrayList<String> al;
ResultSet rs =null;
String modules="";
String totalmodules="";
int count=0;
%>
<%Logger logger = Logger.getLogger("ModuleDetails");
    String cus3="";
    String prod3="";
    String cus[]=request.getParameter("customer").split(",");
    String prod[]=(request.getParameter("product").split(","));
     Integer uid= (Integer) session.getAttribute("userid_curr");
    for(int i=0;i<prod.length;i++){
                prod3=prod3+"'"+prod[i].trim()+"',";
            }
            if(prod3.length()>3){
                prod3=prod3.substring(0,prod3.length()-1);
            }else{
                prod3="All Information";
            }
          for(int i=0;i<cus.length;i++){
                cus3=cus3+"'"+cus[i].trim()+"',";
            }
            if(cus3.length()>3){
                cus3=cus3.substring(0,cus3.length()-1);
            }else{
                cus3="All Information";
            } 
    String found_versiona[]=request.getParameter("version").trim().split(",");
    String ver3="";
            for(int i=0;i<found_versiona.length;i++){
                if(!found_versiona[i].trim().equalsIgnoreCase("All Information")){
                    ver3=ver3+"'"+found_versiona[i].trim()+"',";
                }
            }
            if(ver3.length()>3){
                ver3=ver3.substring(0,ver3.length()-1);
            }else{
                ver3="All Information";
            }
    String plat[]=request.getParameter("platform").trim().split(",");
    String plat3="";
            for(int i=0;i<plat.length;i++){
                if(!plat[i].trim().equalsIgnoreCase("All Information")){
                    plat3=plat3+"'"+plat[i].trim()+"',";
                }
            }
            if(plat3.length()>3){
                plat3=plat3.substring(0,plat3.length()-1);
            }else{
                plat3="All Information";
            }
     try
    {
        connection=MakeConnection.getConnection();
        
        stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
         /*edit by sowjanya*/
        if (cus3.equals("'All Information'") && prod3.equals("'All Information'") && ver3.equals("All Information") || plat3.equals("All Information")) {
                rs = stmt.executeQuery("SELECT MODULE FROM MODULES WHERE modules.pid in ( SELECT PID  FROM  USERPROJECT UP WHERE UP.USERID = " + uid + " ) GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        } /*edit by sowjanya*/ else if((cus3=="All Information"||cus3.equalsIgnoreCase("All Information"))&&(prod3!="All Information"||!prod3.equalsIgnoreCase("All Information"))&&(ver3=="All Information"||ver3.equalsIgnoreCase("All Information"))&&(plat3=="All Information"||plat3.equalsIgnoreCase("All Information")))
        {
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE PNAME in ("+prod3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3!="All Information"||!cus3.equalsIgnoreCase("All Information"))&&(prod3!="All Information"||!prod3.equalsIgnoreCase("All Information"))&&(ver3=="All Information"||ver3.equalsIgnoreCase("All Information"))&&(plat3=="All Information"||plat3.equalsIgnoreCase("All Information")))
        {
                  rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE CUSTOMER in ("+cus3+") and PNAME in ("+prod3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3!="All Information"||!cus3.equalsIgnoreCase("All Information"))&&(prod3!="All Information"||!prod3.equalsIgnoreCase("All Information"))&&(ver3!="All Information"||!ver3.equalsIgnoreCase("All Information"))&&(plat3=="All Information"||plat3.equalsIgnoreCase("All Information")))
        {
                    rs= stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE CUSTOMER in ("+cus3+") and PNAME in ("+prod3+") and VERSION in ("+ver3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((!cus3.equalsIgnoreCase("All Information"))&&(!prod3.equalsIgnoreCase("All Information"))&&(!ver3.equalsIgnoreCase("All Information"))&&(!plat3.equalsIgnoreCase("All Information")))
        {
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE CUSTOMER in ("+cus3+") and PNAME in ("+prod3+") and VERSION in ("+ver3+") and PLATFORM in ("+plat3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3!="All Information"||!cus3.equalsIgnoreCase("All Information"))&&(prod3=="All Information"||prod3.equalsIgnoreCase("All Information"))&&(ver3!="All Information"||!ver3.equalsIgnoreCase("All Information"))&&(plat3!="All Information"||!plat3.equalsIgnoreCase("All Information")))
        {
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE CUSTOMER in ("+cus3+") and VERSION in ("+ver3+") and PLATFORM in ("+plat3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE) ");
        }
        else if((cus3!="All Information"||!cus3.equalsIgnoreCase("All Information"))&&(prod3!="All Information"||!prod3.equalsIgnoreCase("All Information"))&&(ver3=="All Information"||ver3.equalsIgnoreCase("All Information"))&&(plat3!="All Information"||!plat3.equalsIgnoreCase("All Information")))
        {
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE CUSTOMER in ("+cus3+") and PNAME in ("+prod3+") and PLATFORM in ("+plat3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3=="All Information"||cus3.equalsIgnoreCase("All Information"))&&(prod3=="All Information"||prod3.equalsIgnoreCase("All Information"))&&(ver3!="All Information"||!ver3.equalsIgnoreCase("All Information"))&&(plat3!="All Information"||!plat3.equalsIgnoreCase("All Information")))
        {   
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE VERSION in ("+ver3+") and PLATFORM in ("+plat3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3=="All Information"||cus3.equalsIgnoreCase("All Information"))&&(prod3!="All Information"||!prod3.equalsIgnoreCase("All Information"))&&(ver3!="All Information"||!ver3.equalsIgnoreCase("All Information"))&&(plat3!="All Information"||!plat3.equalsIgnoreCase("All Information")))
        {  
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE PNAME in ("+prod3+") and VERSION in ("+ver3+") and PLATFORM in ("+plat3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3=="All Information"||cus3.equalsIgnoreCase("All Information"))&&(prod3!="All Information"||!prod3.equalsIgnoreCase("All Information"))&&(ver3=="All Information"||ver3.equalsIgnoreCase("All Information"))&&(plat3!="All Information"||!plat3.equalsIgnoreCase("All Information")))
        {
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE PNAME in ("+prod3+") and PLATFORM in ("+plat3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3!="All Information"||!cus3.equalsIgnoreCase("All Information"))&&(prod3=="All Information"||prod3.equalsIgnoreCase("All Information"))&&(ver3=="All Information"||ver3.equalsIgnoreCase("All Information"))&&(plat3!="All Information"||!plat3.equalsIgnoreCase("All Information")))
        {
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE CUSTOMER in ("+cus3+") and PLATFORM in ("+plat3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3!="All Information"||!cus3.equalsIgnoreCase("All Information"))&&(prod3=="All Information"||prod3.equalsIgnoreCase("All Information"))&&(ver3!="All Information"||!ver3.equalsIgnoreCase("All Information"))&&(plat3=="All Information"||plat3.equalsIgnoreCase("All Information")))
        {        
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE CUSTOMER in ("+cus3+") and VERSION in ("+ver3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3=="All Information"||cus3.equalsIgnoreCase("All Information"))&&(prod3!="All Information"||!prod3.equalsIgnoreCase("All Information"))&&(ver3!="All Information"||!ver3.equalsIgnoreCase("All Information"))&&(plat3=="All Information"||plat3.equalsIgnoreCase("All Information")))
        {         
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE PNAME in ("+prod3+") and VERSION in ("+ver3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3=="All Information"||cus3.equalsIgnoreCase("All Information"))&&(prod3=="All Information"||prod3.equalsIgnoreCase("All Information"))&&(ver3!="All Information"||!ver3.equalsIgnoreCase("All Information"))&&(plat3=="All Information"||plat3.equalsIgnoreCase("All Information")))
        {         
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE VERSION in ("+ver3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3=="All Information"||cus3.equalsIgnoreCase("All Information"))&&(prod3=="All Information"||prod3.equalsIgnoreCase("All Information"))&&(ver3=="All Information"||ver3.equalsIgnoreCase("All Information"))&&(plat3!="All Information"||!plat3.equalsIgnoreCase("All Information")))
        {         
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE PLATFORM in ("+plat3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else if((cus3!="All Information"||!cus3.equalsIgnoreCase("All Information"))&&(prod3=="All Information"||prod3.equalsIgnoreCase("All Information"))&&(ver3=="All Information"||ver3.equalsIgnoreCase("All Information"))&&(plat3=="All Information"||plat3.equalsIgnoreCase("All Information")))
        {     
                    rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE CUSTOMER in ("+cus3+") and modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        else
        {  
                   rs = stmt.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE modules.pid=project.pid GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
        }
        al=new ArrayList<String>();
        rs.last();
        int rowcount=rs.getRow();
        rs.beforeFirst();

        totalmodules=";";//rowcount+",";
        totalmodules=totalmodules.trim();
        if (rowcount>=2)
        {
            totalmodules=totalmodules+"All Information"+",";
            count++;
        }
        else if (rowcount==0)
        {
            totalmodules=totalmodules+"All Information"+",";
            count++;
        }
        else
            totalmodules=";";
        while(rs.next())
        {    
            modules=rs.getString("MODULE");
            totalmodules=totalmodules+modules.trim()+",";
            count++;
        }
        totalmodules=totalmodules+count;
        al.add(totalmodules);
        String f[]=new String[al.size()+1];
        Object a[]=al.toArray();
        f[0]=(String)a[0];
        out.println(f[0]);
        count=0;
        totalmodules=";";
   }
   catch(ArrayIndexOutOfBoundsException e)
   {
         logger.error(e.getMessage());
   }
   finally{
        if (rs!=null)
        rs.close();
        if (stmt!=null)
        stmt.close();
        if (connection!=null)
        connection.close();
   }
%>

