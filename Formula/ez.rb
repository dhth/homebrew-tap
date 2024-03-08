# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Ez < Formula
  desc "write stdin to stdout, but slowly"
  homepage "https://github.com/dhth/ez"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dhth/ez/releases/download/v0.1.0/ez_0.1.0_darwin_arm64.tar.gz"
      sha256 "8be5752819d89f7e38c1ce7b6f22cfa9b55368331f964c78c492bb4b59652850"

      def install
        bin.install "ez"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ez/releases/download/v0.1.0/ez_0.1.0_darwin_amd64.tar.gz"
      sha256 "64a0f449a940e91aceb795dd11250229fa5defb22de80900baf159fc855c5057"

      def install
        bin.install "ez"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ez/releases/download/v0.1.0/ez_0.1.0_linux_amd64.tar.gz"
      sha256 "f1417ffc6ac3177673daa8a87173c51216ad5d46fa821c805a5c83e8db563909"

      def install
        bin.install "ez"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dhth/ez/releases/download/v0.1.0/ez_0.1.0_linux_arm64.tar.gz"
      sha256 "c146dc4ef548ea3ba2f81034825c5a5f0a3b53a518cf38f82f832666cebbab19"

      def install
        bin.install "ez"
      end
    end
  end
end
