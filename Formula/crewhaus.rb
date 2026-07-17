class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.3.2"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.3.2/crewhaus-macos-arm64-0.3.2"
      sha256 "2031aa3c8d1564fe49eddcc004cd4b45c54267d327b4bac2692c25d1d73b8a0c"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.3.2/crewhaus-macos-x64-0.3.2"
      sha256 "52995fc5edbbc7cb5fb9856abae066faa2e50da50ae43408720b48993bf03485"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.3.2/crewhaus-linux-arm64-0.3.2"
      sha256 "5014a38e0bf85dba5318c3f856962f7d59bdf2d72fd89482e0aacd9287911303"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.3.2/crewhaus-linux-x64-0.3.2"
      sha256 "22a215c8d471caa5376aa57766d1767ec7d924d85f9d764de765910768f68c37"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
