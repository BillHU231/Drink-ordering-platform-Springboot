<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="tw.drink.store.model.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<%
response.setContentType("text/html;charset=UTF-8");
response.setHeader("Cache-Control", "no-cache"); // HTTP 1.1 
response.setHeader("Pragma", "no-cache"); // HTTP 1.0 
response.setDateHeader("Expires", -1); // Prevents caching at the proxy server 
 %>
<html>
<head>
<!--bootstrape匯入-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<!--自己的CSS-->
<link rel="stylesheet" href="store/css/index.css">

<meta charset="UTF-8">
<title>Store System</title>



<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp" %>
</head>




<body>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp" %>

	<!--標題開始-->
	<div class="position-relative text-center overflow-hidden" style="width:98%; height:500px ;margin:10px auto 0px auto;background:url(store/indeximg.jpg);background:rgba(205,205,205,0.5) ; border-radius: 4px 4px 10px 10px;">
		<!--titleImage-->
		<div class="col-md-5 p-lg-5 mx-auto my-5">

			<h1 class="myFirstTitle">店家管理系統</h1>
		</div>
		<div class="position-absolute top-0 start-0">
			<p class="lead fw-normal">
				<span class="title2">企業帳號：${UserID}</span><span class="title2">公司統編：${Vat}</span>
			</p>
		</div>
	</div>
	
<!--  	
	<h1>店家頁面</h1>
	<form action="search.controller" method="post">
	<button type="submit" >test</button>
	</form>
	
	<h1>後台頁面</h1>
	<form action="test2.controller" method="post">
	<button type="submit" >test2</button>
	</form>
	
	<h1>店家圖片建檔</h1>
	<form action="readPic.controller" method="post">
			<button type="submit" >into</button>
	</form>
	
	<h1>產品圖片建檔</h1>
	<form action="readProductPic.controller" method="post">
			<button type="submit" >into</button>
	</form>
-->
	

	<!--內文開始-->
	<div class="mycontainer">
	
	<h2 class="myStitle">分店一覽表</h2>
	
	<!-- 新增按鈕 -->
	<form action="storeEditNInsertEntry.controller" method="post">
		<input type="submit" class="btn btn-outline-success" style="margin-left: 93%;"  value="店家新增"/>
	</form>
		
	<hr class="myhr">
		
		<!--內文_欄位-->
		<div class="bd-example mytable1">
			<table class="table table-sm table-bordered">
				<thead>
					<tr>
						<th scope="col">店家ID</th>
						<th scope="col">店家建立日期</th>
						<th scope="col">店家封面</th>
						<th scope="col">店家名稱</th>
						<th scope="col">聯絡電話</th>
						<th scope="col">地址</th>
						<th scope="col">編輯上架</th>
						<th scope="col">活動管理</th>
						<th scope="col">訂單管理</th>
					</tr>
				</thead>
			<tbody>
			
					<c:forEach items="${storeList}" var="store">
						
						<c:if test="${store.storeid != null}">
						<tr>
							<td class="mytd">${store.storeid}</td>
							<td class="mytd">${store.startdate}</td>
						
						<c:if test="${empty fn:trim(store.photo)}">
							<td class="myimageTable"><img class="myimage" src="store/NoItem.jpg" alt=""></td>
						</c:if>
						<c:if test="${store.photo != null}">
							<td class="myimageTable"><img class="myimage" src="<%=request.getContextPath()%>/StoreIMG/${store.storeid}" alt=""></td>
						</c:if>
							
							<td class="mytd">${store.title}</td>
							<td class="mytd">${store.tel}</td>
							<td class="mytd">${store.stadd}</td>
							
							<td class="mytd" style="width:80px">
								<form action="storeSystemEntryIcon.controller" method="post">
									<input type="hidden" name="imbtn" value="${store.storeid}">
									<input class="imbtn myStoreEntry myentry" type="image" src="store/entry.png">
								</form>
							</td>
							<td class="mytd" style="width:80px">
								<form action="manageActivity.controller" method="post">
									<input type="hidden" name="imbtn" value="${store.storeid}">
									<input class="imbtn myActivEntry myentry" type="image" src="store/entry.png">
								</form>
							</td>
							<td class="mytd" style="width:80px">
								<form action="accountstoreneworder.controller" method="get">
									<input type="hidden" name="imbtn" value="${store.storeid}">
									<input class="imbtn myOrderEntry myentry" type="image" src="store/entry.png">
								</form>
							</td>
							
					
						</tr>
					</c:if>
				</c:forEach>
				
			</tbody>
		</table>
	</div>
</div>
	
	<!--內文結束-->
	
	
	
	<!------匯入------>
 	<!--引用jQuery-->
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<!--bootstrap匯入-->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous">
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous">
	</script>
    <!------匯入------>	
    
<!-- 滑入滑出效果 -->
<script type="text/javascript">
	$(function () {
	$( ".myStoreEntry" ).mouseover(function() {
		 $(this).attr("src","store/01entry.png");
		});
	$( ".myentry" ).mouseout(function() {
		$(this).attr("src","store/entry.png");
		});
	$( ".myActivEntry" ).mouseover(function() {
		 $(this).attr("src","store/01Aentry.png");
		});
	
	$( ".myOrderEntry" ).mouseover(function() {
		 $(this).attr("src","store/01Oentry.png");
		});
	
	
	
	});
	
</script>
		
<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp" %>
</body>
</html>