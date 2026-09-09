import 'dart:io';
import 'package:flutter/material.dart';
// TODO: add to pubspec.yaml -> image_picker: ^1.x
import 'package:image_picker/image_picker.dart';

/// TODO: replace with your real review submission model / API call.
class ReviewSubmission {
  final String productId;
  final double rating;
  final String comment;
  final List<File> mediaFiles;

  const ReviewSubmission({
    required this.productId,
    required this.rating,
    required this.comment,
    required this.mediaFiles,
  });
}

/// Star rating + text + photo/video upload, matching the mockup's
/// "Add Photo or Video" + "What Do You Think?" review submission screen.
class SubmitReviewScreen extends StatefulWidget {
  final String productId;
  final String productName;

  const SubmitReviewScreen({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  State<SubmitReviewScreen> createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {
  double _rating = 0;
  final _commentController = TextEditingController();
  final List<File> _mediaFiles = [];
  final ImagePicker _picker = ImagePicker();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _pickMedia() async {
    if (_mediaFiles.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can add up to 5 photos/videos')),
      );
      return;
    }

    // TODO: present a chooser (photo vs video) if you want video support too,
    // e.g. via showModalBottomSheet with two options calling
    // _picker.pickImage(...) or _picker.pickVideo(...).
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _mediaFiles.add(File(picked.path)));
    }
  }

  void _removeMedia(int index) {
    setState(() => _mediaFiles.removeAt(index));
  }

  Future<void> _submit() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a star rating')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final submission = ReviewSubmission(
      productId: widget.productId,
      rating: _rating,
      comment: _commentController.text.trim(),
      mediaFiles: _mediaFiles,
    );

    // TODO: send `submission` to your backend / review repository here.
    await Future.delayed(const Duration(milliseconds: 600)); // simulated latency

    if (!mounted) return;
    setState(() => _isSubmitting = false);
    Navigator.of(context).pop(submission);
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Write a Review', style: TextStyle(color: Colors.black87)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            widget.productName,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'What Do You Think?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (i) {
                final starValue = i + 1;
                return IconButton(
                  iconSize: 34,
                  icon: Icon(
                    starValue <= _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => _rating = starValue.toDouble()),
                );
              }),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Your Review', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextField(
            controller: _commentController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Share details about your experience with this product...',
              filled: true,
              fillColor: const Color(0xFFF5F5F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Add Photo or Video', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ..._mediaFiles.asMap().entries.map((entry) {
                  final index = entry.key;
                  final file = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(file, width: 90, height: 90, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () => _removeMedia(index),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                GestureDetector(
                  onTap: _pickMedia,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                    ),
                    child: Icon(Icons.add_a_photo_outlined, color: primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Text('Submit Review', style: TextStyle(fontSize: 15, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
