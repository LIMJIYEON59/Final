<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>message</title>
</head>
<body>
<script>
var alertMsg = '${msg}'; 
if(alertMsg){  
	alert(alertMsg);
}
</script>
</body>
</html>