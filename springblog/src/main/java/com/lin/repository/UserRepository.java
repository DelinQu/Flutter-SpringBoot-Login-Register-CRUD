package com.lin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.lin.entity.User;

import javax.transaction.Transactional;

@Transactional
public  interface  UserRepository extends JpaRepository<User, Integer>{
    User findByEmail(String email);

    Integer deleteUserByEmail(String email);
}
