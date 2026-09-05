package com.fooddelivery.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "restaurants")
public class Restaurant extends BaseEntity {

    @Column(nullable = false, length = 120)
    private String name;

    @Column(length = 500)
    private String description;

    @Column(nullable = false, length = 30)
    private String phone;

    @Column(nullable = false)
    private Boolean active = true;

    @ManyToOne(fetch = jakarta.persistence.FetchType.LAZY, optional = false)
    @JoinColumn(name = "owner_id", nullable = false)
    private User owner;

    protected Restaurant() { }

    public Restaurant(String name, String description, String phone, User owner) {
        this.name = name;
        this.description = description;
        this.phone = phone;
        this.owner = owner;
    }

    public String getName() { return name; }
    public String getDescription() { return description; }
    public String getPhone() { return phone; }
    public Boolean getActive() { return active; }
    public User getOwner() { return owner; }
}