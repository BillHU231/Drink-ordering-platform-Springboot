<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

	 <!-- <div style="min-width: 1100px"> -->
	<div class="d1">
		
		 <!-- <div class="d1-check div-img" style="width: 300px; display: inline-block;">
			<img src="newMemberCss/img/memImg1.jpg">
			
		</div>  -->

		<div class="d1-check" style="width:70%; display: inline-block;">
			<section>
				<%-- <form id="nForm" action="<%=request.getContextPath()%>/modifyMenberController" method="post">--%>
					<input type="hidden" name="type" value="form-a_mo" />
					<fieldset class="fie-check">
						<legend class="leg-check">會員資料</legend>

						<div class="dd1-check">
							<div>
								<label id="lab-mem-id">帳號:</label>					
							</div>
							<!-- <div>
								<img id="pic" src="#" class="rounded" style="width: 200px;height: 200px">
							</div> -->
						</div>
						<div class="dd1-check">
							<div>
								<label id="lab-mem-paw">密碼:</label>
							</div>
							<div></div>
						</div>
						<div class="dd1-check">
							<div>
								<label id="lab-mem-name">姓名：</label>
							</div>
							<div>
								<label id="lab-mem-birthday">出生年月日：</label>
							</div>
						</div>
						<div>
							<div style="text-align: left">
								<label id="lab-mem-email">E-mail：</label>
							</div>
						</div>
						<div class="btnn">
							<button id="memck-but1" class="btn btn-primary" name="sub" value="modify">修改</button>
							<button id="memck-but2" class="btn btn-warning" name="sub" value="delete">刪除帳號</button>
							<button id="memck-but3" class="btn btn-secondary" name="sub" value="cancel">取消</button>
						</div>

					</fieldset>
				<%--</form>--%>
			</section>
		</div>

	</div>
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp"%>


	<script type="text/javascript">
		$(function () {
			$.ajax({
				type : 'post',
				url : 'getMemberData_post',
				success : function(req) {
					//console.log("ss",req)
					$("#lab-mem-id").html("帳號:" + req["userID"]);
					$("#lab-mem-paw").html("密碼:***");
					$("#lab-mem-name").html("姓名:" + req["name"]);
					$("#lab-mem-birthday").html("出生年月日:" + req["birthday"]);
					$("#lab-mem-email").html("Email:" + req["email"]);
					if(req["picDir"] != null){
						$("#pic").attr("src",req["picDir"]);
					}else{
						$("#pic").attr("src","newMemberCss/img/nopic.jpg");
					}
				},error :function(){
					console.log("er")
				}
			});
			
			//進修改頁面
			$("#memck-but1").click(function () {
				self.location = "toModifyMember";
			})
			
			//取消
			$("#memck-but3").click(function () {
				self.location = "HomePage";
			});
			
			//刪除
			$("#memck-but2").click(function () {
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
			        				url : 'deleteMember',
			        				success : function(req) {
			        					//console.log(req)
			        					if(req == "delete_success"){
			        						Swal.fire({
			    			                	  title:"完成!",
			    								   timer: 1000,
			    								   showConfirmButton: false,
			    								   icon: 'success'}).then(function(){
			    								self.location = "HomePage";
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