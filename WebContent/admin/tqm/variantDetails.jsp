<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String scId   =   request.getParameter("scId");

    HashMap variantMap =   ViewBPM.getVT(Integer.parseInt(scId));
    LinkedHashMap variant=GetProjectMembers.sortHashMapByKeys(variantMap,true);
    String vtName  =   ";";
    vtName=vtName+"--Select One--"+"*"+"--Select One--"+">";
    if(variant.size()>0){
        Collection set=variant.keySet();
        Iterator ite = set.iterator();

        while (ite.hasNext()) {
            int key=(Integer)ite.next();
            String nameofvt=(String)variant.get(key);
                vtName  =   vtName+key+"*"+nameofvt+">";

        }
        

    }
    out.print(vtName);
%>
