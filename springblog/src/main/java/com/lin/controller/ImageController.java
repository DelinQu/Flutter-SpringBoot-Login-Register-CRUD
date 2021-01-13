package com.lin.controller;

import com.lin.entity.UserProfile;
import com.lin.repository.UserProfileRepository;
import com.lin.service.UploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


@RestController
@RequestMapping("/image")
public class ImageController {
    @Autowired
    UserProfileRepository userProfileRepository;

    @Autowired
    UploadService uploadService;

    @Value("${img.imgURL}")
    private String imgURL;

    //上传图片
    //参数包括用户邮箱和文件
    @PostMapping(value="/update")
    public String update(@RequestParam("file") MultipartFile file,@RequestParam("email") String email) {
        UserProfile userProfile = userProfileRepository.findUserProfileByEmail(email);
        if(file==null) return "empty file";
        //如果用户已经存在,更新
        if(userProfile!=null){
            String indexPath=Long.toString(userProfile.getProfileId());
            //处理文件名
            int lastIndexOf = file.getOriginalFilename().lastIndexOf(".");
            //获取文件的后缀名
            String suffix = file.getOriginalFilename().substring(lastIndexOf);
            String fileName=indexPath + suffix;
            //上传
            uploadService.upload(file,fileName);
            //保存数据库映射
            userProfile.setPath(imgURL+fileName);
            //JPA
            userProfileRepository.deleteUserProfileByEmail(email);
            userProfileRepository.save(userProfile);
            return "sucess";
        }
        else
            return "Email error";
    }
}
