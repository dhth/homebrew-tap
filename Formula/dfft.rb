class Dfft < Formula
  desc "monitor changes as AI agents modify your codebase"
  homepage "https://tools.dhruvs.space/dfft/"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/dfft/releases/download/v0.1.2/dfft-aarch64-apple-darwin.tar.xz"
      sha256 "0eb54785868e6a8631bccd6d7efd84c853dde678325ccded7ed0c1ac5475120e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/dfft/releases/download/v0.1.2/dfft-x86_64-apple-darwin.tar.xz"
      sha256 "f3cf1ef1514bf158feaea2176e74b2fea465004905173079d5566f76d3858065"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/dfft/releases/download/v0.1.2/dfft-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "a595f35ee0d5c9afe1a2d83f46d07a072bcbeceb49aceb4417d1da193911d674"
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
