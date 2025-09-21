package com.example;
import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.web.bind.annotation.*;

@SpringBootApplication
@RestController
public class App {
  @GetMapping("/hello")
  public String hello(@RequestParam(defaultValue="world") String name){
    return "Hello " + name;
  }
  public static void main(String[] args){ SpringApplication.run(App.class, args); }
}
