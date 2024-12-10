package com.solfany.jspLibraryMail.composeMail.controller;

import org.springframework.context.annotation.Description;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ComposeMailController {
  // @Autowired
  // ComposeMailService composeMailService;

  @Description("메일발송 페이지")
  @GetMapping("/mail")
  public String composeMailPage() {
    return "composeMail";
  }
}
