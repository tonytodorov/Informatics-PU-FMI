package sabev.test.test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrowsExactly;

import java.io.File;
import java.time.Duration;

import org.apache.commons.lang3.RandomStringUtils;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.Wait;
import org.openqa.selenium.support.ui.WebDriverWait;

import sabev.test.test.pages.HomePage;

class AutomationExerciseRegisterTests {

	WebDriver driver;

	@AfterEach
	public void afterEach() {
		driver.close();
	}
	
	@Test
	void testChromeAdBlocker() throws Exception {
		ChromeOptions options = new ChromeOptions();
		options.addExtensions(new File("C:\\Users\\PC-TONY\\Desktop\\Автоматизирано тестване на уеб приложения с Java\\Week 6\\adblock\\Adblock-Plus-—.crx"));
		driver = new ChromeDriver(options);

		String email = RandomStringUtils.randomAlphanumeric(5, 10) + "@" + RandomStringUtils.randomAlphabetic(4, 7) + ".com";
		System.out.println(email);
		
		String name = RandomStringUtils.randomAlphabetic(4, 8);
		System.out.println(name);
		
		String password = RandomStringUtils.randomAlphanumeric(4, 8);
		System.out.println(password);
		
		var homePage = new HomePage(driver);
		homePage.navigateToHomePage();
		
		var loginPage = homePage.navigateToLoginPage();
		loginPage.setName(name);
		loginPage.setEmail(email);
		
		var signupPage = loginPage.clickOnSubmit();
		signupPage.setTitleMale();
		signupPage.setPassword(password);
		signupPage.selectBirthDay("10");
		signupPage.selectBirthMonth("4");
		signupPage.selectBirthYear("1998");
		signupPage.clickOnNewsletter();
		signupPage.clickOnOptin();
		
		signupPage.setFirstName("Georgi");
		signupPage.setLastName("Sabev");
		signupPage.setAddress("bul. Svoboda 36");
		signupPage.setCountry("United States");
		signupPage.setState("Plovdiv");
		signupPage.setCity("Sofia");
		signupPage.setZipcode("4281");
		signupPage.setMobileNumber("0581285213");
		
		var accountCreatePage = signupPage.clickOnCreateAccount();
		homePage = accountCreatePage.clickOnContinue();
		
	}
}
