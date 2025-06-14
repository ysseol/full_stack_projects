package board;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/board_servlet/*")
public class BoardController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = request.getRequestURI();
		String path = request.getContextPath();
		BoardDAO dao = new BoardDAO();
		
		if (url.indexOf("list.do") != -1) {
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<BoardDTO> list = dao.listBoard();
			
			map.put("list", list);
			map.put("count", list.size());
			request.setAttribute("map", map);
			
			String page = "/board/list.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		} else if (url.indexOf("join.do") != -1) {
			
			UUID uuid = UUID.randomUUID();
			String id = uuid.toString();
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			BoardDTO dto = new BoardDTO();
			
			dto.setId(id);
			dto.setTitle(title);
			dto.setContent(content);
			
			dao.insertBoard(dto);
			response.sendRedirect(path + "/board_servlet/list.do");
			
		} else if (url.indexOf("view.do") != -1) {
			
			String id = request.getParameter("id");
			int num = Integer.parseInt(request.getParameter("num"));
			
			BoardDTO dto = new BoardDTO();
			
			dto.setId(id);
			dto.setNum(num);
			
			BoardDTO dto2 = dao.detailBoard(dto);
			request.setAttribute("dto", dto2);
			
			String page = "/board/view.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		} else if (url.indexOf("update.do") != -1) {
			
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			BoardDTO dto = new BoardDTO();
			dto.setId(id);
			dto.setTitle(title);
			dto.setContent(content);
			
			dao.updateBoard(dto);
			response.sendRedirect(path + "/board_servlet/list.do");
			
		} else if (url.indexOf("delete.do") != -1) {
			
			String id = request.getParameter("id");
			
			List<String> idList = Arrays.stream(id.split(",")).collect(Collectors.toList());
			
			for (String i : idList) {  
	            dao.deleteBoard(i);
	        }
			
			response.sendRedirect(path + "/board_servlet/list.do");
			
		} else if (url.indexOf("logout.do") != -1) {
			
			String page = "/member/login.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} 
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
}
