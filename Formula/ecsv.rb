# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Ecsv < Formula
  desc "Quickly check the versions of your systems running in ECS tasks across various environments"
  homepage "https://github.com/dhth/ecsv"
  version "1.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ecsv/releases/download/v1.3.1/ecsv_1.3.1_darwin_amd64.tar.gz"
      sha256 "dc56ee1cbe8c13add6e5f871a9604bcff77de79f3a9f52cf46dbdf43696b2dec"

      def install
        bin.install "ecsv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/dhth/ecsv/releases/download/v1.3.1/ecsv_1.3.1_darwin_arm64.tar.gz"
      sha256 "573a49ad61e65393212ed572e0541334a7706415d4f09112b81477556a89779f"

      def install
        bin.install "ecsv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/ecsv/releases/download/v1.3.1/ecsv_1.3.1_linux_amd64.tar.gz"
        sha256 "62f99470d6c58f8d2a20c47a5f22af589d929d05d605db20d4488f50b251fa55"

        def install
          bin.install "ecsv"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/ecsv/releases/download/v1.3.1/ecsv_1.3.1_linux_arm64.tar.gz"
        sha256 "d0d0086a36ae1a0ab00c89b9f09ae6c476fa95472762fb491b9d63bbb5a45649"

        def install
          bin.install "ecsv"
        end
      end
    end
  end
end
