<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.List" import="tw.drink.discuss.model.DiscussBean" %>
<!DOCTYPE html>
<html>
		<head>
			<meta charset="UTF-8">
			<title>討論區</title>
			<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp" %>
			
		<style>
		
		</style>
		
		</head>
	<body>
										<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp" %>
				
		
				 	 <% List<DiscussBean> discussList = (List<DiscussBean>)request.getAttribute("discussAll"); %>
                  	 <% for(DiscussBean item : discussList){  %>
                
	               		 <form class="discussForm" action="<%=request.getContextPath()%>/UpdateDiscussController" method="post">
	               			<table class="table table-striped table-hover">
	                			<tr class="table-primary">
		                			<td>店家名稱:<%= item.getTitle()%></td>
		                			<td>飲料名:<%= item.getProname()%></td>
		                			<td>評論:<%=item.getDrinkDiscuss() %></td>
		                			<td id="Drinkstar"><%=item.getDrinkstar()%>顆星</td>
		                			<td>
	                				<input name="shopName" type="hidden" value="<%= item.getTitle()%>">
	                				<input name="drink" type="hidden" value="<%= item.getProname()%>">
	                				<input name="drinkDiscuss" type="hidden" value="<%= item.getDrinkDiscuss()%>">
	                				<input name="drinkstar" type="hidden" value="<%= item.getDrinkstar()%>">
		                				<input name="discussId" type="hidden" value="<%= item.getID()%>">
		                				<button type="button" class="updateButton">編輯</button>
									</td>
								</tr>
	               			 </table> 
	                	  </form>
                	  <% } %>
                	  
                
                
        								 <%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp" %>
                	
					<script>
					//Vince ==> updateValue(input => type => hidden => class.name)
					//siblings ==>兄弟元素
					//val ==> 給值
					
					
					</script>
	</body>
</html>