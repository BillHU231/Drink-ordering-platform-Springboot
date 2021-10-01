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

.div_god{
    position: relative;
    height:550px;
    width:100%;
    text-align: center;
}
.div_human{
	position: absolute;
	width:200px;
	height:260px;
	top:200px;
	bottom: 150px;
	right:0;
	left:0;
	margin:auto;
	box-shadow:3px 3px 9px black;
	border-radius:6px;
}
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
.bottom_div{
margin:100px;
}
</style>
</head>

<body >
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>
<div class="bottom_div">
<h4>請謹慎發言 , 你的一句話可能會讓人受傷也可能會讓他人得到正面的鼓勵</h4>
<h4>你一句無心的話對別人來說可能是一把刀</h4>
	</div>
	<div class="div_god">
	<div class="div_human">
		<form action="<%=request.getContextPath()%>/DiscussController" id="saddid"
			method="post">
			<h5>店名 : ${disFindById.title}</h5>
			<h5>品名 : ${disFindById.proname}</h5>
			<input name="disid" type="hidden" value="${disFindById.ID}">

			<input type="hidden" name="drinkstar" id="drinkstar" value="">
			<div id="stars" class="left">
				<img src="discuss/whitestar.png" alt=""> 
				<img src="discuss/whitestar.png" alt=""> 
				<img src="discuss/whitestar.png" alt=""> 
				<img src="discuss/whitestar.png" alt=""> 
				<img src="discuss/whitestar.png" alt="">
			</div>
			<div id="comment" class="left"></div>
			<br> 評論: <input type="text" id="talk" name="drinkDiscuss">
			<span id="ttalk"></span><br> <br>

		</form>
			<div class="but_div">
				<input class="but1" onclick="DisAdd()" type="button" value="確認">
			</div>
		</div>
	</div>
	
	<!--引用sweetalert-->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.1/dist/sweetalert2.all.min.js"></script>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>

	<script>
	
		// let nowTime = new Date();
		// console.log("nowTime="+nowTime);
		//制作一個星星評分
		var drinkstar = document.getElementById("drinkstar");
		var divStars = document.getElementById("stars");
		var divComment = document.getElementById("comment");
		var starNum = -1; //記錄當前第幾顆星星被點擊
		var starArray = Array.from(divStars.children); //星星陣列

		//滑鼠移入
		divStars.onmouseover = function(e) {
			if (e.target.tagName === "IMG") { //事件源是圖片
				//把滑鼠移動到的星星替換圖片
				e.target.src = "discuss/blackstar.png";
				//把滑鼠移動到的星星之前的星星替換圖片
				var prev = e.target.previousElementSibling;
				while (prev) {
					prev.src = "discuss/blackstar.png";
					prev = prev.previousElementSibling;
				}
				//把滑鼠移動到的星星之后的星星替換圖片
				var next = e.target.nextElementSibling;
				while (next) { //把滑鼠移動到的星星之后的星星替換圖片
					next.src = "discuss/whitestar.png";
					next = next.nextElementSibling;
				}

				var index = starArray.indexOf(e.target); //找到滑鼠移動到的星星的序號
			}
		}

		//滑鼠點擊
		divStars.onclick = function(e) {
			if (e.target.tagName === "IMG") {
				//記錄當前點擊的星星序號
				starNum = starArray.indexOf(e.target);
				drinkstar.value = starNum + 1;
				// console.log(starNum+1); 	
			}
		}

		//滑鼠移出
		divStars.onmouseout = function(e) {
			if (starNum !== -1) { //滑鼠點擊事件發生，將評分固定在點擊的星星上
				for (var i = 0; i < divStars.children.length; i++) {
					if (i <= starNum) {
						divStars.children[i].src = "discuss/blackstar.png";

					} else {
						divStars.children[i].src = "discuss/whitestar.png";
					}
				}
			} else {
				for (var i = 0; i < divStars.children.length; i++) {
					divStars.children[i].src = "discuss/whitestar.png";
				}
				divComment.innerHTML = ""; //不顯示評論
			}
		}
	</script>
	
<!-- 	拖移div -->





	<script> 
	function DisAdd(){
	Swal.fire({
		icon: 'success',
		title: '評論成功',
	    showConfirmButton: false,
		timer: 1000
		}).then((result) => {
       setTimeout(() => document.getElementById("saddid").submit(), 200)
     })
	}
     </script>
</body>

</html>