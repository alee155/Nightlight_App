import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nightlight/Feedback/FeedBack.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late String appNamespace;

  @override
  void initState() {
    super.initState();
    _getAppNamespace();
  }

  Future<void> _getAppNamespace() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() => appNamespace = packageInfo.packageName);
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: FeedbackDialog.showFeedbackDialog(context, (String feedback) {
          print('Feedback submitted: $feedback');
        }),
      ),
    );
  }

  void _navigateToPlayStore() async {
    if (appNamespace.isEmpty) {
      print('App namespace is not available');
      return;
    }

    final url = "https://play.google.com/store/apps/details?id=$appNamespace";
    await canLaunch(url)
        ? await launch(url)
        : print('Could not launch the Play Store');
  }

  Future<void> onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    String linkToShare =
        "https://play.google.com/store/apps/details?id=$appNamespace";
    String text = "Check out this link: $linkToShare";
    String subject = "Sharing with Friends";

    try {
      await Share.share(
        text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {
      print("Error sharing: $e");
    }
  }

  void openPrivacyPolicy() async {
    const privacyPolicyUrl = "https://itwingtech.com/privacy-policy/";
    await canLaunch(privacyPolicyUrl)
        ? await launch(privacyPolicyUrl)
        : print('Could not launch $privacyPolicyUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Drawer(
        width: 250,
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
                border: Border(
                    right: BorderSide(color: Color(0xFF00FF00), width: 4.0)),
              ),
              child: ListView(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 15, top: 50),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'Inter-VariableFont_slnt,wght.ttf'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        _buildListTile('assets/images/rateus.svg', 'Rate Us',
                            _navigateToPlayStore),
                        _buildListTile('assets/images/feedback.svg', 'Feedback',
                            () => _showFeedbackDialog(context)),
                        _buildListTile('assets/images/share.svg', 'Share',
                            () => onShare(context)),
                        _buildListTile('assets/images/privacy.svg',
                            'Privacy and Policy', openPrivacyPolicy),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(String iconPath, String title, Function onTap) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        height: 30,
        width: 30,
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.white,
            fontFamily: 'Inter-VariableFont_slnt,wght.ttf'),
      ),
      onTap: () => onTap(),
    );
  }
}
