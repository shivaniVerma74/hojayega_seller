import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../Helper/color.dart';
import 'SignUpPersonal.dart';

class VerifyOtp extends StatefulWidget {
  final OTP;
  const VerifyOtp({super.key, this.OTP});

  @override
  State<VerifyOtp> createState() => _OtpState();
}
class _OtpState extends State<VerifyOtp> {
  final _formKey = GlobalKey<FormState>();

  var pin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, color:Colors.white, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color:colors.primary,
        border: Border.all(color: colors.primary,),
        borderRadius: BorderRadius.circular(6),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color:  colors.primary,),
      borderRadius: BorderRadius.circular(6),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color:  colors.primary,
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                        'assets/images/otp verification – 3.png',),)),
              ],
            ),
            const Form(
              child: Positioned(
                  top: 30,
                  left: 20,
                  child: Text('OTP verification', style: TextStyle(fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
            ),
            const Positioned(
                top: 80,
                left: 20,
                right: 20,
                child: Text(
                    'Please enter received VerifyOtp on your mobile number to continue.',
                    style: TextStyle(fontSize: 14,
                        fontWeight: FontWeight.bold, color: Colors.white))),
            Positioned(
                top: 150,
                left: 50,
                right: 50,
                child: Image.asset("assets/images/OTP VERIFICATION.png", scale: 1.4)),
            const SizedBox(height: 50,),
            Positioned(
              top: 400,
              bottom: 130,
              left: 20,
              right: 20,
              child: Container(
                // margin: EdgeInsets.fromLTRB(20, 400, 20, 150),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text("OTP: ${widget.OTP}", style: const TextStyle(fontWeight: FontWeight.w600),),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                      child: SizedBox(
                        width: 250,
                        child: Form(
                          key: _formKey,
                          child: Pinput(
                            controller:pin ,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            validator: (s) {
                              return s == '${widget.OTP}' ? null : 'Pin is incorrect';
                            },
                            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) => debugPrint('enter pin'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 45,
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=> SignUpPersonal()));
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text('Verify',style: TextStyle(color: colors.whiteTemp),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




