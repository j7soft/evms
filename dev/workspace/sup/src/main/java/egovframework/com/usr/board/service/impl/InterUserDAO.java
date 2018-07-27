package egovframework.com.usr.board.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.BoardVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("InterUserDAO")
public class InterUserDAO extends EgovComAbstractDAO {

	public List<BoardVO> boardSelect(BoardVO vo) {
		List<BoardVO> list = (List<BoardVO>) list("EgovUserDAO.boardSelect",vo);


		return list;
	}

	public BoardVO boardSelectOne(BoardVO vo) {
		BoardVO bvo = (BoardVO)selectOne("EgovUserDAO.boardSelectOne",vo);
		return bvo;
	}

	public List<BoardVO> boardSelectOnList(BoardVO vo) {
		List<BoardVO> list = (List<BoardVO>) list("EgovUserDAO.boardSelectOnList",vo);
		return list;
	}
	
	public int boardinsert(BoardVO bvo) {
		return (int)insert("EgovUserDAO.boardinsert",bvo);
	}

	public List<BoardVO> bookSelect(BoardVO bvo) {
		List<BoardVO> list = (List<BoardVO>) list("EgovUserDAO.bookSelect",bvo);
		return list;
	}

	public int loginUpdate(LoginVO lvo) {
		return (int)update("EgovUserDAO.loginUpdate",lvo);
	}

	public int boardCnt(BoardVO bvo) {
		return (int)update("EgovUserDAO.boardCnt",bvo);
	}

	public int boardUpdate(BoardVO bvo) {
		return (int)update("EgovUserDAO.boardUpdate",bvo);
	}

	public String sysdate() {
		return (String)selectOne("EgovUserDAO.sysdate");
	}

	public List<BoardVO> boardSearch(String word) {
		List<BoardVO> list = (List<BoardVO>) list("EgovUserDAO.boardSearch",word);
		return list;
	}

}
