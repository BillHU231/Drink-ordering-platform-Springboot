<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test</title>
<!--bootstrape匯入-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<!--自己的CSS-->
<link rel="stylesheet" href="store/css/index.css">
<!--照片的CSS-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.css" />

<style type="text/css">
#
</style>

<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>


	<!-- 內文開始 -->
	<div class="usercontainer ">

		<div class="myusermenu">
		
		   <div class="myleftmenu">
			<div class="mymap">
				<h5>請選擇所在地區</h5>
				<div>
					<input class="form-control" style="width:300px; margin:0 auto;" list="datalistOptions"  autocomplete="off" placeholder="可使用下拉式選單選擇所在地">
						<datalist id="datalistOptions">
							<option value="台北市">
							<option value="台中市">
							<option value="高雄市">
<!-- 							<option value="新北市"> -->
<!-- 							<option value="桃園市"> -->
<!-- 							<option value="台南市"> -->
<!-- 							<option value="基隆市"> -->
<!-- 							<option value="新竹市"> -->
<!-- 							<option value="嘉義市"> -->
<!-- 							<option value="苗栗縣"> -->
<!-- 							<option value="彰化縣"> -->
<!-- 							<option value="南投縣"> -->
<!-- 							<option value="雲林縣"> -->
<!-- 							<option value="屏東縣"> -->
<!-- 							<option value="宜蘭縣"> -->
<!-- 							<option value="花蓮縣"> -->
<!-- 							<option value="台東縣"> -->
<!-- 							<option value="澎湖縣"> -->
						</datalist>
					</div>
				</div>
			</div>
			
			
		<div class="myrightmenu">
			
			<div class="mysearch">
				<h5>請輸入要查詢的關鍵字?</h5>
				<div style="width:100%;margin:0 auto;">
						
						<form action="#" method="post">
						<input class="form-control" style="width:42%;float:left;margin-left:10%" list="drinksOption"  autocomplete="off" placeholder="想喝點什麼呢?">
							<datalist id="drinksOption">
								<option value="珍珠奶茶">
								<option value="咖啡">
							</datalist>
						<input class="imbtn usSeabtn" style="" type="image" src="store/search.png">
						</form>
					
					</div>
					<div style="margin:10px 0">
						<button type="button" class="btn btn-outline-success usbtn">找熱門</button>
						<button type="button" class="btn btn-outline-primary usbtn">找優惠</button>
						<button type="button" class="btn btn-outline-info usbtn">找新鮮</button>
<!-- 					<button type="button" class="btn btn-outline-warning usbtn">找附近</button> -->
					</div>
					
					<div style="margin:10px 0">
					<button type="button" class="btn btn-light usbtn">#下午茶</button>
					<button type="button" class="btn btn-light usbtn">#咖啡</button>
					<button type="button" class="btn btn-light usbtn">#珍珠奶茶</button>
					</div>
					
				</div>
				
			</div>

		</div>

		<!-- 內文開始 -->
		<div class="myF">
			<!-- 店家輪播 -->
			<!-- 優惠活動 -->
			<div class="RowOutside">
				<h3>優惠活動</h3>
				<div class="myRow">
					<div style="background-color: yellow; width: 50px; height: 250px;">
						
						
						<div style="margin-top:10px">slide1</div>
					</div>
				</div>
			</div>
			
			<!-- 熱門店家 -->
			<div class="RowOutside">
			<h3>熱門店家</h3>
			<div class="myRow">
				<div style="background-color: yellow; width: 50px; height: 250px;">slide	1</div>
				<div style="background-color: blue; width: 50px; height: 250px;">slide	1</div>
				<div style="background-color: green; width: 50px; height: 250px;">slide	1</div>
				<div style="background-color: red; width: 50px; height: 250px;">slide	1</div>
					<div style="background-color: yellow; width: 50px; height: 250px;">slide	1</div>
				<div style="background-color: blue; width: 50px; height: 250px;">slide	1</div>
				<div style="background-color: green; width: 50px; height: 250px;">slide	1</div>
				<div style="background-color: red; width: 50px; height: 250px;">slide	1</div>
			</div>
			</div>
			
			<!-- 知名品牌 -->
			<div class="RowOutside">
			<h3>知名品牌</h3>
			<div class="myRow">
				<div style="background-color: yellow; width: 50px; height: 50px;">slide	1</div>
				<div style="background-color: blue; width: 50px; height: 50px;">slide	1</div>
				<div style="background-color: green; width: 50px; height: 50px;">slide	1</div>
				<div style="background-color: red; width: 50px; height: 50px;">slide	1</div>
				<div style="background-color: yellow; width: 50px; height: 50px;">slide	1</div>
				<div style="background-color: blue; width: 50px; height: 50px;">slide	1</div>
				<div style="background-color: green; width: 50px; height: 50px;">slide	1</div>
				<div style="background-color: red; width: 50px; height: 50px;">slide	1</div>
			</div>
			</div>
			
			<!-- 最新店家 -->
				<div class="RowOutside">
			<h3>最新店家</h3>
			<div class="myRow">
				<div style="background-color: yellow; width: 50px; height: 50px; text-align:center;">slide	1</div>
				<div style="background-color: blue; width: 50px; height: 50px; text-align:center;">slide	1</div>
				<div style="background-color: green; width: 50px; height: 50px; text-align:center;">slide	1</div>
				<div style="background-color: red; width: 50px; height: 50px; text-align:center;">slide	1</div>
				<div style="background-color: yellow; width: 50px; height: 50px;">slide	1</div>
				<div style="background-color: blue; width: 50px; height: 50px;">slide	1</div>
				<div style="background-color: green; width: 50px; height: 50px;">slide	1</div>
				<div style="background-color: red; width: 50px; height: 50px;">slide	1</div>
			</div>
		</div>
		
		<!-- 店家顯示 -->
		<div class="myF">
<!-- 			<div class="test2" style="width:100%;background-color:red;margin:0 auto;" > -->
				<div class="test2in">111111111111111</div>
				<div class="test2in">111111111111111</div>
				<div class="test2in">111111111111111</div>
				<div class="test2in">111111111111111</div>
				<div class="test2in">111111111111111</div>
				<div class="test2in">111111111111111</div>
<!-- 			</div> -->
		</div>
	
	
	
	</div>



	<!--引用jQuery-->
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

	<!--bootstrap匯入-->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous">
		
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous">
		
	</script>

	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>
	<!--引用slick-->
	<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
	<script>
		$('.myRow').slick({
			infinite : false,
			dots : false,
			slidesToShow : 4,
			slidesToScroll : 2,
			autoplaySpeed : 2000,
			arrows : true,
			loop : false
		});
	</script>

</body>
</html>