package com.memo.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

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
		
		// 디렉토리 생성
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			// 디렉토리 생성 실패 시 null 리턴
			return null;
		}
		
		// 파일 업로드 : byte 단위로 업로드 한다.
		try {
			byte[] bytes = file.getBytes();
			// getOriginalFilename()는 input에서 올린 파일명 (한글 X)
			Path path = Paths.get(filePath + file.getOriginalFilename());
			Files.write(path, bytes);
			
			// 이미지 URL을 리턴한다. (WebMvcConfig에서 매핑한 이미지 path)
			// 예) http://localhost:8080/images/onlyone728_173943/sun.png
			return "/images/" + directoryName + file.getOriginalFilename();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	// 이미지 삭제
	public void deleteFile(String imagePath) {
		// imagePath의 /images/onlyone728_173943/sun.png에서 /images/ 를 제거한 path를 실제 저장경로 뒤에 붙인다.
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
		if (Files.exists(path)) {	// 이미지 파일이 있으면 삭제
			try {
				Files.delete(path);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		// 디렉토리(폴더) 삭제
		path = path.getParent();
		if (Files.exists(path)) {
			try {
				Files.delete(path);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
