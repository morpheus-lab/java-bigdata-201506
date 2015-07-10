
function addOnClickHandlers() {
	
	// id="cds" div를 찾기
	var cdsDiv = document.getElementById("cds");
	// cdsDiv의 자식 element 중 이름이 img인 것들의 리스트
	var cdImages = cdsDiv.getElementsByTagName("img");
	
	for (var i = 0; i < cdImages.length; i++) {
		cdImages[i].onclick = addToTop5;
	}
	
}

// <div id="cds">내의 <img>의 클릭 이벤트 리스너
function addToTop5() {
	var targetToMove = this;
	var destination = document.getElementById("top5");
	
	var numCDs = 0;
	for (var i = 0; i < destination.childNodes.length; i++) {
		if (destination.childNodes.item(i).nodeName.toLowerCase() == "img") {
			numCDs ++;
		}
	}
	
	if (numCDs < 5) {
		// rank 번호 붙이기
		var spanElement = document.createElement("span");
		// <span></span>
		spanElement.setAttribute("class", "rank");
		// <span class="rank"></span>
		var spanTextNode = document.createTextNode(numCDs + 1);
		// 1
		spanElement.appendChild(spanTextNode);
		// <span class="rank">1</span>
		
		// spanElement를 destination에 child로 추가
		destination.appendChild(spanElement);
		
		// top5의 자식 노드로 추가
		destination.appendChild(targetToMove);
		targetToMove.onclick = null;	// 다시 top5로 추가되는 것을 막기위함
	} else {
		alert("You've already chosen 5 CDs.");
	}
}

// "Start Over" 버튼의 클릭 이벤트 리스너
function startOver() {
	var cdsDiv = document.getElementById("cds");
	var top5Div = document.getElementById("top5");
	var top5Child = top5Div.firstChild;
	
	while (top5Child) {
		var elementToModify = top5Child;
		top5Child = top5Child.nextSibling;
		if (elementToModify.nodeName.toLowerCase() == "img") {
			cdsDiv.appendChild(elementToModify);
//			console.log("<img> moved!");
		} else {
			top5Div.removeChild(elementToModify);
//			console.log("<span> removed!");
		}
		
//		console.log("next top5Child is " + top5Child);
	}
	
	addOnClickHandlers();
}













