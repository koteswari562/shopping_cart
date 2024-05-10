<%@ page import="java.util.Map" %>
<%@ page import="shop.cart.Cart" %>
<%@ page import="shop.cart.Product" %>
<%@ page import="java.util.Iterator" %>
<%
    // Retrieve Cart from session
    Cart cart = (Cart) session.getAttribute("cart");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
    body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h3, h4 {
            text-align: center;
            margin-bottom: 20px;
        }

        .card {
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .card-body {
            padding: 20px;
        }

        .disp-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            margin-top: 20px;
        }

        .disp {
            text-align: center;
            margin-bottom: 20px;
        }

        button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

        /* Additional Styles for Specific Elements */

        .row {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .col-md-4 {
            flex: 0 0 32%;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .card-text {
            font-size: 16px;
            margin-bottom: 10px;
        }

        /* Optional: Style for Checkout Button */
        #razorpayBtn {
            margin-top: 20px;
        }
    

        /* Optional: Adjust spacing and alignment within each .disp block */
        .disp {
            text-align: center;
            margin-bottom: 10px; /* Optional margin between each .disp block */
        }
      #total {
            display: none;
        }
        #total2{
        display:none;}
      #razorpayBtn{
      align-items: center;}
    </style>
</head>
<body>
<div class="container">
<h3>Order Details</h3>
        <div class="row">
            <% 
                if (cart != null) {
                    Map<Product, Integer> items = cart.getItems();
                    if (items != null && !items.isEmpty()) {
                        for (Map.Entry<Product, Integer> entry : items.entrySet()) {
                            Product product = entry.getKey();
                            int quantity = entry.getValue();
            %>
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Product: <%= product.getName() %></h5>
                        <p class="card-text">Price: <%= product.getPrice() %></p>
                        <p class="card-text">Quantity: <%= quantity %></p>
                       
                        
                    </div>
                </div>
            </div>
            <%          
                        }
                        
           } else {
            %>
            <div class="col">
                <p>No items in the cart.</p>
            </div>
            <%      
                    }
                } else {
            %>
            <div class="col">
                <p>Cart is empty.</p>
            </div>
            <%      
                }
            %>
        </div>
    </div>
       					 <% Double price = Double.parseDouble(request.getParameter("Price")); %>
						<% Double gst = Double.parseDouble(request.getParameter("GST")); %>
						<% Double sc = Double.parseDouble(request.getParameter("sc")); %>
						<% Double amount = Double.parseDouble(request.getParameter("TotalAmount")); %>
						<div class="disp-container">
						<div class="disp">
						<h6>Price: <%= price %></h6>
						<h6>GST: <%= gst %></h6>
						<h6>Shipping Charges:<%=sc %></h6>
						<h6 id="total">Coupon Applied:-499</h6>
						<h3 id="totalprice"><%= amount %></h3>
						<% if (amount > 20000) { %>
						<button id="coupon">Add Coupon</button>
    <% } %>
						<button id="razorpayBtn">Pay</button>
						</div>
						</div>

    </div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#coupon').click(function() {
                var amt = <%=Double.parseDouble(request.getParameter("TotalAmount"))%>
                		$('#total').show();
                		var currentAmount = parseInt(document.getElementById('totalprice').textContent.trim());
                        var newAmount = currentAmount - 499; 
                        document.getElementById('totalprice').textContent = 'Total Price: ' + newAmount;
                        $('#coupon').hide();
                        alert("YAYYY!!!COUPON APPLIED")
            });
        });
    </script>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<script>

document.addEventListener('DOMContentLoaded', function () {
	var razorpayBtn = document.getElementById('razorpayBtn');
   var currentAmount = parseInt(document.getElementById('totalprice').textContent.trim());
   var amt = currentAmount - 499; 
    console.log(amt);
    razorpayBtn.addEventListener('click', function () {
    	console.log("hiiiiiiiiiii");
        var options = {
            "key": "rzp_test_OQhYYrloWXvOJ5",
            "amount": amt*100, 
            "currency": "INR",
            "name": "Ekart Shopping",
            "description": "Shopping App",
            "image": "https://your-website.com/logo.png",
            "handler": function (response) {
                alert('Payment successful: ' + response.razorpay_payment_id);
            },
            "prefill": {
                "name": "Ram",
                "email": "customer@example.com",
                "contact": "9965847103"
            },
            "theme": {
                "color": "#007bff"
            }
        };
 
        var rzp = new Razorpay(options);
        rzp.open();
    });
});
</script>
</html>

