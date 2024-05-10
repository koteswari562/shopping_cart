package shop.cart;

import java.sql.Date;
import java.util.Map;

public class Order {
	int id;
	Date date;
	int total;
	Map<Product, Integer> items;

	public void setId(int id) {
		this.id = id;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public void setItems(Map<Product, Integer> items) {
		this.items = items;
	}

	public int getId() {
		return id;
	}

	public Date getDate() {
		return this.date;
	}

	public int getTotal() {
		return total;
	}

	public Map<Product, Integer> getItems() {
		return items;
	}
}
