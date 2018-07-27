package egovframework.com.admin.bbs.cont.service;

import java.util.List;

import egovframework.com.cmm.BoardVO;
import egovframework.com.cmm.LoginVO;

public interface SupContentService {

	int ContentInsertData(BoardVO supContentVO);
	
	int ContentUpdateData(BoardVO supContentVO);
	
	int ContentUpdateOnoff(BoardVO supContentVO);
	
	int ContentUpdateRdcnt(BoardVO supContentVO);
	
	int ContentUpdateTT(SupContentVO cvo);

	SupContentVO ContentSelectCommPlaceOne(SupContentVO cvo);

	List<SupContentVO> ContentSelectCommPlace(SupContentVO cvo);
	
	LoginVO infoSelectTT(LoginVO userVO);

	
	
}
