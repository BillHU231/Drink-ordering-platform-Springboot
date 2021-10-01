<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Login Page</title>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/loginCss/loginCss.css">
<!--宣告 CSS-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0"
	crossorigin="anonymous" />

</head>
<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>
	<div>
		<%--<div class="di1">
			<div class="login">
				<h1>登入</h1>
				<%
				//if (lon == null) {
				Cookie cke = null;
				Cookie[] cookies = null;
				String userRe = "";
				String usID = "";
				cookies = request.getCookies();
				if (cookies != null) {
					for (int i = 0; i < cookies.length; i++) {
						cke = cookies[i];
						String cc = cke.getName();
						if (cc.equals("UserID")) {
					usID = cke.getValue();
						}
						cc = cke.getName();
						if (cc.equals("remember_me")) {
					userRe = cke.getValue();
						}
					}
				}
				if (userRe != null && !"".equals(userRe)) {
					userRe = "checked";
				}
				%>

				<!--  <form action="/loginInf" method="post">-->
				<div class="validate-input">
					<input id="userID" class="input100 form-control"
						style="padding: 0 10px 0 25px;" type="text" value="<%=usID%>"
						placeholder="請輸入帳號" autocomplete="off"> <span
						class="focus-input100"></span> <span class="symbol-input100">
						<i class="fa fa-user"></i>
					</span>
					
				</div>
				<p id="errID" class="err"></p>

				<div class="validate-input">
					<input id="pwd" class="input100 form-control" style="padding: 0 10px 0 25px;" type="password"
						placeholder="請輸入密碼"> <span class="focus-input100"></span>
					<span class="symbol-input100"> <i class="fa fa-lock"></i>
					</span>
					
				</div>
				
				<p id="errPwd" class="err"></p>
				
				<div class="remember_me">
					<div class="form-check form-switch">
						<input id="remember_me" class="form-check-input"
							style="float: none" type="checkbox" id="remember_me"
							name="remember_me" value="remember_me" <%=userRe%> /> <label
							class="form-check-label" for="remember_me">記住我</label>
					</div>
				</div>

				<p class="submit">
					<button id="butt1" style="margin-right: 20px"
						class="btn btn-primary" type="submit" name="sub" value="login">登入</button>
					<button id="butt7" class="btn btn-secondary" type="submit"
						name="sub" value="cancel">取消</button>
					<br> <br>
					<button id="butt4" class="btn btn-outline-success" type="submit"
						name="sub" value="cancel" style="font-size: 12px">一般會員</button>
					<button id="butt5" class="btn btn-outline-success" type="submit"
						name="sub" value="cancel" style="font-size: 12px">企業會員</button>
					<button id="butt6" class="btn btn-outline-success" type="submit"
						name="sub" value="cancel" style="font-size: 12px">管理員</button>
					<!-- <button class="btn btn-warning" type="submit" name="sub" value="autoLogin">一鍵登入</button> -->
				</p>
				<div>
					<p class="new_member">
						<a href="<%=request.getContextPath()%>/NewMember">註冊會員</a>
					</p>
				</div>

				<div class="login-help">
					<p class="pp">
						忘記密碼嗎? <a href="<%=request.getContextPath()%>/ForgotPassword">找回密碼</a>
					</p>
					<p id="errorPwd" class="err"></p>
					
					<%
					//} //if
					if (lon != null) {
					String lonID = (String) request.getSession().getAttribute("UserID");
					%>
					<p class="lop"><%=lonID%>
						是否登出?
					</p>
					<button class="btn btn-primary" id="butt3" type="submit" name="sub"
						value="longout">登出</button>
					<!-- <button class="btn btn-secondary" id="butt2" type="submit"
						name="sub" value="cancel">取消</button> -->
					<%
					}
					%> 
					
				</div>
				<!--  </form>-->
			</div>
		</div> --%>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8"
		crossorigin="anonymous"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#errID").text("");
			$("#errPwd").text("");
			$("#errorPwd").text("");
			//送出
			$("#butt1").click(function() {
				var userID = $("#userID").val();
				var userPaws = $("#pwd").val();
				var remCk = $("#remember_me").prop("checked");
				var rem = "rem_N";
				if (remCk) {
					rem = "rem_Y";
				}
				$("#errID").text("");
				$("#errPwd").text("");
				$("#errorPwd").text("");

				var params = {
					"userID" : userID,
					"userPaws" : userPaws,
					"remember_me" : rem
				};
				//console.log(params);
				$.ajax({
					type : 'post',
					url : 'loginInf',
					//dataType:'JSON',
					contentType : 'application/json',
					data : JSON.stringify(params),
					//async : false,
					//data : params,
					success : function(reps) {
						//console.log(reps);
						$("#errID").text(reps["er_usID"]);
						$("#errPwd").text(reps["er_pwd"]);
						$("#errorPwd").text(reps["errorPwd"])
						if (reps["re_Page"] == "a") {
							self.location = "HomePage";
						}
						if (reps["re_Page"] == "b") {
							self.location = "ToVendorPage";
						}
						if (reps["re_Page"] == "fa") {
							self.location = "getMemberData";
						}
						if (reps["re_Page"] == "fb") {
							self.location = "getMemberData";
						}
						if (reps["re_Page"] == "gm") {
							self.location = "ToBackStagePage";
						}
					}
				});
			});

			//取消
			$("#butt7").click(function() {
				console.log("sss");
				$("#errID").text("");
				$("#errPwd").text("");
				$("#errorPwd").text("");

				self.location = "HomePage";
			});

			//登出
			$("#butt3").click(function() {
				$.ajax({
					type : 'GET',
					url : 'loginOut',
					contentType : 'application/json',
					success : function(reps) {
						console.log(reps);
						self.location = "HomePage";
					}
				})
			});

			//一般會員一鍵登入
			$("#butt4").click(function() {
				var params = {
					"userID" : "a123456",
					"userPaws" : "a123",
					"remember_me" : ""
				};
				$.ajax({
					type : 'post',
					url : 'loginInf',
					contentType : 'application/json',
					data : JSON.stringify(params),
					success : function(reps) {
						//console.log(reps);
						self.location = "HomePage";
					}
				})
			});

			//企業會員一鍵登入
			$("#butt5").click(function() {
				var params = {
					"userID" : "b123456",
					"userPaws" : "a123",
					"remember_me" : ""
				};
				$.ajax({
					type : 'post',
					url : 'loginInf',
					contentType : 'application/json',
					data : JSON.stringify(params),
					success : function(reps) {
						//console.log(reps);
						self.location = "HomePage";
					}
				})
			});

			//管理員一鍵登入
			$("#butt6").click(function() {
				var params = {
					"userID" : "admin",
					"userPaws" : "admin",
					"remember_me" : ""
				};
				$.ajax({
					type : 'post',
					url : 'loginInf',
					contentType : 'application/json',
					data : JSON.stringify(params),
					success : function(reps) {
						//console.log(reps);
						self.location = "ToBackStagePage";
					}
				})
			});

		});
	</script>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>
</body>
</html>