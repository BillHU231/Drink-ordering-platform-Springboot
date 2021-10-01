<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="tw.drink.store.model.StoreProduct" 
	import="java.util.ArrayList" 
	import="java.util.List" 
	import="tw.drink.activity.model.ActivityBean" 
	import="tw.drink.activity.model.ActivityDiscountItem"

%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 <!-- 輪播圖 -->
<div id="carouselExampleCaptions" class="carousel slide Banner1_Area" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active Banner1_Box1">
      <img src="homePageStyleAndJs/assets/img/homePageBanner.jpg" class="d-block w-100" alt="A">
      <div class="carousel-caption d-none d-md-block Banner1_Box1_text">
        <h5>歡迎來到 找茶</h5>
        <p>包含全台飲料據點，最新流行飲品</p>
      </div>
    </div>
    <div class="carousel-item Banner1_Box2">
      <img src="homePageStyleAndJs/assets/img/drinkImg1.jpg" class="d-block w-100" alt="B">
      <div class="carousel-caption d-none d-md-block Banner1_Box2_text">
        <h5>New!</h5>
        <p>熱銷飲品</p>
      </div>
      <div style="position:absolute; top:25%; left:60%;text-shadow: 2px 2px 3px rgba(0,0,0,0.3); ">
      	<!-- 隨機1~10 -->
      	<c:set var="randX"><%= java.lang.Math.round(java.lang.Math.random()*9)+1 %></c:set>
      	<c:forEach items="${homePageAllProducts}" var="StoreProduct2"  varStatus="status" >
      		<c:if test="${status.count==randX}">
      			<h1 style="font-size:50px;margin-bottom:40px;font-weight:600;">${StoreProduct2.proname}</h1>
      			<h2 style="margin-bottom:20px;">${StoreProduct2.pintro}</h2>
      			<h2 style="">${StoreProduct2.proprice} 元</h2>
      		</c:if>
      	</c:forEach>
      </div>
    </div>
    <div class="carousel-item Banner1_Box3">
      <img src="homePageStyleAndJs/assets/img/drinkImg2.jpg" class="d-block w-100" alt="C">
      <div class="carousel-caption d-none d-md-block Banner1_Box3_text">
        <h5>
        	<a href="#" style="text-decoration:none;under-line:none">
        		<span class="popularTag">熱門飲品</span><br><span class="moreTag">看看更多</span>
        	</a>
        </h5>
      </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>