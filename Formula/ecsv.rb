# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Ecsv < Formula
  desc "Quickly check the versions of your systems running in ECS tasks across various environments"
  homepage "https://github.com/dhth/ecsv"
  version "2.0.0-beta.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ecsv/releases/download/v2.0.0-beta.1/ecsv_2.0.0-beta.1_darwin_amd64.tar.gz"
      sha256 "21780304042678ecf332f9eaa670c9a826eff58f3de9f9d8e19e1cba366f20b6"

      def install
        bin.install "ecsv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/dhth/ecsv/releases/download/v2.0.0-beta.1/ecsv_2.0.0-beta.1_darwin_arm64.tar.gz"
      sha256 "b8750527fb585ccaf34ceb1a68d0e72b9cc2ed4312315b2d3f2664d449be18a8"

      def install
        bin.install "ecsv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? and Hardware::CPU.is_64_bit?
      url "https://github.com/dhth/ecsv/releases/download/v2.0.0-beta.1/ecsv_2.0.0-beta.1_linux_amd64.tar.gz"
      sha256 "6127a09bace9fa043a9a29bb6dcda674d13b28077b43231486d78ae07819d0ad"
      def install
        bin.install "ecsv"
      end
    end
    if Hardware::CPU.arm? and Hardware::CPU.is_64_bit?
      url "https://github.com/dhth/ecsv/releases/download/v2.0.0-beta.1/ecsv_2.0.0-beta.1_linux_arm64.tar.gz"
      sha256 "a63d59f8c2a22907dc4601158c3c9253df98cf5004e4465808b15e62418ddce4"
      def install
        bin.install "ecsv"
      end
    end
  end
end
