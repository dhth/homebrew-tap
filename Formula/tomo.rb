class Tomo < Formula
  desc "tomo is a no-frills pomodoro progress indicator for tmux"
  homepage "https://github.com/dhth/tomo"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tomo/releases/download/v0.2.0/tomo-aarch64-apple-darwin.tar.xz"
      sha256 "c4316bb87326c5f865e0f7561d121ffe63b61e1a53b976cbfe0a82ecdbdba246"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tomo/releases/download/v0.2.0/tomo-x86_64-apple-darwin.tar.xz"
      sha256 "0473c7b005c6349decc9781f3f246f6ee314f9caeeb75b0eee9a5ef922eb0617"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tomo/releases/download/v0.2.0/tomo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7e8323148eca0591fc06580ff6d4b10550998bb17154fd62ee54e3032f7fb927"
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
