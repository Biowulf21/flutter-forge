# Feature Forge

Feature Forge is a Neovim plugin designed to streamline Flutter development by automatically generating feature-based architecture files. This plugin helps you quickly scaffold new features following a clean architecture approach with BLoC/Cubit for state management.

## Overview

Feature Forge automatically generates the following components for a new feature:

- **View**: Flutter UI components with BLoC consumer setup
- **Cubit**: State management classes following the BLoC pattern
- **Model**: Data classes with Equatable integration
- **Repository**: Abstract and concrete repository implementations

## Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'yourusername/feature_forge',
  requires = { 'nvim-lua/plenary.nvim' }
}
```

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'yourusername/feature_forge',
  dependencies = { 'nvim-lua/plenary.nvim' }
}
```

## Usage

1. Open your Flutter project in Neovim
2. Run the command:

```vim
:lua require('featureForge').createFeature()
```

3. Enter the feature name when prompted (e.g., "UserAuthentication")
4. Feature Forge will generate all the necessary files in the `lib/features/<feature_name>/` directory

## Generated Structure

For a feature named "UserAuthentication", Feature Forge will create:

```
lib/features/UserAuthentication/
├── data/
│   ├── cubit/
│   │   ├── user_authentication_cubit.dart
│   │   └── user_authentication_state.dart
│   ├── model/
│   │   └── user_authentication_model.dart
│   └── repository/
│       └── user_authentication_repository.dart
└── view/
    └── user_authentication_page.dart
```

## Requirements

- Neovim 0.5.0+
- Flutter project with a valid pubspec.yaml file

## Configuration

By default, Feature Forge assumes a standard Flutter project structure. No additional configuration is required.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT
