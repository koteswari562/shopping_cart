package shop.cart;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class Cart {
	private Map<Product, Integer> items;

	public Cart() {
		items = new HashMap<>();
	}

	public void addProduct(Product product, int quantity) {
		int flag = 0;
		System.out.println("cart:" + product.gst);
		for (Map.Entry<Product, Integer> hm : items.entrySet()) {
			Product key = hm.getKey();
			if (key.getId() == product.getId()) {
				items.put(key, hm.getValue() + 1);
				flag = 1;
				break;
			}
		}
		if (flag == 0) {
			items.put(product, quantity);
		}
	}

	public void updateQuantity(Product product, int quantity) {
		if (items.containsKey(product)) {
			items.put(product, quantity);
		}
	}

	public Map<Product, Integer> getItems() {
		return items;
	}

	public int getTotal() {
		int totalPrice = 0;
		int gst = 0;
		int gstamount = 0;
		int price = 0;
		for (Map.Entry<Product, Integer> entry : items.entrySet()) {
			Product product = entry.getKey();
			int quantity = entry.getValue();
			gst = ((product.getPrice() * product.getGst()) / 100) * quantity;
			System.out.println(gst);
			gstamount += gst;
			price += product.getPrice() * quantity - gst;
		}
		return price;
	}

	public int getGst() {
		int totalPrice = 0;
		int gst = 0;
		int gstamount = 0;
		int price = 0;
		for (Map.Entry<Product, Integer> entry : items.entrySet()) {
			Product product = entry.getKey();
			int quantity = entry.getValue();
			gst = ((product.getPrice() * product.getGst()) / 100) * quantity;
			gstamount += gst;
		}
		return gstamount;
	}

	public void clearCart() {
		items.clear();
	}

	public void removeProduct(Product product) {
		// TODO Auto-generated method stub
		Iterator<Map.Entry<Product, Integer>> iterator = items.entrySet().iterator();
		while (iterator.hasNext()) {
			Map.Entry<Product, Integer> entry = iterator.next();
			Product key = entry.getKey();

			// Check if the current map entry's key (product) matches the specified product
			if (key.getId() == product.getId()) {
				// Remove the product from the cart
				iterator.remove(); // Use iterator to safely remove from the map
				break; // Exit the loop after removing the product
			}
		}

	}
}
