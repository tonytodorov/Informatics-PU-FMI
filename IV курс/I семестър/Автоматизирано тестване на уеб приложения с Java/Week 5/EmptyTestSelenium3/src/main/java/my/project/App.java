package my.project;

import java.io.File;
import java.io.IOException;
import java.net.URL;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class App {
	
	public static void main(String[] args) throws IOException {
		
		WebDriver driver;
		
		URL url = Thread.currentThread().getContextClassLoader().getResource("chromedriver/chromedriver.exe");

		// System.setProperty("webdriver.chrome.driver", "C:\\dev\\PU\\projects\\EmptyTestSelenium3\\src\\test\\resources\\chromedriver\\chromedriver.exe");
		System.setProperty("webdriver.chrome.driver", new File(url.getFile()).getCanonicalPath());
		driver = new ChromeDriver();

		driver.get("http://www.google.com");
		System.out.println(driver.getTitle());

		driver.close();
	}
}
