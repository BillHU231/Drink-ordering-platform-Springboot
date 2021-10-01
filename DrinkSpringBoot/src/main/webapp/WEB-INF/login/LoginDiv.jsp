<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>
.popover-body  {
/*background: tomato!important;*/
color: red !important;
height: 40px;
padding: 9px 1em;
}
</style>
<!-- 登入 div -->
<div class="modal fade" id="myModal_login" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="margin: 5em auto; width: 350px; text-align: center">
		<div class="login modal-content" style="border-radius: 15px;">
			<h2>登入</h2>
			
			<div class="validate-input">
				<input type="text" name="ssss" style="height: 0px;margin: 0;border: none;padding: 0;width: 0px">
				<input id="userID" class="input100 form-control" style="padding: 0 20px 0 25px;"
					type="text" value="" placeholder="請輸入帳號" autocomplete="off" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="right" data-bs-content="帳號號錯誤"> 
					<span class="focus-input100"></span> <span class="symbol-input100"> <i class="fa fa-user"></i>
				</span>
			</div>
			
			<p id="errID" class="err"></p>
				
			<div class="validate-input">
				<input id="pwd" class="input100 form-control" style="padding: 0 20px 0 25px;"
					type="password" placeholder="請輸入密碼" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="right" data-bs-content="密碼錯誤"> 
					<span class="focus-input100"></span> 
					<span class="symbol-input100"> <i class="fa fa-lock"></i>
				</span>
			</div>

			<p id="errPwd" class="err"></p>

			<div class="remember_me">
				<div class="form-check form-switch">
					<input id="remember_me" class="form-check-input" style="float: none;" type="checkbox"
						id="remember_me" name="remember_me" value="remember_me" /> <label
						class="form-check-label" for="remember_me">記住我</label>
				</div>
				
				<div class="form-check">
				  <input class="form-check-input" type="checkbox" value="" id="cancelRob">
				  <label class="form-check-label" for="cancelRob" >取消機器人驗證</label>
				</div>
			</div>
			
			<div
			    class="g-recaptcha"
			    data-sitekey="6LfitEkcAAAAAKWfyNXODpfXbQzhhVS1c_0gPfd2"
			    data-callback="gre_verify">
			    
			</div>
			
			
			<div id="GOOGLE_login" class="g-signin2" data-onsuccess="" data-theme="dark" style="margin:10px 0px;width: 300px;"></div>
    			<!-- <a href="#" onclick="signOut();">Sign out</a>
				
			<button id="GOOGLE_login222" class="btn btn-large btn-primary">GOOGLE 登入</button>  -->
			<!-- <button id="GOOGLE_logout" class="btn btn-large btn-warning">GOOGLE 登出</button>
			<span id="GOOGLE_STATUS_2"></span> -->
			
			<p class="submit">
				<button id="butt1" class="btn btn-secondary" style="margin: 5px 10px;" type="submit" name="sub"
					value="login" disabled>登入</button>
				<button id="butt7" class="btn btn-secondary" style="margin: 5px 10px;" type="submit" name="sub"
					value="cancel">取消</button>
				<br> <br>
				<button id="butt4" class="btn btn-outline-success" type="submit" name="sub" value="cancel"
					style="font-size: 12px; margin-right: 20px; padding: .375rem .75rem;">一般會員</button>
				<button id="butt5" class="btn btn-outline-success" type="submit" name="sub" value="cancel"
					style="font-size: 12px; margin-right: 20px; padding: .375rem .75rem;">企業會員</button>
				<button id="butt6" class="btn btn-outline-success" type="submit" name="sub" value="cancel"
					style="font-size: 12px; margin: 10px 20px 0 0; padding: .375rem .75rem;">管理員</button>
					
			</p>

			<div class="login-help">
				<p class="pp">
					<a id="newMem" type="button">註冊&nbsp;</a>還是忘記密碼? <a id="forgPaw" type="button">找回密碼</a>
				</p>
				<p id="errorPwd" class="err"></p>
			</div>
		</div>
	</div>
</div>



<!-- ----------------------------------------- -->

<!-- 登出 div -->
<%
String UserID1 = (String) session.getAttribute("UserID");
String uClass1 = (String) session.getAttribute("ClassMember");
String gName1 = (String) session.getAttribute("G_Name");
String userName1 = (String)session.getAttribute("UserName");

String printName1 = userName1;
if("gg".equals(uClass1)){
	printName1 = gName1;
}
if("admin".equals(UserID1)){
	printName1 = "管理員";
}
%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
	aria-hidden="true">
	<div class="modal-dialog" style="margin: 10em auto; width: 300px; text-align: center">
		<div class="modal-content" style="text-align: center;">
			<div class="modal-header"
				style="text-align: center; justify-content: center; border-bottom: none;">
				<h5 class="modal-title" id="exampleModalLabel">登出</h5>
			</div>
			<div class="modal-body">
				<%=printName1%>
				&nbsp;是否登出?
			</div>
			<div class="modal-footer" style="text-align: center; justify-content: center; border-top: none;">
				<button id="butt3" type="button" class="btn btn-primary" style="padding: .375rem .75rem;">登出</button>
				<button id="butt2" type="button" class="btn btn-secondary" style="padding: .375rem .75rem;">取消</button>
			</div>
		</div>
	</div>
</div>
<!-- ----------------------------------------- -->

<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="homePageStyleAndJs/js/scripts.js"></script>
<!-- jQuery -->
<script src="<%=request.getContextPath()%>/Library/jquery-3.6.0.js"></script>
<script src="<%=request.getContextPath()%>/Library/jquery-ui-1.12.1/jquery-ui.js"></script>
<!-- sweetalert2 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- google  reCAPTCHA -->
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<!-- google  第三方SDK -->
<script src="https://apis.google.com/js/platform.js" async defer></script>


<script>
//$(document)	.ready(	function() {
	
$(function() {
	

	
	// 進行登入程序
	var g_params={};
	
	var startApp = function() {
		gapi.load("auth2", function() {
			auth2 = gapi.auth2.init({
				client_id: "637462585958-er8g4agnmt6htubesbltl6758qbflnf4.apps.googleusercontent.com", // 用戶端 ID
				cookiepolicy: "single_host_origin"
			});
			setTimeout(function(){
				attachSignin(document.getElementById("GOOGLE_login"));
			},100);
			
		});
	};
	
	function attachSignin(element) {
		auth2.attachClickHandler(element, {},
		// 登入成功
		function(googleUser) {
			
				var profile = googleUser.getBasicProfile();
				//console.log(profile.getName());
				//console.log(profile.getEmail());
				//console.log(g_params);
				g_login(profile);
		},
		// 登入失敗
		function(error) {
			//$("#GOOGLE_STATUS_2").html("");
			alert(JSON.stringify(error, undefined, 2));
		});

	}

	//預先執行
	startApp();

	// 點擊登入
	$("#GOOGLE_login").click(function() {
		// 進行登入程序
		setTimeout(function(){
			startApp();
			},100);
	});

	// 點擊登出
	$("#GOOGLE_logout").click(function() {
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.signOut().then(function() {
			// 登出後的動作
			$("#GOOGLE_STATUS_2").html("");
		});
	});
	
	//google登入ajax
	function g_login(profile) {
		
		g_params = {"email":profile.getEmail(),
			     "name":profile.getName()}
		console.log(g_params);
		$.ajax({
			type : 'post',
			url : 'loginInf_google',
			contentType : 'application/json',
			data : JSON.stringify(g_params),
			success : function(reps) {
				//console.log(reps);
				if (reps == "g_success") {
					 Swal.fire({title: "會員切換",
			                html: "選擇使用會員",
			                confirmButtonText:'一般會員',
			                denyButtonText:'企業會員',
			                showDenyButton:true,
			                confirmButtonColor:'#3085d6',
			                cancelButtonColor:'#d33',
			                icon: 'question',
			                allowOutsideClick: false //所外部點選
			                }).then(function (result){
			                	console.log(result.value);
			                	if(result.value == true){
			                		g_params = {
			                				"email":profile.getEmail(),
			               			     	"name":profile.getName(),
			               			     	"ltype":"general"}
			                		$.ajax({
				        				type : 'post',
				        				url : 'loginInf_googleMem',
				        				contentType : 'application/json',
				        				data : JSON.stringify(g_params),
				        				success : function(req) {
				        					if(req == "g_fast"){
				        						self.location = "toModifyMember";
				        					}
				        					if(req == "g_second"){
				        						self.location = "HomePage";
				        					}
				        				},error :function(){
				        					console.log("er")
				        				}
				        			});
			                	}
			                	if(result.value == false){
			                		g_params = {
			                				"email":profile.getEmail(),
			               			     	"name":profile.getName(),
			               			     	"ltype":"vendor"}
			                		$.ajax({
				        				type : 'post',
				        				url : 'loginInf_googleMem',
				        				contentType : 'application/json',
				        				data : JSON.stringify(g_params),
				        				success : function(req) {
				        					if(req == "g_fast"){
				        						self.location = "toModifyMemberVendor";
				        					}
				        					if(req == "g_second"){
				        						self.location = "HomePage";
				        					}
				        				},error :function(){
				        					console.log("er")
				        				}
				        			});
			                	}
			                	
			                	
			                	
			                })
				}
				if (reps == "g_stop") {
					Swal.fire({title:"帳號已遭停權",
						   icon: 'error',
						   confirmButtonText:"確定",
						   width: "300px",
						  })
				}
				
			}//success
		});//ajax
	}
	
	
	
	
})
//第三方登入
	setTimeout(function () {
        $("#GOOGLE_login div :first").css('background-color','#BEBEBE');
        $("#GOOGLE_login div :last").css('background-color','#BEBEBE');
    }, 200);
	
$("#GOOGLE_login").css('pointer-events','none');
//取消機器人
$("#cancelRob").click(function () {
	if ($(this).prop("checked")) {
    	$("#butt1").attr('disabled', false);
		$("#butt1").removeClass("btn-secondary");
		$("#butt1").addClass("btn-primary");
		$("#GOOGLE_login").css('pointer-events','');
		$("#GOOGLE_login div :first").css('background-color','transparent');
	    $("#GOOGLE_login div :last").css('background-color','transparent');
	} else{
		$("#butt1").attr('disabled', true);
		$("#butt1").addClass("btn-secondary");
		$("#butt1").removeClass("btn-primary");
		$("#GOOGLE_login").css('pointer-events','none');
		$("#GOOGLE_login div :first").css('background-color','#BEBEBE');
        $("#GOOGLE_login div :last").css('background-color','#BEBEBE');
	}
        
});

//google reCAPTCHA
function gre_verify(token) {
	
	//function validateAndGetCaptchaResponse() {
        //const response = grecaptcha.getResponse();
        //return response.length === 0 ? null : response;
    //}
	
	//let captchaResponse = validateAndGetCaptchaResponse();
	let captchaResponse = grecaptcha.getResponse();
	  $.ajax({
			type : 'post',
			url : 'googlereCAPTCh',
			dataType:'JSON',
			contentType : 'application/json',
			data: {
                "token": captchaResponse
            },
			success : function(reps) {
				//console.log(reps)
				if(reps["success"] == true){
					//console.log("Ss",reps["success"]);
					$("#butt1").attr('disabled', false);
					$("#butt1").removeClass("btn-secondary");
					$("#butt1").addClass("btn-primary");
					$("#GOOGLE_login").css('pointer-events','');
					$("#GOOGLE_login div :first").css('background-color','transparent');
				    $("#GOOGLE_login div :last").css('background-color','transparent');
				}
				if(reps["success"] == false){
				
					
				}
				}
				
			});
	  
}


$(function () {
	
	//彈跳對話框
	/**/
		var pu = 0;
		var pp = 0;
		$("#userID").blur(function () {
			if($('#userID').val() != "" && pu == 1){
				$('#userID').popover('disable');
				$("#userID").removeClass("is-invalid");
				pu = 0;
			}
		})
	
		$("#pwd").blur(function () {
			if($('#pwd').val() != "" && pp == 1){
				$('#pwd').popover('disable');
				$("#pwd").removeClass("is-invalid");
				pp = 0;
			}
		})
	
	//登入div
	$("#loginInf").click(() => {
	   $('#myModal_login').modal('show');
		$("#errID").text("");
		$("#errPwd").text("");
		$("#errorPwd").text("");
		$("#pwd").val('');
		$.ajax({
			type : 'post',
			url : 'remember',
			contentType : 'application/json',
			success : function(reps) {
				//console.log(reps);
				if(reps["remember_me"] == "rem_Y"){
					$("#remember_me").prop("checked", true);
					$("#userID").val(reps["UserID"]);
				}else{
					$("#userID").val('');
				}
			}
		})
	})
	//登入成功彈跳視窗
	function alent() {
		Swal.fire({title:"登入成功",
			timer: 1000,
			icon: 'success',
			width: "300px",
			height: "300px",
			showConfirmButton: false
		})
	}

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

		$.ajax({
		type : 'post',
		url : 'loginInf',
		//dataType:'JSON',
		contentType : 'application/json',
		data : JSON.stringify(params),
		//async : false,
		//data : params,
		success : function(reps) {
			console.log(reps);
			//$("#errID").text(reps["er_usID"]);
			//$("#errPwd").text(reps["er_pwd"]);
			//$("#errorPwd").text(reps["errorPwd"]);
			if (reps["re_Page"] == "a") {
				alent();
				setTimeout(function(){
					self.location = "HomePage";
				},800);
			}
			if (reps["re_Page"] == "b") {
				alent();
				setTimeout(function(){
					self.location = "HomePage";
				},800);
			}
			if (reps["re_Page"] == "fa") {
				 alent();
				 setTimeout(function(){
					 self.location = "toModifyMember";
					},800);
			}
			if (reps["re_Page"] == "fb") {
				alent();
				setTimeout(function(){
					self.location = "toModifyMemberVendor";
				},800);
			}
			if (reps["re_Page"] == "gm") {
				 alent();
				 setTimeout(function(){
					 self.location = "ToBackStagePage";
					},800);
			}
			if (reps["er_usID"] == "er_usID" && reps["er_pwd"] != "er_pwd") {
				/**/
				$('#userID').popover('enable');
				$('#userID').popover('show');
				$("#userID").focus(function () {
					pu = 1;
				})
				$("#userID").blur(function () {
					$('#userID').popover('hide');
				})
				$("#userID").focus();
				$("#userID").addClass("is-invalid");
			}
			if (reps["er_pwd"] == "er_pwd" && reps["er_usID"] != "er_usID") {
				/**/
				$('#pwd').popover('enable');
				$('#pwd').popover('show');
				$("#pwd").focus(function () {
					pp = 1;
				})
				$("#pwd").blur(function () {
					$('#pwd').popover('hide');
				})
				$("#pwd").focus();
				$("#pwd").addClass("is-invalid");
			}
			
			if (reps["errorPwd"] == "err_IDorPwd"){
				/*-------------------------------*/
				/**/
				$('#userID').popover('enable');
				$('#userID').popover('show');
				$('#pwd').popover('enable');
				$('#pwd').popover('show');
				pu = 0;
				$("#userID").focus(function () {
					pu = 1;
				})
				$("#userID").blur(function () {
					$('#userID').popover('hide');
				})
				$("#userID").addClass("is-invalid");
				/*-------------------------------*/
				/**/
				pp = 0;
				$("#pwd").focus(function () {
					pp = 1;
				})
				$("#pwd").blur(function () {
					$('#pwd').popover('hide');
				})
				$("#pwd").addClass("is-invalid");
				
				Swal.fire({title:"登入失敗",
						   html:"帳號或密碼錯誤",
						   icon: 'error',
						   confirmButtonText:"確定",
						   width: "300px",
						  }
						).then(function(){
							//$("#errID").text("帳號錯誤");
							//$("#errPwd").text("密碼錯誤");
		                });
			}
			if (reps["errorPwd"] == "err_noID"){
				/*-------------------------------*/
				/**/
				$('#userID').popover('enable');
				$('#userID').popover('show');
				$('#pwd').popover('enable');
				$('#pwd').popover('show');
				pu = 0;
				$("#userID").focus(function () {
					pu = 1;
				})
				$("#userID").blur(function () {
					$('#userID').popover('hide');
				})
				$("#userID").addClass("is-invalid");
				/*-------------------------------*/
				/**/
				pp = 0;
				$("#pwd").focus(function () {
					pp = 1;
				})
				$("#pwd").blur(function () {
					$('#pwd').popover('hide');
				})
				$("#pwd").addClass("is-invalid");
				
				Swal.fire({title:"登入失敗",
						   html:"沒有這個帳號",
						   icon: 'error',
						   confirmButtonText:"確定",
						   width: "300px",
						  }
						).then(function(){
							//$("#errID").text("帳號錯誤");
							//$("#errPwd").text("密碼錯誤");
		                });
			}
			if(reps["re_Page"] == "stop"){
				pu = 0;
				pp = 0;
				$('#userID').popover('enable');
				$('#userID').popover('show');
				$('#pwd').popover('enable');
				$('#pwd').popover('show');
				
				
				$("#userID").addClass("is-invalid");
				$("#pwd").addClass("is-invalid");
				Swal.fire({title:"帳號已遭停權",
					   icon: 'error',
					   confirmButtonText:"確定",
					   width: "300px",
					  })
			}
			
			
			
			
			
			
			
			
			
		}//success
		});//ajax
	});	//送出

	//登入取消
	$("#butt7").click(function() {
		$('#myModal_login').modal('hide');
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
				alent();
				 setTimeout(function(){
					 self.location = "HomePage";
				},800);
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
				alent();
				 setTimeout(function(){
					 self.location = "HomePage";
				},800);
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
				alent();
				 setTimeout(function(){
					 self.location = "ToBackStagePage";
				},800);
			}
		})
	});	

	//登出div
	$("#logoutInf").click(() => {
		$('#myModal').modal('show');
	})
	
	//登出
	$("#butt3").click(function() {
		$.ajax({
			type : 'GET',
			url : 'loginOut',
			contentType : 'application/json',
			success : function(reps) {
				//console.log(reps);
				$('#myModal').modal('hide');
				Swal.fire({title:"登出成功",
					timer: 1000,
					icon: 'success',
					width: "300px",
					height: "300px",
					showConfirmButton: false
				}).then(function () {
					self.location = "HomePage";
				})
				
			}
		})
	});
	
	//登出取消
	$("#butt2").click(function() {
		$('#myModal').modal('hide');
	});
	
	
	
});

</script>