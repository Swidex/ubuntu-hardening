function f_journalctl {
  echo "[$i] Systemd/journald.conf and logrotate.conf"

  cp "$LOGROTATE_CONF" "$LOGROTATE"

  sed -i 's/^#Storage=.*/Storage=persistent/' "$JOURNALDCONF"
  sed -i 's/^#ForwardToSyslog=.*/ForwardToSyslog=yes/' "$JOURNALDCONF"
  sed -i 's/^#Compress=.*/Compress=yes/' "$JOURNALDCONF"

  systemctl restart systemd-journald

  if [[ $VERBOSE == "Y" ]]; then
    systemctl status systemd-journald --no-pager
    echo
  fi

  ((i++))
}
