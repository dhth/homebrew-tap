# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Act3 < Formula
  desc "Glance at the last 3 runs of your Github Actions"
  homepage "https://github.com/dhth/act3"
  version "1.1.2"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/dhth/act3/releases/download/v1.1.2/act3_1.1.2_darwin_amd64.tar.gz"
      sha256 "85e717b27ad6c8a63e7fd6a50a34671acefaa96342057bcfe386e7fbd873d381"

      def install
        bin.install "act3"
      end
    end
    on_arm do
      url "https://github.com/dhth/act3/releases/download/v1.1.2/act3_1.1.2_darwin_arm64.tar.gz"
      sha256 "71ac05b2e8db26abf9f39669f6b1e9c672726f5bc1d52ca1666ed02343dff8bf"

      def install
        bin.install "act3"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/act3/releases/download/v1.1.2/act3_1.1.2_linux_amd64.tar.gz"
        sha256 "83b1adaaf6b9b71f5a5bb66c8e82da3a4561bec55489dd8f7329fa2edff6e236"

        def install
          bin.install "act3"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/act3/releases/download/v1.1.2/act3_1.1.2_linux_arm64.tar.gz"
        sha256 "0c0fcef1cd83534689020fdceef12d9451f142b2a47990adb6499090a12a2024"

        def install
          bin.install "act3"
        end
      end
    end
  end
end
