class Tomo < Formula
  desc "tomo is a no-frills pomodoro progress indicator for tmux"
  homepage "https://github.com/dhth/tomo"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tomo/releases/download/v0.1.0/tomo-aarch64-apple-darwin.tar.xz"
      sha256 "11679baa8f01192db2b7a448d50893de65b506198cd42e1414b126d38ca15ff4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tomo/releases/download/v0.1.0/tomo-x86_64-apple-darwin.tar.xz"
      sha256 "d8916326641958d36ec493348fe15371dc90d3488bb82430cfd83748916239af"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tomo/releases/download/v0.1.0/tomo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "19a31a929dc0f977c643e4976d49873b982f650e4c0908da61d6b5836b1d62ca"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
      bin.install "tomo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tomo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tomo"
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
