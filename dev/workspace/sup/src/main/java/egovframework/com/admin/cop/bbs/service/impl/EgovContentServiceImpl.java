package egovframework.com.admin.cop.bbs.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.admin.cop.bbs.service.ContentVO;
import egovframework.com.admin.cop.bbs.service.EgovContentService;
import egovframework.com.cmm.BoardVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("EgovContentService")
public class EgovContentServiceImpl extends EgovAbstractServiceImpl implements EgovContentService {
	
	@Resource(name = "EgovContentDAO")
    private EgovContentDAO egovContentDao;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "egovNttIdGnrService")
    private EgovIdGnrService nttIdgenService;

	@Override
	public int ContentInsert(ContentVO cvo) {
		return egovContentDao.ContentInsert(cvo);
	}

	@Override
	public int ContentUpdate(ContentVO cvo) {
		return egovContentDao.ContentUpdate(cvo);
	}

	@Override
	public List<ContentVO> ContentSelect(ContentVO cvo) {
		return egovContentDao.ContentSelect(cvo);
	}

	@Override
	public LoginVO infoSelect(LoginVO userVO) {
		return egovContentDao.infoSelect(userVO);
	}

	@Override
	public int boardInsert(BoardVO bvo) {
		return egovContentDao.boardInsert(bvo);
	}

	@Override
	public List<LoginVO> infoSelectAll() {
		return egovContentDao.infoSelectAll();
	}

	@Override
	public int boardDelete(String BBS_ID) {
		return egovContentDao.boardDelete(BBS_ID);
	}

	@Override
	public int qnaUpdate(BoardVO bvo) {
		return egovContentDao.qnaUpdate(bvo);
	}

	@Override
	public int pkSelect() {
		return egovContentDao.pkSelect();
	}

	@Override
	public int stupdate(BoardVO bvo) {
		return egovContentDao.stupdate(bvo);
	}

	@Override
	public int atonUpdate(BoardVO bvo) {
		return egovContentDao.atonUpdate(bvo);
	}

	@Override
	public List<BoardVO> selectTable(BoardVO bvo) {
		return egovContentDao.selectTable(bvo);
	}

	@Override
	public BoardVO selectTableDetail(BoardVO bvo) {
		return egovContentDao.selectTableDetail(bvo);
	}

	
}
