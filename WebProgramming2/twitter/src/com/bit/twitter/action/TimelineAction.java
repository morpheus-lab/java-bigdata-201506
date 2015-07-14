package com.bit.twitter.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.twitter.dao.TwitDAO;
import com.bit.twitter.model.Twit;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/*
 * "/timeline.do" 요청 처리
 */
public class TimelineAction implements ICommandAction {

	@Override
	public String processRequest(HttpServletRequest request,
			HttpServletResponse response) throws Throwable {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		Gson gson = new GsonBuilder().create();
		
		PrintWriter writer = response.getWriter();
		
		// "member_seq" 파라미터 유무 체크
		String memberSeq = request.getParameter("member_seq");
		if (memberSeq == null || memberSeq.trim().equals("")) {
			// 전체 타임라인 조회
			List<Twit> timeline = TwitDAO.selectTwit();
			writer.append(gson.toJson(timeline));
		} else {
			// 사용자별 타임라인 조회
		}
		return null;
	}
	
}









