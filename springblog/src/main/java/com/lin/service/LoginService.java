package com.lin.service;
import com.lin.entity.User;
import com.lin.repository.ConfirmationTokenRepository;
import com.lin.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
    @Autowired
    private UserRepository userRepository;

    // 使用spring-security进行密码加密
    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(12);

    public String loginUser(User user) {
        User existingUser = userRepository.findByEmail(user.getEmail());
        if (existingUser != null ) {
            //邮箱未激活
            if (existingUser.getIsEnabled()==0) {
                return ("The email not verified");
            }
            //登录成功
            else if (encoder.matches(user.getPassword(), existingUser.getPassword())){
                return ("sucess");
            }
            //密码错误
            else {
                return ("Incorrect password. Try again");
            }
        }
        //未注册
        else
            return "Your Acount don't exist, Please register!";
    }
}
