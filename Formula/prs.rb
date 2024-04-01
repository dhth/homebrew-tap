# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Prs < Formula
  desc "Stay updated on PRs without leaving the terminal"
  homepage "https://github.com/dhth/prs"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dhth/prs/releases/download/v0.1.0/prs_0.1.0_darwin_arm64.tar.gz"
      sha256 "080f54efa4f2ebcba1e6ee2bbf92b8636276a60894e5f8ce444a73dc0946952a"

      def install
        bin.install "prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/prs/releases/download/v0.1.0/prs_0.1.0_darwin_amd64.tar.gz"
      sha256 "343be62e83ca7edda0002924cfd6e1c326fad473947a9356cb7d6871743a994b"

      def install
        bin.install "prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dhth/prs/releases/download/v0.1.0/prs_0.1.0_linux_arm64.tar.gz"
      sha256 "2ce97365036c64aa8ac13f6cf9338053de9ef74839fe10fbfc13c933126d2bf8"

      def install
        bin.install "prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/prs/releases/download/v0.1.0/prs_0.1.0_linux_amd64.tar.gz"
      sha256 "ba9459d028d7a40245341eb9164a4abfd8b7ecbbda2dad2a73a06db65416b260"

      def install
        bin.install "prs"
      end
    end
  end
end
