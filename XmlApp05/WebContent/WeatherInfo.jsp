<%@page import="com.test.WeatherDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.test.WeatherDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	// 사용자가 선택한 지역 데이터 수신
	String stnId = request.getParameter("stnId");

	if(stnId==null)
	{
		stnId = "108";		// 전국 날씨 정보
	}
	
	StringBuilder sb = new StringBuilder();
	WeatherDAO dao = new WeatherDAO(stnId);
	
	// 타이틀
	String title = dao.weatherTitle();
	
	// 육상 중기 예보
	String weatherInfo = dao.weatherInfo();
	
	// 도시 정보 및 날짜 시간별 날씨 정보
	ArrayList<String> cityList = dao.weatherCityList();
	for(int a=0; a<cityList.size(); a++)
	{
		sb.append(String.format("<h3>%s</h3>", cityList.get(a)));
		
		ArrayList<WeatherDTO> weatherList = dao.weatherList(String.valueOf(a+1));
		
		// 테이블 동적 생성
		sb.append("<table class='table'>");
		sb.append("<tr>");
		sb.append("<th>날짜</th>");
		sb.append("<th>날씨</th>");
		sb.append("<th>최저/최고 기온</th>");
		sb.append("<th>강수확률</th>");
		sb.append("</tr>");
		
		for(WeatherDTO w : weatherList)
		{
			sb.append("<tr>");
			sb.append(String.format("<td>%s</td>", w.getTmEf()));
			sb.append(String.format("<td><img src='images/%s'> %s</td>"
										, w.getImg(), w.getWf()));
			sb.append(String.format("<td>%s℃ / %s℃</td>"
										, w.getTmn(), w.getTmx()));
			sb.append(String.format("<td>%s%%</td>", w.getRnSt()));
			sb.append("</tr>");
		}
		
		sb.append("</table>");
		
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기상청 육상 중기 예보(Weather.jsp)</title>
<link rel="stylesheet" type="text/css" href="css/main.css">

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(document).ready(function()
	{
		//alert("호출 확인");
		
		// 선택한 라디오 상태를 선택된 상태(checked)로 표시(유지)할 수 있도록 처리
		//$(":radio:eq(0)").attr("checked", "checked");
		//                   :
		//$(":radio:eq(2)").attr("checked", "checked");
		//                   :
		//$(":radio:eq(9)").attr("checked", "checked");
		
		//$(":radio[value='108']").attr("checked", "checked");
		//                   :
		//$(":radio[value='133']").attr("checked", "checked");
		//                   :
		//$(":radio[value='184']").attr("checked", "checked");
		
		$(":radio[value='<%=stnId%>']").attr("checked", "checked");
		
	});

</script>

</head>
<body>

<!-- 
108	전국     
109	서울,경기  
105	강원     
131	충북     
133	충남     
146	전북     
156	전남     
143	경북     
159	경남     
184	제주특별자치도
-->


<div class="container">

	<h2>
		기상 정보 <small>Bootstrap</small>
	</h2>

	<div class="panel-group" role="group">
	
		<div class="panel panel-default" role="group">
		
			<div class="panel-heading">지역 선택</div>
			<div class="panel-body">
				<!-- action 속성 생략 → 수신처는 자기 자신 -->
				<form method="get" role="form">
					<input type="radio" name="stnId" value="108" checked="checked"> 전국
					<input type="radio" name="stnId" value="109"> 서울, 경기
					<input type="radio" name="stnId" value="105"> 강원         
					<input type="radio" name="stnId" value="131"> 충북         
					<input type="radio" name="stnId" value="133"> 충남         
					<input type="radio" name="stnId" value="146"> 전북         
					<input type="radio" name="stnId" value="156"> 전남         
					<input type="radio" name="stnId" value="143"> 경북         
					<input type="radio" name="stnId" value="159"> 경남         
					<input type="radio" name="stnId" value="184"> 제주특별자치도    
					
					<button type="submit" class="btn btn-default">Submit</button>
				</form>
			</div><!-- close .panel-body -->
			
		</div><!-- close .panel .panel-default -->
		
		
		<div class="panel panel-default" role="group">
		
			<div class="panel-heading">기상 정보 출력</div>
			<div class="panel-body">
				<p>
					<!-- <b>서울,경기도 육상 중기예보 - 2021년 12월 27일 (월)요일 06:00 발표</b> -->
					<b><%=title %></b>
				</p>
				<p>
					<!-- 
					○ (강수) 1월 2일(일) 오전에는 눈이 내리겠습니다.<br />
					○ (기온) 아침 기온은 -14~-2도, 낮 기온은 -5~4도로 어제(26일, 아침최저기온 -19~-13도, 낮최고기온 -8~-5도)보다 높겠습니다.<br />
					 특히, 12월 31일(금)~1월 1일(토)은 평년(아침 기온 -11~-4)보다 4~5도 가량 낮고 바람도 강하게 불어 매우 춥겠습니다.<br />
					○ (해상) 서해중부해상의 물결은 30일(목) 오후~31일(금) 오전은 1.0~3.0m로 높게 일겠고, 바람이 매우 강하게 불겠습니다. 그 밖의 날은 1.0~2.5m로 일겠습니다.<br />
					○ (주말전망) 1월 1일(토)은 구름많겠고, 2일은 오전에 구름많고 눈이 내리다가 오후에는 맑아지겠습니다. 아침최저기온은 -14~-8도, 낮최고기온은 -1~3도의 분포를 보이겠습니다.
					-->
					<%=weatherInfo %>
				</p>
				
				<!-- 
				<h3>서울</h3>
				<table class="table">
					<thead>
					<tr>
						<th>날짜</th>
						<th>날씨</th>
						<th>최저/최고 기온</th>
						<th>강수확률</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td>2021-12-30 00:00</td>
						<td>맑음</td>
						<td>-7 ~ -2</td>						
						<td>0</td>
					</tr>
					<tr>
						<td>2021-12-30 01:00</td>
						<td>맑음</td>
						<td>-7 ~ -2</td>						
						<td>0</td>
					</tr>
					<tr>
						<td>2021-12-30 02:00</td>
						<td>맑음</td>
						<td>-7 ~ -2</td>						
						<td>0</td>
					</tr>
					</tbody>
				</table>
				
				<h3>인천</h3>
				<table class="table">
					<thead>
					<tr>
						<th>날짜</th>
						<th>날씨</th>
						<th>최저/최고 기온</th>
						<th>강수확률</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td>2021-12-30 00:00</td>
						<td>맑음</td>
						<td>-7 ~ -2</td>						
						<td>0</td>
					</tr>
					<tr>
						<td>2021-12-30 01:00</td>
						<td>맑음</td>
						<td>-7 ~ -2</td>						
						<td>0</td>
					</tr>
					<tr>
						<td>2021-12-30 02:00</td>
						<td>맑음</td>
						<td>-7 ~ -2</td>						
						<td>0</td>
					</tr>
					</tbody>
				</table>
				-->
				
				<%=sb.toString() %>
				
			</div><!-- close .panel-body -->
		
		
		
		</div><!-- close .panel .panel-default -->
	
	</div><!-- close .panel-group -->
	
</div><!-- close .container -->






<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
</body>
</html>