-include ~/.dotfiles/.makefile.gitbase.inc

# ---------------------------------------------------------------------
KS_KDRIVER = iol_kd.run
KS_SUITE   = iol_sui.run

install_ksv:
	set -e; if [ ! -f /opt/keysight/iolibs/uninstall/iokerneldrivers-uninstall ] ; then \
		make zcat_ksv; \
		sudo chmod +x $(KS_KDRIVER); \
		sudo ./$(KS_KDRIVER) --mode unattended; \
		sudo chmod +x $(KS_SUITE); \
		sudo ./$(KS_SUITE) --mode unattended; \
	fi

uninstall_ksv:
	set -e; if [ -f /opt/keysight/iolibs/uninstall/iokerneldrivers-uninstall ] ; then \
		sudo /opt/keysight/iolibs/uninstall/iokerneldrivers-uninstall --mode unattended; \
		sudo /opt/keysight/iolibs/uninstall/iolibrariessuite-uninstall --mode unattended; \
	fi

split_ksv:
	split -b 20M $(KS_KDRIVER) iol_kd.part_
	split -b 20M $(KS_SUITE)   iol_sui.part_

	gzip iol_kd.part_*
	gzip iol_sui.part_*

zcat_ksv:
	zcat iol_kd.part_*  > $(KS_KDRIVER)
	zcat iol_sui.part_* > $(KS_SUITE)

