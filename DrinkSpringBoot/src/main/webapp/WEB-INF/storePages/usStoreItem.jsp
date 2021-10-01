<%@page import="java.util.Enumeration"%>
<%@page import="java.util.List"%>
<%@page import="tw.drink.shopcar.model.ShopCarBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>店家頁面</title>
<!--bootstrape匯入-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<!--自己的CSS-->
<link rel="stylesheet" href="store/css/index.css">
<!--照片的CSS-->
<link rel="stylesheet" href="store/css/jquery.fancybox.min.css">

<style type="text/css">
</style>

<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>
</head>
<body onload="initMap()">
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>

	<!-- **/購物車功能開始/** -->
	<!-- 1.設定隱藏，點擊購物會跑出 -->
	<div id="myshopcar" class="position-fixed top-5 end-0"
		style="background-color: pink; width: 200px; height: 250px; z-index: 9999; float: right; margin-top: -20px; display: none">
		<h4 style="text-align: center;">購物車</h4>
		<table class="table table-hover">
		    <thead>
		       <tr>
		          <td>品項</td>
		         <td>冰塊</td>
		         <td>甜度</td>
		          <td>單價</td>
		          <td>數量</td>
		          <td>移除</td>
		       </tr>
		    </thead>
		    <tbody id="shopcarbody">
		      <c:if test="${car!=null&&car.size()>0}">
		         <c:forEach items="${car}" var="item">
		          <tr>
		              <td>${item.prouctName }</td>
		              <td>${item.ice }</td>
		              <td>${item.sugar }</td>
		              <td>${item.price }</td>
		              <td>${item.qty }</td>
		              <td><i class="bi bi-x"></i></td>
		          </tr>
		         </c:forEach>
		      </c:if>
		    </tbody>
		</table>
	</div>

	<!-- **/購物車功能結束/** -->





	<!-- 標題開始 -->
	<div class="usercontainer">
		<!-- 店家封面 -->
		<c:if test="${empty fn:trim(UsStore.photo)}">
			<div class="myusermenu"
				style="background: url(store/NoItem.jpg) center; background-size: cover; height: 300px;"></div>
		</c:if>
		<c:if test="${UsStore.photo != null}">
			<div class="storemenu">
				<img
					src="${pageContext.request.contextPath}/StoreIMG/${UsStore.storeid}"
					class="rounded mx-auto d-block"
					style="margin-top: 20px; width: 450px;" alt="...">
				<div class="position-absolute top-50 start-0 translate-middle-y">
					<div id="map"
						style="margin-left: 20px; width: 350px; height: 250px; border-radius: 10px;"></div>
				</div>
			</div>
		</c:if>
	</div>



			
		<!-- 店家顯示 -->
		<div class="myF">
		
		<div class="pTitle2" style="font-size:22px;">
			<h2 id="title" class="PRowTitle" style="text-align:center;font-size:40px;font-weight:700">${UsStore.title}</h2>
		<div style="width:500px;margin:0 auto;">
		<div>地址：<span id="stadd">${UsStore.stadd}</span></div>
		<div>聯絡電話：<span id="tel">${UsStore.tel}</span></div>
		<div>店長：${UsStore.manager}</div>
		<div>介紹：${UsStore.intro}</div>
		<!-- 取店家id -->
		<input type="hidden" id="orderssstoreid" value="${UsStore.storeid}"> 	

		</div>

		<hr />

		<div class="album py-5">
			<div class="container">

				<c:forEach items="${UsTags}" var="Ustag">
					<h3 class="PRowTitle" style="font-weight: bold">${Ustag}</h3>
					<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">

						<c:forEach items="${UsProductLists}" var="UsProduct">

							<c:set var="t" value="${Ustag}" scope="request" />
							<c:set var="p" value="${UsProduct.category}" scope="request" />
							<c:if test="${t == p}">

								<!-- 商品顯示開始 -->

								<div class="col">
									<div class="card shadow-sm" style="width: 300px;">

										<c:if test="${empty fn:trim(UsProduct.pphoto)}">
											<a class="d-block" data-fancybox="gallery"
												data-caption="${UsProduct.proname}" href="store/NoItem.jpg"><img
												class="bd-placeholder-img card-img-top" width="100%"
												height="225" src="store/NoItem.jpg"></a>
										</c:if>
										<c:if test="${UsProduct.pphoto != null}">
											<a class="d-block" data-fancybox="gallery"
												data-caption="${UsProduct.proname}"
												href="${pageContext.request.contextPath}/ProductIMG/${UsProduct.pstoreid}${UsProduct.proid}"><img
												class="bd-placeholder-img card-img-top"
												onerror="this.style.display='none'" width="100%"
												height="225"
												src="${pageContext.request.contextPath}/ProductIMG/${UsProduct.pstoreid}${UsProduct.proid}"></a>
										</c:if>

										<div class="card-body">
											<p class="card-text" id="prouctname" style="font-weight: bold">${UsProduct.proname}</p>
											<p class="card-text">${UsProduct.pintro}</p>
											<div class="d-flex justify-content-between align-items-center">
											        
												<div class="btn-group">
													<!-- 訂購按鈕 -->
													     <input type="hidden" id="prouctname${UsProduct.proid}" value="${UsProduct.proname}">
														<button type="button" class="btn btn-sm btn-outline-secondary" onclick="orderBtn(${UsProduct.proid})">訂購</button>
														<form action="initShopCar.controller" method="get" id="differentstore"></form>
												</div>
												<!-- 價格/判斷折價或原價 -->
												<c:forEach items="${discountItems}" var="discount">
													<c:set var="d" value="${discount.proId}" scope="request" />
													<c:set var="p" value="${UsProduct.proid}" scope="request" />

													<c:if test="${d.equals(p)}">
														<c:set var="discountPic" value="${discount.proId}"
															scope="request" />
														<small class="text-muted"> <span>$</span> <span
															style="text-decoration: line-through; margin-right: 5px;">
																${UsProduct.proprice}</span> <span>優惠價$</span> <span
															id="productRealPrice${UsProduct.proid}">${discount.disPrice}</span>
														</small>
													</c:if>
												</c:forEach>
												<c:if test="${empty fn:trim(discountPic)}">
													<small class="text-muted">$ <span
														id="productRealPrice${UsProduct.proid}">${UsProduct.proprice}</span></small>
												</c:if>
												<c:remove var="discountPic" />
											</div>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</c:forEach>
			</div>

		</div>
	</div>

	

	<!-- 引用ajax -->
	<script type="text/javascript"
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>

	<!--引用jQuery-->
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

	<!-- 引用fancybox -->
	<script src="store/js/jquery.fancybox.min.js"></script>
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
	<!-- **/購物車功能開始/** -->
	<script>
		function orderBtn(proid) {
			
			let proName=$("#prouctname"+proid).val();
			let storeid=parseInt($('#orderssstoreid').val());
			let price=$("#productRealPrice"+proid).html();
			(async () => {

				const { value: formValues } = await Swal.fire({
					title: '請依個人喜好調整',
					html:
						"<select name='ice' id='ice' class='form-select' aria-label='Default select example' style='width: 85px;height: 40px;display: inline;'><option disabled>冰塊</option><option value='全冰'>全冰</option><option value='少冰'>少冰</option><option value='去冰'>去冰</option></select>"
						+ "<select name='sugar' id='sugar' class='form-select' aria-label='Default select example' style='width: 85px;height: 40px;display: inline;margin:0px 5px'><option disabled>甜度</option><option value='全糖'>全糖</option><option value='少糖'>少糖</option><option value='半糖'>半糖</option><option value='微糖'>微糖</option><option value='無糖'>無糖</option></select>"
						+ "<label for='qty'>數量:</label><input type='number' min='1' name='qty' id='qty' value='1' style='width: 40px;display: inline;'>"
					,
					focusConfirm: false,
					confirmButtonColor: '#3085d6',
					confirmButtonText: '訂購',
					preConfirm: () => {
						var params={
								"storeID":storeid,
								"prouctID":proid,
								"prouctName":proName,
								"qty":document.getElementById('qty').value,
								"price":price,
								"ice":document.getElementById('ice').value,
								"sugar":document.getElementById('sugar').value
						}
						return params;

						
					}
				})

				if (formValues) {
					console.log(formValues);
					$.ajax({
						type : 'post',
						url : 'accountaddprouct.controller',
						contentType : 'application/json',
						data : JSON.stringify(formValues),
						success : function(data) {
							if('different store'==data){ //
							
								Swal.fire({
									  icon: 'warning',
									  title: '請先結帳,再到不同店家購物',
									  showConfirmButton: false,
									  timer: 1500
									})
									setTimeout(() => document.getElementById('differentstore').submit(), 3000)
									
								}else{
									let product= data.split('-');
									let prouctid=product[0];
									let proname=product[1];
									let propirce=product[2];	
								    $('.shopcarbody').append("<div class='prouct"+prouctid+"' style='position: relative;'><img alt='' src='<c:out value='${request.contextPath}'/>/Drink/shopcarimages/prouct"+prouctid+".jpg' style='width: 70px'><h6 style='color: black;display: inline-block;vertical-align: top;font-weight: 700;'>"+ proname+"</h6><i style='color: red;display: block;'>NT$"+propirce+" </i><img alt='' style='display: block;position: absolute;top: 0;right: 0;' src='<c:out value='${request.contextPath}'/>/Drink/shopcarimages/garbage.png' onclick='deleteprouct("+prouctid+"})'><hr></div>");
											Swal.fire({
												  icon: 'success',
												  title: '已加入購物車',
												  showConfirmButton: false,
												  timer: 1500
												});

								}

						},
						error : function(e) {
							console.log(e);
						}
					});

				}

			})()
			
			

		
			

			
			

	
			
			
		}
	</script>
	<!-- **/購物車功能結束/** -->



	<!-- google map -->
	<script>
  	  var map, geocoder;
 	  // 建立 geocoder 物件實例
      
 	  function initMap() {
 		geocoder = new google.maps.Geocoder();
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 16
        });
        
        var address = document.getElementById("stadd").innerHTML;
        var title = document.getElementById("title").innerHTML;
        var tel = document.getElementById("tel").innerHTML;
        
        const image ="store/store.png";
        const secretMessages = "<P style='text-align:center;font-weight:bold;'>"+title+"</P>"+"<P style='text-align:center;'>"+address+"<br/>"+tel+"</P>";
        
        geocoder.geocode( { 'address': address}, function(results, status) {
            if (status == 'OK') {
            <!--顯示地圖-->	
            map.setCenter(results[0].geometry.location);
            <!--顯示標記-->	 
            var marker = new google.maps.Marker({
                  map: map,
              	  title:title,
              	  icon: image,
                  position: results[0].geometry.location
              });
            
            attachSecretMessage(marker, secretMessages);
            
            } else {
              console.log(status);
            }
          });
        
        
        function attachSecretMessage(marker, secretMessage) {
        	  const infowindow = new google.maps.InfoWindow({
        	    content: secretMessage,
        	  });

        	  marker.addListener("click", () => {
        		  if(!marker.open){
        	   		 	infowindow.open(marker.get("map"), marker);
        	    		marker.open = true;
        		  }else{
        			  	infowindow.close();
                      	marker.open = false;
        		  }
        	});
        }
     } 
    </script>
    
	
	
	

	<!-- 滑入滑出效果 -->
	<!--<script type="text/javascript">
	$(function () {
	$( ".myLarrows" ).mouseover(function() {
		 $(this).attr("src","store/01arrow.png");
		});
	$( ".myLarrows" ).mouseout(function() {
		$(this).attr("src","store/arrow.png");
		});
	$( ".myarrows" ).mouseover(function() {
		 $(this).attr("src","store/01arrow.png");
		});
	$( ".myarrows" ).mouseout(function() {
		 $(this).attr("src","store/arrow.png");
		});
	
	});
	
</script>-->
<!-- 引用google map 需要註冊帳號拿憑證，要使用可詢問喬安~ 20210912-->
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAMlj4xGpmQFW21YqmcpzrHhDMOh9jCnCQ&callback=initMap"></script>
</body>
</html>