package util;

import org.hibernate.Hibernate;
import org.hibernate.dialect.function.SQLFunctionTemplate;

public class MySQLDialect extends org.hibernate.dialect.MySQLDialect {

	@SuppressWarnings("deprecation")
	public MySQLDialect() {
		// TODO Auto-generated constructor stub
		super();
		// register additional hibernate types for default use in scalar
		// sqlquery type auto detection
		//registerHibernateType(Types.LONGVARCHAR, Hibernate.TEXT.getName());//对应表中的列有 text类型的，数据库方言类型不一致导致问题
		registerFunction("regexp", new SQLFunctionTemplate(Hibernate.INTEGER, "?1 REGEXP ?2"));//?1代表第一个参数,?2代表第二个参数
	}

}
