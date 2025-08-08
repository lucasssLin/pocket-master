package com.ruoyi.file.service;

import org.springframework.web.multipart.MultipartFile;

public interface ISysFileMinioService {
    public String uploadFileMinio(MultipartFile file, String prefix) throws Exception;
}
