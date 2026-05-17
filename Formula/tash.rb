class Tash < Formula
  desc "stash content that you can access later"
  homepage "https://tools.dhruvs.space/tash/"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tash/releases/download/v0.1.1/tash-aarch64-apple-darwin.tar.xz"
      sha256 "c88237235b67532bf3429530dcfacc53681e26299da2b269ca154c5726a43f95"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tash/releases/download/v0.1.1/tash-x86_64-apple-darwin.tar.xz"
      sha256 "db4e970323158c4890815652f86fb1e959b892e1b9a44e97cbbe54809ecfa139"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tash/releases/download/v0.1.1/tash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9be9ff7c22dd7c50773d33b96d38a9fb7e655afdb285f261901b8e61180a0e16"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tash/releases/download/v0.1.1/tash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8ddefa5c4e0b481c1f17e5a9c29d6cac7eaaaf75db8f6701529488dab771c928"
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
    bin.install "tash" if OS.mac? && Hardware::CPU.arm?
    bin.install "tash" if OS.mac? && Hardware::CPU.intel?
    bin.install "tash" if OS.linux? && Hardware::CPU.arm?
    bin.install "tash" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
