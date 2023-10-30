import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginScreen extends StatefulWidget {
    static const name = 'user_login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late PageController controller;
  late int currentPage = 0;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          children: [
            _RegisterView(
              press: (){
                  controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInQuint,
                  );
                }),
            Container(color: Colors.blue,
            child: Center(
              child: InkWell(
                onTap: (){
                  controller.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInQuint,
                  );
                },
                child: const Text("Log In"),
              ),
            ),
            ),
        ],),
      ),
    );
  }
}

class _RegisterView extends StatefulWidget {
  final press;
  const _RegisterView({super.key, this.press});

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  bool _passwordVisible = false;


@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 15.h,
              width: 15.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: lightPrimary,),
              child: SvgPicture.asset("assets/petto.svg", height: 10.h, width: 10.w,)),
            ListTile(
              title: Text(AppLocalizations.of(context)!.welcomeBack, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 18.5.sp,
                fontWeight: FontWeight.w900,
              )),
              subtitle: Text(AppLocalizations.of(context)!.enterYourEmail, textAlign: TextAlign.center,),
            ),
            SizedBox(height: 2.h,),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(BoxIcons.bx_envelope),
                labelText:  AppLocalizations.of(context)!.user
              ),
              // style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 4.h,),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(BoxIcons.bx_lock),
                labelText: AppLocalizations.of(context)!.password,
                suffixIcon: GestureDetector(
                  onTap: (){
                    setState(() {
                          _passwordVisible = !_passwordVisible;
                    });
                  },
                  child: !_passwordVisible ? Icon(BoxIcons.bx_hide) : Icon(BoxIcons.bx_show),
                ),
              ),
              obscureText: !_passwordVisible,
            ),
            Row(
              children: [
                Flexible(child: Container()),
                Text(AppLocalizations.of(context)!.forgetPassword, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 3.w,
                  color: lightPrimary,
                ),
                )
              ],
            ),
            SizedBox(height: 4.h,),
             ElevatedButton(
               onPressed: (){}, 
               style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(75.w, 6.5.h)),
               ),
               child: 
                Text(AppLocalizations.of(context)!.signIn, style: TextStyle(color: Colors.white),),
             ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(AppLocalizations.of(context)!.dontHaveAccount),
                 SizedBox(width: 1.w),
                 GestureDetector(
                   onTap: widget.press,
                   child: Text(AppLocalizations.of(context)!.register))
               ],
             )
          ],
        ),
      ),
    );
  }
}