import sys
import re

def tokenize(code):
    # Adds newlines after semicolons and closing parentheses
    code = re.sub(r';', ';\n', code)
    code = re.sub(r'\)', ')\n', code)
    code = re.sub(r'\(', '(\n', code)
    return code.splitlines()

def format_dsl_code(code):
    tokens = tokenize(code)
    indent = 0
    result = []

    for raw_line in tokens:
        line = raw_line.strip()

        if not line:
            continue

        # Decrease indent before printing, if closing a block
        if line == ')' or line.startswith(')'):
            indent -= 1

        # Add the line with proper indentation
        result.append('\t' * indent + line)

        # Increase indent after certain patterns
        if re.match(r'^if\s*\(.*', line) or line.endswith('('):
            indent += 1

        # Decrease indent after line ending with ; if not followed by block
        elif line.endswith(';') and not line.startswith('if'):
            indent = max(0, indent - 1)

    return '\n'.join(result)

if __name__ == "__main__":
    raw_input = sys.stdin.read()
    print(format_dsl_code(raw_input))
