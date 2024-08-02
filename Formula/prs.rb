# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Prs < Formula
  desc "Stay updated on PRs from your terminal"
  homepage "https://github.com/dhth/prs"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/dhth/prs/releases/download/v1.0.0/prs_1.0.0_darwin_amd64.tar.gz"
      sha256 "ffa5e516dba8819ec5323afe3a21bdafe3f90df328019c4c38ead3878e07e0a4"

      def install
        bin.install "prs"
      end
    end
    on_arm do
      url "https://github.com/dhth/prs/releases/download/v1.0.0/prs_1.0.0_darwin_arm64.tar.gz"
      sha256 "252eb9c7cc77b17bbd73b541a0a7350275bc9add91b619e978c23a12acf39e0b"

      def install
        bin.install "prs"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/prs/releases/download/v1.0.0/prs_1.0.0_linux_amd64.tar.gz"
        sha256 "2f628d124d8ccf233d677b5cca42b45227486deac13c8fe483d9f87a322bb19e"

        def install
          bin.install "prs"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/prs/releases/download/v1.0.0/prs_1.0.0_linux_arm64.tar.gz"
        sha256 "32cedc8d91017ffc654d5d9b485f7ffde0634be72965528b7f1c11c0dabb01f4"

        def install
          bin.install "prs"
        end
      end
    end
  end
end
