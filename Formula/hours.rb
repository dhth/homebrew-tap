# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Hours < Formula
  desc "A no-frills time tracking toolkit for the command line"
  homepage "https://github.com/dhth/hours"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/dhth/hours/releases/download/v0.1.0/hours_0.1.0_darwin_amd64.tar.gz"
      sha256 "5a66516175673e1a8525f1b57b86826aa227aafdd39b0702ea52b8a5e63960e2"

      def install
        bin.install "hours"
      end
    end
    on_arm do
      url "https://github.com/dhth/hours/releases/download/v0.1.0/hours_0.1.0_darwin_arm64.tar.gz"
      sha256 "f918a8124a34b704a315bc9017e739e9ec8cc71665210d5bc80f62b3204339f3"

      def install
        bin.install "hours"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/hours/releases/download/v0.1.0/hours_0.1.0_linux_amd64.tar.gz"
        sha256 "0f140154193f474dacdb6b16c2b412cdcc51daa1f84d788c16c4cdb7206d9773"

        def install
          bin.install "hours"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/hours/releases/download/v0.1.0/hours_0.1.0_linux_arm64.tar.gz"
        sha256 "d54cda8d1f74016d0795bb178c80d11963c9fde5c064c6df315b8f66308a1300"

        def install
          bin.install "hours"
        end
      end
    end
  end
end
