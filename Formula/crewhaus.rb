class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.3.0/crewhaus-macos-arm64-0.3.0"
      sha256 "7a1f5dbe472467712b79d68c4d7a82cdbdb291c72491852a4897925b86738318"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.3.0/crewhaus-macos-x64-0.3.0"
      sha256 "71cdb386731e7a2b569f3768ff5d8bdb26d3dae8b02f8e1fad2afad3970ccd2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.3.0/crewhaus-linux-arm64-0.3.0"
      sha256 "f7f17c3c5bfb9a0de4a065f13fc265c3619325e911fd931669c57f2760dfecea"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.3.0/crewhaus-linux-x64-0.3.0"
      sha256 "88be522450daeaf8330483f5ab621cbc6cbe5e64c05f82bb7d5232a35466a979"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
