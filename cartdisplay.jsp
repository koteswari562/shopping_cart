<%@ page import="java.util.Map" %>
<%@ page import="shop.cart.Cart" %>
<%@ page import="shop.cart.Product" %>

<%
    // Retrieve Cart from session
    Cart cart = (Cart) session.getAttribute("cart");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart Items</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
    /* Body Styles */
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        color: #333;
        padding: 20px;
    }

    /* Container Styles */
    .container {
        max-width: 960px;
        margin: 0 auto;
    }

    /* Card Styles */
    .card {
        border: 1px solid #ddd;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        background-color: #fff;
    }

    .card-body {
        padding: 20px;
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

    .product-image {
        width: 100%;
        height: 200px;
        object-fit: cover;
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
    }

    /* Button Styles */
    .btn {
        padding: 8px 16px;
        font-size: 14px;
        border-radius: 5px;
        cursor: pointer;
    }

    .btn-secondary {
        background-color: #6c757d;
        color: #fff;
        border: 1px solid #6c757d;
    }

    .btn-secondary:hover {
        background-color: #5a6268;
        border-color: #545b62;
    }

    .btn-danger {
        background-color: #dc3545;
        color: #fff;
        border: 1px solid #dc3545;
    }

    .btn-danger:hover {
        background-color: #c82333;
        border-color: #bd2130;
    }

    /* Checkout Button */
    .checkout-btn {
        padding: 12px 24px;
        font-size: 16px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .checkout-btn:hover {
        background-color: #0056b3;
    }

    /* Quantity Display */
    .quantity {
        font-weight: bold;
        font-size: 16px;
    }
</style>
    
    
</head>
<body>
    <h1>Cart Items</h1>
    <div class="container">
        <div class="row">
            <% 
                if (cart != null) {
                    // Display cart items
                    Map<Product, Integer> items = cart.getItems();
                    if (items != null && !items.isEmpty()) {
                        for (Map.Entry<Product, Integer> entry : items.entrySet()) {
                            Product product = entry.getKey();
                            int quantity = entry.getValue();
             %>
            <div class="col-md-4 mb-3">
                <div class="card_<%= product.getId() %>">
                    <div class="card-body">
                    <img src="<%= product.getImgpath() %>" class="product-image">
                        <h5 class="card-title">Product: <%= product.getName() %></h5>
                        <p class="card-text">Price: <%= product.getPrice() %></p>
                       <p class="card-text">
                           <button class="btn btn-sm btn-secondary" onclick="decrementQuantity(<%= product.getId() %>,-1
                           )">-</button>
                            <span id ="quantity_<%= product.getId() %>" class="quantity"><%= quantity %></span>
                            <button class="btn btn-sm btn-secondary" onclick="incrementQuantity(<%= product.getId() %>, 1)">+</button>
                        </p>
                       <button class="btn btn-sm btn-danger" id="productCard_<%= product.getId() %>" onclick="removeProduct(<%= product.getId() %>)">Remove</button>
                        
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
    <div class="container">
        <div class="row mt-3">
            <div class="col text-center">
                <button class="btn btn-primary" onclick="checkout()">Checkout</button>
            </div>
        </div>
    </div>
    <script>
    function removeProduct(productId) {

        // Find the card element with the corresponding productId
        var cardToRemove = document.getElementById('productCard_' + productId);
        console.log(cardToRemove);
        
        if (cardToRemove) {
            $('.card_'+productId).hide();
            cardToRemove.remove();
            console.log("htgdj");
            $.ajax({
                url: 'RemoveServlet',
                method: 'POST',
                data: {
                    productId: productId
                },
                success: function(response) {
                    console.log('Product removed successfully');
                },
                error: function(xhr, status, error) {
                    console.log('Error removing product:', error);
                }
            });
        }
    }
    function incrementQuantity(productId,quantity) {
        var quantityElement = $('.quantity#quantity_' + productId);
        var currentQuantity = parseInt(quantityElement.text());

        var newQuantity = currentQuantity + 1;


        quantityElement.text(newQuantity);
        updateQuantity(productId,quantity);
    }
    function decrementQuantity(productId,quantity) {
        var quantityElement = $('.quantity#quantity_' + productId);
        var currentQuantity = parseInt(quantityElement.text());

        var newQuantity = currentQuantity - 1;

        quantityElement.text(newQuantity);
        updateQuantity(productId,quantity);
    }
    function updateQuantity(productId, quantity) {
        $.ajax({
            url: 'CartServlet',
            method: 'POST',
            data: {
                productId: productId,
                quantity: quantity
            },
            success: function(response) {
            	$('.quantity').text(response.quantity);
            	console.log("Quantity updated successfully");
            },
            error: function(xhr, status, error) {
                console.log('Error updating quantity:', error);
            }
        });
    }
    function checkout() {
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "CheckoutServlet");
        
        document.body.appendChild(form);
        form.submit();
    }
    </script>
</body>
</html>