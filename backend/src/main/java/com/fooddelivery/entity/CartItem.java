package com.fooddelivery.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "cart_items")
public class CartItem extends BaseEntity {

    @Column(nullable = false)
    private Integer quantity;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cart_id", nullable = false)
    private Cart cart;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "food_item_id", nullable = false)
    private FoodItem foodItem;

    protected CartItem() { }

    public CartItem(Cart cart, FoodItem foodItem, Integer quantity) {
        this.cart = cart;
        this.foodItem = foodItem;
        this.quantity = quantity;
    }

    public Integer getQuantity() { return quantity; }
    public Cart getCart() { return cart; }
    public FoodItem getFoodItem() { return foodItem; }
}