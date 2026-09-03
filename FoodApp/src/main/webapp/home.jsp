<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.models.Restaurant, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link type="image/png" rel="icon" href="images/food app header logo.png">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <title>Home Page</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }

    body {
      background-color: #f8f8f8;
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

	.search-container {
	  position: relative;
	  flex-grow: 1;
	  margin: 0 20px;
	  max-width: 400px;
	}
	
	.search-bar {
	  width: 100%;
	  padding: 8px 40px 8px 12px;
	  border-radius: 20px;
	  border: none;
	  outline: none;
	  font-size: 14px;
	  background-color: white;
	  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	}
	
	.search-button {
	  position: absolute;
	  right: 10px;
	  top: 50%;
	  transform: translateY(-50%);
	  background: none;
	  border: none;
	  cursor: pointer;
	  padding: 5px;
	  transition: transform 0.1s;
	}
	
	.search-button:hover i {
	  animation: fa-bounce 1s infinite;
	}
	
	/* Font Awesome bounce animation */
	@keyframes fa-bounce {
	  0% { transform: scale(1); }
	  50% { transform: scale(1.3); }
	  100% { transform: scale(1); }
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
	  font-weight: bold;
	  cursor: pointer;
	  transition: all 0.1s ease;
	}
	
	.nav-btn i {
	  transition: color 0.1s ease;
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

  .container {
    padding: 2rem;
  }

    .card-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 2rem;
      justify-content: center;
    }
	
	.card-grid a {
	  text-decoration: none;
	  color: inherit;
	  display: inline-block;
	}
	
    .card {
      background-color: white;
      width: 300px;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      transition: transform 0.2s ease;
    }

    .card:hover {
      transform: scale(1.05);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
      
    }

    .card img {
      width: 100%;
      height: 180px;
      object-fit: cover;
    }

    .card-content {
      padding: 1rem;
    }

    .card h3 {
      font-size: 1.2rem;
      margin-bottom: 0.5rem;
    }

    .card p {
      font-size: 0.9rem;
      margin-bottom: 0.5rem;
      color: #666;
    }

    .card .meta {
      font-size: 0.85rem;
      color: #444;
    }
  </style>
</head>
<body>
  <nav class="navbar">
    <div class="logo">FoodZone</div>
	<div class="search-container">
	  <form action="SearchServlet" method="POST">
	    <input type="text" name="searchQuery" placeholder="Search restaurants..." class="search-bar">
	    <button type="submit" class="search-button">
	      <i class="fa-solid fa-magnifying-glass" style="color: #ff6f61;"></i>
	    </button>
	  </form>
	</div>  
    <div class="nav-buttons">
      <a class="nav-btn" href="login.jsp">Sign In <i class="fa-solid fa-right-to-bracket"></i></a>
      <a class="nav-btn" href="cart.jsp"><i class="fa-solid fa-cart-shopping"></i></a>
    </div>
  </nav>

  <div class="container">
    <div class="card-grid">
		
		<% 
		List<Restaurant> allRestaurants = (List<Restaurant>)request.getAttribute("allRestaurants");
		
	    if(allRestaurants == null || allRestaurants.isEmpty())
	    { %>
	            <div style="width:100%; text-align:center; padding:40px; color:#666;">
	                <h3>No restaurants found</h3>
	                <p>Try a different search </p>
	            </div>
	  <% }
	    else 
	    { 
			for(Restaurant restaurant: allRestaurants)
			{
				String restaurantName = restaurant.getName() == null ? "" : restaurant.getName().toLowerCase();
				String cuisine = restaurant.getCusinetype() == null ? "" : restaurant.getCusinetype().toLowerCase();
				String restaurantImage = restaurant.getImagepath();
				String fallbackImage = "https://images.unsplash.com/photo-1547592180-85f173990554?w=900&auto=format&fit=crop";
				if (restaurantName.contains("paradise") || restaurantName.contains("mehfil")) {
					fallbackImage = "https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=900&auto=format&fit=crop";
				} else if (cuisine.contains("pizza") || cuisine.contains("italian")) {
					fallbackImage = "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=900&auto=format&fit=crop";
				} else if (cuisine.contains("burger") || cuisine.contains("american")) {
					fallbackImage = "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=900&auto=format&fit=crop";
				} else if (cuisine.contains("indian") || cuisine.contains("biryani") || cuisine.contains("curry")) {
					fallbackImage = "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=900&auto=format&fit=crop";
				} else if (cuisine.contains("sushi") || cuisine.contains("japanese")) {
					fallbackImage = "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=900&auto=format&fit=crop";
				}
				if (restaurantImage == null || restaurantImage.trim().isEmpty()) {
					restaurantImage = fallbackImage;
				} else if (!restaurantImage.startsWith("http://") && !restaurantImage.startsWith("https://") && restaurantImage.indexOf('/') < 0 && restaurantImage.indexOf('\\') < 0) {
					restaurantImage = fallbackImage;
				}
				%>
				<a href="menu?restaurantId=<%= restaurant.getRestaurantid() %>">
					<div class="card">
						<img src="<%= restaurantImage %>" alt="<%= restaurant.getName() %> restaurant" onerror="this.onerror=null;this.src='<%= fallbackImage %>'">
						<div class="card-content">
							<h3><%= restaurant.getName() %></h3>
							<p><%= restaurant.getAddress() %></p>
							<p class="meta"><b>Cuisine</b>: <%= restaurant.getCusinetype() %></p>
							<p class="meta"><b>ETA</b>: <%= restaurant.getDeliverytime() %> | <b>Rating</b>: <%= restaurant.getRating() %>⭐</p>
						</div>
					</div>
				</a>
			<% } 
		} %>     
      
    </div>
  </div>
</body>
</html>