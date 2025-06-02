package board;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
public class BoardDTO {
	private int num;
	private String id;
	private String title;
	private String content;
	private String reg_date;
}
