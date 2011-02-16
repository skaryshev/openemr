#!usr/bin/perl
#######################################################################
# Copyright (C) skaryshev
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#######################################################################
# This script iterates through ICD10 codes dumping them to stdout.
# You can modify the script to generate SQL INSERT statements.
#######################################################################
# The ICD10 XML Data files for 2011 are at:
# ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10CM/2011/
# Get the icd10cm_xml_2011.zip file and extract the icd10cm_tabular_2011.xml
#######################################################################

use strict;
use XML::LibXML 1.70; #http://search.cpan.org/~pajas/XML-LibXML-1.70/

my $dom;
eval{
   $dom = XML::LibXML->load_xml( location => 'icd10cm_tabular_2011.xml' );
};
if ($@){
  die "\n" . $@ . "Please download icd10cm_xml_2011.zip from cdc ftp site: \n" .
  "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10CM/2011/icd10cm_xml_2011.zip \n" .
  "and extract icd10cm_tabular_2011.xml file \n\n";
}

my @diag = $dom->getElementsByTagName('diag');
foreach (@diag){
  my @name = $_->getChildrenByTagName('name');
  my @desc = $_->getChildrenByTagName('desc');
  print @name[0]->textContent . "\t";
  print @desc[0]->textContent . "\n";
}
print @diag . " entries processed \n";
1;
