class Mrj < Formula
  desc "mrj merges your open dependency upgrade PRs"
  homepage "https://tools.dhruvs.space/mrj"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/mrj/releases/download/v0.4.0/mrj-aarch64-apple-darwin.tar.xz"
      sha256 "2b187babb439ce135ffd11ce8e0dd182ad70530288c7d56a1bb500df8ee58564"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/mrj/releases/download/v0.4.0/mrj-x86_64-apple-darwin.tar.xz"
      sha256 "4d02a512a7b195556e17267168dc020b7193489496e07930f0fa22d7dc8c8998"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/mrj/releases/download/v0.4.0/mrj-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a12a3444d93a6b21e07f6fc9f6ca863e77a0210d88bb28d29d16da449c39a801"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/mrj/releases/download/v0.4.0/mrj-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f7d5b098332bf025055020f4aa3233596a932e8b89406e5c682bb46f0d065f8e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
    bin.install "mrj" if OS.mac? && Hardware::CPU.intel?
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
