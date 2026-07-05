class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.2.1"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.2.1/crewhaus-macos-arm64-0.2.1"
      sha256 "f1b31d2cfa740e7436445850529870d4a987a97ec2cf448d19c2f513f90edbc9"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.2.1/crewhaus-macos-x64-0.2.1"
      sha256 "4725eac07eeb63f15abf6c7e16eaa05ce088fe5c03d39a63663772450921303b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.2.1/crewhaus-linux-arm64-0.2.1"
      sha256 "f3eb69e6b1229f85a2e0b4a9f17944c06feab86d349ad4a63dfaebffd3cf9ea4"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.2.1/crewhaus-linux-x64-0.2.1"
      sha256 "1443f70fb3923c280fa3f7dde0c6d2f4bda17a8be81ad56d8640a5291e5be021"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
