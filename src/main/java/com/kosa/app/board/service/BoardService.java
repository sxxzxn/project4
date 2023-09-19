package com.kosa.app.board.service;

import java.util.List;


import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.app.board.dao.BoardDAO;
import com.kosa.app.board.domain.Board;
import com.kosa.app.member.domain.Member;

@Service
public class BoardService {
	
	@Autowired
	private BoardDAO boardDAO;


	// 1.게시판 목록
	public List<Board> getBoardAllList() throws Exception {
		System.out.println("Board.Service.setBoardDAO() 함수 호출됨");
		return boardDAO.getBoardAllList();
	}

	// 2. 게시판 상세보기
	public Board getBoardById(int boardId) throws Exception {
		System.out.println("Board.Service.getBoardById() 함수 호출됨");
		increaseViewCount(boardId);
		return boardDAO.getBoardById(boardId);
	}

	// 3. 게시판 글 등록
	public JSONObject insertBoard(Board board) throws Exception {
		JSONObject jsonResult = new JSONObject();
		if (boardDAO.insertBoard(board) == 1) {
			jsonResult.put("status", true);
			jsonResult.put("message", "게시글이 등록되었습니다.");
		} else {
			jsonResult.put("status", false);
			jsonResult.put("message", "게시글이 등록되지 않았습니다.");
		}
		return jsonResult;
	}


	// 4. 게시글 수정
	public JSONObject updateBoard(Board board) throws Exception {
		JSONObject jsonResult = new JSONObject();

		if (boardDAO.updateBoard(board) == 1) {
			jsonResult.put("status", true);
			jsonResult.put("message", "수정완료");
		} else {
			jsonResult.put("status", false);
			jsonResult.put("message", "수정실패");
		}

		return jsonResult;
	}

	// 5. 게시글 삭제
	public JSONObject deleteBoard(Board board) throws Exception {
		JSONObject jsonResult = new JSONObject();

		if (boardDAO.deleteBoard(board) == 1) {
			jsonResult.put("status", true);
			jsonResult.put("message", "게시글이 삭제되었습니다.");
		} else {
			jsonResult.put("status", false);
			jsonResult.put("message", "게시글 삭제에 실패했습니다.");
		}

		return jsonResult;
	
	}

	// 6. 조회수 증가
	public int increaseViewCount(int boardId) throws Exception {
		return boardDAO.increaseViewCount(boardId);
	}

	/// 7. top5출력
	public List<Board> boardTop5() throws Exception {
		return boardDAO.boardTop5();
	}

	// 8. 더보기
	public List<Board> moreBoardList(Board board) throws Exception {
		System.out.println("Board.Service.moreBoardList() 함수 호출됨");
		return boardDAO.moreBoardList(board);
	}
	
	// 관리자모드삭제
	public  JSONObject deleteBoards(String[] deleteBoards) throws Exception {
		JSONObject jsonResult = new JSONObject();
		
		if (boardDAO.deleteBoards(deleteBoards) > 0) {
			jsonResult.put("status", true);
			jsonResult.put("message", "선택한 게시글 삭제 완료했습니다.");
		} else {
			jsonResult.put("status", false);
			jsonResult.put("message", "선택한 게시글 삭제 실패했습니다.");
		}
		
		return jsonResult;
		
	}
}
