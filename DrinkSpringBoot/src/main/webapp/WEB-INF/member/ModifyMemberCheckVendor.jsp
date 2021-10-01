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

	<div class="d1">

		<div class="d1-check" style="width:70%; display: inline-block;">
			<section>
				<%-- <form id="nForm" action="<%=request.getContextPath()%>/modifyMenberController" method="post">--%>
					<input type="hidden" name="type" value="form-a_mo" />
					<fieldset class="fie-check">
						<legend class="leg-check">企業會員資料</legend>

						<div class="dd1-check">
							<div>
								<label id="lab-ven-id">帳號:</label>						
							</div>
							<div>
								<label id="lab-ven-vendor">企業名稱：</label>
							</div>
						</div>
						<div class="dd1-check">
							<div>
								<label id="lab-ven-paw">密碼:</label>
							</div>
							<div></div>
						</div>
						<div class="dd1-check">
							<div>
								<label id="lab-ven-principal">負責人：</label>
							</div>
							<div>
								<label id="lab-ven-vat">統一編號：</label>
							</div>
						</div>
						<div class="dd1-check">
							<div style="display: left;">
								<label id="lab-ven-address">住址：</label>
							</div>
						</div>
						<div class="dd1-check">
							<div style="display: left;">
								<label id="lab-ven-email">E-mail：</label>
							</div>
						</div>
						
						<div class="btnn">
							<button id="venck-but1" class="btn btn-primary" name="sub" value="modify">修改</button>
							<button id="venck-but2" class="btn btn-warning" name="sub" value="delete">刪除帳號</button>
							<button id="venck-but3" class="btn btn-secondary" name="sub" value="cancel">取消</button>
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
					$("#lab-ven-id").html("帳號:" + req["userID"]);
					$("#lab-ven-paw").html("密碼:***");
					$("#lab-ven-vendor").html("企業名稱:" + req["vendor"]);
					$("#lab-ven-principal").html("負責人:" + req["principal"]);
					$("#lab-ven-vat").html("統一編號:" + req["vat"]);
					$("#lab-ven-address").html("地址:" + req["address"]);
					$("#lab-ven-email").html("Email:" + req["email"]);
				},error :function(){
					console.log("er")
				}
			});
			
			//進修改頁面
			$("#venck-but1").click(function () {
				self.location = "toModifyMemberVendor";
			})
			
			//取消
			$("#venck-but3").click(function () {
				self.location = "HomePage";
			});
			
			//刪除
			$("#venck-but2").click(function () {
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