# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Outtasync < Formula
  desc "Quickly identify CloudFormation stacks that have gone out of sync with their counterpart stack files"
  homepage "https://github.com/dhth/outtasync"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dhth/outtasync/releases/download/v0.2.0/outtasync_0.2.0_darwin_arm64.tar.gz"
      sha256 "f86e18554bd39f4b85ea8168bd2fcdc55fa236973c16fc2d5d661d2b6c4c3f09"

      def install
        bin.install "outtasync"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/outtasync/releases/download/v0.2.0/outtasync_0.2.0_darwin_amd64.tar.gz"
      sha256 "332e94d3540adba76d0327119ff42bde2aacb30d7f2762aa44477f402dceb3d5"

      def install
        bin.install "outtasync"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dhth/outtasync/releases/download/v0.2.0/outtasync_0.2.0_linux_arm64.tar.gz"
      sha256 "f70b5e1de36ba11d8a83b482f0818a5ad70dd4904e4de8cf35598f1bbb0950f6"

      def install
        bin.install "outtasync"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/outtasync/releases/download/v0.2.0/outtasync_0.2.0_linux_amd64.tar.gz"
      sha256 "98cf4d0e93e3bf834151361301db3db04f332244d407e40b77e5404b7d0dd3d5"

      def install
        bin.install "outtasync"
      end
    end
  end
end
