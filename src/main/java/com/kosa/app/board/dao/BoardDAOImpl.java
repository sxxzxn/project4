package com.kosa.app.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.app.board.domain.Board;

@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private  SqlSession sqlSession;


	// 1.게시판 목록
	@Override
	public List<Board> getBoardAllList() throws Exception {
		return sqlSession.selectList("mapper.board.getBoardAllList");
	}
	//getBoardAllList

	
	// 2. 게시판 상세보기
	@Override
	public Board getBoardById(int boardId) throws Exception {
		return sqlSession.selectOne("mapper.board.getBoardById", boardId);
	} // getBoard

	
	// 3. 게시판 글 등록
	@Override
	public int insertBoard(Board board) throws Exception {
		return sqlSession.insert("mapper.board.insertBoard", board);
	} //insertBoard

	// 4. 게시글 수정
	@Override
	public int updateBoard(Board board) throws Exception {
		return sqlSession.update("mapper.board.updateBoard", board);
	} //updateBoard

	// 5. 게시글 삭제
	@Override
	public int deleteBoard(Board board) throws Exception {
		return sqlSession.delete("mapper.board.deleteBoard", board);
	} // deleteBoard

	// 6. 조회수 증가
	@Override
	public int increaseViewCount(int boardId) throws Exception {
		return sqlSession.update("mapper.board.viewCount", boardId);
	} // viewCount

	// 7. top5출력
	@Override
	public List<Board> boardTop5() throws Exception {
		return sqlSession.selectList("mapper.board.boardTop5");
	} // boardTop5
	
	//8. 체크박스된 게시글 삭제
	@Override
	public int deleteBoards(String[] boardIds) throws Exception {
		System.out.println("board.boardDAOImpl.deleteBoards() 함수 호출됨");
		return sqlSession.delete("mapper.board.deleteBoards", boardIds);
		
	 } // deleteBoards

	//9. 더보기
	@Override
	public List<Board> moreBoardList(Board board) throws Exception {
		System.out.println("board.boardDAOImpl.moreBoardList() 함수 호출됨");
		return sqlSession.selectList("mapper.board.getBoardList2", board);
	}
		

}
