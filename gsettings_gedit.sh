#!/bin/bash
#Config gedit
gsettings set org.gnome.gedit.plugins active-plugins "['spell', 'docinfo', 'drawspaces', 'snippets', 'time', 'externaltools', 'modelines', 'filebrowser']"
gsettings set org.gnome.gedit.plugins.drawspaces show-white-space true
gsettings set org.gnome.gedit.plugins.drawspaces draw-spaces "['space', 'tab', 'leading', 'text', 'trailing']"
gsettings set org.gnome.gedit.plugins.time selected-format '%c'
gsettings set org.gnome.gedit.plugins.time prompt-type 'prompt-custom-format'
gsettings set org.gnome.gedit.plugins.time custom-format '%Y%m%d%H%M%S.0'
gsettings set org.gnome.gedit.preferences.editor bracket-matching true
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
gsettings set org.gnome.gedit.preferences.editor display-right-margin false
gsettings set org.gnome.gedit.preferences.editor ensure-trailing-newline true
gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
gsettings set org.gnome.gedit.preferences.editor syntax-highlighting true
gsettings set org.gnome.gedit.preferences.ui side-panel-visible false
gsettings set org.gnome.gedit.preferences.encodings auto-detected "['UTF-8', 'CURRENT', 'ISO-8859-15', 'UTF-16']"
