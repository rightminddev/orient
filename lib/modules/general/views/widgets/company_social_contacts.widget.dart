import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../general_services/url_launcher.service.dart';
import '../../../../models/settings/general_settings.model.dart';

class CompanySocialContacts extends StatelessWidget {
  final CompanyContacts socialData;
  const CompanySocialContacts({super.key, required this.socialData});

  @override
  Widget build(BuildContext context) {
    final socialIcons = {
      'whatsapp': FontAwesomeIcons.whatsapp,
      'telegram': FontAwesomeIcons.telegram,
      'facebook': FontAwesomeIcons.facebook,
      'linkedin': FontAwesomeIcons.linkedin,
      'messenger': FontAwesomeIcons.facebookMessenger,
      'instagram': FontAwesomeIcons.instagram,
      'youtube': FontAwesomeIcons.youtube,
      'twitter': FontAwesomeIcons.twitter,
      'pinterest': FontAwesomeIcons.pinterest,
      'snapchat': FontAwesomeIcons.snapchat,
      'tiktok': FontAwesomeIcons.tiktok,
      'discord': FontAwesomeIcons.discord,
      'quora': FontAwesomeIcons.quora,
      'mail': FontAwesomeIcons.envelope,
      'sms': FontAwesomeIcons.message,
      'facetime': FontAwesomeIcons.apple,
      'whatassp': FontAwesomeIcons.whatsapp,
      'location': FontAwesomeIcons.locationCrosshairs,
      'phone': FontAwesomeIcons.phone
    };

    final Map<String, String?> socialLinks = {
      'whatsapp': socialData.whatsapp,
      'facebook': socialData.facebook,
      'twitter': socialData.twitter,
      'instagram': socialData.instagram,
      'linkedin': socialData.linkedin,
      'youtube': socialData.youtube,
      'messenger': socialData.messenger,
      'whatassp': socialData.whatassp,
      'location': socialData.location,
      'phone': socialData.phone,
    };

    return Wrap(
      spacing: AppSizes.s8,
      children: [
        for (var entry in socialLinks.entries)
          if (entry.value?.isNotEmpty ?? false)
            SocailIconButton(
                icon: socialIcons[entry.key] ?? FontAwesomeIcons.circleQuestion,
                label: entry.key,
                url: _getUrl(entry: entry),
                mode: entry.key == 'location'
                    ? LaunchMode.externalApplication
                    : null),
      ],
    );
  }
}

String _getUrl({required MapEntry<String, String?> entry}) {
  if (entry.key == 'location' &&
      entry.value != null &&
      entry.value?.isNotEmpty == true) {
    // Extract the URL from the iframe string
    final locationUrl =
        RegExp(r'src="([^"]+)"').firstMatch(entry.value!)?.group(1) ?? '';
    if (locationUrl.isNotEmpty) {
      return locationUrl;
    }
  }
  if (entry.key == 'phone' &&
      entry.value != null &&
      entry.value?.isNotEmpty == true) {
    return "tel:${entry.value}";
  }

  return entry.key == 'whatsapp' || entry.key == 'whatassp'
      ? "whatsapp://send?phone=${entry.value}"
      : entry.value ?? '';
}

class SocailIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;
  final LaunchMode? mode;
  const SocailIconButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.url,
      this.mode});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => UrlLauncherServiceEx.launch(
          context: context, url: url, mode: mode ?? LaunchMode.platformDefault),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        radius: AppSizes.s24,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.s2),
          child: Center(child: FaIcon(icon, color: Colors.white)),
        ),
      ),
    );
  }
}
