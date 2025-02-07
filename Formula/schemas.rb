# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Schemas < Formula
  desc "Inspect postgres schemas via a TUI"
  homepage "https://github.com/dhth/schemas"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dhth/schemas/releases/download/v0.3.1/schemas_0.3.1_darwin_amd64.tar.gz"
      sha256 "45005c731a46aa20a5e809c328d0d6c6a086cb7877e51e8f36d76b8120a947e3"

      def install
        bin.install "schemas"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/dhth/schemas/releases/download/v0.3.1/schemas_0.3.1_darwin_arm64.tar.gz"
      sha256 "bd0441838ba9cda5aab23fab67f56a4b39323c62563f90380a25c0b064fd5146"

      def install
        bin.install "schemas"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/schemas/releases/download/v0.3.1/schemas_0.3.1_linux_amd64.tar.gz"
        sha256 "b1cc90335c3d62e4d40d2577b81a4bffaec914452815ab55e59ee2f0ea08a66f"

        def install
          bin.install "schemas"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/schemas/releases/download/v0.3.1/schemas_0.3.1_linux_arm64.tar.gz"
        sha256 "dfd5be1c672a28636959b2803ee6456d94937b791cd550f426e4507b377e2843"

        def install
          bin.install "schemas"
        end
      end
    end
  end
end
