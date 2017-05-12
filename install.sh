#!/bin/bash

# Install paths for current user
SNIPPETS=snippets/
TOOLS=tools/
MARC_LANG=marc.lang
GSETTING_SCRIPT=./gsettings_gedit.sh
LOCAL_SNIPPETS=~/.config/gedit/snippets
LOCAL_TOOLS=~/.config/gedit/tools
LOCAL_GTKSOURCEVIEW=~/.local/share/gtksourceview-3.0/language-specs

if [ -d "$LOCAL_SNIPPETS" ]; then
    cp -rv $SNIPPETS* $LOCAL_SNIPPETS
else
    mkdir -p $LOCAL_SNIPPETS
    cp -rv $SNIPPETS* $LOCAL_SNIPPETS
fi

if [ -d "$LOCAL_TOOLS" ]; then
    cp -rv $TOOLS* $LOCAL_TOOLS
else
    mkdir -p $LOCAL_TOOLS
    cp -rv $TOOLS* $LOCAL_TOOLS
fi

if [ -d "$LOCAL_GTKSOURCEVIEW" ]; then
    cp -rv $MARC_LANG $LOCAL_GTKSOURCEVIEW
else
    mkdir -p $LOCAL_GTKSOURCEVIEW
    cp -rv $MARC_LANG $LOCAL_GTKSOURCEVIEW
fi

# Execute gsetting script
echo "Configuring Gedit..."
($GSETTING_SCRIPT)

echo "Installation completed."

