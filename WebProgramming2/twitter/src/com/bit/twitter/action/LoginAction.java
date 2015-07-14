package com.bit.twitter.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.twitter.dao.MemberDAO;
import com.bit.twitter.model.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/* "/login.do" 요청 처리용 Action */
public class LoginAction implements ICommandAction {

	@Override
	public String processRequest(HttpServletRequest request,
			HttpServletResponse response) throws Throwable {
		
		// POST request만 필터링
		if (request.getMethod().toUpperCase().equals("POST")) {
			// request parameters
			String loginId = request.getParameter("login_id");
			String loginPw = request.getParameter("login_pw");
			
			// DB 조회
			Member member = MemberDAO.selectMemberInfo(loginId, loginPw);
			
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			
			if (member != null) {	// 로그인 성공
				// 세션에 정보 저장
				request.getSession().setAttribute("memberInfo", member);
				
				PrintWriter writer = response.getWriter();	// 응답 메시지 바디로의 출력 스트림
//				writer.append("{");
//				writer.append("  \"memberSeq\": " + member.getMemberSeq() + ",");
//				writer.append("  \"nickname\": \"" + member.getNickname() + "\",");
//				writer.append("  \"name\": \"" + member.getName() + "\",");
//				writer.append("  \"email\": \"" + member.getEmail() + "\"");
//				writer.append("}");
				Gson gson = new GsonBuilder().create();
				writer.append(gson.toJson(member));
			} else {				// 로그인 실패
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);	// 응답코드: 401
			}
		}
		
		return null;
	}

}
