<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberManager</title>
<!--bootstrape匯入-->
<!-- <link -->
<!-- 	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" -->
<!-- 	rel="stylesheet" -->
<!-- 	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" -->
<!-- 	crossorigin="anonymous"> -->

<!--自己的CSS-->
<link rel="stylesheet" href="store/css/index.css">
<!-- Bootstrap CSS 樣式(配合 Bootstrap) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

<!-- datatables css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.0/css/dataTables.bootstrap5.min.css" />
<%@ include file="/WEB-INF/websiteForm/backWebsiteHead.jsp"%>

</head>
<body>
	<%@ include file="/WEB-INF/websiteForm/backWebsiteBody1.jsp"%>

	<!-- 提示訊息 -->
	<h4 class="msg">${msg}</h4>
	<h4 class="msgWorng">${errors}</h4>

	<div>
	
	</div>

	<nav>
		<div class="nav nav-tabs" id="nav-tab" role="tablist">
			<button class="nav-link active" id="nav-home-tab"
				data-bs-toggle="tab" data-bs-target="#nav-home" type="button"
				role="tab" aria-controls="nav-home" aria-selected="true">所有會員</button>
				
			<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab"
				data-bs-target="#nav-profile" type="button" role="tab"
				aria-controls="nav-profile" aria-selected="false">一般會員</button>
				
			<button class="nav-link" id="nav-profile-tab1" data-bs-toggle="tab"
				data-bs-target="#nav-profile1" type="button" role="tab"
				aria-controls="nav-profile1" aria-selected="false">企業會員</button>
				
			<button class="nav-link" id="nav-profile-tab2" data-bs-toggle="tab"
				data-bs-target="#nav-profile2" type="button" role="tab"
				aria-controls="nav-profile2" aria-selected="false">停權會員</button>
		</div>
	</nav>
	<div class="tab-content" id="nav-tabContent">
		
		<!-- 所有會員 -->
		<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
			<!-- datatables -->
			<div class="card-body">
				<table id="datatablesSimple" class="table table-striped" style="width: 100%">
					<thead>
						<tr>
							<th scope="col">帳號</th>
							<th scope="col">會員類別</th>
							<th scope="col">姓名</th>
							<th scope="col">統一編號</th>
							<th scope="col">生日</th>
							<th scope="col">廠商名稱</th>
							<th scope="col">負責人</th>
							<th scope="col">地址</th>
							<th scope="col">Email</th>
							<th scope="col">編輯</th>
							<!-- 
							<th>刪除</th>
							 -->
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${memList}" var="mem">
							<tr>
								<td>${mem.userID}</td>
								
								<c:if test="${mem.classMember == 'a'}">
									<td>一般</td>
								</c:if>
								<c:if test="${mem.classMember == 'fa'}">
									<td>一般(忘記密碼未修改)</td>
								</c:if>
								<c:if test="${mem.classMember == 'b'}">
									<td>企業</td>
								</c:if>
								<c:if test="${mem.classMember == 'fb'}">
									<td>企業(忘記密碼未修改)</td>
								</c:if>
								<c:if test="${mem.classMember == 'stop_a' || mem.classMember == 'stop_fa'}">
									<td style="color:red">一般(停權)</td>
								</c:if>
								<c:if test="${mem.classMember == 'stop_b' || mem.classMember == 'stop_fb'}">
									<td style="color:red">企業(停權)</td>
								</c:if>
								<c:if test="${mem.classMember == 'gg' || mem.classMember == 'ga'|| mem.classMember == 'gb'|| mem.classMember == 'gab'}">
									<td>Google登入</td>
								</c:if>
								<c:if test="${mem.classMember == 'stop_ga' || mem.classMember == 'stop_gb'|| mem.classMember == 'stop_gab'}">
									<td style="color:red">Google登入(停權)</td>
								</c:if>
								<td>${mem.name}</td>
								<td>${mem.vat}</td>
								<td>${mem.birthday}</td>
								<td>${mem.vendor}</td>
								<td>${mem.principal}</td>
								<td>${mem.address}</td>
								<td>${mem.email}</td>
								<td>
									<form action="editMemberManager" method="post">
										<input id="userID" type="hidden" name="userID" value="${mem.userID}">
										<input id="myedit" class="imbtn2 myedit" type="image" alt="this slowpoke moves" src="newMemberCss/img/icons8-1.png">
									</form>
								</td>
								<!-- 
								<td>
									<form action="#" method="post">
										<input type="hidden" name="imbtn" value="${mem.userID}">
										<input id="mydelete" class="imbtn2 mydelete" type="image" src="store/delete.png"	>
									</form>
								</td>
								 -->
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

		</div>

		<!-- 一般會員 -->
		<div class="tab-pane fade" id="nav-profile" role="tabpanel"	aria-labelledby="nav-profile-tab">
			<!-- datatables -->
			<div class="card-body">
				<table id="datatablesSimple1" class="table table-striped" style="width: 100%">
					<thead>
						<tr>
							<th scope="col">帳號</th>
							<th scope="col">會員類別</th>
							<th scope="col">姓名</th>
							<th scope="col">生日</th>
							<th scope="col">Email</th>
							<th scope="col">編輯</th>
							<!-- 
							<th>刪除</th>
							 -->
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${memList}" var="mem">
							<c:if test="${mem.classMember == 'a' || mem.classMember == 'fa' || mem.classMember == 'stop_a' || mem.classMember == 'stop_fa'}">
							<tr>
								<td>${mem.userID}</td>
								<c:if test="${mem.classMember == 'a'}">
									<td>一般</td>
								</c:if>
								<c:if test="${mem.classMember == 'fa'}">
									<td>一般<br>(忘記密碼未修改)</td>
								</c:if>
								<c:if test="${mem.classMember == 'stop_a' || mem.classMember == 'stop_fa'}">
									<td style="color:red">一般(停權)</td>
								</c:if>
								<c:if test="${mem.classMember == 'gg' || mem.classMember == 'ga'}">
									<td>Google登入</td>
								</c:if>
								<c:if test="${mem.classMember == 'stop_ga' || mem.classMember == 'stop_gab'}">
									<td style="color:red">Google登入(停權)</td>
								</c:if>
								<td>${mem.name}</td>
								<td>${mem.birthday}</td>
								<td>${mem.email}</td>
								<td>
									<form action="editMemberManager" method="post">
										<input type="hidden" name="userID" value="${mem.userID}">
										<input id="myedit" class="imbtn2 myedit" type="image" src="newMemberCss/img/icons8-1.png">
									</form>
								</td>
								<!-- 
								<td>
									<form action="#" method="post">
										<input type="hidden" name="imbtn" value="${mem.userID}">
										<input id="mydelete" class="imbtn2 mydelete" type="image" src="store/delete.png"	>
									</form>
								</td>
								 -->
							</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- 企業會員 -->
		<div class="tab-pane fade" id="nav-profile1" role="tabpanel" aria-labelledby="nav-profile-tab1">
			<!-- datatables -->
			<div class="card-body">
				<table id="datatablesSimple2" class="table table-striped" style="width: 100%">
					<thead>
						<tr>
							<th scope="col">帳號</th>
							<th scope="col">會員類別</th>
							<th scope="col">統一編號</th>
							<th scope="col">廠商名稱</th>
							<th scope="col">負責人</th>
							<th scope="col">地址</th>
							<th scope="col">Email</th>
							<th scope="col">編輯</th>
							<!-- 
							<th>刪除</th>
							 -->
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${memList}" var="mem">
							<c:if test="${mem.classMember == 'b' || mem.classMember == 'fb' || mem.classMember == 'stop_b' || mem.classMember == 'stop_fb'}">
							<tr>
								<td>${mem.userID}</td>
								<c:if test="${mem.classMember == 'b'}">
									<td>企業</td>
								</c:if>
								<c:if test="${mem.classMember == 'fb'}">
									<td>企業(忘記密碼未修改)</td>
								</c:if>
								<c:if test="${mem.classMember == 'stop_b' || mem.classMember == 'stop_fb'}">
									<td style="color:red">企業(停權)</td>
								</c:if>
								<c:if test="${mem.classMember == 'gg' || mem.classMember == 'gb'}">
									<td>Google登入</td>
								</c:if>
								<c:if test="${mem.classMember == 'stop_gb' || mem.classMember == 'stop_gab'}">
									<td style="color:red">Google登入(停權)</td>
								</c:if>
								<td>${mem.vat}</td>
								<td>${mem.vendor}</td>
								<td>${mem.principal}</td>
								<td>${mem.address}</td>
								<td>${mem.email}</td>
								
								<td>
									<form action="editMemberManager" method="post">
										<input type="hidden" name="userID" value="${mem.userID}">
										<input id="myedit" class="imbtn2 myedit" type="image" src="newMemberCss/img/icons8-1.png">
									</form>
								</td>
								<!-- 
								<td>
									<form action="#" method="post">
										<input type="hidden" name="imbtn" value="${mem.userID}">
										<input id="mydelete" class="imbtn2 mydelete" type="image" src="store/delete.png"	>
									</form>
								</td>
								 -->
							</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- 停權會員 -->
		<div class="tab-pane fade" id="nav-profile2" role="tabpanel" aria-labelledby="nav-profile-tab2">
			<!-- datatables -->
			<div class="card-body">
				<table id="datatablesSimple3" class="table table-striped" style="width: 100%">
					<thead>
						<tr>
							<th scope="col">帳號</th>
							<th scope="col">會員類別</th>
							<th scope="col">姓名</th>
							<th scope="col">統一編號</th>
							<th scope="col">生日</th>
							<th scope="col">廠商名稱</th>
							<th scope="col">負責人</th>
							<th scope="col">地址</th>
							<th scope="col">Email</th>
							<th scope="col">編輯</th>
							<!-- 
							<th>刪除</th>
							 -->
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${memList}" var="mem">
							<tr>
							
								
								<c:if test="${mem.classMember == 'stop_a' || mem.classMember == 'stop_fa'}">
								
									<td>${mem.userID}</td>
									<td style="color:red">一般(停權)</td>
									<td>${mem.name}</td>
									<td>${mem.vat}</td>
									<td>${mem.birthday}</td>
									<td>${mem.vendor}</td>
									<td>${mem.principal}</td>
									<td>${mem.address}</td>
									<td>${mem.email}</td>
									
									<td>
										<form action="editMemberManager" method="post">
											<input id="userID" type="hidden" name="userID" value="${mem.userID}">
											<input id="myedit" class="imbtn2 myedit" type="image" alt="this slowpoke moves" src="newMemberCss/img/icons8-1.png">
										</form>
									</td>
								</c:if>
								
								<c:if test="${mem.classMember == 'stop_b' || mem.classMember == 'stop_fb'}">
									<td>${mem.userID}</td>
									<td style="color:red">企業(停權)</td>
									<td>${mem.name}</td>
									<td>${mem.vat}</td>
									<td>${mem.birthday}</td>
									<td>${mem.vendor}</td>
									<td>${mem.principal}</td>
									<td>${mem.address}</td>
									<td>${mem.email}</td>
									
									<td>
										<form action="editMemberManager" method="post">
											<input id="userID" type="hidden" name="userID" value="${mem.userID}">
											<input id="myedit" class="imbtn2 myedit" type="image" alt="this slowpoke moves" src="newMemberCss/img/icons8-1.png">
										</form>
									</td>
								</c:if>
								
								<c:if test="${mem.classMember == 'stop_ga' || mem.classMember == 'stop_gb'|| mem.classMember == 'stop_gab'}">
									<td>${mem.userID}</td>
									<td style="color:red">Google登入(停權)</td>
									<td>${mem.name}</td>
									<td>${mem.vat}</td>
									<td>${mem.birthday}</td>
									<td>${mem.vendor}</td>
									<td>${mem.principal}</td>
									<td>${mem.address}</td>
									<td>${mem.email}</td>
									
									<td>
										<form action="editMemberManager" method="post">
											<input id="userID" type="hidden" name="userID" value="${mem.userID}">
											<input id="myedit" class="imbtn2 myedit" type="image" alt="this slowpoke moves" src="newMemberCss/img/icons8-1.png">
										</form>
									</td>
								</c:if>
								
								
								<!-- 
								<td>
									<form action="#" method="post">
										<input type="hidden" name="imbtn" value="${mem.userID}">
										<input id="mydelete" class="imbtn2 mydelete" type="image" src="store/delete.png"	>
									</form>
								</td>
								 -->
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

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
	<!-- 往下放會看不到datatables -->
	<%@ include file="/WEB-INF/websiteForm/backWebsiteBody2.jsp"%>
	<!--引用dataTables.js(一定要放置最下面)-->
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/dataTables.bootstrap5.min.js"></script>
		
	<script type="text/javascript">

	$(function () {
		$( ".myedit" ).mouseover(function() {
			 $(this).attr("src","newMemberCss/img/icons8-2.gif");
			});
		$( ".myedit" ).mouseout(function() {
			$(this).attr("src","newMemberCss/img/icons8-1.png");
			});
		});	
	
	</script>

	<script type="text/javascript">

	$(function () {
		$.ajax({
			type : 'post',
			url : 'MemberManagerAll',
			success : function(req) {
				//console.log("ss",req)
			},error :function(){
				console.log("er")
			}
		})
	
	});
	$(document)	.ready(	function() {
		
		//所有會員Table
		$('#datatablesSimple').DataTable({
			//欄位內部設定
			columnDefs : [{ //垂直置中
				targets : '_all',
				createdCell : function(td,cellData,rowData,row, col) {
					$(td).css('vertical-align','middle');
				}
			},{ //水平置中
			targets : '_all',
			className : 'text-center'
			},
			{
			"orderable" : false,
			"targets" : 9
			//第10列取消排序功能
			}
			],

			//屬性區塊,
			lengthMenu : [[ 10, 25, 50, -1 ],[ "10筆", "25筆", "50筆","全部資料" ] ], //[顯示多少頁面,顯示在table的方式]
			//語言區塊(language),
			language : {"lengthMenu" : "顯示 _MENU_ 資料",
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
			
			//一般會員Table
			$('#datatablesSimple1').DataTable({
				//欄位內部設定
				columnDefs : [{ //垂直置中
					targets : '_all',
					createdCell : function(td,cellData,rowData,row, col) {
						$(td).css('vertical-align','middle');
					}
				},{ //水平置中
				targets : '_all',
				className : 'text-center'
				},
				{
				"orderable" : false,
				"targets" : 5
				//第6列取消排序功能
				}
				],

				//屬性區塊,
				lengthMenu : [[ 10, 25, 50, -1 ],[ "10筆", "25筆", "50筆","全部資料" ] ], //[顯示多少頁面,顯示在table的方式]
				//語言區塊(language),
				language : {"lengthMenu" : "顯示 _MENU_ 資料",
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
			
			//企業會員Table
			$('#datatablesSimple2').DataTable({
				//欄位內部設定
				columnDefs : [{ //垂直置中
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
				"targets" : 7
				//第8列取消排序功能
				}
				],
				//屬性區塊,
				lengthMenu : [[ 10, 25, 50, -1 ],[ "10筆", "25筆", "50筆","全部資料" ] ], //[顯示多少頁面,顯示在table的方式]
				//語言區塊(language),
				language : {"lengthMenu" : "顯示 _MENU_ 資料",
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
			
			//停權會員Table
			$('#datatablesSimple3').DataTable({
				//欄位內部設定
				columnDefs : [{ //垂直置中
					targets : '_all',
					createdCell : function(td,cellData,rowData,row, col) {
						$(td).css('vertical-align','middle');
					}
				},{ //水平置中
				targets : '_all',
				className : 'text-center'
				},
				{
				"orderable" : false,
				"targets" : 9
				//第10列取消排序功能
				}
				],

				//屬性區塊,
				lengthMenu : [[ 10, 25, 50, -1 ],[ "10筆", "25筆", "50筆","全部資料" ] ], //[顯示多少頁面,顯示在table的方式]
				//語言區塊(language),
				language : {"lengthMenu" : "顯示 _MENU_ 資料",
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
	function datatable() {
		
		
	};
	</script>
</body>
</html>