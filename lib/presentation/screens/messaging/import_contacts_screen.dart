import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/di/injection.dart';
import '../../../domain/repositories/contact_repository.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/referral/referral_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/imali_app_bar.dart';

/// Screen for importing phone contacts, matching against iMaliChat users,
/// and inviting non-users. POPIA-compliant permission flow.
class ImportContactsScreen extends StatefulWidget {
  const ImportContactsScreen({super.key});

  @override
  State<ImportContactsScreen> createState() => _ImportContactsScreenState();
}

class _ImportContactsScreenState extends State<ImportContactsScreen> {
  _ImportStep _step = _ImportStep.explanation;
  List<Contact> _deviceContacts = [];
  // Map from normalized phone number → contact display name
  final Map<String, String> _phoneToName = {};
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    // Pre-load referral stats so referral code is available for invite links
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReferralBloc>().add(const ReferralEvent.loadStats());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBackground,
      appBar: const IMaliAppBar(
        title: 'Import Contacts',
        backgroundColor: AppColors.chatAppBar,
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state.actionError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.actionError!),
                backgroundColor: AppColors.error,
              ),
            );
          }
          if (state.actionSuccess != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.actionSuccess!),
                backgroundColor: AppColors.success,
              ),
            );
          }
        },
        builder: (context, state) {
          switch (_step) {
            case _ImportStep.explanation:
              return _buildExplanation();
            case _ImportStep.loading:
              return _buildLoading();
            case _ImportStep.results:
              return _buildResults(context, state);
          }
        },
      ),
    );
  }

  Widget _buildExplanation() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Icon(
            Icons.contacts_outlined,
            size: 80,
            color: AppColors.primary.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 24),
          Text(
            'Find Friends on iMaliChat',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'We\'ll check your phone contacts to find friends who are '
            'already on iMaliChat. Your contacts are only used for matching '
            'and are never stored on our servers.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'In compliance with POPIA, your contact data is processed '
            'securely and not shared with third parties.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textHint,
                  height: 1.4,
                ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          if (_permissionDenied) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'Contact permission was denied. Please enable it in '
                'your device settings, then tap Try Again.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.error,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            FilledButton.icon(
              onPressed: _openAppSettings,
              icon: const Icon(Icons.settings),
              label: const Text('How to Enable'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _requestPermissionAndImport,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ] else
            FilledButton.icon(
              onPressed: _requestPermissionAndImport,
              icon: const Icon(Icons.people_outline),
              label: const Text('Continue'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Not Now'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Matching your contacts...'),
        ],
      ),
    );
  }

  Widget _buildResults(BuildContext context, ContactState state) {
    if (state.isImporting) {
      return _buildLoading();
    }

    final matched = state.matchedPhoneContacts;
    final unmatched = state.unmatchedPhoneNumbers;
    final hasResults = matched.isNotEmpty || unmatched.isNotEmpty;

    if (!hasResults) {
      return _buildNoResults();
    }

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        // Friends on iMaliChat section
        if (matched.isNotEmpty) ...[
          _buildSectionHeader(
            'Friends on iMaliChat',
            count: matched.length,
          ),
          ...matched.map((m) => _buildMatchedTile(context, m)),
        ],

        // Invite section
        if (unmatched.isNotEmpty) ...[
          _buildSectionHeader(
            'Invite to iMaliChat',
            count: unmatched.length,
          ),
          ...unmatched.map((phone) => _buildUnmatchedTile(context, phone)),
        ],

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_search, size: 64, color: AppColors.textHint),
            const SizedBox(height: 16),
            Text(
              'No matches found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'None of your phone contacts are on iMaliChat yet. '
              'Invite them to join!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _shareInviteLink,
              icon: const Icon(Icons.share),
              label: const Text('Invite Friends'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {int? count}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
          ),
          if (count != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMatchedTile(
      BuildContext context, Map<String, dynamic> match) {
    final userId = match['userId'] as String? ?? '';
    final displayName = match['displayName'] as String? ?? 'User';
    final username = match['username'] as String?;
    final avatarUrl = match['avatarUrl'] as String?;
    final avatarColor = match['avatarColor'] as String?;
    final isExisting = match['isExistingContact'] as bool? ?? false;
    final contactStatus = match['contactStatus'] as String?;
    final isPending = contactStatus == 'pending';
    final isSent =
        context.read<ContactBloc>().state.sentContactRequestIds.contains(userId);

    Widget trailing;
    if (isExisting) {
      trailing = Chip(
        label: const Text('Contact'),
        backgroundColor: AppColors.chatSurface,
        labelStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
      );
    } else if (isPending) {
      trailing = Chip(
        label: const Text('Pending'),
        backgroundColor: AppColors.warning.withValues(alpha: 0.15),
        labelStyle: TextStyle(
          color: AppColors.warning,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      );
    } else if (isSent) {
      // On this screen all adds use source:'phone_import' which auto-accepts
      trailing = Chip(
        label: const Text('Added'),
        backgroundColor: AppColors.success.withValues(alpha: 0.15),
        labelStyle: TextStyle(
          color: AppColors.success,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        avatar: Icon(Icons.check, size: 16, color: AppColors.success),
      );
    } else {
      trailing = FilledButton(
        onPressed: () {
          context.read<ContactBloc>().add(
                ContactEvent.sendContactRequest(
                  userId,
                  source: 'phone_import',
                ),
              );
        },
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text('Add'),
      );
    }

    return ListTile(
      leading: _buildAvatar(displayName, avatarUrl, avatarColor),
      title: Text(
        displayName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: username != null
          ? Text(
              '@$username',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            )
          : null,
      trailing: trailing,
    );
  }

  Widget _buildUnmatchedTile(BuildContext context, String phoneNumber) {
    final contactName = _phoneToName[phoneNumber] ?? phoneNumber;

    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.textHint.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.person_outline, color: AppColors.textHint),
      ),
      title: Text(
        contactName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: contactName != phoneNumber
          ? Text(
              phoneNumber,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            )
          : null,
      trailing: OutlinedButton(
        onPressed: () => _shareInviteLinkForContact(phoneNumber),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text('Invite'),
      ),
    );
  }

  Widget _buildAvatar(
      String displayName, String? avatarUrl, String? avatarColor) {
    const double size = 48;
    const double radius = 6;

    Color color = AppColors.primary;
    if (avatarColor != null && avatarColor.isNotEmpty) {
      try {
        color = Color(int.parse(avatarColor.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }

    final initials = _getInitials(displayName);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }

  void _openAppSettings() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enable Contacts Permission'),
        content: const Text(
          'To find friends, please grant Contacts permission:\n\n'
          '1. Open your phone Settings\n'
          '2. Go to Apps → iMaliChat\n'
          '3. Tap Permissions\n'
          '4. Enable Contacts\n\n'
          'Then come back and tap Continue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _requestPermissionAndImport() async {
    // Request read-only permission (manifest only declares READ_CONTACTS)
    final status =
        await FlutterContacts.permissions.request(PermissionType.read);
    if (status != PermissionStatus.granted &&
        status != PermissionStatus.limited) {
      setState(() => _permissionDenied = true);
      return;
    }

    setState(() {
      _step = _ImportStep.loading;
      _permissionDenied = false;
    });

    // Read device contacts
    _deviceContacts = await FlutterContacts.getAll(
      properties: {ContactProperty.name, ContactProperty.phone},
    );

    // Extract and normalize phone numbers
    final phoneNumbers = <String>[];
    _phoneToName.clear();

    for (final contact in _deviceContacts) {
      for (final phone in contact.phones) {
        final normalized = _normalizePhone(phone.number);
        if (normalized.isNotEmpty) {
          phoneNumbers.add(normalized);
          _phoneToName[normalized] = contact.displayName ?? '';
        }
      }
    }

    if (phoneNumbers.isEmpty) {
      setState(() => _step = _ImportStep.results);
      return;
    }

    // Deduplicate
    final uniqueNumbers = phoneNumbers.toSet().toList();

    // Trigger matching via ContactBloc
    if (mounted) {
      context
          .read<ContactBloc>()
          .add(ContactEvent.importPhoneContacts(uniqueNumbers));
      setState(() => _step = _ImportStep.results);
    }
  }

  String _normalizePhone(String raw) {
    try {
      final parsed = PhoneNumber.parse(raw, callerCountry: IsoCode.ZA);
      if (parsed.isValid()) {
        return parsed.international;
      }
    } catch (_) {}

    // Fallback: manual normalization
    String digits = raw.replaceAll(RegExp(r'[^\d+]'), '');
    if (digits.startsWith('0') && digits.length == 10) {
      digits = '+27${digits.substring(1)}';
    }
    if (!digits.startsWith('+') && digits.isNotEmpty) {
      digits = '+$digits';
    }
    return digits;
  }

  void _shareInviteLink() {
    final referralCode =
        context.read<ReferralBloc>().state.stats?.referralCode;
    final refParam = referralCode != null ? '?ref=$referralCode' : '';
    Share.share(
      'Join me on iMaliChat! Download the app and start earning '
      'tokens while chatting: https://imalichat.app/join$refParam',
      subject: 'Join iMaliChat',
    );
  }

  /// Share invite link for a specific unmatched phone contact.
  /// Records a pending invite (fire-and-forget) for auto-contact on signup.
  void _shareInviteLinkForContact(String phoneNumber) {
    final referralCode =
        context.read<ReferralBloc>().state.stats?.referralCode;

    // Fire-and-forget: record pending invite for phone-based attribution
    getIt<ContactRepository>().recordPendingInvite(
      phoneNumber,
      referralCode: referralCode,
    );

    final refParam = referralCode != null ? '?ref=$referralCode' : '';
    Share.share(
      'Join me on iMaliChat! Download the app and start earning '
      'tokens while chatting: https://imalichat.app/join$refParam',
      subject: 'Join iMaliChat',
    );
  }

  @override
  void dispose() {
    // Clear import results when leaving
    context.read<ContactBloc>().add(const ContactEvent.clearImportResults());
    super.dispose();
  }
}

enum _ImportStep {
  explanation,
  loading,
  results,
}
