<%@page import="java.util.Enumeration"%>
<%@page import="tw.drink.shopcar.model.Orderssitem"%>
<%@page import="java.util.List"%>
<%@page import="tw.drink.shopcar.model.Orderss"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Store New Orderss</title>
<style type="text/css">
* {
	padding: 0;
	margin: 0;
}

.body {
	min-height: 550px;
	margin: 0;
	width: 100%;
	
}

.body>h1 {
	font-size: 3em;
	text-align: center;
}
</style>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>
<!-- JQuery引用 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- datatables css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.0/css/dataTables.bootstrap5.min.css" />
<!-- boostrap套版 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8"
	crossorigin="anonymous"></script>
</head>
<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>
	<div class="body">
		<h1>店家訂單</h1>
		<hr />
		<div class="card text-center" style="width: 80%; margin: 0 auto">
			<div class="card-header">
				<ul class="nav nav-tabs card-header-tabs" >
					<li class="nav-item">
			            <form action="accountstoreneworder.controller" method="get">
					        <input type="hidden" name="imbtn" value="<%=request.getAttribute("storeid")%>">
					        <input type="submit" class="nav-link active" aria-current="true" value="即時訂單">
					    </form>
					</li>
					<li class="nav-item">
					    <form action="accountselectstoreorderss.controller" method="get">
					        <input type="hidden" name="imbtn" value="<%=request.getAttribute("storeid")%>">
					        <input type="submit" class="nav-link" aria-current="true" value="歷史訂單">
					    </form>
					</li>
				</ul>
			</div>
			
			
			<!--即時訂單-->

			<div class="bd-example mytable1" >
				<table id="datatablesSimple1" class="table table-striped"
					style="width: 80%; margin: 0 auto">
					<thead>
						<tr>
							<th scope="col">訂單編號</th>
							<th scope="col">客戶編號</th>
							<th scope="col">客戶姓名</th>
							<th scope="col">消費日期</th>
							<th scope="col">消費總金額</th>
							<th scope="col">消費品項明細</th>
							<th scope="col">接收訂單</th>
						</tr>
					</thead>
					<tbody>
						<%
					    List<Orderss> neworderss = (List<Orderss>) request.getAttribute("orderssByStoreID");
					     if (neworderss != null && neworderss.size() > 0) {
						for (int i = 0; i < neworderss.size(); i++) {
							Orderss orderss = neworderss.get(i);
					   %>
						<tr>
							<th><%=orderss.getOrderssID()%></th>
							<th><%=orderss.getCustomerID()%></th>
							<th><%=orderss.getCustomername()%></th>
							<th><%=orderss.getShopdate()%></th>
							<th><%=orderss.getTotal()%></th>
							<th>
								<!-- Button trigger modal --> <input type="button" value="商品明細"
								id='orderssitemid'
								onclick="showModel(<%=orderss.getOrderssID()%>)"
								class="btn btn-primary" data-bs-toggle="modal"
								data-bs-target="#exampleModal" /> <!-- Modal -->
								<div class="modal fade" id="Modal<%=orderss.getOrderssID()%>"
									tabindex="-1" aria-labelledby="exampleModalLabel"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel">明細</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">
												<ul>
													<%
												List<Orderssitem> orderssitem = (List<Orderssitem>) request.getAttribute("orderssitem"+orderss.getOrderssID());
												if (orderssitem != null && orderssitem.size() > 0) {
													for (int j = 0; j < orderssitem.size(); j++) {
														Orderssitem item = orderssitem.get(j);
												%>
													<li><%=item.getPoructName()+"---"+item.getQTY()+"杯" %>
													</li>
													<%}
													}
												%>
												</ul>

											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Close</button>

											</div>
										</div>
									</div>
								</div>
							</th>
							<th>
								<form action="accountconfimorderss.controller" method="post"
									id="confimorderss<%=orderss.getOrderssID()%>">
									<input type="hidden" name="orderssid"
										value="<%=orderss.getOrderssID()%>">
										<input type="hidden" name="imbtn" value="<%=request.getSession().getAttribute("storeid")%>">
									<button type="button" class="btn btn-danger"
										id="confimorderssbutton"
										onclick="confim(<%=orderss.getOrderssID()%>)">接收訂單</button>
								</form>
							</th>
						</tr>
						<%
						}
					     }
					%>
					</tbody>
				</table>
			</div>

			
			

		</div>
	</div>
	<script type="text/javascript">
	function showModel(id){
		let text='#Modal'+id;
		$(text).modal('show');
	};
	
	function confim(id) {
		console.log('delete prouct');
		Swal.fire({
			title: '要接收此訂單嗎?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: '接受',
	        cancelButtonText: '取消'
			}).then((result) => {
		         if (result.isConfirmed) {
		             Swal.fire({
		              icon: 'success',
		              title: '訂單接受',
		              showConfirmButton: false,
		              timer: 1500
		            }) 
		             setTimeout(() => document.getElementById("confimorderss"+id).submit(), 1500)
		            }
		          })
	};

	
	</script>

	<!-- datatable設定 -->
	<script type="text/javascript">
	$(document).ready( function () {
		$('#datatablesSimple1').DataTable(
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
								"sEmptyTable" :"目前無即時訂單",
								"oPaginate" : {
									"sFirst" : "首頁",
									"sPrevious" : "上一頁",
									"sNext" : "下一頁",
									"sLast" : "末頁"
								}
							},
						});
	} );
	
	</script>

	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>
	<!--引用dataTables.js(一定要放置最下面)-->
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/dataTables.bootstrap5.min.js"></script>
	<!-- boostrap套版 -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-lpyLfhYuitXl2zRZ5Bn2fqnhNAKOAaM/0Kr9laMspuaMiZfGmfwRNFh8HlMy49eQ"
		crossorigin="anonymous"></script>
</body>
</html>