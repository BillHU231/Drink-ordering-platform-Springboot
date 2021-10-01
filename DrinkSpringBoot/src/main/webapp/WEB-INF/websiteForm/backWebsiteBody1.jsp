<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 連結: 放body裡第一行
	<%@ include file="/WEB-INF/websiteForm/backWebsiteBody1.jsp" %>
--%>
<%
// 編碼設訂
response.setContentType("text/html;charset=UTF-8");
request.setCharacterEncoding("UTF-8");
%>
<%
// 取得帳號資料
String UserID = (String) session.getAttribute("UserID");
String ClassMember = (String) session.getAttribute("ClassMember");
String Vat = (String) session.getAttribute("Vat");
String Longin = (String) session.getAttribute("Longin");
// Longin != null 為已登入狀態
// Longin == null 為未登入狀態

// 未登入、已登入側邊欄各項目連結不一樣
String enterpriseDataLink = null;
String storeManageLink = null;

String orderQueryLink = null;
String commentLink = null;
String activityLink = null;

if (Longin == null) { // 未登入狀態

	enterpriseDataLink = "'#'";
	storeManageLink = "'#'";
	activityLink = "'#'";

} else { // 已登入狀態

	//enterpriseDataLink = "'" + request.getContextPath() + "/ModifyMember'";
	//storeManageLink = "'" + request.getContextPath() + "/checkLoginEntry.controller'";
	//activityLink = "'" + request.getContextPath() + "/manageActivity.controller'";

}

//System.out.println("UserID="+UserID);
//System.out.println("ClassMember="+ClassMember);
//System.out.println("Vat="+Vat);
System.out.println("Longin=" + Longin);
%>
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
	<!-- Navbar Brand-->
	<a class="navbar-brand ps-3 myFontTC myLetterSpace2"
		href="<%=request.getContextPath()%>/ToBackStagePage">Drink</a>
	<!-- Sidebar Toggle
	<button
		class="myNavBtnDisappear btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
		id="sidebarToggle" href="#!">
		<i class="fas fa-bars"></i>
	</button>
	-->
	<!-- Navbar Search-->
	<form
		class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
		<div class="input-group">
			<!-- 
                        搜尋欄
                        <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                        <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                     -->
		</div>
	</form>

	<%
	// 登錄成功狀態
	if (Longin != null) {
	%>
	<div class="myFontTC myFontColorWhite myLetterSpace2 ">
		<%=UserID%>
	</div>	
	<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
		<li  class="nav-item dropdown">
		<a id="logoutInf" class="nav-link dropdown-toggle"
			href="#" role="button" data-bs-toggle="dropdown"
			aria-expanded="false">
			<i class="fas fa-user fa-fw"></i></a>
			<%--
			<ul class="dropdown-menu dropdown-menu-end"
				aria-labelledby="navbarDropdown">
				<!-- LinkTag-登出 -->
				
				<li ><a class="dropdown-item myFontTC myTextCenter"
					style="text-align: center"
					href="<%=request.getContextPath()%>/LoginPage">登出</a>
				 </li>
			</ul>
			--%>
		</li>
	</ul>
	<%
	}
	%>

	<%
	// 未登錄狀態
	if (Longin == null) {
	%>

	<!-- LinkTag-登入 -->
	<a href="HomePage" class="mySignUpBtn"><i class="fas fa-user"></i></a>
	<!-- LinkTag-註冊 -->
	<!--<a href="NewMemberAll.jsp" class="mySignUpBtn">註冊</a>-->

	<%
	}
	%>

</nav>
<div id="layoutSidenav">
	<div id="layoutSidenav_nav">
		<nav class="sb-sidenav accordion sb-sidenav-dark"
			id="sidenavAccordion">
			<div class="sb-sidenav-menu">
				<div class="nav">
					<div class="sb-sidenav-menu-heading myLetterSpace2">選單</div>
					<!-- LinkTag-企業資訊 -->
					<a class="nav-link myFontTC myLetterSpace2" href="<%=request.getContextPath() %>/MemberManager"> 
					<!-- <div class="sb-nav-link-icon"> -->
						<i class="far fa-address-card"></i> 
						<!--</div> --> 
						&nbsp;帳號管理
					</a> 
					<a class="nav-link myFontTC myLetterSpace2" href="<%=request.getContextPath() %>/storeManagerEntry.controller"> 
					<!-- <div class="sb-nav-link-icon"> -->
						<i class="fas fa-store-alt"></i> 
						<!--</div> --> 
						&nbsp;店家管理
					</a> 
					<a class="nav-link myFontTC myLetterSpace2" href="<%=request.getContextPath() %>/toBackActivity.controller"> 
					<!-- <div class="sb-nav-link-icon"> -->
						<i class="fas fa-tachometer-alt"></i> 
						<!--</div> --> 
						&nbsp;活動管理
					</a> 
					<!--<a class="nav-link myFontTC myLetterSpace2" href="#"> 
					 <div class="sb-nav-link-icon">
						<i class="fas fa-shopping-cart"></i> 
						<!--</div> --> 
						<!--&nbsp;訂單管理-->
					<!--  </a> -->
					
					<a class="nav-link myFontTC myLetterSpace2" href="<%=request.getContextPath() %>/DiscussBackPage"> 
					<!-- <div class="sb-nav-link-icon"> -->
						<i class="fas fa-comment-dots"></i>
						<!--</div> --> 
						&nbsp;論壇管理
					</a>
							<!--
                            <div class="sb-sidenav-menu-heading myLetterSpace2">店家</div>
                              
                            <a class="nav-link collapsed myFontTC myLetterSpace2" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                管理
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link myFontTC myLetterSpace2" href="/Drink/storeSystemEntry.controller" >店家管理</a>
                            -->
							<!--<a class="nav-link myFontTC myLetterSpace2" href="#">新增店家</a> -->
							<!--<a class="nav-link myFontTC myLetterSpace2" href="#">查詢店家</a> -->
							<!--<a class="nav-link myFontTC myLetterSpace2" href="#">修改店家</a> -->
							<!--<a class="nav-link myFontTC myLetterSpace2" href="#">刪除店家</a> -->
					<%--<a class="nav-link myFontTC myLetterSpace2" href=<%=activityLink%> >店家活動</a><!-- 2021/8/4 臨時加 -->
                                </nav>
                            </div>
                            --%>
					<!--  -->
				</div>
			</div>

		</nav>
	</div>
	<div id="layoutSidenav_content">
		<main>
			<div class="container-fluid px-4">
			
			
			
