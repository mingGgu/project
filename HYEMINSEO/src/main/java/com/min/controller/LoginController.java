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

	//	ȸ������
	@RequestMapping(value="join", method=RequestMethod.GET)
	public void getjoin() {
	}
	@RequestMapping(value="join", method=RequestMethod.POST) 
	public ModelAndView join(MemberVo mbv, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		int m = dao.insertjoin(mbv);
		if (m > 0) {
			mav.addObject("msg", "�ݰ��� ����� :)");
		}
		else {
			mav.addObject("msg", "����� �̾������� �ٽ� �ۼ����ٷ�? :)");
		}
		mav.setViewName("login");
		return mav;
	}
	
	//	�ߺ�üũ
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

	//	�α��� ���� �� main �������� �̵�
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

	//	���� ����
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

		// �г��� ���� ���� ������
		member_nickname = request.getParameter("member_nickname");
		mav.addObject("member_nickname", member_nickname);
		
		int r = dao.updateMember(mbv);
		if (r > 0) {
			mav.addObject("msg", "������ ���������� �����Ǿ����ϴ�!");
		}
		else {
			mav.addObject("msg", "���� ������ �����Ͽ�����3��");
		}
		
		int member_no = Integer.parseInt(request.getParameter("member_no"));
		// jsp�� �ѷ��� ����� ȸ������ ���� ��Ƽ� ������
		HashMap map = new HashMap();
		map.put("member_no", member_no);
	      
		mav.addObject("mbv", dao.sessionCheck(map));
		mav.setViewName("updateMember");
		return mav;
	}
	
	// ��й�ȣ ����
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
	
	// ��й�ȣ ����
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
	 
		// ������ pwd�� ������
		member_pwd = request.getParameter("member_pwd");
		member_nickname = request.getParameter("member_nickname");
	 
		HashMap map = new HashMap();
		map.put("member_nickname", member_nickname);
		map.put("member_pwd", member_pwd);
		mav.addObject("mbv.member_pwd", member_pwd);
	 
		int r = dao.updateNewPwd(map);
		if (r > 0) {
			mav.addObject("msg", "������ ���������� �����Ǿ����ϴ�!");
		}
		else {
			mav.addObject("msg", "���� ������ �����Ͽ�����^��");
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
    
	// ȸ������ �������
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
