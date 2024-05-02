package sabev.test.test.pages;

import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

public class SignupPage extends BasePage<LoginPage>{
	
	protected By verifyPage = By.xpath("//*[contains(text(), 'Enter Account Information')]");
	
	private By titleMale = By.id("id_gender1");	
	private By titleFemale = By.id("id_gender2");
	private By password = By.id("password");
	
	private By days = By.id("days");
	private By months = By.id("months");
	private By years = By.id("years");
	
	private By newsletter = By.id("newsletter");
	private By optin = By.id("optin");
	
	private By firstName = By.id("first_name");	
	private By lastName = By.id("last_name");
	private By address1 = By.id("address1");
	private By country = By.id("country");
	private By state = By.id("state");
	private By city = By.id("city");
	private By zipcode = By.id("zipcode");
	private By mobileNumber = By.id("mobile_number");
	
	private By createAccountBtn = By.xpath("//button[contains(text(), 'Create Account')]");
	
	public SignupPage(WebDriver driver) {
		super(driver);
		new WebDriverWait(driver, Duration.ofSeconds(2)).until(d->d.findElement(verifyPage).isDisplayed());
	}
	
	public void setTitleMale() {
		webDriver.findElement(titleMale).click();
	}	

	public void setPassword(String password) {
		webDriver.findElement(this.password).sendKeys(password);
	}

	public void selectBirthDay(String day) {
		Select dayOfBirth = new Select(webDriver.findElement(days));
		dayOfBirth.selectByValue(day);
	}

	public void selectBirthMonth(String month) {
		Select monthOfBirth = new Select(webDriver.findElement(months));
		monthOfBirth.selectByValue(month);
	}
	
	public void selectBirthYear(String year) {
		Select yearOfBirth = new Select(webDriver.findElement(years));
		yearOfBirth.selectByValue(year);
	}
	
	public void clickOnNewsletter() {
		webDriver.findElement(newsletter).click();
	}
	
	public void clickOnOptin() {
		webDriver.findElement(optin).click();
	}
	
	public void setFirstName(String firstName) {
		webDriver.findElement(this.firstName).sendKeys(firstName);
	}

	public void setLastName(String lastName) {
		webDriver.findElement(this.lastName).sendKeys(lastName);
	}

	public void setAddress(String address1) {
		webDriver.findElement(this.address1).sendKeys(address1);
	}
	
	public void setCountry(String country) {
		Select countrySlb = new Select(webDriver.findElement(this.country));
		countrySlb.selectByValue(country);
	}
	
	public void setState(String state) {
		webDriver.findElement(this.state).sendKeys(state);
	}
	
	public void setCity(String city) {
		webDriver.findElement(this.city).sendKeys(city);
	}
	
	public void setZipcode(String zipcode) {
		webDriver.findElement(this.zipcode).sendKeys(zipcode);
	}
	
	public void setMobileNumber(String mobileNumber) {
		webDriver.findElement(this.mobileNumber).sendKeys(mobileNumber);
	}
	
	public AccountCreatedPage clickOnCreateAccount() {
		webDriver.findElement(createAccountBtn).click();
		return new AccountCreatedPage(webDriver);
	}
}
