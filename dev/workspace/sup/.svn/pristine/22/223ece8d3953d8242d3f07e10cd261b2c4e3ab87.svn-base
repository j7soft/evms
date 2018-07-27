package egovframework.com.admin.bbs.cont.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.admin.bbs.cont.service.SupContentVO;
import egovframework.com.cmm.BoardVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SupContentDAO")
public class SupContentDAO extends EgovComAbstractDAO {

	public int ContentInsertData(BoardVO cvo) {
		return (int)insert("SupContentDAO.ContentInsertData", cvo);
	}

	public int ContentUpdateData(BoardVO cvo) {
		return (int)update("SupContentDAO.ContentUpdateData", cvo);
	}

	public int ContentUpdateOnoff(BoardVO cvo) {
		return (int)update("SupContentDAO.ContentUpdateOnoff", cvo);
	}

	public int ContentUpdateRdcnt(BoardVO cvo) {
		
		
		return (int)update("SupContentDAO.ContentUpdateRdcnt", cvo);
	}
	
	
	public int ContentUpdate(SupContentVO cvo) {
		int result = 0;
		result = (int)update("EgovContentDAO.ContentUpdate", cvo);
		
		return result;
	}

	public List<SupContentVO> ContentSelectCommPlace(SupContentVO cvo) {
		return (List<SupContentVO>) list("SupContentDAO.ContentSelectCommPlace",cvo);
	}

	public SupContentVO ContentSelectCommPlaceOne(SupContentVO cvo) {
		return (SupContentVO) selectOne("SupContentDAO.ContentSelectCommPlaceOne",cvo);
	}

	public LoginVO infoSelect(LoginVO userVO) {
		return (LoginVO)selectOne("EgovContentDAO.infoSelect",userVO);
	}



}
