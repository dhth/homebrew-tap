# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Ecsv < Formula
  desc "Quickly check the versions of your systems running in ECS tasks across various environments"
  homepage "https://github.com/dhth/ecsv"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ecsv/releases/download/v0.5.0/ecsv_0.5.0_darwin_amd64.tar.gz"
      sha256 "79cd29b3548a4a4a2af4f492d3b232e9d5556f4edb18abbaddcec9a3c122ba66"

      def install
        bin.install "ecsv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/dhth/ecsv/releases/download/v0.5.0/ecsv_0.5.0_darwin_arm64.tar.gz"
      sha256 "9339ecaab316ee60ce97f158411307f3517f57a8d78c5c83b2c44160c75f6f30"

      def install
        bin.install "ecsv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dhth/ecsv/releases/download/v0.5.0/ecsv_0.5.0_linux_arm64.tar.gz"
      sha256 "d2ae71cac9ed16e4bdd8dd7a84cd7aec22c15cdde291224664b021c1fff53205"

      def install
        bin.install "ecsv"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ecsv/releases/download/v0.5.0/ecsv_0.5.0_linux_amd64.tar.gz"
      sha256 "80ad43e96a62e4e7993122b0f22859ad935f934704cf54a5995abd183dcc2592"

      def install
        bin.install "ecsv"
      end
    end
  end
end
