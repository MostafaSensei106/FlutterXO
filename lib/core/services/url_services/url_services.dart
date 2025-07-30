import 'package:url_launcher/url_launcher.dart'
    show launchUrl, LaunchMode, canLaunchUrl;

import '../../widgets/app_toast/app_toast.dart' show showErrorToast;

/// Launches a URL in an external application.
///
/// [url] is the URL to be launched.
///
/// Shows a toast with an error message if the launch fails.
Future<void> launchURL(final String url) async {
  try {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  } catch (e) {
    showErrorToast(e.toString());
  }
}

/// Sends an email using an external application.
///
/// [toEmail] is the recipient's email address.
/// [subject] is the subject of the email.
/// [body] is the body of the email.
///
/// Throws an exception if the email launch fails.
Future<void> sendEmail({
  required final String toEmail,
  required final String subject,
  required final String body,
}) async {
  final emailLaunchUri = Uri(
    scheme: 'mailto',
    path: toEmail,
    query:
        '${Uri.encodeQueryComponent('subject')}=$subject&${Uri.encodeQueryComponent('body')}=$body',
  );
  if (!await launchUrl(emailLaunchUri)) {
    throw Exception('Could not launch $emailLaunchUri');
  }
}

/// Initiates a phone call using an external application.
///
/// [phoneNumber] is the phone number to call.
///
/// Throws an exception if the phone call launch fails.
Future<void> makePhoneCall(final String phoneNumber) async {
  final phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw Exception('Could not launch phone call');
  }
}
