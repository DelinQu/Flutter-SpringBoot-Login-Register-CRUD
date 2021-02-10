package com.lin.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "user_profile")
public class UserProfile {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="profile_id")
    private long profileId;

    @Column(name="emial")
    private String email;

    @Column(name="username")
    private String username;

    @Column(name="name")
    private String name;

    @Column(name="telephone")
    private String telephone;

    @Column(name="age")
    private Integer age;

    @Column(name="job")
    private String job;

    @Column(name="path")
    private String path;

}
