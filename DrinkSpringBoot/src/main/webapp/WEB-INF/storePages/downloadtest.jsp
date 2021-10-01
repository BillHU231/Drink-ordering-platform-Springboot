<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Download test</title>
</head>
<body>
<p style="font-size: 20px;color: red;">使用a標籤方式將json匯出csv檔案</p>
 <button id="dataDownload" onclick='tableToExcel()'>店家資料下載</button>
 
 
 
 
 	<!-- 引入Ajax -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!--引用jQuery-->
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
 
 
     
  <script>
  
  $(document).ready(function(){
	  $("#dataDownload").click(function(){
		  $.ajax({
				type:'POST',
				url:'download.controller',
				dataType: 'json',
				success:function(data){
					//列標題
				      let str = "店家ID,創建日期,企業帳號,店家名稱,負責人,地址,聯絡電話,簡介\n";
				      //增加\t為了不讓表格顯示科學計數法或者其他格式
				      for(let i = 0 ; i < data.length ; i++ ){
				        for(let item in data[i]){
				        	if(item != 'photo'){
				            str = str + data[i][item]+","; 
				        	}
				        }
				       		 str = str + '\n';
				      }
				      //encodeURIComponent解決中文亂碼
				      let uri = 'data:text/csv;charset=utf-8,\ufeff' + encodeURIComponent(str);
				      //通過建立a標籤實現
				      var link = document.createElement("a");
				      link.href = uri;
				      //對下載的檔案命名
				      link.download =  "json資料表.csv";
				      document.body.appendChild(link);
				      link.click();
				      document.body.removeChild(link);
				}
		  
		  });
	  });
	  
	  
	  
  });
  
  
  
  
  
  
  
  
  
  
  
  
//     function tableToExcel(){
//       //要匯出的json資料
//       var jsonData = [
//         {
//           name:'路人甲',
//           phone:'123456789',
//           email:'[email protected]'
//         },
//         {
//           name:'炮灰乙',
//           phone:'123456789',
//           email:'[email protected]'
//         },
//         {
//           name:'土匪丙',
//           phone:'123456789',
//           email:'[email protected]'
//         },
//         {
//           name:'流氓丁',
//           phone:'123456789',
//           email:'[email protected]'
//         },
//       ]
//     //列標題
//       let str = "姓名,電話,郵箱\n";
//       //增加\t為了不讓表格顯示科學計數法或者其他格式
//       for(let i = 0 ; i < jsonData.length ; i++ ){
//         for(let item in jsonData[i]){
//             str = str + jsonData[i][item]+",";     
//         }
//         str = str + '\n';
//       }
//       //encodeURIComponent解決中文亂碼
//       let uri = 'data:text/csv;charset=utf-8,\ufeff' + encodeURIComponent(str);
//       //通過建立a標籤實現
//       var link = document.createElement("a");
//       link.href = uri;
//       //對下載的檔案命名
//       link.download =  "json資料表.csv";
//       document.body.appendChild(link);
//       link.click();
//       document.body.removeChild(link);
//     }

</script>
</body>
</html>