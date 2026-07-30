## Digitizing an old binary preserved as Hexdump 

The original paper sheets of version 7.9 in DIN A4 were still existing and thus scanned with an Epson ET-3850 at 300 dpi using its automatic document feeder. The individual pages were stored in JPG format, transformed into monochrome TIFs with 300 dpi resolution by ImageMagick's command 'magick' (former 'convert') and subjected to OCR under Linux ( Fedora workstation ) using tesseract. All that is achieved after executing the shell script OCR.sh ...</br>
The result was quite satisfying, only small artefacts must be removed.

Add a semi-colon behind postion 4 of every line and remove all blanks.

```
    sed 's/./&;/4;' NIBLFP.ocr > NIBLFP.ocr.hex
    sed -i 's/\s//g ' NIBLFP.ocr.hex

```

Address range from `$`D200 to `$`D3FF contains only `$`FF bytes, which could be easily added. Into the second missing address range from `$`D500 to `$`D69F look into file 'NIBLFP.fill.hex' and choose the appropiate output-/input routines.

Now convert this file into a binary file.
```
    ./1_convert_hex2bin.py NIBLFP.ocr
```

The obtained binary file is now converted to an Intel Hex file, which can be used in the emulation.

```
    ./13_bin2Intel_HEX.py D000 D000 32
    mv -v D000.hex NIBLFP_v9_emu.hex
```

The other file 'NIBLFP_v8_emu.hex'' is the previous version, which was preserved by Ronald Dekker on his website .*)

*) see <https://www.dos4ever.com/SCMP/NIBLE.zip>

