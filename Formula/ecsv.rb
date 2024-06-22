# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Ecsv < Formula
  desc "Quickly check the versions of your systems running in ECS tasks across various environments"
  homepage "https://github.com/dhth/ecsv"
  version "1.2.2"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/dhth/ecsv/releases/download/v1.2.2/ecsv_1.2.2_darwin_amd64.tar.gz"
      sha256 "6592d542a4994a217a5bc6db6e8e09a620a8a64c6eeff85d1eb8a4545b9d933d"

      def install
        bin.install "ecsv"
      end
    end
    on_arm do
      url "https://github.com/dhth/ecsv/releases/download/v1.2.2/ecsv_1.2.2_darwin_arm64.tar.gz"
      sha256 "1297bfd6244e49068af83daf36f9dcf54760eec3063e1cdf83b3834b9d061029"

      def install
        bin.install "ecsv"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/ecsv/releases/download/v1.2.2/ecsv_1.2.2_linux_amd64.tar.gz"
        sha256 "dcbb621fa458febf0c3848f0b4f25545b0335cd643995ffd19d56045b46d8e59"

        def install
          bin.install "ecsv"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/ecsv/releases/download/v1.2.2/ecsv_1.2.2_linux_arm64.tar.gz"
        sha256 "671b65b60039ddd9cbd39703208d9db73f54137c379dd8377bf6d43c4b4ff865"

        def install
          bin.install "ecsv"
        end
      end
    end
  end
end
