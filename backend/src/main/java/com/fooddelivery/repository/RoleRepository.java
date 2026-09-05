package com.fooddelivery.repository;

import com.fooddelivery.entity.Role;
import com.fooddelivery.entity.RoleName;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Long> {

    Optional<Role> findByName(RoleName name);
}