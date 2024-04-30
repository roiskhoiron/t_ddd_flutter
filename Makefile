build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs

unit_test:
	flutter test

integration_test:
	flutter test integration_test

golden_test:
	flutter test --update-goldens

golden_test_integration:
	flutter test test/integration_test --update-goldens