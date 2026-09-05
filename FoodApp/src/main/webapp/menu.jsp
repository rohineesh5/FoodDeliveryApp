<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.models.Menu, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link type="image/png" rel="icon" href="images/food app header logo.png">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <title>Menu Page</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background-color: #fafafa;
      color: #333;
    }
	
	.navbar {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	  background-color: #ff6f61;
	  padding: 10px 20px;
	  color: white;
	  border-radius: 0 0 12px 12px;
	}
	
	.logo {
	  font-size: 24px;
	  font-weight: bold;
	}
	
	.nav-buttons {
	  display: flex;
	  gap: 10px;
	}
	
	.nav-btn {
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  gap: 8px;
	  background-color: white;
	  color: #ff6f61;
	  text-decoration: none;
	  border: 2px solid #ff6f61;
	  padding: 8px 16px;
	  border-radius: 20px;
	  font-size: 16px;
	  font-weight: bold;
	  cursor: pointer;
	  transition: all 0.3s ease;
	  line-height: 1;
	}

	
	.nav-btn i {
	  font-size: 16px;
	  line-height: 1;
	  display: inline-flex;
	  align-items: center;
	}

	
	.nav-btn:hover {
	  background-color: #ff6f61;
	  color: white;
	}
	
	.nav-btn:hover i {
	  color: white;
	}

	.fa-right-to-bracket{
		font-size: 20px;
	}
	
	.fa-cart-shopping{
		font-size: 20px;
	}
	
    .menu-container {
      padding: 2rem;
      max-width: 1200px;
      margin: auto;
    }

    .menu-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 2rem;
      justify-content: center;
    }

    .menu-card {
      background-color: white;
      width: 280px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      overflow: hidden;
      transition: transform 0.3s ease;
    }

    .menu-card:hover {
      transform: translateY(-5px);
    }

    .menu-card img {
      width: 100%;
      height: 180px;
      object-fit: cover;
    }

    .menu-card-content {
      padding: 1rem;
    }

    .menu-card h3 {
      font-size: 1.1rem;
      margin-bottom: 0.4rem;
      color: #222;
    }

    .menu-card p {
      font-size: 0.9rem;
      color: #666;
      margin-bottom: 0.4rem;
    }

    .price {
      font-weight: bold;
      color: #ff4d4f;
      font-size: 1rem;
      margin-bottom: 0.3rem;
    }

    .rating {
      font-size: 0.85rem;
      background-color: #f0f0f0;
      display: inline-block;
      padding: 0.2rem 0.5rem;
      border-radius: 12px;
      color: #333;
    }
    
	.button-container {
	    display: flex;
	    justify-content: center;
	    align-content: center;
	    margin-top: auto;
	}
	
	.add-btn {
	    background-color: hsl(359, 100%, 55%);
	    color: white;
	    border: none;
	    padding: 8px 16px;
	    border-radius: 20px;
	    font-size: 14px;
	    cursor: pointer;
	    transition: background-color 0.3s ease;
	}
	
	.add-btn:hover {
	    background-color: hsl(359, 100%, 45%);
      font-weight: bolder;
	}
 
  </style>
</head>
<body>

<nav class="navbar">
  <div class="logo">FoodZone</div>
  <div class="nav-buttons">
    <button class="nav-btn">Sign In <i class="fa-solid fa-right-to-bracket"></i></button>
    <button class="nav-btn"><i class="fa-solid fa-cart-shopping"></i></button>
  </div>
</nav>

  <div class="menu-container">
    <div class="menu-grid">
      
      <!-- Menu Card -->
      <%
      List<Menu> menuByRestaurantId = (List<Menu>)request.getAttribute("menuByRestaurantId");
      
      for(Menu menu : menuByRestaurantId)
      { %>
      	
      	<div class="menu-card">
	        <img src="<%= menu.getImagepath() %>" alt="menu image">
	        <div class="menu-card-content">
	          <h3><%= menu.getItemname() %></h3>
	          <p class="price">₹ <%= menu.getPrice() %></p>
	          <p><%= menu.getDescription() %></p>
	          <span class="rating">⭐ <%= menu.getRatings() %></span>
	          <form action="cart?restaurantId=<%= menu.getRestaurantid() %>">
	            	<input type="hidden" name="menuId" value="<%= menu.getMenuid() %>">
	            	<input type="hidden" name="quantity" value="1">
	            	<input type="hidden" name="restaurantId" value="<%= menu.getRestaurantid() %>">
	            	<input type="hidden" name="action" value="add">
		            <div class="button-container">
		              <input type="submit" class="add-btn" value="Add Item">
		            </div>
	          </form>
        	</div>
      	</div>
    	  
      <% } %>

    </div>
  </div>

</body>
</html>