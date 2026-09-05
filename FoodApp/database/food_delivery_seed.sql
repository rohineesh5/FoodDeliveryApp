USE food;

SET @paradise_id = (
    SELECT restaurantid
    FROM restaurant
    WHERE LOWER(name) = 'paradise biryani'
    LIMIT 1
);

INSERT INTO menu (restaurantid, itemname, description, price, isavailable, ratings, imagepath)
SELECT @paradise_id, 'Chicken Dum Biryani', 'Aromatic basmati rice layered with tender chicken, saffron, and fried onions.', 260, 'Available', 4.8, 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=900&auto=format&fit=crop'
WHERE @paradise_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM menu WHERE restaurantid = @paradise_id AND itemname = 'Chicken Dum Biryani');

INSERT INTO menu (restaurantid, itemname, description, price, isavailable, ratings, imagepath)
SELECT @paradise_id, 'Mutton Biryani', 'Slow-cooked mutton with fragrant rice, whole spices, and fresh herbs.', 340, 'Available', 4.7, 'https://images.unsplash.com/photo-1517244683847-7456b63c5969?w=900&auto=format&fit=crop'
WHERE @paradise_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM menu WHERE restaurantid = @paradise_id AND itemname = 'Mutton Biryani');

INSERT INTO menu (restaurantid, itemname, description, price, isavailable, ratings, imagepath)
SELECT @paradise_id, 'Egg Biryani', 'Spiced basmati rice served with boiled eggs, caramelized onions, and mint.', 210, 'Available', 4.5, 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=900&auto=format&fit=crop'
WHERE @paradise_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM menu WHERE restaurantid = @paradise_id AND itemname = 'Egg Biryani');

INSERT INTO menu (restaurantid, itemname, description, price, isavailable, ratings, imagepath)
SELECT @paradise_id, 'Paneer Biryani', 'A rich vegetarian biryani with paneer, vegetables, saffron, and mint.', 230, 'Available', 4.4, 'https://images.unsplash.com/photo-1563379091339-03246963d96c?w=900&auto=format&fit=crop'
WHERE @paradise_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM menu WHERE restaurantid = @paradise_id AND itemname = 'Paneer Biryani');

INSERT INTO menu (restaurantid, itemname, description, price, isavailable, ratings, imagepath)
SELECT @paradise_id, 'Chicken 65', 'Crispy, spicy fried chicken tossed with curry leaves and green chillies.', 220, 'Available', 4.6, 'https://images.unsplash.com/photo-1601050690117-94f5f6fa8bd7?w=900&auto=format&fit=crop'
WHERE @paradise_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM menu WHERE restaurantid = @paradise_id AND itemname = 'Chicken 65');

INSERT INTO menu (restaurantid, itemname, description, price, isavailable, ratings, imagepath)
SELECT @paradise_id, 'Mirchi Ka Salan', 'Hyderabadi peanut and sesame chilli curry, perfect with biryani.', 140, 'Available', 4.3, 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=900&auto=format&fit=crop'
WHERE @paradise_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM menu WHERE restaurantid = @paradise_id AND itemname = 'Mirchi Ka Salan');

SELECT menuid, restaurantid, itemname, price, isavailable, ratings
FROM menu
WHERE restaurantid = @paradise_id
ORDER BY menuid;
