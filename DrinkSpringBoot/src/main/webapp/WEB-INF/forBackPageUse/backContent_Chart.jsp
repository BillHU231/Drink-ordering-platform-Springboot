<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chart.js</title>
</head>
<body>
<div style="width:850px;margin:0 auto;">
<div style="height:520px;width:400px;text-align:center;float:left;margin-top:40px">
<h3>店家地區分布</h3>
<canvas id="storeArea"></canvas></div>

<div style="height:260px;width:400px;text-align:center;float:right;margin:20px;">
<h3>熱門產品排行</h3>
<canvas id="storeTag"></canvas>
</div>
<div style="height:260px;width:400px;text-align:center;float:right;margin:20px;">
<h3>熱門店家排行</h3>
<canvas id="storeTitle"></canvas>
</div>
</div>


	<!-- 匯入圖表 -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
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


</body>
</html>