<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="tw.drink.shopcar.model.ShopCarBean"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>enterprise page</title>
<style>
* {
	padding: 0;
	margin: 0;
	list-style: none;
}


.body {
	height: 100vh;
	padding: 50px 0;
	width: 100%;
	background-color: #EFFFD7;
}

.body>h1 {
	font-size: 3em;
	text-align: center;
}

.checkoutProuct {
	border: 1px solid blue;
	border-collapse: collapse;
	margin: 10px auto;
	width: 300px
}

.body>h6 {
	font-size: 3em;
	text-align: center;
}


</style>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>
</head>

<body>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>

	<div class="body">
		<h1>您訂單已取消</h1>
		<h6>
			<img src="<%=request.getContextPath() %>/images/thanks.png">
		</h6>
 
	</div>

	</div>

  <%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>

	</script>
</body>

</html>