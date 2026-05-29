class Mrj < Formula
  desc "mrj merges your open dependency upgrade PRs"
  homepage "https://tools.dhruvs.space/mrj"
  version "0.5.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dhth/mrj/releases/download/v0.5.0/mrj-aarch64-apple-darwin.tar.xz"
    sha256 "7f522bf1e277ae6868aef60299d7d6e65f99fc03850c5bd332b80f845b80533f"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/mrj/releases/download/v0.5.0/mrj-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1ec2bc54c54079e221a0342390060d3bd6d1ca6216815192ee35f7c06fb60089"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/mrj/releases/download/v0.5.0/mrj-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0d0678102faf3757c7d8eee5dba1b74cc8716b6800f99d67329c92dc57d7caa9"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "mrj" if OS.mac? && Hardware::CPU.arm?
    bin.install "mrj" if OS.linux? && Hardware::CPU.arm?
    bin.install "mrj" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
