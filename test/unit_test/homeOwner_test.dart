import 'package:flutter_test/flutter_test.dart';
import 'package:wherehome/data/repositories/home_owner_repo.dart';
import 'package:wherehome/data/repositories/user_repo.dart';

void main() {
  group('HomeOwner Class Tests', () {
    test('HomeOwner object creation test', () {
      HomeOwner homeOwner = HomeOwner(
        id: '12345',
        user: User(
          phoneNumber: '1234567890',
          email: 'john@example.com',
        ),
      );

      expect(homeOwner.id, '12345');
      expect(homeOwner.user.phoneNumber, '1234567890');
      expect(homeOwner.user.email, 'john@example.com');
    });

    group('User Class Tests', () {
      test('User object creation test', () {
        User user = User(
          id: '54321',
          email: 'user@example.com',
          phoneNumber: '9876543210',
        );
        expect(user.id, '54321');
        expect(user.email, 'user@example.com');
        expect(user.phoneNumber, '9876543210');
      });

      test('User JSON serialization test', () {
        User user = User(
          id: '54321',
          email: 'user@example.com',
          phoneNumber: '9876543210',
        );

        final json = user.toJson('password');
        expect(json['phoneNumber'], '9876543210');
        expect(json['password'], 'password');
      });
    });
  });
}
