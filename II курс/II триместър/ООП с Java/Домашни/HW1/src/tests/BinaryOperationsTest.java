package tests;

import calculators.AbstractCalculator;
import digits.BinaryDigit;

public class BinaryOperationsTest {

    public static void test(AbstractCalculator calculator) {

        BinaryDigit a = new BinaryDigit("1101");
        BinaryDigit b = new BinaryDigit("0001");

        BinaryDigit addResult = (BinaryDigit) calculator.add(a, b);
        calculator.renderNative(addResult);
        calculator.renderDecimal(addResult);

        BinaryDigit subResult = (BinaryDigit) calculator.sub(a, b);
        calculator.renderNative(addResult);
        calculator.renderDecimal(addResult);

        BinaryDigit mulResult = (BinaryDigit) calculator.mul(a, b);
        calculator.renderNative(addResult);
        calculator.renderDecimal(addResult);

        BinaryDigit divResult = (BinaryDigit) calculator.div(a, b);
        calculator.renderNative(addResult);
        calculator.renderDecimal(addResult);
    }
}