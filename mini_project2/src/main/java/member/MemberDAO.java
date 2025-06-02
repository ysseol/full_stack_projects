package member;

import org.apache.ibatis.session.SqlSession;

import sqlmap.MybatisManager;

public class MemberDAO {
	
	public int loginMember(MemberDTO dto) {

		int result = 0;
		
        SqlSession session = MybatisManager.getInstance().openSession();
        String sql = session.selectOne("member.login_member", dto);
        
        if (sql != null) {
			result = 1;
		}
        
        session.close();
        return result;
    }
	
	public void insertMember(MemberDTO dto) {
		
        SqlSession session = MybatisManager.getInstance().openSession();
        session.insert("member.insert_member", dto);
        session.commit();
        session.close();
        
    }
	
	public int checkMember(MemberDTO dto) {
		
		int result = 0;
		
		SqlSession session = MybatisManager.getInstance().openSession();
		String sql = session.selectOne("member.check_member", dto);
		
		if (sql != null) {
			int count = Integer.parseInt(sql);
			
			if (count == 0) {
				result = 1;
			}
		}
		
		return result;
	}
	
}
