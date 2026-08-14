class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.5.6"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.5.6/crewhaus-macos-arm64-0.5.6"
      sha256 "d20c6d2581146d2fa8594edf051c8992fc70cac54377eea67acd1eb4581306da"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.5.6/crewhaus-macos-x64-0.5.6"
      sha256 "53151f9ae1859d5a8882fa413b661b4b825da949f9dedf3c95f8b5367625bfa4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.6/crewhaus-linux-arm64-0.5.6"
      sha256 "b3971f7f5c68715f07fe154af57c2861ea7b63f8c3aa61558bfb4beb4f6a290d"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.6/crewhaus-linux-x64-0.5.6"
      sha256 "b3d820c6a550048a02c373301f3868328cbf35f94525e1a5040fc4206085da67"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
