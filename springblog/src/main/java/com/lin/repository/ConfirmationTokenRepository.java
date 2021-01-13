package com.lin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.lin.entity.ConfirmToken;

import javax.transaction.Transactional;

@Transactional
public interface  ConfirmationTokenRepository extends JpaRepository<ConfirmToken, Integer> {
    ConfirmToken findByUserId (long userId);
}