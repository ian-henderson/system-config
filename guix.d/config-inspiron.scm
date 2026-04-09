;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.

;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
	     (gnu packages admin)            ; btop
             (gnu packages curl)
             (gnu packages freedesktop)      ; power-profiles-daemon
             (gnu packages glib)
             (gnu packages gnome)
             (gnu packages gnome-xyz)        ; gnome extensions
	     (gnu packages ncurses)          ; clear (term function)
             (gnu packages ssh)              ; openssh
             (gnu packages version-control)  ; git
             (gnu packages vim)
	     (gnu packages xdisorg)          ; wl-clipboard
	     (gnu services base)
	     (gnu services pm)
	     (gnu services sound)            ; pulseaudio-service-type
             (guix)
             (nongnu packages editors)
             (nongnu packages linux)
             (nongnu system linux-initrd))

(use-service-modules cups desktop networking ssh xorg)

(define %boot-device (uuid "A29E-78E4" 'fat32))
(define %encrypted-device (uuid "f09b3806-ad87-4d56-9a52-dc43d1612edc"))
(define %root-device "/dev/mapper/cryptroot")

(define %my-packages
  (list adwaita-icon-theme
	bibata-cursor-theme
	btop
	curl
	fastfetch
	git
	glib
	gnome-shell-extension-just-perfection
	gnome-shell-extension-night-theme-switcher
	gnome-tweaks
	gsettings-desktop-schemas
	htop
	ncurses
	neovim
	openssh
	power-profiles-daemon
	vscodium
	wl-clipboard))

(operating-system
  (kernel linux)
  (initrd microcode-initrd)
  ;; dell only
  (firmware (cons* linux-firmware sof-firmware %base-firmware))

  (locale "en_US.utf8")
  (timezone "America/Denver")
  (keyboard-layout (keyboard-layout "us"))
  ;; maybe make this a variable too?
  (host-name "inspiron")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "ian")
                  (comment "Ian Henderson")
                  (group "users")
                  (home-directory "/home/ian")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
		%base-user-accounts))

  (packages (append %my-packages %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list  (service gnome-desktop-service-type)
		  (service power-profiles-daemon-service-type)
		  (service bluetooth-service-type
			   (bluetooth-configuration (auto-enable? #t)) )
		  (set-xorg-configuration
		   (xorg-configuration (keyboard-layout keyboard-layout)))
		  (simple-service 'add-extra-hosts
				  hosts-service-type
				  (list (host "10.0.0.2" "veles"))))
           (modify-services
	       %desktop-services
	     (guix-service-type
	      config =>
	      (guix-configuration
		(inherit config)
		(substitute-urls
		 (append (list "https://substitutes.nonguix.org"
			       "https://nonguix-proxy.ditigal.xyz"
			       "https://cache-cdn.guix.moe"
			       "https://guix.tobias.gr")
			 %default-substitute-urls))
		(authorized-keys
		 (append (list (local-file "/etc/guix/nonguix-key.pub"))
			 %default-authorized-guix-keys))))
	     (delete pulseaudio-service-type)
	     (delete alsa-service-type))))

  (bootloader (bootloader-configuration
		(bootloader grub-efi-bootloader)
		(targets (list "/boot/efi"))
		(keyboard-layout keyboard-layout)))

  (mapped-devices (list (mapped-device
                          (source %encrypted-device)
			  (target "cryptroot")
			  (type luks-device-mapping))))

  ;; dell only
  (initrd-modules (append '("vmd") %base-initrd-modules))


  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
			 (mount-point "/boot/efi")
			 (device %boot-device)
			 (type "vfat"))
                       (file-system
			 (mount-point "/")
			 (device %root-device)
			 (type "ext4")
			 (dependencies mapped-devices))
		       %base-file-systems)))
