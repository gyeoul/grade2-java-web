package ml.dyweb;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;

public class DBCP {
    Context context = new InitialContext();
    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/oracle");
    Connection con = dataSource.getConnection();

    public DBCP() throws NamingException, SQLException {

    }
}
