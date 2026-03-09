import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../theme/app_colors.dart';

/// Bottom-sheet QR/barcode scanner for meter numbers and utility bills.
/// Supports EAN-13 (SA meters), QR Code, and Code 128 (utility bills).
class BuyQrScanner extends StatefulWidget {
  /// Called with the scanned value when a barcode is detected.
  final ValueChanged<String> onScanned;

  const BuyQrScanner({super.key, required this.onScanned});

  /// Show the scanner as a bottom sheet. Returns the scanned value or null.
  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: BuyQrScanner(
          onScanned: (value) => Navigator.of(context).pop(value),
        ),
      ),
    );
  }

  @override
  State<BuyQrScanner> createState() => _BuyQrScannerState();
}

class _BuyQrScannerState extends State<BuyQrScanner> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );
  bool _hasScanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasScanned) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    setState(() => _hasScanned = true);
    widget.onScanned(barcode!.rawValue!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Scan Barcode or QR Code',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Point your camera at the meter or utility bill',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          // Camera view
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: MobileScanner(
                    controller: _controller,
                    onDetect: _onDetect,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
