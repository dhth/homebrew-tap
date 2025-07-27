class Dfft < Formula
  desc "monitor changes as AI agents modify your codebase"
  homepage "https://tools.dhruvs.space/dfft/"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/dfft/releases/download/v0.1.1/dfft-aarch64-apple-darwin.tar.xz"
      sha256 "151dd8e19fcb3900a4e215fd80e7d3e31c0fa2d61c8d0a092938432efb124041"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/dfft/releases/download/v0.1.1/dfft-x86_64-apple-darwin.tar.xz"
      sha256 "5823932363ef8a96ca8be984faefd0126461d30fda96ee2afc4ad293e4b53108"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/dfft/releases/download/v0.1.1/dfft-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "87c278b234d2d0a3db6e6d122d2a1f1b36197073d80ab55e460458dd114823f6"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "dfft" if OS.mac? && Hardware::CPU.arm?
    bin.install "dfft" if OS.mac? && Hardware::CPU.intel?
    bin.install "dfft" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
