<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="java.util.ArrayList" 
    import="java.util.List" 
    import="tw.drink.activity.model.ActivityDiscountItem" 
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>updateActivity</title>
    
	<!-- jQuery-UI CSS 樣式(配合 jQuery UI)-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!-- Bootstrap-ICON CSS 樣式 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
	
	<style>
		*{ 
			padding: 0;
			margin: 0;
		}
		.containerArea{
            padding: 0;
			margin: 0;
            width: 100%;
		}
		.containerArea .header{
			padding:220px 0;
			font-size:58px;
			line-height: 60px;
			text-align: center;
		}
		
		.containerArea .formBox{
			background-color: rgba(255,255,255,0.8);
			max-width: 98%;
			padding: 70px 8% 50px;
			margin: 10px auto;
			border-radius: 10px;
			font-size: 23px;
    		line-height: 30px;
		}
		
		.containerArea .discountItem{
			margin-bottom: 30px;
		}
		.containerArea .proPriceBox{
			display: inline-block;
			width:25%;
			margin-right:1%;
		}
		.containerArea .selectUpdateDiscountValueBox{
			display: inline-block;
			height:58px;
			width:25%;
			margin-right:1%;
			font-size: 23px;
		}
		.containerArea .disPriceBox{
			display: inline-block;
			width:40%;
		}
		.containerArea .btnItem{
			text-align: center;
		}
		.containerArea .btnItem button{
		    font-size: 24px;
    		line-height: 24px;
    		height:50px;
    		padding:12px 12px;
		}
	</style>
	
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp" %>
	
</head>
<body>

	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp" %>
	
	<div class="containerArea">
		<div class="header" style="width:98%; height:500px ;margin:10px auto 0px auto;background:rgba(205,205,205,0.5) ; border-radius: 4px 4px 10px 10px;">
			修改限時特價項目
		</div>
		
		<div class="formBox">
			<form action="<%=request.getContextPath()%>/updateDiscountItemDo.controller" method="post">
				<c:forEach items="${allDiscountByAactivityid}" var="ActivityDiscountItem" >
					<div class="discountItem">
						<!-- 品項 ID -->
						<input type="hidden" name="discountId" value="${ActivityDiscountItem.discountId}">
						<div class="alert alert-warning" role="alert">
							品項名稱: ${ActivityDiscountItem.proName} - ( 原折扣價格: ${ActivityDiscountItem.disPrice}元 )
						</div>
						<div class="alert alert-primary proPriceBox" role="alert">
							原價: <span class="proPriceText">${ActivityDiscountItem.proPrice}</span><span>元</span>
						</div>
						<select class="form-control selectUpdateDiscountValueBox" name="selectUpdateDiscountValue${allDiscountByAactivityid}">
	                        <option value="95" selected>95折</option>
	                        <option value="90">9折</option>
	                        <option value="80">8折</option>
	                        <option value="70">7折</option>
	                        <option value="60">6折</option>
	                        <option value="50">半價</option>
	                    </select>
	                    <div class="alert alert-danger disPriceBox" role="alert">
							折扣後價格: 
							<span class="newDiscountValue" id="newDiscountValue${ActivityDiscountItem.discountId}">
								${ Math.round(Math.floor(ActivityDiscountItem.proPrice*0.95)) }
							</span>
							<span>元</span>
							
						</div>
						<input class="disdisPriceInput" type="hidden" name="disdisPrice" value="${ Math.round(Math.floor(ActivityDiscountItem.proPrice*0.95)) }">
						<hr>
					</div>
				</c:forEach>
				<div class="btnItem">
					<button type="submit" class="btn btn-warning">確定修改</button>
				</div>
			</form>
		</div>
		
	</div>
	
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp" %>
	
	<!-- jQuery CDN -->
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	
	<!-- jQuery-UI CDN -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30=" crossorigin="anonymous"></script>
	
	<!-- Bootstrap CDN Javascript body2標籤已有-->
	
    <script>
		$(function(){
			
			// 選擇折扣項目
			$(".discountItem").on("change",".selectUpdateDiscountValueBox",function(){ // 後來產生的元素，使用on動態繫結事件
				
				// 取得該項目原價
				let proPrice;
				proPrice = $(this).siblings(".proPriceBox").find(".proPriceText").text();
				console.log("原價:"+proPrice);
				
				// 計算折扣後價格
				let newPrice;
				newPrice = Math.floor( proPrice*parseInt( $(this).val() )/100 );
				console.log("折扣價:"+newPrice);
				
				// 畫面顯示
				$(this).siblings(".disPriceBox").find(".newDiscountValue").text(newPrice);
				// input 設定
				$(this).siblings(".disdisPriceInput").val(newPrice);
			});
			
			// 送出表單
			
		})
	</script>
</body>
</html>