<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 連結: 放body裡最後一行。如果body裡有javascript，要放 javascript 之前
	<%@ include file="/WEB-INF/websiteForm/backWebsiteBody2.jsp" %>
 --%>
 			</div>
        </main>
    </div>
</div>

<!-- 登入 and 登出  -->
<%@ include file="/WEB-INF/login/LoginDiv.jsp" %>
    
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
<script src="websiteStyleAndJs/homePageTemplateJS/js/scripts.js"></script>
<script src="<%=request.getContextPath() %>/Library/jquery-3.6.0.js"></script>
<script src="<%=request.getContextPath() %>/Library/jquery-ui-1.12.1/jquery-ui.js"></script>

<script>

</script>

	        