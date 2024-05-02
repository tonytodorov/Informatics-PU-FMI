package sabev.test.test.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class HomePage extends BasePage<HomePage> {
	
	private By verifyUserFixedPath = By.xpath("//*[contains(text(), 'Logged in as')]");
	private By verifyUserNamePath = By.xpath("//*[contains(text(), 'Logged in as')]");

	public HomePage(WebDriver driver) {
		super(driver);
	}
	
	public String getLoggedUser(String userName) {
		String usrNameSelector = "//*[contains(text(), '"+userName+"')]";
		return "";
	}
	
	
}
