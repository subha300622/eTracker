<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mmc" class="com.eminentlabs.mom.MoMUtil"></jsp:useBean>
<%out.print(mmc.getMoMStatusCount(request));%>
