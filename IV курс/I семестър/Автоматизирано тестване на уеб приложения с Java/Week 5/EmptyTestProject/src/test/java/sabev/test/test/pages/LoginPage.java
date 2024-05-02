package sabev.test.test.pages;

import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.WebDriverWait;

public class LoginPage extends BasePage<LoginPage>{
	
	protected By verifyPage = By.xpath("//*[contains(text(), 'New User Signup!')]");
	protected By nameTxt = By.name("name");
	protected By emailTxt = By.xpath("//input[@data-qa='signup-email']");
	protected By signUpBtn = By.xpath("//button[@data-qa='signup-button']");
	
	public LoginPage(WebDriver driver) {
		super(driver);
		new WebDriverWait(driver, Duration.ofSeconds(2)).until(d->d.findElement(verifyPage).isDisplayed());
	}
	
	public void setName(String name) {
		webDriver.findElement(nameTxt).sendKeys(name);
	}
	
	public void setEmail(String email) {
		webDriver.findElement(emailTxt).sendKeys(email);
	}
	
	public SignupPage clickOnSubmit() {
		webDriver.findElement(signUpBtn).click();
		return new SignupPage(webDriver);
	}
}
