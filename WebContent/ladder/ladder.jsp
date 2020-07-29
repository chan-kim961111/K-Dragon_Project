<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>

<%
   String userID = null;
if (session.getAttribute("userID") != null) {
   userID = (String) session.getAttribute("userID");
}
%>
<html>

<head>
<title></title>
<meta charset=utf-8>
<meta name=description content="">
<link rel="stylesheet" type="text/css" href="./ladder_file/style.css">
<link rel="stylesheet" type="text/css" href=" ./ladder_file/meterial.css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<link rel="stylesheet" href="<c:url value='/resources/common/css/common.css'/>" >
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- ����Ʈ -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- ��Ÿ�Ͻ�Ʈ ����  -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script src="./ladder_file/jquery-2.1.3.min.js"></script>
<style>
#chet_form{
border-style: solid;
width: 280px;
position: fixed;
left: 100%;
top: 20%;
margin-left: -300px;
}

</style>
</head>
<body>
   <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="../search/main.jsp" _msthash="238680" _msttexthash="28185131">����Ž��</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample05" aria-controls="navbarsExample05" aria-expanded="false" aria-label="Toggle navigation" _msthidden="A" _msthiddenattr="204581" _mstaria-label="320099">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarsExample05">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active" width =20%>
        <a class="nav-link" href="../search/main.jsp"><font _mstmutation="1" _msthash="699582" _msttexthash="4991896">main </font><span class="sr-only" _msthash="1019902" _msttexthash="11687494">(����)</span></a>
      </li>
      <li class="nav-item" width =20%>
        <a class="nav-link" href="../board/view.jsp" _msthash="699998" _msttexthash="9876347">board</a>
      </li>
      <li class="nav-item" width =20%>
        <a class="nav-link" href="../ladder/ladder.jsp" _msthash="699998" _msttexthash="9876347">game</a>
      </li>
	</div>
	 <% 
    	if (userID==null){
    %>
			<ul class="navbar-nav mr-auto">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" style="color: white">�����ϱ�</a>
					<ul class="dropdown-menu">
						<li><a href="../login/login.jsp">�α���</a></li>
						<li><a href="../login/join.jsp">ȸ������</a></li>

					</ul></li>
			</ul>

			<%
				} else {
			%>
			
			<ul class="navbar-nav mr-auto">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" style="color: white">ȸ������</a>
					<ul class="dropdown-menu">
						<li><a href="../login/logoutAction.jsp">�α׾ƿ�</a></li>
						<li><a href="../login/checkPwForm.jsp">��������</a></li>
					</ul></li>
			</ul>

			<%
				}
			%>
</nav>
   <!-- �ִϸ��̼� ��� JQUERY -->
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <!-- ��Ʈ��Ʈ�� JS  -->
   <script src="../js/bootstrap.js"></script>
   
   <div class="landing" id="landing">
      <div class="start-form">
         <div class="landing-form">
            <div class="group">
               <input type="text" name="member" required> <span
                  class="highlight"></span> <span class="bar"></span> <label>������
                  ��</label>
               <div id="button" class="button raised green">
                  <div class="center" fit>START</div>
                  <paper-ripple fit></paper-ripple>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div id="ladder" class="ladder">
      <div class="dim"></div>
      <canvas class="ladder_canvas" id="ladder_canvas"></canvas>
   </div>
   <script src="./ladder_file/ladder.js"></script>
  <%if(userID!=null){ %>
 	<div id="chet_form">
	<!-- �ܼ� �޽����� ������ �ϴ� �α� �ؽ�Ʈ ������.(���� �޽����� ǥ���Ѵ�.) -->
	<textarea id="messageTextArea" rows="10" cols="35"></textarea>
		<br />

		<!-- ���� ���� �Է��ϴ� �ؽ�Ʈ �ڽ�(�⺻ ���� anonymous(�͸�)) -->

		<!-- �۽� �޽����� �ۼ��ϴ� �ؽ�Ʈ �ڽ� -->
		<input id="textMessage" type="text" onkeydown="enterkey()">
		<!-- �޼����� �۽��ϴ� ��ư -->
		<input onclick="sendMessage()" value="����" type="button">
		<!-- WebSocket ���� �����ϴ� ��ư -->

		<p id="chetmember_num"></p>

	
	</div>
	<script type="text/javascript">
		// �ܼ� �ؽ�Ʈ ������ ������Ʈ
		var messageTextArea = document.getElementById("messageTextArea");
		var chetmember_num = document.getElementById("chetmember_num");
		// �� ���� ���� �Լ�, url ���� �Ķ���ʹ� callback �Լ��� �޴´�.
		function connectWebSocket(url, message, open, close, error) {
			// WebSocket ������Ʈ ���� (�ڵ����� ���� �����Ѵ�. - onopen �Լ� ȣ��)
			let webSocket = new WebSocket(url);
			// �Լ� üũ�ϴ� �Լ�
			function call(cb, msg) {
				// cb�� �Լ� Ÿ������ Ȯ��
				if (cb !== undefined && typeof cb === "function") {
					// �Լ� ȣ��
					cb.call(null, msg);
				}
			}
			// WebSocket ������ ������ �Ǹ� ȣ��Ǵ� �Լ�
			webSocket.onopen = function() {
				// callback ȣ��
				call(open);
			};
			// WebSocket ������ ������ ����� ȣ��Ǵ� �Լ�
			webSocket.onclose = function() {
				// callback ȣ��
				call(close);
			};
			// WebSocket ������ ��� �߿� ������ �߻��ϸ� ��û�Ǵ� �Լ�
			webSocket.onerror = function() {
				// callback ȣ��
				call(error);
			};
			// WebSocket ������ ���� �޽����� ���� ȣ��Ǵ� �Լ�
			webSocket.onmessage = function(msg) {
				// callback ȣ��
				call(message, msg);
			};
			// �� ���� ����
			return webSocket;
		}
		// ���� �߻� �� ����� callback �Լ�
		var open = function() {
			// �ܼ� �ؽ�Ʈ�� �޽����� ����Ѵ�
			messageTextArea.value += "ä�� ���� �Ϸ�...\n";
		}
		// ���� �߻� �� ����� callback �Լ�
		var close = function() {
			// �ܼ� �ؽ�Ʈ�� �޽����� ����Ѵ�
			messageTextArea.value += "ä�� ���� �Ұ�...\n";
			// �� ������ �õ��Ѵ�.
			setTimeout(function() {
				// ������
				webSocket = connectWebSocket(
						"ws://192.168.0.21:8088/FamousRest/broadsocket",
						message, open, close, error);
			});
		}
		// ���� �߻� �� ����� callback �Լ�
		var error = function() {
			messageTextArea.value += "error...\n";
		}
		// �޼����� ���� �� ����� callback �Լ�
		var message = function(msg) {
			// �ܼ� �ؽ�Ʈ�� �޽����� ����Ѵ�.
			var msgdata_split = msg.data.split("||");
			messageTextArea.value += msgdata_split[0] + "\n";
			chetmember_num.innerText = "���� ���� �� ���� " + msgdata_split[1] + 
										"�� �Դϴ�";
			
			scrolldown();

		};
		// �� ���� ����, ������ ���� ������ IP �ּҿ� ��Ĺ ���� ��Ʈ �־���� �մϴ�.
		var webSocket = connectWebSocket(
				"ws://192.168.0.21:8088/FamousRest/broadsocket", message,
				open, close, error);
		// Send ��ư�� ������ ȣ��Ǵ� �Լ�
		function sendMessage() {
			// ������ �ؽ�Ʈ �ڽ� ������Ʈ�� ���
			//var user = document.getElementById("user");
			// �۽� �޽����� �ۼ��ϴ� �ؽ�Ʈ �ڽ� ������Ʈ�� ���
			var message = document.getElementById("textMessage");
			// �ܼ� �ؽ�Ʈ�� �޽����� ����Ѵ�.
			messageTextArea.value += "<%=session.getAttribute("userID")%>" + "(�����) => " + message.value
					+ "\n";
			// WebSocket ������ �޽����� ����(���� ��{{������}}�޽�����)
			webSocket.send("{{" + "<%=session.getAttribute("userID")%>" + "}}" + message.value);
			// �۽� �޽����� �ۼ��� �ؽ�Ʈ �ڽ��� �ʱ�ȭ�Ѵ�.
			message.value = "";
			scrolldown();
		}
		
		function enterkey() {
	           if (event.keyCode == 13) {
	              sendMessage();
	           }
	       }
		
		// Disconnect ��ư�� ������ ȣ��Ǵ� �Լ�
		function disconnect() {
			// WebSocket ���� ����
			webSocket.close();
		}
		
		function scrolldown(){
	           var elem = document.getElementById('messageTextArea');
	           elem.scrollTop = elem.scrollHeight;
	       }
	</script>
	<%} %>
</body>
</html>