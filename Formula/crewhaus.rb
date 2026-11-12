class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.8.2"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.8.2/crewhaus-macos-arm64-0.8.2"
      sha256 "a4cdc1374d06b5165b2e63786a34439d2cff50686a4908be08a5cb1384776e07"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.8.2/crewhaus-macos-x64-0.8.2"
      sha256 "36bbec949580ea9fc13ea2ff7455570a5b73592ebdd3df3537e77845af517394"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.8.2/crewhaus-linux-arm64-0.8.2"
      sha256 "ff51c9c55cfe997549b7585e0293aca8db50319e59f0b7644c918eef6f39cc05"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.8.2/crewhaus-linux-x64-0.8.2"
      sha256 "9c35ce8c93fb41c6752d78e712005d0a93f149349c18bbc72cca8897a5937099"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
