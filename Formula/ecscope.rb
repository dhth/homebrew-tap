class Ecscope < Formula
  desc "ecscope lets you monitor AWS ECS resources from the terminal"
  homepage "https://tools.dhruvs.space/ecscope/"
  version "0.4.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dhth/ecscope/releases/download/v0.4.1/ecscope-aarch64-apple-darwin.tar.xz"
    sha256 "0fa5183e16e4d096502d8aa55188f2a154d2513582c7a3592164daa6a61d43c4"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/ecscope/releases/download/v0.4.1/ecscope-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c50f2b532659d5f8f1f5c125bc17f6912fec8c35eeef6daf31fc17009cacf1c6"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
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
