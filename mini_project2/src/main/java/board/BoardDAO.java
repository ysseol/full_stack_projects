package board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import sqlmap.MybatisManager;

public class BoardDAO {
	
	public List<BoardDTO> listBoard() {
        SqlSession session = MybatisManager.getInstance().openSession();
        List<BoardDTO> list = session.selectList("board.list_board");
        session.close();
        return list;
    }
	
	public void insertBoard(BoardDTO dto) {
        SqlSession session = MybatisManager.getInstance().openSession();
        session.insert("board.insert_board", dto);
        session.commit();
        session.close();
    }
	
	public BoardDTO detailBoard(BoardDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		BoardDTO dto2 = session.selectOne("board.detail_board", dto);
		dto2.setNum(dto.getNum());
		session.close();
        return dto2;
	}
	
	public void updateBoard(BoardDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
        session.update("board.update_board", dto);
        session.commit();
        session.close();
	}
	
	public void deleteBoard(String id) {
		SqlSession session = MybatisManager.getInstance().openSession();
        session.delete("board.delete_board", id);
        session.commit();
        session.close();
	}
	
}
