<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <meta name="google-signin-scope" content="profile email">
		<meta name="google-signin-client_id"
			content='637462585958-er8g4agnmt6htubesbltl6758qbflnf4.apps.googleusercontent.com'>
        <title>HomePage</title>
        
        <%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp"  %>
    </head>
    <body>
    	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp"  %>
    	
			
			<!-- 依照回傳登入狀態顯示頁面 --> 
            <%
            if(Longin == null){	// 未登入狀態的頁面
            %>
            
   				<!-- Banner_1 輪播圖 --> 
            	<%@ include file="/WEB-INF/forHomePageUse/HomePageBanner_1.jsp"  %>
            	
        		<!-- 其他 -->	
	            <%@ include file="/WEB-INF/forHomePageUse/HomePageBanner_2.jsp"  %>
	            
	            <!-- 其他 -->	
	            <div></div>
	            
        	<%	
            }else if( ClassMember.equals("a") || ClassMember.equals("fa") ){ // 一般會員登入
            %>
            
            	<!-- Banner_1 輪播圖 --> 
            	<%@ include file="/WEB-INF/forHomePageUse/HomePageBanner_1.jsp"  %>
            	
            	<!-- 其他 -->	
	            <%@ include file="/WEB-INF/forHomePageUse/HomePageBanner_2.jsp"  %>
            	
        		<!-- 其他 -->	
	            <div></div>
            
            
            <%	
            }else if( ClassMember.equals("b") || ClassMember.equals("fb") ){ // 企業會員登入
            %>
        		
        		<%@ include file="/WEB-INF/forHomePageUse/EnterpriseFirstPage.jsp"  %>
            	
            <% 
            }else if( ( ClassMember.equals("ga") || ClassMember.equals("gab") ) && "success_g".equals(Longin) ){ // 一般會員登入 google
            %>
            
            	<!-- Banner_1 輪播圖 --> 
            	<%@ include file="/WEB-INF/forHomePageUse/HomePageBanner_1.jsp"  %>
            	
            	<!-- 其他 -->	
	            <%@ include file="/WEB-INF/forHomePageUse/HomePageBanner_2.jsp"  %>
            	
        		<!-- 其他 -->	
	            <div></div>
            
            
            <%	
            }else if( ( ClassMember.equals("gb") || ClassMember.equals("gab") ) && "success_v".equals(Longin)){ // 企業會員登入 google
                %>
        		
            		<%@ include file="/WEB-INF/forHomePageUse/EnterpriseFirstPage.jsp"  %>
                	
                <% 
                }
            %>
         
        
        
    	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp" %>
    	
    </body>
</html>

