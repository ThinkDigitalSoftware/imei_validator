library imei_validator_test;

import 'dart:convert' show json;

import 'package:imei_validator/imei_validator.dart';
import 'package:unittest/unittest.dart';

main() {
  //test 1
  test("Should remove any dashs and space from the IMEI", () {
    var imei = new ImeiValidator("1-2-3-2-1 3-2-1-7");
    expect(imei.Imei, equals("123213217"));
  });

  //test 2
  test("Should throw error when string is not a number", () {
    expect(() => new ImeiValidator("Not a Number"), throwsFormatException);
  });

  //test 3
  test("Should throw error when string is empty", () {
    expect(() => new ImeiValidator(""), throwsFormatException);
  });

  //test 4
  test("Should return true for a valid IMEI", () {
    var imei = new ImeiValidator("123213217");
    expect(imei.isValid, equals(false));
  });

  //test 5
  test("Should return true for a valid IMEI", () {
    var imei = new ImeiValidator("12321321");
    expect(imei.isValid, equals(false));
  });

  //test 6
  test("Should return JSON object", () {
    var imei = new ImeiValidator("5232132174");
    expect(json.encode(imei), equals('{"imei":"5232132174","valid":false}'));
  });

  //test 7
  test("Should return String", () {
    var imei = new ImeiValidator("5232132174");
    expect(imei.toString(), equals('IMEI: 5232132174, valid: false'));
  });

  //test 8
  test("Should return true for a valid IMEI", () {
    var imei = new ImeiValidator("356233095475163");
    expect(imei.isValid, equals(true));
  });

  //test 9
  test("Should return false for an invalid IMEI", () {
    var imei = new ImeiValidator("356233095475143");
    expect(imei.isValid, equals(false));
  });

  //test 10
  test("Should return the correct check digit for a 14 digit identifier", () {
    var imei = new ImeiValidator("37828224631000");
    expect(imei.checkDigit, equals('5'));
  });

  //test 11
  test("Should return the meid (14 digit identifier)", () {
    var imei = new ImeiValidator("356233095475163");
    expect(imei.Meid, equals("35623309547516"));
  });

  //test 12
  test("Should return null for non-valid IMEIs", () {
    var imei = new ImeiValidator("1-2-3-2-1 3-2-1-7");
    expect(imei.checkDigit, equals(null));
  });
}
