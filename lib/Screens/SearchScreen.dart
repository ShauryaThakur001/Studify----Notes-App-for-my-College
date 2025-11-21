import 'package:flutter/material.dart';
import 'package:studify/Services/Supabase_Storage_Service.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final StorageService storage = StorageService();

  List<Map<String, dynamic>> allNotes = [];
  List<Map<String, dynamic>> filteredNotes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    final notes = await storage.fetchNotes();

    setState(() {
      allNotes = notes;
      filteredNotes = notes;
    });
  }

  void searchNotes(String query) {
    final results = allNotes.where((note) {
      final title = note["title"].toString().toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();

    setState(() => filteredNotes = results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            const SizedBox(height: 50),

            /// SEARCH BAR
            TextField(
              controller: _searchController,
              onChanged: searchNotes,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.blue.shade900),
                hintText: "Search by Title...",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),
            Divider(color: Colors.white),

            Expanded(
              child: filteredNotes.isEmpty
                  ? Center(child: Text("No notes found"))
                  : ListView.builder(
                      itemCount: filteredNotes.length,
                      itemBuilder: (context, index) {
                        final note = filteredNotes[index];

                        return Dismissible(
                          key: ValueKey(note["id"]),
                          direction: DismissDirection.endToStart,

                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(Icons.delete,
                                color: Colors.white, size: 28),
                          ),

                          confirmDismiss: (_) async {
                            return await showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Delete Note?"),
                                content: const Text("Do you want to delete this note?"),
                                actions: [
                                  TextButton(
                                    child: const Text("Cancel"),
                                    onPressed: () => Navigator.pop(context, false),
                                  ),
                                  TextButton(
                                    child: const Text("Delete",
                                        style: TextStyle(color: Colors.red)),
                                    onPressed: () => Navigator.pop(context, true),
                                  ),
                                ],
                              ),
                            );
                          },

                          onDismissed: (_) async {
                            await storage.deleteNote(note["id"]);
                            await loadNotes(); // Refresh

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Note deleted")),
                            );
                          },

                          child: containerWidget(
                            title: note["title"],
                            date: note["course"],
                            onOpen: () async {
                              final uri = Uri.parse(note["file_url"]);
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            },
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}

/// NOTE CARD WIDGET
Widget containerWidget({
  required String title,
  required String date,
  required VoidCallback onOpen,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.blue.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.shade100,
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
            ElevatedButton.icon(
              onPressed: onOpen,
              icon: const Icon(Icons.open_in_new,
                  color: Colors.white, size: 18),
              label: const Text("Open", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
