# MARCGedit
An optional MARC Maker Editor for Linux environment. MARC Gedit is powered by Gedit text editor.

##MARCGedit works with the following technology:
* Gedit - official text editor of the GNOME desktop environment
* The MARC::* - series of modules create a simple object-oriented abstraction of MARC record handling.
* MARC::File::MARCMaker - work with MARCMaker/MARCBreaker records
* Zenity - display graphical dialog boxes from shell scripts
* GtkSourceView - shared libraries for the GTK+ syntax highlighting widget

##SNIPPETS
MARCGedit use the [Gedit snippets plugin](https://wiki.gnome.org/Apps/Gedit/Plugins/Snippets)
The file **marc.xml** needs to be copied to *~/.config/gedit/snippets* directory.
Snippets allow to introduce *MARC records or fixed fields* to the current text.

##TAGS FILES (Deprecated)
Tags plugin no more works in Gedit.
The tags needs to be compresed in **"*.tags.gz"** format
Once compresed, you can copy the gz files to one of this two directories:
```
/usr/share/gedit/plugins/taglist
or
~/.gnome2/gedit/taglist
```

##HIGHLIGHT MARCGedit
The highlight syntax of MARCMaker is activated if you use **marc.lang** file. You need to copy this file to */usr/share/gtksourceview-3.0/language-specs* directory

##EXTERNAL TOOLS
[External tools plugin](https://wiki.gnome.org/Apps/Gedit/Plugins/ExternalTools) allow to execute the tools created for MARCGedit listed below:
* MARC Maker -> convert MARCMaker records to MARC binary (ISO 2709)
* Field 005 Date and Time -> generate date in format of Representation of Dates and Times (ISO 8601)

To execute those tools you need to go to Tools -> External Tools

######You need to install the following modules (debian environment):
```
$ apt-get install libmarc-record-perl libmarc-file-marcmaker-perl zenity zenity-common gedit gedit-common gedit-plugins
```

######Running the application locally
```
$ git clone https://github.com/hecaxmmx/MARCGedit.git
$ cd MARCGedit
$ cp snippets/. ~/.config/gedit/snippets
$ cp tools/. ~/.config/gedit/tools
$ sudo cp marc.lang /usr/share/gtksourceview-3.0/language-specs
```
> Note: If snippets and tools directories does not exist please create manually.

######Setting Gedit
1. Open Gedit text editor normally
2. Enable External Tools, goto Preferences -> Plugins -> External Tools
3. Enable Snippets, goto Preferences -> Plugins -> Snippets
4. Enable Snippets, goto Preferences -> Plugins -> Draw spaces
5. Enable line number, goto Preferences -> View -> Display line numbers
6. Enable highlight line, goto Preferences -> View -> Highlight current line
7. Choose View -> Highlight -> MARC (This is required)

######Setting Gedit
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

