import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tf_core/tf_core.dart' show DI, Config;
import 'package:the_flashcard/common/common.dart';
import 'package:the_flashcard/login/x_textfield_widget.dart';

import 'login_bloc.dart';
import 'register_email_screen.dar.dart';

class LoginEmailScreen extends StatefulWidget {
  static final name = '/login_email_screen';

  LoginEmailScreen({Key key}) : super(key: key);

  _LoginEmailScreenState createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends XState<LoginEmailScreen> {
  LoginBloc bloc;
  TextEditingController emailController;
  TextEditingController passwordController;
  FocusNode emailNode;
  FocusNode passwordNode;

  @override
  void initState() {
    super.initState();
    bloc = LoginBloc();
    emailController = TextEditingController()
      ..addListener(() {
        bloc.add(EmailChanged(emailController.text));
      });
    passwordController = TextEditingController()
      ..addListener(() {
        bloc.add(PasswordChanged(passwordController.text));
      });
    emailNode = FocusNode();
    passwordNode = FocusNode();
  }

  @override
  void dispose() {
    emailController?.dispose();
    passwordController?.dispose();
    emailNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: bloc,
        listener: _onStateChanged,
        builder: (_, state) {
          return Stack(
            children: <Widget>[
              LayoutBuilder(
                builder: (_, constraint) {
                  return GestureDetector(
                    onTap: () => unfocus(),
                    child: SingleChildScrollView(
                      reverse: true,
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Flex(
                            direction: Axis.vertical,
                            children: <Widget>[
                              Flexible(
                                child: ClipPath(
                                  clipper: OvalBottomBorderClipper(),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(bottom: 40),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          XedColors.pastelRed,
                                          XedColors.waterMelon,
                                        ],
                                        stops: [
                                          0.0,
                                          1.0,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Flex(
                                      direction: Axis.vertical,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SvgPicture.asset(
                                              Assets.imgBubbleChatLogin),
                                        ),
                                        SvgPicture.asset(Assets.imgSmileLogin),
                                        Spacer(
                                          flex: 4,
                                        ),
                                        _buildTitle("Hey there!"),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: _buildDescription(
                                              "Welcome to our community. Your journey starts here."),
                                        ),
                                        Spacer(
                                          flex: 7,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 36)
                                      .copyWith(bottom: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 40),
                                        child: XTextFieldWidget(
                                          color: XedColors.black10,
                                          textInputType:
                                              TextInputType.emailAddress,
                                          icon: Icon(
                                            Icons.mail_outline,
                                            color: XedColors.color_178_178_178,
                                            size: 20,
                                          ),
                                          textStyle:
                                              RegularTextStyle(16).copyWith(
                                            color: XedColors.color_41_51_58,
                                            fontSize: 16,
                                          ),
                                          hintStyle:
                                              RegularTextStyle(16).copyWith(
                                            color: XedColors.color_178_178_178,
                                            fontSize: 16,
                                          ),
                                          hintText: "Your email",
                                          node: emailNode,
                                          controller: emailController,
                                          onSubmitted: (_) =>
                                              passwordNode.requestFocus(),
                                        ),
                                      ),
                                      !state.isEmailValid
                                          ? Padding(
                                              padding: EdgeInsets.symmetric(
                                                      horizontal: 16)
                                                  .copyWith(top: 12),
                                              child: Text(
                                                Config.getString(
                                                        'email_error') ??
                                                    '',
                                                style: RegularTextStyle(14)
                                                    .copyWith(
                                                  color: XedColors.roseRed,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      Container(
                                        margin: EdgeInsets.only(top: 12),
                                        child: XTextFieldWidget(
                                          color: XedColors.black10,
                                          icon: Icon(
                                            Icons.lock_outline,
                                            color: XedColors.color_178_178_178,
                                            size: 20,
                                          ),
                                          textStyle:
                                              RegularTextStyle(16).copyWith(
                                            color: XedColors.color_41_51_58,
                                            fontSize: 16,
                                          ),
                                          hintStyle:
                                              RegularTextStyle(16).copyWith(
                                            color: XedColors.color_178_178_178,
                                            fontSize: 16,
                                          ),
                                          obscureText: true,
                                          hintText: "Password",
                                          node: passwordNode,
                                          controller: passwordController,
                                        ),
                                      ),
                                      !state.isPasswordValid
                                          ? Padding(
                                              padding: EdgeInsets.symmetric(
                                                      horizontal: 16)
                                                  .copyWith(top: 12),
                                              child: Text(
                                                Config.getString(
                                                        'password_error') ??
                                                    '',
                                                style: RegularTextStyle(14)
                                                    .copyWith(
                                                  color: XedColors.roseRed,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      Container(
                                        margin: EdgeInsets.only(top: 25),
                                        width: double.infinity,
                                        child: XedButtons.colorCTA(
                                          onTap: handleLoginPress,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Sign in",
                                                style: SemiBoldTextStyle(18)
                                                    .copyWith(
                                                  color: XedColors.white255,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              state.isSubmitting
                                                  ? XedProgress.indicator(
                                                      color: XedColors.white255)
                                                  : SizedBox(),
                                            ],
                                          ),
                                          color: XedColors.waterMelon,
                                          borderRadius:
                                              BorderRadius.circular(27.5),
                                          padding: EdgeInsets.only(
                                              bottom: 15, top: 16),
                                        ),
                                      ),
                                      Spacer(),
                                      _buildForgetPassword(onTap: () {
                                        navigateToScreen(
                                          screen: RegisterEmailScreen(),
                                          name: RegisterEmailScreen.name,
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _onStateChanged(BuildContext context, LoginState state) {
    if (state.isFailure) {
      showErrorSnakeBar(state.error, context: context);
    } else if (state.isSuccess) {
      closeUntilRootScreen(context: context);
      showSuccessSnakeBar(Config.getString("msg_login_success"),
          context: context);
    }
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      textAlign: TextAlign.center,
      style: RegularTextStyle(18).copyWith(
        color: XedColors.white255,
        fontSize: 18,
        height: 1.4,
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: SemiBoldTextStyle(24).copyWith(
        color: XedColors.white255,
        fontSize: 24,
      ),
    );
  }

  Widget _buildForgetPassword({VoidCallback onTap}) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: RegularTextStyle(16).copyWith(
            color: XedColors.color_178_178_178,
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  void handleLoginPress() {
    bloc.add(
      LoginPressed(
        email: emailController.text.toLowerCase().trim(),
        password: passwordController.text.trim(),
      ),
    );
  }
}
