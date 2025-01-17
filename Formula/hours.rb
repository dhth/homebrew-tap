# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Hours < Formula
  desc "A no-frills time tracking toolkit for the command line"
  homepage "https://github.com/dhth/hours"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dhth/hours/releases/download/v0.4.0/hours_0.4.0_darwin_amd64.tar.gz"
      sha256 "3e7b588ba43c5fd6f4ed17451f2df7d5b53ec7638e9e3eb7413b94738f07c3c5"

      def install
        bin.install "hours"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/dhth/hours/releases/download/v0.4.0/hours_0.4.0_darwin_arm64.tar.gz"
      sha256 "41cc233948d46eee16e6eb39e3e0798f932e841d11a746ec4994b1f865ace5a7"

      def install
        bin.install "hours"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/hours/releases/download/v0.4.0/hours_0.4.0_linux_amd64.tar.gz"
        sha256 "4a45b767d51b97f4c8b804e4124a09030bd8d536985cbad1a3cce428e99f9294"

        def install
          bin.install "hours"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/hours/releases/download/v0.4.0/hours_0.4.0_linux_arm64.tar.gz"
        sha256 "2479c77362c76392e716a15791fd584b2c2d25281174ad975a930d81dd61ff9b"

        def install
          bin.install "hours"
        end
      end
    end
  end
end
