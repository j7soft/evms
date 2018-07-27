package egovframework.com.cmm;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.imgscalr.Scalr;
import org.springframework.web.multipart.MultipartFile;

public class FileUploadUtil {
	static Logger logger = Logger.getLogger(FileUploadUtil.class);
	
	public static BoardVO fileUpload(BoardVO bvo, HttpServletRequest request) throws Exception{
		if(bvo.getFile()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile(), request, "file",bvo.getNTT_NO()+"F");
			bvo.setFFILE(fileName);
		}
		if(bvo.getMfile()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getMfile(), request, "file",bvo.getNTT_NO()+"M");
			bvo.setIMAGE(fileName);
		}	
		if(bvo.getLfile()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getLfile(), request, "file",bvo.getNTT_NO()+"L");
			bvo.setLOGO(fileName);
		}	
		if(bvo.getFile1()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile1(), request, "file",bvo.getNTT_NO()+"_1");
			bvo.setITEM_IMAGE(fileName);
		}	
		if(bvo.getFile2()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile2(), request, "file",bvo.getNTT_NO()+"_2");
			bvo.setITEM_IMAGE(bvo.getITEM_IMAGE()+";"+fileName);
		}	
		if(bvo.getFile3()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile3(), request, "file",bvo.getNTT_NO()+"_3");
			bvo.setITEM_IMAGE(bvo.getITEM_IMAGE()+";"+fileName);
		}	
		if(bvo.getFile4()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile4(), request, "file",bvo.getNTT_NO()+"_4");
			bvo.setITEM_IMAGE(bvo.getITEM_IMAGE()+";"+fileName);
		}	
		if(bvo.getFile5()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile5(), request, "file",bvo.getNTT_NO()+"_5");
			bvo.setITEM_IMAGE(bvo.getITEM_IMAGE()+";"+fileName);
		}	
		if(bvo.getFile6()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile6(), request, "file",bvo.getNTT_NO()+"_6");
			bvo.setITEM_IMAGE(bvo.getITEM_IMAGE()+";"+fileName);
		}	
		if(bvo.getFile7()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile7(), request, "file",bvo.getNTT_NO()+"_7");
			bvo.setITEM_IMAGE(bvo.getITEM_IMAGE()+";"+fileName);
		}	
		if(bvo.getFile8()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile8(), request, "file",bvo.getNTT_NO()+"_8");
			bvo.setITEM_IMAGE(bvo.getITEM_IMAGE()+";"+fileName);
		}	
		if(bvo.getFile9()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile9(), request, "file",bvo.getNTT_NO()+"_9");
			bvo.setITEM_IMAGE(bvo.getITEM_IMAGE()+";"+fileName);
		}	
		if(bvo.getFile10()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile10(), request, "file",bvo.getNTT_NO()+"_10");
			bvo.setITEM_IMAGE(bvo.getITEM_IMAGE()+";"+fileName);
		}	
		if(bvo.getFile11()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile11(), request, "file",bvo.getNTT_NO()+"_11");
			bvo.setITEM_IMAGE(bvo.getITEM_IMAGE()+";"+fileName);
		}	
		if(bvo.getFile12()!=null){
			String fileName = FileUploadUtil.fileUpload(bvo.getFile12(), request, "file",bvo.getNTT_NO()+"_12");
			bvo.setITEM_IMAGE(bvo.getITEM_IMAGE()+";"+fileName);
		}	
		
		
		
		
		
		
		
		return bvo;
	}
	
	
	/* 파일 업로드할 폴더 생성 */
	public static void makeDir(String docRoot){
		File fileDir = new File(docRoot);
		if(fileDir.exists()){
			return;
		}
		//mkdir은 두개폴더는 생성이 안되니 s를 붙혀준다
		fileDir.mkdirs();
	}
	
	/* 파일 업로드 메서드 */
	public static String fileUpload(MultipartFile file, HttpServletRequest request, String fileName,String fname)
		throws IOException{
		logger.info("fileUpload 호출 성공");
		
		String real_name = null;
		
		//MultipartFile 클래스의 getFile()
		//메서드로 클라이언트가 업로드한 파일(오리지날 이름)
		String org_name = file.getOriginalFilename();
		logger.info("org_name : " + org_name);
		
		//파일명 변경(중복되지 않게)
		if(org_name != null &&(!org_name.equals(""))){
			real_name = fileName + "_"  + fname + org_name.substring(org_name.lastIndexOf("."),org_name.length()); //저장할 파일
			
			String docRoot = request.getSession().getServletContext().getRealPath("/uploadStorage/" + fileName);
			makeDir(docRoot);
			
			File fileAdd = new File(docRoot + "/" + real_name); //파일 생성후
			logger.info("업로드할 파일(fileAdd) : " + fileAdd);
			System.out.println(fileAdd.getPath());
			file.transferTo(fileAdd);
		}
		return real_name;
		
	}
	
	public static void fileDelete(String fileName, HttpServletRequest request) throws IOException{
		logger.info("fileDelete 호출 성공");
		boolean result = false;
		String dirName = fileName.substring(0,fileName.indexOf("_"));
		String docRoot = request.getSession().getServletContext().getRealPath("/uploadStorage/" +dirName);
		
		File fileDelete = new File(docRoot + "/" +fileName); //파일 생성후
		System.out.println(fileDelete);
		if(fileDelete.exists() && fileDelete.isFile()){
			result = fileDelete.delete();
		}
		logger.info("파일 삭제 여부(true/false) : " + result);
	}
	
	public static String makeThumbnail(String fileName, HttpServletRequest request) throws Exception{
		String dirName = fileName.substring(0, fileName.indexOf("_"));//이미지가 존재하는 폴더 추출
		
		//추출된 폴더의 실제 경로 (물리적 위치 : C:\...)
		String imgPath = request.getSession().getServletContext().getRealPath("/uploadStorage/" + dirName);
		
		File fileAdd = new File(imgPath, fileName);
		logger.info("원본 이미지 파일(fileAdd) : " + fileAdd);
		
		BufferedImage sourceImg = ImageIO.read(fileAdd);
		BufferedImage destImg = Scalr.resize(sourceImg,Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,133);
		//resize(대상[BufferedImage 타입], 원본비율, 높이 또는 너비,크기)
		
		
		String thumbnailName = "thumbnail_"+ fileName;
		//썸네일 파일명 지정
		String docRoot = imgPath+ "/thumbnail";
		makeDir(docRoot);
		//썸네일을 저장할 경로 지정 및 생성
		File newFile = new File(docRoot, thumbnailName);
		logger.info("업로드할 파일(newFile)");
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		 // 파일명에서 마지막 .의 위치로 확장자 추출
	    logger.info("확장자(formatName) : " + formatName);
	      
	    ImageIO.write(destImg,  formatName, newFile);
		System.out.println(formatName.toString());
		System.out.println(newFile.toString());
		System.out.println(docRoot.toString());
	    return thumbnailName;

		
	}

}
