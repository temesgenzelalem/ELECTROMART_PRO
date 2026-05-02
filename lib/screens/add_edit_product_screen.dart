import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../providers.dart';
import '../models/product_model.dart';

class AddEditProductScreen extends ConsumerStatefulWidget {
  final String? productId;
  const AddEditProductScreen({super.key, this.productId});

  @override
  ConsumerState<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends ConsumerState<AddEditProductScreen> {
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _priceController = TextEditingController();
  final _specsController = TextEditingController();
  final _stockController = TextEditingController();
  File? _imageFile;
  String? _existingImageUrl;
  bool _isSaving = false;

  bool get _isEditing => widget.productId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) _loadProduct();
  }

  Future<void> _loadProduct() async {
    final doc = await ref
        .read(firestoreServiceProvider)
        .productsRef
        .doc(widget.productId)
        .get();
    if (doc.exists) {
      final product = ProductModel.fromFirestore(doc);
      _nameController.text = product.name;
      _brandController.text = product.brand;
      _priceController.text = product.price.toString();
      _specsController.text = product.specs.join(', ');
      _stockController.text = product.stock.toString();
      _existingImageUrl = product.imageUrl;
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _imageFile = File(image.path));
  }

  Future<void> _save() async {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty) return;
    setState(() => _isSaving = true);
    try {
      final name = _nameController.text;
      final brand = _brandController.text;
      final price = double.tryParse(_priceController.text) ?? 0;
      final specs = _specsController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      final stock = int.tryParse(_stockController.text) ?? 0;
      String imageUrl = _existingImageUrl ?? '';
      if (_imageFile != null) {
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}_$name.jpg';
        imageUrl = await ref.read(firestoreServiceProvider).uploadProductImage(_imageFile!, fileName);
      }
      if (_isEditing) {
        await ref.read(firestoreServiceProvider).productsRef.doc(widget.productId).update({
          'name': name,
          'brand': brand,
          'price': price,
          'specs': specs,
          'stock': stock,
          if (imageUrl.isNotEmpty) 'imageUrl': imageUrl,
        });
      } else {
        await ref.read(firestoreServiceProvider).productsRef.add({
          'name': name,
          'brand': brand,
          'price': price,
          'specs': specs,
          'stock': stock,
          'imageUrl': imageUrl,
          'rating': 5.0,
          'reviewCount': 0,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        });
      }
      if (mounted) context.go('/admin-dashboard');
    } catch (e) {
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031427),
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha:0.6),
        title: Text(
          _isEditing ? 'Edit Product' : 'Add Product',
          style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha:0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha:0.1)),
                  ),
                  child: _imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(_imageFile!, fit: BoxFit.cover),
                        )
                      : _existingImageUrl != null && _existingImageUrl!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(_existingImageUrl!, fit: BoxFit.cover),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo, size: 48, color: Colors.grey[600]),
                                const SizedBox(height: 8),
                                Text('Tap to pick image', style: TextStyle(color: Colors.grey[400])),
                              ],
                            ),
                ),
              ),
              const SizedBox(height: 24),
              _buildField('Product Name', _nameController),
              const SizedBox(height: 16),
              _buildField('Brand', _brandController),
              const SizedBox(height: 16),
              _buildField('Price', _priceController, keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildField('Specs (comma separated)', _specsController),
              const SizedBox(height: 16),
              _buildField('Stock', _stockController, keyboardType: TextInputType.number),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isSaving
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(_isEditing ? 'UPDATE' : 'SAVE',
                          style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withValues(alpha:0.3),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade700)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade700)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.blue)),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _priceController.dispose();
    _specsController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
