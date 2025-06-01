import 'package:firstgetxapp/app/modules/stepper/views/nfcscanne_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';


class Step1View extends StatefulWidget {
  const Step1View({super.key});

  @override
  State<Step1View> createState() => _Step1ViewState();
}

class _Step1ViewState extends State<Step1View> {
  static const platform =
      MethodChannel('com.example.nfcreaderapp/passport_reader');

  String _statusMessage = 'Scan result will appear here';
  String? _documentNumber;
  String? _dateOfBirth;
  String? _expirationDate;

  CameraController? _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController!.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<void> _startMRZScan() async {
    setState(() {
      _statusMessage = "🔍 Starting MRZ scan...";
    });

    try {
      final dynamic result = await platform.invokeMethod('startMRZScan');

      if (result is Map) {
        _documentNumber = result['documentNumber']?.toString();
        _dateOfBirth = result['dateOfBirth']?.toString();
        _expirationDate = result['expirationDate']?.toString();

        setState(() {
          _statusMessage = '''
✅ MRZ Read Successfully:

📄 Document Number: $_documentNumber
🎂 Date of Birth: $_dateOfBirth
📅 Expiry Date: $_expirationDate

📲 Hold the passport to the back of your phone for NFC...
''';
        });

        Get.to(() => NfcScanneView(
              documentNumber: _documentNumber!,
              dateOfBirth: _dateOfBirth!,
              expirationDate: _expirationDate!,
            ));
      } else if (result == "REQUESTING_PERMISSIONS") {
        setState(() {
          _statusMessage = "📋 Permissions requested. Please try again.";
        });
      } else {
        setState(() {
          _statusMessage = "⚠️ Unexpected MRZ scan result: $result";
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _statusMessage = "❌ PlatformException during MRZ scan: ${e.message}";
      });
    } catch (e, stackTrace) {
      setState(() {
        _statusMessage = "❌ Error during MRZ scan: $e";
      });
      print("❌ MRZ Exception: $e");
      print("📌 StackTrace: $stackTrace");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Step 1 - MRZ + NFC"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _isCameraInitialized && _cameraController != null
                  ? Builder(
                      builder: (_) {
                        final aspectRatio =
                            _cameraController!.value.aspectRatio;
                        if (aspectRatio > 0) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AspectRatio(
                              aspectRatio: aspectRatio,
                              child: CameraPreview(_cameraController!),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _startMRZScan,
                icon: const Icon(Icons.document_scanner),
                label: const Text("Start MRZ Scan"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: SelectableText(
                        _statusMessage,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
