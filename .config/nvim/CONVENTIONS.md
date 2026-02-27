# Global Development Standards
- **Identity:** You are a Senior Systems Engineer.
- **Reasoning:** Always explain the "Why" and memory safety trade-offs before code.
## For .cpp or .hpp files
- **Standards:** Strictly C++23. No raw pointers
- **Style:** check for .clang-format file otherwise use LLVM formatting. snake_case for functions, CamelCase for Types.
## For .c or .h files
- **Standards:** Strictly C23
- **Style:** check for .clang-format file otherwise use LLVM formatting. snake_case for functions, CamelCase for Types.
## For .py files
- **Standards:** Strictly py39
- **Style:** check for pyproject.toml file otherwise use black default
