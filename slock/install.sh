#!/bin/sh

rm config.h
cp config.def.h config.h
make
mv slock ~/.config/bin/
