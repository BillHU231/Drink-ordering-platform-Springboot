<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" 
	import="java.util.ArrayList" 
    import="java.util.List" 
    import="tw.drink.activity.model.ActivityBean" 
    import="tw.drink.activity.model.ActivityDiscountItem" 
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Activity Backstage</title>
	
	<!-- datatables css -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" />
	<link rel="stylesheet"
		href="https://cdn.datatables.net/1.11.0/css/dataTables.bootstrap5.min.css" />
	
	<!-- 自己的 CSS -->
	<style>
		.backACImage{
			max-width: 80px;
		}
		.backACDeleteBtnImg{
			width: 25px;
		}
	</style>
	
	<!-- 後臺套版 -->
	<%@ include file="/WEB-INF/websiteForm/backWebsiteHead.jsp" %>

</head>
<body>

	<!-- 後臺套版 -->
	<%@ include file="/WEB-INF/websiteForm/backWebsiteBody1.jsp"%>
	
	<!-- 提示訊息 -->
	<h4 class="msg" style="margin-top:30px;">${msg}</h4>
	<h4 class="msgWorng">${errors}</h4>
 	

	<nav>
		<div class="nav nav-tabs " id="nav-tab" role="tablist">
			<button class="nav-link active gmtab" id="nav-home-tab"
				data-bs-toggle="tab" data-bs-target="#nav-home" type="button"
				role="tab" aria-controls="nav-home" aria-selected="true">活動總覽</button>
			<!-- 
			<button class="nav-link gmtab" id="nav-profile-tab" data-bs-toggle="tab"
				data-bs-target="#nav-profile" type="button" role="tab"
				aria-controls="nav-profile" aria-selected="false">產品資料</button>
				
			-->
		</div>
	</nav>
	<div class="tab-content" id="nav-tabContent">
		
		<!-- 店家頁籤 -->
		<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
			<!-- datatables -->			
			<div class="card-body mytable2">
				<table id="datatablesSimple" class="table table-striped" style="width: 100%">
					<thead>
						<tr>
							<th style="width: 10%;">限時特價活動ID</th>
							<th style="width: 7%;">所屬店家ID</th>
							<th style="width: 10%;">特價主題</th>
							<th>主題圖片</th>
							<th style="width: 10%;">開始時間</th>
							<th style="width: 10%;">結束時間</th>
							<th style="width: 20%;">特價內容</th>
							<th style="width: 15%;">產品項目</th>
							<th>刪除</th>
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${allActivityForBack}" var="ActivityBean">
							<tr>

								<td>${ActivityBean.activityId}</td>
								<td>${ActivityBean.pstoreid}</td>
								<td>${ActivityBean.activityTopic}</td>

								<c:if test="${empty fn:trim(ActivityBean.activityImg)}">
									<td><img class="backACImage" src="homePageStyleAndJs/assets/img/onDrinkImg.jpg" alt=""></td>
								</c:if>
								<c:if test="${ActivityBean.activityImg != null}">
									<td><img class="backACImage" src="<%=request.getContextPath()%>/avtivityIMG/activity${ActivityBean.activityId}.png" alt=""></td>
								</c:if>

								<td>${ActivityBean.startTime}</td>
								<td>${ActivityBean.endTime}</td>
								
								<td>${ActivityBean.activityContent}</td>
								<td>
								
									<c:forEach items="${allActivityDiscountItemForBack}" var="ActivityDiscountItem">
										<c:if test="${ActivityBean.activityId == ActivityDiscountItem.activityId}" >
		    					
				    						<span>${ActivityDiscountItem.proName}</span><span>	</span>
				    						
				    					</c:if>
									</c:forEach>
								
								</td>
								<td class="mytd myicon">
									<form id="deleteActivity${ActivityBean.activityId}" action="toBackDeleteActivity.controller" method="post" >
										<input type="hidden" name=activityDeleteId value="${ActivityBean.activityId}">
									</form>
										<button class="mybutton"  onclick="ACdelete(${ActivityBean.activityId})"><img class="backACDeleteBtnImg mydelete" src="store/delete.png"></button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	
	<!---------------- 匯入 ------------------------>

	<!--bootstrap匯入-->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
		
	<!--引用jQuery-->
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<!-- include往下放會看不到datatables效果 -->
	
	<!--引用sweetalert-->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.1/dist/sweetalert2.all.min.js"></script>
	
	<!-- 後臺套版 -->
	<%@ include file="/WEB-INF/websiteForm/backWebsiteBody2.jsp"%>
	
	<!--引用dataTables.js(一定要放置最下面)-->
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/dataTables.bootstrap5.min.js"></script>

	<!-- sweetalert彈跳視窗 -->
	
	<script type="text/javascript">
	
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
			
			$( ".mydelete" ).mouseover(function() {
				$(this).attr("src","store/01delete.png");
				});
			$( ".mydelete" ).mouseout(function() {
				$(this).attr("src","store/delete.png");
				});	
		});
		
	</script>
	
	
	<!-- Data 設定-->
	<script type="text/javascript">
	$(document)	.ready(	function() {
		
		//店家table
		$('#datatablesSimple').DataTable(
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
									}
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