package hkmu.wadd.controller;

import hkmu.wadd.model.S265F;
import hkmu.wadd.model.S265Fcomment;
import hkmu.wadd.service.S265FCommentService;
import hkmu.wadd.service.S265FService;
import jakarta.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
public class S265FController {

    private static final Logger logger = LoggerFactory.getLogger(S265FController.class);
    @Autowired
    private S265FCommentService s265FCommentService;
    @Autowired
    private S265FService s265FService;

    @Value("${upload.directory}")
    private String uploadDirectory;

    @GetMapping("/teacher/S265F")
    public String redirectToIndex(Model model, @RequestParam(value = "lang", defaultValue = "en") String lang)  {
        logger.info("Accessed /S265F endpoint");
        List<S265F> files = s265FService.getAllFiles();
        model.addAttribute("files", files);
        // Fetch all comments and add to model
        List<S265Fcomment> comments = s265FCommentService.findAll();
        model.addAttribute("comments", comments);
        if ("zh".equals(lang)) {
            return "teacher/S265F_zh";
        }
        return "teacher/S265F";    
    
    }

    @GetMapping("/upload")
    public String redirectToUploadPage() {
        logger.info("Accessed /upload endpoint, redirecting to /S265F");
        return "redirect:/S265F";
    }



@PostMapping("/upload")
public String uploadFile(
        @RequestParam("title") String title,
        @RequestParam("attachments") MultipartFile[] attachments,
        RedirectAttributes redirectAttributes) {
    logger.info("Processing upload request with title: {}", title);
    if (attachments == null || attachments.length == 0) {
        logger.warn("No files uploaded!");
        redirectAttributes.addFlashAttribute("error", "No files uploaded!");
        return "redirect:/teacher/S265F"; // Redirect to teacher/addcourse
    }

    try {
        for (MultipartFile file : attachments) {
            if (!file.isEmpty()) {
                S265F s265F = new S265F();
                s265F.setTitle(title); // Same title for all files in this upload
                s265FService.addFile(s265F, file);
                logger.info("Uploaded file: {}", file.getOriginalFilename());
            }
        }
        redirectAttributes.addFlashAttribute("success", "Files uploaded successfully!");
        logger.info("Files uploaded successfully");
    } catch (Exception e) {
        logger.error("Failed to upload files: {}", e.getMessage());
        redirectAttributes.addFlashAttribute("error", "Failed to upload files: " + e.getMessage());
    }

    return "redirect:/teacher/S265F"; // Redirect to teacher/addcourse
}


    @GetMapping("/download/{fileName}")
    public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) throws IOException {
        logger.info("Downloading file: {}", fileName);
        Path filePath = Paths.get(uploadDirectory).resolve(fileName).normalize();
        Resource resource = new UrlResource(filePath.toUri());
        if (resource.exists() && resource.isReadable()) {
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);
        } else {
            logger.error("File not found: {}", fileName);
            return ResponseEntity.notFound().build();
        }
    }
    @PostMapping("/teacher/S265F/submit_Comment")
    public String submitComment(@RequestParam("comment") String content, Model model) {
        // Get the currently logged-in username
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = userDetails.getUsername();

        // Create a new comment
        S265Fcomment comment = new S265Fcomment();
        comment.setUsername(username);
        comment.setContent(content);

        // Save the comment to the database
        s265FCommentService.save(comment);

        // Redirect back to the S265F page to refresh comments
        return "redirect:/teacher/S265F";
    }
    @PostMapping("/teacher/filedelete")
    public String deleteFile(@RequestParam("fileId") Long fileId, RedirectAttributes redirectAttributes) {
        logger.info("Processing delete request for fileId: {}", fileId);
        try {
            s265FService.deleteFile(fileId);
            redirectAttributes.addFlashAttribute("success", "File deleted successfully!");
            logger.info("File deleted successfully with id: {}", fileId);
        } catch (Exception e) {
            logger.error("Failed to delete file with id {}: {}", fileId, e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Failed to delete file: " + e.getMessage());
        }
        return "redirect:/teacher/S265F";
    }

    @PostMapping("/teacher/S265F/deleteComment")
public String deleteComment(@RequestParam("commentId") Long commentId) {
    s265FCommentService.deleteComment(commentId);
    return "redirect:/teacher/S265F";
}
    
}