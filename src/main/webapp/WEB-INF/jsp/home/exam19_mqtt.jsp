<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		
		<script>
			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61614,
						new Date().getTime.toString());
				
				client.onMessageArrived = onMessageArrived;	//메시지가 도착했을 때 자동으로 실행시킨다 (콜백함수)
				client.connect({onSuccess:onConnect});
			});
			
			function onConnect() {
				console.log("mqtt broker connected");
				client.subscribe("/camerapub");				//연결이 되고나서 구독하겠다. (topic)
			}
			
			function onMessageArrived(message){
				console.log(message.payloadString);
				if(message.destinationName=="/camerapub"){
					var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64, "+ message.payloadString)
				}
			}
		</script>
	</head>
	<body>
		<h5 class="alert alert-info">/exam19_mqtt.jsp</h5>
		
		<img id="cameraView"/>
	</body>
</html>