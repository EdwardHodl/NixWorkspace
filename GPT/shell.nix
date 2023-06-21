{ pkgs ? import <nixpkgs> {}, config }:

pkgs.mkShell {
  name = "GPTShell";

  buildInputs = with pkgs; [
    git
    # https://discourse.nixos.org/t/how-to-get-this-basic-c-build-to-work-in-a-nix-shell/12262/4
    glibc.out
    glibc.static
    gcc11
    cmake
    qt6.qtbase
  ];

shellHook = ''
  echo "================================================================================"
  echo "                         LlamaGPTJ-chat Documentation"
  echo "================================================================================"
  echo
  echo "----------------------------- Source Location ----------------------------------"
  echo "https://github.com/kuvaus/LlamaGPTJ-chat"
  echo
  echo "----------------------------- Build Instructions --------------------------------"
  echo "1. Clone the repository:"
  echo "   git clone --recurse-submodules https://github.com/kuvaus/LlamaGPTJ-chat"
  echo "2. Change into the LlamaGPTJ-chat directory:"
  echo "   cd LlamaGPTJ-chat"
  echo "3. Build the project:"
  echo "   mkdir build && cd build && cmake .. && cmake --build . --parallel"
  echo
  echo "-------------------------- Executable Paths & Usage ----------------------------"
  echo "The executable is located at: build/bin/chat"
  echo "To use the executable with 4 threads, run:"
  echo "./chat -m \"${lapbox.homedir}/NixWorkspace/GPT/data/models/your_model.bin\" -t 4"
  echo
  echo "----------------------------- Configuration Paths ------------------------------"
  echo "Model location: ${lapbox.homedir}/NixWorkspace/GPT/data/models/"
  echo
  echo "================================================================================"

  alias gptjchatdir="cd ${lapbox.homedir}/NixWorkspace/GPT/LlamaGPTJ-chat"
  alias gptjchatbuild="mkdir -p build && cd build && cmake .. --fresh && cmake --build . --parallel"
  alias modelsdir="cd ${lapbox.homedir}/NixWorkspace/GPT/data/models"
  alias chat="${lapbox.homedir}/NixWorkspace/GPT/LlamaGPTJ-chat/build/bin/chat"
  alias
'';
}
