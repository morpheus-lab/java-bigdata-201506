package com.bit.twitter.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.twitter.dao.TwitDAO;
import com.bit.twitter.model.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class WriteAction implements ICommandAction {

	@Override
	public String processRequest(HttpServletRequest request,
			HttpServletResponse response) throws Throwable {
		
		request.setCharacterEncoding("UTF-8");
		
		// POST만 처리하도록 필터링
		if(request.getMethod().toUpperCase().equals("POST")) {
			// 로그인 상태 체크
			Member member = (Member) request.getSession().getAttribute("memberInfo");
			if (member != null) {
				// request 파라미터 "content"
				String content = request.getParameter("content");
				
				if (content == null || content.trim().equals("")) {
					// BAD REQUEST
					response.setStatus(HttpServletResponse.SC_BAD_REQUEST);	// 400
				} else {
					// DB에 INSERT
					boolean result = TwitDAO.insertTwit(member.getMemberSeq(), content) > 0;
					
					Gson gson = new GsonBuilder().create();
					
					response.setContentType("application/json");
					response.getWriter().append(gson.toJson(result));
				}
			} else {
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);	// 401
			}
		}
		
		return null;
	}

}
