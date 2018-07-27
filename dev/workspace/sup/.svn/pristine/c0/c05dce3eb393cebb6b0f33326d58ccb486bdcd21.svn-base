package egovframework.com.usr.board.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.google.gson.Gson;

import egovframework.com.admin.cop.bbs.service.EgovContentService;
import egovframework.com.cmm.BoardVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cop.bbs.service.EgovBBSMasterService;
import egovframework.com.usr.board.service.EgovUserService;
import egovframework.com.usr.board.service.InterUserService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class EgovUserController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovUserController.class);

	@Resource(name = "InterUserService")
	private InterUserService interUserService;
	
	@Resource(name = "EgovUserService")
	private EgovUserService egovUserService;

	@Resource(name = "EgovContentService")
	private EgovContentService egovContentService;

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

	@RequestMapping(value = "/introduce.do")
	public String introduce(@RequestParam("type") String type, ModelMap model, HttpServletRequest request) {

		if (type.trim().equals("Introduction")) {
			return "jsp/template/SUPIC/SUP_Introduction";
		} else if (type.trim().equals("Business")) {
			return "jsp/template/SUPIC/SUP_Introduction_Business";
		} else if (type.trim().equals("Message")) {
			return "jsp/template/SUPIC/SUP_Introduction_Message";
		} else if (type.trim().equals("Organization")) {
			return "jsp/template/SUPIC/SUP_Introduction_Organization";
		} else if (type.trim().equals("Location")) {
			return "jsp/template/SUPIC/SUP_Introduction_Location";
		} else if (type.trim().equals("SiteMap")) {
			return "jsp/template/SUPIC/SUP_Sitemap";
		} else if (type.trim().equals("Clause")) {
			return "jsp/template/SUPIC/SUP_clause";
		} else if (type.trim().equals("MaterialsI")) {
			return "jsp/template/SUPIC/SUP_Materials_Introduction";
		} else if (type.trim().equals("MaterialsC")) {
			return "jsp/template/SUPIC/SUP_Materials_Condition";
		}  else if (type.trim().equals("Floor")) {
			return "jsp/template/SUPIC/SUP_Floor";
		} else if (type.trim().equals("Introduction_Street")) {
			return "jsp/template/SUPIC/SUP_Introduction_Street1";
		} else {
			return "잘못된접근입니다.";
		}
	}
	public int boardCnt(BoardVO bvo){
		int result=0;
		result = egovUserService.boardCnt(bvo);
		
		
		return result;
	}

	@RequestMapping(value = "/display.do")
	public String display(@RequestParam("type") String str, ModelMap model, HttpServletRequest request) {
		if (str.trim().equals("SUP_Display")) {
			return "jsp/template/display/SUP_Display";
		} else if (str.trim().equals("Display_Studio")) {
			return "jsp/template/display/SUP_Display_Studio";
		} else if (str.trim().equals("Display_Education")) {
			return "jsp/template/display/SUP_Display_Education";
		} else if (str.trim().equals("Display_Fablab")) {
			return "jsp/template/display/SUP_Display_Fablab";
		} else if (str.trim().equals("Display_Cafe")) {
			return "jsp/template/display/SUP_Display_Cafe";
		} else if (str.trim().equals("Display_Restrant")) {
			return "jsp/template/display/SUP_Display_Restrant";
		} else if (str.trim().equals("Display_Outdoors")) {
			return "jsp/template/display/SUP_Display_Outdoors";
		} else {
			return "잘못된접근입니다.";
		}
	}

	@RequestMapping(value = "/studio.do")
	public String studio(@RequestParam("type") String str, ModelMap model, HttpServletRequest request) {
		if (str.trim().equals("Studio_Display")) {
			return "jsp/template/SUPST/SUP_Studio_Display";
		} else if (str.trim().equals("Studio_Rent")) {
			return "jsp/template/SUPST/SUP_Studio_Rent";
		} else if (str.trim().equals("Studio_Education")) {
			return "jsp/template/SUPST/SUP_Studio_Education";
		} else if (str.trim().equals("Studio_Learning")) {
			return "jsp/template/SUPST/SUP_Studio_Learning";
		}  else if (str.trim().equals("Studio_Weekly")) {
			return "jsp/template/SUPST/SUP_Studio_Weekly";
		} else {
			return "잘못된접근입니다.";
		}
	}
	
	@RequestMapping(value = "/freeboard.do")
	public String freeboardInsert(@RequestParam("NTT_ID") String NTT_ID, ModelMap model, HttpServletRequest request) {
		
		model.addAttribute("NTT_ID", NTT_ID);
		
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		model.addAttribute("lvo", lvo);		
		
		
		if (NTT_ID.trim().equals("freeboard")) {
			return "jsp/template/board/boardInsert";
		} else {
			return "잘못된접근입니다.";
		}
	}
	@RequestMapping(value = "/mypage.do")
	public String mypage(HttpServletRequest request, ModelMap model) {
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		BoardVO bvo = new BoardVO();
		String sysdate = sysdate();
		bvo.setMBER_ID(lvo.getId());

		
		
		List<BoardVO> list = interUserService.bookSelect(bvo);

		/*for (int i = 0; i < list.size(); i++) {
			LOGGER.debug("title ------->" + list.get(i).getTITLE());
			LOGGER.debug("onoff ------->" + list.get(i).getONOFF());
		}*/
		
		
		model.addAttribute("sysdate", sysdate);
		model.addAttribute("list", list);
		model.addAttribute("lvo", lvo);

		return "jsp/template/board/SUP_Mypage";
	}
	
	@RequestMapping(value = "/loginUpdate.do")
	public String loginUpdate(@ModelAttribute("lfrm")LoginVO lvo, ModelMap model, HttpServletRequest request) {
		int result = 0;
		result = interUserService.loginUpdate(lvo);
		if(result == 1){

			request.getSession().setAttribute("loginVO",lvo );
			return "redirect:/mypage.do";
		}else{
			return "/404";
		}
		
	}
	
	
	@RequestMapping(value = "/infoInsert.do")
	public String infoInsert(@ModelAttribute("frm")BoardVO bvo, ModelMap model, HttpServletRequest request) {
		int result = 0;
		model.addAttribute("NTT_ID", bvo.getNTT_ID().trim());
		
		result = interUserService.boardinsert(bvo);
		
		if(result == 1){
			return "redirect:/board.do?type="+bvo.getNTT_ID();
		} else {
			return "잘못된접근입니다.";
		}
		
	}
	
	@RequestMapping(value = "/detail.do")
	public String move(@RequestParam("NTT_ID") String NTT_ID, @RequestParam("BBS_ID") String BBS_ID, ModelMap model, HttpServletRequest request) {
		
		// 디테일 가기전 로그인정보 불러오기
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		model.addAttribute("lvo", lvo);		
		
		// 매개변수로 받은 디테일 고유번호를 vo에 담아 예약 조회하기
		BoardVO vo = new BoardVO();
		vo.setNTT_ID(NTT_ID.trim());
		vo.setBBS_ID(BBS_ID.trim());
		
		// 예약 조회
		BoardVO dvo = interUserService.boardSelectOne(vo);
		if (dvo != null || !dvo.getNAME().equals(null) || !dvo.getNAME().equals("")) {
			vo.setBBS_ID(dvo.getNAME());// 조회 후 받아오는 상품정보의 고유번호를 다시 설정 후 상품정보
										// 불러오기
			// 상품 조회
			BoardVO pvo = interUserService.boardSelectOne(vo);
			if (pvo != null) {
				model.addAttribute("pvo", pvo);
			}
		}
		
		//성인 / 아동 카운팅때문에 예외조건 추가.
		if(!(NTT_ID).contains("reserv")){
			
		
		
			int cnt = 0;
			if(dvo.getCNT()==null ||dvo.getCNT().equals("")){
				cnt = 0;
			}else{
				cnt = Integer.parseInt(dvo.getCNT());
			}
			
			cnt += 1;
			System.out.println(cnt);
			
			dvo.setCNT(cnt+"");
		}
			boardCnt(dvo);
			
			model.addAttribute("vo", dvo);

		
		LOGGER.debug("------------------------------------------------------------------");
		LOGGER.debug(dvo.getTITLE());
		LOGGER.debug(dvo.getBBS_ID());
		LOGGER.debug(dvo.getFDAY());
		LOGGER.debug(dvo.getCNT());
		LOGGER.debug(dvo.getFTIME());
		LOGGER.debug(dvo.getPRICE());
		LOGGER.debug(dvo.getSTIME());
		LOGGER.debug(dvo.getTITLE());
		LOGGER.debug(dvo.getDETAIL());
		LOGGER.debug(dvo.getPTB());
		LOGGER.debug("------------------------------------------------------------------");
		String type = "";
		String root = "";
		switch (NTT_ID) {
		case "mypage":
			type = "마이페이지";
			break;
		case "move":
			type = "입주시설임대";
			root = "홈,주요사업,입주시설임대";
			break;
		case "story":
			type = "스토리";
			root = "홈,커뮤니티,스토리";
			break;
		case "notice":
			type = "공지사항";
			root = "홈,커뮤니티,공지사항";
			break;
		case "news":
			type = "보도자료";
			root = "홈,커뮤니티,보도자료";
			break;
		case "reference":
			type = "자료실";
			root = "홈,커뮤니티,자료실";
			break;
		case "customer":
			type = "고객센터";
			root = "홈,커뮤니티,고객센터";
			break;
		case "freeboard":
			type = "자유게시판";
			root = "홈,커뮤니티,자유게시판";
			break;
		case "gallery":
			type="갤러리";
			root = "홈,커뮤니티,갤러리";
			break;
		case "material":
			type="소재이야기";
			root = "홈,커뮤니티,소재이야기";
			break;
			
			
		case "reservrent":
			type = "대관예약";
			root = "홈,대관및예약,대관예약";
			break;
		case "reservbus":
			type="셔틀버스예약";
			root = "홈,대관및예약,셔틀버스예약";
			break;
		case "reservedu":
			type="교육예약";
			root = "홈,대관및예약,교육예약";
			break;
		case "reservtrip":
			type="현장학습예약";
			root = "홈,대관및예약,현장학습예약";
			break;
		case "reservtripT":
			type="현장학습예약";
			root = "홈,대관및예약,현장학습예약";
			break;
			
		case "qna":
			type="나의질문";
			root = "홈,커뮤니티,나의질문";
			break;
		}
		
		model.addAttribute("type", type);
		model.addAttribute("root", root);
		model.addAttribute("NTT_ID", NTT_ID);
		
		if (NTT_ID.trim().equals("move")) {
			return "jsp/template/board/SUP_Studio_studio2";
		} else if (NTT_ID.trim().equals("mypage")) {
			return "jsp/template/board/SUP_Mypage";
		} 
		
		else if (NTT_ID.trim().equals("reservrent")){
			return "jsp/template/board/reservrentDetail";
		} else if (NTT_ID.trim().equals("reservbus")){
			return "jsp/template/board/reservbusDetail";
		} else if (NTT_ID.trim().equals("reservedu")){
			return "jsp/template/board/reserveduDetail";
		}else if (NTT_ID.trim().equals("reservtrip") || NTT_ID.trim().equals("reservtripT")){
			return "jsp/template/board/reservtripDetail";
		}else if (NTT_ID.trim().equals("qna")){
			return "jsp/template/board/SUP_Mypage_Qna";
		}
		
		
		else if (NTT_ID.trim().equals("gallery")) {
			return "jsp/template/board/galleryDetail";
		} else if (NTT_ID.trim().equals("material")) {
			return "jsp/template/board/materialDetail";
		}

		else if(NTT_ID.trim().equals("freeboard") && BBS_ID.trim().equals("insert")){
			return "jsp/template/board/boardInsert";
		} else if (NTT_ID.trim().equals("story")||NTT_ID.trim().equals("notice") || NTT_ID.trim().equals("news") || NTT_ID.trim().equals("reference")
				 || NTT_ID.trim().equals("freeboard")) {
			return "jsp/template/board/cmmUserDetail";
		} else {
			return "잘못된접근입니다.";
		}
	}

	@RequestMapping(value = "/book.do")
	public String book(@ModelAttribute BoardVO vo, @RequestParam("type") String NTT_ID, HttpServletRequest request,ModelMap model) {
		vo.setNTT_ID(NTT_ID.trim());
		List<BoardVO> list = interUserService.boardSelect(vo);
		
		BoardVO review = new BoardVO();
		review.setNTT_ID("review");
		List<BoardVO> reviewlist = interUserService.boardSelect(review);
		
		
		

		model.addAttribute("reviewlist", reviewlist);
		model.addAttribute("list", list);
		model.addAttribute("vo", vo);

		
		String type = "";
		switch (NTT_ID) {
		case "rent":
			type = "대관예약";
			break;
		case "edu":
			type = "교육예약";
			break;
		case "trip":
			type = "현장학습예약";
			break;
		}
		model.addAttribute("type", type);
		
		if (NTT_ID.trim().equals("rent")) {
			model.addAttribute("rentlist", list);
			
			BoardVO reservRent = new BoardVO();
			reservRent.setNTT_ID("reservrent");
			List<BoardVO> reservRentList = interUserService.boardSelect(reservRent);
			
			model.addAttribute("reservRentList", reservRentList);
			
			return "jsp/template/book/SUP_Reservation_Rent";
		} else if (NTT_ID.trim().equals("edu")) {
			return "jsp/template/book/SUP_Reservation_Education";
		} else if (NTT_ID.trim().equals("trip")) {
			return "jsp/template/book/SUP_Reservation_Learning_1";
		} else if (NTT_ID.trim().equals("rent_weekly")) {
			return "jsp/template/book/SUP_rent_weekly";
		}

		return "";
	}
	@RequestMapping(value="/mvpage.do")
	public String mbpage(@RequestParam("NTT_ID") String NTT_ID, HttpServletRequest request, ModelMap model) {
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		
		model.addAttribute("lvo", lvo);
		model.addAttribute("NTT_ID", NTT_ID);
		String type = "";

		BoardVO bvo = new BoardVO();
		List<BoardVO> list = null;
		if(NTT_ID.trim().indexOf("trip") != -1){
			bvo.setNTT_ID("trip");
			list = interUserService.boardSelect(bvo);
			model.addAttribute("list",list);
		}
		switch (NTT_ID) {
		case "tripT":
			type = "현장학습예약";
			break;
		}
		model.addAttribute("type", type);
		 if (NTT_ID.trim().equals("tripT")) {
			return "jsp/template/book/SUP_Reservation_Learning_4";
		}else{
			return "/";
		}
	}
	@RequestMapping(value="/tripsole.do")
	public String tripsole(@RequestParam("NTT_ID") String NTT_ID,@RequestParam("BBS_ID") String BBS_ID,@RequestParam("time") String time, HttpServletRequest request, ModelMap model) {
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		model.addAttribute("lvo", lvo);
		model.addAttribute("NTT_ID", NTT_ID);
		
		BoardVO bvo = new BoardVO();
		bvo.setNTT_ID("NTT_ID");
		bvo.setBBS_ID(BBS_ID);
		bvo=interUserService.boardSelectOne(bvo);
		bvo.setFTIME(time);
		model.addAttribute("vo",bvo);
		
		
		if (NTT_ID.trim().equals("trip")) {
			return "jsp/template/book/SUP_Reservation_Learning_3";
		}else{
			return "/";
		}
	}

	@RequestMapping(value = "/bookinsert.do")
	public String bookinsert(@RequestParam("NTT_ID") String NTT_ID, @RequestParam("BBS_ID") String BBS_ID,
			HttpServletRequest request, ModelMap model) {
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		
		BoardVO bvo = new BoardVO();
		bvo.setNTT_ID(NTT_ID.trim());
		bvo.setBBS_ID(BBS_ID.trim());
		
		
		List<BoardVO> list = interUserService.boardSelect(bvo);
		if(!bvo.getBBS_ID().trim().equals("")||bvo.getBBS_ID()!=null){
			BoardVO vo = interUserService.boardSelectOne(bvo);	
			model.addAttribute("vo", vo);	 
		}

		model.addAttribute("list", list);
		model.addAttribute("lvo", lvo);
		String type = "";
		switch (NTT_ID) {
		case "rent":
			type = "대관예약";
			break;
		case "edu":
			type = "교육예약";
			break;
		case "tripS1":
			type = "현장학습예약";
			break;
		case "tripS2":
			type = "현장학습예약";
			break;
		case "tripT":
			type = "현장학습예약";
			break;
		case "bus":
			type = "셔틀버스예약";
			break;
		}
		
		model.addAttribute("type", type);
		model.addAttribute("NTT_ID", NTT_ID);

		if (NTT_ID.trim().equals("rent")) {
			return "jsp/template/book/SUP_Reservation_Rent3";
		} else if (NTT_ID.trim().equals("edu")) {
			return "jsp/template/book/SUP_Reservation_Education2";
		} else if (NTT_ID.trim().equals("bus")) {
			
			//승인건 추가
			bvo.setNTT_ID("reservbus");
			
			List<BoardVO> rvo = interUserService.boardSelectOnList(bvo);	
			model.addAttribute("rvo", rvo);	 
			
			return "jsp/template/book/SUP_Reservation_Bus";
		} else if (NTT_ID.trim().equals("tripS1")) {
			return "jsp/template/book/SUP_Reservation_Learning_2";
		} else if (NTT_ID.trim().equals("tripS2")) {
			return "jsp/template/book/SUP_Reservation_Learning_3";
		} else if (NTT_ID.trim().equals("tripT")) {
			return "jsp/template/book/SUP_Reservation_Learning_4";
		}
		return "";
	}

	@RequestMapping(value = "/bookinsert2.do")
	public String bookinsert2(@ModelAttribute("frm") BoardVO bvo, HttpServletRequest request, ModelMap model) {
		System.out.println(bvo.toString());
		
		String type = bvo.getNTT_ID();
		String reserv = "reserv"+type;
		if(!bvo.getNTT_ID().trim().equals("review")){
			bvo.setNTT_ID(reserv);
		}else{
			bvo.setNTT_ID(type);
		}
		int result = interUserService.boardinsert(bvo);
		
		if(result!=1){
			return "404";
		}else{
			return "redirect:/mypage.do";		
		}
	}

	@RequestMapping(value = "/board.do")
	public String board(@RequestParam("type") String NTT_ID, ModelMap model, HttpServletRequest request) {
		BoardVO vo = new BoardVO();
		vo.setNTT_ID(NTT_ID.trim());
		List<BoardVO> list = egovUserService.boardSelect(vo);
		
		model.addAttribute("list", list);

		String type = "";
		String root = "";
		
		switch (NTT_ID) {
		case "move":
			type = "입주시설임대";
			root = "홈,주요사업,입주시설임대";
			break;
		case "story":
			type = "스토리";
			root = "홈,커뮤니티,스토리";
			break;
		case "notice":
			type = "공지사항";
			root = "홈,커뮤니티,공지사항";
			break;
		case "news":
			type = "보도자료";
			root = "홈,커뮤니티,보도자료";
			break;
		case "reference":
			type = "자료실";
			root = "홈,커뮤니티,자료실";
			break;
		case "customer":
			type = "고객센터";
			root = "홈,커뮤니티,고객센터";
			break;
		case "freeboard":
			type = "자유게시판";
			root = "홈,커뮤니티,자유게시판";
			break;
		case "gallery":
			type="갤러리";
			root = "홈,커뮤니티,갤러리";
			break;
		case "material":
			type="소재이야기";
			root = "홈,커뮤니티,소재이야기";
			break;
		}
		model.addAttribute("type", type);
		model.addAttribute("root", root);
		model.addAttribute("NTT_ID", NTT_ID);

		if (NTT_ID.trim().equals("move")) {
			return "jsp/template/board/SUP_Studio_studio";
		} else if (NTT_ID.trim().equals("story")) {
			return "jsp/template/board/SUP_Studio_studio";
		} else if (NTT_ID.trim().equals("notice")) {
			return "jsp/template/board/cmmUserList";
		} else if (NTT_ID.trim().equals("news")) {
			return "jsp/template/board/cmmUserList";
		} else if (NTT_ID.trim().equals("reference")) {
			return "jsp/template/board/cmmUserList";
		} else if (NTT_ID.trim().equals("freeboard")) {
			return "jsp/template/board/cmmUserList";
		} else if (NTT_ID.trim().equals("gallery")) {
			return "jsp/template/board/galleryList";
		} else if (NTT_ID.trim().equals("material")) {
			return "jsp/template/board/materialList";
		} else if (NTT_ID.trim().equals("")) {
			return "";
		} else {
			return "잘못된접근입니다.";
		}
	}

	@RequestMapping(value = "/boardinsert.do")
	public String boardinsert(@ModelAttribute("frm") BoardVO bvo, ModelMap model, HttpServletRequest request) {
		String type = bvo.getNTT_ID();

		int result = interUserService.boardinsert(bvo);
		if (result == 1) {
			if (type.trim().equals("move")) {
				return "jsp/template/board/SUP_Studio_studio";
			} else if (type.trim().equals("notice")) {
				return "jsp/template/board/cmmUserList";
			} else if (type.trim().equals("news")) {
				return "jsp/template/board/cmmUserList";
			} else if (type.trim().equals("referenc")) {
				return "jsp/template/board/cmmUserList";
			} else if (type.trim().equals("qna")) {
				return "redirect:/customer.do";
			} else {
				return "잘못된접근입니다.";
			}
		} else {
			return "잘못된접근입니다.";
		}
	}

	

	@RequestMapping(value = "/customer.do")
	public String customer(HttpServletRequest request, ModelMap model) {
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		BoardVO bvo = new BoardVO();
		bvo.setNTT_ID("faq");
		List<BoardVO> list = interUserService.boardSelect(bvo);

		model.addAttribute("list", list);
		model.addAttribute("lvo", lvo);
		model.addAttribute("NTT_ID", bvo.getNTT_ID());

		return "jsp/template/board/SUP_Community_Qna";
	}

	public String sysdate(){
		String sysdate = egovUserService.sysdate();
		return sysdate;
	}

	@RequestMapping(value = "/ajaxSelect.do",method=RequestMethod.GET,produces = "application/text; charset=utf8")
	@ResponseBody
	public String ajaxSelect(@RequestParam("BBS_ID") String BBS_ID,HttpServletResponse response){
		System.out.println(BBS_ID);
		BoardVO bvo = new BoardVO();
		bvo.setBBS_ID(BBS_ID);

		response.setCharacterEncoding("UTF8");
		response.setContentType("application/json");
		
		bvo = egovUserService.boardSelectOne(bvo);
		
		System.out.println(bvo.toString());
		String json = new Gson().toJson(bvo);
		System.out.println(json);
		
		return json;
	}
	
	@RequestMapping(value = "/search.do")
	public String search(@RequestParam("word") String word,ModelMap model){
		List<BoardVO> list = egovUserService.boardSearch(word);
		
		model.addAttribute("word",word);
		model.addAttribute("list",list);
		
		
		return "jsp/template/board/search";
	}
}
