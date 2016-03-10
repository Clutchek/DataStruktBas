/* This is the driving engine of the program. It parses the command-line
 * arguments and calls the appropriate methods in the other classes.
 *
 * You should edit this file in two ways:
 * 1) Insert your database username and password in the proper places.
 * 2) Implement the three functions getInformation, registerStudent
 *    and unregisterStudent.
 */
import java.sql.*; // JDBC stuff.
import java.util.Properties;
import java.util.Scanner;
import java.io.*;  // Reading user input.

public class StudentPortal
{
    /* TODO Here you should put your database name, username and password */
    static final String USERNAME = "tda357_042";
    static final String PASSWORD = "TQAz5SxP";

    /* Print command usage.
     * /!\ you don't need to change this function! */
    public static void usage () {
        System.out.println("Usage:");
        System.out.println("    i[nformation]");
        System.out.println("    r[egister] <course>");
        System.out.println("    u[nregister] <course>");
        System.out.println("    q[uit]");
    }

    /* main: parses the input commands.
     * /!\ You don't need to change this function! */
    public static void main(String[] args) throws Exception
    {
        try {
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://ate.ita.chalmers.se/";
            Properties props = new Properties();
            props.setProperty("user",USERNAME);
            props.setProperty("password",PASSWORD);
            Connection conn = DriverManager.getConnection(url, props);

            String student = args[0]; // This is the identifier for the student.

            Scanner scanner = new Scanner(System.in);
            usage();
            System.out.println("Welcome!");
            while(true) {
                String mode = scanner.nextLine();
                String[] cmd = mode.split(" +");
                cmd[0] = cmd[0].toLowerCase();
                if ("information".startsWith(cmd[0]) && cmd.length == 1) {
                    /* Information mode */
                    getInformation(conn, student);
                } else if ("register".startsWith(cmd[0]) && cmd.length == 2) {
                    /* Register student mode */
                    registerStudent(conn, student, cmd[1]);
                } else if ("unregister".startsWith(cmd[0]) && cmd.length == 2) {
                    /* Unregister student mode */
                    unregisterStudent(conn, student, cmd[1]);
                } else if ("quit".startsWith(cmd[0])) {
                    break;
                } else usage();
            }
            System.out.println("Goodbye!");
            conn.close();
        } catch (SQLException e) {
            System.err.println(e);
            System.exit(2);
        }
    }

    /* Given a student identification number, ths function should print
     * - the name of the student, the students national identification number
     *   and their university issued login name (something similar to a CID)
     * - the programme and branch (if any) that the student is following.
     * - the courses that the student has read, along with the grade.
     * - the courses that the student is registered to.
     * - the mandatory courses that the student has yet to read.
     * - whether or not the student fulfills the requirements for graduation
     */
    static void getInformation(Connection conn, String student) throws SQLException {
        PreparedStatement st =
                conn.prepareStatement("SELECT * FROM StudentsFollowing WHERE personalCodeNumber  = ?");
        st.setString(1, student);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            //Retrieve by column name
            String name = rs.getString("name");
            String loginId = rs.getString("loginId");
            String line = rs.getString("studyProgramme");
            String branch = rs.getString("branch");

            System.out.println("Information for student " + student);
            System.out.println("-------------------------------------");

            //Display values
            System.out.println("Name: " + name);
            System.out.println("Student ID: " + loginId);
            System.out.println("Line: " + line);
            System.out.println("Branch: " + branch);

        }
        System.out.println();
        System.out.println();


        System.out.println("Read courses (name (code), credits: grade):");
        st = conn.prepareStatement("SELECT * FROM FinishedCourses WHERE student  = ?");
        st.setString(1, student);
        rs = st.executeQuery();
        while (rs.next()) {

            String courseName = rs.getString("name");
            String courseCode = rs.getString("coursecode");
            String credits = rs.getString("credits");
            String grade = rs.getString("grade");
            System.out.println(courseName + " (" + courseCode + "), " + credits + "p: " + grade);

        }
        System.out.println();
        System.out.println();

        st = conn.prepareStatement("SELECT * FROM Registrations  WHERE student  = ?");
        st.setString(1, student);
        rs = st.executeQuery();
        System.out.println("Registered courses (name (code), credits: status):");
        while (rs.next()) {

            String courseCode = rs.getString("course");
            String status = rs.getString("status");

            if (status.equals("waiting")) {
                PreparedStatement st2 = conn.prepareStatement("SELECT * FROM CourseQueuePositions WHERE student  = ? AND restrictedCourse = ?");
                st2.setString(1, student);
                st2.setString(2, courseCode);
                ResultSet rs2 = st2.executeQuery();
                if (rs2.next()) {
                    String number = rs2.getString("row_number");
                    System.out.println(courseCode + ",  " + status + " " + number);
                }
            } else {
                System.out.println(courseCode + ",  " + status);
            }

        }

        System.out.println();
        System.out.println();

        st = conn.prepareStatement("SELECT * from PathToGraduation WHERE student = ?;");
        st.setString(1, student);
        rs = st.executeQuery();
        while (rs.next()){
            System.out.println("Seminar courses taken:" + rs.getString("nbrofseminarcourses"));
            System.out.println("Math credits taken:" + rs.getString("mathCredits"));
            System.out.println("Research credits taken:" + rs.getString("researchCredits"));
            System.out.println("Total credits taken:" + rs.getString("totalcredits"));
            System.out.println("Fulfills the requirements for graduation: " + rs.getString("qualifiedforgraduation"));
            System.out.println("-------------------------------------");
        }
        rs.close() ;
        st.close() ;
    }

    /* Register: Given a student id number and a course code, this function
     * should try to register the student for that course.
     */
    static void registerStudent(Connection conn, String student, String course) throws SQLException
    {
        PreparedStatement st =
                conn.prepareStatement("INSERT INTO Registrations values(?, ?, ?)") ;
        st.setString(1,course);
        st.setString(2,student);
        st.setString(3,null);
        boolean regFailed = false;
        int rs = 0;
        try {
            rs = st.executeUpdate();
        }catch(SQLException e){
            regFailed = true;
            System.out.println(e.getMessage() + "Student could not be registered");
            if(st != null){
                st.close();
            }
        }
        if(!regFailed){
            PreparedStatement s2 =
                    conn.prepareStatement("SELECT status FROM Registrations WHERE student = ? AND course = ?");
            s2.setString(1, student);
            s2.setString(2, course);
            ResultSet r2 = s2.executeQuery();
            if(r2 != null){
                if(r2.next()){
                    if(r2.getString("status").equals("waiting")){
                        System.out.println("Course "+course +" is full, you are put in the waiting list.");
                    }else if(r2.getString("status").equals("registered")){
                        System.out.println("You are now successfully registered to course " + course);
                    }
                }
            }
            if(r2 != null){
                r2.close();
            }
            if(s2 != null){
                s2.close();
            }
        }
    }

    /* Unregister: Given a student id number and a course code, this function
     * should unregister the student from that course.
     */
    static void unregisterStudent(Connection conn, String student, String course) throws SQLException
    {
        PreparedStatement st =
                conn.prepareStatement("DELETE FROM Registrations WHERE student = ? AND course = ?") ;
        st.setString(1,student);
        st.setString(2,course);
        int deletion = st.executeUpdate();
        if(deletion > 0){
            System.out.println("Deleted "+student+" from "+course);
        }else{
            System.out.println("Deletion failed");
        }
        st.close();
    }
}