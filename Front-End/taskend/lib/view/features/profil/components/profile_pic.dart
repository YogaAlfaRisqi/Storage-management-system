import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taskend/controller/auth_provider.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? _imageFile;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: _imageFile != null
                ? FileImage(_imageFile!)
                : AssetImage("assets/images/default_profile_image.png")
                    as ImageProvider,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  backgroundColor: Color.fromARGB(255, 212, 214, 220),
                ),
                onPressed: () async {
                  final pickedFile =
                      await picker.getImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    File imageFile = File(pickedFile.path);

                    String userId = 'userId'; // Replace with actual user ID
                    String message =
                        await authProvider.uploadImage(userId, imageFile);

                    if (message == 'Image uploaded successfully') {
                      setState(() {
                        _imageFile = imageFile;
                      });
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                  }
                },
                child: SvgPicture.asset("assets/images/camera_icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
