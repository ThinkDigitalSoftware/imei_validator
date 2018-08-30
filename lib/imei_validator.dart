library imei_validator;

///The formula verifies a number against its included check digit,
///which is usually appended to a partial account number to
///generate the full account number. This number must pass the following test:
///
///From the rightmost digit, which is the check digit, and moving left,
///double the value of every second digit. The check digit is not doubled,
///the first digit doubled is immediately to the left of the check digit.
///If the result of this doubling operation is greater than 9 (e.g., 8 × 2 = 16),
///then add the digits of the product (e.g., 16: 1 + 6 = 7, 18: 1 + 8 = 9) or,
///alternatively, the same result can be found by subtracting 9 from the product
/// (e.g., 16: 16 − 9 = 7, 18: 18 − 9 = 9).
///Take the sum of all the digits.
///If the total modulo 10 is equal to 0 (if the total ends in zero)
///then the number is valid according to the Luhn formula; else it is not valid.
class ImeiValidator {
  String Imei;
  String _checkDigit;
  bool isValid = false;

  ImeiValidator(String number) {
    this.Imei = number.replaceAll(new RegExp(r"-|\s"), "");
    this.validate(this.Imei);
  }

  ImeiValidator.Integer(int number) {
    this.Imei = number.toString();
    this.validate(Imei);
  }

  String get checkDigit => _checkDigit;

  /// Returns the 14 digit MEID from the 15 digit IMEI
  String get Meid => Imei.substring(0, Imei.length - 1);

  ///Returns a full code (including check digit), from the specified partial code (without check digit).
  String luhnCalculate(partCode) {
    var checksum = luhnChecksum(partCode + "0");
    return (checksum == 0 ? 0 : 10 - checksum).toString();
  }

  ///Returns a json representation of the imei and its validity
  Map<String, dynamic> toJson() => {"imei": this.Imei, "valid": this.isValid};

  ///Returns a String representation of the imei and its validity
  String toString() => "IMEI: ${this.Imei}, valid: ${this.isValid}";

  ///Validates the imei before processing it.
  void validate(String number) {
    if (number.isEmpty) throw new FormatException("IMEI cannot be empty");
    if (int.tryParse(number) == null)
      throw new FormatException("IMEI must contain only digits");
    // if it gets past all of this
    if (number.length == 14) {
      // for MEIDs
      _checkDigit = luhnCalculate(number);
      this.Imei += _checkDigit;
    }
    if (number.length == 14 || number.length == 15)
      this.isValid = luhn_validate(Imei);
  }

  /// Calculates the luhn check digit based off of `code` and return it.
  static int luhnChecksum(code) {
    int len = code.length;
    num parity = len % 2;
    int sum = 0;

    for (int i = len - 1; i >= 0; i--) {
      int digit = int.parse(code[i]);
      if (i % 2 == parity) digit *= 2;

      if (digit > 9) digit -= 9;
      sum += digit;
    }
    return sum % 10;
  }

  ///Returns true if specified code (with check digit) is valid.
  static bool luhn_validate(fullCode) => luhnChecksum(fullCode) == 0;
}
