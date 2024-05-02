package processor;

import calculators.AbstractCalculator;
import calculators.Digit;
import digits.BinaryDigit;

public class MathCalculator extends AbstractCalculator {


    @Override
    public Digit add(Digit a, Digit b) {
        return null;
    }

    @Override
    public Digit addMulti(Digit... collection) {
        return null;
    }

    public Digit sub(Digit a, Digit b) {
        return null;
    }

    @Override
    public Digit subMulti(Digit... collection) {
        return null;
    }

    public Digit mul(Digit a, Digit b) {
        return null;
    }

    @Override
    public Digit mulMulti(Digit... collection) {
        return null;
    }

    public Digit div(Digit a, Digit b) {
        return null;
    }

    @Override
    public Digit divMulti(Digit... collection) {
        return null;
    }

    public void renderHex(Digit digit) {
        BinaryDigit a = new BinaryDigit("0101");
        MathCalculator calculator = new MathCalculator();
        calculator.nativeRender(a);
    }
}
