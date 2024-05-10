import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;

import shop.cart.Order;
import shop.cart.Product;

public class OrderDAO {
	static String url = "jdbc:postgresql://192.168.110.48/postgres";
	static String username = "plf_training_admin";
	static String password = "pff123";

	public static void insertOrderItems(double orderId, Map<Product, Integer> items) {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		try (Connection con = DriverManager.getConnection(url, username, password);
				PreparedStatement stmt = con
						.prepareStatement("INSERT INTO orderproducts_k(ordid,proid,quantity,price) VALUES(?,?,?,?)")) {
			for (Map.Entry<Product, Integer> entry : items.entrySet()) {
				Product product = entry.getKey();
				int quantity = entry.getValue();
				stmt.setDouble(1, orderId);
				stmt.setInt(2, product.getId());
				stmt.setInt(3, quantity);
				stmt.setDouble(4, product.getPrice());
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public double insertOrder(Order order) {
		// TODO Auto-generated method stub
		double orderId = -1;
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		try (Connection con = DriverManager.getConnection(url, username, password);
				PreparedStatement stmt = con
						.prepareStatement("Insert INTO orders_k(ordid,orddate,ordtotal) VALUES (?,?,?)")) {
			orderId = Math.random();
			stmt.setDouble(1, orderId);
			stmt.setDate(2, new java.sql.Date(order.getDate().getTime()));
			stmt.setInt(3, order.getTotal());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orderId;
	}

}
