class Ecscope < Formula
  desc "ecscope lets you monitor AWS ECS resources from the terminal"
  homepage "https://tools.dhruvs.space/ecscope/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/ecscope/releases/download/v0.1.0/ecscope-aarch64-apple-darwin.tar.xz"
      sha256 "39ed857dca54f3b7898ab8cc210060102381f76989078d24dfce0074a9e1c6b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ecscope/releases/download/v0.1.0/ecscope-x86_64-apple-darwin.tar.xz"
      sha256 "d994b72fd962205ea955cb2a1c777b85013164381d964ad9b341cb0a490f83e2"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/ecscope/releases/download/v0.1.0/ecscope-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c351424651dd9a51259500fed1f3335bfcb0332cfe0a8536bcabc6267975bd00"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "ecscope" if OS.mac? && Hardware::CPU.arm?
    bin.install "ecscope" if OS.mac? && Hardware::CPU.intel?
    bin.install "ecscope" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
