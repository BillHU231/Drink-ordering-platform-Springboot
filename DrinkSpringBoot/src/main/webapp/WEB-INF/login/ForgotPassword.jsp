<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForgotPassword</title>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>

<!-- jQuery -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/Library/jquery-ui-1.12.1/jquery-ui.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/loginCss/forgotPassword.css">

</head>
<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>
	<div class="d1">
		<div class="d1-fg">
	
			<section>
				<form id="nForm" action="<%=request.getContextPath()%>/ForgotPasswordChack" method="get">
					<input type="hidden" id="cla" name="type" value="form-a" />
					<fieldset class="fie-fg">
						<legend class="leg-fg">找回密碼</legend>
	
						<%
						String sel_A = "selected";
						String sel_B = "";
						String type_A = "text";
						String type_B = "hidden";
						String sty_A = "";
						String sty_B = "style =\"display:none\"";
	
						String type_fg = "text";
						String sty_fg = "";
						String sty_fg1 = "style =\"display:none\"";
	
						String formN = (String) request.getAttribute("Type");
						//String formN= (String) request.getSession().getAttribute("Type");
						String fgString = (String) request.getAttribute("Type_fg");
						//String fgString= (String) request.getSession().getAttribute("Type_fg");
						if (formN != null) {
							if (formN.equals("A")) {
								sel_A = "selected";
								sel_B = "";
								type_A = "text";
								type_B = "hidden";
								sty_A = "";
								sty_B = "style =\"display:none\"";
							}
							if (formN.equals("B")) {
								sel_A = "";
								sel_B = "selected";
								type_A = "hidden";
								type_B = "text";
								sty_A = "style =\"display:none\"";
								sty_B = "";
							}
						}
						if ("fg".equals(fgString)) {
							type_A = "hidden";
							type_B = "hidden";
							type_fg = "hidden";
							sty_A = "style =\"display:none\"";
							sty_B = "style =\"display:none\"";
							sty_fg = "style =\"display:none\"";
							sty_fg1 = "";
						}
						%>
	
	
						<div <%=sty_fg%>>
						<span style="font-size:20px;">會員類別選擇</span>
							<select id="sel" class="form-select" style="width: 200px;padding: 3px 12px" <%=sty_fg%>>
								<option value="memberA" <%=sel_A%>>一般會員</option>
								<option value="memberVendorB" <%=sel_B%>>企業會員</option>
							</select>
						</div>
						<div class="dd1-fg">
							<div>
								<label for="userID" <%=sty_fg%>>帳號：</label> 
								<input type="<%=type_fg%>" class="form-control" id="userID" name="userID" value="" style="width: 150px" autocomplete="off"/>
							</div>
							<div>
	
								<%
								//String asErr = (String) request.getSession().getAttribute("Message");
								String asErr = (String) request.getAttribute("Message");
								if (asErr != null) {
								%>
								<span style="color: red; font-size: 30px">請填寫完整資訊</span>
								<%
								//session.invalidate();
								}
								%>
							</div>
						</div>
						<div class="dd1-fg">
							<div>
								<label for="birthday" <%=sty_A%>>出生年月日：</label> 
								<input type="<%=type_A%>" id="birthday" class="form-control" placeholder="格式:2021/09/24" name="birthday" value="" style="width: 150px" autocomplete="off" /> 
									
								<label for="principal" <%=sty_B%>>負責人：</label> 
								<input type="<%=type_B%>" name="principal" class="form-control" value=""	style="width: 150px" autocomplete="off"/>	
	
								<%
								//String senEmail = (String) request.getSession().getAttribute("Type_fg");
								String senEmail = (String) request.getAttribute("Type_fg");
								if (senEmail != null) {
									if (senEmail.equals("fg")) {
								%>
								<div style="width: 600px">
									<h1 class="ddh1" style="color: red;">密碼已經寄至您信箱</h1>
								</div>
								<%
								//session.invalidate();
								}
								}
								%>
							</div>
							<div>
								<label for="vat" <%=sty_B%>>統一編號：</label> 
								<input type="<%=type_B%>" id="vat" class="form-control" name="vat" value="" style="width: 150px" autocomplete="off"/>
	
							</div>
						</div>
	
						<div class="dd1-fg">
							<div>
								<label for="email" <%=sty_fg%>>E-mail：</label> 
								<input type="<%=type_fg%>" name="email" class="form-control" value="" style="width: 300px" autocomplete="off" />
							</div>
						</div>
	
						<div class="btnn-fg">
							<button class="btn btn-primary" type="submit" id="sub1" name="sub" value="forgChack"
								<%=sty_fg%>>送出</button>
							<button class="btn btn-warning" type="submit" name="sub" value="cancel" <%=sty_fg%>>取消</button>
							<button id="fg-black" class="btn btn-success" name="sub" value="black" <%=sty_fg1%>>返回</button>
						</div>
					</fieldset>
				</form>
	
			</section>
		</div>
	</div>
	
	
	
	<div class="modal fade" id="loading-email" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" style="margin:320px auto; width: 300px; text-align: center">
			<div class="spinner-border text-primary" role="status">
			  <span class="visually-hidden">Loading...</span>
			</div>
		</div>
	</div>
	
	
	
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>
	
	<script src="<%=request.getContextPath()%>/Library/jquery-3.6.0.js"></script>
	<script src="<%=request.getContextPath()%>/Library/jquery-ui-1.12.1/jquery-ui.js"></script>
	<!-- sweetalert2 -->
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
		$(function() {
			//日期選擇
			$("#birthday").datepicker({
				dateFormat : 'yy-mm-dd',
				changeMonth : true,
				changeYear : true
			});
		
			$("#sub1").click(function () {
				addFormN();
				load();
				submit();
			})
			
			function load() {
				$('#loading-email').css('background', 'rgba(255,255,255,0.4)'); 
				$('#loading-email').modal({backdrop: 'static'});
				$('#loading-email').modal('show')
			}
			
		})
		
		
		//選擇類別
		document.addEventListener("DOMContentLoaded", function() {
					document.getElementById("sel").addEventListener("change",
							ss);
					//document.getElementById("sub1").addEventListener("click", addFormN);
					//document.getElementById("sub2").addEventListener("click",addFormN);
				});
		//
		
		function ss() {
			let se = document.getElementById("sel").value
			if (se == "memberA") {
				//隱藏碼
				document.getElementById("cla").value = "form-a"
				document.getElementById("nForm").submit();
			}
			if (se == "memberVendorB") {
				document.getElementById("cla").value = "form-b"
				document.getElementById("nForm").submit();
			}
		}
		//送出編碼
		//document.getElementById("sub1").click = addFormN;
		function addFormN() {
			let se = document.getElementById("sel").value
			if (se == "memberA") {
				//隱藏碼
				document.getElementById("cla").value = "form-a"
			}
			if (se == "memberVendorB") {
				document.getElementById("cla").value = "form-b"
			}
		}
	</script>

</body>
</html>