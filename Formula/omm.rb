# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Omm < Formula
  desc "omm is a keyboard-driven task manager for the command line"
  homepage "https://github.com/dhth/omm"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/dhth/omm/releases/download/v0.5.0/omm_0.5.0_darwin_amd64.tar.gz"
      sha256 "b419d1ceb3da716f67f5caf2b558c6e7d1e344471e697a667c0a83717c69d2ab"

      def install
        bin.install "omm"
      end
    end
    on_arm do
      url "https://github.com/dhth/omm/releases/download/v0.5.0/omm_0.5.0_darwin_arm64.tar.gz"
      sha256 "18ed030165bbb9950c316aea317f76a2adc7b86be6ee7630de2ea1bd06f17a08"

      def install
        bin.install "omm"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/omm/releases/download/v0.5.0/omm_0.5.0_linux_amd64.tar.gz"
        sha256 "c2d3fac9c9bd6814ad9ac936b953a700a19383b9c38bcd8e5974324933763665"

        def install
          bin.install "omm"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/omm/releases/download/v0.5.0/omm_0.5.0_linux_arm64.tar.gz"
        sha256 "12a6ed46d146846a510aeb94cee566c340feeaeefbfa949f0d154abc7c476ac8"

        def install
          bin.install "omm"
        end
      end
    end
  end
end
