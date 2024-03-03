# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Gobrewtest < Formula
  desc "A completely useless binary; used for testing purposes"
  homepage "https://github.com/dhth/gobrewtest"
  version "0.1.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dhth/gobrewtest/releases/download/v0.1.6/gobrewtest_Darwin_arm64.tar.gz"
      sha256 "9e1b82053dc888594207dd454260a45f5bb4fe2f5348008c14d591341bdbb651"

      def install
        bin.install "gobrewtest"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/gobrewtest/releases/download/v0.1.6/gobrewtest_Darwin_x86_64.tar.gz"
      sha256 "f5f9e8592b22e3373f537647691aefd36a83bb6ff54c9cef9f483a87b65ced8f"

      def install
        bin.install "gobrewtest"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dhth/gobrewtest/releases/download/v0.1.6/gobrewtest_Linux_arm64.tar.gz"
      sha256 "e78a206a859dbd79e28f48dde6efa490e7e1c3e37df5cb4035d9dae74846fdb3"

      def install
        bin.install "gobrewtest"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/gobrewtest/releases/download/v0.1.6/gobrewtest_Linux_x86_64.tar.gz"
      sha256 "481c869554ee7144c444e6719c38b3595615f644eb451e887766a85b6a1665b1"

      def install
        bin.install "gobrewtest"
      end
    end
  end
end
