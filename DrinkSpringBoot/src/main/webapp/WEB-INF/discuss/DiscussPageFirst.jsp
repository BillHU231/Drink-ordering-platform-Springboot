<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>評論區</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>
<style>
.but1 {
	text-align: right;
	border: 0;
	background-color: #ffa500;
	font-family: 'Kosugi Maru', sans-serif;
	/* 日文 */
	border-radius: 3px;
	padding: 2px;
}

.but1:hover {
	background-color: #ffffff;
	border: 0px #003C9D solid;
	font-family: 'Kosugi Maru', sans-serif;
	/* 日文 */
}
.down_div{
	padding:200px;
}
</style>
</head>

<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>
	<!-- datatables -->
	<div style="width:100% ;box-shadow:3px 3px 9px black; ">
			<div class="card-body">
				<table id="datatablesSimple" class="table" style="width: 100%;">
					<thead>
						<tr>
							<th >店家名稱</th>
							<th >飲料名</th>
							<th >評論</th>
							<th >星星</th>
							<th >編輯</th>
						</tr>
					</thead>
					<tbody class="tb">

						<c:forEach items="${DiscussUserIdFind}" var="distorename">
								<tr>
									<c:if test="${empty fn:trim(distorename.drinkDiscuss)}">
										<td>
										${distorename.title}
										</td>
									</c:if>
									<c:if test="${distorename.drinkDiscuss != null}">
										<td class="table-primary">
										${distorename.title}
										</td>
									</c:if>
									
									<c:if test="${empty fn:trim(distorename.drinkDiscuss)}">
										<td>
										${distorename.proname}
										</td>
									</c:if>
									<c:if test="${distorename.drinkDiscuss != null}">
										<td class="table-primary">
										${distorename.proname}
										</td>
									</c:if>
									
									
									<c:if test="${empty fn:trim(distorename.drinkDiscuss)}">
										<td>尚未評論</td>
									</c:if>
									<c:if test="${distorename.drinkDiscuss != null}">
										<td class="table-primary">
											${distorename.drinkDiscuss}
										</td>
									</c:if>
									
									<c:choose>
									<c:when test="${empty fn:trim(distorename.drinkstar)}">
										<td></td>
									</c:when>
									<c:when test="${distorename.drinkstar.equals('1')}">
										<td class="table-success">
										<img src="discuss/blackstar.png" alt="">
										</td>
									</c:when>
									<c:when test="${distorename.drinkstar.equals('2')}">
										<td class="table-success">
										<img src="discuss/blackstar.png" alt="">
										<img src="discuss/blackstar.png" alt="">
										</td>
									</c:when>
									<c:when test="${distorename.drinkstar.equals('3')}">
										<td class="table-success">
										<img src="discuss/blackstar.png" alt="">
										<img src="discuss/blackstar.png" alt="">
										<img src="discuss/blackstar.png" alt="">
										</td>
									</c:when>
									<c:when test="${distorename.drinkstar.equals('4')}">
										<td class="table-success">
										<img src="discuss/blackstar.png" alt="">
										<img src="discuss/blackstar.png" alt="">
										<img src="discuss/blackstar.png" alt="">
										<img src="discuss/blackstar.png" alt="">
										</td>
									</c:when>
									<c:when test="${distorename.drinkstar.equals('5')}">
										<td class="table-success">
										<img src="discuss/blackstar.png" alt="">
										<img src="discuss/blackstar.png" alt="">
										<img src="discuss/blackstar.png" alt="">
										<img src="discuss/blackstar.png" alt="">
										<img src="discuss/blackstar.png" alt="">
										</td>
									</c:when>
									
									
									</c:choose>
									<c:if test="${empty fn:trim(distorename.drinkDiscuss)}">
									<td>
										<form action="UpdateDiscussController" method="post">
											<input type="hidden" name="ID" value="${distorename.ID}">
											<input type="hidden" class="Vince" name="updateValue" value="">
											<input class="btn btn-info updateButton" type="button" value="評論">
										</form>
									</td>
								</c:if>
								<c:if test="${distorename.drinkDiscuss != null}">
									<td class="table-primary">
										<form action="UpdateDiscussController" method="post">
											<input type="hidden" name="ID" value="${distorename.ID}">
											<input type="hidden" class="Vince" name="updateValue" value="">
											<input class="btn btn-danger deleteButton" type="button" value="刪除">
										</form>
									</td>
								</c:if>
								</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
	</div>
	<div class="down_div">
	
	</div>
	
	<!--bootstrap匯入-->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>
	<!--引用dataTables.js(一定要放置最下面)-->
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/dataTables.bootstrap5.min.js"></script>
	
	<script>
					//Vince ==> updateValue(input => type => hidden => class.name)
					//siblings ==>兄弟元素
					//val ==> 給值
// 					$('.updateButton').click(function(){
// 						$('.updateButton').siblings('.Vince').val("1");
// 						$('.updateButton').parents('form').first().submit();
// 						console.log("123");
// 					})
					$('.deleteButton').click(function(){
						$(this).siblings('.Vince').val("2");
						$(this).parents('form').first().submit();
						console.log("456");
						
					})
					$(".tb").on("click",".updateButton",function(){
						$(this).siblings('.Vince').val("1");
						$(this).parents('form').first().submit();
						console.log("123");// 後來產生的元素，使用on動態繫結事件
					})
	</script>

	<script type="text/javascript">
	$(document)	.ready(	function() {
		
		//店家table
		$('#datatablesSimple').DataTable(
						{
							
							
							
							
							
							//欄位內部設定
							columnDefs : [{ //垂直置中
										targets : '_all',
										createdCell : function(	td,cellData,rowData,row, col) {
											$(td).css({'vertical-align':'middle','width':'4px'});
											
										}
									},
									{ //水平置中
										targets : '_all',
										className : 'text-center'
									}
									//{
									//	targets : 9,
									//	orderable : false
										
									//},
									//第10列取消排序功能
									//{
									//	targets : 10,
									//	orderable : false
								      
									//} //第11列取消排序功能
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