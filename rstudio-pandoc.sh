#!/bin/bash

# When using render, errors break the knitting process. However,
# knitting alone works fine. Thus using knit and then running pandoc
# to create docx.

MD=$1

/usr/lib/rstudio/bin/pandoc/pandoc $MD --to docx --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash-implicit_figures --output ${MD%.md}.docx --highlight-style tango
