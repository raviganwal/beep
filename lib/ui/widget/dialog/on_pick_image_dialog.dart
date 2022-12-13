import 'package:beep/ui/widget/app_debug_print.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class OnPickImageDialog extends StatefulWidget {
  const OnPickImageDialog({Key? key}) : super(key: key);

  @override
  State<OnPickImageDialog> createState() => _OnPickImageDialogState();
}

class _OnPickImageDialogState extends State<OnPickImageDialog> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 30,
          ),
          // const Icon(
          //   Icons.image,
          //   size: 30,
          //   color: Colors.grey,
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Text(
          //   'Select Image',
          //   style: GoogleFonts.nunitoSans(
          //     fontSize: 16,
          //     color: Colors.black,
          //     fontWeight: FontWeight.w500,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
          TextButton(
            onPressed: () async {
              final pickedFile = await _onImageButtonPressed(
                  ImageSource.gallery,
                  context: context);
              if (pickedFile is XFile) {
                if (!mounted) return;
                Navigator.of(context).pop(pickedFile);
              }
            },
            child: Text('Pick Image from gallery',
                style: GoogleFonts.nunitoSans(
                    color: const Color(0xff00ab6c),
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
          ),
          TextButton(
              onPressed: () async {
                final pickedFile = await _onImageButtonPressed(
                    ImageSource.camera,
                    context: context);
                if (pickedFile is XFile) {
                  if (!mounted) return;
                  Navigator.of(context).pop(pickedFile);
                }
              },
              child: Text('Take a Photo',
                  style: GoogleFonts.nunitoSans(
                      color: const Color(0xff00ab6c),
                      fontWeight: FontWeight.w500,
                      fontSize: 16))),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<XFile?> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 30,
      );
      return pickedFile;
    } catch (e) {
      appDebugPrint("error ${e.toString()}");
    }
    return null;
  }
}
