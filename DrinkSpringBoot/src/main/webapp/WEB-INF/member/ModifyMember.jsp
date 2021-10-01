<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ModifyMember</title>
<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/newMemberCss/modifyMember.css">
</head>
<body>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"%>
	<div class="d1">
		<div class="d1-check">
			<section>
				<%-- <form id="nForm" action="<%=request.getContextPath()%>/modifyMenberController" method="post"> --%>
					<input id="m-cla" type="hidden" name="type" value="form-a_mo" />
					<fieldset class="fie-check">
						<legend class="leg-check">會員資料修改</legend>
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
					           <h1 style="color: red">請先填寫完整資訊</h1>
					        <%	
					        }
					        %>
						
						<div class="dd1-fg">
							<div>
								<label id="lab-mem-id" for="inp-mem-id">帳號：</label>
								 <input id="inp-mem-id" class="form-control" type="hidden" value="" /> 
								 <input id="inp-mem-gclass" class="form-control" type="hidden" value="" /> 
							</div>
							
							<div class="text-center">
							<!-- 
							  <img id="pic" src="#" class="rounded" style="width: 200px;height: 200px">
							  
							  <form id="uploadForm" enctype="multipart/form-data">
							  	<input id="inp-mem-id" name="userID" class="form-control" type="hidden" value="" />
								  <div class="input-group" style="width: 100%;">
									  <input type="file" class="form-control" id="inputFile" name="inputFile" aria-describedby="inputFileAddon" aria-label="Upload" >
									  <button class="btn btn-outline-secondary" type="button" id="inputFileAddon" style="width: 80px">上傳</button>
								  </div>
							  </form>
							   -->
							  
							</div>
						</div>
						<div class="dd1-check">
							<div>
	
								<label for="inp-mem-pws">密碼：</label>
								
								<input id="inp-mem-pws" class="form-control" type="password" value="" />
								
								<span id="inp-mem-pwsW" class="spa">至少6個字且必須包含英數字</span>
							</div>
							<div>
								<label for="inp-mem-passwordck">密碼確認：</label>
								
								<input id="inp-mem-passwordck" class="form-control" type="password" value=""/>
								
								<span id="inp-mem-pwsckW" class="spa">&nbsp;</span>
							</div>
						</div>
						<div class="dd1-check">
							<div>
								<label for="inp-mem-name">姓名：</label>
								
								<input id="inp-mem-name" class="form-control" style="width: 250px" type="text" value=""  autocomplete="off"/>
								
							</div>
							<div>
								<label for="inp-mem-birthday">出生年月日：</label>
								
								<input  id="inp-mem-birthday" class="form-control" style="width: 250px" type="text" value="" autocomplete="off"/>
								
							</div>
						</div>
						<div class="dd1-check" style="justify-content: left;">
							<div>
								<label for="inp-mem-email">E-mail：</label>
								<input id="inp-mem-email" class="form-control" type="text" value="" style="width: 100%;"
									autocomplete="off" />
								
							</div>
						</div>
						<div class="btnn">
							<button id="mod-but1" class="btn btn-primary" type="submit" name="sub" value="modifySubmit">確認修改</button>
							<button id="mod-but2" class="btn btn-secondary" type="submit" name="sub" value="cancel">取消</button>
						</div>
	
					</fieldset>
				<!-- </form> -->
			</section>
		</div>
	</div>

	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>

	<script type="text/javascript">
	$(function () {
		//日期
		$("#inp-mem-birthday").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
		     changeYear: true
		});
		//取資料
		$.ajax({
			type : 'post',
			url : 'getMemberData_post',
			success : function(req) {
				console.log("ss",req)
				$("#lab-mem-id").html("帳號:" + req["userID"]);
				$("#inp-mem-id").val(req["userID"]);
				if(req["classMember"] == "fa" || req["classMember"] == "ga" || req["classMember"] == "gg" || req["classMember"] == "gab"){
					$("#inp-mem-pws").val("");
					$("#inp-mem-passwordck").val("");
				}else{
					$("#inp-mem-pws").val(req["password"]);
					$("#inp-mem-passwordck").val(req["password"]);
				}
			
				$("#inp-mem-name").val(req["name"]).blur();
				$("#inp-mem-birthday").val(req["birthday"]).blur();
				$("#inp-mem-email").val(req["email"]).blur();
				if(req["picDir"] != null){
					$("#pic").attr("src",req["picDir"]);
				}else{
					$("#pic").attr("src","newMemberCss/img/nopic.jpg");
				}
				if(req["classMember"] == "gg" || req["classMember"] == "ga" || req["classMember"] == "gab" || req["classMember"] == "gb"){
					$("#inp-mem-pws").attr("disabled","disabled");
					$("#inp-mem-passwordck").attr("disabled","disabled");
					$("#inp-mem-gclass").val("general");
				}
				if(req["classMember"] == "gg"){
					$("#mem-but2").attr("disabled","disabled");
				}
			},error :function(){
				console.log("er")
			}
		});
		
		//取消
		$("#mod-but2").click(() => {
			self.location = "HomePage";
		});
		
		//姓名檢查
		$("#inp-mem-name").blur(function() {
			var m_name = $("#inp-mem-name").val();
			if(m_name != ""){
				$("#inp-mem-name").addClass("is-valid");
	        	$("#inp-mem-name").removeClass("is-invalid");
			}else{
		        $("#inp-mem-name").addClass("is-invalid");
		        $("#inp-mem-name").removeClass("is-valid");
			}
		});
		
		//生日檢查
		$("#inp-mem-birthday").blur(function() {
			setTimeout(function() {
				var m_birthday = $("#inp-mem-birthday").val();
				if(m_birthday != ""){
					$("#inp-mem-birthday").addClass("is-valid");
		        	$("#inp-mem-birthday").removeClass("is-invalid");
				}else{
			        $("#inp-mem-birthday").addClass("is-invalid");
			        $("#inp-mem-birthday").removeClass("is-valid");
				}
			}, 200);
		});
		
		//Email檢查
		$("#inp-mem-email").blur(function() {
			var m_email = $("#inp-mem-email").val();
			if(m_email != ""){
				$("#inp-mem-email").addClass("is-valid");
	        	$("#inp-mem-email").removeClass("is-invalid");
			}else{
		        $("#inp-mem-email").addClass("is-invalid");
		        $("#inp-mem-email").removeClass("is-valid");
			}
		});
		
		//送出
		$("#mod-but1").click(function () {
			var m_sub1 = $("#mod-but1").val();
			var m_type = $("#m-cla").val();
			var m_userID = $("#inp-mem-id").val();
			var m_pws = $("#inp-mem-pws").val();
			var m_pwsCk = $("#inp-mem-passwordck").val();
			var m_name = $("#inp-mem-name").val();
			var m_birthday = $("#inp-mem-birthday").val();
			var m_email = $("#inp-mem-email").val();
			var m_gclass = $("#inp-mem-gclass").val();
				var params = {
					"sub" : m_sub1,
					"type" : m_type,
					"userID" : m_userID,
					"pws" : m_pws,
					"passwordck" : m_pwsCk,
					"name" : m_name,
					"birthday" : m_birthday,
					"email" : m_email,
					"gclass" : m_gclass
				};
			
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
		function pwsck() {
			let thePwsObjVal = $("#inp-mem-pws").val();
	        let thp1 = false,thp2 = false;
	        let pwsL = thePwsObjVal.length;
	        if (thePwsObjVal == "") {
	        	$("#inp-mem-pwsW").text("密碼不可為空");
	            $("#inp-mem-pwsW").css("color", "red");
	            $("#inp-mem-pws").addClass("is-invalid");
	            $("#inp-mem-pws").removeClass("is-valid");
	          } else if (pwsL < 6) {
	        	  $("#inp-mem-pwsW").text("至少6個字且必須包含英數字");
	              $("#inp-mem-pwsW").css("color", "red");
	              $("#inp-mem-pws").addClass("is-invalid");
	              $("#inp-mem-pws").removeClass("is-valid");
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
	             	$("#inp-mem-pwsW").text("必須包含英數字")
	              	$("#inp-mem-pwsW").css("color", "red");
	              	$("#inp-mem-pws").addClass("is-invalid");
	              	$("#inp-mem-pws").removeClass("is-valid");
	            }
	            if (thp1 && thp2) {
	            	$("#inp-mem-pwsW").text("正確")
	              	$("#inp-mem-pwsW").css("color", "green");
	              	$("#inp-mem-pws").removeClass("is-invalid");
	              	$("#inp-mem-pws").addClass("is-valid");
	            }
	           
	          }
		}
		
		//確認密碼檢查
		function pwsck2() {
			let thePwsCkObjVal = $("#inp-mem-passwordck").val();
	        let pw = $("#inp-mem-pws").val();
	        let thp1 = false,thp2 = false;
	        let pwsL = thePwsCkObjVal.length;
	        
	        if (thePwsCkObjVal == "") {
	        	$("#inp-mem-pwsckW").text("密碼不可為空");
	            $("#inp-mem-pwsckW").css("color", "red");
	            $("#inp-mem-passwordck").addClass("is-invalid");
	            $("#inp-mem-passwordck").removeClass("is-valid");
	            $("#inp-mem-d-pawck").removeClass("dd1");
	        	$("#inp-mem-d-pawck").addClass("dd2");
	          } else if(pw != thePwsCkObjVal){
	        	  $("#inp-mem-pwsckW").text("兩次密碼不符");
	              $("#inp-mem-pwsckW").css("color", "red");
	              $("#inp-mem-passwordck").addClass("is-invalid");
	              $("#inp-mem-passwordck").removeClass("is-valid");
	              $("#inp-mem-d-pawck").removeClass("dd1");
	          	  $("#inp-mem-d-pawck").addClass("dd2");
	          } else if (pwsL < 6) {
	        	  $("#inp-mem-pwsckW").text("至少6個字且必須包含英數字");
	              $("#inp-mem-pwsckW").css("color", "red");
	              $("#inp-mem-passwordck").addClass("is-invalid");
	              $("#inp-mem-passwordck").removeClass("is-valid");
	              $("#inp-mem-d-pawck").removeClass("dd1");
	          	  $("#inp-mem-d-pawck").addClass("dd2");
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
	            	$("#inp-mem-pwsckW").text("正確")
	              	$("#inp-mem-pwsckW").css("color", "green");
	              	$("#inp-mem-passwordck").removeClass("is-invalid");
	              	$("#inp-mem-passwordck").addClass("is-valid");
	              	$("#inp-mem-d-pawck").removeClass("dd1");
	             	$("#inp-mem-d-pawck").addClass("dd2");
	              }
	          }
		}
		
		//密碼檢查
		$("#inp-mem-pws").blur(pwsck);
		
		//確認密碼
		$("#inp-mem-passwordck").blur(pwsck2);
		
		//即時顯示圖片
		$("#inputFile").change(function() {
			var readFile = new FileReader();
			var mfile = $("#inputFile")[0].files[0];
			readFile.readAsDataURL(mfile);
			readFile.onload = function() {
				var img = $("#pic");
				img.attr("src", this.result);
			}
		});
		
		//上傳照片
		$("#inputFileAddon").click(function () {
			var img_formData = new FormData($("#uploadForm")[0]);
			console.log(img_formData);
			$.ajax({
				type : 'post',
				url : 'uploadMemberPic',
				processData: false,
				contentType: false,
				data : img_formData,
				cache : false,
				success : function(req) {
					console.log(req);
					if(req == "success_upload"){
						Swal.fire({title:"上傳成功",
							   timer: 1000,
							   showConfirmButton: false,
							   icon: 'success',
							   //width: "400px",
							  })
					}if(req == "error_upload"){
						Swal.fire({title:"請選擇圖片",
							   timer: 1000,
							   showConfirmButton: false,
							   icon: 'error',
							   //width: "400px",
							  })
					}
					
				}
			});
		});
		
		
		
		
		
		
		
	});
	</script>


</body>
</html>