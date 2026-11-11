class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.8.1"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.8.1/crewhaus-macos-arm64-0.8.1"
      sha256 "e851c913c6cfe93e841b67e1c49a5126dcdaddbff0fa646c70801ab1bc342153"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.8.1/crewhaus-macos-x64-0.8.1"
      sha256 "2aec9de5f346c344284313f530a02f49d1b96fceb13ac8de3abe58cf0138a3e0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.8.1/crewhaus-linux-arm64-0.8.1"
      sha256 "d9d0d047134210887e085e3fd4d52198aa6db84406eb8b06d14eeb9465edd6c3"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.8.1/crewhaus-linux-x64-0.8.1"
      sha256 "3d996105942e784ce271da385f78cdde4dddfac5e9ed700b0e44a6d3c58feae4"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
