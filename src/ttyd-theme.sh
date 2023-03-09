#!/usr/bin/env bash

read -r -d '' raw_theme << Here
'theme = {
"background":    "#282a36",
"foreground":    "#f8f8f2",
"cursor":        "#f1f1f0",
"black":         "#000000",
"red":           "#d81e00",
"green":         "#5ea702",
"yellow":        "#cfae00",
"blue":          "#427ab3",
"magenta":       "#89658e",
"cyan":          "#00a7aa",
"white":         "#dbded8",
"brightBlack":   "#686a66",
"brightRed":     "#f54235",
"brightGreen":   "#99e343",
"brightYellow":  "#fdeb61",
"brightBlue":    "#84b0d8",
"brightMagenta": "#bc94b7",
"brightCyan":    "#37e6e8",
"brightWhite":   "#f1f1f0"
}'
Here

raw_theme="${raw_theme//$'\n'/}"          # Remove line breaks
cooked_theme="${raw_theme// /}"           # Remove spaces
cooked_escaped="${cooked_theme//\"/\\\"}" # Escape double quotes

markdown_codeblock='``'

cat <<Here
**Dracula-theme for ttyd**

For dropping the theme into __ttyd.service__, create __/etc/default/ttyd-theme__ containing:

    TTYD_THEME=-t ${cooked_escaped}

And an __override.conf__ (__systemctl edit ttyd.service__):

    # /etc/systemd/system/ttyd.service.d/override.conf
    [Service]
    EnvironmentFile=/etc/default/ttyd-theme
    ExecStart=
    ExecStart=/usr/sbin/ttyd \$TTYD_THEME \$TTYD_OPTIONS

For all other invocations, build on this __-t__ option:

    -t ${cooked_theme}
Here
