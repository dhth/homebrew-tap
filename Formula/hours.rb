# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Hours < Formula
  desc "A no-frills time tracking toolkit for the command line"
  homepage "https://github.com/dhth/hours"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/dhth/hours/releases/download/v0.2.0/hours_0.2.0_darwin_amd64.tar.gz"
      sha256 "b9eebc947ed630e3893b7975b08efd26db1d647a2bc53f0d8753ff3a2687658c"

      def install
        bin.install "hours"
      end
    end
    on_arm do
      url "https://github.com/dhth/hours/releases/download/v0.2.0/hours_0.2.0_darwin_arm64.tar.gz"
      sha256 "ccc14e02b926aa7dfcf4b909a0f50ea03ee3205d10d1a5a008ee37385cdbf6b4"

      def install
        bin.install "hours"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/hours/releases/download/v0.2.0/hours_0.2.0_linux_amd64.tar.gz"
        sha256 "90ecef273fb63493eb95e2ecf8072afb976097b8d4f95be73e8907b869821f11"

        def install
          bin.install "hours"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/hours/releases/download/v0.2.0/hours_0.2.0_linux_arm64.tar.gz"
        sha256 "c29c6f479297d0e46bed4b2128d9c287883d4b62671cbb34a62c2c719b06fed9"

        def install
          bin.install "hours"
        end
      end
    end
  end
end
