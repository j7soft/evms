package egovframework.com.admin.cop.bbs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.admin.cop.bbs.service.ContentVO;
import egovframework.com.cmm.BoardVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("EgovContentDAO")
public class EgovContentDAO extends EgovComAbstractDAO {

	public int ContentInsert(ContentVO cvo) {
		return (int)insert("EgovContentDAO.ContentInsert", cvo);
	}

	public int ContentUpdate(ContentVO cvo) {
		int result = 0;
		if(cvo.getLINK_URL().equals(null)  || cvo.getLINK_URL().equals("")){
			result = (int)update("EgovContentDAO.atUpdate", cvo);
		}else{
			result = (int)update("EgovContentDAO.ContentUpdate", cvo);
		}
		return result;
	}

	public List<ContentVO> ContentSelect(ContentVO cvo) {
		return (List<ContentVO>) list("EgovContentDAO.ContentSelect",cvo);
	}

	public LoginVO infoSelect(LoginVO userVO) {
		return (LoginVO)selectOne("EgovContentDAO.infoSelect",userVO);
	}

	public int boardInsert(BoardVO bvo) {
		return (int)insert("EgovContentDAO.boardInsert",bvo);
	}

	public List<LoginVO> infoSelectAll() {
		return (List<LoginVO>) list("EgovContentDAO.infoSelectAll",null);
	}

	public int boardDelete(String BBS_ID) {
		return (int)delete("EgovContentDAO.boardDelete",BBS_ID);
	}

	public int qnaUpdate(BoardVO bvo) {
		return (int)update("EgovContentDAO.qnaUpdate",bvo);
	}

	public int pkSelect() {
		return (int)selectOne("EgovContentDAO.pkSelect");
	}

	public int stupdate(BoardVO bvo) {
		return (int)update("EgovContentDAO.stupdate",bvo);
	}

	public int atonUpdate(BoardVO bvo) {
		return (int)update("EgovContentDAO.atonUpdate",bvo);
	}

	public List<BoardVO> selectTable(BoardVO bvo) {
		List<BoardVO> list = null;
		if(bvo.getPUSHDATE() == null){
			list = (List<BoardVO>) list("EgovContentDAO.selectcal",bvo);
			
		}else{
			if(bvo.getTITLE() != null){
				list = (List<BoardVO>) list("EgovContentDAO.selectTITLE",bvo);
			}else{
				list = (List<BoardVO>) list("EgovContentDAO.selectTable",bvo);
			}
		}
		return list;
	}

	public BoardVO selectTableDetail(BoardVO bvo) {
		return (BoardVO)selectOne("EgovContentDAO.selectTableDetail",bvo);
	}

	


}
