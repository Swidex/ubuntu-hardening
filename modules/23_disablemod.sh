function f_disablemod {
  echo "[$i] Disable misc kernel modules"

  MOD="bluetooth bnep btusb firewire-core n_hdlc net-pf-31 soundcore thunderbolt usb-midi usb-storage"
  for disable in $MOD; do
    if ! grep -q "$disable" "$DISABLEMOD" 2> /dev/null; then
      echo "install $disable /bin/true" >> "$DISABLEMOD"
    fi
  done

  ((i++))
}
