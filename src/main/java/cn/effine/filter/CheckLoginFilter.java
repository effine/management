package cn.effine.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckLoginFilter implements Filter {

	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)resp;
		HttpSession session = request.getSession(false);
		if("/".equals(request.getRequestURI()) || "/servlet/login".equals(request.getRequestURI()) || (session!=null && session.getAttribute("user")!=null)){
			chain.doFilter(request, response);
		}else{
			response.sendRedirect("/login");
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

}
