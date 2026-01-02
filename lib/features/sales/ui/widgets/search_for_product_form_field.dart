import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/sales/logic/provider/select_product_provider.dart';
import 'package:small_managements/generated/l10n.dart';

class SearchForProductFormField extends StatefulWidget {
  const SearchForProductFormField({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  SearchForProductFormFieldState createState() => SearchForProductFormFieldState();
}
class SearchForProductFormFieldState extends State<SearchForProductFormField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isSelectingProduct = false; // متغير جديد

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && !_isSelectingProduct) {
      Future.delayed(Duration(milliseconds: 150), () {
        if (!_isSelectingProduct) {
          _removeOverlay();
        }
      });
    }
  }

  void _handleTextChange() {
    if (_controller.text.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    _removeOverlay();
    final products = widget.ref
        .read(productProviderNotifier)
        .where((product) => product.productName.toLowerCase().contains(_controller.text.toLowerCase()))
        .toList();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.9,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, 60),
          child: Material(
            elevation: 8,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => _isSelectingProduct = true,
                    onExit: (_) => _isSelectingProduct = false,
                    child: InkWell(
                      onTap: () {
                        _isSelectingProduct = false;
                        widget.ref.read(selectProductProvider.notifier).addProduct(product);
                        _controller.clear();
                        _removeOverlay();
                        Future.delayed(Duration(milliseconds: 100), () {
                          _focusNode.requestFocus();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(product.productName)),
                            Text(
                              "${product.sellingPrice} \$",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: CustomTextFormField(
        focusNode: _focusNode,
        controller: _controller,
        keyboardType: TextInputType.text,
        labelText: S.of(context).searchForProduct,
        validator: (v) {
          return null;
        },
      ),
    );
  }
}