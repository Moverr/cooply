import 'package:Cooply/screens/home_screen.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/util.dart';
import '../widgets/loadingDialog.dart';

class VerificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final int codeLength = 6;
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  String code = "";

  @override
  void dispose() {
    controllers.forEach((c) => c.dispose());
    focusNodes.forEach((f) => f.dispose());
    super.dispose();
  }

  int countIndex = 0;
  void handleInput(String value, int index) {
    if (value.length > 1) {
      // Pasted multiple characters — distribute from where the paste happened
      int pasteIndex = index;
      for (int i = countIndex; i < value.length; countIndex++) {
        if (pasteIndex >= codeLength) break;
        controllers[pasteIndex].text = value[i];
        pasteIndex++;
      }

      if (pasteIndex < codeLength) {
        FocusScope.of(context).requestFocus(focusNodes[pasteIndex]);
      } else {
        FocusScope.of(context).unfocus();
      }
    } else {
      // Typed single character — just move to next
      if (value.isNotEmpty && index + 1 < codeLength) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else if (index + 1 == codeLength) {
        FocusScope.of(context).unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          flexibleSpace: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: Util.scaleWidthFromDesign(context, 200),
                color: Colors.white,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.white.withAlpha(128),
                    BlendMode.dstATop,
                  ),
                  child:
                      Image.asset('assets/home_image.png', fit: BoxFit.cover),
                ),
              ),
              Center(
                child: Image.asset('assets/cooply_sm.png'),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 1, top: 50),
            child: Text(
              "Enter \nVerification Code ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppConstants.defaultFont,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(codeLength, (index) {
                return Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => handleInput(value, index),
                      ),
                    ),
                    if (index < codeLength - 1) SizedBox(width: 10),
                  ],
                );
              }),
            ),
          ),
          SizedBox(height: 30),
         ElevatedButton(
              onPressed: () {
               _handleVerification();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),



        ],
      ),
    );
  }

  Future<void> _handleVerification( ) async {
    String otpCode = controllers
        .map((controller) => controller.text.trim())
        .join()
        .toUpperCase();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    LoadingDialog.show(context, "Validating Token");

    await authProvider.validateOTP(otpCode);

    LoadingDialog.hide(context);

    if (authProvider.isRegistered == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Validated Succesfully"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Activation failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
