package com.sim.flutterspring.controller;

import com.sim.flutterspring.model.UserDto;
import com.sim.flutterspring.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@CrossOrigin
@RestController
@RequestMapping("/api")
public class UserController {
    //--회원가입 api, 유저 조회 api--//

    Logger logger = LoggerFactory.getLogger(UserController.class);

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/signup")
    public ResponseEntity<UserDto> signup(@Valid @RequestBody UserDto userDto) {       // 회원가입 api
        //--UserDto를 파라미터로 받아 UserService의 signup() 메서드 호출--//

        return ResponseEntity.ok(userService.signup(userDto));
    }

    @GetMapping("/user")
    @PreAuthorize("hasAnyRole('USER','ADMIN')")
    public ResponseEntity<UserDto> getMyUserInfo() {                                   // User 정보 api
        //--@PreAuthorize 를 통해 USER, ADMIN 두가지 권한 모두 허용--//
        return ResponseEntity.ok(userService.getMyUserWithAuthorities());
    }

    @GetMapping("/user/{username}")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public ResponseEntity<UserDto> getUserInfo(@PathVariable String username) {
        //--ADMIN 권한만 호출할 수 있도록 설정
        // UserService 에서 구현한 username 파라미터를 기준으로 유저 정보와 권한 정보를 리턴하는 api--//
        return ResponseEntity.ok(userService.getUserWithAuthorities(username));
    }

}
