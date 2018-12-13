

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;

public class UserDaoImpl implements UserDao {

	public void selectAll(PageUtil<User> page) {
		SqlSession session = MySqlSession.getSession();
		//r
		Integer num1Max=session.selectOne("UserInfo.num1Max");
		Integer num2Min=session.selectOne("UserInfo.num2Min");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(num2Min>1) {
			map.put("num1", num1Max);
			map.put("num2", num2Min-1);
		}else {
		
			if(page.getSize() < num1Max) {
				map.put("num1", num1Max);
			}else {
				map.put("num1", page.getIndex() * page.getSize());
			}
			map.put("num2", (page.getIndex() - 1) * page.getSize());		
		}
		
		List<User> list = session.selectList("UserInfo.all", map);
		page.setCount((Integer) session.selectOne("UserInfo.count"));
		page.setList(list);
		MySqlSession.closeSession();
	}

	public int del(int id) {
		//1.DB 접속할 mybaits 의 sqlSession 불러온다. - open
		SqlSession session = MySqlSession.getSession();
		//2.DB 삭제 처리
		session.delete("UserInfo.del" , id);
		//3. 커밋을 한다.
		session.commit();		
		//4. sqlSession 닫는다.  - close
		MySqlSession.closeSession();
		return 1;
	}

	public User ById(int id) {
		//1.DB 접속할 mybaits 의 sqlSession 불러온다. - open
		SqlSession session = MySqlSession.getSession();
		//2.User.xml 파일의  UserInfo.ById  를 찾아  User 객체를 넣는다. 
		User user =session.selectOne("UserInfo.ById", id);		
		return user;
	}

	
	public int upd(User u) {
		try {
			//1.DB 접속할 mybaits 의 sqlSession 불러온다. - open
			SqlSession session = MySqlSession.getSession();
			
			//2.User.xml 파일의  UserInfo.upd  를 찾아  User 객체를 넣는다. 			
			session.insert("UserInfo.upd", u);
			
			//3. 커밋을 한다.
			session.commit();
			//4. sqlSession 닫는다.  - close
			MySqlSession.closeSession();	
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

	
	
	
	public int add(User u) {
		try {			
			//1.DB 접속할 mybaits 의 sqlSession 불러온다. - open
			SqlSession session = MySqlSession.getSession();
			System.out.println(" u  :  "+ u.toString());
						
			//2.User.xml 파일의  UserInfo.all  를 찾아  User 객체를 넣는다. 			
			session.insert("UserInfo.add", u);
			
			//3. 커밋을 한다.
			session.commit();
			//4. sqlSession 닫는다.  - close
			MySqlSession.closeSession();				
			return 1;
		}catch(Exception  e) {
			e.printStackTrace();
			return 0;
		}
		
	}
}
