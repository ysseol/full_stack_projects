package member;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import board.BoardDAO;
import board.BoardDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/member_servlet/*")
public class MemberController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURI();
		String path = request.getContextPath();
		MemberDAO dao = new MemberDAO();
		BoardDAO dao2 = new BoardDAO();
		
		if (url.indexOf("login.do") != -1) {
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			
			MemberDTO dto = new MemberDTO();
			
			dto.setUserid(userid);
			dto.setPwd(pwd);
			
			int result  = dao.login(dto);
			
			if (result == 1) {
				Map<String, Object> map = new HashMap<String, Object>();
				List<BoardDTO> list = dao2.list();
				
				map.put("list", list);
				map.put("count", list.size());
				
				request.setAttribute("map", map);
				String page = "/board/list.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
		    } else {
		    	request.setAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
		    	request.setAttribute("userid", userid);
		    	
		        String page = "/member/login.jsp";
		        RequestDispatcher rd = request.getRequestDispatcher(page);
		        rd.forward(request, response);
		    }
			
		} else if (url.indexOf("member.do") != -1) {
			
			String page = "/member/member.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		} else if (url.indexOf("register.do") != -1) {
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			
			MemberDTO dto1 = new MemberDTO();
			
			dto1.setUserid(userid);
			
			MemberDTO dto2 = new MemberDTO();
			
			dto2.setUserid(userid);
			dto2.setPwd(pwd);
			dto2.setName(name);
			
			int result = dao.check(dto1);
			
			if (result == 1) {
				dao.insert(dto2);
				
				request.setAttribute("message", "등록 되었습니다.");
				request.setAttribute("userid", userid);
				
				String page = "/member/login.jsp";
			    RequestDispatcher rd = request.getRequestDispatcher(page);
			    rd.forward(request, response);
			} else {
				request.setAttribute("message", "이미 사용중인 아이디입니다.");
				request.setAttribute("userid", userid);
				request.setAttribute("name", name);
				
				String page = "/member/member.jsp";
			    RequestDispatcher rd = request.getRequestDispatcher(page);
			    rd.forward(request, response);
			}
			
		} else if (url.indexOf("check.do") != -1) {
			
			String userid = request.getParameter("userid");
			
			MemberDTO dto = new MemberDTO();
			
			dto.setUserid(userid);
			
			int result = dao.check(dto);
			
			if (result == 1) {
				request.setAttribute("message", "사용가능한 아이디입니다.");
				String page = "/member/member.jsp";
			    RequestDispatcher rd = request.getRequestDispatcher(page);
			    rd.forward(request, response);
			} else {
				request.setAttribute("message", "이미 사용중인 아이디입니다.");
				String page = "/member/member.jsp";
			    RequestDispatcher rd = request.getRequestDispatcher(page);
			    rd.forward(request, response);
			}
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
