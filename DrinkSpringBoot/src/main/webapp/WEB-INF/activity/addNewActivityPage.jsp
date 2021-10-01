<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList" import="tw.drink.activity.model.StoreProductBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>addNewActivity</title>
    
	<!-- jQuery-UI CSS 樣式(配合 jQuery UI)-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!-- Bootstrap-ICON CSS 樣式 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
	
	<style>
		*{ 
			padding: 0;
			margin: 0;
		}
		.containerArea{
            padding: 0;
			margin: 0;
            width: 100%;
		}
		.containerArea .header{
			padding:220px 0;
			font-size:58px;
			line-height: 60px;
			text-align: center;
		}
		
		.containerArea .formBox{
			background-color: rgba(255,255,255,0.8);
			max-width: 98%;
			margin: 10px auto;
			border-radius: 10px;
		}
		.containerArea form{
			display: block;
			padding: 0 0 50px;
		}
		.containerArea .inputItem{
			font-size: 23px;
			line-height: 30px;
			padding: 25px 8% 0 8%;
		}
		.containerArea .inputItem label{
			display: block;
			height: 25px;
			margin-bottom: 10px;
		}



		.containerArea .activityTopic{
			width:100%;
            display: inline-block;
            font-size: 20px;
		}
		 .containerArea .activityTimeYMD{
			width:200px;
            display: inline-block;
            font-size: 20px;
		} 
		.containerArea .selectBox{
            width:50px;
            display: inline-block;
			font-size: 20px;
			margin-right: 10px;
		}
		.containerArea .textareaBox{
            width:100%;
			height:200px;
            display: inline-block;
            font-size: 20px;
			vertical-align: top;
			resize:none; /* 不能調整尺寸 */
			padding: 5px 0 5px 5px;
			border-radius: 5px;
		} 
        .containerArea .fileBox{
            width:100%;
            display: inline-block;
            font-size: 20px;
        }

        /*優惠品項*/
        .containerArea .ProductItem{
            font-size: 23px;
			line-height: 30px;
			padding: 25px 8% 0 8%;
        }
        .containerArea .ProductItem label{
			display: block;
			height: 25px;
            margin-bottom: 10px;
		}
        .containerArea .productSelector{
            margin-bottom: 20px;
        }
        .containerArea .selectProduct{
            width: 100%;
            display: inline-block;
            font-size: 20px;
        }
        .containerArea .productSelector .productSelectorBox-one{
            display: inline-block;
            width: 40%;
        }
        .containerArea .productSelector .productSelectorBox-two{
            display: inline-block;
            width: 40%;
            margin-left: 10px;
        }
        .containerArea .productSelector .productSelectorBox-three{
            display: inline-block;
            width: 10%;
            margin-left: 10px;
            vertical-align: middle;
        }
        .containerArea .productSelector .productSelectorBox-three button{
            width: auto; /* 防止衝突 */
            font-size: 20px;
            position: relative;
            top:-1px; /* 按鈕位置微調 */
        }
		.containerArea .productBoxList .productBox .productBoxKey{
			display: inline-block;
			width:40%;
		}
		.containerArea .productBoxList .productBox .productBoxValue{
			display: inline-block;
			width:20%;
		}
		.containerArea .productBoxList .productBox .productDiscountPrice{
			display: inline-block;
		}

        .containerArea .sendOutItem{
			font-size: 23px;
			line-height: 30px;
			padding: 70px 8% 0 8%;
            text-align: center;
		}
		.containerArea .sendOutItem .sendOutButton{
			width:auto; /* 防止衝突 */
		}
		
		/* 一鍵輸入 */
		.keyinByOne{
			padding: 20px 8% 0 8% ;
			text-align: right;
		}
		.keyinByOne .keyinBtn{
			display: inline-block;
		}
	</style>
	
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteHead.jsp" %>
	
</head>
<body>

	<%
		ArrayList<StoreProductBean> allProduct = (ArrayList<StoreProductBean>)request.getAttribute("productInformation");
		// 目前處理 產品ID、產品名稱、產品價格，尚不處理 店家ID
	%>

	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody1.jsp" %>
	
	<div class="containerArea">
		<div class="header" style="width:98%; height:500px ;margin:10px auto 0px auto;background:rgba(205,205,205,0.5) ; border-radius: 4px 4px 10px 10px;">
			新增限時特價活動
		</div>
		
		<div class="formBox">
			<div class="keyinByOne">
	            <button type="button" class="btn btn-warning keyinBtn" id="keyinBtn">一鍵輸入</button>
	        </div>
			<form action="<%=request.getContextPath()%>/getAddNewActivity.controller" modelAttribute="ActivityBean" method="post" enctype="multipart/form-data">
				<div class="inputItem">
					<label for="activityTopicId">標題:</label>
	                <input class="form-control activityTopic" id="activityTopicId" name="activityTopic" type="text" placeholder="輸入優惠標題"  aria-label="default input example">			
	            </div>
				<div class="inputItem">
					<label for="">優惠時段:</label>
	                <input class="form-control activityTimeYMD" id="startTimeYMD" name="startTimeYMD" type="text" placeholder="選擇日期" aria-label="default input example">
					<select class="form-control selectBox" id="startTimeH" name="startTimeH">
						<option value="00">00</option>
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
					</select>時
					到
					<input class="form-control activityTimeYMD" id="endTimeYMD" name="endTimeYMD" type="text" placeholder="選擇日期">
					<select class="form-control selectBox" id="endTimeH" name="endTimeH">
						<option value="00">00</option>
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
					</select>時
				</div>
				<div class="inputItem">
					<label for="activityContentId">優惠描述:</label>
					<textarea class="form-control textareaBox" id="activityContentId" name="activityContent" placeholder="請輸入內容"></textarea>
				</div>
				<div class="inputItem">
					<label for="activityTopicId">優惠圖片:</label>
					<input class="form-control fileBox" id="formFile" name="imgFile" type="file">
				</div>
				<div class="ProductItem">
					<label for="">優惠品項 (最多五項最少一項) :</label>
	                <hr>
	                <div class="productSelector">
	                    <div class="productSelectorBox-one">
	                        <label for="">選擇優惠品項:</label>
	                        <select class="form-control selectProduct" id="selectProductItem" name="selectProductItem">
	                            
	                            <%
									// 產生選項: value:產品ID、text內容:產品名稱
	                            	for(StoreProductBean item : allProduct) {
								%>		
								
									<option value="<%= item.getProid() %>"><%= item.getProname() %>( <%= item.getProprice() %> 元 )</option>
								
								<%		
									}
	                            %>
	                            
	                        </select>
	                    </div>
	                    <div class="productSelectorBox-two">
	                        <label for="">選擇優惠類型:</label>
	                        <select class="form-control selectProduct" id="selectDiscountValue" name="selectDiscountValue">
	                            <option value="95">95折</option>
	                            <option value="90">9折</option>
	                            <option value="80">8折</option>
	                            <option value="70">7折</option>
	                            <option value="60">6折</option>
	                            <option value="50">半價</option>
	                        </select>
	                    </div>
	                    <div class="productSelectorBox-three">
	                        <button class="btn btn-outline-primary" id="addProductBox" type="button"><i class="bi bi-plus"></i></button>
	                    </div>
	                </div>
	
	                <!-- 產生的的品項 -->
	                <div class="productBoxList" id="productBoxList">
	                    
	                </div>
	
					<!-- 品項的模型 -->
					<div class="alert alert-primary alert-dismissible fade show productBox" role="alert" style="display: none;">
						<span class="productBoxKey"></span><span class="productBoxValue"></span><span class="productDiscountPrice"></span>
						<input class="productBoxInputKey" type="hidden" value="" >
						<input class="productBoxInputValue" type="hidden" value="" >
						<input class="productBoxInputProductName" type="hidden" value="" >
						<input class="productBoxInputProductPrice" type="hidden" value="" >
						<button id="ee" type="button" class="btn-close deleteProductBtn" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
					<!-- 店家資訊 -->
					<input name="pstoreid" type="hidden" value="<%= allProduct.get(0).getPstoreid() %>" >
				</div>
	            <div class="sendOutItem">
	                <button type="submit" class="btn btn-primary btn-lg sendOutButton" >建立限時優惠</button>
	            </div>
	            
			</form>
			
		</div>
		
	</div>
	
	<%@ include file="/WEB-INF/websiteForm/homeWebsiteBody2.jsp" %>
	
	<!-- jQuery CDN -->
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	
	<!-- jQuery-UI CDN -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30=" crossorigin="anonymous"></script>
	
	<!-- Bootstrap CDN Javascript body2標籤已有-->
	
    <script>
		$(function(){

			// o 日期 UI 初始設定
			$( "#startTimeYMD" ).datepicker();
			$( "#endTimeYMD" ).datepicker();

			$( "#startTimeYMD" ).on('blur',function(){
				console.log(">>>"+$( "#startTimeYMD" ).val())
			});
			
			// o 一鍵輸入
			$("#keyinBtn").click(function(){
				console.log("Hiii")
				$("#activityTopicId").val("防疫在家喝飲料");
				$("#activityContentId").val("疫情期間，最好的防疫方式就是乖乖宅在家喝飲料。即日起兩個月，只要在本店消費，所有飲品一律半價，鼓勵大家待在家，並享用最高品質的茶飲。");
			});
			
			
			// o 增加優惠品項
			let productArray=[] // 品項資料 
			//[
			//	{ id:品項1ID , discount:折扣項目1 }, 
			//	{ id:品項2ID , discount:折扣項目2 }...
			// ]
			$("#addProductBox").click(function(){

				// 取得品項ID & 折扣項目
				// 顯示在畫面的 data
				let productBoxKeyText = $("#selectProductItem").find("option:selected").text();
				let productBoxValueText = $("#selectDiscountValue").find("option:selected").text();
				let productDiscountValue = $("#selectDiscountValue").find("option:selected").val(); // 折扣的參數(用來計算折扣後結果)
				// id, discount 準備存入 品項資料
				let productBoxKey = $("#selectProductItem").val();
				let productBoxValue = $("#selectDiscountValue").val();

				// 最多五項品項
				if( productArray.length<5 ){	// 五個項目以內

					// 防止同品項新增兩次
					let repeat = false; // false: 沒重複，true: 重複了
					for(let i = 0 ; i<productArray.length ;i++){ // 注意: 第一次加入不會觸發內容
	
						if( productBoxKey == productArray[i]["id"] ){ // 重複了! 不能加入
							repeat = true;
							break;
						}
	
					}
	
					if( repeat ){ // 重複了! 不能加入
	
						alert("已有相同產品，不能重複加入");

					}else if( !repeat ){ // 未重複! 可以加入
	
						console.log("未重複! 可以加入");
	
						// 存入 品項ID & 折扣項目 到 品項資料
						productObj = {
							id: 0,
							discount:""
						};
						productObj["id"] = productBoxKey;
						productObj["discount"] = productBoxValue;
						productArray.push(productObj);
						
		
						//***顯示 品項資料
						console.log(productObj);
						console.log(productArray);
		
						// 畫面建立優惠品項Box
						let productBoxObject = $(".ProductItem>.productBox").clone();
						productBoxObject.css("display","block");
						productBoxObject.find(".productBoxKey").text(productBoxKeyText); 		// 畫面 產品中文名稱
						productBoxObject.find(".productBoxValue").text(productBoxValueText);	// 畫面 折扣程度(中文)
						productBoxObject.find(".productDiscountPrice").text("折扣後價格: "+ Math.floor( ( productBoxKeyText.replace(/[^0-9]/ig,"") )*parseInt(productDiscountValue)/100 ) +" 元")// 畫面 產品折扣後價格(向下取整)  
						
						productBoxObject.find(".productBoxInputKey").val(productBoxKey);		// input 設定 產品id
						productBoxObject.find(".productBoxInputKey").attr("name","productBoxKey");
						productBoxObject.find(".productBoxInputValue").val(productBoxValue);	// input 設定 折扣程度
						productBoxObject.find(".productBoxInputValue").attr("name","productBoxValue");
						
						productBoxObject.find(".productBoxInputProductName").val(productBoxKeyText);	// input 設定 產品中文名稱
						productBoxObject.find(".productBoxInputProductName").attr("name","productBoxProductName");
						
						productBoxObject.find(".productBoxInputProductPrice").val( productBoxKeyText.replace(/[^0-9]/ig,"") );	// input 設定 產品原價
						productBoxObject.find(".productBoxInputProductPrice").attr("name","productBoxProductPrice");
						
						$("#productBoxList").append(productBoxObject);
					}

				}else{	// 超過五個項目

					alert("已超過五個項目，不能再增加了");
					
				}

			});


			// o 刪去優惠品項
			$(".productBoxList").on("click",".deleteProductBtn",function(){ // 後來產生的元素，使用on動態繫結事件
				
				// 取得 ID & 折扣項目
				let productBoxKey = $(this).siblings(".productBoxInputKey").val();
				let productBoxValue = $(this).siblings(".productBoxInputValue").val();

				// 從 品項資料 刪除該筆 ID & 折扣項目
				for(let i = 0 ; i<productArray.length ;i++){

					if( productBoxKey == productArray[i]["id"] ){ 

						// 刪除該筆資料
						productArray.splice(i,1);
						//***顯示 品項資料
						console.log(productBoxKey+"被刪掉了!")
						console.log(productArray);
					}

				}

			})




		})
	</script>
</body>
</html>