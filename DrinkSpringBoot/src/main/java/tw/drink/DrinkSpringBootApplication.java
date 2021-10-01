package tw.drink;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan
public class DrinkSpringBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(DrinkSpringBootApplication.class, args);
	}
}
