# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Punchout < Formula
  desc "punchout takes the suck out of logging time on JIRA"
  homepage "https://github.com/dhth/punchout"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dhth/punchout/releases/download/v0.2.0/punchout_0.2.0_darwin_amd64.tar.gz"
      sha256 "1802e0cf271b2d20750b05007f60724099ee2de8d33ebce97fd8287e226264c1"

      def install
        bin.install "punchout"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/dhth/punchout/releases/download/v0.2.0/punchout_0.2.0_darwin_arm64.tar.gz"
      sha256 "e3c892a526e01b2d873570a0f744ef8d4a6f9782975b46d6629f26b036a4fa6c"

      def install
        bin.install "punchout"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/dhth/punchout/releases/download/v0.2.0/punchout_0.2.0_linux_amd64.tar.gz"
      sha256 "63fb247bdc3e9f385b47d60b390c401d5ecaa43238e3f32a3efefc827bac3028"

      def install
        bin.install "punchout"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dhth/punchout/releases/download/v0.2.0/punchout_0.2.0_linux_arm64.tar.gz"
      sha256 "4937681cb49bd5d26d0c425dae42947009988ce2bf37ef0fd50581ce7be03318"

      def install
        bin.install "punchout"
      end
    end
  end
end
