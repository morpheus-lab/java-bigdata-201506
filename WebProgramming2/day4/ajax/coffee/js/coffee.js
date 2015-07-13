/* coffee.js */

function getSize() {	// 폼에 입력된 사이즈 값을 가져오는 함수
	var sizeGroup = document.forms[0].size;
	for (var i in sizeGroup) {
		if (sizeGroup[i].checked) {
			return sizeGroup[i].value;
		}
	}
}

function getBeverage() {	// 폼에 입력된 음료 값을 가져오는 함수
	var bevGroup = document.forms[0].beverage;
	for (var i in bevGroup) {
		if (bevGroup[i].checked) {
			return bevGroup[i].value;
		}
	}
}

function serveDrink() {	// ajax 요청이 완료되면 응답을 받아서 화면에 표시하는 함수 (ajax 콜백 함수)
	if (request1.readyState == 4) {
		if (request1.status == 200) {
			var resMsg = request1.responseText;
			var name = resMsg.substring(1);	// 인덱스 1 ~ 끝
			alert(name + '님의 커피가 나왔습니다.');
			replaceText(document.getElementById('coffeemaker1-status'), 'Idle');
		} else {
			// 에러 발생
			alert('커피메이커1 사용 중 오류 발생');
		}
		request1 = createRequest();
	}
	if (request2.readyState == 4) {
		if (request2.status == 200) {
			var resMsg = request2.responseText;
			var name = resMsg.substring(1);	// 인덱스 1 ~ 끝
			alert(name + '님의 커피가 나왔습니다.');
			replaceText(document.getElementById('coffeemaker2-status'), 'Idle');
		} else {
			// 에러 발생
			alert('커피메이커2 사용 중 오류 발생');
		}
		request2 = createRequest();
	}
}

function sendRequest(req, url) {	// ajax 요청 보내는 함수
	req.open('GET', url, true);
	req.onreadystatechange = serveDrink;
	req.send(null);
}

function orderCoffee() {	// 버튼의 click 이벤트 리스너
	var name = document.getElementById('name').value;
	var size = getSize();
	var beverage = getBeverage();
	
	var url = 'coffeemaker.jsp?name=' + encodeURIComponent(name)
				+ '&size=' + size
				+ '&beverage=' + beverage
				+ '&coffeemaker=';
	
	// 커피메이커#1의 상태값을 갖고 있는 <div> 엘리먼트
	var divCoffeeMaker1Status = document.getElementById('coffeemaker1-status');
	var status = getText(divCoffeeMaker1Status);
	if (status == 'Idle') {
		// 커피메이커#1이 유휴상태
		sendRequest(request1, url + 1);
		replaceText(divCoffeeMaker1Status, name + '님이 주문하신 ' + size + ' '
													+ beverage + '를 만드는 중...');
	} else {
		var divCoffeeMaker2Status = document.getElementById('coffeemaker2-status');
		status = getText(divCoffeeMaker2Status);
		if (status == 'Idle') {
			// 커피메이커#2가 유휴상태
			sendRequest(request2, url + 2);
			replaceText(divCoffeeMaker2Status, name + '님이 주문하신 ' + size + ' '
														+ beverage + '를 만드는 중...');
		} else {
			// 둘 다 사용중인 상태
			alert('커피메이커가 모두 사용중입니다.\n\n잠시 후 다시 시도하세요.');
		}
	}
	
	document.forms[0].reset();	// 폼 초기화
}




















