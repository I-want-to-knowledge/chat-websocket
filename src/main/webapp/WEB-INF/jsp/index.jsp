<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Java后端WebSocket的Tomcat实现</title>
</head>
<body>
	<div style="width:600px">
		<div style="top:100px;left:470px;"><!-- position:absolute; -->
			<div id="div_msgzone" class="panel panel-default">
				<div class="panel-heading">消息窗口</div>
				<div id="message" class="panel-body"
					style="width: 580px; height: 650px;overflow:hidden;">
					
					
					<!-- <div style="margin-bottom: 10px; position: relative; left: 0px;">
						<div style="color: green">你 19:48:45</div>
						等待服务器握手包...
					</div> -->
					
					
				</div>
			</div>
		</div>
        
        
        <!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
		<!-- <div style="max-width:500px;max-height:300px;resize: none;width:500px;height:300px;">
			<label id="message"></label>
		</div> -->

		Welcome <br /> 
		<div style="width:550px;height:100px;overflow: hidden;">
			<textarea id="text" style="width:450px;height:99px;max-width:450px;max-height:99px;overflow: hidden;" cols="30" rows="20">
			${name}
			</textarea><button onclick="send()" style="max-width:49px;max-height:99px;width:49px;height:99px;">发送消息</button>
		</div>
		<div style="height:10px"></div>
		<hr />
		<!--userno:发送消息人的编号-->
		登录者：<input id="userno" type="text" value="123" /><br /> 
		接收者：<input id="recipient" type="text" value="123" /><br />
		<button onclick="onopen()">链接</button>
		<button onclick="closeWebSocket()">关闭WebSocket连接</button>
		<hr />

	</div>
</body>

<script type="text/javascript">
    var websocket = null;
    var userno = null;
    
    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        
    }
    else {
        alert('当前浏览器 Not support websocket')
    }

    function onopen() {
    	userno=document.getElementById('userno').value;
    	websocket = new WebSocket("ws://${ip}:${port}/websocket/"+userno);
	
	    //连接发生错误的回调方法
	    websocket.onerror = function () {
	        setMessageInnerHTML("WebSocket连接发生错误");
	    };
	
	    //连接关闭的回调方法
	    websocket.onclose = function () {
	        setMessageInnerHTML("WebSocket连接关闭");
    	}
	    
	    //连接成功建立的回调方法
	    websocket.onopen = function () {
	        setMessageInnerHTML("WebSocket连接成功");
	    }
	
	    //接收到消息的回调方法
	    websocket.onmessage = function (event) {
	        setMessageInnerHTML(event.data);
	    }
    }

    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function () {
        closeWebSocket();
    }

    //将消息显示在网页上
    function setMessageInnerHTML(sendMessage) {
        document.getElementById('message').innerHTML += sendMessage + '<br/>';
    }

    //关闭WebSocket连接
    function closeWebSocket() {
        websocket.close();
    }

    //发送消息
    function send() {
        var message = document.getElementById('text').value;//要发送的消息内容
        var ToSendUserno=document.getElementById('recipient').value;//接收人编号：4567
        // var now=getNowFormatDate();//获取当前时间
        // document.getElementById('message').innerHTML += (now+"发送人："+userno+'<br/>'+"---"+message) + '<br/>';
        // document.getElementById('message').style.color="red";
        // message="{'msg':'" + message + "','recipient':'"+ToSendUserno + "'}";//将要发送的信息和内容拼起来，以便于服务端知道消息要发给谁
        message= message + "|"+ToSendUserno;//将要发送的信息和内容拼起来，以便于服务端知道消息要发给谁
        websocket.send(message);
        
        /* websocket.onmessage = function(event) {
        	var msg = event.data;
        	if (msg != '当前用户不在线') {
		        var now=getNowFormatDate();//获取当前时间
		        document.getElementById('message').innerHTML += (now+"发送人："+userno+'<br/>'+"---"+message) + '<br/>';
		        document.getElementById('message').style.color="red";
        	} else {
	        	alert(msg);
        	}
        } */
    }
    //获取当前时间
    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var seperator2 = ":";
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
                + " " + date.getHours() + seperator2 + date.getMinutes()
                + seperator2 + date.getSeconds();
        return currentdate;
} 
</script>
</html>