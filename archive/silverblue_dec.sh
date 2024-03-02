installTailscale=true
installEdgeRPM=false
installLibrewolfRPM=false
addFlathubUserBeta=true
addFlathubUser=true

rpmOverrideRemove=( \
	firefox firefox-langpacks 	\
	gnome-tour			        \
	gnome-terminal-nautilus		\
)

rpmOverlays=( \
#	fish		    	\
  waydroid	    	\
  distrobox	    	\
  gnome-tweaks		\
  adw-gtk3-theme		\
  nautilus-python		\
#	zoxide			    \
#	alacritty		    \
#	firewall-config		\
  libratbagd-ratbag   \
  akmod-nvidia 		\

# GNOME clipboard extension Pano
  libgda-sqlite		\

# Yubikey PAM auth
  pam-u2f		    	\
	
# GSConnect
  openssl            	\
  
  cockpit \
  cockpit-machines \
  cockpit-selinux \
  cockpit-podman \
  cockpit-kdump \
  
  libvirt \
  tailscale \

# Laptop fingerprint
)

# https://lp.digilent.com/complete-adept-runtime-download
# https://lp.digilent.com/complete-waveforms-download

rpmLocalOverlays=( \
    https://mullvad.net/media/app/MullvadVPN-2023.4_x86_64.rpm \
# Lunar dates (RPM Sphere)
    https://raw.githubusercontent.com/rpmsphere/x86_64/master/l/lunar-date-devel-2.4.0-7.1.x86_64.rpm \
    https://raw.githubusercontent.com/rpmsphere/x86_64/master/l/lunar-date-2.4.0-7.1.x86_64.rpm \
)

rm -f /etc/yum.repos.d/tailscale.repo
if [ "$installTailescale" = true ] ; then
	curl https://pkgs.tailscale.com/stable/fedora/tailscale.repo -o /etc/yum.repos.d/tailscale.repo
	rpmOverlays+=(tailscale)
fi

rm -f /etc/yum.repos.d/edge.repo
if [ "$installEdgeRPM" = true ] ; then
	# rpm --import https://packages.microsoft.com/keys/microsoft.asc
	curl https://packages.microsoft.com/yumrepos/edge/config.repo -o /etc/yum.repos.d/edge.repo
	rpmOverlays+=(microsoft-edge-stable)
fi

rm -f /etc/yum.repos.d/librewolf.repo
if [ "$installLibrewolfRPM" = true ] ; then
	curl https://rpm.librewolf.net/librewolf-repo.repo -o /etc/yum.repos.d/librewolf.repo
	rpmOverlays+=(librewolf)
fi

if [ "$installHyprlandRPM" = true ] ; then
	curl https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/repo/fedora-38/solopasha-hyprland-fedora-38.repo -o /etc/yum.repos.d/solopasha_hyprland.repo
	rpmOverlays+=(hyprland xdg-desktop-portal-hyprland fuzzel)
fi

flatpakUninstall=( \
# Fedora repository shit
  org.gnome.NautilusPreviewer \
  org.gnome.Evince \
  org.gnome.Connections \
  org.gnome.Logs \
)

flatpakInstall=( \
  com.github.tchx84.Flatseal \
  com.raggesilver.BlackBox \
  dev.deedles.Trayscale	\
  io.gitlab.librewolf-community	\
  org.gnome.Connections \
  me.kozec.syncthingtk \
  org.mozilla.Thunderbird \
  org.gnome.Evince \
  org.gnome.NautilusPreviewer \
  ca.desrt.dconf-editor \
  com.github.GradienceTeam.Gradience \
  com.github.flxzt.rnote \
  com.github.marhkb.Pods \
  com.jgraph.drawio.desktop \
  com.mattjakeman.ExtensionManager \
  com.microsoft.Edge \
  com.raggesilver.BlackBox \
  com.usebottles.bottles \
  io.github.celluloid_player.Celluloid \
  io.github.fabrialberio.pinapp \
  io.gitlab.librewolf-community \
  org.gaphor.Gaphor \
)

flatpak remote-delete --force fedora
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak uninstall ${flatpakUninstall[*]} 
flatpak install --user ${flatpakInstall[*]}
rpm-ostree override remove ${rpmOverrideRemove[*]}
rpm-ostree install ${rpmOverlays[*]} ${rpmLocalOverlays[*]}

# ibus rime
# https://github.com/hchunhui/ibus-rime.AppImage
mkdir $HOME/Applications
curl https://github.com/hchunhui/ibus-rime.AppImage/releases/download/continuous/ibus-rime-x86_64.AppImage \
    -o $HOME/Applications/ibus-rime-x86_64.AppImage
chmod +x /home/$HOME/Applications/ibus-rime.AppImage
$HOME/Applications/ibus-rime-x86_64.AppImage

# rustup
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Nix
curl -L -O https://install.determinate.systems/nix/rev/55cbf41a007aa0f230bb3744c34867b460be4a0a/nix-installer-x86_64-linux
chmod +x nix-installer-x86_64-linux
./nix-installer-x86_64-linux install ostree
#nix
# fish
# /etc/shells
# chcon -t container_file_t -R <dir>

#=======================================================================================================

# distrobox GNOME desktop
# dnf install gnome-shell gnome-software gnome-terminal nautilus gnome-tweaks
# dnf install librime ibus-rime alacrittty fish f38-backgrounds-gnome 
# dnf install libgda libgda-sqlite
# dnf install akmod-nvidia

# distrobox Gaming Fedora Rawhide
#sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
#sudo dnf install steam lutris xxd xdotool xz unzip xwininfo yad fusefish wine akmod-nvidia
#chsh -s /usr/bin/fish

#set -U XDG_DATA_HOME "$HOME/.local/share"
#set -U XDG_CONFIG_HOME "$HOME/.config"
#set -U XDG_STATE_HOME "$HOME/.local/state"
#set -U XDG_CACHE_HOME "$HOME/.cache"
