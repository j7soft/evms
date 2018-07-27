package egovframework.com.admin.bbs.cont.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.admin.bbs.cont.service.SupContentService;
import egovframework.com.admin.bbs.cont.service.SupContentVO;
import egovframework.com.admin.cop.bbs.service.EgovContentService;
import egovframework.com.cmm.BoardVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.FileUploadUtil;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cop.bbs.service.EgovBBSMasterService;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.usr.board.service.EgovUserService;
import egovframework.rte.fdl.property.EgovPropertyService;


/**
 * 게시물 관리를 위한 컨트롤러 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *   2009.06.29	한성곤			2단계 기능 추가 (댓글관리, 만족도조사)
 *   2011.07.01 안민정		 	댓글, 스크랩, 만족도 조사 기능의 종속성 제거
 *   2011.8.26	정진오			IncludedInfo annotation 추가
 *   2011.09.07 서준식           유효 게시판 게시일 지나도 게시물이 조회되던 오류 수정
 *   2016.06.13 김연호			표준프레임워크 3.6 개선
 *      </pre>
 */

@Controller
public class SupContentController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SupContentController.class);
	

	@Resource(name = "SupContentService")
	private SupContentService supContentService;
	
	
	@Resource(name = "EgovContentService")
	private EgovContentService egovContentService;

	@Resource(name = "EgovUserService")
	private EgovUserService egovUserService;

	@Resource(name = "loginService")
	private EgovLoginService loginService;

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovBBSMasterService")
	private EgovBBSMasterService egovBBSMasterService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	

	
	@Autowired
	private DefaultBeanValidator beanValidator;
	@RequestMapping("/admin/selectContent.do")
	public String ContentList(@RequestParam("NTT_ID") String NTT_ID , Model model) {
		SupContentVO supVO = new SupContentVO();
		supVO.setNTT_ID(NTT_ID); //게시판코드
		List<SupContentVO> commPlace = supContentService.ContentSelectCommPlace(supVO);
		
		String bbs_nm = "";
		switch (NTT_ID)
		{
		case "rent" :
			bbs_nm = "대관";
			break;
		case "edu" :
			bbs_nm = "교육";
			break;
		case "bus" :
			bbs_nm = "셔틀버스";
			break;
		case "trip" :
			bbs_nm = "현장학습";
			break;	
		}
		model.addAttribute("type", bbs_nm);
		model.addAttribute("NTT_ID", NTT_ID);
		LOGGER.debug("------------------------------------------------------------------");
		LOGGER.debug(NTT_ID);
		LOGGER.debug("------------------------------------------------------------------");
		
		model.addAttribute("list", commPlace);

		return "jsp/admin/reservation/prodCmmList";

	}
	@RequestMapping(value = "/admin/selectcal.do")
	public String selectcal(@RequestParam("NTT_ID") String bbsId , Model model) {
		
		String bbs_nm = "";
		switch (bbsId)
		{
		case "reservrent" :
			bbs_nm = "대관";
			break;
		case "reservedu" :
			bbs_nm = "교육";
			break;
		case "reservbus" :
			bbs_nm = "셔틀버스";
			break;
		case "reservtrip" :
			bbs_nm = "현장학습";
			break;
		case "reservtripT" :
			bbs_nm = "현장학습";
			break;	
		}
		model.addAttribute("NTT_ID", bbsId);
		
		SupContentVO supVO = new SupContentVO();
		supVO.setNTT_ID(bbsId); //게시판코드
		List<SupContentVO> commPlace = supContentService.ContentSelectCommPlace(supVO);
		
		for(int i = 0 ; i < commPlace.size(); i++){
			System.out.println(commPlace.get(i));
		}
		
		model.addAttribute("BBS_NM", bbs_nm);
		model.addAttribute("list", commPlace);

		return "jsp/admin/reservation/reservCmmCal";
	}
	@RequestMapping(value = "/admin/selectBoard.do")
	public String board(@RequestParam("NTT_ID") String bbsId ,@RequestParam("date") String date, Model model) {
		
		String bbs_nm = "";
		switch (bbsId)
		{
		case "reservrent" :
			bbs_nm = "대관";
			break;
		case "reservedu" :
			bbs_nm = "교육";
			break;
		case "reservbus" :
			bbs_nm = "셔틀버스";
			break;
		case "reservtrip" :
			bbs_nm = "현장학습";
			break;	
		}
		model.addAttribute("NTT_ID", bbsId);
		
		BoardVO bvo = new BoardVO();
		bvo.setNTT_ID(bbsId); //게시판코드
		bvo.setPUSHDATE(date);
		List<BoardVO> list = egovContentService.selectTable(bvo);
		bvo.setTITLE("select");
		List<BoardVO> title = egovContentService.selectTable(bvo);
		model.addAttribute("BBS_NM", bbs_nm);
		model.addAttribute("list", list);
		model.addAttribute("title", title);

		return "jsp/admin/reservation/reservCmmList";
	}
	

	@RequestMapping(value = "/admin/cont/detailPage.do")
	public String registPage(@RequestParam("BBS_ID") String bbsId ,@RequestParam("NTT_ID") String NTT_ID , Model model , HttpServletRequest request) {
		
		SupContentVO supVO = new SupContentVO();
		supVO.setBBS_ID(bbsId); //게시판코드
		SupContentVO bbsDetail = supContentService.ContentSelectCommPlaceOne(supVO);
		
		SupContentVO pvo = new SupContentVO();
		pvo.setBBS_ID(bbsDetail.getNAME());
		pvo = supContentService.ContentSelectCommPlaceOne(pvo);
		
		LoginVO lvo = new LoginVO();
		lvo.setId(bbsDetail.getMBER_ID());
		lvo = egovContentService.infoSelect(lvo);

		model.addAttribute("vo", bbsDetail);
		model.addAttribute("lvo", lvo);
		model.addAttribute("pvo", pvo);
		
		model.addAttribute("NTT_ID", NTT_ID);
		LOGGER.debug("------------------------------------------------------------------");
		LOGGER.debug("FDATA" + bbsDetail.getFDATE());
		LOGGER.debug("------------------------------------------------------------------");
		if(NTT_ID.trim().indexOf("reserv") != -1){
			if(NTT_ID.trim().equals("reservtripT")){
				return "jsp/admin/reservation/reservtripDetail" ;
			}else{
				return "jsp/admin/reservation/" + NTT_ID + "Detail" ;
			}
		}
		else{
			return "jsp/admin/reservation/" + NTT_ID;
		}
		
		
	}
	@RequestMapping(value="/admin/bookIpage.do")
	public String iPage(@RequestParam("NTT_ID") String NTT_ID, Model model, HttpServletRequest request){
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		model.addAttribute("lvo",lvo);
		model.addAttribute("NTT_ID",NTT_ID);
		
		return "jsp/admin/reservation/"+NTT_ID.trim();
	}
	
	
	@RequestMapping(value = "/admin/registData.do")
	public String registData(@ModelAttribute("supContentVO") BoardVO supContentVO, HttpServletRequest request, BindingResult bindingResult, Model model) throws Exception {
		
		int result = 0;
		
		model.addAttribute("resultMsg", "success.common.insert");
		LOGGER.debug("------------------------------------------------------------------");
		LOGGER.debug(supContentVO.getTITLE());
		LOGGER.debug(supContentVO.getBBS_ID());
		LOGGER.debug(supContentVO.getFDAY());
		LOGGER.debug(supContentVO.getCNT());
		LOGGER.debug(supContentVO.getFTIME());
		LOGGER.debug(supContentVO.getPRICE());
		LOGGER.debug(supContentVO.getSTIME());
		LOGGER.debug(supContentVO.getTITLE());
		LOGGER.debug(supContentVO.getDETAIL());
		LOGGER.debug(supContentVO.getPTB());
		LOGGER.debug("-----------nttid" + supContentVO.getNTT_ID());
		LOGGER.debug("------------------------------------------------------------------");

		int pk = egovContentService.pkSelect();
		supContentVO.setNTT_NO(supContentVO.getNTT_ID()+pk+"_");
		supContentVO = FileUploadUtil.fileUpload(supContentVO,request);
		
		result = supContentService.ContentInsertData(supContentVO);
		
		return "redirect:/admin/selectContent.do?NTT_ID="+supContentVO.getNTT_ID();
	}
	@RequestMapping(value="/admin/updateData.do")
	public String updateData(@ModelAttribute("supContentVO") BoardVO supContentVO, HttpServletRequest request, BindingResult bindingResult, Model model) throws Exception {
		
		
		
		int result = 0;
		
		model.addAttribute("resultMsg", "success.common.update");
		LOGGER.debug("/////////////////////////////////////////////////////////");
		LOGGER.debug(supContentVO.getTITLE());
		LOGGER.debug(supContentVO.getBBS_ID());
		LOGGER.debug(supContentVO.getFDAY());
		LOGGER.debug(supContentVO.getCNT());
		LOGGER.debug(supContentVO.getFTIME());
		LOGGER.debug(supContentVO.getPRICE());
		LOGGER.debug(supContentVO.getSTIME());
		LOGGER.debug(supContentVO.getTITLE());
		LOGGER.debug(supContentVO.getDETAIL());
		LOGGER.debug(supContentVO.getPTB());
		LOGGER.debug("/////////////////////////////////////////////////////////");

		int pk = egovContentService.pkSelect();
		supContentVO.setNTT_NO(supContentVO.getNTT_ID()+pk+"_");
		supContentVO = FileUploadUtil.fileUpload(supContentVO,request);
		
		/*result = supContentService.ContentInsertData(supContentVO);
		
		return "redirect:/admin/selectContent.do?NTT_ID="+supContentVO.getNTT_ID();*/
		
		
		result = supContentService.ContentUpdateData(supContentVO);
		
		if("move".equals(supContentVO.getNTT_ID())){
			return "redirect:/admin/board.do?NTT_ID=" +supContentVO.getNTT_ID();
		}
			
		return "redirect:/admin/selectContent.do?NTT_ID="+supContentVO.getNTT_ID();
	}
	
	
	///admin/stupdate.do
	@RequestMapping(value="/admin/stupdate.do")
	public String stupdate(@ModelAttribute("supContentVO") BoardVO supContentVO, HttpServletRequest request, BindingResult bindingResult, Model model, @RequestParam("CNT") String cnt, @RequestParam("NTT_NO") String ntt_no) throws Exception {
		
		
		int result = 0;
		
		model.addAttribute("resultMsg", "success.common.update");
		
		LOGGER.debug("--------------getONOFF          -->    " + supContentVO.getONOFF()  );
		
		LOGGER.debug("--------------getBBS_ID          -->    " + supContentVO.getBBS_ID() );
		
		result = supContentService.ContentUpdateOnoff(supContentVO);
		
		
		
		if(supContentVO.getNTT_ID().contains("edu") || supContentVO.getNTT_ID().contains("trip") ) {
		
		String mdata = cnt;
		
		LOGGER.debug("--------------mdata          -->    " + mdata  );
		
		int bp = Integer.parseInt(mdata.split(",")[0]);
		
		int sp = Integer.parseInt(mdata.split(",")[1]);
		
		int rdcnt = bp+sp;
		
		LOGGER.debug("--------------rdcnt          -->    " + rdcnt  );
		
		LOGGER.debug("--------------ntt_no          -->    " + ntt_no  );
		supContentVO.setRDCNT(rdcnt);
		
		supContentVO.setBBS_ID(ntt_no);
		
		
		}
		
		result = supContentService.ContentUpdateRdcnt(supContentVO);
		//승인시 페이지못찾음 잡기
		if(supContentVO.getNTT_ID().contains("move")  ){
			return "redirect:/admin/board.do?NTT_ID=" +supContentVO.getNTT_ID();
		}else if( supContentVO.getNTT_ID().contains("rent") || supContentVO.getNTT_ID().contains("trip") || supContentVO.getNTT_ID().contains("edu") || supContentVO.getNTT_ID().contains("bus")){
			
			return "redirect:/admin/selectcal.do?NTT_ID=" +supContentVO.getNTT_ID();
		}
			
		return "redirect:/admin/selectContent.do?NTT_ID="+supContentVO.getNTT_ID();
	}
	
}
