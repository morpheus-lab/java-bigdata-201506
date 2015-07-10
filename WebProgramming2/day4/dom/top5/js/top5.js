
function addOnClickHandlers() {
	// 문서내에 있는 모든 <img>를 찾아서
	var imgTags = document.getElementsByTagName('img');
	// 클릭 이벤트 핸들러 설정
	for (var i in imgTags) {
		imgTags[i].onclick = addToTop5;
	}
}

function addToTop5() {	// 각 이미지의 클릭 이벤트 핸들러
	var numCDs = document.getElementById('top5')
				.getElementsByTagName('img').length;	// 현재 '#top5'에 들어있는 CD 개수
	if (numCDs < 5) {
		var moveTo = document.getElementById('top5');
		
		// <span> 태그 생성
		var elSpan = document.createElement('span');	// <span />
		// class="rank"
		elSpan.setAttribute('class', 'rank');	// <span class="rank" />
		// 텍스트 노드 추가
		//elSpan.innerHTML = numCDs + 1;	// <span class="rank">1</span>
		elSpan.appendChild(document.createTextNode(numCDs + 1));
		
		moveTo.appendChild(elSpan);	// '#top5'에 <span> 태그 추가
		moveTo.appendChild(this);	// '#top5'로 옮기기
		
		this.onclick = null;	// 더 이상 클릭 이벤트가 처리되지 않도록
	} else {
		// 이미 가득참 경고
		alert('이미 TOP 5를 모두 선택하셨습니다.');
	}
}

function startOver() {	// 초기화 버튼
	var cdsDiv = document.getElementById('cds');
	var top5Div = document.getElementById('top5');
	var top5Child = top5Div.firstChild;
	
	while (top5Child) {
		// 옮기거나 삭제할 노드
		var nodeToModify = top5Child;
		
		// 다음 노드
		top5Child = top5Child.nextSibling;

		// 제거
		// nodeToModify가 img? span?
		if (nodeToModify.nodeName.toLowerCase() == 'img') {
			nodeToModify.onclick = addToTop5;	// 클릭 이벤트 핸들러 다시 달기
			// cdsDiv로 옮기기
			cdsDiv.appendChild(nodeToModify);
			console.log('<img> moved');
		} else if (nodeToModify.nodeName.toLowerCase() == 'span') {
			// 삭제
			top5Div.removeChild(nodeToModify);
			console.log('<span> removed');
		}
	}
	
//	addOnClickHandlers();
}























