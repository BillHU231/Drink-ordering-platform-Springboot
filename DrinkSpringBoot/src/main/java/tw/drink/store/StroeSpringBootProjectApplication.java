	package tw.drink.store;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication

//對Web應用程式支援: Servlet、Filter與Listener撰寫(pom檔同步設定)
//預設：(scanBasePackages = "tw.leonchen") 
@ServletComponentScan //如有用到在加上
public class StroeSpringBootProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(StroeSpringBootProjectApplication.class, args);
	}

}
