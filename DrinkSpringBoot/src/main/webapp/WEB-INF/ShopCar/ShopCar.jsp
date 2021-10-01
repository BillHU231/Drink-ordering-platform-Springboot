
<%@page import="java.util.Enumeration"%>
<%@page import="tw.drink.store.model.StoreProduct"%>
<%@page import="tw.drink.shopcar.model.ShopCarBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>enterprise page</title>
<style>
* {
	padding: 0;
	margin: 0;
}

.body {
	min-height: 550px;
	margin: 0;
	width: 100%;
	background-color: #EFFFD7;
}

.body>h1 {
	font-size: 3em;
	text-align: center;
}

#add {
	text-align: center;
	font-size: 1.5em;
}

.prouct {
	border: 3px solid blue;
	border-radius: 20px;
	text-align: center;
	width: 400px;
	margin: 10px auto
}

.checkout {
	text-align: center;
	/* width: 400px; */
	margin: 10px auto
}

.totalword {
	display: inline;
	color: red;
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

</head>

<body>

	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>

	<div class="body">
		<h1>購物車</h1>
		<hr>


		<div class="card-body" >
			<table id="datatablesSimple1" class="table table-striped"
				style="width: 80%;margin:0 auto">
				<thead>
					<tr>
						<th scope="col">商品圖示</th>
						<th scope="col">商品名稱</th>
						<th scope="col">冰塊</th>
						<th scope="col">甜度</th>
						<th scope="col">單價</th>
						<th scope="col">數量</th>
						<th scope="col">移除</th>
					</tr>
				</thead>
				<tbody>
					<%
						List<ShopCarBean> car = (List<ShopCarBean>) request.getAttribute("car");

					if (car != null && car.size() > 0) {
						for (int i = 0; i < car.size(); i++) {
							ShopCarBean caritem = car.get(i);
					%>
					<tr>
						<th><img alt=""
							src="<%request.getContextPath();%>/Drink/shopcarimages/prouct<%=caritem.getProuctID()%>.jpg"
							 style="width:100px"></th>
						<th><%=caritem.getProuctName()%></th>
						<th><%=caritem.getIce()%></th>
						<th><%=caritem.getSugar()%></th>
						<th><%=caritem.getPrice()%></th>
						<th><input type='number' name='qty'
							value='<%=caritem.getQty()%>' min="1" style="width: 3em"
							class='proqty'
							id='<%=caritem.getProuctID() + "-" + caritem.getIce() + "-" + caritem.getSugar()%>' />
						</th>
						<th>
							<form id="delete<%=i%>" action="accountdeleteprouct.controller"
								method="post">
								<input type="hidden" name="deproid" value="<%=i%>"> <input
									type="button" value="移除商品" id='removeprouct' class="btn btn-primary"
									onclick="Pdelete(<%=i%>)" />
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
		<%
			if (car != null && car.size() > 0) {
			int total = 0;
			for (int i = 0; i < car.size(); i++) {
				ShopCarBean caritem = car.get(i);
				total += caritem.getPrice() * caritem.getQty();
			}
		%>

		<div class="checkout">
			<form id="checkoutForm" action="accountcheckout.controller"
				method="post">
				<h5 class="totalword">
					<em id="total">小計NT$<%=total%></em>
				</h5>
				<input type="button" value="結帳" onclick="checkout()" class="btn btn-primary">
			</form>
		</div>

	</div>
	<%
		}
	%>

    <!-- datatable設定 -->
	<script type="text/javascript">
	$('#datatablesSimple1').DataTable(
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
								},
						],
					});
	
	</script>


	<!-- 彈出視窗 -->
	<script type="text/javascript">
	//移除商品
	function Pdelete(id){
		console.log('delete prouct');
		Swal.fire({
			title: '確定移除此項商品嗎?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
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
	//結帳
		function checkout(){
		console.log('checkout');
		Swal.fire({
			title: '確定結帳嗎?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: '結帳',
	        cancelButtonText: '取消'
			}).then((result) => {
		         if (result.isConfirmed) {
		       
		             setTimeout(() => document.getElementById('checkoutForm').submit(), 1500)
		            }
		          })
	}
	//增加數量
	$('.proqty').change(function() {
			console.log('qtychange');
			let prouct = this.id;
			let prouctArray = prouct.split('-');
			console.log(prouctArray);
			let prouctid = prouctArray[0];
			let prouctice = prouctArray[1];
			let prouctsugar = prouctArray[2];
			let qty = this.value;
			//console.log(proucdid+"-"+proucdice+"-"+proucdsuger+"-"+qty);
			var params = {
				"prouctID" : prouctid,
				"ice" : prouctice,
				"sugar" : prouctsugar,
				"qty" : qty
			};
			console.log(params);
			$.ajax({
				type : 'post',
				url : 'accountchangeqty.controller',
				contentType : 'application/json',
				data : JSON.stringify(params),
				success : function(data) {
					if ("qty is not change" == data) {
						console.log(data);
					} else {
						console.log(data);
						$('#total').text('小計NT$' + data);
					}

				},
				error : function(e) {
					console.log(e);
				}
			});
		});
	</script>
	<!-- 套版引入 -->
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>
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
	<script
		src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.1/dist/sweetalert2.all.min.js"></script>
	<!--引用dataTables.js(一定要放置最下面)-->
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/dataTables.bootstrap5.min.js"></script>
</body>

</html>