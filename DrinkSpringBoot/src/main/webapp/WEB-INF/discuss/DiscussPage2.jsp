
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.List"
	import="tw.drink.discuss.model.DiscussBean" 
	import="tw.drink.store.model.Store"
	import="tw.drink.store.model.StoreProduct"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>討論區</title>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>

<style>
		.select_div{
			padding:50px;
			
	box-shadow:3px 3px 9px #C4E1E1;
		}
		.select {
		display:inline-block;
            text-align: center;
            height: 40px;
            overflow: hidden;
            border-radius: 10px;
            width:200px;
        }
        .option{
            width: 150px;
            height: 40px;
            font-size: 20px;
            display: inline-block;
            border-radius: 10px;
            padding-top: 10px;
            width:200px;
        }
		.down {
			padding: 200px;
		}
</style>

</head>
<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>

	<div style="width: 100%;box-shadow:3px 3px 9px 	#D8D8EB;">
		<div class="card-body">
			<table id="datatablesSimple" class="table table-success table-striped" style="width: 100%;">
		<thead>
			<tr>
				<th scope="col">店家名稱</th>
				<th scope="col">飲料名</th>
				<th scope="col">評論</th>
				<th scope="col">星級</th>
			</tr>
		</thead>
		<tbody>

			<%
				List<DiscussBean> discussList = (List<DiscussBean>) request.getAttribute("DisPage2findAll");
			%>
			<%
				for (DiscussBean item : discussList) {
					String tmpDis = item.getDrinkDiscuss();
					String tmpstar = item.getDrinkstar();
					String tmptitle = item.getTitle();
					String tmpproname = item.getProname();
					
					
					if(item.getDrinkDiscuss() != null & item.getDrinkDiscuss() != null){
						
						%><tr><%
						
								%><td><%=tmptitle %></td><% 
				 				%><td><%=tmpproname %></td><%
				 				%><td><%=tmpDis %></td><%
								%><td><%switch(tmpstar){
								
								case "1":
									%><img src="discuss/blackstar.png" alt=""><%
								break;
								case "2":
									%><img src="discuss/blackstar.png" alt=""><%
									%><img src="discuss/blackstar.png" alt=""><%
								break;
								case "3":
									%><img src="discuss/blackstar.png" alt=""><%
									%><img src="discuss/blackstar.png" alt=""><%
									%><img src="discuss/blackstar.png" alt=""><%
								break;
								case "4":
									%><img src="discuss/blackstar.png" alt=""><%
									%><img src="discuss/blackstar.png" alt=""><%
									%><img src="discuss/blackstar.png" alt=""><%
									%><img src="discuss/blackstar.png" alt=""><%
								break;
								case "5":
									%><img src="discuss/blackstar.png" alt=""><%
									%><img src="discuss/blackstar.png" alt=""><%
									%><img src="discuss/blackstar.png" alt=""><%
									%><img src="discuss/blackstar.png" alt=""><%
									%><img src="discuss/blackstar.png" alt=""><%
								break;
								
								}
								%></td><%
				 				
				 		%></tr><%	
				 				
					}
			%>

			<%
				}
			%>
		</tbody>
	</table>
	</div>
	
	</div>
	<div class="down"></div>
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

	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/dataTables.bootstrap5.min.js"></script>
		
	

	<script type="text/javascript">
		$(document)
				.ready(
						function() {

							//店家table
							$('#datatablesSimple')
									.DataTable(
											{

												//欄位內部設定
												columnDefs : [
														{ //垂直置中
															targets : '_all',
															createdCell : function(
																	td,
																	cellData,
																	rowData,
																	row, col) {
																$(td)
																		.css(
																				{
																					'vertical-align' : 'middle',
																					'width' : '4px'
																				});

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