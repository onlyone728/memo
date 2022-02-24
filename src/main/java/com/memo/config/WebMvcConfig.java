package com.memo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	/**
	 * 웹의 이미지 주소와 실제 파일 경로를 매핑해주는 설정
	 */
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry
		.addResourceHandler("/images/**")		// http://localhost:8080/images/onlyone728_173943/sun.png
		.addResourceLocations("file:/Users/janghana/Desktop/java/megait/6_spring-project/memo/workspace/images/");		// 실제 파일 저장위치
	}
}
