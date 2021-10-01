<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.List"
	import="tw.drink.discuss.model.DiscussBean"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>討論區</title>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>

<style>
	.eranbu{
	background:blue;
	padding:100px;
	}
</style>

</head>
<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>
	<div class="eranbu">
		茶類<input type="checkbox" class="" value="">
		鮮奶茶<input type="checkbox" class="" value="">
		其他<input type="checkbox" class="" value="">
	</div>

	<% List<DiscussBean> discussList = (List<DiscussBean>) request.getAttribute("DisPage2findAll"); %>
	<% for (DiscussBean item : discussList) { %>

	<form class="discussForm"
		action="<%=request.getContextPath()%>/DiscussPage2Findall" method="post">
		<div>
			<h5>店家名稱:<%=item.getTitle()%></h5>
			<h5>飲料名:<%=item.getProname()%></h5>
			<h5>評論:<%=item.getDrinkDiscuss()%></h5>
			<div id="Drinkstar"><%=item.getDrinkstar()%>顆星
			</div>
			<div>
				<input name="shopName" type="hidden" value="<%=item.getTitle()%>">
				<input name="drink" type="hidden" value="<%=item.getProname()%>">
				<input name="drinkDiscuss" type="hidden"
					value="<%=item.getDrinkDiscuss()%>"> <input
					name="drinkstar" type="hidden" value="<%=item.getDrinkstar()%>">
				<input name="discussId" type="hidden" value="<%=item.getID()%>">
				<input type="hidden" class="Vince" name="updateValue" value="">
				<i type="button" class="bi bi-pencil-square updateButton"></i> 
				<i type="button" class="bi bi-trash deleteButton"></i>
			</div>
		</div>
	</form>
	
	<% } %>



	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>

	<script>
		//Vince ==> updateValue(input => type => hidden => class.name)
		//siblings ==>兄弟元素
		//val ==> 給值
		$('.updateButton').click(function() {
			$(this).siblings('.Vince').val("1");
			$(this).parents('form').submit();
			console.log("123");
		})
		$('.deleteButton').click(function() {
			$(this).siblings('.Vince').val("2");
			$(this).parents('form').submit();
			console.log("456");

		})
	</script>
</body>
</html>