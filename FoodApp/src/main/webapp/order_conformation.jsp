<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Order Confirmation Page</title>
  <link type="image/png" rel="icon" href="images/food app header logo.png">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }

    body {
      background-color: white;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      position: relative;
      padding-bottom: 200px;
    }

    .confirmation-container {
      background-color: white;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 2px 2px 10px #ff6f61;
      text-align: center;
      max-width: 650px;
    }

    .confirmation-container h1 {
      font-size: 26px;
      color: #333;
      margin-bottom: 20px;
    }

    .confirmation-container p {
      font-size: 18px;
      color: #555;
      margin-bottom: 10px;
    }

    /* Delivery scooter animation */
    .moving-image-container {
      position: fixed;
      bottom: 30px;
      width: 100%;
      height: 105px;
      pointer-events: none;
      overflow: hidden;
      z-index: 1;
    }

    .delivery-vehicle {
      position: absolute;
      left: -140px;
      bottom: 0;
      width: 125px;
      height: 100px;
      animation: rideAcrossRoad 10s linear infinite;
    }

    .delivery-rider {
      position: absolute;
      left: 47px;
      bottom: 42px;
      color: #2f4858;
      font-size: 42px;
      transform: rotate(-8deg);
    }

    .moving-image {
      position: absolute;
      left: 0;
      bottom: 0;
      color: #ff6f61;
      font-size: 72px;
      filter: drop-shadow(0 5px 2px rgba(0, 0, 0, 0.2));
    }

    @keyframes rideAcrossRoad {
      0% {
        left: -140px;
        transform: translateY(2px) rotate(-1deg);
      }
      100% {
        left: 100%;
        transform: translateY(-1px) rotate(1deg);
      }
    }

    /* Road */
    .road {
      position: fixed;
      bottom: 0px;
      width: 100%;
      height: 30px;
      background: #333;
      box-shadow: inset 0 5px 0 #555;
      z-index: 0;
    }

    .road::after {
      content: '';
      position: absolute;
      top: 50%;
      left: 0;
      width: 100%;
      height: 4px;
      background-image: repeating-linear-gradient(
        to right,
        white 0,
        white 40px,
        transparent 40px,
        transparent 80px
      );
      transform: translateY(-50%);
    }
  </style>
</head>
<body>

  <div class="confirmation-container">
    <h1>Thank You!</h1>
    <p>Your order has been placed successfully using the <strong>FoodZone</strong> app.</p>
    <p>We’re on our way to deliver happiness to your doorstep!</p>
  </div>

  <!-- Animated delivery scooter -->
  <div class="moving-image-container">
    <div class="delivery-vehicle" aria-label="Delivery person riding a scooter">
      <i class="fa-solid fa-person delivery-rider" aria-hidden="true"></i>
      <i class="fa-solid fa-motorcycle moving-image" aria-hidden="true"></i>
    </div>
  </div>

  <!-- Road -->
  <div class="road"></div>

</body>
</html>