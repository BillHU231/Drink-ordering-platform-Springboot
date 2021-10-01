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

<!-- <!--form匯入--> -->
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
	<!--標題開始-->
	<div class="position-relative text-center overflow-hidden" style="width:98%; height:500px ;margin:10px auto 0px auto; background:url(store/indeximg.jpg);background:rgba(205,205,205,0.5) ; border-radius: 4px 4px 10px 10px;">
		<!--titleImage-->
		<div class="col-md-5 p-lg-5 mx-auto my-5" style="width:99%">

			<h1 class="myFirstTitle">產品資訊新增及編輯</h1>
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
	<!--標題結束-->


	<!--內文開始-->
	<div class="mycontainer">


		<!--店家抬頭-->
		<h2 class="myStitle">產品資訊</h2>
		<hr class="myhr">



		<!--店家編輯欄位-->
		<div class="container">
			<main>

					<!-- 第一次新增 -->
						<c:if test="${pID == null}">

						<form id="PAdd" class="row g-3" action="productInsertAction.controller" modelAttribute="productItem"	method="post" enctype="multipart/form-data">
						<!-- 店家封面 -->
						<label class="form-label">產品封面：</label>
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
							<input id="proname" type="text" class="form-control" name="proname" >
						</div>
						<div class="col-md-6">
							<label class="form-label">售價：</label> 
							<input id="proprice" type="text" class="form-control" name="proprice">
						</div>
						<div class="col-12">
							<label class="form-label">分類標籤：</label> 
						<input id="category" name="category" class="form-control" list="datalistOptions"  autocomplete="off" placeholder="可使用下拉式選單，直接輸入可新增">
							
							<datalist id="datalistOptions">
							<c:forEach items="${tags}" var="tag">
  									<option value="${tag}">
							</c:forEach>
								</datalist>
						</div>
						<div class="mb-3">
							<label class="form-label">簡介：</label>
							<textarea  id="pintro" class="form-control" rows="3" style="resize: none" name="pintro"></textarea>
						</div>
						</form>
						<div class="col-12 myFormbtn">
							<button onclick="PAdd()" type="submit" class="btn btn-primary edbtn">確認更新</button>
							<button class="btn btn-secondary edbtn" onclick="BackSys()" type="submit" >取消返回</button>
							<button class="btn btn-info edbtn" onclick="Input()" type="submit" >一鍵輸入</button>
							<form id="BackSys" action="storeSystemAction.controller" method="post"></form>
						</div>
					</c:if>



					<!-- 新增過要編輯 -->

					<c:if test="${pID != null}">
					<form id="PEdit" class="row g-3" action="productEditAction.controller" modelAttribute="productItem"	method="post" enctype="multipart/form-data">
						<!-- 店家封面 -->

						<!-- 店家封面 -->
						<label class="form-label">產品封面：</label>
						<div class="text-center">
							
							<!-- 圖片 -->
							<c:if test="${empty fn:trim(product.pphoto)}">
							<img id="upimg"  class="d-block mx-auto mb-4 myFormImage" src="store/NoItem.jpg">
							</c:if>
							<c:if test="${product.pphoto != null}">
							<img id="upimg"  class="d-block mx-auto mb-4 myFormImage" src="<%=request.getContextPath()%>/ProductIMG/${product.pstoreid}${product.proid}">
							</c:if>
							
							<div class="mb-3">
								<input class="form-control" type="file" id="formFile" name="photo">
							</div>
						</div>
						
						
						<div class="col-md-6">
							<label class="form-label">ID號碼：</label>
							<input type="text" class="form-control" name="proid"  value="${product.proid}" disabled="disabled">
						</div>
						<div class="col-md-6">
							<label class="form-label">建立日期：</label>
							<input type="text" class="form-control" name="pstartdate"  value="${product.pstartdate}" disabled="disabled">
						</div>
						<div class="col-md-6">
							<label class="form-label">名稱：</label> 
							<input type="text" class="form-control" name="proname"  value="${product.proname}">
						</div>
						<div class="col-md-6">
							<label class="form-label">售價：</label> 
							<input type="text" class="form-control" name="proprice" value="${product.proprice}">
						</div>
						<div class="col-12">
							<label class="form-label">分類標籤：</label> 
							<input id="category" name="category" class="form-control" list="datalistOptions" autocomplete="off" value="${product.category}"  placeholder="可使用下拉式選單選取已建檔的標籤，或是直接輸入可執行新增">
							
							<datalist id="datalistOptions">
							<c:forEach items="${tags}" var="tag">
  									<option value="${tag}">
							</c:forEach>
								</datalist>
						</div>
<%-- 							
<input  type="text" class="form-control" name="category" value="${product.category}"> --%>
<!-- 							<div id="info-lists"></div> -->
							
						<div class="mb-3">
							<label class="form-label">簡介：</label>
							<textarea class="form-control" id="" rows="3" style="resize: none" name="pintro">${product.pintro}</textarea>
						</div>
				</form>
						<div class="col-12 myFormbtn">
							<button onclick="PEdit(${product.proid})" type="submit" class="btn btn-primary edbtn">確認更新</button>
							
							<!-- 返回鍵 -->
							<c:if test="${ClassMember != 'gm'}">
							<button class="btn btn-secondary edbtn" onclick="BackSys()" type="submit" >取消返回</button>
							</c:if>
							
							<c:if test="${ClassMember == 'gm'}">
							<button class="btn btn-secondary edbtn" onclick="BackGm()" type="submit" >取消返回</button>
							</c:if>
							
							<form id="BackSys" action="storeSystemAction.controller" method="post"></form>
							<form id="BackGm" action="storeManagerEntry.controller" method="post"></form>
						</div>
					</c:if>
			</main>
		</div>
	</div>
	<!--內文結束-->







	<!--匯入-->
	<!-- 引入Ajax -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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

	<!--form匯入-->
<!-- 	<script src="form-validation.js"></script> -->
	<!--引用sweetalert-->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.1/dist/sweetalert2.all.min.js"></script>

<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp" %>

<script type="text/javascript">
<!-- sweetalert彈跳視窗 -->
function PEdit(id){
	Swal.fire({
		icon: 'success',
		title: '產品更新成功',
	    showConfirmButton: false,
		timer: 1000
		}).then((result) => {
       setTimeout(() => document.getElementById("PEdit").submit(), 200)
     })
}

function PAdd(){
	Swal.fire({
		icon: 'success',
		title: '產品新增成功',
	    showConfirmButton: false,
		timer: 1000
		}).then((result) => {
       setTimeout(() => document.getElementById("PAdd").submit(), 200)
     })
}

<!-- 返回鍵 -->
function BackSys(){
	document.getElementById("BackSys").submit()
}

function BackGm(){
	document.getElementById("BackGm").submit()
}

<!-- 一鍵輸入 -->
function Input(){
	document.getElementById("proname").value='焦糖瑪奇朵-測試用';
    document.getElementById("proprice").value=150;
	document.getElementById("category").value='咖啡';
	document.getElementById("pintro").innerHTML='融合優質鮮奶及香草風味糖漿後，倒入濃縮咖啡並在牛奶上覆以香甜焦糖醬，呈現多層次風味，深受歡迎的飲料。';
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


<!-- tag回傳(ajax)模糊查詢、暫時停用 -->
<!-- <script type="text/javascript">
	$(document).ready(function(){
		$("#category").keyup(function(){
			$.ajax({
				type: "POST",
				url: "tagReader.controller",
				data:'keyword=' + $(this).val(),
				success: 
					function(data){
						var json = JSON.stringify(data, null, 4);
						var parsedObjinArray = JSON.parse(json);
						console.log(parsedObjinArray);
						var result = "";
						$.each(parsedObjinArray,function(i,n){
							result = result + '<button type="button" class="btn btn-outline-dark tagbtn" id="aname"  onclick="list(' + "'" + n + "'" +')">#' + n + '</div>';
								});
						console.log('result=' + result);
						$("#info-lists").show();
						$("#info-lists").html(result);
			}
		});
	});
});
	function list(val) {
		$("#category").val(val);
		$("#info-lists").hide();
	}
	
</script> -->
</body>
</html>