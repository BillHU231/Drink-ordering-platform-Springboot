
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="tw.drink.shopcar.model.ShopCarBean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>checkout</title>
<style>
* {
	padding: 0;
	margin: 0;
	list-style: none;
}

.body {
	height: 100vh;
	padding: 50px 0;
	width: 100%;
	background-color: #EFFFD7;
}

.body>h1 {
	font-size: 3em;
	text-align: center;
}

.checkoutProuct {
	margin: auto;
	width: 300px;
	border-collapse: collapse;
	display: flex;
	align-items: center;
	justify-content: center;
}

tr, td, th {
	border: 1px solid blue;
	line-height: 30px;
}

caption {
	display: table-caption;
	text-align: center;
}

tbody {
	text-align: center;
}

tbody tr:nth-child(2n) {
	background-color: cornflowerblue;
}

tbody tr:nth-child(2n+1) {
	background-color: cornsilk;
}

.information {
	border: 3px solid blue;
	border-radius: 10px;
	width: 500px;
	padding: 10px 10px;
	margin: 10px auto;
}

div.d1 {
	border-bottom: 1px solid #D0D0D0;
	padding: 10px;
}

.formbutton {
	clear: both;
}

.formbutton{
   margin-left: 45%;
   padding: 2px
}
#confimbutton{
  display: inline;
}
#cancel{
  display: inline;
}
</style>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>
	<!-- JQuery引用 -->
   <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>

	<div class="body">
		<h1>訂單</h1>
		<hr>
		<table class="checkoutProuct">

			<tbody>
				<tr>
					<th colspan="3">
						<h5>您消費的項目</h5>
					</th>
				</tr>
				<tr>
					<th>品項</th>
					<th>數量</th>
					<th>單品總價</th>
				</tr>
				<%
					List<ShopCarBean> cars = (List<ShopCarBean>) request.getAttribute("car");
				for (ShopCarBean item : cars) {
					double oneProuctTotal = item.getPrice() * item.getQty();
				%>

				<tr>
					<td><%=item.getProuctName()%><em><%=item.getIce() + " " + item.getSugar()%></em></td>
					<td><%=item.getQty()%></td>
					<td>NT$<%=oneProuctTotal%></td>
				</tr>
				<%
					}
				%>

				<tr>
					<td colspan="2" style="border-right: none;">總數量:<%=request.getAttribute("allQty")%></td>

					<td colspan="2">total: <%=request.getAttribute("allProuctTotal")%></td>
				</tr>
			</tbody>
		</table>

		<form name="confimForm" action="accountconfim.controller"
			method="post" id="confim">
			<fieldset class="information">
				<h5 id="word">
					填寫個人資料<em style="color: red;">(必填)</em>
				</h5>
				<input type="checkbox" id="cbox" value="second_checkbox" checked="checked">
				<label for="cbox">同會員資料</label>
				<input type="hidden" id="hiddenname" value="${customername}">
				<input type="hidden" id="hiddenmail" value="${customermail}">
				<div class="d1">
					<label for="guest">訂購人姓名:</label> <input type="text" id="guest"
						name="guest" value="${customername}" readonly="readonly"> <span id="idguest" style="color: red"></span>
				</div>
				<div class="d1">
					<label for="mail">電子信箱:</label> <input type="text" id="mail"
						name="mail" value="${customermail}" readonly="readonly"> <span id="idmail" style="color: red"></span>
				</div>

				<%	
		            for (ShopCarBean item : cars) { %>
				<input type="hidden" name="storeID" value="<%=item.getStoreID()%>"> 
				<%} %>
			</fieldset>
		</form>
			<div class=formbutton>
				<input type="button" value="確認" id="confimbutton" class="btn btn-primary">
		      <form name="cancalForm" action="accountcancal.controller"
			        method="post" id="cancel">
			    <input type="submit" value="取消" class="btn btn-primary">
		      </form>
	        </div>

	</div>




	<script type="text/javascript">
	//同會員資料js
	$('#cbox').change(function(){
		if(this.checked){
		console.log('true');
		let name=$('#hiddenname').val();
		let mail=$('#hiddenmail').val();
		$('#guest').val(name);
		$('#mail').val(mail);
				
		}else{
			console.log('false');
			$('#guest').removeAttr('readonly');
			$('#mail').removeAttr('readonly');
			$('#guest').val("");
			$('#mail').val("");
			
		}
		
	});
	
	
	
		document.getElementById("word").addEventListener('click', function() {
			document.getElementById("guest").value = '胡秉睿';
			document.getElementById("mail").value = 'asbill920166@gmail.com';

		});

		document.getElementById("confimbutton").addEventListener(
				"click",
				function() {
					let guest = document.getElementById("guest").value;
					let mail = document.getElementById("mail").value;
					if (guest == "" || mail == "") {
						Swal.fire({
							icon : 'error',
							title : '個人資料不能空白',
						})
					} else {
						document.getElementById("confim").submit();
					}
				});

		document.getElementById("guest").addEventListener("blur", function() {
			let guest = document.getElementById("guest");
			let guestval = guest.value;
			let idspen = document.getElementById("idguest");
			if (guestval == "") {
				idspen.innerHTML = "不可空白";
			} else {
				idspen.innerHTML = "";
			}
		});

		document.getElementById("mail").addEventListener("blur", function() {

			let mail = document.getElementById("mail");
			let mailval = mail.value;
			let idspen = document.getElementById("idmail");
			if (mailval == "") {
				idspen.innerHTML = "不可空白";
			} else {
				idspen.innerHTML = "";
			}
		});


	</script>
	<!--引用sweetalert-->
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- 套版 -->
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>
</body>

</html>