import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../core/services/key_backup_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';

/// Screen for managing E2EE key backups.
///
/// Allows users to create an encrypted backup of their private keys
/// and restore from a backup if needed (e.g., after reinstalling the app).
class KeyBackupScreen extends StatefulWidget {
  const KeyBackupScreen({super.key});

  @override
  State<KeyBackupScreen> createState() => _KeyBackupScreenState();
}

class _KeyBackupScreenState extends State<KeyBackupScreen> {
  final _passphraseController = TextEditingController();
  final _confirmController = TextEditingController();
  final _restoreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _restoreFormKey = GlobalKey<FormState>();

  late final KeyBackupService _backupService;

  bool _hasBackup = false;
  bool _isLoading = true;
  bool _isCreating = false;
  bool _isRestoring = false;
  bool _obscurePassphrase = true;
  bool _obscureConfirm = true;
  bool _obscureRestore = true;
  String? _lastBackupDate;

  @override
  void initState() {
    super.initState();
    _backupService = getIt<KeyBackupService>();
    _loadBackupStatus();
  }

  @override
  void dispose() {
    _passphraseController.dispose();
    _confirmController.dispose();
    _restoreController.dispose();
    super.dispose();
  }

  Future<void> _loadBackupStatus() async {
    try {
      final metadata = await _backupService.getBackupMetadata();
      if (mounted) {
        setState(() {
          _hasBackup = metadata?.backupExists ?? false;
          _lastBackupDate = metadata?.lastBackupAt?.toString().split('.').first;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _createBackup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isCreating = true);
    try {
      await _backupService.createBackup(_passphraseController.text);
      if (mounted) {
        _passphraseController.clear();
        _confirmController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Key backup created successfully'),
            backgroundColor: AppColors.success,
          ),
        );
        _loadBackupStatus();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create backup: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isCreating = false);
    }
  }

  Future<void> _restoreBackup() async {
    if (!_restoreFormKey.currentState!.validate()) return;

    setState(() => _isRestoring = true);
    try {
      final success =
          await _backupService.restoreFromBackup(_restoreController.text);
      if (mounted) {
        _restoreController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Keys restored successfully'
                  : 'Incorrect passphrase or corrupted backup',
            ),
            backgroundColor: success ? AppColors.success : AppColors.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Restore failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isRestoring = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Key Backup'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            color: AppColors.primary,
                            size: 32,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              'Your encryption keys are stored on this device. '
                              'Create a backup to restore them if you switch '
                              'devices or reinstall the app.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (_hasBackup) ...[
                    const SizedBox(height: AppSpacing.md),
                    Card(
                      color: AppColors.success.withValues(alpha: 0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle,
                                color: AppColors.success),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Backup exists',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: AppColors.success),
                                  ),
                                  if (_lastBackupDate != null)
                                    Text(
                                      'Last backup: $_lastBackupDate',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors.textSecondary),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: AppSpacing.lg),

                  // Create backup section
                  Text(
                    _hasBackup ? 'Update Backup' : 'Create Backup',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _passphraseController,
                          obscureText: _obscurePassphrase,
                          decoration: InputDecoration(
                            labelText: 'Backup passphrase',
                            hintText: 'Enter a strong passphrase',
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassphrase
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => setState(
                                  () => _obscurePassphrase = !_obscurePassphrase),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.length < 8) {
                              return 'Passphrase must be at least 8 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        TextFormField(
                          controller: _confirmController,
                          obscureText: _obscureConfirm,
                          decoration: InputDecoration(
                            labelText: 'Confirm passphrase',
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirm
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => setState(
                                  () => _obscureConfirm = !_obscureConfirm),
                            ),
                          ),
                          validator: (v) {
                            if (v != _passphraseController.text) {
                              return 'Passphrases do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppButton(
                          text: _hasBackup
                              ? 'Update Backup'
                              : 'Create Backup',
                          onPressed: _isCreating ? null : _createBackup,
                          isLoading: _isCreating,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),
                  const Divider(),
                  const SizedBox(height: AppSpacing.lg),

                  // Restore section
                  Text(
                    'Restore from Backup',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Enter your backup passphrase to restore your encryption keys.',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Form(
                    key: _restoreFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _restoreController,
                          obscureText: _obscureRestore,
                          decoration: InputDecoration(
                            labelText: 'Backup passphrase',
                            suffixIcon: IconButton(
                              icon: Icon(_obscureRestore
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => setState(
                                  () => _obscureRestore = !_obscureRestore),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Enter your passphrase';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppButton(
                          text: 'Restore Keys',
                          onPressed: _isRestoring ? null : _restoreBackup,
                          isLoading: _isRestoring,
                          variant: AppButtonVariant.outline,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
