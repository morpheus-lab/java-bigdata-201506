<%@ page contentType="text/html; charset=UTF-8" %>
<%
java.util.Calendar cal = java.util.Calendar.getInstance();
%>
<%= cal.get(java.util.Calendar.YEAR) %>년
<%= cal.get(java.util.Calendar.MONTH) + 1 %>월
<%= cal.get(java.util.Calendar.DATE) %>일