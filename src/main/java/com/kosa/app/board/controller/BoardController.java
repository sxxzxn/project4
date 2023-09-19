package com.kosa.app.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.app.board.domain.Board;
import com.kosa.app.board.service.BoardService;
import com.kosa.app.notice.domain.Notice;
import com.kosa.app.notice.service.NoticeService;
@Controller
public class BoardController {
	@Autowired
	private BoardService services;
	
	@Autowired
	private NoticeService noticeService;


	
	// 게시판 전체글 조회
	@RequestMapping(value="/board/boardList.do")
	public String boardList(Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("board.controller.boardList()");
		try {
			board.setMoreNum(10);
			request.setAttribute("boardList", services.moreBoardList(board));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/boardList";
	}

	@ResponseBody
	@RequestMapping(value="/board/ajaxList2.do", method=RequestMethod.POST)
	public String ajaxList2(@RequestBody Board board, HttpServletRequest req, HttpServletResponse res) throws Exception {
    	System.out.println("board.controller.ajaxList2() 게시판사항 목록 서블릿 호출됨");
    	JSONObject result = new JSONObject();
		
		try { 
        	List<Board> boardList = services.moreBoardList(board);
        	result.put("status", true);
        	result.put("boardList", boardList);
        } catch (Exception e) { 
        	result.put("status", false);
        	result.put("message", "서버에 오류 발생");
        	e.printStackTrace();
        }
		
		return result.toString();
	}
	
	// 상단 메뉴바 info 이동
	@RequestMapping("/board/info.do")
	public String info(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    System.out.println("info()");

	    try {
	        List<Notice> noticeTop5 = noticeService.noticeTop5();
	        request.setAttribute("notices", noticeTop5);

	        List<Board> boardTop5 = services.boardTop5();
	        request.setAttribute("boards", boardTop5);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return "board/info";
	}
	
	
	// 게시글 등록
	@ResponseBody
	@RequestMapping(value="/board/insertBoard.do", method=RequestMethod.POST)
	public String insertBoard(@RequestBody Board board, HttpServletRequest request) throws Exception {
		System.out.println("insertBoard()");
		System.out.println(board);
		JSONObject jsonResult = services.insertBoard(board); // Use 'services' instance variable to call the method
		return jsonResult.toString();
	}

	// 게시글 조회
	@ResponseBody
	@RequestMapping(value="/board/viewBoard.do")
	public String viewBoard(@RequestBody Board board, HttpServletRequest request) throws Exception {
        
	    JSONObject result = new JSONObject();
	    Board retrievedBoard = services.getBoardById(board.getBoardId());
	   
	    try {
	        services.increaseViewCount(board.getBoardId());

	        if (retrievedBoard != null) {
	        	result.put("status", true);
	        	result.put("board",retrievedBoard);
	        	result.put("boardId",retrievedBoard.getBoardId());
	        	result.put("title",retrievedBoard.getTitle());
	        	result.put("contents",retrievedBoard.getContents());
	        	result.put("writerUid",retrievedBoard.getWriterUid());
	        } else {
	        	
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		return result.toString();
	}
	
	// 게시글 수정 폼
	public String updateBoardForm(Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("updateBoardForm()");
        request.setAttribute("board", board);
		return "board/updateBoardForm.jsp";
	}
	
	// 게시글 수정
	@ResponseBody
	@RequestMapping(value="/board/updateBoard.do")
	public String updateBoard(@RequestBody Board board, HttpServletRequest request) throws Exception {
		System.out.println("board.controller.updateBoard()");
		JSONObject jsonResult = services.updateBoard(board);

		return jsonResult.toString();
	}
	
	//관리자 모드 게시글 삭제
	public String deleteBoards(Board board, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("deleteMember()");
		System.out.println(board);
		JSONObject jsonResult = services.deleteBoards(board.getBoardIds());
		return jsonResult.toString();
	}

	// 유저 글 삭제 
	@ResponseBody
	@RequestMapping(value="/board/deleteBoard.do")
	public String deleteBoard(@RequestBody Board board, HttpServletRequest request)
			throws Exception {
		System.out.println("deleteBoard()");
		JSONObject jsonResult = services.deleteBoard(board);
		
		return jsonResult.toString();
	}
	
	
	

	
}
