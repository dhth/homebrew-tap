class Tomo < Formula
  desc "tomo is a no-frills pomodoro progress indicator for tmux"
  homepage "https://github.com/dhth/tomo"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tomo/releases/download/v0.1.1/tomo-aarch64-apple-darwin.tar.xz"
      sha256 "ec129ddaae0d8d059f59a8f67da22bbf011742206af6938a512180c64ce27d59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tomo/releases/download/v0.1.1/tomo-x86_64-apple-darwin.tar.xz"
      sha256 "eb3c8cf196efaf98c2130be8d66cd6db093f8bc3b342cabde12c5e954bf2a37d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tomo/releases/download/v0.1.1/tomo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cccabd659658916cf79c724d7d31586b789e4f62ae23b9042cd1b5e7b9f575af"
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
