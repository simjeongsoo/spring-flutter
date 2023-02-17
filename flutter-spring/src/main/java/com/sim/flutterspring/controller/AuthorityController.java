package com.sim.flutterspring.controller;

import com.sim.flutterspring.entity.User;
import com.sim.flutterspring.jwt.JwtFilter;
import com.sim.flutterspring.jwt.TokenProvider;
import com.sim.flutterspring.model.AuthorityDto;
import com.sim.flutterspring.model.LoginDto;
import com.sim.flutterspring.repository.AuthorityRepository;
import com.sim.flutterspring.repository.UserRepository;
import com.sim.flutterspring.service.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@RestController
@RequestMapping("/api")
public class AuthorityController {
    private final TokenProvider tokenProvider;
    private final JwtFilter jwtFilter;

    @Autowired
    public AuthorityController(TokenProvider tokenProvider, JwtFilter jwtFilter) {
        this.tokenProvider = tokenProvider;
        this.jwtFilter = jwtFilter;
    }

    @PostMapping("/userauthenticationcheck")
    public ResponseEntity<Authentication> signin(@Valid @RequestBody LoginDto loginDto, HttpServletRequest request) {       // 사용자 인증 정보
//        Authentication authenticationClient = authenticationManagerBuilder.getObject().authenticate(token);

        String token = jwtFilter.resolveToken(request); // client에서 받아온 헤더에 담긴 토큰
        Authentication authenticationClient = tokenProvider.getAuthentication(token); // 토큰 정보로 사용자 권한 체크
//        Authentication authenticationServer = SecurityContextHolder.getContext().getAuthentication();

        if (!authenticationClient.isAuthenticated()) {
            return null;
        }

        return ResponseEntity.ok(authenticationClient);
    }

    //    @GetMapping("/authority")
////    @PreAuthorize("hasAnyRole('USER','ADMIN')")
//    public AuthorityDto getMyUserInfo(String username) {
//        User user = userRepository.findOneWithAuthoritiesByUsername(username).orElse(null);
//
//        return ResponseEntity.ok(authorityRepository.findById(id).get());
//    }
}
