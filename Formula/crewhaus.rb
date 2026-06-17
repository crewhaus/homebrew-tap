class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.1.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.4/crewhaus-macos-arm64-0.1.4"
      sha256 "f74c093018294e44e7616846d92c547f8aed859c1ae74ca47b27f5f85308b29e"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.4/crewhaus-macos-x64-0.1.4"
      sha256 "7ae4c10cc0bf81d9fc0eea248e0fce01f6a7e39c798cb7d71711b88944232f9c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.4/crewhaus-linux-arm64-0.1.4"
      sha256 "85e590e84a1626dfe050fbe490ea5e3d76b36b8d0c3c5a9e3305789461303ea2"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.4/crewhaus-linux-x64-0.1.4"
      sha256 "f8b2a957da84c9335fe30fad2bb88659f4bf06b1399fcb8894e3991828e0b743"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
