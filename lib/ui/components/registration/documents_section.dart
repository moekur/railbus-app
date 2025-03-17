import 'package:flutter/material.dart';

class Document {
  final String name;
  final String filePath;

  Document({required this.name, required this.filePath});
}

class DocumentsSection extends StatefulWidget {
  final Function(String, bool) showMessage;
  final List<Document>? existingDocuments; // Optional parameter for pre-existing documents

  const DocumentsSection({
    super.key,
    required this.showMessage,
    this.existingDocuments,
  });

  @override
  State<DocumentsSection> createState() => _DocumentsSectionState();
}

class _DocumentsSectionState extends State<DocumentsSection> {
  late List<Document> _documents;

  @override
  void initState() {
    super.initState();
    // Initialize _documents with existingDocuments if provided, otherwise empty list
    _documents = widget.existingDocuments != null ? List.from(widget.existingDocuments!) : [];
  }

  Future<void> _uploadFile() async {
    // Simulate upload (replace with file_picker in real app)
    setState(() {
      _documents.add(Document(name: 'Document_${_documents.length + 1}.pdf', filePath: 'path/to/file'));
    });
    widget.showMessage('File uploaded successfully (simulated)', false);
  }

  Future<void> _capturePhoto() async {
    // Simulate capture (replace with image_picker in real app)
    setState(() {
      _documents.add(Document(name: 'Photo_${_documents.length + 1}.jpg', filePath: 'path/to/photo'));
    });
    widget.showMessage('Photo captured successfully (simulated)', false);
  }

  void _deleteDocument(int index) {
    setState(() {
      _documents.removeAt(index);
    });
    widget.showMessage('Document deleted', false);
  }

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Documents',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add a document',
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.upload,
                        color: secondaryColor,
                        size: 30,
                      ),
                      onPressed: _uploadFile,
                      tooltip: 'Upload Document',
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: secondaryColor,
                        size: 30,
                      ),
                      onPressed: _capturePhoto,
                      tooltip: 'Capture Photo',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _documents.isEmpty
                ? const Padding(
                    padding: EdgeInsets.zero,
                    child: Text(
                      'No documents uploaded yet.',
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      _documents.length,
                      (index) => ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        title: Text(_documents[index].name),
                        subtitle: Text(_documents[index].filePath),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => _deleteDocument(index),
                          tooltip: 'Delete Document',
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}