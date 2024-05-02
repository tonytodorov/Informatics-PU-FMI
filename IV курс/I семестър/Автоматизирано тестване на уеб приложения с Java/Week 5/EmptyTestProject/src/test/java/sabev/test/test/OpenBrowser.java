package sabev.test.test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrowsExactly;

import java.time.Duration;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.Wait;
import org.openqa.selenium.support.ui.WebDriverWait;

class OpenBrowser {

  WebDriver driver;

  @AfterEach
  public void afterEach() {
    driver.close();
  }

  @Test
  void testSleepMissingElement() throws InterruptedException {
    driver = new FirefoxDriver();
    driver.manage().window().fullscreen();

    driver.get("https://www.selenium.dev/selenium/web/dynamic.html");

    WebElement boxAdder = driver.findElement(By.id("adder"));
    boxAdder.click();

    assertThrowsExactly(
        NoSuchElementException.class, () -> driver.findElement(By.id("box0")).isDisplayed());
  }

  @Test
  void testImplicitlyWaitForSingleElement() throws InterruptedException {
    driver = new FirefoxDriver();
    driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
    driver.manage().window().fullscreen();

    driver.get("https://www.selenium.dev/selenium/web/dynamic.html");

    WebElement boxAdder = driver.findElement(By.id("adder"));
    boxAdder.click();
    Wait<WebDriver> wait = new WebDriverWait(driver, Duration.ofSeconds(5));
    wait.until(d -> driver.findElement(By.id("box0")).isDisplayed());

    assertEquals(true, driver.findElement(By.id("box0")).isDisplayed());
  }

  @Test
  void testImplicitlyWaitForAllElement() throws InterruptedException {
    driver = new FirefoxDriver();
    driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
    driver.manage().window().fullscreen();

    driver.get("https://www.selenium.dev/selenium/web/dynamic.html");

    WebElement boxAdder = driver.findElement(By.id("adder"));
    boxAdder.click();

    assertEquals(true, driver.findElement(By.id("box0")).isDisplayed());
  }

  @Test
  void testSleep() throws InterruptedException {
    driver = new FirefoxDriver();
    driver.manage().window().fullscreen();

    driver.get("https://www.selenium.dev/selenium/web/dynamic.html");

    WebElement boxAdder = driver.findElement(By.id("adder"));
    boxAdder.click();
    Thread.sleep(2000);

    assertEquals(true, driver.findElement(By.id("box0")).isDisplayed());
  }

  @Test
  void testDemoqaWebFormSuccesfully() throws InterruptedException {
    driver = new FirefoxDriver();
    driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
    driver.manage().window().fullscreen();

    driver.get("https://demoqa.com/automation-practice-form");

    driver.findElement(By.id("firstName")).sendKeys("Test");
    driver.findElement(By.id("lastName")).sendKeys("Ivanov");
    driver.findElement(By.id("userEmail")).sendKeys("username@example.com");

    WebElement genderRadioButton = driver.findElement(By.xpath("//label[@for='gender-radio-1']"));
    genderRadioButton.click();

    driver.findElement(By.id("userNumber")).sendKeys("0881234567");

    WebElement dataPicker = driver.findElement(By.id("dateOfBirthInput"));
    dataPicker.click();

    Select yearSelect =
        new Select(driver.findElement(By.className("react-datepicker__year-select")));
    yearSelect.selectByValue("2001");
    
    Select monthSelect =
        new Select(driver.findElement(By.className("react-datepicker__month-select")));
    
    monthSelect.selectByValue("10");

    WebElement day =
        driver.findElement(
            By.xpath("//div[@class='react-datepicker__day react-datepicker__day--016']"));
    day.click();

    WebElement hobbies = driver.findElement(By.xpath("//label[@for='hobbies-checkbox-3']"));
    hobbies.click();

        driver
            .findElement(By.id("uploadPicture"))
            .sendKeys("C:\\Users\\ts.ivanov\\Documents\\uni\\specs.txt");

    driver.findElement(By.id("submit")).submit();

    assertEquals(
        true,
        driver
            .findElement(By.xpath("//div[text()='Thanks for submitting the form']"))
            .isDisplayed());
  }

  @Test
  void testSeleniumWebFormSuccesfully() throws InterruptedException {
    driver = new FirefoxDriver();
    driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
    driver.manage().window().fullscreen();

    driver.get("https://www.selenium.dev/selenium/web/web-form.html");

    WebElement textInputElement = driver.findElement(By.id("my-text-id"));
    textInputElement.sendKeys("some text");

    WebElement passwordInputElement = driver.findElement(By.name("my-password"));
    passwordInputElement.sendKeys("some password");

    WebElement textAreaInputElement = driver.findElement(By.name("my-textarea"));
    textAreaInputElement.sendKeys("some textarea");

    Select formSelect = new Select(driver.findElement(By.name("my-select")));
    formSelect.selectByValue("2");

    driver.findElement(By.cssSelector("button")).click();

    assertEquals("Received!", driver.findElement(By.id("message")).getText());
  }

  //	 @Test
  //	    public void testLocalChrome() throws InterruptedException {
  //		  WebDriver driver = new ChromeDriver();
  //	       driver.get("http://www.mobile.bg");
  //	       System.out.println(driver.getCurrentUrl());
  //	       Thread.sleep(10000L);
  //	       driver.close();
  //	    }

  //	    @Test
  //	    public void testLocalEdge() throws InterruptedException {
  //	    	 WebDriver driver = new EdgeDriver();
  //	    	 driver.get("http://www.google.com");
  //		     System.out.println(driver.getCurrentUrl());
  //		     Thread.sleep(10000L);
  //		     driver.close();
  //	    }
}
