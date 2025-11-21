import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studify/Services/Supabase_Storage_Service.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final storage = StorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(29),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.white,
              ),
            ],
          ),
          width: 330,
          height: 540,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Upload Your File",
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Select a file to upload and share",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                const SizedBox(height: 30),

                // Upload icon box
                Container(
                  height: 180,
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade300, width: 2),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.cloud_upload_outlined,
                      size: 105,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Browse Files
                Container(
                  width: 280,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextButton(
                    onPressed: () => showUploadBottomSheet(context),
                    child: const Text(
                      "Browse Files",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    uploadWidget(FontAwesomeIcons.filePdf),
                    uploadWidget(Icons.edit_document),
                    uploadWidget(FontAwesomeIcons.image),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// ⭐ BOTTOM SHEET FUNCTION (FIXED)
//
Future<void> showUploadBottomSheet(BuildContext context) async {
  TextEditingController titleController = TextEditingController();
  File? pickedFile;
  String selectedCourse = "BCA";

  final storage = StorageService();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 25,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Contribute to the Community",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.blue.shade900,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // TITLE
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: "Enter Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ⭐ COURSE SELECTION BUTTONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      courseButton("BCA", selectedCourse, () {
                        setState(() => selectedCourse = "BCA");
                      }),
                      courseButton("BBA", selectedCourse, () {
                        setState(() => selectedCourse = "BBA");
                      }),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // File Picker
                  ElevatedButton.icon(
                    onPressed: () async {
                      File? file = await storage.pickFile();
                      if (file != null) {
                        setState(() => pickedFile = file);
                      }
                    },
                    icon: const Icon(Icons.upload_file, color: Colors.white),
                    label: Text(
                      pickedFile == null ? "Choose File" : "File Selected",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade500,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () async {
                      if (titleController.text.isEmpty || pickedFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please complete all fields")),
                        );
                        return;
                      }

                      // 1️⃣ Upload file
                      String? url =
                          await storage.uploadFile(pickedFile!, "uploads");

                      if (url == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Upload failed")),
                        );
                        return;
                      }

                      // 2️⃣ Save to database
                      final success = await storage.saveNote(
                        titleController.text.trim(),
                        selectedCourse,
                        url,
                      );

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Uploaded Successfully")),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Database save failed")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 21, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 45),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

//
// ⭐ course selection button
//
Widget courseButton(String text, String selected, VoidCallback onTap) {
  final bool isActive = text == selected;

  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: isActive ? Colors.blue.shade800 : Colors.blue.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: isActive ? Colors.white : Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

//
// ⭐ Circular icon widget
//
Widget uploadWidget(IconData icon) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.blue.shade800, width: 2),
    ),
    child: CircleAvatar(
      radius: 33,
      backgroundColor: Colors.blue.shade50,
      child: Icon(icon, size: 34, color: Colors.blue.shade900),
    ),
  );
}
