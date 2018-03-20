<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="com.aliyunoss.HelloOSS" %><%--
  Created by IntelliJ IDEA.
  User: muqi
  Date: 2018/3/20
  Time: 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="application/x-msdownload" pageEncoding="UTF-8"%>
<%
    //关于文件下载时采用文件流输出的方式处理：
    //加上response.reset()，并且所有的％>后面不要换行，包括最后一个；
    response.reset();//可以加也可以不加
    response.setContentType("application/x-download");
    //application.getRealPath("/main/mvplayer/CapSetup.msi");获取的物理路径
    //接收表单
    request.setCharacterEncoding("utf-8");
    String fname = request.getParameter("filename");
    HelloOSS ho = new HelloOSS();
    String info = ho.downloadfiele(fname);
    if(info.equals("successful")){
        String filedownload = "F:"+ File.separator +"ossdown"+ File.separator + fname;
        String filedisplay = fname;
        filedisplay = URLEncoder.encode(filedisplay, "UTF-8");
        response.addHeader("Content-Disposition","attachment;filename=" + filedisplay);

        java.io.OutputStream outp = null;
        java.io.FileInputStream in = null;
        try {
            outp = response.getOutputStream();
            in = new FileInputStream(filedownload);
            byte[] b = new byte[1024];
            int i = 0;
            while((i = in.read(b)) > 0) {
                outp.write(b, 0, i);
            }
            outp.flush();
            //要加以下两句话，否则会报错
            //java.lang.IllegalStateException: getOutputStream() has already been called for //this response
            out.clear();
            out = pageContext.pushBody();
        }  catch(Exception e){
            System.out.println("Error!");
            e.printStackTrace();
        }finally{
            if(in != null){
                in.close();
                in = null;
            }
            //这里不能关闭
            //if(outp != null)  {
            //outp.close();
            //outp = null;
            //}
        }
    }

%>