import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:peanut_api_test/main.export.dart';

class SignUpView extends HookConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              DecoContainer(height: 150, width: double.infinity, color: context.colors.primary),
              const Expanded(child: DecoContainer(width: double.infinity)),
            ],
          ),
          SizedBox(
            height: context.height,
            child: SingleChildScrollView(
              padding: Pads.med(),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  spacing: Insets.med,
                  children: [
                    Gap(context.padding.top),
                    Text('Create Account', style: context.text.headlineSmall?.bold.textColor(context.colors.onPrimary)),
                    Text(
                      'Join the Locum Marketplace',
                      style: context.text.bodyMedium?.textColor(context.colors.onPrimary),
                    ),
                    const Gap(20),

                    const KTextField(
                      prefixIcon: Icon(Icons.mail_outline),
                      name: 'your@email.com',
                      hintText: 'your@email.com',
                      title: 'Email Address',
                    ),

                    const KTextField(
                      prefixIcon: Icon(Icons.mail_outline),
                      name: 'Enter your phone number',
                      hintText: '+880 123456789',
                      title: 'Phone Number',
                    ),

                    const OptionSelector(items: ['Pharmacy', 'Locum'], title: 'Register as'),
                    const KTextField(
                      prefixIcon: Icon(Icons.lock_outline),
                      name: 'password',
                      hintText: '••••••••',
                      isPasswordField: true,
                      title: 'Password',
                    ),

                    const KTextField(
                      prefixIcon: Icon(Icons.lock_outline),
                      name: 'password',
                      hintText: '••••••••',
                      isPasswordField: true,
                      title: 'Confirm Password',
                    ),

                    const Gap(10),
                    SubmitButton(
                      label: 'Sign up',
                      onPressed: (l) async {
                        RPaths.search.push(context);
                      },
                      expanded: true,
                    ),

                    Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Already have an account?  '),
                            TextSpan(
                              text: 'Log in',
                              style: context.text.bodyMedium?.bold,
                              recognizer: TapGestureRecognizer()..onTap = () => RPaths.login.push(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
