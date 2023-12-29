<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
     String pId   =   request.getParameter("pId");

    HashMap mProcess =   ViewBPM.getClientMP(Integer.parseInt(pId));
    LinkedHashMap mainProcess=GetProjectMembers.sortHashMapByKeys(mProcess,true);
    String mpName  =   ";";
    mpName=mpName+"--Select One--"+"*"+"--Select One--"+">";
    if(mainProcess.size()>0){
        Collection set=mainProcess.keySet();
        Iterator ite = set.iterator();
        int spCount  =  0;
        while (ite.hasNext()) {
            int key=(Integer)ite.next();
            String nameofmp=(String)mainProcess.get(key);
            spCount   =   ViewBPM.getSPCount(key);
            mpName  =   mpName+key+"*"+nameofmp+">";

        }
        

    }
    out.print(mpName);
%>
