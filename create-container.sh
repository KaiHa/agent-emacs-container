#!/usr/bin/env nix-shell
#!nix-shell -i bash
#!nix-shell --packages nixos-install

set -eu -o pipefail

if machinectl show agent-emacs --property=State &> /dev/null
then
    echo "ERROR: Container agent-emacs still running.  Please power it off first!"
    exit 1
fi

tmpdir=$(mktemp -d /var/cache/agent-emacs-XXXXXX.tmp)
destdir=/var/lib/machines/agent-emacs

chmod 755 ${tmpdir}
mkdir -p ${tmpdir}/{boot,etc/nixos}
cp configuration.nix ${tmpdir}/etc/nixos/
nixos-install --no-root-password --root ${tmpdir}
chattr -i ${destdir}/var/empty/ || true
rm --one-file-system -r ${destdir} || true
chattr -i ${tmpdir}/var/empty/
mv --no-target-directory ${tmpdir} ${destdir}

mkdir -p /etc/systemd/nspawn/
cat > /etc/systemd/nspawn/agent-emacs.nspawn <<-EOF
	[Exec]
	  PrivateUsers=identity
	[Files]
	  Bind=$(readlink -f ./target-home/):/home/kai/
	  Bind=/tmp/.X11-unix
	  BindReadOnly=/run/user/$(id -u kai)/wayland-1:/tmp/wayland-1
	[Network]
	  Private=off
EOF

cat > ./target-home/.profile  <<-EOF
	export DISPLAY=${DISPLAY}
	export WAYLAND_DISPLAY=/tmp/wayland-1
EOF

setfacl -Rm m::rwx ./target-home/
setfacl -Rm u:1000:rwx ./target-home/
