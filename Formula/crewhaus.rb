class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.2.4"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.2.4/crewhaus-macos-arm64-0.2.4"
      sha256 "74e2161f8fba46f90cda4700ce27b98d8aec39f25f2c8e16a922f36534023178"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.2.4/crewhaus-macos-x64-0.2.4"
      sha256 "03e99e81aeb65823f1ecc9abbcec6070b9a8e783869e83589e870a44903c54a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.2.4/crewhaus-linux-arm64-0.2.4"
      sha256 "419382fe36ec167e57eafb4ff0f06e6d749aaac41cd6cc892f69f9bb5e1c8b1a"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.2.4/crewhaus-linux-x64-0.2.4"
      sha256 "41da6db5eb07a651ace259c8562e88627a09a7a88d4f8a2a7a1133f12dac0034"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
