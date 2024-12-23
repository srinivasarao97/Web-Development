<%@ page import="java.io.IOException"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.rmi.Naming"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<% page import="java.sql.*"%>

<%
public class CreateServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String  repassword=request.getParameter("repassword");
		
		String amoun=request.getParameter("amount");
		double amount=Double.parseDouble(amoun);
		
		String adderess=request.getParameter("adderess");
		
		String ph=request.getParameter("phone");
		double phone=Double.parseDouble(ph);
		int status=0;
	Connection con;
	PreparedStatement ps;
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","srinu");
		ps = con.prepareStatement("Insert into NEWACCOUNT values(?,?,?,?,?,?,?)");
		int	nextvalue1=GetCon.getPrimaryKey();
		ps.setInt(1,nextvalue1);
		ps.setString(2,username);
		ps.setString(3,password);
		ps.setString(4,repassword);
		ps.setDouble(5,amount);
		ps.setString(6,adderess);
		ps.setDouble(7,phone);
		
		status=ps.executeUpdate();
		
	} catch (SQLException e) {
		
		e.printStackTrace();
	}
	    
		if(status>0){
			out.print("WELCOME! YOUR ACCOUNT HAS OPENED");
			RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
			rd.include(request, response);
		}
		else{
			out.print("Sorry,Registration failed. please try later");
			RequestDispatcher rd=request.getRequestDispatcher("MyHtml.html");
			rd.include(request, response);
		}
		
	con.close();	
	}

}

%>