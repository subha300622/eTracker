
<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="asset" class="com.eminent.Assets.AssetsController"/>
<%
    asset.doAction(request);
    if (asset.isContainIp()==true||asset.isContainIp()==false) {
              out.print(asset.isContainIp());
}
%>

 
