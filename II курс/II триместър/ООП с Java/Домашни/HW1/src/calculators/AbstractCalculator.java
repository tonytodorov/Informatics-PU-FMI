package calculators;

import digits.BinaryDigit;
import processor.MathCalculator;

public abstract class AbstractCalculator {

    public abstract Digit add(Digit a, Digit b);
    public abstract Digit addMulti(Digit ...collection);
    public abstract Digit sub(Digit a, Digit b);
    public abstract Digit subMulti(Digit ...collection);
    public abstract Digit mul(Digit a, Digit b);
    public abstract Digit mulMulti(Digit ...collection);

    public abstract Digit div(Digit a, Digit b);
    public abstract Digit divMulti(Digit ...collection);


    public void renderNative(BinaryDigit addResult) {
        BinaryDigit a = new BinaryDigit("0101");
        MathCalculator calculator = new MathCalculator();
    }

    public void renderHex(Digit addResult) {
        BinaryDigit a = new BinaryDigit("0101");
        MathCalculator calculator = new MathCalculator();
    }

    public void renderDecimal(BinaryDigit addResult) {
        BinaryDigit a = new BinaryDigit("0101");
        MathCalculator calculator = new MathCalculator();
    }

    public void nativeRender(Digit addResult) {
        BinaryDigit a = new BinaryDigit("0101");
        MathCalculator calculator = new MathCalculator();
    }

    public void decimalRender(Digit addResult) {
        BinaryDigit a = new BinaryDigit("0101");
        MathCalculator calculator = new MathCalculator();
    }

    public void hexRender(Digit addResult) {
        BinaryDigit a = new BinaryDigit("0101");
        MathCalculator calculator = new MathCalculator();
    }

    public void octRender(Digit addResult) {
        BinaryDigit a = new BinaryDigit("0101");
        MathCalculator calculator = new MathCalculator();
    }

    public void binaryRender(Digit addResult) {
        BinaryDigit a = new BinaryDigit("0101");
        MathCalculator calculator = new MathCalculator();
    }

    public void renderBinary(BinaryDigit addResult) {
        BinaryDigit a = new BinaryDigit("0101");
        MathCalculator calculator = new MathCalculator();

    }

    public void renderOct(BinaryDigit addResult) {
        BinaryDigit a = new BinaryDigit("0101");
        MathCalculator calculator = new MathCalculator();
    }
}
