class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.3/crewhaus-macos-arm64-0.1.3"
      sha256 "e9873c9c70ce7a236b8370ecf2590e524e41c9ca109a9f5b6abbdd3e85ee9ce9"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.3/crewhaus-macos-x64-0.1.3"
      sha256 "1048997e5b70894c4908a20549a56d01f2c78c1f81fd32e9603d2dea9771d4e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.3/crewhaus-linux-arm64-0.1.3"
      sha256 "41d751a1031d4cd9defe7b7acafad1071b64d9e30b48ea745e0a663e05239d4e"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.3/crewhaus-linux-x64-0.1.3"
      sha256 "64f5052a7696fcde918587c3a24d0e1c7c1acc75003453d9066e867d660c626a"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
