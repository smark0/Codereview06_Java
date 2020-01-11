package sample;

import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

public class TeacherDB {

    private Connection conn;
    private static final String teacherTable = "teacher";

    public TeacherDB()
            throws SQLException, ClassNotFoundException {

        // Class.forName("org.hsqldb.jdbc.JDBCDriver" );

        //STEP 2: Check if JDBC driver is available
        java.lang.Class.forName("com.mysql.cj.jdbc.Driver");
        //STEP 3: Open a connection
        System.out.println("Connecting to database...");
        conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cr06_steven_markhardt_school" +
                        "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
                "root",
                "");

        // we will use this connection to write to a file
        conn.setAutoCommit(true);
        conn.setReadOnly(false);
    }

    public void closeDB() throws SQLException {
        conn.close();
    }

    /**
     * Get all db records
     * @return
     * @throws SQLException
     */
    public List<Teacher> getAllRows()  throws SQLException {

        String sql = "SELECT * FROM " + teacherTable + " ORDER BY teacherName";
        PreparedStatement pstmnt = conn.prepareStatement(sql);
        ResultSet rs = pstmnt.executeQuery();
        List<Teacher> list = new ArrayList<>();

        while (rs.next()) {
            int i = rs.getInt("teacherID");
            String surname = rs.getString("teacherSurname");
            String name = rs.getString("teacherName");
            String email = rs.getString("teacherMail");
            list.add(new Teacher(i, surname, name, email));
        }

        pstmnt.close(); // also closes related result set
        return list;
    }

    public List<Class> GetAllRows(int i) throws SQLException {

        String sql = "SELECT class.classID, class.className FROM class INNER JOIN teacher2class ON class.classId = teacher2class.fk_classID WHERE teacher2class.fk_teacherID = ?";
        PreparedStatement pstmnt = conn.prepareStatement(sql);
        pstmnt.setInt(1, i);
        ResultSet rs = pstmnt.executeQuery();
        List<Class> listClasses = new ArrayList<>();

        while (rs.next()) {
            int i2 = rs.getInt("classID");
            String name = rs.getString("className");
            listClasses.add(new Class(i2, name));
        }
        pstmnt.close();
        return listClasses;
    }
}

