package com.lin.utils;

import org.springframework.stereotype.Component;

import java.util.Random;

// 生成4位随机验证码
@Component
public class myToken {

    private String str="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private StringBuilder token=new StringBuilder(4);

    public myToken() {
    }

    public String creatToken(){
        for(int i=0;i<4;i++)
        {
            char ch=str.charAt(new Random().nextInt(str.length()));
            token.append(ch);
        }
        return token.toString();
    }
}
