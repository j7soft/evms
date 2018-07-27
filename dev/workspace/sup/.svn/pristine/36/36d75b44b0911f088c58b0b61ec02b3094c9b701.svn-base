package egovframework.com.usr.board.service.impl;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.BoardVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.usr.board.service.InterUserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("InterUserService")
public class InterUserServiceImpl extends EgovAbstractServiceImpl implements InterUserService {

	@Resource(name = "InterUserDAO")
    private InterUserDAO egovUserDAO;

	@Override
	public List<BoardVO> boardSelect(BoardVO vo) {
		return egovUserDAO.boardSelect(vo);
	}

	@Override
	public BoardVO boardSelectOne(BoardVO vo) {
		return egovUserDAO.boardSelectOne(vo);
	}

	@Override
	public List<BoardVO> boardSelectOnList(BoardVO vo) {
		return egovUserDAO.boardSelectOnList(vo);
	}
	
	@Override
	public int boardinsert(BoardVO bvo) {
		return egovUserDAO.boardinsert(bvo);
	}

	@Override
	public List<BoardVO> bookSelect(BoardVO bvo) {
		return egovUserDAO.bookSelect(bvo);
	}

	@Override
	public int loginUpdate(LoginVO lvo) {
		return egovUserDAO.loginUpdate(lvo);
	}

	@Override
	public int boardCnt(BoardVO bvo) {
		return egovUserDAO.boardCnt(bvo);
	}

	@Override
	public int boardUpdate(BoardVO bvo) {
		return egovUserDAO.boardUpdate(bvo);
	}

	@Override
	public String sysdate() {
		return egovUserDAO.sysdate();
	}

	@Override
	public List<BoardVO> boardSearch(String word) {
		return egovUserDAO.boardSearch(word);
	}
	
	
}
