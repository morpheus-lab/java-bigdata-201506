package com.bit.mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bit.mvc.dao.MemberDAO;
import com.bit.mvc.model.Member;

public class LoginAction implements ICommandAction {

	@Override
	public String processRequest(HttpServletRequest request,
			HttpServletResponse response) throws Throwable {
		HttpSession session = request.getSession();
		// 로그인 여부 체크
		if (session.getAttribute("memberBean") != null) {
			// 이미 로그인 되어 있으면
			return "/WEB-INF/view/login_ok.jsp";
		}
		else {
			// 로그인 되어 있지 않다면
			if (request.getMethod().equals("GET")) {	// GET 요청이라면
				return "/WEB-INF/view/login_form.jsp";
			}
			else if (request.getMethod().equals("POST")) {	// POST 요청이라면
				String userId = request.getParameter("userId");
				String userPw = request.getParameter("userPw");
				// userId와 userPw가 맞는지 체크
				MemberDAO dao = new MemberDAO();
				Member member = dao.getMemberInfo(userId);
				if (member == null) {
					// 해당 id의 회원정보가 없다면
					request.setAttribute("LOGIN_FAIL_MESSAGE", "회원정보를 찾을 수 없습니다.");
					return "/WEB-INF/view/login_fail.jsp";
				} else if (!member.getPw().equals(userPw)) {
					// 패스워드만 틀린 경우
					request.setAttribute("LOGIN_FAIL_MESSAGE", "비밀번호가 틀렸습니다.");
					return "/WEB-INF/view/login_fail.jsp";
				} else {
					// 로그인 정보가 맞다면 세션에 어트리뷰트 추가
					session.setAttribute("memberBean", member);
					return "/WEB-INF/view/login_ok.jsp";
				}
			}
		}
		return "/WEB-INF/view/error.jsp";	// 위 모든 경우에 해당하지 않는 요청이라면
	}

}
