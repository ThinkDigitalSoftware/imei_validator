# imei_validator


imei_validator is a library for checking IMEIs using the Luhn algorithm. 

## Installing

Add this to your package's pubspec.yaml file:
```
dependencies:
  imei_validator: any
```

If you're using the Dart Editor, choose:

```
Menu > Tools > Pub Install
```

Or if you want to install from the command line, run:

```
$ pub install
```

Now in your Dart code, you can use:

```dart
import 'package:imei_validator/imei_validator.dart';
```

## Overview

```dart
var imei = new ImeiValidator("378282246310005");
print(imei.isValid); // true
```

Note: imei_validator will automatically remove any space or dashes from the string passed to it 

### Check Digit

You can calculate a check digit by creating a new ImeiValidator and passing in an meid (14 digits). The ImeiValidator will automatically calculate the check digit and make it available via the checkDigit getter.
```dart
var imei = new ImeiValidator("37828224631000");
print(imei.checkDigit); // 5
```