<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Display</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

    #cartIcon {
        position: fixed;
        top: 5px;
        right: 40px;
        font-size: 34px;
        color: #333;
        cursor: pointer;
    }

    .product-card {
        border: 1px solid #ddd;
        border-radius: 8px;
        margin-bottom: 20px;
        margin-left:10%;
        width: 22%;
        background-color:lightblue;
    }

    .product-card .card-img-top {
        object-fit: cover;
        height: 250px; 
    }

    .product-card .card-body {
        padding: 15px;
    }

    .product-card .card-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .product-card .card-text {
        font-size: 16px;
        margin-bottom: 10px;
    }
    .container{
    	marign-right:0px;
    }

    .product-card .btn-primary {
        width: 100%;
    }
    .not-available-message {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); 
    font-size: 18px;
    font-weight: bold;
    color: Red;
    background-color: rgba(255, 255, 255, 0.8); 
    padding: 10px;
    border-radius: 8px;
}
        #price{
        	width:150px;
        	margin-right:190px;
        	margin-top:20px;
        }
    #category {
            width: 150px;
            margin-right: 10px;
            margin-top:20px;
        }

        #samp{
    opacity: 0.5; 
    pointer-events: none; 
    filter: grayscale(100%); 
}
</style>
<script>
$(document).ready(function(){
        var pincode = prompt("Please enter your pincode:");
    $("#category").change(function(){
        var categoryId = $(this).val();
        $.ajax({
            url: "ProductsServlet",
            method: "POST",
            data: {category: categoryId},
            success: function(data){
                $("#products").empty();
                
                $.each(data, function(index, product){
                    var card = $("<div>").addClass("card product-card");
                    var cardBody = $("<div>").addClass("card-body");
                    var productImage = $("<img>").addClass("card-img-top").attr("src", product.imgpath); 
                    var productName = $("<h5>").addClass("card-title").text(product.name);
                    var productPrice = $("<p>").addClass("card-text").text("Price: " + product.price);
                    var addToCartButton = $("<button>").addClass("btn btn-primary").text("Add to Cart");
                    
                    addToCartButton.click(function(){
                        $.ajax({
                            url: "CartServlet",
                            method: "POST",
                            data: {productId: product.id},
                            dataType: "text",
                            success: function(response){
                            	alert("Item Added");
                                console.log("Product added to cart:", product);
                            },
                            error: function(xhr, status, error){
                                console.error("Error adding product to cart:", error);
                            }
                        });
                    });
                    
                    cardBody.append(productImage, productName, productPrice, addToCartButton);
                    card.append(cardBody);
                    $("#products").append(card);
                });
            }
        });
    });
    $("#price").change(function(){
        var categoryId = $('#category').val();
        var priceId=$('#price').val();
        console.log(priceId);
        $.ajax({
            url: "PriceServlet",
            method: "POST",
            data: {category: categoryId,price:priceId},
            success: function(data){
                $("#products").empty();
                $.each(data, function(index, product){
                    var card = $("<div>").addClass("card product-card");
                    var cardBody = $("<div>").addClass("card-body");
                    var productImage = $("<img>").addClass("card-img-top").attr("src", product.imgpath); 
                    var productName = $("<h5>").addClass("card-title").text(product.name);
                    var productPrice = $("<p>").addClass("card-text").text("Price: " + product.price);
                    var addToCartButton = $("<button>").addClass("btn btn-primary").text("Add to Cart");
                    console.log(product.pincode);
                    if(product.pincode<pincode){
                    	var cardid="samp";
                    	card.attr("id",cardid);
                    	var message=$("<p>"). addClass("not-available-message").text("Not Available");
                    	cardBody.append(message);
                    }
              
                    addToCartButton.click(function(){
                        $.ajax({
                            url: "CartServlet",
                            method: "POST",
                            data: {productId: product.id},
                            dataType: "text",
                            success: function(response){
                                alert("Item Added");
                            },
                            error: function(xhr, status, error){
                                console.error("Error adding product to cart:", error);
                            }
                        });
                    });
                    
                    cardBody.append(productImage, productName, productPrice, addToCartButton);
                    
                    card.append(cardBody);
                    $("#products").append(card);
                });
            }
        });
    });
    // Redirect to cartdisplay.jsp when cart icon is clicked
    $("#cartIcon").click(function() {
        window.location.href = "cartdisplay.jsp";
    });
});
</script>
</head>
<body>
    <div class="container">
        <h2 style="text-align: center; background-color: lightblue;">Products</h2>
        <div class="row">
            <div class="col-md-6">
                <select id="category" class="form-control">
                    <option>Category</option>
                    <option value="1">Mobiles</option>
                    <option value="2">Clothes</option>
                </select>
                <select id="price" class="form-control">
                    <option>Max Price</option>
                    <option value="1000">1000</option>
                    <option value="5000">5000</option>
                    <option value="10000">10000</option>
                    <option value="20000">20000</option>
                    <option value="30000">30000</option>
                    <option value="40000">40000</option>
                    <option value="50000">50000</option>
                </select>
            </div>
        </div>
        <div class="row mt-3" id="products">
        </div>
    </div>
    <!-- Cart icon at the top right corner -->
    <i id="cartIcon" class="fas fa-shopping-cart"></i>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
