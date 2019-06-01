package com.min.controller;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.min.dao.MainDao;
import com.min.vo.MemberVo;
@Controller
public class LoginController {
	@Autowired
	private MainDao dao;
	public void setDao(MainDao dao) {
		this.dao = dao;
	}

	//	회원가입
	@RequestMapping(value="join", method=RequestMethod.GET)
	public void getjoin() {
	}
	@RequestMapping(value="join", method=RequestMethod.POST) 
	public ModelAndView join(MemberVo mbv, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		int m = dao.insertjoin(mbv);
		if (m > 0) {
			mav.addObject("msg", "반가워 영희야 :)");
		}
		else {
			mav.addObject("msg", "영희야 미안하지만 다시 작성해줄래? :)");
		}
		mav.setViewName("login");
		return mav;
	}
	
	//	중복체크
	@RequestMapping(value="checkNick", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String checknick(String member_nickname) {
		String str = "";
		int check = -1;
		check = dao.nickCheck(member_nickname);
		if (check > 0) {
			str = "true";
		}
		else {
			str = "false";
		}
		return str;
	}

	@RequestMapping(value="checkMail", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String checkI(String member_email) {
		String str = "";
		int check = -1;
		check = dao.joinCheck(member_email);
		if (check > 0) {
			str = "true";
		}
		else {
			str = "false";
		}
		return str;
	}

	//	로그인 성공 후 main 페이지로 이동
	@RequestMapping(value="login", method=RequestMethod.GET)
	public void getlogin() {
	}
	@RequestMapping(value="login", method=RequestMethod.POST)
	public ModelAndView login(HttpSession session, HttpServletResponse response, HttpServletRequest request, String member_email, String member_pwd, String member_nickname) {
		ModelAndView mav = new  ModelAndView();
		member_email = request.getParameter("member_email");
		member_pwd = request.getParameter("member_pwd");
	   
		HashMap map = new HashMap();
		map.put("member_email", member_email);
		map.put("member_pwd", member_pwd);
		
		MemberVo mbv = dao.loginMember(map);
		if (mbv != null) {
			session.setAttribute("member_no", mbv.getMember_no());
			mav.addObject("member_no", mbv.getMember_no());
			mav.addObject("member_nickname", mbv.getMember_nickname());
			mav.addObject("list", dao.main());	
			mav.setViewName("main");
		}
		else {
			mav.addObject("member_no", -1);
		}
		return mav;
	}

	//	정보 수정
	@RequestMapping(value="updateMember", method=RequestMethod.GET)
	public ModelAndView update(int member_no) {
		ModelAndView mav = new ModelAndView();
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		mav.addObject("mbv", dao.sessionCheck(map));
		return mav;
	}
	@RequestMapping(value="updateMember", method=RequestMethod.POST)
	public ModelAndView update(MemberVo mbv, HttpServletRequest request, HttpServletResponse response, String member_nickname) {
		ModelAndView mav = new ModelAndView();

		// 닉네임 변경 값을 가져옴
		member_nickname = request.getParameter("member_nickname");
		mav.addObject("member_nickname", member_nickname);
		
		int r = dao.updateMember(mbv);
		if (r > 0) {
			mav.addObject("msg", "정보가 성공적으로 수정되었습니다!");
		}
		else {
			mav.addObject("msg", "정보 수정에 실패하였어요ㅠ3ㅠ");
		}
		
		int member_no = Integer.parseInt(request.getParameter("member_no"));
		// jsp에 뿌려줄 변경된 회원정보 값을 담아서 가져감
		HashMap map = new HashMap();
		map.put("member_no", member_no);
	      
		mav.addObject("mbv", dao.sessionCheck(map));
		mav.setViewName("updateMember");
		return mav;
	}
	
	// 비밀번호 변경
	@RequestMapping(value="pwdCheck", produces="text/plain;charset=UTF-8")          
	@ResponseBody
	public String updatePwd(int member_no, String member_pwd) {
		String str ="";
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		map.put("member_pwd", member_pwd);
	 
		int check = -1;
		check = dao.updatePwd(map);        
	 
		if (check > 0) { 
			str = "true";
		}
		else { 
			str = "false"; 
		} 
		return str;
	}
	
	// 비밀번호 수정
	@RequestMapping(value="updateNewPwd", method=RequestMethod.GET)
	public ModelAndView updatePwd(int member_no) {
		ModelAndView mav = new ModelAndView();
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		mav.addObject("mbv", dao.sessionCheck(map));
		return mav;
	}
	@RequestMapping(value="updateNewPwd", method=RequestMethod.POST)
	public ModelAndView updatePwd(HttpServletRequest request, HttpServletResponse response, String member_nickname, String member_pwd, int memberno) {
		ModelAndView mav = new ModelAndView();
	 
		// 변경할 pwd를 가져옴
		member_pwd = request.getParameter("member_pwd");
		member_nickname = request.getParameter("member_nickname");
	 
		HashMap map = new HashMap();
		map.put("member_nickname", member_nickname);
		map.put("member_pwd", member_pwd);
		mav.addObject("mbv.member_pwd", member_pwd);
	 
		int r = dao.updateNewPwd(map);
		if (r > 0) {
			mav.addObject("msg", "정보가 성공적으로 수정되었습니다!");
		}
		else {
			mav.addObject("msg", "정보 수정에 실패하였어요ㅠ^ㅠ");
		}
		
		int member_no = Integer.parseInt(request.getParameter("memberno"));
		map.put("member_no", member_no);
		mav.addObject("mbv", dao.sessionCheck(map));
		mav.setViewName("updateMember");
		return mav;
	}
	
	@RequestMapping(value="deleteMember", method=RequestMethod.GET)
	public ModelAndView delete(int member_no) {
		ModelAndView mav = new ModelAndView();
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		int r = dao.deleteMember(map);
		mav.setViewName("redirect:/start.jsp");                
		return mav;
	}
    
	// 회원정보 끌어오기
	@RequestMapping(value="session",  produces="text/plain; charset=UTF-8") 
	@ResponseBody
	public String getInfo(int member_no) {
		ObjectMapper mapper = new ObjectMapper();
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		
		MemberVo listInfo = dao.sessionCheck(map);
		String mav = "";
		try {
			mav = mapper.writeValueAsString(listInfo);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return mav;
	}
}
