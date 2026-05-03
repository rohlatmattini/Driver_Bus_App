import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../controllers/passenger_controller.dart';

class QrScannerView extends StatefulWidget {
  const QrScannerView({super.key});

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  final MobileScannerController scannerController = MobileScannerController();

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PassengerController>();

    return Scaffold(
      appBar: AppBar(title: Text("scanPassengerTicket".tr)),
      body: MobileScanner(
        controller: scannerController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            controller.processQrCode(barcodes.first.rawValue);
          }
        },
      ),
    );
  }
}
