<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="tw.drink.store.model.StoreProduct" 
	import="java.util.ArrayList" 
	import="java.util.List" 
	import="tw.drink.activity.model.ActivityBean" 
	import="tw.drink.activity.model.ActivityDiscountItem"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!--------------------------------- Banner_2 流程圖--------------------------------->

<div class="Banner2_Area">
	<ul class="Banner2_list" >
		<li><a href="#" onclick="$('#loginInf').click();">
			<i class="bi bi-people-fill"></i>
			<span class="Banner2_li_text1">加入會員</span>
		</a></li>
		<li><a href="#">
			<i class="bi bi-compass-fill"></i>
			<span class="Banner2_li_text2">尋找飲品</span>
		</a></li>
		<li><a href="#">
			<i class="bi bi-handbag-fill"></i>
			<span class="Banner2_li_text3">下訂</span>
		</a></li>
		<li><a href="#">
			<i class="bi bi-patch-check"></i>
			<span class="Banner2_li_text4">Enjoy!</span>
		</a></li>	
	</ul>
</div>

<!--------------------------------- Banner_3 推薦飲品 --------------------------------->
<%
	// 取得所有產品資料
	ArrayList<StoreProduct> allProducts = (ArrayList<StoreProduct>)request.getAttribute("homePageAllProducts");
	
	// 隨機給出一種產品
	int productNum = allProducts.size(); // 產品總數量
	int randomIndex = 0; 				 // 亂數產生器: 產生 index [0] ~ [總數-1] 其中一個
	randomIndex = (int)(Math.random()*(productNum));
	request.setAttribute("randomIndex", randomIndex);
%>


<div class="Banner3_Area">
	<div class="guessULikeTopic">推薦飲品</div>
	<div class="guessULikeBox">
		<c:forEach items="${homePageAllProducts}" var="StoreProduct" varStatus="loop">
			<div class="<c:if test="${loop.index == randomIndex}" > guessULike </c:if>">
				
				<!-- 顯示圖片 -->
				<c:if test="${empty fn:trim(StoreProduct.pphoto)}">
					<div class="guessULikeImg"><img class="myimage" src="homePageStyleAndJs/assets/img/onDrinkImg.jpg" alt=""></div>
				</c:if>
				<c:if test="${StoreProduct.pphoto != null}">
					<div class="guessULikeImg"><img class="myimage" src="<%=request.getContextPath()%>/ProductIMG/${StoreProduct.pstoreid}${StoreProduct.proid}" alt=""></div>					
				</c:if>
				
				<!-- 顯示文字 -->
				<div class="guessULikeText">
					
					<!-- 顯示店家名稱 -->
					<c:forEach items="${homePageAllStores}" var="Store" >
					
						<c:if test="${Store.storeid == StoreProduct.pstoreid}" >
    					
    						<h2>${Store.title}</h2>
    						
    					</c:if>
    					
					</c:forEach>
					
					<!-- 顯示產品明細 -->
					<div><i class="bi bi-arrow-right-circle-fill"></i> ${StoreProduct.proname}</div>
					<div><i class="bi bi-arrow-right-circle-fill"></i> ${StoreProduct.category}</div>
					<div><i class="bi bi-arrow-right-circle-fill"></i> ${StoreProduct.pintro}</div>
				</div>
			</div>
		</c:forEach>
		<button id="NextguessULike" class="nextGuessULikeBtn">Next</button>
	</div>
	<script>
		// 必須要載入完整個檔案才能使用 jQuery
		window.onload =function(){
			
			// 猜你喜歡功能
			$("#NextguessULike").click(function(){
				
				// 取得改變前的 index
				let lastOneIndex = $(".guessULikeBox>div").index( $(".guessULike") );
				// 所有子元素消除 class : guessULike
				$(".guessULikeBox>div").removeClass("guessULike");
				
				// 取得亂數，並且和上次不同:
				let randIndex;
				do {
					
					randIndex = Math.floor(Math.random()*$(".guessULikeBox>div").length);
					//console.log("原本:",lastOneIndex)
					//console.log("產生:",randIndex);
					
				} while (randIndex == lastOneIndex);
				
				// 根據這次取得的亂數使不同 div 得到 class : guessULike
				$(".guessULikeBox>div").eq(randIndex).addClass("guessULike");
				
				
			});
			
		}
	</script>
</div>

<!--------------------------------- Banner_4 限時特價 --------------------------------->

<div class="Banner4_Area">
	<div class="activityTopic">限時特價</div>
	<div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
	
	  <!-- 顯示區塊 -->
	  <div class="carousel-inner activityBox">
		
	    <div class="carousel-item activityBox_item active">
	      <img src="homePageStyleAndJs/assets/img/homePageBanner.jpg" class="d-block w-100" alt="...">
	    </div>
		
		<!-- 所有的活動 -->
		<c:forEach items="${homePageAllActivitys}" var="ActivityBean">
		
		    <div class="carousel-item activityBox_item">
		    	
		    	<!-- 顯示圖片 -->
		    	<c:if test="${empty fn:trim(ActivityBean.activityImg)}">
					<img class="d-block w-100" src="homePageStyleAndJs/assets/img/onActivityImg.jpg" alt="">
				</c:if>
				<c:if test="${ActivityBean.activityImg != null}">
					<img class="d-block w-100" src="<%=request.getContextPath()%>/avtivityIMG/activity${ActivityBean.activityId}.png" alt="">				
				</c:if>
				
				<div class="activityItemText">
			    	<div class="itemTopic">${ActivityBean.activityTopic}</div>
			    	<div class="itemContent">&nbsp &nbsp ${ActivityBean.activityContent}</div>
			    	
			    	<!-- 限時特價活動中，只顯示該活動所屬的特價商品 -->
			    	<div class="activityItemDiscountDetail">
			    		<div class="activityItemDiscountDetail_Btn">
			    			<i class="bi bi-gift-fill"></i>
			    			<p>詳細內容</p>
			    		</div>
			    		<div class="activityItemDiscountDetail_Text" id="activityItemDiscountDetail_Text">
			    			
			    			<!-- 顯示中文店名 -->
		    				<c:forEach items="${homePageAllStores}" var="Store">
		    					
		    					<c:if test="${Store.storeid == ActivityBean.pstoreid}" >
		    					
		    						<h2>${Store.title}</h2>
		    						
		    					</c:if>
		    				
		    				
		    				</c:forEach>
							
							<!-- 顯示詳細折扣項目 -->
					    	<c:forEach items="${homePageAllDiscountItems}" var="activitydiscountitem" varStatus="loop2">
					    				
					    		
					    		<c:if test="${ActivityBean.activityId == activitydiscountitem.activityId }">
					    			
					    			<div class="discountItem">
						    			<div class="discountItemTitle"><i class="bi bi-check2"></i>${activitydiscountitem.proName }</div>
						    			<div>
						    				<span class="origPrice">原價: ${activitydiscountitem.proPrice }</span>
						    				<span class="discPrice">特價: ${activitydiscountitem.disPrice }</span>
						    			</div>
					    			</div>
					    			
					    		</c:if>
					    	
					    	</c:forEach>
				    	</div>
					</div>
				</div>
		    	
		    </div>
		    
	    </c:forEach>
		<!-- 
	    <div class="carousel-item">
	      <img src="homePageStyleAndJs/assets/img/drinkImg1.jpg" class="d-block w-100" alt="...">
	    </div>
	    -->

	  </div>
	  
	  
	  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Next</span>
	  </button>
	</div>

</div>


<!--------------------------------- 看看別人怎麼說 --------------------------------->
<div class= "otherTalk_Area">
	<div class="otherTalkTopic">討論區</div>
	<div class="otherTalkBox">
		<div class="otherTalkItem1">
			<a href="<%=request.getContextPath() %>/DiscussPage2Findall"><i class="bi bi-chat-dots"></i> 看看別人怎麼說</a>
		</div>
	</div>
</div>
<!--------------------------------- Banner_5 關於找茶 --------------------------------->
<div class="Banner5_Area">
	<div class="aboutFindTeaBox">
		<div class="findTeaTopic">
			關於 <span style="color: #ff9e1f;font-weight: 600;">找茶</span>
		</div>
		<div class="findTeaContent">
			<i class="bi bi-check2"></i>&nbsp正在煩惱要喝什麼嗎?上百種飲品任你選-加入會員。<br>
			<i class="bi bi-check2"></i>&nbsp優惠折扣，都在找茶。<br>
			<i class="bi bi-check2"></i>&nbsp輕鬆尋找飲品，一鍵下訂飲料。<br>
			<i class="bi bi-check2"></i>&nbsp歡迎各大飲品企業申請加入找茶平台。
		</div>
	</div>
</div>

