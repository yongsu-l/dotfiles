#!/bin/bash
set -euo pipefail

# Get the directory of the script itself
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change to that directory
cd "$SCRIPT_DIR"

# Install stow based on platform
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install stow
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Ubuntu/Debian
    sudo apt update && sudo apt install -y stow yacc # yacc is a dependency to install tmux with mise
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

stow --adopt . && git restore .

# p10k
if [ ! -d ~/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
fi

# devtools
curl https://mise.run | sh
mise install

zsh -c "exit 0"
