

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@SuppressWarnings("serial")
public class UserServlet extends HttpServlet {
	UserDao ud = new UserDaoImpl();
	ClassesDao cd = new ClassesDaoImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String type = request.getParameter("type");
		String action = request.getParameter("action");
		if (type.equals("all")) {
			doAll(request, response);
		} else if (type.equals("del")) {
			doDel(request, response);
		} else if (type.equals("upd")) {
			doUpd(request, response);
		} else if (type.equals("add")) {
			doAdd(request, response);
		}else if(type.equals("firebase")) {
			
			//firebase(request, response);			
			if(action.equals("welcome")) {	
				//type 이 firebase 이고 action 파라미터가 welcome 일경우 첫페이지 로그인 화면으로 이도으		
				welcome(request, response);	
			}else if(action.equals("joinform")) {
				//회원 가입폼으로 이동
				joinForm(request, response);
			}else if(action.equals("join")) {
				//회원 가입  으로 ajax 처리
				join(request, response);
			}			
		}else if(type.equals("logout")) {
			logout(request, response);
		}
		
	}

	//데이터 등록 삽입 메서드
	public void doAdd(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
			String name=request.getParameter("name"); // name 파리이터 값 가져오기
			String sex=request.getParameter("sex");   // sex 파라미터 값 가져오기
			String email=request.getParameter("email"); // email 파라미터 값 가져오기
			String clsId=request.getParameter("clsId"); // clsId 파라미터 값 가져오기
			
		if(name!=null && sex!=null && email!=null && clsId!=null) {
			//name, sex, email, clsId 파라미터값 모두가 null 이 아닌경우 insert.jsp 에서 값을 입력해 온것이기 때문에
			// DB 에 데이터를 삽입한다.
			System.out.println("name : " +name + " sex : " + sex + " : " + " email : " +email +"   clsId: " +clsId );
			
			//1.User 개체에 데이터를 넣는다.
			User u=new User();
			u.setName(name);
			u.setGender(sex);
			u.setEmail(email);
			u.setClsId(Integer.parseInt(clsId)); //String 타입의 id 를 int 타입으로 형변환 시킨다.
			
			//2. DB에 데이터를 삽입한다.
			Integer result=ud.add(u);	
			if(result==1) {
				//성공시 1
								
				//2. redirect 방식으로 목록화면으로 이동한다. 
				//데이터베이스  삽이과 업데이트 후에는 redirect 방식으로 이동해한다. 
				//foward 방식으로 이동할 경우 브라우저 새로고침을 했을 경우 같은 반복작업으로 DB 삽입과 업데이트 일어난다.
				response.sendRedirect("/UserServlet?type=all");
			}else {
				//실패시 0
				request.setAttribute("error", "데이터 등록에 실패 했습니다.");
				request.getRequestDispatcher("insert.jsp").forward(request, response);
			}
		}else {
			//name, sex, email, clsId 중 하나라도 널인 경우  insert.jsp 의 데이터 입력 폼으로 이동한다.			
			//1.select 에 사용하기 위해 DB의 classes 테이블  정보를 불러온다.
			List<Classes>  clsList=cd.all();			
			//2.clsList 의 이름으로 clsList 객체를 담는다.
			request.setAttribute("clsList", clsList); 			
			//3.insert.jsp forward 방식으로 이동
			request.getRequestDispatcher("insert.jsp").forward(request, response);						
		}
	}
	
	//업데이트 메서드
	public void doUpd(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//type=upd&stop=a&id=${u.id}
		String stop=request.getParameter("stop");
		String id=request.getParameter("id");

		//a 이면 get  방식으로 온 경우로 업데이트 폼으로 이동한다.
		if(stop!=null) {	
			if(stop.equals("a")) {
				//1.회원 정보를 불러온다.
				User user=ud.ById(Integer.parseInt(id));
				request.setAttribute("u", user);	
				
				//2.클래스 정보를 불러온다.
				List<Classes> clsList=cd.all();
				request.setAttribute("clsList", clsList);	
				
				request.getRequestDispatcher("update.jsp").forward(request, response);
			}
			
		}else {			
			String name=request.getParameter("name"); // name 파리이터 값 가져오기
			String sex=request.getParameter("sex");   // sex 파라미터 값 가져오기
			String email=request.getParameter("email"); // email 파라미터 값 가져오기
			String clsId=request.getParameter("clsId"); // clsId 파라미터 값 가져오기
			
			//1.User 개체에 데이터를 넣는다.
			User u=new User();
			u.setId(Integer.parseInt(id));
			u.setName(name);
			u.setGender(sex);
			u.setEmail(email);
			u.setClsId(Integer.parseInt(clsId)); //String 타입의 id 를 int 타입으로 형변환 시킨다.
			System.out.println(" 업데이트  : " + u.toString());
			//업데이트
			ud.upd(u);
			response.sendRedirect("/UserServlet?type=all");
		}
		

	}

	//삭제처리 메서드
	public void doDel(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			//id 파라미타 값을 받는다.
			String id =request.getParameter("id");			
			//삭제 
			ud.del(Integer.parseInt(id));
			//리다이렉트로 이동 			
			response.sendRedirect("/UserServlet?type=all");
	}

	public void doAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int index = 1;
		String strs = request.getParameter("index");
		if (strs != null) {
			index = Integer.parseInt(strs);
		}
		PageUtil<User> page = new PageUtil<User>();
		page.setIndex(index);
		ud.selectAll(page);
		
		request.setAttribute("page", page);
		request.setAttribute("index", page.getIndex());
		request.setAttribute("sum", page.pageCount(page.getCount(), page
				.getSize()));
		
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
	
	
	
	//메인 첫페이지 로그인 페이지도 이동하는 메서드
	public void welcome(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{		
		request.getRequestDispatcher("welcome.jsp").forward(request, response);
	}
	
	//로그 아웃 처리 메서드
	public void logout(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{		
		// Request로부터 세션을 받는다.
		HttpSession session=request.getSession();
		//세션 정보 삭제
		session.invalidate();
		response.sendRedirect("/");
	}
	
	//회원 가입 폼으로 이동하는 메서드
	public void joinForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{	
		//1.select 에 사용하기 위해 DB의 classes 테이블  정보를 불러온다.
		List<Classes>  clsList=cd.all();			
		//2.clsList 의 이름으로 clsList 객체를 담는다.
		request.setAttribute("clsList", clsList);
		request.getRequestDispatcher("JoinUs.jsp").forward(request, response);
		
	}
	
	
	//회원 가입 메서드 ajax 데이터 받음
	public void join(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{	
		String fireBaseId=request.getParameter("fireBaseId");
		String name=request.getParameter("name"); // name 파리이터 값 가져오기
		String sex=request.getParameter("sex");   // sex 파라미터 값 가져오기
		String email=request.getParameter("email"); // email 파라미터 값 가져오기
		String clsId=request.getParameter("clsId"); // clsId 파라미터 값 가져오기
		String pw=request.getParameter("pw"); // clsId 파라미터 값 가져오기
		
		//1.User 개체에 데이터를 넣는다.
		User u=new User();
		u.setFireBaseId(fireBaseId);
		u.setName(name);
		u.setGender(sex);
		u.setEmail(email);
		u.setClsId(Integer.parseInt(clsId)); //String 타입의 id 를 int 타입으로 형변환 시킨다.
		u.setPw(pw);
		System.out.println(" 업데이트  : " + u.toString());
		
		//2. DB에 데이터를 삽입한다.
		Integer result=ud.add(u);
		
		PrintWriter out=response.getWriter();	
		if(result==1) { //성공시 1		
			out.print("success");
		}else { 			//실패시 
			out.print("fail");
		}
		
	}
	
	
	//firebase 메시지 전송으로 이동
	public void firebase(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{
		
		request.getRequestDispatcher("firebase.jsp").forward(request, response);
	}
	
}