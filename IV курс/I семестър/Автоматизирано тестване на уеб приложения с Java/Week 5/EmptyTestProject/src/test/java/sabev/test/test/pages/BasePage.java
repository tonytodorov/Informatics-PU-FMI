package sabev.test.test.pages;

import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.WebDriverWait;

public abstract class BasePage<T> {

	protected WebDriver webDriver; 
	protected By loginLink = By.xpath("//a[@href='/login']");
	
	public BasePage(WebDriver driver) {
		webDriver = driver;
	}
	
	public LoginPage navigateToLoginPage() {
		webDriver.findElement(loginLink).click();
		return new LoginPage(webDriver);
	}
	
	public HomePage navigateToHomePage() {
		webDriver.navigate().to("https://automationexercise.com/");
		new WebDriverWait(webDriver, Duration.ofSeconds(2)).until(wd->wd.getTitle()).equalsIgnoreCase("Automation Exercise");
		webDriver.getTitle().equalsIgnoreCase("Automation Exercise");
		
		return new HomePage(webDriver); 
	}
	
}
