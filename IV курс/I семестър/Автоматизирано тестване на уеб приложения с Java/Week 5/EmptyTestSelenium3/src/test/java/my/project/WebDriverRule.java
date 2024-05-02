package my.project;

import static org.junit.Assert.*;

import java.io.File;
import java.net.URL;

import org.junit.Test;
import org.junit.rules.ExternalResource;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;


public class WebDriverRule extends ExternalResource {

	private WebDriver driver;
	
    @Test
	public void openBrowser() throws Exception {
    	URL url = Thread.currentThread().getContextClassLoader().getResource("chromedriver/chromedriver.exe");
    	
    	// System.setProperty("webdriver.chrome.driver", "C:\\dev\\PU\\projects\\EmptyTestSelenium3\\src\\test\\resources\\chromedriver\\chromedriver.exe");
		System.setProperty("webdriver.chrome.driver", new File(url.getFile()).getCanonicalPath());
		driver = new ChromeDriver();
		
		driver.get("http://www.google.com");
		System.out.println(driver.getTitle());
		
		driver.close();
	}
}
