package com.solfany.jspLibraryMail.composeMail.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@Controller
@Api(tags = "Mail API") // API 그룹명
public class ComposeMailController {

  /**
   * 메일 작성 페이지로 이동합니다.
   * 
   * @return composeMail.jsp 페이지
   */
  @ApiOperation(value = "메일 작성 페이지", notes = "메일 작성 화면으로 이동합니다.")
  @GetMapping("/")
  public String composeMailPage() {
    return "composeMail";
  }

  /**
   * 메일 발송 API
   * 
   * @param emailAddress 받는 사람 이메일 주소
   * @param referenceEmailAddress 참조 이메일 주소 (옵션)
   * @param emailTitle 메일 제목
   * @param emailContent 메일 본문
   * @param files 첨부 파일 배열 (옵션)
   * @return 메일 발송 결과 메시지
   */
  @ApiOperation(value = "메일 발송", notes = "메일 발송 API를 호출합니다.")
  @PostMapping(value = "/sendMail", consumes = "multipart/form-data")
  public ResponseEntity<?> composeMailSend(@RequestParam("emailAddress") String emailAddress,
      @RequestParam(value = "referenceEmailAddress", required = false) String referenceEmailAddress,
      @RequestParam("emailTitle") String emailTitle,
      @RequestParam("emailContent") String emailContent,
      @RequestParam(value = "files", required = false) MultipartFile[] files) {
    try {
      // 로그 출력
      System.out.println("받는 사람: " + emailAddress);
      System.out.println("참조 메일: " + referenceEmailAddress);
      System.out.println("메일 제목: " + emailTitle);
      System.out.println("메일 본문: " + emailContent);

      // 첨부파일 처리
      if (files != null && files.length > 0) {
        for (MultipartFile file : files) {
          System.out.println("첨부 파일: " + file.getOriginalFilename());
        }
      } else {
        System.out.println("첨부 파일 없음");
      }

      // TODO: 메일 발송 로직 추가
      // composeMailService.sendMail(emailAddress, referenceEmailAddress, emailTitle, emailContent,
      // files);

      return ResponseEntity.ok("메일 발송 성공");
    } catch (Exception e) {
      // 에러 로그 출력
      e.printStackTrace();
      return ResponseEntity.status(500).body("메일 발송 실패: " + e.getMessage());
    }
  }
}
