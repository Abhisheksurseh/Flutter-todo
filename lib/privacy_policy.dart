import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 14, 48, 65),
       iconTheme: IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
        title: Text(
          'Privacy policy',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
        ),
      ),
      body: SingleChildScrollView(
         padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Last updated: August 21, 2024',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16),
            Text(
              'Introduction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Your privacy is important to us. This privacy policy explains how our task management app ("TaskTrack") collects, uses, and shares your personal information when you use our service.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Information We Collect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '1. Personal Information: We may collect personal information such as your name, email address, and phone number when you create an account or contact us.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '2. Usage Data: We may collect information on how the app is accessed and used. This may include your device\'s IP address, browser type, and the pages you visit within the app.',
              style: TextStyle(fontSize: 16),
            ),
              Text(
              '3. Task Data: We collect the information you provide when creating tasks in the app, such as task titles, descriptions, deadlines, and any associated tags or notes. This data is stored locally on your device or synced to our servers if you use our cloud services.',
              style: TextStyle(fontSize: 16),
            ),
              Text(
              '4. Device Information: We may collect information about the device you use to access the app, including the hardware model, operating system version, unique device identifiers, and mobile network information',
              style: TextStyle(fontSize: 16),
            ),
              Text(
              '5. Location Data: If you grant permission, we may collect and process information about your actual location using various technologies, including GPS, Wi-Fi, or mobile network data. This may be used to provide location-based task reminders or other location-specific features.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Sharing Your Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We do not share your personal information with third parties except as necessary to provide our services or comply with the law.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Security',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We take the security of your personal information seriously and use industry-standard measures to protect it.',
              style: TextStyle(fontSize: 16),
            ),
            Text('Data Encryption: We use industry-standard encryption protocols (such as SSL/TLS) to protect the transmission of your data from your device to our servers. Additionally, any sensitive information stored on our servers is encrypted to prevent unauthorized access.',
            style: TextStyle(fontSize: 16),
            ),
            Text('Access Controls: Access to personal information is restricted to authorized personnel only. We implement role-based access controls to ensure that only those who need access to your data to perform their duties can view or manage it.',
            style: TextStyle(fontSize: 16),
            ),
            Text('Regular Security Audits: We regularly review and update our security practices to address new and emerging threats. This includes performing regular security audits, vulnerability assessments, and applying patches to our systems promptly.',
            style: TextStyle(fontSize: 16),
            ),
            Text('Secure Storage: Your data is stored in secure environments that are protected against unauthorized access, loss, destruction, or alteration. We use secure data centers that comply with recognized industry standards for data security.',
            style: TextStyle(fontSize: 16),
            ),
            Text('Anonymization and Pseudonymization: Where possible, we anonymize or pseudonymize personal data to add an extra layer of protection. This ensures that even in the unlikely event of a data breach, your information remains protected.',
            style: TextStyle(fontSize: 16),
            ),
            Text('User Authentication: We employ strong authentication mechanisms, including multi-factor authentication (MFA), to verify your identity before granting access to your account. You are also encouraged to use strong, unique passwords and keep them confidential.',
            style: TextStyle(fontSize: 16),
            ),
            Text('Monitoring and Alerts: Our systems are continuously monitored for suspicious activity. In the event of unauthorized access or data breach, we have protocols in place to respond swiftly and mitigate any potential damage.',
            style: TextStyle(fontSize: 16),
            ),
            Text('Data Retention and Disposal: We retain your personal information only as long as necessary to fulfill the purposes outlined in this privacy policy. When your data is no longer needed, we securely delete or anonymize it to prevent unauthorized access.',
            style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Your Rights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'You have the right to access, update, or delete your personal information at any time. Please contact us if you wish to exercise these rights.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We may update this privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on this page.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions about this privacy policy, please contact us at [A4R@gmail.com].',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}