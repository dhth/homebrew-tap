class Gobrewtest < Formula
  desc "A completely useless binary; used for testing purposes"
  homepage "https://github.com/dhth/gobrewtest"
  version "0.1.2"

  on_macos do
    url "https://github.com/dhth/gobrewtest/releases/download/v0.1.2/gobrewtest_Darwin_arm64.tar.gz"

    def install
      bin.install "gobrewtest"
    end
  end
end
