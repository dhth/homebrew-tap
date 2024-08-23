class CargoDistTest < Formula
  desc "just a test repo"
  homepage "https://github.com/dhth/cargo-dist-test"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.5/cargo-dist-test-aarch64-apple-darwin.tar.xz"
      sha256 "25e55e3914c6eaa95c8505934bd1d95a083694469db7e6fd650cfa3c792b6fe3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.5/cargo-dist-test-x86_64-apple-darwin.tar.xz"
      sha256 "83f0cb16836e2ca73cf7849cc443ae503e83daee552bd202d287eccacdb88e16"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.5/cargo-dist-test-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4f7bd831b1fb99f58f76bbd2c9b5436ab476f0e91041ae03da28853a342344ce"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cargo-dist-test"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cargo-dist-test"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cargo-dist-test"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
