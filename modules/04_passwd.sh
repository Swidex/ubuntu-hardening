function f_update {
  echo "adding password requirements."
  sed -i 's/^password[\t].*.pam_cracklib.*/password\trequired\t\t\tpam_cracklib.so retry=3 maxrepeat=3 minlen=8 dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1 difok=8/' /etc/pam.d/common-password
  sed -i 's/try_first_pass sha512.*/try_first_pass sha512 remember=5/' /etc/pam.d/common-password
  if ! grep tally "$COMMONAUTH"; then
    sed -i '/^$/a auth required pam_tally.so file=/var/log/faillog onerr=fail deny=3 unlock_time=900' "$COMMONAUTH"
    sed -i '/pam_tally.so/d' "$COMMONACCOUNT"
    echo 'account required pam_tally.so reset' >> "$COMMONACCOUNT"
  fi
  sed -i 's/pam_lastlog.so.*/pam_lastlog.so showfailed/' "$PAMLOGIN"
  sed -i 's/delay=.*/delay=4000000/' "$PAMLOGIN"

  echo "disabling root account"
  sudo passwd -l root
}
