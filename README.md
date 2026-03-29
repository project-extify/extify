# extify

A structured Lua CLI tool to quickly scaffold browser extension boilerplates with interactive input and template support.

## Features

- **Interactive Setup**: Prompts for extension name, description, version, and author.
- **Multiple Templates**: Choose between different boilerplate structures (e.g., `basic`, `popup-only`).
- **Dynamic Scaffolding**: Automatically populates `manifest.json` and other files with your inputs using `{{PLACEHOLDER}}` syntax.
- **Extensible**: Easily add your own templates to the `templates/` directory.

## Prerequisites

- [Lua](https://www.lua.org/) (5.1 or later recommended).
- Unix-like environment (Linux, macOS, Termux) with `ls` and `find` available.

## Usage

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd extify
   ```

2. **Initialize a new extension**:
   Navigate to the directory where you want to create your extension and run:
   ```bash
   lua /path/to/extify/main.lua init
   ```

3. **Follow the prompts**:
   The CLI will ask you for:
   - **Extension Name**
   - **Description**
   - **Version** (defaults to 1.0.0)
   - **Author**
   - **Template Selection** (e.g., `1` for basic, `2` for popup-only)

4. **Result**:
   The tool will scaffold the project structure in your current directory, replacing all placeholders with your specific details.

## Available Templates

- **`basic`**: A full Manifest V3 extension including a background service worker and a popup.
- **`popup-only`**: A minimal Manifest V3 extension focused only on a popup interface.

## Creating Custom Templates

To add your own template:
1. Create a new folder in the `templates/` directory (e.g., `templates/my-vue-template/`).
2. Add your extension files inside that folder.
3. Use the following placeholders in any file:
   - `{{NAME}}`
   - `{{DESCRIPTION}}`
   - `{{VERSION}}`
   - `{{AUTHOR}}`

`extify` will automatically list your new template the next time you run `init`.
