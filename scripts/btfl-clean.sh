#!/usr/bin/sh

sed \
  -e 's/^mcu_id .*/mcu_id REDACTED/' \
  -e 's/^signature .*/signature REDACTED/'
  # -e 's/^\(set pilot_name = \).*/\1REDACTED/' \
  # -e 's/^\(set craft_name = \).*/\1REDACTED/'
