# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Act3 < Formula
  desc "Glance at the last 3 runs of your Github Actions"
  homepage "https://github.com/dhth/act3"
  version "1.1.3"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/dhth/act3/releases/download/v1.1.3/act3_1.1.3_darwin_amd64.tar.gz"
      sha256 "bd63ed19559ff539e71926948fe9a64c96ee4658624b135615ed11f0839ea4a8"

      def install
        bin.install "act3"
      end
    end
    on_arm do
      url "https://github.com/dhth/act3/releases/download/v1.1.3/act3_1.1.3_darwin_arm64.tar.gz"
      sha256 "827127bb11814227ac3ddcbd68c41ea2bcc47d5955f42d5bbe125f9a47dcf962"

      def install
        bin.install "act3"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/act3/releases/download/v1.1.3/act3_1.1.3_linux_amd64.tar.gz"
        sha256 "90472ec940bd3013ae7c4e6990aed8ee27ede949bbd93a9e1d8f8ddc0a2a0561"

        def install
          bin.install "act3"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/dhth/act3/releases/download/v1.1.3/act3_1.1.3_linux_arm64.tar.gz"
        sha256 "cb05596e8a69ce1d2aec57d87c4eceafb1b12c45f06df6ead9f6cb533a0c5897"

        def install
          bin.install "act3"
        end
      end
    end
  end
end
