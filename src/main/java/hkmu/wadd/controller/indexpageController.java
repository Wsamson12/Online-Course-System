package hkmu.wadd.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class indexpageController {
    @GetMapping("/")
    public String redirectToIndex(@RequestParam(value = "lang", defaultValue = "en") String lang) {
        //return "index"; // This returns the view name for index.jsp
        if ("zh".equals(lang)) {
            return "index_zh";
        }
        return "index";
    }
}
