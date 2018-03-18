<%--
  Created by IntelliJ IDEA.
  User: muqi
  Date: 2018/3/18
  Time: 18:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.aliyunoss.HelloOSS" %>
<%@ page import="com.aliyun.oss.model.OSSObjectSummary" %>
<%@ page import="java.util.List" %>
<%
    HelloOSS ho = new HelloOSS();
    List<OSSObjectSummary> objectSummary=ho.showlist();
    out.print("您有以下Object："+"<br>");
    for (OSSObjectSummary object : objectSummary) {
        out.print(object.getKey()+"<br>");
    }
%>