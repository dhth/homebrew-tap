# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Act3 < Formula
  desc "Glance at the last 3 runs of your Github Actions"
  homepage "https://github.com/dhth/act3"
  version "2.0.0-rc.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dhth/act3/releases/download/v2.0.0-rc.1/act3_2.0.0-rc.1_darwin_amd64.tar.gz"
      sha256 "f3923246d5220f292f114e0791c5188465489fa70b22a2a136b1abfdbbc3e304"

      def install
        bin.install "act3"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/dhth/act3/releases/download/v2.0.0-rc.1/act3_2.0.0-rc.1_darwin_arm64.tar.gz"
      sha256 "7847ca167e3cac73d16c4c3d7616fce7e9852a8da1a2b2e344f329a7b14357c0"

      def install
        bin.install "act3"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? and Hardware::CPU.is_64_bit?
      url "https://github.com/dhth/act3/releases/download/v2.0.0-rc.1/act3_2.0.0-rc.1_linux_amd64.tar.gz"
      sha256 "f80eef0f169fc36a23890b7b85ca491d38ca7c5216659df5e39f4ab8f3ae5106"
      def install
        bin.install "act3"
      end
    end
    if Hardware::CPU.arm? and Hardware::CPU.is_64_bit?
      url "https://github.com/dhth/act3/releases/download/v2.0.0-rc.1/act3_2.0.0-rc.1_linux_arm64.tar.gz"
      sha256 "c94523af9c333abee7b6c08d0ff99449f08f28f4c6be7d96f4638e223e73f304"
      def install
        bin.install "act3"
      end
    end
  end
end
