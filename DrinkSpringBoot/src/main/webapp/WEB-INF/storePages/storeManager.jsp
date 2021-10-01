<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="tw.drink.store.model.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Store Manager</title>

<!--bootstrape匯入-->
<!-- <link -->
<!-- 	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" -->
<!-- 	rel="stylesheet" -->
<!-- 	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" -->
<!-- 	crossorigin="anonymous"> -->

<!--自己的CSS-->
<link rel="stylesheet" href="store/css/index.css">

<!-- datatables css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.0/css/dataTables.bootstrap5.min.css" />
<%@ include file="/WEB-INF/websiteForm/backWebsiteHead.jsp"%>
</head>



<body>
	<%@ include file="/WEB-INF/websiteForm/backWebsiteBody1.jsp"%>

	<!--內文開始-->


	<nav>
		<div class="nav nav-tabs " id="nav-tab" role="tablist">
			<button class="nav-link active gmtab" id="nav-home-tab"
				data-bs-toggle="tab" data-bs-target="#nav-home" type="button"
				role="tab" aria-controls="nav-home" aria-selected="true">店家資料</button>
			<button class="nav-link gmtab" id="nav-profile-tab" data-bs-toggle="tab"
				data-bs-target="#nav-profile" type="button" role="tab"
				aria-controls="nav-profile" aria-selected="false">產品資料</button>
		</div>
	</nav>
	<div class="tab-content" id="nav-tabContent">
		
		<!-- 店家頁籤 -->
		<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
			
			
		<div style="width:1000px;margin:10px auto;text-align:center">
			<h3 style="text-align:center;font-weight:bold;">店家地區分布圖</h3>
			 <!-- 左圖表 -->
				<div style="height:520px;width:400px;display:inline-block;float:left;">
					<canvas id="storeArea"></canvas>
				</div>
			<!-- 右圖片 -->
				<div style="height:460px;width:400px;text-align:center;display:inline-block;margin-left:100px;margin-bottom:20px;">
					<img style="height:460px;" src="store/Taiwan.png">
				</div>
			</div>
			

			
			
		
			
			<br/>
			<hr/>
			<!-- datatables -->			
			<h3 style="text-align:center;font-weight:bold;">店家資料一覽表</h3>
						<!-- 按鈕 -->
			<div class="" style=" width:150px; height:50px;float:right;">
				 <button id="dataDownload" class="btn btn-outline-secondary" onclick='tableToExcel()'>店家資料下載</button>
			</div>
			
			
			<div class="card-body mytable2" style="margin-top:50px;">
				<table id="datatablesSimple" class="table table-striped" style="width: 100%">
					<thead>
						<tr>
							<th>企業帳號</th>
							<th>店家ID</th>
							<th>店家封面</th>
							<th>建立日期</th>
							<th>店家名稱</th>
							<th>負責人</th>
							<th>聯絡電話</th>
							<th>地址</th>
							<th>簡介</th>
							<th>編輯</th>
							<th>刪除</th>
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${AllStores}" var="store">
							<tr>

								<td>${store.cuserid}</td>
								<td>${store.storeid}</td>

								<c:if test="${empty fn:trim(store.photo)}">
									<td><img class="mgimage" src="store/NoItem.jpg" alt=""></td>
								</c:if>
								<c:if test="${store.photo != null}">
									<td><img class="mgimage" src="<%=request.getContextPath()%>/StoreIMG/${store.storeid}" alt=""></td>
								</c:if>

								<td>${store.startdate}</td>
								<td>${store.title}</td>
								<td>${store.manager}</td>
								<td>${store.tel}</td>
								<td>${store.stadd}</td>
								<td>${store.intro}</td>
								<td>
									<form action="storeGmEditEntry.controller" method="post">
										<input type="hidden" name="imbtn" value="${store.storeid}">
										<input class="imbtn2 myedit" type="image" src="store/edit.png">
									</form>
								</td>
							<td class="mytd myicon">
								<form id="storedelete${store.storeid}" action="storeGmDeleteEntry.controller" method="post">
								<input type="hidden" name="imbtn" value="${store.storeid}">
							</form>
								<button class="mybutton"  onclick="Sdelete(${store.storeid})"><img class="imbtn2 mydelete" src="store/delete.png"></button>
						</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<hr/>
			<!-- 編輯紀錄-->			
			<h3 style="text-align:center;font-weight:bold;">店家異動紀錄</h3>
			
			<div class="card-body mytable2" style="margin-top:50px;">
				<table id="datatablesSimple3" class="table table-striped" style="width: 100%">
					<thead>
						<tr>
							<th>編輯ID</th>
							<th>企業帳號</th>
							<th>店家ID</th>
							<th>更新日期</th>
							<th>項目</th>
							<th>詳細資料</th>
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${storeRec}" var="storeRec">
							<tr>
								<td>${storeRec.seditid}</td>
								<td>${storeRec.cuserid}</td>
								<td>${storeRec.storeid}</td>
								<td>${storeRec.editdate}</td>
								<td>${storeRec.item}</td>
								<td>${storeRec.detail}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			
		</div>



		<!-- 產品頁籤 -->
		<div class="tab-pane fade" id="nav-profile" role="tabpanel"	aria-labelledby="nav-profile-tab">
			<!-- datatables -->
			<div class="card-body">
				<table id="datatablesSimple2" class="table table-striped" style="width: 100%">
					<thead>
						<tr>
							<th>店家ID號碼</th>
							<th>產品ID號碼</th>
							<th>產品封面</th>
							<th>建立日期</th>
							<th>產品名稱</th>
							<th>售價</th>
							<th>分類</th>
							<th>簡介</th>
							<th>編輯</th>
							<th>刪除</th>
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${AllProducts}" var="product">
							<tr>

								<td>${product.pstoreid}</td>
								<td>${product.proid}</td>

								<c:if test="${empty fn:trim(product.pphoto)}">
									<td><img class="mgimage" src="store/NoItem.jpg" alt=""></td>
								</c:if>
								<c:if test="${product.pphoto != null}">
									<td><img class="mgimage" src="<%=request.getContextPath()%>/ProductIMG/${product.pstoreid}${product.proid}" alt=""></td>
								</c:if>

								<td>${product.pstartdate}</td>
								<td>${product.proname}</td>
								<td>${product.proprice}</td>
								<td>${product.category}</td>
								<td>${product.pintro}</td>
								<td>
									<form action="productGmEditEntry.controller" method="post">
										<input type="hidden" name="imbtn" value="${product.proid}">
										<input class="imbtn2 myedit" type="image" src="store/edit.png">
									</form>
								</td>
							<td>
								<form id="productdelete${product.proid}" action="productGmDeleteEntry.controller" method="post">
									<input type="hidden" name="imbtn" value="${product.proid}"> 
								</form>
									<button class="mybutton "  onclick="Pdelete(${product.proid})"><img class="imbtn2 mydelete" src="store/delete.png"></button>
							</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<hr/>
			
		</div>
		
		

		
		
	</div>







	<!---------------- 匯入 ------------------------>
	<!-- 引入Ajax -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- 匯入圖表 -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
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
	<!-- include往下放會看不到datatables效果 -->
	
	<!--引用sweetalert-->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.1/dist/sweetalert2.all.min.js"></script>
	
	<%@ include file="/WEB-INF/websiteForm/backWebsiteBody2.jsp"%>
	<!--引用dataTables.js(一定要放置最下面)-->
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.0/js/dataTables.bootstrap5.min.js"></script>


<!-- sweetalert彈跳視窗 -->
<script type="text/javascript">

function Sdelete(id){
	Swal.fire({
		title: '確定刪除店家?',
        text: "刪除店家將會連同產品一起刪除!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '刪除',
        cancelButtonText: '取消'
		}).then((result) => {
	         if (result.isConfirmed) {
	             Swal.fire({
	              icon: 'success',
	              title: '刪除成功',
	              showConfirmButton: false,
	              timer: 1500
	            }) 
	             setTimeout(() => document.getElementById("storedelete"+id).submit(), 1500)
	            }
	          })
	        }
 
function Pdelete(id){
	Swal.fire({
		title: '確定刪除?',
        text: "資料將無法復原!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '刪除',
        cancelButtonText: '取消'
		}).then((result) => {
	         if (result.isConfirmed) {
	             Swal.fire({
	              icon: 'success',
	              title: '刪除成功',
	              showConfirmButton: false,
	              timer: 1500
	            }) 
	            setTimeout(() => document.getElementById("productdelete"+id).submit(), 1500)
	            }
	          })
	        }
</script>






<!-- icon滑入滑出 -->
<script type="text/javascript">
	$(function () {
	$( ".myedit" ).mouseover(function() {
		 $(this).attr("src","store/01edit.png");
		});
	$( ".myedit" ).mouseout(function() {
		$(this).attr("src","store/edit.png");
		});
	$( ".mydelete" ).mouseover(function() {
		$(this).attr("src","store/01delete.png");
		});
	$( ".mydelete" ).mouseout(function() {
		$(this).attr("src","store/delete.png");
		});	
	});
	
</script>


<!-- datatables -->
<script type="text/javascript">
	$(document)	.ready(	function() {
		
		//店家table
		$('#datatablesSimple').DataTable({
							
							//欄位內部設定
							columnDefs : [{ //垂直置中
										targets : '_all',
										createdCell : function(	td,cellData,rowData,row, col) {
											$(td).css({'vertical-align':'middle','width':'4px'});
											
										}
									},
									{ //水平置中
										targets : '_all',
										className : 'text-center'
									},
									{
										targets : 9,
										orderable : false
										
									},
									//第10列取消排序功能
									{
										targets : 10,
										orderable : false
								      
									} //第11列取消排序功能
							],

							//屬性區塊,
							lengthMenu : [
									[ 10, 25, 50, -1 ],
									[ "10筆", "25筆", "50筆",
											"全部資料" ] ], //[顯示多少頁面,顯示在table的方式]
							//語言區塊(language),
							language : {
								"lengthMenu" : "顯示 _MENU_ 資料",
								"sZeroRecords" : "無查詢結果",
								"sInfo" : "目前有 _MAX_ 筆資料",
								"sSearch" : "關鍵字搜尋:",
								"sEmptyTable" : "尚有資料紀錄存在",
								"oPaginate" : {
									"sFirst" : "首頁",
									"sPrevious" : "上一頁",
									"sNext" : "下一頁",
									"sLast" : "末頁"
								}
							},
						});

		    //產品table
			$('#datatablesSimple2')	.DataTable(
									{
										//欄位內部設定
										columnDefs : [
												{ //垂直置中
													targets : '_all',
													createdCell : function(
															td,cellData,rowData,row, col) {
														$(td).css('vertical-align',	'middle');
														
													}
												},
												{ 
												//水平置中
													targets : '_all',
													className : 'text-center'
												},
												//第9列取消排序功能
												{
													targets : 8,
													orderable : false
											          
												},
												//第10列取消排序功能
												{
													targets: 9,
													orderable : false
											          
												} 
										],

										//屬性區塊,
										lengthMenu : [
												[ 10, 25, 50, -1 ],
												[ "10筆", "25筆", "50筆",
														"全部資料" ] ], //[顯示多少頁面,顯示在table的方式]
										//語言區塊(language),
										language : {
											"lengthMenu" : "顯示 _MENU_ 資料",
											"sZeroRecords" : "無查詢結果",
											"sInfo" : "目前有 _MAX_ 筆資料",
											"sSearch" : "關鍵字搜尋:",
											"sEmptyTable" : "尚有資料紀錄存在",
											"oPaginate" : {
												"sFirst" : "首頁",
												"sPrevious" : "上一頁",
												"sNext" : "下一頁",
												"sLast" : "末頁"
											}
										},
									});
	
	
	 //store紀錄table
	$('#datatablesSimple3')	.DataTable(
							{
								//降冪設定
								order: [ 0, 'desc' ],
								
								//欄位內部設定
								columnDefs : [
										{ //垂直置中
											targets : '_all',
											createdCell : function(
													td,cellData,rowData,row, col) {
												$(td).css('vertical-align',	'middle');
												
											}
										},
										{ 
										//水平置中
											targets : '_all',
											className : 'text-center'
										}
								],

								//屬性區塊,
								lengthMenu : [
										[ 10, 25, 50, -1 ],
										[ "10筆", "25筆", "50筆",
												"全部資料" ] ], //[顯示多少頁面,顯示在table的方式]
								//語言區塊(language),
								language : {
									"lengthMenu" : "顯示 _MENU_ 資料",
									"sZeroRecords" : "無查詢結果",
									"sInfo" : "目前有 _MAX_ 筆資料",
									"sSearch" : "關鍵字搜尋:",
									"sEmptyTable" : "尚有資料紀錄存在",
									"oPaginate" : {
										"sFirst" : "首頁",
										"sPrevious" : "上一頁",
										"sNext" : "下一頁",
										"sLast" : "末頁"
									}
								},
							});
	 
					});

	
	
</script>

<!-- chart.js -->
<script>
var ctx = document.getElementById('storeArea');
var cyz = document.getElementById('storeTag');
var caa = document.getElementById('storeTitle');

var myChart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['台北市', '台中市', '高雄市'],
        datasets: [{
            label: '店家地區數量',
            data: [10, 8, 12],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});


var myChart = new Chart(cyz, {
    type: 'bar',
    data: {
        labels: ['紅茶', '咖啡', '冰沙'],
        datasets: [{
            label: '搜尋次數',
            data: [10, 8, 12],
            backgroundColor: [
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(153, 102, 255, 0.2)'
            ],
            borderColor: [
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(153, 102, 255, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

var myChart = new Chart(caa, {
    type: 'bar',
    data: {
        labels: ['85度C', '春陽茶室', '清新福全'],
        datasets: [{
            label: '搜尋次數',
            data: [50, 20, 30],
            backgroundColor: [
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
</script>

<!-- 下載 -->
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
				      link.download =  "店家資料表.csv";
				      document.body.appendChild(link);
				      link.click();
				      document.body.removeChild(link);
				}
		  
		  });
	  });
  });
</script>

</body>
</html>