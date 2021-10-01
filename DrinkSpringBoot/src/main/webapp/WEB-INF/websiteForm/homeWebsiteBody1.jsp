<%@page import="tw.drink.shopcar.model.ShopCarBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- 連結: 放body裡第一行
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp" %>
--%>
<%
	// 編碼設定
	response.setContentType("text/html;charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>	
<%
	// 取得帳號資料
	String UserID = (String)session.getAttribute("UserID");
	String ClassMember = (String)session.getAttribute("ClassMember");
	String Vat = (String)session.getAttribute("Vat");
	String Longin = (String)session.getAttribute("Longin");
	String gName = (String)session.getAttribute("G_Name");
	String userName = (String)session.getAttribute("UserName");
	

	
	
	
	
	
	String printName = userName;
	if("gg".equals(ClassMember)){
		printName = gName;
	}
	// Longin != null 為已登入狀態
	// Longin == null 為未登入狀態
	
	// 全部連結表:
	// 未登入
	String logoinLink = "'" + request.getContextPath() + "/LoginPage'"; 	// 登入按鈕
	String homePageLink = "'" + request.getContextPath() + "/HomePage'"; 	// 首頁連結
	String signUpLink = "'" + request.getContextPath() + "/NewMember'";		// 註冊連結
	String logoutLink = "'" + request.getContextPath() + "/LoginPage'";		// 登出
	// 一般會員
	String memberDataLink =null;	// 會員基本資料
	String orderNowLink =null;		// 購物車
	String orderQueryLink =null;	// 訂單查詢
	String commentLink =null;		// 我要評論
	String findFoodLink=null;		//想喝什麼
	// 企業會員
	String enterpriseDataLink =null;// 企業會員基本資料
	String storeManageLink =null;	// 店家管理
	String enterpriseOrderLink =null;	// 企業端訂單
	String enterpriseActivityLink =null;// 企業端活動管理
	
	// 判斷:是 未登入、一般會員、企業會員
	if(Longin == null){ // 未登入狀態
		
		System.out.println("--------------------------------------------");
		System.out.println("未登入狀態");
		System.out.println("--------------------------------------------");
		
		memberDataLink = "'#'";
		orderNowLink = "'#'";
		orderQueryLink = "'#'";
		commentLink = "'#'";
		
	}else if( ClassMember.equals("a") || ClassMember.equals("fa") ){ // 一般會員登入
		
		System.out.println("--------------------------------------------");
		System.out.println("一般會員登入");
		System.out.println("--------------------------------------------");
		
		findFoodLink ="'"+ request.getContextPath() + "/search.controller'";				//想喝什麼
		memberDataLink = "'"+ request.getContextPath() + "/ModifyMember'";					// 會員資料    
        orderNowLink = "'"+ request.getContextPath() + "/initShopCar.controller'";         	// 購物車
        orderQueryLink = "'"+ request.getContextPath() +"/selectAllOrderss.controller'";    // 訂單查詢
        commentLink = "'"+ request.getContextPath() +"/productmainpage.controller'";        // 我要評論

	}else if( ClassMember.equals("b") || ClassMember.equals("fb") ){ // 企業會員登入
		
		System.out.println("--------------------------------------------");
		System.out.println("企業會員登入");
		System.out.println("--------------------------------------------");
		
		enterpriseDataLink ="'"+ request.getContextPath() + "/ModifyMember'"; 
		storeManageLink ="'"+ request.getContextPath() +"/storeSystemEntry.controller'"; 
		enterpriseOrderLink ="'"+ request.getContextPath() +"/accountstoreneworder.controller'"; 
		enterpriseActivityLink ="'"+ request.getContextPath() +"/manageActivity.controller'";
		
	}else if(( ClassMember.equals("ga") || ClassMember.equals("gab") ) && "success_g".equals(Longin)){ // 一般會員登入 google
		
		System.out.println("--------------------------------------------");
		System.out.println("一般會員登入");
		System.out.println("--------------------------------------------");
		
		findFoodLink ="'"+ request.getContextPath() + "/search.controller'";				//想喝什麼
		memberDataLink = "'"+ request.getContextPath() + "/ModifyMember'";					// 會員資料    
        orderNowLink = "'"+ request.getContextPath() + "/initShopCar.controller'";         	// 購物車
        orderQueryLink = "'"+ request.getContextPath() +"/selectAllOrderss.controller'";    // 訂單查詢
        commentLink = "'"+ request.getContextPath() +"/productmainpage.controller'";        // 我要評論

	}else if( ( ClassMember.equals("gb") || ClassMember.equals("gab") ) && "success_v".equals(Longin) ){ // 企業會員登入 google
		
		System.out.println("--------------------------------------------");
		System.out.println("企業會員登入");
		System.out.println("--------------------------------------------");
		
		enterpriseDataLink ="'"+ request.getContextPath() + "/ModifyMember'"; 
		storeManageLink ="'"+ request.getContextPath() +"/storeSystemEntry.controller'"; 
		enterpriseOrderLink ="'"+ request.getContextPath() +"/accountstoreneworder.controller'"; 
		enterpriseActivityLink ="'"+ request.getContextPath() +"/manageActivity.controller'";
		
	}
	
	
	
	//System.out.println("UserID="+UserID);
	//System.out.println("ClassMember="+ClassMember);
	//System.out.println("Vat="+Vat);
	System.out.println("Longin="+Longin);

%>	
<!-- Header 標頭 -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container px-4 px-lg-5" style=" max-width: 1320px;">
        <!-- logo 變色效果 CSS:11518行 -->
        <a class="navbar-brand myHeaderLogoFont" href=<%= homePageLink %> style="font-size:40px;"><img class="myHeaderLogoImg" src="homePageStyleAndJs/assets/img/logo.png">找茶</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
            
            <%
            if(Longin == null){	// 未登入狀態
            %>	
            	<%-- <li class="nav-item"><a class="nav-link myHeaderItem" href=<%= orderNowLink %> ><i class="bi bi-cart-check"></i>購物車</a></li> --%>
              	<li id="loginInf" class="nav-item"><a type="button" class="nav-link myHeaderItem" ><i class="bi bi-person-circle"></i>登入</a></li>
                <li id="newMemInf" class="nav-item"><a type="button" class="nav-link myHeaderItem" ><i class="bi bi-brightness-high"></i>註冊</a></li>
            <%	
            }else if( ClassMember.equals("a") || ClassMember.equals("fa") ){ // 一般會員登入
            %>
            	<li class="nav-item"><a class="nav-link myHeaderItem" href=<%= findFoodLink %> ><i class="bi bi-search"></i>在找什麼嗎?</a></li>
            	<li class="nav-item"><a class="nav-link myHeaderItem" href=<%= commentLink %> ><i class="bi bi-chat-square-dots"></i>我要評論</a></li>
                <li class="nav-item"><a class="nav-link myHeaderItem" href=<%= orderQueryLink %> ><i class="bi bi-clipboard-check"></i>訂單查詢</a></li>
                <li class="nav-item" id="shopcars"><a class="nav-link myHeaderItem" href=<%= orderNowLink %> ><i class="bi bi-cart-check"></i>購物車</a></li>
                   <div id="myshopcar" style="background-color: #ACD6FF; width: 340px; top: 82px; right: 24%; position: fixed;display:none ">
		                 <h4 style="text-align: center;color: black;">購物車</h4>
		                 <div class='shopcarbody' >
		                 <c:if test="${car!=null&&car.size()>0}">
		                       <c:forEach items="${car}" var="item">
		                       <div class="prouct${item.getProuctID() }" style='position: relative;'>
		                       <img alt="" src="<c:out value="${request.contextPath}"/>/Drink/shopcarimages/prouct${ item.getProuctID()}.jpg" style="width: 70px">
		                       <h6 style='color: black;display: inline-block;vertical-align: top;font-weight: 700;'>${item.getProuctName()} </h6>
		                       <i style='color: red;display: block;'>NT$${ item.getPrice()} </i>
		                       <img alt="" style="display: block;position: absolute;top: 0;right: 0;" src="<c:out value="${request.contextPath}"/>/Drink/shopcarimages/garbage.png" onclick="deleteprouct(${ item.getProuctID()})">
		                       <hr>
		                       </div>
		                       </c:forEach>		                    
		                 </c:if>
		                    

		                </div>   
	                   </div>  
                <li class="nav-item"><a class="nav-link myHeaderItem" href=<%= memberDataLink %> ><i class="bi bi-person-circle"></i><%=printName%></a></li>
                <li id="logoutInf" class="nav-item"><a class="nav-link myHeaderItem" href="#" ><i class="bi bi-door-open-fill"></i>登出</a></li>
            <%	
            }else if( ClassMember.equals("b") || ClassMember.equals("fb") ){ // 企業會員登入
            %>
            	<!--  <li class="nav-item"><a class="nav-link myHeaderItem" href=<%= enterpriseOrderLink %> ><i class="bi bi-clipboard-check"></i>即時訂單</a></li>-->
            	<!-- <li class="nav-item"><a class="nav-link myHeaderItem" href=<%= enterpriseActivityLink %> ><i class="bi bi-gift"></i>優惠活動</a></li> -->
            	<li class="nav-item"><a class="nav-link myHeaderItem" href=<%= storeManageLink %> ><i class="bi bi-house-door"></i>店家管理</a></li>
            	<li class="nav-item"><a class="nav-link myHeaderItem" href=<%= enterpriseDataLink %> ><i class="bi bi-person-circle"></i><%=printName%></a></li>
            	<li id="logoutInf" class="nav-item"><a type="button" class="nav-link myHeaderItem" ><i class="bi bi-door-open-fill"></i>登出</a></li>
            <% 
            }else if(( ClassMember.equals("ga") || ClassMember.equals("gab") ) && "success_g".equals(Longin) ){ // 一般會員登入 google
            %>
            	<li class="nav-item"><a class="nav-link myHeaderItem" href=<%= findFoodLink %> ><i class="bi bi-search"></i>在找什麼嗎?</a></li>
            	<li class="nav-item"><a class="nav-link myHeaderItem" href=<%= commentLink %> ><i class="bi bi-chat-square-dots"></i>我要評論</a></li>
                <li class="nav-item"><a class="nav-link myHeaderItem" href=<%= orderQueryLink %> ><i class="bi bi-clipboard-check"></i>訂單查詢</a></li>
                <li class="nav-item" id="shopcars"><a class="nav-link myHeaderItem" href=<%= orderNowLink %> ><i class="bi bi-cart-check"></i>購物車</a></li>
                              <div id="myshopcar" style="background-color: #ACD6FF; width: 340px; top: 82px; right: 24%; position: fixed;display:none ">
		                 <h4 style="text-align: center;color: black;">購物車</h4>
		                 <div class='shopcarbody' >
		                 <c:if test="${car!=null&&car.size()>0}">
		                       <c:forEach items="${car}" var="item">
		                       <div style='position: relative;'>
		                       <img alt="" src="<c:out value="${request.contextPath}"/>/Drink/shopcarimages/prouct${ item.getProuctID()}.jpg" style="width: 70px">
		                       <h6 style='color: black;display: inline-block;vertical-align: top;font-weight: 700;'>${item.getProuctName()} </h6>
		                       <i style='color: red;display: block;'>NT$${ item.getPrice()} </i>
		                       <img alt="" style="display: block;position: absolute;top: 0;right: 0;" src="<c:out value="${request.contextPath}"/>/Drink/shopcarimages/garbage.png" onclick="deleteprouct(${ item.getProuctID()})">
		                       <hr>
		                       </div>
		                       </c:forEach>		                    
		                 </c:if>
		                    

		                </div>   
	                   </div>  
                <li class="nav-item"><a class="nav-link myHeaderItem" href=<%= memberDataLink %> ><i class="bi bi-person-circle"></i><%=printName%></a></li>
                <li id="logoutInf" class="nav-item"><a class="nav-link myHeaderItem" href="#" ><i class="bi bi-door-open-fill"></i>登出</a></li>
            <%	
            }else if( ( ClassMember.equals("gb") || ClassMember.equals("gab") ) && "success_v".equals(Longin) ){ // 企業會員登入 google
            %>
            	<!-- <li class="nav-item"><a class="nav-link myHeaderItem" href=<%= enterpriseOrderLink %> ><i class="bi bi-clipboard-check"></i>即時訂單</a></li> -->
            	<!-- <li class="nav-item"><a class="nav-link myHeaderItem" href=<%= enterpriseActivityLink %> ><i class="bi bi-gift"></i>優惠活動</a></li> -->
            	<li class="nav-item"><a class="nav-link myHeaderItem" href=<%= storeManageLink %> ><i class="bi bi-house-door"></i>店家管理</a></li>
            	<li class="nav-item"><a class="nav-link myHeaderItem" href=<%= enterpriseDataLink %> ><i class="bi bi-person-circle"></i><%=printName%></a></li>
            	<li id="logoutInf" class="nav-item"><a type="button" class="nav-link myHeaderItem" ><i class="bi bi-door-open-fill"></i>登出</a></li>
            <% 
            }
            %>
            
            </ul>
        </div>
    </div>
</nav>
<!-- Header 底色 --> 
<div style="height: 96px;background-color: rgb(255, 158, 31);"></div>
	
	<%
	if(Longin == null){	// 未登入狀態
	%>	
		<div class="homePage_Content" style="min-height: 550px;">
	<%	
    }else if( ClassMember.equals("a") || ClassMember.equals("fa") ){ // 一般會員登入
    %>
    	<div class="homePage_Content" style="min-height: 550px;">
   	
   	<%	
    }else if( ClassMember.equals("b") || ClassMember.equals("fb") ){ // 企業會員登入
    %>
   		<div class="enterpriseContent" style="min-height: 550px;">
    <% 
    }
    %>
    

  




