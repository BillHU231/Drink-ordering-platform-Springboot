<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberManagerEdit</title>
<!--自己的CSS-->
<link rel="stylesheet" href="store/css/index.css">
<link rel="stylesheet" href="newMemberCss/modifyMember.css">
<!-- datatables css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.0/css/dataTables.bootstrap5.min.css" />
	
<%@ include file="/WEB-INF/websiteForm/backWebsiteHead.jsp"%>
</head>
<body>
<%@ include file="/WEB-INF/websiteForm/backWebsiteBody1.jsp"%>

<div class="d1-bk">
			<section>
				<input id="m-cla" type="hidden" name="type" value="form-a_mo" />
					<fieldset class="fie-bk">
						<legend class="leg-bk">後台會員編輯</legend>
						<div class="dd1-bk">
							<div>
								<label id="lab-venbk-id" for="inp-mem-id">帳號：</label>
								<input id="inp-venbk-id" class="form-control" type="hidden" value="" /> 
							</div>
							
							<div>
								<label>會員狀態：<span id="sp-venbk-state"></span></label>
								<button id="venbk-stop" class="btn btn-danger" value="stop" style="margin-left:70px">停權</button>
							</div>
						</div>
						<div class="dd1-bk">
							<div>
								<label for="inp-venbk-vendor">企業名稱：</label>
								<input id="inp-venbk-vendor" class="form-control" type="text" value="" />
							</div>
							<div style="display: flex; align-items: center;">
								<label id="lab-venbk-paw">密碼：</label>
								<input id="inp-venbk-paw" class="form-control" type="hidden" value="" /> 
								<input id="inp-venbk-passwordck" class="form-control" type="hidden" value="" /> 
							</div>
							
						</div>
						<div class="dd1-bk">
							<div>
								<label for="inp-venbk-principal">負責人：</label>
								
								<input id="inp-venbk-principal" class="form-control" type="text" name="name" value=""  autocomplete="off"/>
								
							</div>
							<div>
								<label for="inp-venbk-vat">統一編號：</label>
								
								<input  id="inp-venbk-vat" class="form-control" type="text" name="birthday" value="" autocomplete="off"/>
								
							</div>
						</div>
						<div class="dd1-bk" style="justify-content: left;">
							<div>
								<label for="inp-venbk-address">住址：</label>
								<input id="inp-venbk-address" class="form-control" type="text" name="email" value="" style="width: 100%;"
									autocomplete="off" />
							</div>
						</div>
						<div class="dd1-bk" style="justify-content: left;">
							<div>
								<label for="inp-venbk-email">E-mail：</label>
								<input id="inp-venbk-email" class="form-control" type="text" name="email" value="" style="width: 100%;"
									autocomplete="off" />
							</div>
						</div>
						<div class="btnn-bk">
							<button id="venbk-but1" class="btn btn-primary" type="button" name="sub" value="modifySubmit">確認修改</button>
							<button id="venbk-but2" class="btn btn-secondary" name="sub" value="cancel">返回</button>
							<button id="venbk-delete" class="btn btn-danger" type="button" name="sub" value="delete">刪除帳號</button>
						</div>
	
					</fieldset>
			</section>	
			
		
	</div>






<!---------------- 匯入 ------------------------>

	<!--bootstrap匯入-->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
	<!--引用jQuery-->
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<!-- 往下放會看不到datatables -->
	<%@ include file="/WEB-INF/websiteForm/backWebsiteBody2.jsp"%>
	<!--引用dataTables.js(一定要放置最下面)-->
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/dataTables.bootstrap5.min.js"></script>
	<!-- sweetalert2 -->
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
	<script type="text/javascript">
		$(document).ready(function (){
			$.ajax({
				type : 'post',
				url : 'getMemberData_post',
				success : function(req) {
					//console.log("ss",req)
					$("#lab-venbk-id").html("帳號:" + req["userID"]);
					$("#inp-venbk-id").val(req["userID"]);
					if(req["classMember"] == "b"){
						$("#lab-venbk-paw").html("密碼：正常");
						$("#sp-venbk-state").html("正常");
					}else if(req["classMember"] == "fb"){
						$("#lab-venbk-paw").html("密碼：忘記密碼未修改");
						$("#sp-venbk-state").html("正常");
					}else if(req["classMember"] == "stop_b"){
						$("#lab-venbk-paw").html("密碼：");
						$("#sp-venbk-state").html("停權").css("color","red");
						$("#venbk-stop").text("解除停權");
						$("#venbk-stop").addClass("btn-warning");
						$("#venbk-stop").removeClass("btn-danger");
						$("#venbk-stop").val("stopCancel");
					}
					$("#inp-venbk-paw").val(req["password"]);
					$("#inp-venbk-passwordck").val(req["password"]);
					
					$("#inp-venbk-vendor").val(req["vendor"]);
					$("#inp-venbk-principal").val(req["principal"]);
					$("#inp-venbk-vat").val(req["vat"]);
					$("#inp-venbk-address").val(req["address"]);
					$("#inp-venbk-email").val(req["email"]);
					
					$("#inp-venbk-vendor").attr('disabled', 'disabled');
					$("#inp-venbk-principal").attr('disabled', 'disabled');
					$("#inp-venbk-vat").attr('disabled', 'disabled');
					$("#inp-venbk-address").attr('disabled', 'disabled');
					$("#inp-venbk-email").attr('disabled', 'disabled');
					$("#venbk-but1").text('修改');
					
				},error :function(){
					console.log("er")
				}
			});
			
			

			
			
			
			
		});
		
		$(function () {
			
			/*--共用var--*/
			var v_sub1 = "";
			/*----------*/
			//修改按鈕
			var index = 0;
			$("#venbk-but1").click(function () {
				if(index == 0){
					ck1();
					index = 1;
				}else if(index == 1){
					ck2();
					index = 0;
					v_sub1 = $("#venbk-but1").val();
					subm();
				}
			});
			
			function ck1() {
				$("#inp-venbk-vendor").removeAttr('disabled');
				$("#inp-venbk-principal").removeAttr('disabled');
				$("#inp-venbk-vat").removeAttr('disabled');
				$("#inp-venbk-address").removeAttr('disabled');
				$("#inp-venbk-email").removeAttr('disabled');
				$("#venbk-but1").text('確認修改');
			}
			function ck2() {
				$("#inp-venbk-vendor").attr('disabled', 'disabled');
				$("#inp-venbk-principal").attr('disabled', 'disabled');
				$("#inp-venbk-vat").attr('disabled', 'disabled');
				$("#inp-venbk-address").attr('disabled', 'disabled');
				$("#inp-venbk-email").attr('disabled', 'disabled');
				$("#venbk-but1").text('修改');
			}
			
			function subm() {
				
				var v_userID = $("#inp-venbk-id").val();
				var v_pws = $("#inp-venbk-paw").val();
				var v_pwsCk = $("#inp-venbk-passwordck").val();
				var v_vendor = $("#inp-venbk-vendor").val();
				var v_principal = $("#inp-venbk-principal").val();
				var v_vat = $("#inp-venbk-vat").val();
				var v_address = $("#inp-venbk-address").val();
				var v_email = $("#inp-venbk-email").val();

				var params = {
						"sub" : v_sub1,
						"userID" : v_userID,
						"pws" : v_pws,
						"passwordck" : v_pwsCk,
						"vendor" : v_vendor,
						"principal" : v_principal,
						"vat" : v_vat,
						"address" : v_address,
						"email" : v_email				
				}
				
				$.ajax({
					type : 'post',
					url : 'modifyMenberController',
					contentType : 'application/json',
					data : JSON.stringify(params),
					success : function(req) {
						//console.log("ss",req)
						if(req == "success"){
							Swal.fire({title:"修改完成",
								   timer: 1000,
								   showConfirmButton: false,
								   icon: 'success',
								   //width: "400px",
								  }
								)
						}
					},error :function(){
						console.log("er")
					}
				});
			}
			/*----------------------------------------------------*/
			//停權按鈕
			var index2 = 0;
			$("#venbk-stop").click(function () {
				v_sub1 = $("#venbk-stop").val();
				if(v_sub1 == "stopCancel"){
					index2 = 1;
				}
				if(index2 == 0){
					stop();
					index2 = 1;
					$("#venbk-stop").text("解除停權");
					$("#venbk-stop").val("stopCancel");
					$("#venbk-stop").addClass("btn-warning");
					$("#venbk-stop").removeClass("btn-danger");
					$("#sp-venbk-state").html("停權").css("color","red");
				}else if(index2 == 1){
					stop();
					index2 = 0;
					$("#venbk-stop").text("停權");
					$("#venbk-stop").val("stop");
					$("#venbk-stop").removeClass("btn-warning");
					$("#venbk-stop").addClass("btn-danger");
					$("#sp-venbk-state").html("正常").css("color","");
				}
			});
			
			function stop() {
				
				var v_userID = $("#inp-venbk-id").val();
				var v_pws = $("#inp-venbk-paw").val();
				var v_pwsCk = $("#inp-venbk-passwordck").val();
				var v_vendor = $("#inp-venbk-vendor").val();
				var v_principal = $("#inp-venbk-principal").val();
				var v_vat = $("#inp-venbk-vat").val();
				var v_address = $("#inp-venbk-address").val();
				var v_email = $("#inp-venbk-email").val();

				var params = {
						"sub" : v_sub1,
						"userID" : v_userID,
						"pws" : v_pws,
						"passwordck" : v_pwsCk,
						"vendor" : v_vendor,
						"principal" : v_principal,
						"vat" : v_vat,
						"address" : v_address,
						"email" : v_email				
				}
				
				$.ajax({
					type : 'post',
					url : 'modifyMenberController',
					contentType : 'application/json',
					data : JSON.stringify(params),
					success : function(req) {
						//console.log("ss",req)
						if(req == "stop_success"){
							Swal.fire({title:"停權成功",
								   timer: 1000,
								   showConfirmButton: false,
								   icon: 'success',
								   //width: "400px",
								  }
								)
						}
						if(req == "stopCancel_success"){
							Swal.fire({title:"解除成功",
								   timer: 1000,
								   showConfirmButton: false,
								   icon: 'success',
								   //width: "400px",
								  }
								)
						}
					},error :function(){
						console.log("er")
					}
				});
			}
			//取消
			$("#venbk-but2").click(() => {
				self.location = "MemberManager";
			});
			
			//刪除
			$("#venbk-delete").click(function () {
				v_sub1 =  $("#venbk-delete").val();
				var v_userID = $("#inp-venbk-id").val();

				var params = {
						"sub" : v_sub1,
						"userID" : v_userID,
				}
				
				 Swal.fire({title: "確定刪除？",
		                html: "按下確定後資料會永久刪除",
		                type: "question",
		                confirmButtonText:'確定',
		                denyButtonText:'取消',
		                showDenyButton:true,
		                confirmButtonColor:'#3085d6',
		                cancelButtonColor:'red',
		                icon: 'warning',
		                }).then(function (result){
		                	//console.log(result.value);
		                	if(result.value == true){
		                		$.ajax({
			        				type : 'post',
			        				url : 'modifyMenberController',
			        				contentType : 'application/json',
			        				data : JSON.stringify(params),
			        				success : function(req) {
			        					//console.log(req)
			        					if(req == "delete_success"){
			        						Swal.fire({
			    			                	  title:"完成!",
			    								   timer: 1000,
			    								   showConfirmButton: false,
			    								   icon: 'success'}).then(function(){
			    								self.location = "MemberManager";
			    			                	});
			        					}
			        				},error :function(){
			        					console.log("er")
			        				}
			        			});
		                	}
		                	
		                	
		                	
		                })
		    });
			
			
			
			
		});
	
	</script>
</body>
</html>