# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Hours < Formula
  desc "A no-frills time tracking toolkit for the command line"
  homepage "https://github.com/dhth/hours"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/dhth/hours/releases/download/v0.3.0/hours_0.3.0_darwin_amd64.tar.gz"
      sha256 "a98bdd978f6ad3c148a3c7c9e28622860964551a79f1bb818e32b99313ef27a4"

      def install
        bin.install "hours"
      end
    end
    on_arm do
      url "https://github.com/dhth/hours/releases/download/v0.3.0/hours_0.3.0_darwin_arm64.tar.gz"
      sha256 "ddd1bfe5bd6bdb593f5b5c741d508334dc4faba6040599be02875402c2f0e440"

      def install
        bin.install "hours"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/hours/releases/download/v0.3.0/hours_0.3.0_linux_amd64.tar.gz"
        sha256 "780542736bd4a9af26ec88b4f5dab1a535d5dcfadc37214c5c55be19a02e881b"

        def install
          bin.install "hours"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/hours/releases/download/v0.3.0/hours_0.3.0_linux_arm64.tar.gz"
        sha256 "83e42c4799a78a8e6fd967da9c30da1788488051f20fa386d21fcc820cc94031"

        def install
          bin.install "hours"
        end
      end
    end
  end
end
