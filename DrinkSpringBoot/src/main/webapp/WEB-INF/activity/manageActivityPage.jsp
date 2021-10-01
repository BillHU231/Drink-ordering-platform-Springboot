<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.List" import="tw.drink.activity.model.ActivityBean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<!-- Bootstrap 套版標籤有 -->

	<!--store的CSS-->
	<link rel="stylesheet" href="store/css/index.css">
	
	<!-- datatables css -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" />
	<link rel="stylesheet"
		href="https://cdn.datatables.net/1.11.0/css/dataTables.bootstrap5.min.css" />
	
	<meta charset="UTF-8">
	<title>Activity Manage System</title>
	
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp" %>
	
</head>
<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp" %>
	<!--標題開始-->
	<div class="position-relative text-center overflow-hidden" style="width:98%; height:500px ;margin:10px auto 0px auto;background:url(store/indeximg.jpg);background:rgba(205,205,205,0.5); border-radius: 4px 4px 10px 10px;">
		<!--titleImage-->
		<div class="col-md-5 p-lg-5 mx-auto my-5" style="width:99%">

			<h1 class="myFirstTitle">限時特價活動管理</h1>
			<div class="position-absolute top-0 end-0">
				<a class="btn btn-outline-secondary mybtn" href="storeSystemEntry.controller">返回分店首頁</a>
			</div>
		</div>
		<div class="position-absolute top-0 start-0">
			<p class="lead fw-normal">
				<!-- UserID、Vat: 登入系統參數，Session等級。 -->
				<span class="title2">企業帳號：${UserID}</span><span class="title2">公司統編：${Vat}</span>
			</p>
		</div>
	</div>
	
	
	


	<!--內文開始-->
	<div class="mycontainer">

		<!--產品抬頭-->
		<h2 class="myStitle">活動資訊</h2>
		<form action="addNewActivity.controller" method="get">
			<input type="submit" class="btn btn-outline-success" style="margin-left: 93%;"  value="新增活動"/>
		</form>
		<hr class="myhr">
		<!--內文_產品欄位-->

		<!-- datatables -->
		<div class="card-body">
			<table id="datatablesSimple" class="table table-striped">
				<thead>
					<tr>
						<th scope="col">ID</th>
						<th scope="col">活動標題</th>
						<th scope="col">產品封面</th>
						<th scope="col">開始時間</th>
						<th scope="col">結束時間</th>
						<th scope="col">活動簡介</th>
						<th scope="col">編輯</th>
						<th scope="col">刪除</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${allActivity}" var="activity">
						<tr>
							<td class="mytd">${activity.activityId}</td>
							<td class="mytd">${activity.activityTopic}</td>
							
							<c:if test="${empty fn:trim(activity.activityImg)}">
								<td class="myimageTable"><img class="myimage" src="store/NoItem.jpg" alt=""></td>
							</c:if>
							<c:if test="${activity.activityImg != null}">
								<td class="myimageTable">
								<img class="myimage" src="<%=request.getContextPath()%>/avtivityIMG/activity${activity.activityId}.png" alt=""></td>
							</c:if>
							
							<td class="mytd">${activity.startTime}</td>
							<td class="mytd">${activity.endTime}</td>
							<td class="mytd">${activity.activityContent}</td>
							
							<!-- 編輯按鈕 --><!-- 尚未更改 -->
							<td class="mytd myicon " style="width:80px">
							
								<form action="updateDiscountItem.controller" method="post">
									<input type="hidden" name="updateDiscountItemActivityId" value="${activity.activityId}"> 
									<button class="mybutton" type="submit"><img class="imbtn myedit" src="store/edit.png"></button>
								</form>
								
							</td>
							<!-- 刪除按鈕 --><!-- 尚未更改 -->
							<td class="mytd myicon" style="width:80px">
								<!--
								<form action="deleteActivity.controller" method="post">
									<input type="hidden" name="activityDeleteId" value="${activity.activityId}"> 
									<input class="imbtn myedit proedit" type="image" src="store/edit.png">
								</form>
								-->
								<!--
								<form id="delete${product.proid}" action="productDeleteAction.controller" method="post">
									<input type="hidden" name="deproid" value="${product.proid}"> 
								</form>
									<button class="mybutton"  onclick="Pdelete(${product.proid})"><img class="imbtn mydelete" src="store/delete.png"></button>
								-->
								<form id="deleteActivity${activity.activityId}" action="deleteActivity.controller" method="post">
									<input type="hidden" name=activityDeleteId value="${activity.activityId}"> 
								</form>
									<button class="mybutton"  onclick="ACdelete(${activity.activityId})"><img class="imbtn mydelete" src="store/delete.png"></button>
								
								
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		</div>

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

	<!-- sweetalert彈跳視窗 : 晚點啟用-->
	<script type="text/javascript">
	<!--
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
	-->
	
	function ACdelete(id){
		Swal.fire({
			title: '確定刪除活動?',
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
		            setTimeout(() => document.getElementById("deleteActivity"+id).submit(), 1500)
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
			$('#datatablesSimple').DataTable({
				//欄位內部設定
				columnDefs : [
					{ //垂直置中
						targets : '_all',
						createdCell : function(td,cellData,rowData,row, col) {
							$(td).css('vertical-align','middle');
						}
					},
					{ //水平置中
						targets : '_all',
						className : 'text-center'
					},
					{
						"orderable" : false,
						"targets" : 6
						// 修改: 第7列取消排序功能
					},
					{
						"orderable" : false,
						"targets" : 7
						// 修改:第8列取消排序功能
					} 
				],
	
				//屬性區塊,
				lengthMenu : [
					[ 10, 25, 50, -1 ],
					[ "10筆", "25筆", "50筆","全部資料" ] 
				], //[顯示多少頁面,顯示在table的方式]
				
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