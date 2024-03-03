class Gobrewtest < Formula
  desc "A completely useless binary; used for testing purposes"
  homepage "https://github.com/dhth/gobrewtest"
  version "0.1.4"

  on_macos do
    url "https://github.com/dhth/gobrewtest/releases/download/v0.1.4/gobrewtest_Darwin_arm64.tar.gz"
    sha256 "0e9993283ef4843935bcc226b8b4af4e1c3637aaa5a09e2859e9a56fcdbd3f9f"

    def install
      bin.install "gobrewtest"
    end
  end
end
