package tw.drink.store.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@ComponentScan(basePackages = {"tw.drink"})
@EnableJpaRepositories(basePackages = "tw.drink")
public class JpaConfig {
	
	

}
