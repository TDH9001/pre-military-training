# This application is made to facilitate attendance taking and documentation of the attendance on a daily baisis
 Repo link : https://github.com/TDH9001/pre-military-training
 dev contact info:
   phone number  : 01206822202
   name : mohamed yehia mohamed 
   
 1. the first app
    Which is the QR generator app
    other than it being a simple screen with some text and a form that is validated to fulfill the basic requirements of the fields
    The 2 things that are important in this app are the encryption and QR code generation
    a. The QR generator
      using  qr_flutter: ^4.1.0 :  https://pub.dev/packages/qr_flutter
    using this widget{
        QrImageView(
                  data: encrypted.base64,
                  version: QrVersions.auto,
                  size: 300,
                ),
    }
    b. the Encryption
      i used basic 16-character AES encryption
      from   encrypt: ^5.0.3 : https://pub.dev/packages/encrypt
      using this code for getting the encrypted String of items
      where the plain Text is formatted as the items in the fields and a "|||" as a delimiter for the String.split(string , "|||") function
      which can be found on the " qr_data_model " file
      using this function override
        {
          String toString() {
            return "$student_name ||| $national_id ||| $serial_number |||  $student_phone_number |||  $faculty |||  $address";
            }
        }
      using this logic
        {
          var key = enc.Key.fromUtf8("8332767606048159");
          "8332767606048159";
          final iV = enc.IV.fromBase16(key.base16);
          final encrypter = enc.Encrypter(enc.AES(key));
      final encrypted = encrypter.encrypt(s, iv: iV);
      // final decripted = encrypter.decrypt64(encrypted.base64, iv: iV);
        }
    
      and the String "s" here is the plain text mentioned earlier


2. The Attendance Taker
   This app, on the other hand, is responsible for the attendance, leave, and generating a .json file with the recorded data
   which scans the QR code provided > checks if the decrypted plaintext is in the same format as the expected plaintext from the first app > (code for description is mentioned in the first app)
   using the following dependancies/pacages
    mobile_scanner: ^7.0.0 : https://pub.dev/packages/mobile_scanner
    encrypt: ^5.0.3 : https://pub.dev/packages/encrypt
    hive: ^2.2.3 :  https://pub.dev/packages/hive
    hive_flutter: ^1.1.0 : (https://pub.dev/packages/hive_flutter)
    external_path: ^2.2.0 : https://pub.dev/packages/external_path)

   The logic is simple and should not be problematic to understand
   i tried to comment and log the whole process in the code , in addition to a history of commits 
   
   
    
