package egovframework.com.admin.cop.bbs.web;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.admin.bbs.cont.service.SupContentService;
import egovframework.com.admin.cop.bbs.service.ContentVO;
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
public class EgovContentController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovContentController.class);
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

	@RequestMapping("/admin/content.do")
	public String ContentList(@RequestParam("NTT_NO") String str, ModelMap model) {
		ContentVO cvo = new ContentVO();
		cvo.setNTT_NO(str.trim().substring(0, 2));
		List<ContentVO> list = egovContentService.ContentSelect(cvo);

		for (int i = 0; i < list.size(); i++) {
		}
		model.addAttribute("list", list);
		if (str.equals("popup")) {
			return "jsp/admin/content/EgovPopup";
		} else if (str.trim().equals("banner")) {
			return "jsp/admin/content/EgovBanner";
		} else if (str.trim().equals("program")) {
			return "jsp/admin/content/EgovProgram";
		} else if (str.trim().equals("")) {
			return "jsp/admin/content/";
		} else {
			return "404";
		}

	}

	@ResponseBody
	@RequestMapping(value = "/admin/ContentInsert.do", method = RequestMethod.POST, produces = "text/plain; charset=UTF-8")
	public String ContentInsert(@ModelAttribute("frm") ContentVO cvo, @RequestParam("NTT_NO") String str,
			HttpServletRequest request) throws Exception {

		List<ContentVO> list = egovContentService.ContentSelect(cvo);
		String type = "";
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		cvo.setLAST_UPDUSR_ID(lvo.getId());
		cvo.setFRST_REGISTER_ID(lvo.getId());
		cvo.setNTT_NO(str.trim());
		int result = 0;
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getBANNER_NM().trim().equals(cvo.getBANNER_NM().trim())) {
				type = "update";
				break;
			}
		}
		if (type.equals("update")) {

			result = 0;
			String b_file = "";
			if (!cvo.getFile().isEmpty()) {
				FileUploadUtil.fileDelete(cvo.getB_file(), request);
				b_file = FileUploadUtil.fileUpload(cvo.getFile(), request, "file", cvo.getBANNER_NM());
				cvo.setBANNER_IMAGE_FILE(b_file);
			} else {
				cvo.setB_file("");
			}
			result = egovContentService.ContentUpdate(cvo);
		} else {
			result = 0;
			String fileName = FileUploadUtil.fileUpload(cvo.getFile(), request, "file", cvo.getBANNER_NM());
			cvo.setBANNER_IMAGE_FILE(fileName);
			/*
			 * String thumbName = FileUploadUtil.makeThumbnail(fileName,
			 * request); cvo.setBANNER_IMAGE(thumbName);
			 */
			result = egovContentService.ContentInsert(cvo);
		}
		if (result == 1) {
			type = "성공";
		} else {
			type = "실패";
		}
		return type;
	}

	@RequestMapping(value = "/state.do")
	public String state(@RequestParam("NTT_NO") String NTT_NO, @RequestParam("BANNER_NM") String BANNER_NM,
			@RequestParam("REFLCT_AT") String REFLCT_AT, HttpServletRequest request) {
		ContentVO cvo = new ContentVO();
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		cvo.setLAST_UPDUSR_ID(lvo.getId());
		cvo.setNTT_NO(NTT_NO);
		cvo.setBANNER_NM(BANNER_NM);
		cvo.setREFLCT_AT(REFLCT_AT);
		cvo.setLINK_URL("");
		int result = egovContentService.ContentUpdate(cvo);
		return "redirect:/admin/content.do?NTT_NO=" + NTT_NO;
	}

	@RequestMapping(value = "/admin/board.do")
	public String board(@RequestParam("NTT_ID") String NTT_ID, ModelMap model, HttpServletRequest request) {
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		System.out.println(lvo.toString());
		
		BoardVO vo = new BoardVO();
		vo.setNTT_ID(NTT_ID.trim());
		List<BoardVO> list = egovUserService.boardSelect(vo);
		
		String type = "";
		switch (NTT_ID) {
		case "move":
			type="입주업체 관리";
			break;
		case "review":
			type="후기 관리";
			break;
		case "notice":
			type="공지사항";
			break;
		case "news":
			type="보도자료";
			break;
		case "reference":
			type="자료실";
			break;
		case "story":
			type="스토리";
			break;
		case "freeboard":
			type="자유게시판";
			break;
		case "qna":
			type="Q&A";
			break;
		case "faq":
			type="FAQ";
			break;
		case "gallery":
			type="갤러리";
			break;
		case "material":
			type="소재";
			break;
		}

		model.addAttribute("type", type);
		model.addAttribute("NTT_ID", NTT_ID);
		model.addAttribute("list", list);
		model.addAttribute("lvo",lvo);
		
		if(type.trim().equals("소재")||type.trim().equals("갤러리")||type.trim().equals("공지사항")||type.trim().equals("보도자료")||type.trim().equals("자료실")||type.trim().equals("스토리")||type.trim().equals("자유게시판")){
			return "jsp/admin/board/boardList";
		}else if(type.trim().equals("")||type.trim().equals("")||type.trim().equals("")||type.trim().equals("")||type.trim().equals("")){
			return "jsp/admin/board/List";
		}else if(type.trim().equals("FAQ")){
			return "jsp/admin/board/"+NTT_ID+"List";
		}else{
			return "jsp/admin/board/"+NTT_ID+"List";					
		}
	}
	
	@RequestMapping(value="/admin/boardDetail.do")
	public String boardDetail(@RequestParam("NTT_ID") String NTT_ID,@RequestParam("BBS_ID") String BBS_ID, Model model, HttpServletRequest request){
				
		BoardVO vo = new BoardVO();
		vo.setBBS_ID(BBS_ID.trim());
		vo = egovUserService.boardSelectOne(vo);
		
		LoginVO lvo = null;
		if(vo.getMBER_ID()!=null){
			lvo=new LoginVO();
			lvo.setId(vo.getMBER_ID().trim());
			lvo = egovContentService.infoSelect(lvo);
			model.addAttribute("lvo", lvo);
		}
		
		String type = "";
		switch (NTT_ID) {
		case "move":
			type="입주업체 관리";
			break;
		case "review":
			type="후기 관리";
			break;
		case "notice":
			type="공지사항";
			break;
		case "news":
			type="보도자료";
			break;
		case "reference":
			type="자료실";
			break;
		case "freeboard":
			type="자유게시판";
			break;
		case "story":
			type="스토리";
			break;
		case "qna":
			type="Q&A";
			break;
		case "faq":
			type="FAQ";
			break;
		case "gallery":
			type="갤러리";
			break;
		case "material":
			type="소재";
			break;
		}

		model.addAttribute("type", type);
		model.addAttribute("NTT_ID", NTT_ID);
		model.addAttribute("vo", vo);
		
		if(NTT_ID.trim().equals("gallery")||NTT_ID.trim().equals("material")||NTT_ID.trim().equals("notice")||NTT_ID.trim().equals("news")||NTT_ID.trim().equals("reference")||NTT_ID.trim().equals("freeboard")){
			return "jsp/admin/board/board";
		}else if(NTT_ID.trim().equals("qna")){
			return "jsp/admin/board/"+NTT_ID+"Detail";
		}else if(NTT_ID.trim().equals("")||NTT_ID.trim().equals("")||NTT_ID.trim().equals("")||NTT_ID.trim().equals("")||NTT_ID.trim().equals("")){
			return "jsp/admin/board/List";
		}else{
			return "jsp/admin/board/"+NTT_ID;					
		}
	}
	
	@RequestMapping(value="/admin/boardIpage.do")
	public String boardIpage(@RequestParam("NTT_ID") String NTT_ID, Model model, HttpServletRequest request){
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		model.addAttribute("lvo",lvo);
		System.out.println(lvo.toString());
		
		String type = "";
		switch (NTT_ID) {
		case "move":
			type="입주업체 등록";
			break;
		case "member":
			type="회원";
			break;
		case "review":
			type="후기";
			break;
		case "notice":
			type="공지사항 등록";
			break;
		case "news":
			type="보도자료 등록";
			break;
		case "reference":
			type="자료 등록";
			break;
		case "story":
			type="스토리 등록";
			break;
		case "qna":
			type="Q&A 답변";
			break;
		case "faq":
			type="FAQ";
			break;
		case "gallery":
			type="갤러리";
			break;
		case "material":
			type="소재";
			break;
		}

		model.addAttribute("type", type);
		model.addAttribute("NTT_ID", NTT_ID);
		
		if(NTT_ID.trim().equals("gallery")||NTT_ID.trim().equals("material")||NTT_ID.trim().equals("notice")||NTT_ID.trim().equals("news")||NTT_ID.trim().equals("reference")){
			return "jsp/admin/board/board";
		}else if(NTT_ID.trim().equals("")){
			return "jsp/admin/board/";
		}else if(NTT_ID.trim().equals("")||NTT_ID.trim().equals("")||NTT_ID.trim().equals("")||NTT_ID.trim().equals("")||NTT_ID.trim().equals("")){
			return "jsp/admin/board/List";
		}else{
			return "jsp/admin/board/"+NTT_ID;					
		}
	}
	
	@RequestMapping(value="/amdin/infoSelectAll.do")
	public String infoSelectAll(Model model, HttpServletRequest request){
		List<LoginVO> lvo = egovContentService.infoSelectAll();
		model.addAttribute("list",lvo);
		model.addAttribute("type","회원관리");
		
		return "jsp/admin/board/memberList";
	}
	
	@RequestMapping(value="/amdin/infoSelect.do")
	public String infoSelect(@RequestParam("MBER_ID")String MBER_ID,Model model, HttpServletRequest request){
		LoginVO lvo = new LoginVO();
		lvo.setId(MBER_ID);
		lvo = egovContentService.infoSelect(lvo);

		model.addAttribute("type","회원관리");
		model.addAttribute("lvo",lvo);
		
		return "jsp/admin/board/SUP_Mypage";
	}
	@RequestMapping(value="/amdin/infoUpdate.do")
	public String infoUpdate(@ModelAttribute("lfrm")LoginVO lvo, ModelMap model, HttpServletRequest request){
		int result = 0;
		result = egovUserService.loginUpdate(lvo);
		if(result == 1){
			return "redirect:/amdin/infoSelect.do?MBER_ID="+lvo.getId();
		}else{
			return "/404";
		}
	}
	
	@RequestMapping(value="/admin/boardInsert.do")
	public String boardInsert(@ModelAttribute("frm")BoardVO bvo ,Model model, HttpServletRequest request) throws Exception{
		int result = 0;
		int pk = egovContentService.pkSelect();
		bvo.setNTT_NO(bvo.getNTT_ID()+pk+"_");
		bvo = FileUploadUtil.fileUpload(bvo,request);
		
		result = egovContentService.boardInsert(bvo);
		if(result != 1){
			return "/404";
		}else{
			return "redirect:/admin/board.do?NTT_ID="+bvo.getNTT_ID();
		}
	}
	@RequestMapping(value="/admin/boardUpdate.do")
	public String boardUpdate(@ModelAttribute("frm")BoardVO bvo ,Model model, HttpServletRequest request) throws Exception{
		int result = 0;
		bvo = FileUploadUtil.fileUpload(bvo,request);
		
		result = egovUserService.boardUpdate(bvo);
		if(result != 1){
			return "/404";
		}else{
			return "redirect:/admin/board.do?NTT_ID="+bvo.getNTT_ID();
		}
	}
	@RequestMapping(value="/admin/boardDelete.do")
	public String boardDelete(@RequestParam("NTT_ID")String NTT_ID ,@RequestParam("BBS_ID")String BBS_ID ,Model model, HttpServletRequest request) throws IOException{
		BoardVO bvo = new BoardVO();
		bvo.setNTT_ID(NTT_ID);
		bvo.setBBS_ID(BBS_ID);
		bvo = egovUserService.boardSelectOne(bvo);
		/** 이부분에서 파일 삭제 루틴 부분을 지워본다 
		if (bvo.getFFILE()!=null) {
			FileUploadUtil.fileDelete(bvo.getFFILE(), request);
		}
		if (bvo.getIMAGE()!=null) {
			FileUploadUtil.fileDelete(bvo.getIMAGE(), request);
		}
		if (bvo.getITEM_IMAGE()!=null) {
			FileUploadUtil.fileDelete(bvo.getITEM_IMAGE(), request);
		}
		if (bvo.getMIMAGE()!=null) {
			FileUploadUtil.fileDelete(bvo.getMIMAGE(), request);
		}
		if (bvo.getLOGO()!=null) {
			FileUploadUtil.fileDelete(bvo.getLOGO(), request);
		}
		*/
		int result = egovContentService.boardDelete(BBS_ID);
		
		if(result != 1){
			return "/404";
		}else{
			
			// 관리자단 마스터 삭제 후 리턴값.
			if(NTT_ID.contains("rent") || NTT_ID.contains("edu") || NTT_ID.contains("trip") ) {
				return "redirect:/admin/selectContent.do?NTT_ID="+NTT_ID;
			} else {	
				return "redirect:/admin/board.do?NTT_ID="+NTT_ID;
			}
		}
	}
	@RequestMapping(value="/admin/qndUpdate.do")
	public String qndUpdate(@ModelAttribute("frm") BoardVO bvo ,Model model, HttpServletRequest request){
		int result = 0;
		result = egovContentService.qnaUpdate(bvo);
		
		if(result != 1){
			return "/404";
		}else{
			return "redirect:/admin/boardDetail.do?NTT_ID="+bvo.getNTT_ID().trim()+"&BBS_ID="+bvo.getBBS_ID().trim();
		}
	}
	@RequestMapping(value="/admin/atonUpdate.do")
	public String atonUpdate(@RequestParam("NTT_ID")String NTT_ID ,@RequestParam("BBS_ID")String BBS_ID,@RequestParam("type")String type,@RequestParam("value")String value, Model model, HttpServletRequest request){
		int result = 0;
		BoardVO bvo = new BoardVO();
		bvo.setNTT_ID(NTT_ID);
		bvo.setBBS_ID(BBS_ID);
		if(type.trim().equals("ONOFF")){
			bvo.setONOFF(value);
		}else{
			bvo.setUSE_AT(value);
		}
		
		result = egovContentService.atonUpdate(bvo);
		
		if(result != 1){
			return "/404";
		}else{
			return "redirect:/admin/board.do?NTT_ID="+NTT_ID;
		}
	}

}
