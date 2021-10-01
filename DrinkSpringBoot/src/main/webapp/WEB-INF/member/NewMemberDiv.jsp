<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="modal fade" id="myModal_mem" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="margin: 10em auto; width: 500px; text-align: center">
		<div class="modal-content" style="text-align: center; margin: 10em auto; border-radius: 15px;">
			<div class="modal-header"
				style="text-align: center; justify-content: center; border-bottom: none;">
				<h3 class="modal-title" id="exampleModalLabel">會員註冊</h3>
			</div>
			<div class="d1">
				<div>
					<nav>
						<div class="nav nav-tabs" id="nav-tab" role="tablist">
							<button class="nav-link active ttab" id="nav-home-tab" data-bs-toggle="tab"
								data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home"
								aria-selected="true">一般會員</button>
							<button class="nav-link ttab" id="nav-profile-tab" data-bs-toggle="tab"
								data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile"
								aria-selected="false">企業會員</button>
						</div>
					</nav>
					
					<!-- 一般帳號 -->
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="nav-home" role="tabpanel"
							aria-labelledby="nav-home-tab" style="width:350px">
							
							<span><em class="ee">*每格皆為必填欄位</em></span>
							
							<input type="hidden" id="m-cla" name="type" value="form-a" />
							
							<br>
							<div id="m-d-id" class="dd1">
								<label class="labe" for="m-userID">帳號：</label> 
								<input class="form-control" id="m-userID" name="userID" value="" autocomplete="off"/>
							</div>
							
							<span id="m-userIDW" class="spa">&nbsp;</span>
							
							<div class="dd1" style=" margin-bottom:0px">
								<label class="labe" for="m-pws">密碼：</label> 
								<input id="m-pws" class="form-control" type="password" name="pws" value=""/>
							</div>
							
							<span id="m-pwsW" class="spa">密碼需6個字且必須包含英數字</span>
							
							<div id="m-d-pawck" class="dd1">
								<label class="labe" for="m-passwordck">密碼確認：</label> 
								<input id="m-passwordck" class="form-control" type="password" name="passwordck" value="" />
							</div>
							
							<span id="m-pwsckW" class="spa">&nbsp;</span>
							
							<div id="m-d-name" class="dd1">
								<label class="labe" for="m-name">姓名：</label> 
								<input id="m-name" class="form-control" name="name" value="" autocomplete="off" />
							</div>
							
							<span id="m-nameW" class="spa">&nbsp;</span>
							
							<div id="m-d-birthday" class="dd1">
								<label class="labe" for="m-birthday">出生年月日：</label> 
								<input id="m-birthday" class="form-control" name="birthday" placeholder="格式:2021/09/24" value="" autocomplete="off" />
							</div>
							
							<span id="m-birthdayW" class="spa">&nbsp;</span>
							
							<div id="m-d-email" class="dd1">
								<label class="labe" for="m-email">Email：</label> 
								<input id="m-email" class="form-control" name="email" value=""  autocomplete="off" />
							</div>
							
							<span id="m-emailW" class="spa">&nbsp;</span>

							<div class="dd1 btnn">
								<button class="btn btn-primary" id="div-mem-sub1" name="sub" value="submit">送出</button>
								<button class="btn btn-warning" id="div-mem-sub2" name="sub" value="res">清除重填</button>
								<button class="btn btn-secondary" id="div-mem-sub3" name="sub" value="cancel">取消</button>
							</div>
							<div class="dd1 btnn">
							<button id="div-mem-fast" class="btn btn-outline-success" type="submit" name="sub" value="cancel"
								style="font-size: 12px; margin: 0 20px 10px 20px; padding: .375rem .75rem;">一鍵輸入</button>
								
							</div>

						</div>
						
						<!-- 企業帳號 -->
						<div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" style="width:350px">
							
							<span><em class="ee">*每格皆為必填欄位</em></span>
							<input type="hidden" id="v-cla" name="type" value="form-b" />
							
							<br>
							<div id="v-d-id" class="dd1">
								<label class="labe" for="v-userID">帳號：</label> 
								<input class="form-control" id="v-userID" name="userID" value="" autocomplete="off"/>
							</div>
							
							<span id="v-userIDW" class="spa">&nbsp;</span>
							
							<div class="dd1" style=" margin-bottom:0px">
								<label class="labe" for="v-pws">密碼：</label> 
								<input id="v-pws" class="form-control" type="password" name="pws" value=""/>
							</div>
							
							<span id="v-pwsW" class="spa">密碼需6個字且必須包含英數字</span>
							
							<div id="v-d-pawck" class="dd1">
								<label class="labe" for="v-passwordck">密碼確認：</label> 
								<input id="v-passwordck" class="form-control" type="password" name="passwordck" value="" />
							</div>
							
							<span id="v-pwsckW" class="spa">&nbsp;</span>
							
							<div id="v-d-vendor" class="dd1">
								<label class="labe" for="v-vendor">企業名稱：</label> 
								<input id="v-vendor" class="form-control" name="vendor" value="" autocomplete="off" />
							</div>
							
							<span id="v-vendorW" class="spa">&nbsp;</span>
							
							<div id="v-d-principal" class="dd1">
								<label class="labe" for="v-principal">負責人：</label> 
								<input id="v-principal" class="form-control" name="principal" value="" autocomplete="off" />
							</div>
							
							<span id="v-principalW" class="spa">&nbsp;</span>
							
							<div id="v-d-vat" class="dd1">
								<label class="labe" for="v-vat">統一編號：</label> 
								<input id="v-vat" class="form-control" name="vat" value=""  autocomplete="off" />
							</div>
							
							<span id="v-vatW" class="spa">&nbsp;</span>
							
							<div id="v-d-address" class="dd1">
								<label class="labe" for="v-address">地址：</label> 
								<input id="v-address" class="form-control" name="vat" value=""  autocomplete="off" />
							</div>
							
							<span id="v-addressW" class="spa">&nbsp;</span>
							
							<div id="v-d-email" class="dd1">
								<label class="labe" for="v-vat">Email：</label> 
								<input id="v-email" class="form-control" name="email" value=""  autocomplete="off" />
							</div>
							
							<span id="v-emailW" class="spa">&nbsp;</span>

							<div class="dd1 btnn">
								<button class="btn btn-primary" id="div-ven-sub1" name="sub" value="submit">送出</button>
								<button class="btn btn-warning" id="div-ven-sub2" name="sub" value="res">清除重填</button>
								<button class="btn btn-secondary" id="div-ven-sub3" name="sub" value="cancel">取消</button>
							</div>
							<div class="dd1 btnn">
							<button id="div-ven-fast" class="btn btn-outline-success" type="submit" name="sub" value="cancel"
								style="font-size: 12px; margin: 0 20px 10px 20px; padding: .375rem .75rem;">一鍵輸入</button>
								
							</div>
							
							
							
						</div>
					</div>
				</div>
			</div>




		</div>
	</div>
</div>

<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="homePageStyleAndJs/js/scripts.js"></script>
<!-- jQuery -->
<script src="<%=request.getContextPath()%>/Library/jquery-3.6.0.js"></script>
<script src="<%=request.getContextPath()%>/Library/jquery-ui-1.12.1/jquery-ui.js"></script>
<!-- sweetalert2 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
$(function () {
	
	/*------------------------------------------------*/
	//登入註冊--id在LoginDiv
	$("#newMem").click(function () {
		$('#myModal_login').modal('hide');
		$('#myModal_mem').modal('show');
		clean();
		clean2();	
	})
	//登入註冊--id在LoginDiv
	$("#forgPaw").click(function () {
		self.location = "ForgotPassword";
	})
	/*------------------------------------------------*/
	//日期
	$("#m-birthday").datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth: true,
	     changeYear: true
	});
	
	//會員div顯示
	$("#newMemInf").click(() => {
		$('#myModal_mem').modal('show');
		clean();
		clean2();		
	});
	
	//清除
	function clean(){
		$("#m-userID").val("");
		$("#m-pws").val("");
		$("#m-passwordck").val("");
		$("#m-name").val("");
		$("#m-birthday").val("");
		$("#m-email").val("");
    	
		$("#m-userID").removeClass("is-valid");
		$("#m-userID").removeClass("is-invalid");
		$("#m-pws").removeClass("is-valid");
		$("#m-pws").removeClass("is-invalid");
		$("#m-passwordck").removeClass("is-valid");
		$("#m-passwordck").removeClass("is-invalid");
		$("#m-name").removeClass("is-valid");
		$("#m-name").removeClass("is-invalid");
		$("#m-birthday").removeClass("is-valid");
		$("#m-birthday").removeClass("is-invalid");
		$("#m-email").removeClass("is-valid");
		$("#m-email").removeClass("is-invalid");
		
		$("#m-userIDW").html("&nbsp;");
		$("#m-pwsW").html("密碼需6個字且必須包含英數字").css("color", "gray");
		$("#m-pwsckW").html("&nbsp;");
		$("#m-nameW").html("&nbsp;");
		$("#m-birthdayW").html("&nbsp;");
		$("#m-emailW").html("&nbsp;");
	}
	
	//清除button
	$("#div-mem-sub2").click(() => {
		clean();
	});
	
	//登出取消
	$("#div-mem-sub3").click(() => {
		$('#myModal_mem').modal('hide');
	});

	//姓名檢查
	$("#m-name").blur(function() {
		var m_name = $("#m-name").val();
		if(m_name != ""){
			$("#m-name").addClass("is-valid");
        	$("#m-name").removeClass("is-invalid");
        	$("#m-nameW").html("&nbsp;");
		}else{
        	$("#m-nameW").text("不可為空");
	        $("#m-nameW").css("color", "red");
	        $("#m-name").addClass("is-invalid");
	        $("#m-name").removeClass("is-valid");
		}
	});
	//生日檢查
	$("#m-birthday").blur(function() {
		setTimeout(function() {
			var m_birthday = $("#m-birthday").val();
			if(m_birthday != ""){
				$("#m-birthday").addClass("is-valid");
	        	$("#m-birthday").removeClass("is-invalid");
	        	$("#m-birthdayW").html("&nbsp;");
			}else{
	        	$("#m-birthdayW").text("不可為空");
		        $("#m-birthdayW").css("color", "red");
		        $("#m-birthday").addClass("is-invalid");
		        $("#m-birthday").removeClass("is-valid");
			}
		}, 200);
	});
	//Email檢查
	$("#m-email").blur(function() {
		var m_email = $("#m-email").val();
		if(m_email != ""){
			$("#m-email").addClass("is-valid");
        	$("#m-email").removeClass("is-invalid");
        	$("#m-emailW").html("&nbsp;");
		}else{
        	$("#m-emailW").text("不可為空");
	        $("#m-emailW").css("color", "red");
	        $("#m-email").addClass("is-invalid");
	        $("#m-email").removeClass("is-valid");
		}
	});
	
	//檢查帳號
	$("#m-userID").blur(function() {
		var m_userID = $("#m-userID").val();
			if(m_userID != ""){
				var params = {
					"userID" : m_userID
				};
			$.ajax({
				type : 'post',
				url : 'newMemberCheck',
				contentType : 'application/json',
				data : JSON.stringify(params),
				success : function(reps) {
					//console.log("ss",reps)
					if(reps == "ok"){
						$("#m-userID").addClass("is-valid");
						$("#m-userID").removeClass("is-invalid");
						$("#m-userIDW").css("color", "green");
						$("#m-userIDW").text("可以使用");
					}
					if(reps == "no"){
						$("#m-userID").addClass("is-invalid");
						$("#m-userID").removeClass("is-valid");
						$("#m-userIDW").css("color", "red");
						$("#m-userIDW").text("帳號重複");
					}
				},error : function(reps) {
						console.log("er");
				}
			})
			}else{
				$("#m-userIDW").text("不可為空");
		        $("#m-userIDW").css("color", "red");
		        $("#m-userID").addClass("is-invalid");
		        $("#m-userID").removeClass("is-valid");
			}
	});
	
	//密碼檢查
	$("#m-pws").blur(function() {
		let thePwsObjVal = $("#m-pws").val();
        let thp1 = false,thp2 = false;
        let pwsL = thePwsObjVal.length;
        if (thePwsObjVal == "") {
        	$("#m-pwsW").text("密碼不可為空");
            $("#m-pwsW").css("color", "red");
            $("#m-pws").addClass("is-invalid");
            $("#m-pws").removeClass("is-valid");
          } else if (pwsL < 6) {
        	  $("#m-pwsW").text("至少6個字且必須包含英數字");
              $("#m-pwsW").css("color", "red");
              $("#m-pws").addClass("is-invalid");
              $("#m-pws").removeClass("is-valid");
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
             	$("#m-pwsW").text("必須包含英數字")
              	$("#m-pwsW").css("color", "red");
              	$("#m-pws").addClass("is-invalid");
              	$("#m-pws").removeClass("is-valid");
            }
            if (thp1 && thp2) {
            	$("#m-pwsW").text("正確")
              	$("#m-pwsW").css("color", "green");
              	$("#m-pws").removeClass("is-invalid");
              	$("#m-pws").addClass("is-valid");
            }
           
          }
	});
	
	//確認密碼
	$("#m-passwordck").blur(function() {
		let thePwsCkObjVal = $("#m-passwordck").val();
        let pw = $("#m-pws").val();
        let thp1 = false,thp2 = false;
        let pwsL = thePwsCkObjVal.length;
        
        if (thePwsCkObjVal == "") {
        	$("#m-pwsckW").text("密碼不可為空");
            $("#m-pwsckW").css("color", "red");
            $("#m-passwordck").addClass("is-invalid");
            $("#m-passwordck").removeClass("is-valid");
            $("#m-d-pawck").removeClass("dd1");
        	$("#m-d-pawck").addClass("dd2");
          } else if(pw != thePwsCkObjVal){
        	  $("#m-pwsckW").text("兩次密碼不符");
              $("#m-pwsckW").css("color", "red");
              $("#m-passwordck").addClass("is-invalid");
              $("#m-passwordck").removeClass("is-valid");
              $("#m-d-pawck").removeClass("dd1");
          	  $("#m-d-pawck").addClass("dd2");
          } else if (pwsL < 6) {
        	  $("#m-pwsckW").text("至少6個字且必須包含英數字");
              $("#m-pwsckW").css("color", "red");
              $("#m-passwordck").addClass("is-invalid");
              $("#m-passwordck").removeClass("is-valid");
              $("#m-d-pawck").removeClass("dd1");
          	  $("#m-d-pawck").addClass("dd2");
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
            	$("#m-pwsckW").text("正確")
              	$("#m-pwsckW").css("color", "green");
              	$("#m-passwordck").removeClass("is-invalid");
              	$("#m-passwordck").addClass("is-valid");
              	$("#m-d-pawck").removeClass("dd1");
             	$("#m-d-pawck").addClass("dd2");
              }
          }
	});
	
	//確認一般input是否有填
	function check1() {
		if($("#m-userID").val() == ""){
			$("#m-userID").addClass("is-invalid");
		}
		if($("#m-pws").val() == ""){
			$("#m-pws").addClass("is-invalid");
		}
		if($("#m-passwordck").val() == ""){
			$("#m-passwordck").addClass("is-invalid");
		}
		if($("#m-name").val() == ""){
			$("#m-name").addClass("is-invalid");
		}
		if($("#m-birthday").val() == ""){
			$("#m-birthday").addClass("is-invalid");
		}
		if($("#m-email").val() == ""){
			$("#m-email").addClass("is-invalid");
		}
	}
	
	function sub_ajax(){
		var m_sub1 = $("#div-mem-sub1").val();
		var m_type = $("#m-cla").val();
		var m_userID = $("#m-userID").val();
		var m_pws = $("#m-pws").val();
		var m_pwsCk = $("#m-passwordck").val();
		var m_name = $("#m-name").val();
		var m_birthday = $("#m-birthday").val();
		var m_email = $("#m-email").val();
		
			var params = {
				"sub" : m_sub1,
				"type" : m_type,
				"userID" : m_userID,
				"pws" : m_pws,
				"passwordck" : m_pwsCk,
				"name" : m_name,
				"birthday" : m_birthday,
				"email" : m_email
			};
			$.ajax({
				type : 'post',
				url : 'newMemberCreat',
				contentType : 'application/json',
				data : JSON.stringify(params),
				success : function(reps) {
					//console.log("ss",reps)
					if(reps == "success"){
						Swal.fire({title:"註冊成功",
							   timer: 2000,
							   showConfirmButton: false,
							   icon: 'success',
							   width: "400px",
							  }
							).then(function(){
								$('#myModal_mem').modal('hide');
			                });
					}
					if(reps == "no"){ 
						
					}if(reps == "error_null"){
						//未完全填寫
						Swal.fire({title:"請完整填寫資訊",
							   //timer: 1000,
							   //showConfirmButton: false,
							   confirmButtonText:"確定",
							   icon: 'warning',
							   width: "400px",
							  }
							).then(function(){
								check1();
			                });
					}if(reps == "error_paw"){
						//兩次密碼不同
					}
				},error : function(reps) {
						console.log("er");
				}
			})
	}
	//一般會員送出
	$("#div-mem-sub1").click(function() {
		sub_ajax();		
	});
	
	//一鍵輸入
	$("#div-mem-fast").click(function () {
		$("#m-userID").val("aa123456").blur();
		$("#m-pws").val("a123456").blur();
		$("#m-passwordck").val("a123456").blur();
		$("#m-name").val("註冊機").blur();
		$("#m-birthday").val("2021-09-01").blur();
		$("#m-email").val("610323021@gms.ndhu.edu.tw").blur();
	});
	
	//-----------------------------------------------------------------
	//企業
	
	//清除
	function clean2(){
		$("#v-userID").val("");
		$("#v-pws").val("");
		$("#v-passwordck").val("");
		$("#v-vendor").val("");
		$("#v-principal").val("");
		$("#v-vat").val("");
		$("#v-address").val("");
		$("#v-email").val("");
    	
		$("#v-userID").removeClass("is-valid");
		$("#v-userID").removeClass("is-invalid");
		$("#v-pws").removeClass("is-valid");
		$("#v-pws").removeClass("is-invalid");
		$("#v-passwordck").removeClass("is-valid");
		$("#v-passwordck").removeClass("is-invalid");
		$("#v-vendor").removeClass("is-valid");
		$("#v-vendor").removeClass("is-invalid");
		$("#v-principal").removeClass("is-valid");
		$("#v-principal").removeClass("is-invalid");
		$("#v-vat").removeClass("is-valid");
		$("#v-vat").removeClass("is-invalid");
		$("#v-address").removeClass("is-valid");
		$("#v-address").removeClass("is-invalid");
		$("#v-email").removeClass("is-valid");
		$("#v-email").removeClass("is-invalid");
		
		$("#v-userIDW").html("&nbsp;");
		$("#v-pwsW").html("密碼需6個字且必須包含英數字").css("color", "gray");
		$("#v-pwsckW").html("&nbsp;");
		$("#v-vendorW").html("&nbsp;");
		$("#v-principalW").html("&nbsp;");
		$("#v-vatW").html("&nbsp;");
		$("#v-addressW").html("&nbsp;");
		$("#v-emailW").html("&nbsp;");
	}
	
	//清除button
	$("#div-ven-sub2").click(() => {
		clean2();
	});
	
	//登出取消
	$("#div-ven-sub3").click(() => {
		$('#myModal_mem').modal('hide');
	});
	
	//廠商檢查
	$("#v-vendor").blur(function() {
		var v_vendor = $("#v-vendor").val();
		if(v_vendor != ""){
			$("#v-vendor").addClass("is-valid");
        	$("#v-vendor").removeClass("is-invalid");
        	$("#v-vendorW").html("&nbsp;");
		}else{
        	$("#v-vendorW").text("不可為空");
	        $("#v-vendorW").css("color", "red");
	        $("#v-vendor").addClass("is-invalid");
	        $("#v-vendor").removeClass("is-valid");
		}
	});
	
	//負責人檢查
	$("#v-principal").blur(function() {
		var v_principal = $("#v-principal").val();
		if(v_principal != ""){
			$("#v-principal").addClass("is-valid");
        	$("#v-principal").removeClass("is-invalid");
        	$("#v-principalW").html("&nbsp;");
		}else{
        	$("#v-principalW").text("不可為空");
	        $("#v-principalW").css("color", "red");
	        $("#v-principal").addClass("is-invalid");
	        $("#v-principal").removeClass("is-valid");
		}
	});
	
	//統編檢查
	$("#v-vat").blur(function() {
		var v_vat = $("#v-vat").val();
		if(v_vat != ""){
			$("#v-vat").addClass("is-valid");
        	$("#v-vat").removeClass("is-invalid");
        	$("#v-vatW").html("&nbsp;");
		}else{
        	$("#v-vatW").text("不可為空");
	        $("#v-vatW").css("color", "red");
	        $("#v-vat").addClass("is-invalid");
	        $("#v-vat").removeClass("is-valid");
		}
	});
	
	//地址檢查
	$("#v-address").blur(function() {
		var v_address = $("#v-address").val();
		if(v_address != ""){
			$("#v-address").addClass("is-valid");
        	$("#v-address").removeClass("is-invalid");
        	$("#v-addressW").html("&nbsp;");
		}else{
        	$("#v-addressW").text("不可為空");
	        $("#v-addressW").css("color", "red");
	        $("#v-address").addClass("is-invalid");
	        $("#v-address").removeClass("is-valid");
		}
	});
	
	//Email檢查
	$("#v-email").blur(function() {
		var v_email = $("#v-email").val();
		if(v_email != ""){
			$("#v-email").addClass("is-valid");
        	$("#v-email").removeClass("is-invalid");
        	$("#v-emailW").html("&nbsp;");
		}else{
        	$("#v-emailW").text("不可為空");
	        $("#v-emailW").css("color", "red");
	        $("#v-email").addClass("is-invalid");
	        $("#v-email").removeClass("is-valid");
		}
	});
	
	//檢查帳號
	$("#v-userID").blur(function() {
		var v_userID = $("#v-userID").val();
			if(v_userID != ""){
				var v_params = {
					"userID" : v_userID
				};
			$.ajax({
				type : 'post',
				url : 'newMemberCheck',
				contentType : 'application/json',
				data : JSON.stringify(v_params),
				success : function(reps) {
					//console.log("ss",reps)
					if(reps == "ok"){
						$("#v-userID").addClass("is-valid");
						$("#v-userID").removeClass("is-invalid");
						$("#v-userIDW").css("color", "green");
						$("#v-userIDW").text("可以使用");
					}
					if(reps == "no"){
						$("#v-userID").addClass("is-invalid");
						$("#v-userID").removeClass("is-valid");
						$("#v-userIDW").css("color", "red");
						$("#v-userIDW").text("帳號重複");
					}
				},error : function(reps) {
						console.log("er");
				}
			})
			}else{
				$("#v-userIDW").text("不可為空");
		        $("#v-userIDW").css("color", "red");
		        $("#v-userID").addClass("is-invalid");
		        $("#v-userID").removeClass("is-valid");
			}
	});
	
	//密碼檢查
	$("#v-pws").blur(function() {
		let thePwsObjVal = $("#v-pws").val();
        let thp1 = false,thp2 = false;
        let pwsL = thePwsObjVal.length;
        if (thePwsObjVal == "") {
        	$("#v-pwsW").text("密碼不可為空");
            $("#v-pwsW").css("color", "red");
            $("#v-pws").addClass("is-invalid");
            $("#v-pws").removeClass("is-valid");
          } else if (pwsL < 6) {
        	  $("#v-pwsW").text("至少6個字且必須包含英數字");
              $("#v-pwsW").css("color", "red");
              $("#v-pws").addClass("is-invalid");
              $("#v-pws").removeClass("is-valid");
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
             	$("#v-pwsW").text("必須包含英數字")
              	$("#v-pwsW").css("color", "red");
              	$("#v-pws").addClass("is-invalid");
              	$("#v-pws").removeClass("is-valid");
            }
            if (thp1 && thp2) {
            	$("#v-pwsW").text("正確")
              	$("#v-pwsW").css("color", "green");
              	$("#v-pws").removeClass("is-invalid");
              	$("#v-pws").addClass("is-valid");
            }
           
          }
	});
	
	//確認密碼
	$("#v-passwordck").blur(function() {
		let thePwsCkObjVal = $("#v-passwordck").val();
        let pw = $("#v-pws").val();
        let thp1 = false,thp2 = false;
        let pwsL = thePwsCkObjVal.length;
        
        if (thePwsCkObjVal == "") {
        	$("#v-pwsckW").text("密碼不可為空");
            $("#v-pwsckW").css("color", "red");
            $("#v-passwordck").addClass("is-invalid");
            $("#v-passwordck").removeClass("is-valid");
            $("#v-d-pawck").removeClass("dd1");
        	$("#v-d-pawck").addClass("dd2");
          } else if(pw != thePwsCkObjVal){
        	  $("#v-pwsckW").text("兩次密碼不符");
              $("#v-pwsckW").css("color", "red");
              $("#v-passwordck").addClass("is-invalid");
              $("#v-passwordck").removeClass("is-valid");
              $("#v-d-pawck").removeClass("dd1");
          	  $("#v-d-pawck").addClass("dd2");
          } else if (pwsL < 6) {
        	  $("#v-pwsckW").text("至少6個字且必須包含英數字");
              $("#v-pwsckW").css("color", "red");
              $("#v-passwordck").addClass("is-invalid");
              $("#v-passwordck").removeClass("is-valid");
              $("#v-d-pawck").removeClass("dd1");
          	  $("#v-d-pawck").addClass("dd2");
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
            	$("#v-pwsckW").text("正確")
              	$("#v-pwsckW").css("color", "green");
              	$("#v-passwordck").removeClass("is-invalid");
              	$("#v-passwordck").addClass("is-valid");
              	$("#v-d-pawck").removeClass("dd1");
             	$("#v-d-pawck").addClass("dd2");
              }
          }
	});
	
	//確認企業input是否有填
	function check2() {
		if($("#v-userID").val() == ""){
			$("#v-userID").addClass("is-invalid");
		}
		if($("#v-pws").val() == ""){
			$("#v-pws").addClass("is-invalid");
		}
		if($("#v-passwordck").val() == ""){
			$("#v-passwordck").addClass("is-invalid");
		}
		if($("#v-vendor").val() == ""){
			$("#v-vendor").addClass("is-invalid");
		}
		if($("#v-principal").val() == ""){
			$("#v-principal").addClass("is-invalid");
		}
		if($("#v-vat").val() == ""){
			$("#v-vat").addClass("is-invalid");
		}
		if($("#v-address").val() == ""){
			$("#v-address").addClass("is-invalid");
		}
		if($("#v-email").val() == ""){
			$("#v-email").addClass("is-invalid");
		}
	}
	
	
	//企業會員送出
	$("#div-ven-sub1").click(function() {
		var v_sub1 = $("#div-ven-sub1").val();
		var v_type = $("#v-cla").val();
		var v_userID = $("#v-userID").val();
		var v_pws = $("#v-pws").val();
		var v_pwsCk = $("#v-passwordck").val();
		var v_vendor = $("#v-vendor").val();
		var v_principal = $("#v-principal").val();
		var v_vat = $("#v-vat").val();
		var v_address = $("#v-address").val();
		var v_email = $("#v-email").val();
		
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
				"email" : v_email
			};
			$.ajax({
				type : 'post',
				url : 'newMemberCreat',
				contentType : 'application/json',
				data : JSON.stringify(params),
				success : function(reps) {
					//console.log("ss",reps)
					if(reps == "success"){
						Swal.fire({title:"註冊成功",
							   timer: 2000,
							   showConfirmButton: false,
							   icon: 'success',
							   width: "400px",
							  }
							).then(function(){
								$('#myModal_mem').modal('hide');
			                });
					}
					if(reps == "no"){ 
						
					}if(reps == "error_null"){
						//未完全填寫
						Swal.fire({title:"請完整填寫資訊",
							   //timer: 2000,
							   //showConfirmButton: false,
							   confirmButtonText:"確定",
							   icon: 'warning',
							   width: "400px",
							  }
							).then(function(){
								check2();
			                });
					}if(reps == "error_paw"){
						//兩次密碼不同
					}
				},error : function(reps) {
						console.log("er");
				}
			})
	});
	
	//企業會員一鍵註冊
	$("#div-ven-fast").click(function(){
		$("#v-userID").val("bb112233").blur();
	 	$("#v-pws").val("a123456").blur();
		$("#v-passwordck").val("a123456").blur();
		$("#v-vendor").val("好廠商").blur();
		$("#v-principal").val("好心肝").blur();
		$("#v-vat").val("33456788").blur();
		$("#v-address").val("台北市某區的某個路邊").blur();
		$("#v-email").val("66678991aa@gmail.com").blur();
	})
	
});
</script>