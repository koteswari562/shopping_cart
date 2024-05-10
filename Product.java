package shop.cart;

public class Product {
	int id;
	String name;
	int price;
	String imgpath;
	int pincode;
	int gst;

	public Product(int id, String name, int price, String imgpath, int pincode, int gst) {
		this.id = id;
		this.name = name;
		this.price = (price * (100 - gst)) / 100;
		this.imgpath = imgpath;
		this.pincode = pincode;
		this.gst = gst;
	}

	public Product(int id, String name, int price, String imgpath) {
		// TODO Auto-generated constructor stub
		this.id = id;
		this.name = name;
		this.price = (price * (100 - gst)) / 100;
		this.imgpath = imgpath;
	}

	public Product(int id, String name, int price, String imgpath, int gst) {
		// TODO Auto-generated constructor stub
		this.id = id;
		this.name = name;
		this.price = (price * (100 - gst)) / 100;
		this.imgpath = imgpath;
		this.gst = gst;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public int getPrice() {
		return price;
	}

	public int getGst() {
		return this.gst;
	}

	public void setImgpath(String imgpath) {
		this.imgpath = imgpath;
	}

	public String getImgpath() {
		return imgpath;
	}

}
