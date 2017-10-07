class ComplexNumber {
  float real;
  float imaginary;
  ComplexNumber(float real, float imaginary) {
    this.real = real;
    this.imaginary = imaginary;
  }
  void square() {
    float realTemp = real*real-imaginary*imaginary;
    imaginary = 2*imaginary*real;
    real = realTemp;
  }
  void add(ComplexNumber number) {
    real+=number.real;
    imaginary+=number.imaginary;
  }
  float absoluteValue(boolean squared) {
   float squaredValue = real*real + imaginary*imaginary;
   return squared ? squaredValue : sqrt(squaredValue);
  }
}