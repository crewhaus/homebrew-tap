class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.7.0"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.7.0/crewhaus-macos-arm64-0.7.0"
      sha256 "b7d55bc8f057568cf545d356dfcf59240faefe6ab075e92011184520db50b6b5"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.7.0/crewhaus-macos-x64-0.7.0"
      sha256 "3240b94e9d6cee4b137bf8bda1832bf43d9d7df3a24b15fe22059456c41d4117"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.7.0/crewhaus-linux-arm64-0.7.0"
      sha256 "1f0cab873a9c581450e300a22d50b3d9b7e0de5294ea594c5647a6f6deb2e887"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.7.0/crewhaus-linux-x64-0.7.0"
      sha256 "f2847a46419d1671de555efb69aaa22cf11d43683f701886c850b2b1ec02b8f4"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
