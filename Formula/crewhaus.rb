class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.3.1"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.3.1/crewhaus-macos-arm64-0.3.1"
      sha256 "71927e51fb80cc142ed4186e2dbaebbe5d0d4c650cca40481f78ac79434e0745"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.3.1/crewhaus-macos-x64-0.3.1"
      sha256 "628cde09de27248c91097a0ffe48340a4d73c6030462936d2f61dcfba2395734"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.3.1/crewhaus-linux-arm64-0.3.1"
      sha256 "42257027d3b7ae9b3ec1d7a4eda01314d31b910a081718b199240cd239f922aa"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.3.1/crewhaus-linux-x64-0.3.1"
      sha256 "6d207d8d939084c69b887a987c88ebbfc96c5896e71d82322e955ae08f331bd1"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
