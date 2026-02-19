import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jacktest1/src/features/products/domain/product.dart';
import 'package:jacktest1/src/features/products/presentation/controllers/product_controller.dart';

class ProductFormDialog extends HookConsumerWidget {
  const ProductFormDialog({super.key, this.product});

  final Product? product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: product?.name);
    final descriptionController = useTextEditingController(
      text: product?.description,
    );
    final priceController = useTextEditingController(
      text: product?.price.toString(),
    );
    final category = useState<String>(product?.category ?? 'LPG Cylinder');

    final categories = ['LPG Cylinder', 'Refill', 'Accessory', 'Water'];

    return AlertDialog(
      title: Text(product == null ? 'Create Product' : 'Edit Product'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: category.value,
              onChanged: (value) => category.value = value!,
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final newProduct = Product(
              id: product?.id,
              name: nameController.text,
              category: category.value,
              price: double.tryParse(priceController.text) ?? 0.0,
              description: descriptionController.text,
            );

            if (product == null) {
              await ref
                  .read(productControllerProvider.notifier)
                  .addProduct(newProduct);
            } else {
              await ref
                  .read(productControllerProvider.notifier)
                  .updateProduct(newProduct);
            }
            if (context.mounted) Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
