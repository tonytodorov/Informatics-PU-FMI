package tests;

import calculators.AbstractCalculator;
import calculators.Digit;
import digits.BinaryDigit;
import digits.DecimalDigit;

public class MixOperationTest {

    public static void test(AbstractCalculator calculator) {

        Digit a   = new BinaryDigit("1101");
        Digit b  = new DecimalDigit("10574");
        BinaryDigit addResult = (BinaryDigit) calculator.add(a, b);
        calculator.renderNative(addResult);
        calculator.renderDecimal(addResult);

        DecimalDigit subResult = (DecimalDigit) calculator.sub(a, b);
        calculator.renderNative(addResult);
        calculator.renderBinary(addResult);

        BinaryDigit mulResult = (BinaryDigit) calculator.mul(a, b);
        calculator.renderNative(addResult);
        calculator.renderOct(addResult);

        DecimalDigit divResult = (DecimalDigit) calculator.div(a, b);
        calculator.renderNative(addResult);
        calculator.renderHex(addResult);
    }
}
