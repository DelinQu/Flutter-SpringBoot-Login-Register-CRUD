package com.lin.service;

import com.lin.entity.ConfirmToken;
import com.lin.entity.User;
import com.lin.entity.UserProfile;
import com.lin.repository.ConfirmationTokenRepository;
import com.lin.repository.UserProfileRepository;
import com.lin.repository.UserRepository;
import com.lin.utils.myToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class RegisterService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ConfirmationTokenRepository confirmationTokenRepository;

    @Autowired
    private EmailSenderService emailSenderService;

    @Autowired
    private UserProfileRepository userProfileRepository;

    // 使用spring-security进行密码加密
    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(12);

    public String send(User user) {
        User existingUser = userRepository.findByEmail(user.getEmail());
        //如果邮箱已存在,不可注册
        if(existingUser != null) {
            if(existingUser.getIsEnabled()==0)
                return "Do not send repeatly!";
            return "existing user";
        }
        else {
            //保证已经注册的用户只能发送一次验证码
            //保存当前用户,注意设置未激活
            user.setIsEnabled(0);
            String pwd=encoder.encode(user.getPassword());
            user.setPassword(pwd);
            userRepository.save(user);

            //生成随机验证
            String token= new myToken().creatToken();

            //保存setConfirmationToken
            ConfirmToken confirmationToken = new ConfirmToken(user.getUserId(), token);
            confirmationTokenRepository.save(confirmationToken);

            //发送邮箱校验
            SimpleMailMessage mailMessage = new SimpleMailMessage();
            mailMessage.setTo(user.getEmail());
            mailMessage.setSubject("Complete Registration!");
            mailMessage.setFrom("qdl.cs@aliyun.com");
            mailMessage.setText("为完成注册认证, 请输入验证码\n\n"+token);

            //发送
            emailSenderService.sendEmail(mailMessage);
            return token;
        }
    }

    public String registerUser(User user,String token) {
        User existingUser = userRepository.findByEmail(user.getEmail());
        if(existingUser != null) {
            if(existingUser.getIsEnabled()==1)
                return "existing User";
            else {
                ConfirmToken confirmToken = confirmationTokenRepository.findByUserId(existingUser.getUserId());
                System.out.println(confirmToken);
                System.out.println(token);
                //验证成功
                if(confirmToken.getConfirmationToken().equals(token)){
                    existingUser.setIsEnabled(1);		//激活
                    existingUser.setUsername(user.getUsername());   //重新设置用户名
                    userRepository.deleteUserByEmail(existingUser.getEmail());  //先删除
                    userRepository.save(existingUser);

                    //每注册一个user就向资料表中插入一个用户资料
                    UserProfile userProfile=new UserProfile();
                    userProfile.setEmail(user.getEmail());
                    userProfile.setUsername(user.getUsername());
                    userProfileRepository.save(userProfile);
                    return "sucess";
                }
                else
                    return "badToken";
            }
        }
        else
            return "Please Send token first!";
    }
}
