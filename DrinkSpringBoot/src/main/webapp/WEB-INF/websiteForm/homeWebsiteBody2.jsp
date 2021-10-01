<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 連結: 放body裡最後一行。如果body裡有javascript，要放 javascript 之前
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp" %>
 --%>

</div>

<!-- 登入 and 登出  -->
<%@ include file="/WEB-INF/login/LoginDiv.jsp" %>
<!-- 註冊會員 -->
<%@ include file="/WEB-INF/member/NewMemberDiv.jsp" %>

<!-- Footer-->
<footer class="footer bg-black small text-center text-white-50">
	<div class="container px-4 px-lg-5">Copyright &copy; 資策會EEIT129第三組</div>
</footer>

<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="homePageStyleAndJs/js/scripts.js"></script>
<!-- jQuery -->
<script src="<%=request.getContextPath()%>/Library/jquery-3.6.0.js"></script>
<script src="<%=request.getContextPath()%>/Library/jquery-ui-1.12.1/jquery-ui.js"></script>
<!-- sweetalert2 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<!-- 購物車script -->
  <script type="text/javascript">
    $('#shopcars').mouseover(function(){
    	$('#myshopcar').css('display','inline')
    	
    });
    $('#shopcars').mouseout(function(){
    	$('#myshopcar').css('display','none')
    });
    $('#myshopcar').mouseover(function(){
    	$('#myshopcar').css('display','inline')
    	
    });
    $('#myshopcar').mouseout(function(){
    	$('#myshopcar').css('display','none')
    });
    function deleteprouct(id){
    	console.log(id);
    	var params={
    			"prouctID":id
    	};
    	console.log(params);
    	
		$.ajax({
			type : 'post',
			url : 'accountdeleteshopcarprouct.controller',
			contentType : 'application/json',
			data : JSON.stringify(params),
			success : function(data) {
				console.log(data);
				Swal.fire({
					  icon: 'success',
					  title: '已刪除',
					  showConfirmButton: false,
					  timer: 1500
					});
				$('.prouct'+data).html("");
				
		      


			},
			error : function(e) {
				console.log(e);
			}
		});
    };
	
    </script>
