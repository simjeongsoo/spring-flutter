package com.sim.flutterspring.jwt;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class JwtAccessDeniedHandler implements AccessDeniedHandler {
    //--필요한 권한이 존재하지 않는 경우에 403 Forbidden 에러를 리턴하기위한 클래스--//

    @Override
    public void handle(HttpServletRequest request,
                       HttpServletResponse response,
                       AccessDeniedException accessDeniedException) throws IOException, ServletException {
        // 403 error return
        response.sendError(HttpServletResponse.SC_FORBIDDEN);
    }
}
