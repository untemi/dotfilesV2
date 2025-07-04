#!/usr/bin/env bash
sudo pacman --needed -S git
git clone --bare https://github.com/andro404-MC/dotfilesV2 $HOME/.local/share/dotfiles
function config {
   git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME $@
}

mkdir -p .dotfiles-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles from https://github.com/andro404-MC/dotfilesV2";
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi

# checkout dotfiles from repo
config checkout
config config status.showUntrackedFiles no

# PARU

echo "Adding rumpowered"
echo '
[rumpowered]
Server = https://jc141x.github.io/rumpowered-packages/$arch ' | sudo tee -a /etc/pacman.conf
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman-key --recv-keys cc7a2968b28a04b3
sudo pacman-key --lsign-key cc7a2968b28a04b3
sudo pacman -Syyu

echo "Installing PARU"
sudo pacman -S paru

# RUST
paru -S rustup
rustup install stable
rustup default stable

# PACKAGES
echo "Installing Software"
paru --needed -S albert autotiling base base-devel bemenu btop cfonts cliphist dunst engrampa eza fastfetch vivaldi foot fzf git go gtklock htop hyprlock imv intel-gpu-tools intel-media-driver keepassxc kvantum kvantum-qt5 less libva-intel-driver libva-utils mpc mpd mpv ncmpcpp nemo neovim vim network-manager-applet networkmanager nm-connection-editor nodejs noto-fonts noto-fonts-cjk npm nsxiv nwg-look p7zip polkit-gnome qbittorrent qt5ct qt6ct ripgrep rofi-calc rofi-wayland starship sway swaybg swayidle swayosd thunderbird ttf-font-awesome ttf-jetbrains-mono-nerd ttf-ubuntu-font-family udiskie unzip waybar wl-clip-persist wl-clipboard wlogout xdg-desktop-portal-wlr xdg-desktop-portal-gtk xdg-user-dirs xorg-xwayland yazi yt-dlp zathura zathura-cb zathura-ps zathura-djvu zathura-pdf-poppler zoxide zsh dash mdcat perl-image-exiftool pavucontrol ttf-apple-emoji xorg-xrdb tumbler ffmpegthumbnailer gamemode qt5-wayland flatpak nemo-engrampa wget fuse gtk-engine-murrine imagemagick sway-contrib  slurp man-db bat at fd dragon-drop hunspell-en_US noise-suppression-for-voice pacman-contrib alsa-utils xorg-xev papirus-icon-theme ttf-ms-win10-auto gst-plugins-{base,good,bad,ugly} gst-libav zsh-autosuggestions zsh-history-substring-search zsh-fast-syntax-highlighting	trashy hyprland hypridle hyprpaper luarocks wiki-tui rmpc mprocs-bin realtime-privileges doas espeak-ng caligula

echo "Adding user to realtime groupe"
sudo gpasswd -a $USER realtime

echo "Setting up Yazi..."
ya pack -i

echo "Setting up swayosd..."
sudo systemctl enable --now swayosd-libinput-backend.service
sudo usermod -a -G video $USER

echo "Setting up zsh history..."
mkdir .cache/zsh/
touch .cache/zsh/history

echo "Setting up mpd..."
mkdir .local/share/mpd
mkdir .local/share/mpd/playlists

echo "Setting dash as default system shell..."
sudo rm /usr/bin/sh
sudo ln /usr/bin/dash /usr/bin/sh

echo "Setting foot as xterm"
sudo ln /usr/bin/foot /usr/bin/xterm

echo "Font cache..."
fc-cache -fr

echo "user-dirs-update..."
xdg-user-dirs-update

echo "disabling middle click paste..."
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
