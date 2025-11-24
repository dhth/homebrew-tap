class Unreleased < Formula
  desc "view the commits to your GitHub repos since their last release"
  homepage "https://tools.dhruvs.space/unreleased"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/unreleased/releases/download/v0.1.0/unreleased-aarch64-apple-darwin.tar.xz"
      sha256 "511286906d2c3fcbb54835b3ec0c4b1d6f4ea63b309bfe3612e1443c03679734"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/unreleased/releases/download/v0.1.0/unreleased-x86_64-apple-darwin.tar.xz"
      sha256 "da4df2d1fb6eca66cf444c0c73303236b9570a6a4490dc4c8e7ca1b673c956cb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/unreleased/releases/download/v0.1.0/unreleased-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "30ad43b9dc0913dd3406cdce5e2f01cb9a8cff1d0240df7262958027d6cdca9b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/unreleased/releases/download/v0.1.0/unreleased-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "47736d1bfdd73f4893f3954025809f7a0bc34e47671ed1dfbc61c840bcc3bd18"
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
    bin.install "unreleased" if OS.mac? && Hardware::CPU.arm?
    bin.install "unreleased" if OS.mac? && Hardware::CPU.intel?
    bin.install "unreleased" if OS.linux? && Hardware::CPU.arm?
    bin.install "unreleased" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
