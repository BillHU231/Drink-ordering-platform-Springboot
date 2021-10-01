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
								<label id="lab-membk-id" for="inp-mem-id">帳號：</label>
								<input id="inp-membk-id" class="form-control" type="hidden" value="" /> 
							</div>
							
							<div>
								<label>會員狀態：<span id="sp-membk-state"></span></label>
								<button id="membk-stop" class="btn btn-danger" value="stop" style="margin-left:70px">停權</button>
							</div>
						</div>
						<div class="dd1-bk">
							<div>
	
								<label id="lab-membk-paw">密碼：</label>
								<input id="inp-membk-paw" class="form-control" type="hidden" value="" /> 
								<input id="inp-membk-passwordck" class="form-control" type="hidden" value="" /> 
							</div>
						</div>
						<div class="dd1-bk">
							<div>
								<label for="inp-membk-name">姓名：</label>
								
								<input id="inp-membk-name" class="form-control" style="width: 250px" type="text" value=""  autocomplete="off"/>
								
							</div>
							<div>
								<label for="inp-membk-birthday">出生年月日：</label>
								
								<input  id="inp-membk-birthday" class="form-control" style="width: 250px" type="text" value="" autocomplete="off"/>
								
							</div>
						</div>
						<div class="dd1-bk" style="justify-content: left;">
							<div>
								<label for="inp-membk-email">E-mail：</label>
								<input id="inp-membk-email" class="form-control" type="text" value="" style="width: 100%;"
									autocomplete="off" />
								
							</div>
						</div>
						<div class="btnn-bk">
							<button id="membk-but1" class="btn btn-primary" type="button" name="sub" value="modifySubmit">確認修改</button>
							<button id="membk-but2" class="btn btn-secondary" type="button" name="sub" value="cancel">返回</button>
							<button id="membk-delete" class="btn btn-danger" type="button" name="sub" value="delete">刪除帳號</button>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
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
					$("#lab-membk-id").html("帳號:" + req["userID"]);
					$("#inp-membk-id").val(req["userID"]);
					if(req["classMember"] == "a"){
						$("#lab-membk-paw").html("密碼：正常");
						$("#sp-membk-state").html("正常");
					}else if(req["classMember"] == "fa"){
						$("#lab-membk-paw").html("密碼：忘記密碼未修改");
						$("#sp-membk-state").html("正常");
					}else if(req["classMember"] == "stop_a" || req["classMember"] == "stop_fa"){
						$("#lab-membk-paw").html("密碼：");
						$("#sp-membk-state").html("停權");
						$("#membk-stop").text("解除停權");
						$("#membk-stop").addClass("btn-warning");
						$("#membk-stop").removeClass("btn-danger");
						$("#membk-stop").val("stopCancel");
					}
					$("#inp-membk-paw").val(req["password"]);
					$("#inp-membk-passwordck").val(req["password"]);
					
					$("#inp-membk-name").val(req["name"]);
					$("#inp-membk-birthday").val(req["birthday"]);
					$("#inp-membk-email").val(req["email"]);
					
					$("#inp-membk-name").attr('disabled', 'disabled');
					$("#inp-membk-birthday").attr('disabled', 'disabled');
					$("#inp-membk-email").attr('disabled', 'disabled');
					$("#membk-but1").text('修改');
					
				},error :function(){
					console.log("er")
				}
			});
			
			//日期
			$("#inp-membk-birthday").datepicker({
				dateFormat: 'yy-mm-dd',
				changeMonth: true,
			     changeYear: true
			});
			
			
		});
	
		
		
		
		$(function () {
			
			/*--共用var--*/
			var m_sub1 = "";
			/*----------*/
			//修改按鈕
			var index = 0;
			$("#membk-but1").click(function () {
				if(index == 0){
					ck1();
					index = 1;
				}else if(index == 1){
					ck2();
					index = 0;
					m_sub1 = $("#membk-but1").val();
					subm();
				}
			});
			
			function ck1() {
				$("#inp-membk-name").removeAttr('disabled');
				$("#inp-membk-birthday").removeAttr('disabled');
				$("#inp-membk-email").removeAttr('disabled');
				$("#membk-but1").text('確認修改');
			}
			function ck2() {
				$("#inp-membk-name").attr('disabled', 'disabled');
				$("#inp-membk-birthday").attr('disabled', 'disabled');
				$("#inp-membk-email").attr('disabled', 'disabled');
				$("#membk-but1").text('修改');
			}
			
			function subm() {
				
				var m_userID = $("#inp-membk-id").val();
				var m_pws = $("#inp-membk-paw").val();
				var m_pwsCk = $("#inp-membk-passwordck").val();
				var m_name = $("#inp-membk-name").val();
				var m_birthday = $("#inp-membk-birthday").val();
				var m_email = $("#inp-membk-email").val();

				var params = {
						"sub" : m_sub1,
						"userID" : m_userID,
						"pws" : m_pws,
						"passwordck" : m_pwsCk,
						"name" : m_name,
						"birthday" : m_birthday,
						"email" : m_email				
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
			$("#membk-stop").click(function () {
				m_sub1 = $("#membk-stop").val();
				if(m_sub1 == "stopCancel"){
					index2 = 1;
				}
				if(index2 == 0){
					stop();
					index2 = 1;
					$("#membk-stop").text("解除停權");
					$("#membk-stop").val("stopCancel");
					$("#membk-stop").addClass("btn-warning");
					$("#membk-stop").removeClass("btn-danger");
					$("#sp-membk-state").html("停權").css("color","red");
				}else if(index2 == 1){
					stop();
					index2 = 0;
					$("#membk-stop").text("停權");
					$("#membk-stop").val("stop");
					$("#membk-stop").removeClass("btn-warning");
					$("#membk-stop").addClass("btn-danger");
					$("#sp-membk-state").html("正常").css("color","");
				}
			});
			
			function stop() {
				
				var m_userID = $("#inp-membk-id").val();
				var m_pws = $("#inp-membk-paw").val();
				var m_pwsCk = $("#inp-membk-passwordck").val();
				var m_name = $("#inp-membk-name").val();
				var m_birthday = $("#inp-membk-birthday").val();
				var m_email = $("#inp-membk-email").val();

				var params = {
						"sub" : m_sub1,
						"userID" : m_userID,
						"pws" : m_pws,
						"passwordck" : m_pwsCk,
						"name" : m_name,
						"birthday" : m_birthday,
						"email" : m_email				
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
			$("#membk-but2").click(() => {
				self.location = "MemberManager";
			});
			
			//刪除
			$("#membk-delete").click(function () {
				m_sub1 =  $("#membk-delete").val();
				var m_userID = $("#inp-membk-id").val();

				var params = {
						"sub" : m_sub1,
						"userID" : m_userID,
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