import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.Naming;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
public class CreateServlet2 extends HttpServlet {
	static int count=0;
	
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
		count+=1;
		ps.setInt(1,count);
		ps.setString(2,username);
		ps.setString(3,password);
		ps.setString(4,repassword);
		ps.setDouble(5,amount);
		ps.setString(6,adderess);
		ps.setDouble(7,phone);
		
		status=ps.executeUpdate();
		
	} catch (Exception e) {
		
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
		
	//con.close();	
	}

}