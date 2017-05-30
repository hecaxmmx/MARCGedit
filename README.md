# MARCGedit
An optional MARC Maker Editor for Linux environment. MARC Gedit is powered by Gedit text editor.

## MARCGedit works with the following technology:
* Gedit - official text editor of the GNOME desktop environment
* The MARC::* - series of modules create a simple object-oriented abstraction of MARC record handling.
* MARC::File::MARCMaker - work with MARCMaker/MARCBreaker records
* Zenity - display graphical dialog boxes from shell scripts
* GtkSourceView - shared libraries for the GTK+ syntax highlighting widget

## You need to install the following modules (debian environment):

```
$ apt-get install libmarc-record-perl libmarc-file-marcmaker-perl zenity zenity-common gedit gedit-common gedit-plugins
```

#### Running the application locally

```
# Clone repository or download ZIP file
$ git clone https://github.com/hecaxmmx/MARCGedit.git
$ unzip /MARCGedit-master.zip
$ cd MARCGedit

# Install manually
$ cp snippets/. ~/.config/gedit/snippets
$ cp tools/. ~/.config/gedit/tools
$ cp marc.lang ~/.local/share/gtksourceview-3.0/language-specs
$ ./gsettings_gedit.sh

# Or use the install script for local user
$ bash install.sh
```

> Note: If snippets and tools directories does not exist please create manually.

#### Setting Gedit (only if gsetting does not work properly)
1. Open Gedit text editor normally
2. Enable External Tools, goto Preferences -> Plugins -> External Tools
3. Enable Snippets, goto Preferences -> Plugins -> Snippets
4. Enable draw spaces, goto Preferences -> Plugins -> Draw spaces
5. Enable line number, goto Preferences -> View -> Display line numbers
6. Enable highlight line, goto Preferences -> View -> Highlight current line
7. Choose View -> Highlight -> MARC (This is required)

## Using MARCGedit
1. Open Gedit
2. Choose View -> Highlight -> MARC
3. Insert a book record
  * Type the word "record" and press tab + space
  * A modal will show up with all options
  * Select book
  * Test with another type of record
4. Insert a fixed field
  * Type "fixed" and press tab + space
  * A modal will show up with all options
  * Select Bib>008 Book (fixed)
  * Press tab to go to next position
  * Change data for each position
5. Convert MARC Maker to MARC
  * Go to Tools -> External Tools -> MARC Maker

#### SNIPPETS
MARCGedit use the [Gedit snippets plugin](https://wiki.gnome.org/Apps/Gedit/Plugins/Snippets)
The file **marc.xml** needs to be copied to */usr/share/gedit/plugins/snippets* or *~/.config/gedit/snippets* directory.
Snippets allows you to introduce *MARC records or fixed fields* to the current text.

#### TAGS FILES (Deprecated)
Tags plugin no more works in Gedit.
The tags needs to be compresed in **".tags.gz"** format. Once compresed, you can copy the gz files to one of this two directories: */usr/share/gedit/plugins/taglist* or *~/.gnome2/gedit/taglist*

#### HIGHLIGHT MARCGedit
The highlight syntax of MARCMaker is activated if you use **marc.lang** file. You need to copy this file to */usr/share/gtksourceview-3.0/language-specs* or *~/.local/share/gtksourceview-3.0/language-specs* directory

#### EXTERNAL TOOLS
[External tools plugin](https://wiki.gnome.org/Apps/Gedit/Plugins/ExternalTools) allows to execute the tools created for MARCGedit listed below:
* MARC Maker -> convert MARCMaker records to MARC binary (ISO 2709) \[Ctrl-Alt-M\]
* Field 005 Date and Time -> generate date in format of Representation of Dates and Times (ISO 8601) \[Ctrl-Alt-D\]
* Change case -> Changes the case of characters in the selection \[Ctrl-Alt-C\]

To execute those tools you need to go to Tools -> External Tools or execute by shortcut key.
