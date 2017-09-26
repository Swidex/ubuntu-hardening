
function f_disablemnt {
  echo "[$i] Disable misc file systems"

  FS="cramfs freevxfs jffs2 hfs hfsplus squashfs udf vfat"
  for disable in $FS; do
    if ! grep -q "$disable" "$DISABLEMNT" 2> /dev/null; then
      echo "install $disable /bin/true" >> "$DISABLEMNT"
    fi
  done

  ((i++))
}
