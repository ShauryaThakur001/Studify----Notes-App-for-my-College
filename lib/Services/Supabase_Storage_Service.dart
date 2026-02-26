import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Pick ANY file
  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      withData: false,
    );

    if (result == null) return null;
    return File(result.files.single.path!);
  }

  /// Upload file to Supabase Storage
  Future<String?> uploadFile(File file, String folderName) async {
    try {
      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}";

      final filePath = "$folderName/$fileName";

      final response = await _client.storage
          .from('studifybucket')
          .upload(filePath, file);

      if (response.isEmpty) return null;

      final publicUrl =
          _client.storage.from('studifybucket').getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      print("Supabase Upload Error: $e");
      return null;
    }
  }

  /// Fetch notes from Supabase
  Future<List<Map<String, dynamic>>> fetchNotes() async {
    try {
      final response = await _client
          .from("notes")
          .select()
          .order("created_at", ascending: false);

      return response.map<Map<String, dynamic>>((note) {
        return {
          "id": note["id"], // FIXE
          "title": note["title"],
          "course": note["course"],
          "file_url": note["file_url"],
          "created_at": note["created_at"],
        };
      }).toList();
    } catch (e) {
      print("Error fetching notes: $e");
      return [];
    }
  }

  /// Delete note by ID
  Future<bool> deleteNote(int id) async {
    try {
      await _client.from("notes").delete().eq("id", id);
      return true;
    } catch (e) {
      print("Delete note error: $e");
      return false;
    }
  }

  /// Save note in Database
  Future<bool> saveNote(String title, String course, String fileUrl) async {
    try {
      await _client.from("notes").insert({
        "title": title,
        "course": course,
        "file_url": fileUrl,
      });

      return true;
    } catch (e) {
      print("Save note error: $e");
      return false;
    }
  }
}
