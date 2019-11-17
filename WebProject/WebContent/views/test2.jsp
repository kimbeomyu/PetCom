<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.1/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.1/js/bootstrap.min.js"></script>
<link
	href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"
	rel="stylesheet">

<link href="summernote.css" rel="stylesheet">
<script src="summernote.min.js"></script>

<script src="lang/summernote-ko-KR.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>

	$(document).ready(function() {
		$('#myEditor').summernote({
			lang : 'ko-KR',
			height : "400px",
			onImageUpload : function(files, editor, $editable) {
				console.log(files[0]);
				console.log(editor);
				sendFile(files[0],editor,$editable);
			}
		});
		
		function sendFile(file, editor, welEditable) {
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data : data,
				type : "POST",
				url : "/imageUpload",
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) {
					console.log(data);
					editor.insertImage(welEditable, data);
				}
			});
		}
	}
		
	
</script>


</body>
</html>