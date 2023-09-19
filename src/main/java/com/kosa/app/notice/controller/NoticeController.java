package com.kosa.app.notice.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.app.board.domain.Board;
import com.kosa.app.notice.domain.Notice;
import com.kosa.app.notice.service.NoticeService;
@Controller
public class NoticeController  {
	@Autowired
	private NoticeService services;
	
	@RequestMapping("/notice/noticeList.do")
	public String noticeList(Notice notice, HttpServletRequest req, HttpServletResponse res) throws Exception {
    	System.out.println("notice.controller.NoticeList() 공지사항 전체 목록 서블릿 호출됨");
		
		try { 
        	req.setAttribute("result", services.getNoticePageList(notice));
        } catch (Exception e) { 
        	e.printStackTrace();
        }
		
		return "notice/noticeList";
		
	}
	@ResponseBody
	@RequestMapping(value="/notice/viewNotice.do")
	public String detailView(@RequestBody Notice notice, HttpServletRequest req) throws Exception {
	   
		JSONObject result = new JSONObject();
	    Notice retrievedNotice = services.getNoticeById(notice.getNoticeId());
	   
	    try {
	        services.increaseViewCount(notice.getNoticeId());

	        if (retrievedNotice != null) {
	        	result.put("status", true);
	        	result.put("board",retrievedNotice);
	        	result.put("title",retrievedNotice.getTitle());
	        	result.put("contents",retrievedNotice.getContents());
	        	result.put("writerUid",retrievedNotice.getWriterUid());
	        } else {
	        	
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		return result.toString();
	}
	
	public String insertNoticeForm(HttpServletRequest req, HttpServletResponse res) throws Exception {
    	System.out.println("notice.controller.insertNoticeForm() ");
		return "notice/insertNoticeForm.jsp";
		
	}
	
	public String insert(Notice notice, HttpServletRequest req, HttpServletResponse res) throws Exception {
    	System.out.println("notice.controller.insert() ");
    	JSONObject jsonResult = new JSONObject();
    	boolean status = services.insertNotice(notice);
    	
    	jsonResult.put("status", status);
    	jsonResult.put("message", status ? "공지사항 글 작성이 등록되었습니다" : "공지사항 글 작성시 오류가 발생하였습니다");
		
		return jsonResult.toString();
	}
	
//	public String deleteNotice(Notice notice, HttpServletRequest req, HttpServletResponse res) throws Exception {
//    	System.out.println("notice.controller.delete() ");
//    	JSONObject jsonResult = new JSONObject();
//    	boolean status = services.deleteNotice(notice.getNoticeId());
//    	
//    	jsonResult.put("status", status);
//    	jsonResult.put("message", status ? "공지사항 글이 삭제되었습니다" : "공지사항 글 삭제시 오류가 발생하였습니다");
//		
//		return jsonResult.toString();
//	}
	
//	public String updateNoticeForm(Notice notice, HttpServletRequest req, HttpServletResponse res) throws Exception {
//    	System.out.println("notice.controller.updateForm() ");
//    	
//		try { 
//        	req.setAttribute("notice", services.getNotice(notice.getNoticeid()));
//        } catch (Exception e) { 
//        	e.printStackTrace();
//        }
//
//		return "notice/updateNoticeForm.jsp";
//	}
//	
//	public String update(Notice notice, HttpServletRequest req, HttpServletResponse res) throws Exception {
//    	System.out.println("notice.controller.update() ");
//    	JSONObject jsonResult = new JSONObject();
//    	boolean status = services.updateNotice(notice);
//    	
//    	jsonResult.put("status", status);
//    	jsonResult.put("message", status ? "공지사항 글 수정이 되었습니다" : "공지사항 글 수정시 오류가 발생하였습니다");
//		
//		return jsonResult.toString();
//	}
//	
	
}
