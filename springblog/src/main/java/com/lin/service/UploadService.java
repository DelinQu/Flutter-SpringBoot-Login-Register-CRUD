package com.lin.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
public class UploadService {

    @Value("${upload.dir}")
    private String uploadDir;

    @Transactional
    public String upload(@RequestParam("file") MultipartFile file, String fileName) {
        if (file.isEmpty()) {
            return "empty";
        }
        try {
            byte[] bytes = file.getBytes();
            //组合成文件名
            Path path = Paths.get(uploadDir +fileName);
            //写入服务器
            Files.write(path, bytes);
        }catch (Exception e) {
            return "error";
        }
        return "sucess";
    }
}
