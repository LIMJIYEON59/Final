<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 모달 -->
<div id="addcalmodal" class="modal">
	<div class="modal-dialog pcal">
		<!-- Modal content -->
		<div class="pcal modal-container ">
			<div class="modal-header-pcal"></div>
			<div class="modal-body-pcal">
				<div class="card pcal">
					<div class="card-body pcal">
					<div class="card-header pcalTitle">
						<h2 class="pcalTitle"><b>일정 작성</b></h2>
					</div>
						<form class="addcalmodal-frm" action="${pageContext.request.contextPath}/member/insertpcal" method="post">
							<!-- url 때문에 pno필요함 -->
							<input type="hidden" name="pno" value="${pno}">
							<!-- TODO 일정번호 -->
							<input type="hidden" name="sno" value="${sno}">
							<!-- 제목 -->
							<input type="text" class="form-control title" name="title" id="form-content title" placeholder="제목을 입력하세요.">
							
							<!-- 날짜 -->
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar align-middle me-2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
							<input type="date" class="form-date" id="start" name="start" required="required"> ~ <input type="date" class="form-date" id="end" name="end" required="required"> <!-- s -->
							
							 <!-- 작성자&참석자 -->
							 <div class="d-flex align-items-center" id="form-content">
								<div class="userid-img">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user align-middle me-2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r= "4"></circle></svg>
								</div>
								<!-- 작성자 -->
									<input class="form-control userid" type="text" name="userid" value="${principal.username }" readonly>
								<div class="form-userid" id="form-content" >
									<!-- 참가자 임시로 넣음 -->
									<!-- <input type="text" name="attenduseridArr" value="mplsam@kh.co.kr">
									<input type="text" name="attenduseridArr" value="kh0001@kh.com">
									<input type="text" name="attenduseridArr" value="kh0002@kh.com">  -->
									<!-- 참가자 반복 -->
									<div id="attenduserid-wrap">
									<!-- 
										<div class="attenduserid-item">
											<input type="text" placeholder="참가자" readonly>
											<input type="hidden"  name="attenduseridArr">
										</div>
									 -->	
									</div>
									<select class="calmemberlist" id="calmemberlist" > <!-- 일단 한 명만 추가해서 insert까지 하기  --> 
										<option value="">참가자 추가</option>
									</select>
								</div>
							</div>
							
							<!-- 지도 -->
							<div>
								<div class="d-flex align-items-center">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map-pin align-middle me-2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
									<input type= "text" class= "form-control place" id="splace" name="splace" placeholder= "장소를 입력하세요." onkeydown="searchOnEnter(event)">
								</div>
							</div>
							<div  class="map-hidden" id="form-content">
								<%@ include file="/WEB-INF/views/kakaomap.jsp"%>
							</div>
								
							<!-- 내용  -->
							<div id="form-content">
								<textarea class="smemo" id="summernote-addcalmodal" rows="5" name="smemo"></textarea>
						    </div>
						    
						    <!-- 등록 취소 버튼 -->
							<div align="center">
								<button type="submit" class="btn btn-primary" >등록</button>
								<button  type="reset"  class="btn btn-warning" onclick="resetcalmodal()">취소</button>
							</div>
						</form>
					</div>
				</div>  <!-- end of card -->
			</div>
		</div>
	</div>
</div>

<script>

//지도 초기화!!!

	function resetcalmodal(){
		var kakaoaddmap = document.getElementById('map');
		kakaoaddmap.innerHTML =''; //지도를 비운다.
		$('.map-hidden').css("display", 'none'); //지도 맵
		$('#addcalmodal #splace').val(''); //지도 이름
		
		$('#addcalmodal .title').val(''); //제목
		$('#addcalmodal #start').val(''); //시작일
		$('#addcalmodal #end').val(''); //종료일
		
		
	}
</script>
