package com.kosa.app.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.app.member.domain.Member;
import com.kosa.app.member.service.MemberService;

@Controller
public class MemberController {
	// request response관련 업무
	
	@Autowired
	private MemberService memberService;

//	public String memberList(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		System.out.println("memberList()");
//
//		try {
//			request.setAttribute("memberList", memberService.getMemberAllList());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return "member/memberList.jsp";
//
//	}

	@ResponseBody
	@RequestMapping(value="/member/insert.do", method=RequestMethod.POST)
	public String insert(@RequestBody Member member, HttpServletRequest request) throws Exception {
		JSONObject jsonResult = memberService.insert(member);
		return jsonResult.toString();
	}

	
	@ResponseBody
	@RequestMapping(value="/member/existUid.do", method=RequestMethod.POST, produces = "application/json; charset=utf8")
	public String existUid(@RequestBody Member member, HttpServletRequest request) throws Exception {
		System.out.println(member);
		JSONObject jsonResult = new JSONObject();
		if (memberService.existUid(member)) {
			jsonResult.put("status", true);
			jsonResult.put("message", "아이디가 사용 불가능 합니다");
		} else {
			jsonResult.put("status", false);
			jsonResult.put("message", "아이디가 사용가능합니다");
		}

		return jsonResult.toString();
	}

	//rest API
	@ResponseBody
	@RequestMapping(value="/member/login.do", method=RequestMethod.POST)
	public Map<String, Object> login(@RequestBody Member member, HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();	
		HttpSession session = request.getSession();
		
		Member loginMember = memberService.login(member);

		if (loginMember != null) {
			session.setAttribute("loginMember", loginMember);
			resultMap.put("status" , true);
			resultMap.put("message" , loginMember.getName() + "님 로그인 되었습니다.");
		} 
		else{
			resultMap.put("status" , false);
			resultMap.put("message" , "아이디와 비밀번호를 확인해주세요");
		}
		
		return resultMap; 
	}

	@ResponseBody
	@RequestMapping(value="/member/logout.do", produces = "application/json; charset=utf8")
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("logout()");

		HttpSession session = request.getSession();
		session.invalidate();

		JSONObject jsonResult = new JSONObject();
		jsonResult.put("status", true);
		jsonResult.put("message", "로그아웃 되었습니다");
		
		return jsonResult.toString();
	}


	@ResponseBody
	@RequestMapping(value="/member/findUid.do", method=RequestMethod.POST, produces = "application/json; charset=utf8")
	public String findUid(@RequestBody Member member, HttpServletRequest request) throws Exception {
		String name = request.getParameter("findUid_uname"); // "name"은 HTML 폼에서 사용한 이름
		String age = request.getParameter("findUid_age"); // "age"는 HTML 폼에서 사용한 이름

		System.out.println("findUid()");
		System.out.println(member);
		JSONObject jsonResult = memberService.findUid(member);
		return jsonResult.toString();
	}

	
	@ResponseBody
	@RequestMapping(value="/member/findFwd.do", method=RequestMethod.POST)
	public String findPwd(@RequestBody Member member, HttpServletRequest request) throws Exception {
		String uid = request.getParameter("findFwd_uid");
		String name = request.getParameter("findFwd_uname"); // "name"은 HTML 폼에서 사용한 이름
		String age = request.getParameter("findFwd_age"); // "age"는 HTML 폼에서 사용한 이름

		JSONObject jsonResult = memberService.findPwd(member);
		return jsonResult.toString();
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/member/checkFwd.do")
	public String checkPwd(@RequestBody Map<String, String> paramMap, HttpSession session, HttpServletRequest request) throws Exception {
	    System.out.println("controller()");
	    
	    
	    session = request.getSession();
	    Member loginMember = (Member)session.getAttribute("loginMember");
	    
	    String pwd = paramMap.get("pwd"); 
	    JSONObject jsonResult = new JSONObject();
	    Member member = new Member();
	    member.setUid(loginMember.getUid());
	    member.setPwd(pwd);
	    
	    System.out.println(memberService.checkPwd(member, session));
	    if (!memberService.checkPwd(member, session)) {
	        jsonResult.put("status", true);
	        jsonResult.put("message", "비밀번호가 일치하지 않습니다.");
	    } else {
	        jsonResult.put("status", false);
	        jsonResult.put("message", "비밀번호가 일치합니다.");
	    }

	    return jsonResult.toString();
	}


	@ResponseBody
	@RequestMapping(value="/member/updateMember.do", method=RequestMethod.POST)
	public String updateMember(@RequestBody Member member, HttpServletRequest request)
			throws Exception {
		System.out.println("updateMember()");
		JSONObject jsonResult = memberService.updateMember(member);
		HttpSession session = request.getSession();
		session.setAttribute("loginMember", member);
		return jsonResult.toString();
	}
	//회원탈퇴
	@RequestMapping(value="/member/deleteMember.do", method=RequestMethod.GET)
	public String deleteMember(Member member, HttpServletRequest request)
			throws Exception {
		System.out.println("deleteMembers() : " + member);
		JSONObject jsonResult = memberService.deleteMember(member);
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/main.do";
	}
//
//	public String deleteMembers(Member member, HttpServletRequest request, HttpServletResponse response)
//			throws Exception {
//		System.out.println("deleteMember()");
//		System.out.println(member);
//		JSONObject jsonResult = memberService.deleteMembers(member.getUids());
//		return jsonResult.toString();
//	}
	
}
