import 'package:axons/screen/home.dart';
import 'package:axons/provider/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginWithPin extends ConsumerStatefulWidget {
  const LoginWithPin({Key? key}) : super(key: key);

  @override
  LoginWithPinState createState() => LoginWithPinState();
}

class LoginWithPinState extends ConsumerState<LoginWithPin> {
  String _input = '';

  void _onDigitButtonPressed(String digit) {
    if (digit == 'backspace') {
      // Delete last digit
      if (_input.isNotEmpty) {
        setState(() {
          _input = _input.substring(0, _input.length - 1);
        });
      }
    } else {
      // Append digit
      if (_input.length < 4) {
        setState(() {
          _input += digit;
        });
        // Check if the input has exactly four digits
        if (_input.length == 4) {
          // Compare the input with the pin from the provider
          if (_input == ref.read(pinProvider)) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (route) => false,
            );
          }
        }
      }
    }
  }

  Widget _buildErrorMessage() {
    if (_input.length == 4) {
      if (_input != ref.read(pinProvider)) {
        return const Text(
          'กรุณาใส่รหัสที่ถูกต้อง',
          style: TextStyle(color: Colors.red),
        );
      }
    }
    return const SizedBox.shrink();
  }

  Widget _buildInputWidget() {
    final List<Widget> circles = List.generate(4, (index) {
      if (index < _input.length) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Icon(
            Icons.circle,
            size: 24,
            color: Colors.indigo,
          ),
        );
      } else {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Icon(
            Icons.circle,
            size: 24,
            color: Colors.grey,
          ),
        );
      }
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: circles,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInputWidget(),
        const SizedBox(height: 16),
        _buildErrorMessage(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDigitButton('1'),
            _buildDigitButton('2'),
            _buildDigitButton('3'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDigitButton('4'),
            _buildDigitButton('5'),
            _buildDigitButton('6'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDigitButton('7'),
            _buildDigitButton('8'),
            _buildDigitButton('9'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDigitButton(''),
            _buildDigitButton('0'),
            _buildDigitButton('backspace'),
          ],
        ),
      ],
    );
  }

  Widget _buildDigitButton(String digit) {
    return TextButton(
      onPressed: () => _onDigitButtonPressed(digit),
      style: TextButton.styleFrom(foregroundColor: Colors.black, minimumSize: const Size(100, 50)),
      child: digit == 'backspace' ? const Icon(Icons.backspace_outlined) : Text(digit),
    );
  }
}
