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

<!-- <!--form匯入--> 
<!-- <link rel="canonical" -->
<!-- 	href="https://getbootstrap.com/docs/5.0/examples/checkout/"> -->
<!-- <link href="form-validation.css" rel="stylesheet"> -->

<meta charset="UTF-8">
<title>Store System</title>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp" %>
</head>


<body>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp" %>

	<!--標題開始-->
	<div class="position-relative text-center overflow-hidden" style="width:98%; height:500px ;margin:10px auto 0px auto; background:url(store/indeximg.jpg);background:rgba(205,205,205,0.5) ; border-radius: 4px 4px 10px 10px;">
		<!--titleImage-->
		<div class="col-md-5 p-lg-5 mx-auto my-5" style="width:99%">

			<h1 class="myFirstTitle">店家資訊新增及編輯</h1>
			<div class="position-absolute top-0 end-0">
				<a class="btn btn-outline-secondary mybtn" href="storeSystemEntry.controller">返回分店首頁</a>
			</div>
		</div>
		<div class="position-absolute top-0 start-0">
			<p class="lead fw-normal">
				<span class="title2">企業帳號：${UserID}</span><span class="title2">公司統編：${Vat}</span>
			</p>
		</div>
	</div>


	<!--內文開始-->
	<div class="mycontainer">


		<!--店家抬頭-->
		<h2 class="myStitle">店家資訊</h2>
		<hr class="myhr">



		<!--店家編輯欄位-->
		<div class="container">
			<main>
			
			<c:if test="${storeItem == null || storeItem == ''}">
			
				<form id="SAdd" class="row g-3" action="insertStoreAction.controller" modelAttribute="storeItem" method="post"	enctype="multipart/form-data">

					<!-- 第一次新增 -->

						<!-- 店家封面 -->
						<label class="form-label">店家封面：</label>
						<div class="text-center">

							<!-- 圖片 -->
							<img id="upimg" class="d-block mx-auto mb-4 myFormImage" src="store/NoItem.jpg">

							<div class="mb-3">
								<input class="form-control" type="file" id="formFile" name="photo">
							</div>
						</div>

						<!-- 店家基本資料 -->
						<div class="col-md-6">
							<label class="form-label">名稱：</label> 
							<input id="title" type="text" class="form-control" name="title">
						</div>
						<div class="col-md-6">
							<label class="form-label">負責人：</label> 
							<input id="manager" type="text" class="form-control" name="manager">
						</div>
						<div class="col-md-6">
							<label class="form-label">聯絡電話：</label> 
							<input id="tel" type="text" class="form-control" name="tel" placeholder="格式：02-2798-8888 / 0912-345-678">
						</div>
						<div class="col-md-6">
							<label class="form-label">地址：</label> 
							<input id="stadd" type="text" class="form-control" name="stadd" placeholder="格式：台中市信義區基隆路247號">
						</div>
						<div class="mb-3">
							<label class="form-label">簡介：</label>
							<textarea id="intro" class="form-control" id="" rows="3" style="resize: none" name="intro"></textarea>
						</div>
						</form>
						<div class="col-12 myFormbtn">
							<button class="btn btn-primary edbtn" onclick="SAdd()" type="submit">確認更新</button>
							<button class="btn btn-secondary edbtn" onclick="Back()" type="submit" >取消返回</button>
							<button class="btn btn-info edbtn" onclick="Input()" type="submit" >一鍵輸入</button>
							
							<!-- 返回系統管理首頁 -->
							<form id="backentry" action="storeSystemEntry.controller" method="post"></form>
						</div>
					</c:if>



					<!-- 新增過要編輯 -->

					<c:if test="${storeItem != null && storeItem != ''}">
					<form id="SEdit" class="row g-3" action="storeEditAction.controller" modelAttribute="storeItem" method="post"	enctype="multipart/form-data">
						<!-- 店家封面 -->
						<label class="form-label">店家封面：</label>
						<div class="text-center">

							<!-- 圖片 -->
							<c:if test="${empty fn:trim(storeItem.photo)}">
								<img id="upimg" class="d-block mx-auto mb-4 myFormImage"
									src="store/NoItem.jpg">
							</c:if>
							<c:if test="${storeItem.photo != null}">
								<img id="upimg" class="d-block mx-auto mb-4 myFormImage"
									src="<%=request.getContextPath()%>/StoreIMG/${storeItem.storeid}">
							</c:if>

							<div class="mb-3">
								<input class="form-control" type="file" id="formFile"
									name="photo">
							</div>
						</div>


						<div class="col-md-6">
							<label class="form-label">ID號碼：</label> <input type="text"
								class="form-control" name="storeid" value="${storeItem.storeid}"
								disabled="disabled">
						</div>
						<div class="col-md-6">
							<label class="form-label">建立日期：</label> <input type="text"
								class="form-control" name="startdate"
								value="${storeItem.startdate}" disabled="disabled">
						</div>
						<div class="col-md-6">
							<label class="form-label">名稱：</label> <input type="text"
								class="form-control" name="title" value="${storeItem.title}">
						</div>
						<div class="col-md-6">
							<label class="form-label">負責人：</label> <input type="text"
								class="form-control" name="manager" value="${storeItem.manager}">
						</div>
						<div class="col-md-6">
							<label class="form-label">聯絡電話：</label> <input type="text"
								class="form-control" name="tel" value="${storeItem.tel}">
						</div>
						<div class="col-md-6">
							<label class="form-label">地址：</label> <input type="text"
								class="form-control" name="stadd" value="${storeItem.stadd}">
						</div>
						<div class="mb-3">
							<label class="form-label">簡介：</label>
							<textarea class="form-control" id="" rows="3"
								style="resize: none" name="intro">${storeItem.intro}</textarea>
						</div>
							</form>
							
							<!-- 返回 -->
						<div class="col-12 myFormbtn">
							<button onclick="SEdit(${storeItem.storeid})" type="submit" class="btn btn-primary edbtn">確認更新</button>
							
							<c:if test="${ClassMember != 'gm'}">
							<button class="btn btn-secondary edbtn" onclick="BackSys()" type="submit" >取消返回</button>
							</c:if>
							
							<c:if test="${ClassMember == 'gm'}">
							<button class="btn btn-secondary edbtn" onclick="BackGm()" type="submit" >取消返回</button>
							</c:if>
							
							<!-- 返回系統管理首頁 -->
							<form id="BackSys" action="storeSystemAction.controller" method="post"></form>
							<form id="BackGm" action="storeManagerEntry.controller" method="post"></form>
						</div>
						
					</c:if>
					
			</main>
		</div>
	</div>
	<!--內文結束-->







	<!--匯入-->
	<!--引用jQuery-->
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>

<!-- 	<!--form匯入--> -->
<!-- 	<script src="form-validation.js"></script> -->
	<!--引用sweetalert-->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.1/dist/sweetalert2.all.min.js"></script>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp" %>


<script type="text/javascript">
<!-- sweetalert彈跳視窗 -->
function SEdit(id){
	Swal.fire({
		icon: 'success',
		title: '店家更新成功',
	    showConfirmButton: false,
		timer: 1000
		}).then((result) => {
       setTimeout(() => document.getElementById("SEdit").submit(), 200)
     })
}

function SAdd(){
	Swal.fire({
		icon: 'success',
		title: '店家新增成功',
	    showConfirmButton: false,
		timer: 1000
		}).then((result) => {
       setTimeout(() => document.getElementById("SAdd").submit(), 200)
     })
}

<!-- 取消返回 -->
function Back(){
	document.getElementById("backentry").submit()
}

function BackSys(){
	document.getElementById("BackSys").submit()
}

function BackGm(){
	document.getElementById("BackGm").submit()
}

<!-- 一鍵輸入 -->
function Input(){
	 document.getElementById("title").value='清新飲料店-測試用';
	 document.getElementById("manager").value='王店長';
	 document.getElementById("tel").value='02-24252365';
	 document.getElementById("stadd").value='基隆市中正區義二路27號';
	 document.getElementById("intro").innerHTML='廟口熱門店家';
}


//即時顯示圖片
$("#formFile").change(function() {
	var readFile = new FileReader();
	var mfile = $("#formFile")[0].files[0];
	readFile.readAsDataURL(mfile);
	readFile.onload = function() {
		var img = $("#upimg");
		img.attr("src", this.result);
	}
});

</script>
	
</body>
</html>