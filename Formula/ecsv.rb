# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Ecsv < Formula
  desc "Quickly check the versions of your systems running in ECS tasks across various environments"
  homepage "https://github.com/dhth/ecsv"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dhth/ecsv/releases/download/v0.4.0/ecsv_0.4.0_darwin_arm64.tar.gz"
      sha256 "853592b0263869a0e83605aad406f3d9fa743b14a71312503d6c8235428fef04"

      def install
        bin.install "ecsv"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ecsv/releases/download/v0.4.0/ecsv_0.4.0_darwin_amd64.tar.gz"
      sha256 "23eb9ed188de66a6c40e163d5df2adfbc16853df29ed6249c288190695fd26af"

      def install
        bin.install "ecsv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dhth/ecsv/releases/download/v0.4.0/ecsv_0.4.0_linux_arm64.tar.gz"
      sha256 "44bcceb1352feb0ff6ee9e5018e9781ff5c3fb58ccf81cfc492184adb4608cd6"

      def install
        bin.install "ecsv"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ecsv/releases/download/v0.4.0/ecsv_0.4.0_linux_amd64.tar.gz"
      sha256 "6dee62ee76b4eb996c80aa856709da6318f008cecd75ddbc4046550573f4fae7"

      def install
        bin.install "ecsv"
      end
    end
  end
end
