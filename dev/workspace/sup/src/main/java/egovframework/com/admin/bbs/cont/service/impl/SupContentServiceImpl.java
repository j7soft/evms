package egovframework.com.admin.bbs.cont.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.admin.bbs.cont.service.SupContentService;
import egovframework.com.admin.bbs.cont.service.SupContentVO;
import egovframework.com.cmm.BoardVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("SupContentService")
public class SupContentServiceImpl  implements SupContentService {
	
	@Resource(name = "SupContentDAO")
    private SupContentDAO supContentDAO;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "egovNttIdGnrService")
    private EgovIdGnrService nttIdgenService;

	@Override
	public int ContentInsertData(BoardVO cvo) {
		return supContentDAO.ContentInsertData(cvo);
	}

	@Override
	public int ContentUpdateData(BoardVO cvo) {
		return supContentDAO.ContentUpdateData(cvo);
	}
	
	@Override
	public int ContentUpdateOnoff(BoardVO cvo) {
		
		return supContentDAO.ContentUpdateOnoff(cvo);
	}

	@Override
	public int ContentUpdateRdcnt(BoardVO cvo) {
		return supContentDAO.ContentUpdateRdcnt(cvo);
	}
	
	
	
	public int ContentUpdateTT(SupContentVO cvo) {
		return supContentDAO.ContentUpdate(cvo);
	}

	@Override
	public List<SupContentVO> ContentSelectCommPlace(SupContentVO cvo) {
		return supContentDAO.ContentSelectCommPlace(cvo);
	}


	@Override
	public SupContentVO ContentSelectCommPlaceOne(SupContentVO cvo) {
		return supContentDAO.ContentSelectCommPlaceOne(cvo);
	}
	
	@Override
	public LoginVO infoSelectTT(LoginVO userVO) {
		return supContentDAO.infoSelect(userVO);
	}

	
}
