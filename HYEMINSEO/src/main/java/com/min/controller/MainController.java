package com.min.controller;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.min.dao.MainDao;
import com.min.vo.BadVo;
import com.min.vo.GoodVo;
import com.min.vo.MemberVo;
import com.min.vo.MovieVo;
import com.min.vo.ZzimVo;
@Controller
public class MainController {
	@Autowired
	private MainDao dao;
	public void setDao(MainDao dao) {
		this.dao = dao;
	}
	// main ȣ�� �� �������� �̵�
	@RequestMapping(value="main", method=RequestMethod.GET)
	public ModelAndView main(HttpSession session, int member_no) {
		ModelAndView mav = new  ModelAndView();
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		
		MemberVo mbv = dao.sessionCheck(map);
		if (mbv != null) {
			session.setAttribute("member_no", mbv.getMember_no());
			mav.addObject("member_no", mbv.getMember_no());
			mav.addObject("member_nickname", mbv.getMember_nickname());
			mav.addObject("list", dao.main());			
		}
		return mav;
	}
	// main ������ - �� ��� ajax
	@RequestMapping(value="zzimlist", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String zzimList(int member_no) {
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		ObjectMapper mapper = new ObjectMapper();
		List<MovieVo> list = dao.zzimList(map);
		String str = "";
		try {
			str = mapper.writeValueAsString(list);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	// main ������ - ���ƿ� ��� ajax
	@RequestMapping(value="goodlist", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String goodList(int member_no) {
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		ObjectMapper mapper = new ObjectMapper();
		List<MovieVo> list = dao.goodList(map);
		String str = "";
		try {
			str = mapper.writeValueAsString(list);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	// main ������ - �ڽ����ǽ� ��� ajax
	@RequestMapping(value="boxoffice", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String boxOffice() {
		ObjectMapper mapper = new ObjectMapper();
		List<MovieVo> list = dao.boxOffice();
		String str = "";
		try {
			str = mapper.writeValueAsString(list);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	// list ������
	@RequestMapping(value="list", method=RequestMethod.GET)
	public ModelAndView list(HttpSession session, int member_no) {
		ModelAndView mav = new  ModelAndView();
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		
		MemberVo mbv = dao.sessionCheck(map);
		if (mbv != null) {
			session.setAttribute("member_no", mbv.getMember_no());
			mav.addObject("member_no", mbv.getMember_no());
			mav.addObject("member_nickname", mbv.getMember_nickname());
		}
		return mav;
	}
	// list ������ - ajax
	@RequestMapping(value="listMV", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String list() {
		ObjectMapper mapper = new ObjectMapper();
		List<MovieVo> list = dao.listMV();
		String str = "";
		try {
			str = mapper.writeValueAsString(list);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	// �˻� ������ �̵� - post�� �˻��� ����
	@RequestMapping(value="search", method=RequestMethod.POST)
	public ModelAndView searchMV(HttpSession session, String search) {
		ModelAndView mav = new ModelAndView();
		HashMap map = new HashMap();
		map.put("member_no", session.getAttribute("member_no"));
		
		MemberVo mbv = dao.sessionCheck(map);
		if (mbv != null) {
			session.setAttribute("member_no", mbv.getMember_no());
			mav.addObject("member_no", mbv.getMember_no());
			mav.addObject("member_nickname", mbv.getMember_nickname());
			mav.addObject("search", search);
		}
		return mav;
	}
	// �˻� ������ ������ �˻��� ajax
	@RequestMapping(value="searchlist", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String searchList(String search) {
		HashMap map = new HashMap();
		map.put("search", search);
		ObjectMapper mapper = new ObjectMapper();
		List<MovieVo> list = dao.searchMV(map);
		String str = "";
		try {
			str = mapper.writeValueAsString(list);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	
	// ȸ���� �� ��� ��ȯ
	@RequestMapping(value="checkZ", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String checkZ(int member_no) {
		HashMap map = new HashMap();
		map.put("member_no", member_no);
			
		ObjectMapper mapper = new ObjectMapper();
		List<ZzimVo> list = dao.checkZ(map);
		String str = "";
		try {
			str = mapper.writeValueAsString(list);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	// ���ϱ� ��ư ajax
	@RequestMapping(value="zzim", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String zzim(int member_no, int movie_no) {
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		map.put("movie_no", movie_no);
		
		String str = "";
		int z = dao.zzim(map);
		if (z > 0) {
			str = "success";
		}
		return str;
	}
	// ���ϱ� ��� ��ư ajax
	@RequestMapping(value="nzzim", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String nzzim(int member_no, int movie_no) {
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		map.put("movie_no", movie_no);
		
		String str = "";
		int z = dao.nzzim(map);
		if (z > 0) {
			str = "cancel";
		}
		return str;
	}
	
	// ȸ���� ���ƿ� ��� ��ȯ
	@RequestMapping(value="checkG", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String checkG(int member_no) {
		HashMap map = new HashMap();
		map.put("member_no", member_no);
				
		ObjectMapper mapper = new ObjectMapper();
		List<GoodVo> list = dao.checkG(map);
		String str = "";
		try {
			str = mapper.writeValueAsString(list);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	// ���ƿ� ��ư ajax
	@RequestMapping(value="good", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String good(int member_no, int movie_no) {
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		map.put("movie_no", movie_no);
		
		String str = "";
		int g = dao.good(map);
		if (g > 0) {
			str = "success";
		}
		return str;
	}
	// ���ƿ� ��� ��ư ajax
	@RequestMapping(value="ngood", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String ngood(int member_no, int movie_no) {
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		map.put("movie_no", movie_no);
		
		String str = "";
		int g = dao.ngood(map);
		if (g > 0) {
			str = "cancel";
		}
		return str;
	}
	
	// ȸ���� �Ⱦ�� ��� ��ȯ
	@RequestMapping(value="checkB", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String checkB(int member_no) {
		HashMap map = new HashMap();
		map.put("member_no", member_no);
					
		ObjectMapper mapper = new ObjectMapper();
		List<BadVo> list = dao.checkB(map);
		String str = "";
		try {
			str = mapper.writeValueAsString(list);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	// �Ⱦ�� ��ư ajax
	@RequestMapping(value="bad", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String bad(int member_no, int movie_no) {
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		map.put("movie_no", movie_no);
		
		String str = "";
		int b = dao.bad(map);
		if (b > 0) {
			str = "success";
		}
		return str;
	}
	// �Ⱦ�� ��� ��ư ajax
	@RequestMapping(value="nbad", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String nbad(int member_no, int movie_no) {
		HashMap map = new HashMap();
		map.put("member_no", member_no);
		map.put("movie_no", movie_no);
		
		String str = "";
		int b = dao.nbad(map);
		if (b > 0) {
			str = "cancel";
		}
		return str;
	}
}
