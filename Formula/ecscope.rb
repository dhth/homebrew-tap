class Ecscope < Formula
  desc "ecscope lets you monitor AWS ECS resources from the terminal"
  homepage "https://tools.dhruvs.space/ecscope/"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/ecscope/releases/download/v0.4.0/ecscope-aarch64-apple-darwin.tar.xz"
      sha256 "5178b55e6c407d19b874104bdc321a295c674fcbd7b015c6d362b3a34c8ba18a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ecscope/releases/download/v0.4.0/ecscope-x86_64-apple-darwin.tar.xz"
      sha256 "edacc24953d50bde2709e4489cdb0d357da70e5945f763b84dfb92b882c5a03d"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/ecscope/releases/download/v0.4.0/ecscope-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "91ab43691a8d0d2a0e4dce201c06a92d15d78ff53edc277c636c19f2954211c9"
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
