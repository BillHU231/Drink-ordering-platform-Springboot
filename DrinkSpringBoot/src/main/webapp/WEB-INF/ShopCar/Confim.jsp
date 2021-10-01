<%@page import="tw.drink.shopcar.model.Orderssitem"%>
<%@page import="tw.drink.shopcar.model.Orderss"%>
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

.container>h6 {
	font-size: 3em;
	text-align: center;
}
.butt{
    margin: 10px 43%;

}
</style>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>
<!-- datatables css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.0/css/dataTables.bootstrap5.min.css" />
	
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8" crossorigin="anonymous"></script>	
</head>

<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBodynew.jsp"%>


	<div class="body">
		<h1> <img src="<%request.getContextPath();%>/Drink/shopcarimages/checked.png" style="width: 50px"/>您的訂單已付款成功!!</h1>
		<hr>
		<!-- 顯示訂單 -->
		<div class="bd-example mytable2">
				<table id="datatablesSimple2" class="table table-striped"
					style="width: 80%; margin: 0 auto">
					<thead>
						<tr>
							<th scope="col">編號</th>
							<th scope="col">品項</th>
							<th scope="col">數量</th>
							<th scope="col">金額</th>
						</tr>
					</thead>
					<tbody>
						<%
						int j=1;
						  List<Orderssitem> order = (List<Orderssitem>) request.getAttribute("orderssitem");
						int total=0;
					     if (order != null && order.size() > 0) {
						for (int i = 0; i < order.size(); i++) {
							Orderssitem orderss = order.get(i);
					%>
						<tr>
						   <td><%=j++%>.</td>
						   <td><%=orderss.getPoructName()%></td>
						   <td><%=orderss.getQTY() %></td>
						   <td><%=orderss.getActualprice()*orderss.getQTY() %></td>				
						</tr>

						<%
						total+=orderss.getActualprice()*orderss.getQTY();
						}
						%>
						<tr>
						   <td colspan="4" align="right">總金額:<%=total %>元 </td>
						
						
						</tr>
						
					<% 	
					     }
					     request.getSession().setAttribute("UserID", "a123456");
					     request.getSession().setAttribute("ClassMember", "a");
					     request.getSession().setAttribute("Vat", null);
					     request.getSession().setAttribute("Longin", "success");
					     request.getSession().setAttribute("G_Name", null);
					     request.getSession().setAttribute("UserName", "王大明");
					 
					     
					     
					%>
					</tbody>
				</table>
			</div>
			<div class="butt">
			  <a class="btn btn-primary" href="http://localhost:8081/Drink/search.controller">繼續購物</a>
			  <a class="btn btn-primary" href="http://localhost:8081/Drink/HomePage">回首頁</a>
			
			</div>


	</div>
	    <!-- datatable設定 -->
	<script type="text/javascript">
	$('#datatablesSimple1').DataTable(
					{
						//欄位內部設定
						columnDefs : [{ //垂直置中
									targets : '_all',
									createdCell : function(	td,cellData,rowData,row, col) {
										$(td).css('vertical-align','middle');
									}
								},
								{ //水平置中
									targets : '_all',
									className : 'text-center'
								},
						],
					});
	
	</script>
	
	
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>
		<!--bootstrap匯入-->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>


</body>

</html>