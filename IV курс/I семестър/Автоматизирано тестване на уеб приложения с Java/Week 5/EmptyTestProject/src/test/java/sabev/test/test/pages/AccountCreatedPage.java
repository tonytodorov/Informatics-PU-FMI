package sabev.test.test.pages;

import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.WebDriverWait;

public class AccountCreatedPage extends BasePage<AccountCreatedPage>{
	
	protected By verifyPage = By.xpath("//*[contains(text(), 'Account Created!')]");
	protected By continueBtn = By.linkText("Continue");

	public AccountCreatedPage(WebDriver driver) {
		super(driver);
		new WebDriverWait(driver, Duration.ofSeconds(2)).until(d->d.findElement(verifyPage).isDisplayed());
	}
	
	public HomePage clickOnContinue() {
		webDriver.findElement(continueBtn).click();
		return new HomePage(webDriver);
	}
}
