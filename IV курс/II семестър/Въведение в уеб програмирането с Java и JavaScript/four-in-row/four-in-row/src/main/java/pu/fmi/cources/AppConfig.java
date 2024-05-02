package pu.fmi.cources;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {
	
	@Bean
	public GameRepo gameRepo() {
		return new GameRepoInMemory();
	}
	
	
	
}
