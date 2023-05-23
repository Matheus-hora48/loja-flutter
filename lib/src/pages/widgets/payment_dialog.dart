import 'package:app/src/config/custom_colors.dart';
import 'package:app/src/models/order_model.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class PaymentDialog extends StatelessWidget {
  PaymentDialog({Key? key, required this.order}) : super(key: key);
  final OrderModel order;
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Pagamento com pix',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Image.memory(
                    utilsServices.decodeQrCodeImage(order.qrCodeImage),
                    height: 200,
                    width: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Vencimento: ${utilsServices.formatDateTime(order.overdueDateTime)}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Text(
                    'Total: ${utilsServices.priceToCurrency(order.total)}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            width: 2, color: CustomColors.customSwatchColor),
                      )),
                      onPressed: () {
                        FlutterClipboard.copy(order.copyAndPaste);
                        utilsServices.showToast(message: 'Código copiado');
                      },
                      icon: const Icon(
                        Icons.copy,
                        size: 15,
                      ),
                      label: const Text(
                        'Copiar código Pix',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ))
          ],
        ));
  }
}
