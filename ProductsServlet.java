
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import shop.cart.Product;

@WebServlet("/ProductsServlet")
public class ProductsServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		int categoryId = Integer.parseInt(request.getParameter("category"));
		List<Product> products = ProductDAO.getProductsByCategory(categoryId);
		response.setContentType("application/json");
		Gson gson = new Gson();
		String productsJson = gson.toJson(products);
		response.getWriter().write(productsJson);
	}

}
