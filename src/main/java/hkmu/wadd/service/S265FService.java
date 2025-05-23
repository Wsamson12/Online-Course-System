package hkmu.wadd.service;

import hkmu.wadd.model.S265F;
import hkmu.wadd.repository.S265FRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import jakarta.transaction.Transactional;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.List;

@Service
public class S265FService {
    private static final Logger logger = LoggerFactory.getLogger(S265FService.class);
    @Autowired
    private S265FRepository s265FRepository;

    @Value("${upload.directory}")
    private String uploadDirectory;

    @Transactional
    public void addFile(S265F s265F, MultipartFile file) throws IOException {
        Path uploadPath = Paths.get(uploadDirectory);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String fileName = file.getOriginalFilename();
        Path filePath = uploadPath.resolve(fileName);
        Files.write(filePath, file.getBytes());

        s265F.setFileName(fileName);
        s265F.setFileUrl("/HelloSpringSecurity/download/" + fileName);

        s265FRepository.save(s265F);
    }

    public List<S265F> getAllFiles() {
        return s265FRepository.findAll();
    }
    @Transactional
    public void deleteFile(Long fileId) {
        S265F file = s265FRepository.findById(fileId)
                .orElseThrow(() -> new RuntimeException("File not found with id: " + fileId));
        Path filePath = Paths.get(uploadDirectory).resolve(file.getFileName()).normalize();
        try {
            Files.deleteIfExists(filePath); // Delete the file from the filesystem
        } catch (IOException e) {
            logger.error("Failed to delete file from filesystem: {}", e.getMessage());
        }
        s265FRepository.delete(file);
    }


}