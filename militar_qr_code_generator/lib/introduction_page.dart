import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              child: Center(
                child: Text(
                  """
    📋 تعليمات التسجيل في دورة الخدمة العسكرية: \n
                  من فضلك جهّز البيانات التالية قبل البدء:\n
                  - الاسم رباعي.\n
                  - الرقم القومي.\n
                  - رقم الهاتف.\n
                  - العنوان بالتفصيل.\n
                  - صورة شخصية واضحة.\n
تأكد من إدخال البيانات بدقة، لأنه سيتم استخدامها في إجراءات التسجيل الرسمية.\n
                  
بعد إدخال البيانات، سيتم توليد كود QR يحتوي على المعلومات بشكل مشفر.\n
                  
يجب حفظ الكود QR، لأنه سيتم استخدامه لاحقاً في تطبيق التحقق لعرض بياناتك.\n
                  
جميع البيانات تظل محفوظة على الجهاز بشكل آمن بدون اتصال بالإنترنت.\n
                  
في حال وجود أي خطأ في البيانات، قم بإعادة إدخالها قبل إنشاء الكود.
                  
في حاله ادخال معلومات غير صحيحه قد يؤدي الي الغاء الدوره بسبب تسجيل غياب خاطئ.
                  """,
                  style: TextStyle(fontSize: 18),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/form');
                  },
                  child: Text("ادخال البيانات"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
