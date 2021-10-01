<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList" import="tw.drink.activity.model.StoreProductBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>updateActivity</title>
    
	<!-- jQuery-UI CSS 樣式(配合 jQuery UI)-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!-- Bootstrap-ICON CSS 樣式 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
	
	<style>
		*{ 
			padding: 0;
			margin: 0;
		}
		.containerArea{
            padding: 0;
			margin: 0;
            width: 100%;
		}
		.containerArea .header{
			padding:220px 0;
			font-size:58px;
			line-height: 60px;
			text-align: center;
		}
		
		.containerArea .formBox{
			background-color: rgba(255,255,255,0.8);
			max-width: 98%;
			margin: 10px auto;
			border-radius: 10px;
		}
		
	</style>
	
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp" %>
	
</head>
<body>

	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp" %>
	
	<div class="containerArea">
		<div class="header" style="width:98%; height:500px ;margin:10px auto 0px auto;background:rgba(205,205,205,0.5) ; border-radius: 4px 4px 10px 10px;">
			修改限時特價項目
		</div>
		
		<div class="formBox">
			<form action="<%=request.getContextPath()%>/XXX.controller" modelAttribute="ActivityBean" method="post">
				123
			</form>
		</div>
		
	</div>
	
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp" %>
	
	<!-- jQuery CDN -->
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	
	<!-- jQuery-UI CDN -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30=" crossorigin="anonymous"></script>
	
	<!-- Bootstrap CDN Javascript body2標籤已有-->
	
    <script>
		$(function(){

			
		})
	</script>
</body>
</html>