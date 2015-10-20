#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set repeat.wait 25
/bin/echo -n .
$cli set repeat.initial_wait 100
/bin/echo -n .
$cli set remap.fkeys_to_consumer_f1 1
/bin/echo -n .
$cli set remap.fkeys_to_consumer_f5 1
/bin/echo -n .
/bin/echo
