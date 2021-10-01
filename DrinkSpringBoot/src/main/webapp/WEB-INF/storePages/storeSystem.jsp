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

<!-- datatables css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.0/css/dataTables.bootstrap5.min.css" />

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

			<h1 class="myFirstTitle">資訊編輯及產品上架</h1>
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

		<!--內文_店家欄位-->
		<div class="bd-example mytable1">
			<table class="table table-sm table-bordered mytable1">
				<thead>
					<tr>
						<th scope="col">ID</th>
						<th scope="col">建立日期</th>
						<th scope="col">店家封面</th>
						<th scope="col">店家名稱</th>
						<th scope="col">負責人</th>
						<th scope="col">聯絡電話</th>
						<th scope="col">地址</th>
						<th scope="col">簡介</th>
						<th scope="col">編輯</th>
						<th scope="col">刪除</th>
					</tr>
				</thead>
				<tbody>
				
					<tr>
						<td class="mytd">${storeItem.storeid}</td>
						<td class="mytd">${storeItem.startdate}</td>
					
						<c:if test="${empty fn:trim(storeItem.photo)}">
							<td class="myimageTable"><img class="myimage"
								src="store/NoItem.jpg" alt=""></td>
						</c:if>
						<c:if test="${storeItem.photo != null}">
							<td class="myimageTable"><img class="myimage"
								src="<%=request.getContextPath()%>/StoreIMG/${storeItem.storeid}"
								alt=""></td>
						</c:if>
						
						
						<td class="mytd">${storeItem.title}</td>
						<td class="mytd">${storeItem.manager}</td>
						<td class="mytd">${storeItem.tel}</td>
						<td class="mytd">${storeItem.stadd}</td>
						<td class="mytd myintro">${storeItem.intro}</td>
						
						<td class="mytd myicon" style="width:80px">
							<form action="storeEditNInsertEntry.controller" method="post">
								<input type="hidden" name="imbtn" value="${storeItem.storeid}">
								<input class="imbtn myedit" type="image" src="store/edit.png" >
							</form>
						</td>
						<td class="mytd myicon" style="width:80px">
							<form id="delete${storeItem.storeid}" action="storeDeleteEntry.controller" method="post">
								<input type="hidden" name="imbtn" value="${storeItem.storeid}">
							</form>
							<button class="mybutton"  onclick="Sdelete(${storeItem.storeid})"><img class="imbtn mydelete" src="store/delete.png"></button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>


		<!--產品抬頭-->
		<h2 class="myStitle">產品資訊</h2>
		<form action="productInsertEntry.controller" method="get">
		<input type="submit" class="btn btn-outline-success" style="margin-left: 93%;"  value="產品新增"/>
		</form>
		<hr class="myhr">
		<!--內文_產品欄位-->

<!-- datatables -->
		<div class="card-body">
			<table id="datatablesSimple" class="table table-striped">
				<thead>
					<tr>
						<th scope="col">ID</th>
						<th scope="col">建立日期</th>
						<th scope="col">產品封面</th>
						<th scope="col">名稱</th>
						<th scope="col">售價</th>
						<th scope="col">分類標籤</th>
						<th scope="col">簡介</th>
						<th scope="col">編輯</th>
						<th scope="col">刪除</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${productLists}" var="product">
						<tr>
						<td class="mytd">${product.proid}</td>
						<td class="mytd">${product.pstartdate}</td>
							<c:if test="${empty fn:trim(product.pphoto)}">
								<td class="myimageTable"><img class="myimage" src="store/NoItem.jpg" alt=""></td>
							</c:if>
							<c:if test="${product.pphoto != null}">
								<td class="myimageTable">
								<img class="myimage" src="<%=request.getContextPath()%>/ProductIMG/${product.pstoreid}${product.proid}" alt=""></td>
							</c:if>
							
							
						
							<td class="mytd">${product.proname}</td>
							<td class="mytd">${product.proprice}</td>
							<td class="mytd">${product.category}</td>
							<td class="mytd myintro">${product.pintro}</td>
							<td class="mytd myicon " style="width:80px">
								<form action="productEditNInsertEntry.controller" method="post">
									<input type="hidden" name="adproid" value="${product.proid}"> 
									<input class="imbtn myedit proedit" type="image" src="store/edit.png">
								</form>
							</td>
							<td class="mytd myicon" style="width:80px">
								<form id="delete${product.proid}" action="productDeleteAction.controller" method="post">
									<input type="hidden" name="deproid" value="${product.proid}"> 
								</form>
									<button class="mybutton"  onclick="Pdelete(${product.proid})"><img class="imbtn mydelete" src="store/delete.png"></button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		</div>
		<!--內文結束-->

		<!-- icon滑入及滑出 -->
		<script>
			
		</script>

		<!--匯入-->
		
		
	   <!--引用jQuery-->
	   <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
		<!--bootstrap匯入-->
		<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
			integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
			crossorigin="anonymous"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
			integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
			crossorigin="anonymous"></script>

		<!--引用sweetalert-->
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.1/dist/sweetalert2.all.min.js"></script>

<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp" %>
	
		<!--引用dataTables.js(一定要放置最下面)-->
		<script type="text/javascript" src="https://cdn.datatables.net/1.11.0/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="https://cdn.datatables.net/1.11.0/js/dataTables.bootstrap5.min.js"></script>

<!-- sweetalert彈跳視窗 -->
<script type="text/javascript">

function Sdelete(id){
	Swal.fire({
		title: '確定刪除店家?',
        text: "刪除店家將會連同產品一起刪除!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '刪除',
        cancelButtonText: '取消'
		}).then((result) => {
	         if (result.isConfirmed) {
	             Swal.fire({
	              icon: 'success',
	              title: '刪除成功',
	              showConfirmButton: false,
	              timer: 1500
	            }) 
	            
	            setTimeout(() => document.getElementById("delete"+id).submit(), 1500)
	            }
	          })
	        }

function Pdelete(id){
	Swal.fire({
		title: '確定刪除?',
        text: "資料將無法復原!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '刪除',
        cancelButtonText: '取消'
		}).then((result) => {
	         if (result.isConfirmed) {
	             Swal.fire({
	              icon: 'success',
	              title: '刪除成功',
	              showConfirmButton: false,
	              timer: 1500
	            }) 
	            setTimeout(() => document.getElementById("delete"+id).submit(), 1500)
	            }
	          })
	        }
</script>

<!-- icon滑入滑出 -->
<script type="text/javascript">
	$(function () {
	$( ".myedit" ).mouseover(function() {
		 $(this).attr("src","store/01edit.png");
		});
	$( ".myedit" ).mouseout(function() {
		$(this).attr("src","store/edit.png");
		});
	$( ".mydelete" ).mouseover(function() {
		$(this).attr("src","store/01delete.png");
		});
	$( ".mydelete" ).mouseout(function() {
		$(this).attr("src","store/delete.png");
		});	
	});
	
</script>


<!-- 產品datatables -->
<script type="text/javascript">
	$(document)	.ready(	function() {
		
		//店家table
		$('#datatablesSimple').DataTable(
						{
							//欄位內部設定
							columnDefs : [{ //垂直置中
										targets : '_all',
										createdCell : function(
												td,cellData,rowData,row, col) {
											$(td).css(		'vertical-align',
															'middle');
										}
									},

									{ //水平置中
										targets : '_all',
										className : 'text-center'
									},
									{
										"orderable" : false,
										"targets" : 7
									//第8列取消排序功能
									},
									{
										"orderable" : false,
										"targets" : 8
									} //第9列取消排序功能
							],

							//屬性區塊,
							lengthMenu : [
									[ 10, 25, 50, -1 ],
									[ "10筆", "25筆", "50筆",
											"全部資料" ] ], //[顯示多少頁面,顯示在table的方式]
							//語言區塊(language),
							language : {
								"lengthMenu" : "顯示 _MENU_ 資料",
								"sZeroRecords" : "無查詢結果",
								"sInfo" : "目前有 _MAX_ 筆資料",
								"sSearch" : "關鍵字搜尋:",
								"sEmptyTable" : "尚有資料紀錄存在",
								"oPaginate" : {
									"sFirst" : "首頁",
									"sPrevious" : "上一頁",
									"sNext" : "下一頁",
									"sLast" : "末頁"
								}
							},
						});
	});
</script>		

</body>
</html>