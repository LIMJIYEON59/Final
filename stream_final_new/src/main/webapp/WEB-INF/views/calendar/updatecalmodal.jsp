<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 모달 -->
<div id="updatecalmodal" class="modal">
	<div class="modal-dialog pcal">
		<!-- Modal content -->
		<div class="pcal modal-container">
			<div class="modal-header-pcal"></div>
			<div class="modal-body-pcal">
				<div class="card pcal">
					<div class="card-body pcal">
					<div class="card-header pcalTitle">
						<h2 class="pcalTitle"><b>일정 수정</b></h2>
					</div>
						<form action="${pageContext.request.contextPath}/member/updatepcal" method="post" id="frm-updatecal">
							<!-- 일정번호 프로젝트번호  url 때문에 pno필요함 -->
							<%--<input type="hidden" name="pno" value="${pno}"> --%>
							<!-- TODO 일정번호 -->
							<input type="hidden" id="sno" name="sno">
							
							<!-- 제목 -->
							<input type="text" class="form-control title" id="title" name="title" id="form-content" placeholder="제목을 입력하세요." required="required">
						
							<!-- 날짜 -->
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar align-middle"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
							<input type="date" class="form-date" id="start" name="start" required="required"> ~ <input type="date" class="form-date" id="end" name="end" required="required"> <!-- s -->
							
							<!-- 작성자&참석자 -->
							 <div class="wrap-selected">
								 <div class="selected-leftPart">
									 <div class="d-flex align-items-center">
										 <!-- 작성자 -->
										 <input class="form-control userid" type="hidden" name="userid" value="${principal.username }" readonly>
										 <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user align-middle me-2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r= "4"></circle></svg>
									
										 <!-- 참가자 -->
										 <select class="form-select  mb-3 calmemberlist" id="updatecalmemberlist" >
										 	 <option value="">참가자 추가</option>
										 </select>
									 </div>
									 <!-- 장소 이름 -->
									 <div class="d-flex align-items-center">
									 	 <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map-pin align-middle me-2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
										 <div class="form-control updateplace" id="splace"></div>
								     </div>	
								 </div>
							     <!-- 참가자 반복 -->
							     <div id="updatedAttendees" class="selected-rightPart card updatecalendar">
										 <!-- 
											 <div class="attenduserid-item">
												 <input type="text" placeholder="참가자" readonly>
												 <input type="hidden"  name="attenduseridArr">
											 </div>
										  -->	
									 </div>
								 </div>
								 <!-- 지도  -->
	     						 <div class="map" id="map-updatemodal"></div>
						
								<!-- 내용  -->
								<div id="form-content">
									<textarea class="form-control smemo" id="summernote-updatecalmodal" rows="5" name="smemo"></textarea>
							    </div>
						    
							<!-- 등록 취소 버튼 -->
							<div align="center">
								<button  type="button" id="updBtn" class="btn btn-primary" >수정</button>
								<button  type="reset"  class="btn btn-warning">취소</button>
							</div>
						</form>
					</div>
				</div>  <!-- end of card -->
			</div>
		</div>
	</div>
</div>

<!-- 일정 상세 정보 가져오기 -->
<script>
	$('#update-calButton').on("click", function() {
		var selectedUpdateSno= $("#readcalmodal #sno").val(); //sno읽어옴
		var selectedUpdateTitle = $("#readcalmodal #title").text();
		var selectedUpdateStart = $("#readcalmodal #start").text();
		var selectedUpdateEnd = $("#readcalmodal #end").text();
		var selectedUpdateUserid = $("#readcalmodal #userid").text();
		var selectedUpdateUseridList = $("#readcalmodal .attenduserid-item").text(); //참가자
		var selectedUpdateSplace = $("#readcalmodal #splace").text();
		var selectedUpdateSmemo = $("#readcalmodal #smemo").html(); //<p>태그 다 가져와야함 html사용!
		
		$("#updatecalmodal input[name= 'sno']").val(selectedUpdateSno);
		$("#updatecalmodal input[name='title']").val(selectedUpdateTitle);
		$("#updatecalmodal input[name='start']").val(selectedUpdateStart);
		$("#updatecalmodal input[name='end']").val(selectedUpdateEnd);
		
		console.log("selectedUpdateUseridList" +selectedUpdateUseridList);
		$('#updatecalmodal .updateattenduserid-item').text(selectedUpdateUseridList); //참가자
		$("#summernote-updatecalmodal").summernote("code" ,selectedUpdateSmemo); //썸머노트
		$('#updatecalmodal #userid').text(selectedUpdateUserid);
		$('#updatecalmodal #splace').text(selectedUpdateSplace);
		 updateshowMap(); 
	});
</script>

<!-- 참가자들을 input에 추가한다. -->
<script>
	document.getElementById("updatecalmemberlist").addEventListener("change", function() {
		if(this.selectedIndex == 0){
			return;
		}
	    var selectedText = this.options[this.selectedText].text;
	    var selectedValue = this.options[this.selectedValue].value;
	    //document.getElementById("calmemberinput").value = selectedValue; // 하나가 아니기때문에 id = "calmemberinput" 안됨
		var updateCheckUserId = false;
	    $(".updateattenduserid-item").each(function(idx, updateItem){
	    	updateValue = $(thisItem).children("[name=updateAttenduseridArr]").val();
	    	console.log(updateValue);
	    	if(selectedValue == updateValue){
	    		alert("이미 참석자에 등록된 사원입니다.");
	    		updateCheckUserId = true;
	    		return false;
	    	}
	    });
	    if(updateCheckUserId == false){  //등록된 적 없는 사원일 경우 추가
		    var htmlVal='';
		    htmlVal+='<div class="updateattenduserid-item">';
		    htmlVal+='<input type="text" class="form-control-updateUserid" placeholder="참가자" readonly value="'+selectedText+'">';
		    htmlVal+='<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-delete align-middle me-2"><path d="M21 4H8l-7 8 7 8h13a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2z"></path><line x1="18" y1="9" x2="12" y2="15"></line><line x1="12" y1="9" x2="18" y2="15"></line></svg>';
		    htmlVal+='<input type="hidden" name="updateAttenduseridArr" value="'+selectedValue+'" >';
		    htmlVal+='</div>';
		    
		    //attenduserid-wrap
		    $("#updatedAttendees").append(htmlVal);
		    
		 	 //참가자 svg 누르면 삭제됨TODO
		    /* $(".feather.feather-delete.align-middle.me-2").click(function() {
		 		console.log("add삭제");
		 		$(this).closest(".attenduserid-item").remove();
		 	}); */
	    }
	});
</script>

<!-- 참가자 list select option //updatedAttendees -->
<script>
	function updateMemberProjectListHandler(thisElement){
		console.log("calendar_pno: "+calendar_pno);
		console.log("logined_userid: "+logined_userid);
		$.ajax({
			url:'${pageContext.request.contextPath}/member/memberProjectList',
			type:"post",
			data : {
				pno : calendar_pno,
				userid : logined_userid//전달이 되나?
			},
			dataType: "json", //json으로 형식의 응답을 제공하냐
			success:updateMemberView,
			error:updateMemberError
		});
	}
	function updateMemberView(updateData){
		console.log(updateData)
		console.log("성공하였습니다.")
		var updateListHtml = '<option value="">참가자 추가</option>';
		for (var i=0; i<updateData.length; i++){
			var mname = updateData[i];
			updateListHtml += `<option value="\${mname.userid}">\${mname.mname}</option>`; //data를 뿌리고 그걸 option에다가 넣어줌 //value=userid
		}
		$("#updatecalmemberlist").html(updateListHtml);
	}
	function updateMemberError(request, status, error){
		console.log("오류발생!!!!!!!!!!!");
		console.log(request);
		console.log(status);
		console.log(error);
		
		var updateListHtml = '<option value="">참가자 추가</option>';
		updateListHtml += `<option selected>해당하는 이름이 없습니다.</option>`;
		$("#updatecalmemberlist").html(updateListHtml);
	}
</script>

<script>
	$('#updatecalmodal #updBtn').on("click", function(){
		console.log($("#frm-updatecal").serialize());
		
		//ajax 요청을 보낸다.
		$.ajax({
			url: "${pageContext.request.contextPath}/member/updatepcal", //수정 엔드포인트이다
			type: 'POST',
			data: $("#frm-updatecal").serialize(),			
			success: function(response){
				console.log(response);
				//수정이 성공하면 실행될 코드
				if(response === 1) {
					//수정이 성공했을 때
					alert('일정이 수정되었습니다.');
					$('#updatecalmodal').modal('hide');// 모달창 닫기
				}else{
					alert('일정 수정에 실패했습니다.')
					console.log("updatepcal22에서 오류 발생");
				}
			},
			error : function(request, status, error){
				console.log(request);
				console.log(status);
				console.log(error);
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
		});
	})
</script>

<!-- 지도 api -->
<script>
	var mapContainer_updatemodal = document.getElementById('map-updatemodal'), // 지도를 표시할 div 
	mapOption_updatemodal = {
		center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level : 3, // 지도의 확대 레벨
		disableDoubleClickZoom: true
	};

	//showMap 함수 정의
	function updateshowMap() {
		
		var splaceTextupdate = $('#updatecalmodal #splace').text().trim();
		if(!splaceTextupdate){
			mapContainer_updatemodal.innerHTML ='';
			mapContainer_updatemodal.style.display ='none';
			return;
		}
		
		// 지도를 생성합니다    
		var map3 = new kakao.maps.Map(mapContainer_updatemodal, mapOption_updatemodal);
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder3 = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		console.log(splaceTextupdate); //서울 강남
		geocoder3.addressSearch(splaceTextupdate , function(result, status) {
			
			var splaceTextupdate = $('#updatecalmodal #splace').text();
			
			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {
				var updatecoords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
				// 결과값으로 받은 위치를 마커로 표시합니다
				var marker3 = new kakao.maps.Marker({
					map : map3,
					position : updatecoords 
				});
		
				// 인포윈도우로 장소에 대한 설명을 표시합니다
				var infowindow = new kakao.maps.InfoWindow({
					content : '<div style="width:150px;text-align:center;padding:6px 0;">장소</div>'
				});
				infowindow.open(map3, marker3);
		
			   
				// 이 코드 넣었더니 지도 뜸!!
			    setTimeout(function(){ map3.relayout(); }, 1000);
				
				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map3.setCenter(updatecoords);
			 
				// 지도를 표시
			    mapContainer_updatemodal.style.display = 'block';
			  
				// 마우스 드래그로 지도 이동 막기
				map3.setDraggable(false);
				// 마우스 휠로 지도 확대,축소 막기
				map3.setZoomable(false);
				
			} // if
		});  // cb function
	}
</script>


