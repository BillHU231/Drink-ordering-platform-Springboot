<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ModifyMemberVendor</title>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/newMemberCss/modifyMember.css">
</head>
<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>
	
<div class="d1">
	<div class="d1-check">
		<section>
			<%-- <form id="nForm" action="<%=request.getContextPath()%>/modifyMenberController" method="post"> --%>
				<input id="m-cla" type="hidden" name="type" value="form-b_mo" />
				<fieldset class="fie-check">
					<legend class="leg-check">企業會員資料修改</legend>
					<%String idClass = (String) request.getSession().getAttribute("ClassMember"); %>
						<%
	              		if("fa".equals(idClass)){
	              		%>
				           <h1 style="color: red">請先修改密碼</h1>
				        <%	
				        }
				        %>
						<%
	              		if("gg".equals(idClass)){
	              		%>
				           <h1 style="color: red">請先填寫完整資料</h1>
				        <%	
				        }
				        %>
					<div class="dd1-check">
						<div>
							<label id="lab-ven-id" for="inp-ven-id">帳號：</label>
							<input id="inp-ven-id" class="form-control" type="hidden" name="userID" value="" />
							<input id="inp-ven-gclass" class="form-control" type="hidden" value="" /> 
						</div>
						<div>
							<label for="inp-ven-vendor">企業名稱：</label>
							<input id="inp-ven-vendor" class="form-control" type="text" value="" />
						</div>
					</div>
					<div class="dd1-check">
						<div>

							<label for="inp-ven-pws">密碼：</label>
							
							<input id="inp-ven-pws" class="form-control" type="password" name="pws" value="" />
							
							<span id="inp-ven-pwsW" class="spa">至少6個字且必須包含英數字</span>
						</div>
						<div>
							<label for="inp-ven-passwordck">密碼確認：</label>
							
							<input id="inp-ven-passwordck" class="form-control" type="password" name="passwordck" value=""/>
							
							<span id="inp-ven-pwsckW" class="spa">&nbsp;</span>
						</div>
					</div>
					<div class="dd1-check">
						<div>
							<label for="inp-ven-principal">負責人：</label>
							
							<input id="inp-ven-principal" class="form-control" type="text" name="name" value=""  autocomplete="off"/>
							
						</div>
						<div>
							<label for="inp-ven-vat">統一編號：</label>
							
							<input  id="inp-ven-vat" class="form-control" type="text" name="birthday" value="" autocomplete="off"/>
							
						</div>
					</div>
					<div class="dd1-check" style="justify-content: left;">
						<div>
							<label for="inp-ven-address">住址：</label>
							<input id="inp-ven-address" class="form-control" type="text" name="email" value="" style="width: 100%;"
								autocomplete="off" />
						</div>
					</div>
					<div class="dd1-check" style="justify-content: left;">
						<div>
							<label for="inp-ven-email">E-mail：</label>
							<input id="inp-ven-email" class="form-control" type="text" name="email" value="" style="width: 100%;"
								autocomplete="off" />
						</div>
					</div>
					<div class="btnn">
						<button id="ven-but1" class="btn btn-primary" value="modifySubmit">確認修改</button>
						<button id="ven-but2" class="btn btn-secondary" value="cancel">取消</button>
					</div>

				</fieldset>
			<!-- </form> -->
		</section>
	</div>
</div>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>

	<script type="text/javascript">
	$(function () {
		//取資料
		$.ajax({
			type : 'post',
			url : 'getMemberData_post',
			success : function(req) {
				//console.log("ss",req)
				$("#lab-ven-id").html("帳號:" + req["userID"]);
				$("#inp-ven-id").val(req["userID"]);
				if(req["classMember"] == "fa" || req["classMember"] == "ga" || req["classMember"] == "gg" || req["classMember"] == "gab"){
					$("#inp-ven-pws").val("");
					$("#inp-ven-passwordck").val("");
				}else {
					$("#inp-ven-pws").val(req["password"]);
					$("#inp-ven-passwordck").val(req["password"]);
				}
				
				$("#inp-ven-vendor").val(req["vendor"]).blur();
				$("#inp-ven-principal").val(req["principal"]).blur();
				$("#inp-ven-vat").val(req["vat"]).blur();
				$("#inp-ven-address").val(req["address"]).blur();
				$("#inp-ven-email").val(req["email"]).blur();
				
				if(req["classMember"] == "gg" || req["classMember"] == "ga" || req["classMember"] == "gab" || req["classMember"] == "gb"){
					$("#inp-ven-pws").attr("disabled","disabled");
					$("#inp-ven-passwordck").attr("disabled","disabled");
					$("#inp-ven-gclass").val("vendor");
				}
				if(req["classMember"] == "gg"){
					$("#ven-but2").attr("disabled","disabled");
				}
			},error :function(){
				console.log("er")
			}
		});
		
		//取消
		$("#ven-but2").click(() => {
			self.location = "HomePage";
		});
		
		//企業檢查
		$("#inp-ven-vendor").blur(function() {
			var m_vendor = $("#inp-ven-vendor").val();
			if(m_vendor != ""){
				$("#inp-ven-vendor").addClass("is-valid");
	        	$("#inp-ven-vendor").removeClass("is-invalid");
			}else{
		        $("#inp-ven-vendor").addClass("is-invalid");
		        $("#inp-ven-vendor").removeClass("is-valid");
			}
		});
		
		//負責人檢查
		$("#inp-ven-principal").blur(function() {
			var m_birthday = $("#inp-ven-principal").val();
			if(m_birthday != ""){
				$("#inp-ven-principal").addClass("is-valid");
	        	$("#inp-ven-principal").removeClass("is-invalid");
			}else{
		        $("#inp-ven-principal").addClass("is-invalid");
		        $("#inp-ven-principal").removeClass("is-valid");
			}
		});
		
		//統一編號檢查
		$("#inp-ven-vat").blur(function() {
			var m_birthday = $("#inp-ven-vat").val();
			if(m_birthday != ""){
				$("#inp-ven-vat").addClass("is-valid");
	        	$("#inp-ven-vat").removeClass("is-invalid");
			}else{
		        $("#inp-ven-vat").addClass("is-invalid");
		        $("#inp-ven-vat").removeClass("is-valid");
			}
		});
		
		//地址檢查
		$("#inp-ven-address").blur(function() {
			var m_birthday = $("#inp-ven-address").val();
			if(m_birthday != ""){
				$("#inp-ven-address").addClass("is-valid");
	        	$("#inp-ven-address").removeClass("is-invalid");
			}else{
		        $("#inp-ven-address").addClass("is-invalid");
		        $("#inp-ven-address").removeClass("is-valid");
			}
		});
		
		//Email檢查
		$("#inp-ven-email").blur(function() {
			var m_email = $("#inp-ven-email").val();
			if(m_email != ""){
				$("#inp-ven-email").addClass("is-valid");
	        	$("#inp-ven-email").removeClass("is-invalid");
			}else{
		        $("#inp-ven-email").addClass("is-invalid");
		        $("#inp-ven-email").removeClass("is-valid");
			}
		});
		
		//送出
		$("#ven-but1").click(function () {
			var v_sub1 = $("#ven-but1").val();
			var v_type = $("#m-cla").val();
			var v_userID = $("#inp-ven-id").val();
			var v_pws = $("#inp-ven-pws").val();
			var v_pwsCk = $("#inp-ven-passwordck").val();
			var v_vendor = $("#inp-ven-vendor").val();
			var v_principal = $("#inp-ven-principal").val();
			var v_vat = $("#inp-ven-vat").val();
			var v_address = $("#inp-ven-address").val();
			var v_email = $("#inp-ven-email").val();
			var v_gclass = $("#inp-ven-gclass").val();
			
			var params = {
					"sub" : v_sub1,
					"type" : v_type,
					"userID" : v_userID,
					"pws" : v_pws,
					"passwordck" : v_pwsCk,
					"vendor" : v_vendor,
					"principal" : v_principal,
					"vat" : v_vat,
					"address" : v_address,
					"email" : v_email,
					"gclass" : v_gclass
			}
					
			
			$.ajax({
				type : 'post',
				url : 'modifyMenberController',
				contentType : 'application/json',
				data : JSON.stringify(params),
				success : function(req) {
					console.log("ss",req)
					if(req == "success"){
						Swal.fire({title:"修改成功",
							   timer: 1000,
							   showConfirmButton: false,
							   icon: 'success',
							   //width: "400px",
							  }
							).then(function(){
								self.location = "HomePage";
			                });
					}
					if(req == "error_paws"){
						Swal.fire({title:"兩次密碼不相同",
							   confirmButtonText:"確定",
							   icon: 'error',
							  }
							).then(function(){
								pwsck();
								pwsck2();
			                });
					}
					if(req == "error_pawsnull"){
						Swal.fire({title:"密碼不可為空",
							   confirmButtonText:"確定",
							   icon: 'error',
							  }
							).then(function(){
								pwsck();
								pwsck2();
			                });
					}
					if(req == "error_haveNull"){
						Swal.fire({title:"請填寫完整資訊",
							   confirmButtonText:"確定",
							   icon: 'error',
							  }
							).then(function(){
								pwsck();
								pwsck2();
			                });
					}
					if(req == "error_haveNull_g"){
						Swal.fire({title:"請填寫完整資訊",
							   confirmButtonText:"確定",
							   icon: 'error',
							  }
							)
					}
				},error :function(){
					console.log("er")
				}
			});
		})
		
		
		//密碼檢查
		$("#inp-ven-pws").blur(function() {
			let thePwsObjVal = $("#inp-ven-pws").val();
	        let thp1 = false,thp2 = false;
	        let pwsL = thePwsObjVal.length;
	        if (thePwsObjVal == "") {
	        	$("#inp-ven-pwsW").text("密碼不可為空");
	            $("#inp-ven-pwsW").css("color", "red");
	            $("#inp-ven-pws").addClass("is-invalid");
	            $("#inp-ven-pws").removeClass("is-valid");
	          } else if (pwsL < 6) {
	        	  $("#inp-ven-pwsW").text("至少6個字且必須包含英數字");
	              $("#inp-ven-pwsW").css("color", "red");
	              $("#inp-ven-pws").addClass("is-invalid");
	              $("#inp-ven-pws").removeClass("is-valid");
	          } else if (pwsL >= 6) {
	            for (let i = 0; i < pwsL; i++) {
	              let ch = thePwsObjVal.charAt(i).toUpperCase();
	              if (ch >= "A" && ch <= "Z") {
	                thp1 = true;
	              }
	              if (ch >= "0" && ch <= "9") {
	                thp2 = true;
	              }
	            }
	            if(thp1 || thp2){
	             	$("#inp-ven-pwsW").text("必須包含英數字")
	              	$("#inp-ven-pwsW").css("color", "red");
	              	$("#inp-ven-pws").addClass("is-invalid");
	              	$("#inp-ven-pws").removeClass("is-valid");
	            }
	            if (thp1 && thp2) {
	            	$("#inp-ven-pwsW").text("正確")
	              	$("#inp-ven-pwsW").css("color", "green");
	              	$("#inp-ven-pws").removeClass("is-invalid");
	              	$("#inp-ven-pws").addClass("is-valid");
	            }
	           
	          }
		});
		
		//確認密碼
		$("#inp-ven-passwordck").blur(function() {
			let thePwsCkObjVal = $("#inp-ven-passwordck").val();
	        let pw = $("#inp-ven-pws").val();
	        let thp1 = false,thp2 = false;
	        let pwsL = thePwsCkObjVal.length;
	        
	        if (thePwsCkObjVal == "") {
	        	$("#inp-ven-pwsckW").text("密碼不可為空");
	            $("#inp-ven-pwsckW").css("color", "red");
	            $("#inp-ven-passwordck").addClass("is-invalid");
	            $("#inp-ven-passwordck").removeClass("is-valid");
	            $("#inp-ven-d-pawck").removeClass("dd1");
	        	$("#inp-ven-d-pawck").addClass("dd2");
	          } else if(pw != thePwsCkObjVal){
	        	  $("#inp-ven-pwsckW").text("兩次密碼不符");
	              $("#inp-ven-pwsckW").css("color", "red");
	              $("#inp-ven-passwordck").addClass("is-invalid");
	              $("#inp-ven-passwordck").removeClass("is-valid");
	              $("#inp-ven-d-pawck").removeClass("dd1");
	          	  $("#inp-ven-d-pawck").addClass("dd2");
	          } else if (pwsL < 6) {
	        	  $("#inp-ven-pwsckW").text("至少6個字且必須包含英數字");
	              $("#inp-ven-pwsckW").css("color", "red");
	              $("#inp-ven-passwordck").addClass("is-invalid");
	              $("#inp-ven-passwordck").removeClass("is-valid");
	              $("#inp-ven-d-pawck").removeClass("dd1");
	          	  $("#inp-ven-d-pawck").addClass("dd2");
	          } else if (pwsL >= 6) {
	            for (let i = 0; i < pwsL; i++) {
	              let ch = thePwsCkObjVal.charAt(i).toUpperCase();
	              if (ch >= "A" && ch <= "Z") {
	                thp1 = true;
	              }
	              if (ch >= "0" && ch <= "9") {
	                thp2 = true;
	              }
	            }
	            if (thp1 && thp2 && (pw === thePwsCkObjVal)) {
	            	$("#inp-ven-pwsckW").text("正確")
	              	$("#inp-ven-pwsckW").css("color", "green");
	              	$("#inp-ven-passwordck").removeClass("is-invalid");
	              	$("#inp-ven-passwordck").addClass("is-valid");
	              	$("#inp-ven-d-pawck").removeClass("dd1");
	             	$("#inp-ven-d-pawck").addClass("dd2");
	              }
	          }
		});
		
		
		
		
		
	});
	</script>


</body>
</html>