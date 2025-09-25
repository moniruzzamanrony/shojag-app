/* *
 * for terms and condition and privacy policy ui, action and logic
 * */

import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/style/style.dart';
import 'package:app/feature/auth/presentation/provider/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/styled_text.dart';

class TermsAndConditionWidget extends StatelessWidget {
  const TermsAndConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle =  const TextStyle();
    return Row(
      children: [
        Selector<RegistrationProvider, bool>(
          selector: (_, provider) => provider.acceptTermsAndCondition,
          builder: (_, value, __) => Checkbox(
            visualDensity: Styles.minimumVisualDensity,
            value: value,
            splashRadius: 0,
            onChanged: (v) {
              if (v == null) return;
              context.read<RegistrationProvider>().acceptTermsAndCondition = v;
            },
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
                context: context, builder: (_) =>  const TermsAndConditionDialog());
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(text: context.language.iAgreeToThe, style: textStyle),
            const  TextSpan(text: ' '),
            TextSpan(
                text: context.language.termsAndConditions,
                style: textStyle.copyWith(color: context.colorScheme.primary))
          ])),
        )
      ],
    );
  }
}

class TermsAndConditionDialog extends StatelessWidget {
  const TermsAndConditionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Terms and Conditions'),
      content: SizedBox(
          height: 0.3.sh,
          child: SingleChildScrollView(
              child: StyledText(
            text: toc,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 10.sp, height: 1.4),
            tags: {
              'bold': StyledTextTag(
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              'bullet': StyledTextWidgetBuilderTag((ctx, data, attributes) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FaIcon(
                    FontAwesomeIcons.solidCircle,
                    size: 6.sp,
                  ),
                );
              })
            },
          ))),
      actions: [
        FilledButton(
            style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
            )),
            onPressed: () {
              context.pop();
            },
            child: const Text('OK'))
      ],
    );
  }
}

final toc = '''
Thank you for using Shojag! Shojag is a safety-focused app designed to alert users within a specific area about incidents and emergencies, allowing nearby citizens and emergency responders (police, ambulance, fire service) to respond in real-time.

By using this app, you agree to the following <bold>Terms and Conditions:</bold>

<bold>1. Acceptance of Terms</bold>
By downloading, accessing, or using Shojag, you acknowledge that you have read, understood, and agree to these terms and conditions. If you do not agree to these terms, please do not use the app or website.

<bold>2. User Eligibility</bold>
You must be at least 18 years of age to use Shojag or have the consent of a parent or guardian. By registering, you represent that you meet these eligibility requirements.

<bold>3. Account Registration</bold>
You agree to provide accurate, current, and complete information during registration.
You are responsible for safeguarding your account details and for any activity under your account.

<bold>4. User Responsibilities</bold>
<bullet></bullet><bold>Account Creation: </bold>You must provide accurate and truthful information when creating an account. It is your responsibility to keep your login credentials secure.
<bullet></bullet><bold>Use of Alerts: </bold>Users must only create genuine alerts. False or misleading alerts are strictly prohibited and may result in account suspension or legal consequences.
<bullet></bullet><bold>Respectful Usage: </bold>All interactions on Shojag must comply with our community guidelines. Harassment, abusive language, or illegal activities are not tolerated.

<bold>5. Alerts and Location Sharing</bold>
<bullet></bullet><bold>Alert Creation: </bold>You can create alerts for incidents such as robberies, accidents, or any other emergencies.
<bullet></bullet><bold>Location Sharing:</bold> By using Shojag, you consent to sharing your real-time location with other users within the range of an alert. This location sharing is necessary for others to respond accurately to alerts.
<bullet></bullet><bold>Responder Tracking: </bold>When responding to an alert, your location may be tracked for safety and to improve response coordination.
Shojag uses location services, which may affect device battery life and data usage. Please use this feature responsibly.

<bold>6. Emergency Services Integration</bold>
<bullet></bullet>Shojag facilitates communication with emergency services (police, fire service, ambulance), but:
<bullet></bullet>Shojag does not guarantee immediate response times from emergency services.
Users are responsible for the accuracy of the information provided in their alerts.

<bold>7. FnF Feature</bold>
<bullet></bullet>The Friends and Family (FnF) feature allows users to page the real-time location of pre-selected contacts (if enabled).
<bullet></bullet>Users must obtain consent before adding individuals to their FnF group.
<bullet></bullet>Shojag is not responsible for any misuse of this feature.

<bold>8. Data Privacy</bold>
Shojag values your privacy. We collect, store, and process personal data in accordance with our Privacy Policy. By using Shojag, you consent to the collection and use of your data for providing app services.

<bold>9. Liability</bold>
Shojag is a tool to enhance safety but does not replace official emergency services.
Shojag is not liable for any loss, damage, or injury resulting from delays, inaccuracies, or miscommunications in the app.

<bold>10. Prohibited Activities</bold>
Users are prohibited from:
Using Shojag for any illegal or unauthorized purpose.
Attempting to interfere with the app’s functionality or security.
Collecting data from other users without permission.

<bold>11. Termination</bold>
We reserve the right to suspend or terminate accounts that violate these terms or engage in harmful behavior. Shojag may modify or discontinue any part of the service without prior notice.

<bold>12. Intellectual Property</bold>
All content, features, and functionality in Shojag, including logos, designs, and software, are owned by Shojag and protected by copyright and trademark laws.

<bold>13. Modifications to the App and Terms</bold>
Shojag reserves the right to update or modify these terms at any time. Continued use of the app after such changes constitutes your acceptance of the updated terms.

<bold>14. Termination</bold>
These terms are governed by and construed in accordance with the laws of Bangladesh. Any disputes arising from the use of Shojag will be subject to the jurisdiction of Bangladeshi courts.


<bold>15. Disclaimer</bold>
Shojag is provided on an "as-is" basis without warranties of any kind. Shojag does not guarantee uninterrupted access or error-free performance.

<bold>16. Contact Information</bold>
For questions or concerns about these terms, please contact us at Email: <bold>shojagapp@gmail.com</bold>.

''';
