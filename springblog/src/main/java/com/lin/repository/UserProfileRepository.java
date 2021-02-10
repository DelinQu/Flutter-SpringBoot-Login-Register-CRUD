package com.lin.repository;

import com.lin.entity.UserProfile;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.List;

@Transactional
public interface UserProfileRepository extends JpaRepository<UserProfile, Integer> {
    UserProfile findUserProfileByEmail(String email);

    List<UserProfile> findAllByUsernameContains(String username);

    Integer deleteUserProfileByEmail(String email);
}
