package com.fooddelivery.dto;

import java.util.Set;

public record AuthenticationResponse(String token, String tokenType, String email, Set<String> roles) {
}