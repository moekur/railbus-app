import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:railbus/ui/components/miscs/header.dart';
import 'package:railbus/utils/format_utils.dart';

enum DocumentType {
  AnnualReport,
  NewsAnnouncementArticle,
  OtherDocument,
}

class NewsAndAnnouncementsScreen extends StatefulWidget {
  const NewsAndAnnouncementsScreen({super.key});

  @override
  State<NewsAndAnnouncementsScreen> createState() =>
      _NewsAndAnnouncementsScreenState();
}

class _NewsAndAnnouncementsScreenState
    extends State<NewsAndAnnouncementsScreen> {
  DocumentType? _selectedType; // Nullable to allow filtering by all types

  // Mock data for the documents
  static final List<Map<String, dynamic>> documents = [
    {
      "type": DocumentType.AnnualReport,
      "name": "2023 Annual Report",
      "description": "Comprehensive financial overview for the year 2023.",
      "downloadUrl": "https://example.com/2023_annual_report.pdf",
      "date": DateTime(2024, 3, 15),
    },
    {
      "type": DocumentType.AnnualReport,
      "name": "2022 Annual Report",
      "description": "Financial performance and insights for 2022.",
      "downloadUrl": "https://example.com/2022_annual_report.pdf",
      "date": DateTime(2023, 3, 10),
    },
    {
      "type": DocumentType.NewsAnnouncementArticle,
      "name": "New Share Issuance Announcement",
      "description": "Details about the new share issuance for investors.",
      "articleContent":
          "We are excited to announce the issuance of 1 million new shares to support our expansion plans. This initiative aims to raise AED 10 million to fund new projects in the coming year. Investors are encouraged to participate in this opportunity.",
      "downloadUrl": "https://example.com/share_issuance.pdf",
      "date": DateTime(2024, 10, 20),
    },
    {
      "type": DocumentType.NewsAnnouncementArticle,
      "name": "Q3 2024 Performance Article",
      "description": "A detailed article on our Q3 2024 performance.",
      "articleContent":
          "In Q3 2024, our company achieved a 15% growth in revenue, driven by strong demand in our core markets. Key highlights include a 20% increase in share value and successful completion of three major projects.",
      "downloadUrl": "https://example.com/q3_2024_article.pdf",
      "date": DateTime(2024, 11, 5),
    },
    {
      "type": DocumentType.OtherDocument,
      "name": "Investor Guidelines",
      "description": "Guidelines for investors on share trading policies.",
      "downloadUrl": "https://example.com/investor_guidelines.pdf",
      "date": DateTime(2024, 1, 15),
    },
    {
      "type": DocumentType.OtherDocument,
      "name": "Compliance Policy",
      "description": "Updated compliance policy for shareholders.",
      "downloadUrl": "https://example.com/compliance_policy.pdf",
      "date": DateTime(2024, 2, 20),
    },
  ];

  void _downloadDocument(BuildContext context, String url) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading document from $url')),
    );
  }

  List<Map<String, dynamic>> _filterDocuments() {
    List<Map<String, dynamic>> filteredDocs = documents;

    // Filter by type
    if (_selectedType != null) {
      filteredDocs =
          filteredDocs.where((doc) => doc["type"] == _selectedType).toList();
    }

    return filteredDocs;
  }

  void _onTypeSelected(DocumentType? type) {
    setState(() {
      _selectedType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final filteredDocuments = _filterDocuments();

    return Scaffold(
      backgroundColor: primaryColor, // Dark background for the entire screen

      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(title: 'News & Announcements'),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: TypeSelectorComponent(
                  selectedType: _selectedType,
                  onTypeSelected: _onTypeSelected,
                ),
              ),
            ),
            // Rounded container for the document list
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: filteredDocuments.length,
                  itemBuilder: (context, index) {
                    final document = filteredDocuments[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: Icon(
                            _getDocumentIcon(document["type"]),
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          document["name"],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          _getDocumentTypeLabel(document["type"]),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: Text(
                          DateFormat('MMM dd, yyyy').format(document["date"]),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Description: ${document["description"]}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                if (document["type"] ==
                                    DocumentType.NewsAnnouncementArticle) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    'Content:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    document["articleContent"],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () => _downloadDocument(
                                      context, document["downloadUrl"]),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text(
                                    'Download Document',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getDocumentIcon(DocumentType type) {
    switch (type) {
      case DocumentType.AnnualReport:
        return Icons.book;
      case DocumentType.NewsAnnouncementArticle:
        return Icons.article;
      case DocumentType.OtherDocument:
        return Icons.description;
    }
  }

  String _getDocumentTypeLabel(DocumentType type) {
    switch (type) {
      case DocumentType.AnnualReport:
        return 'Annual Report';
      case DocumentType.NewsAnnouncementArticle:
        return 'News/Announcement/Article';
      case DocumentType.OtherDocument:
        return 'Other Document';
    }
  }
}

// TypeSelectorComponent for filtering by document type
class TypeSelectorComponent extends StatelessWidget {
  final DocumentType? selectedType;
  final Function(DocumentType?) onTypeSelected;

  const TypeSelectorComponent({
    required this.selectedType,
    required this.onTypeSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...DocumentType.values.map((type) {
          final typeLabel = _getTypeLabel(type);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed: () => onTypeSelected(type),
              child: Text(
                typeLabel,
                style: TextStyle(
                  color: selectedType == type ? Colors.white : Colors.white70,
                ),
              ),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            onPressed: () => onTypeSelected(null), // Reset to show all types
            child: Text(
              'All',
              style: TextStyle(
                color: selectedType == null ? Colors.white : Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getTypeLabel(DocumentType type) {
    switch (type) {
      case DocumentType.AnnualReport:
        return 'Annual Report';
      case DocumentType.NewsAnnouncementArticle:
        return 'News/Announcement';
      case DocumentType.OtherDocument:
        return 'Other Document';
    }
  }
}
