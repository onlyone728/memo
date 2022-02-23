package com.memo.common;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component	// 스프링 빈
public class FileManagerService {
	
	// 일반적으로는 CDN 서버 (이미지, css, js)
	// 파일 저장될 폴더 설정
	public final static String FILE_UPLOAD_PATH = "/Users/janghana/Desktop/java/megait/6_spring-project/memo/workspace/images/";
	
	public String saveFile(String userLoginId, MultipartFile file) {
		
		// 파일 디렉토리 경로 예 : onlyone728_173943/sun.png
		// 파일명이 겹치지 않게 하기 위해 현재시간을 경로에 붙여준다.
		String directoryName = userLoginId + "_" + System.currentTimeMillis() + "/";
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		
	}
}
