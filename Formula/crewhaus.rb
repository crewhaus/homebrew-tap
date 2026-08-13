class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.5.4"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.5.4/crewhaus-macos-arm64-0.5.4"
      sha256 "c08cda191e612443f27de3657f8d8c79ba7f346270c25741487f57cf821d30ac"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.5.4/crewhaus-macos-x64-0.5.4"
      sha256 "6398b65f26337cfe61e473ba3d5f30b2f8cf905397c608690dca5528b3ed9c84"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.4/crewhaus-linux-arm64-0.5.4"
      sha256 "f3355332b080d4bff5416c5c2924f26d8ef5168d83740c1432740603f891a507"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.4/crewhaus-linux-x64-0.5.4"
      sha256 "45443a2b096dffe4c83186802801ef1c6831d45609765496aced0db3b077c342"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
