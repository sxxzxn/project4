package com.kosa.app.board.dao;

import java.util.List;

import com.kosa.app.board.domain.Board;

public interface BoardDAO {
	
	// 1.게시판 목록
	List<Board> getBoardAllList() throws Exception; // 전체 게시글 목록 조회

	// 2. 게시판 상세보기
	Board getBoardById(int boardId) throws Exception; // 특정 게시글 조회

	// 3. 게시판 글 등록
	int insertBoard(Board board) throws Exception; // 게시글 등록

	// 4. 게시글 수정
	int updateBoard(Board board) throws Exception; // 게시글 수정

	// 5. 게시글 삭제
	int deleteBoard(Board board) throws Exception;// 게시글 삭제

	// 6. 조회수 증가
	int increaseViewCount(int boardId) throws Exception; // 게시글 조회 수 증가

	// 7. top5출력
	List<Board> boardTop5() throws Exception;

	// 8. 선택 게시글 삭제
	int deleteBoards(String[] boardIds) throws Exception;
	
	//10. 더보기
	public List<Board> moreBoardList(Board board) throws Exception;




}
