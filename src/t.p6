use v6;
use XML::Document;
use XML;
use Test;

my $text = slurp('ARV7020-17086.xml2');
my $xml = XML::Element.new($text);
ok $xml ~~ XML::Element, 'Element parsed properly.';

my @items = $xml.elements();
is @items.elems, 5, 'elements() returns correct number.';

#say "here" ~ " I" ~ "'am " ~ @items.[4];
#say @items.[4].name;
#is @items[4].elems, 2, 'element cnt';
#say @items.^methods;
#say @items.^perl;
my @a;
for @items {
  say .name;
  if .name ~~ 'Templates' {
    say 'here';
    @a = .elements();
    say @a.elems;
    for @a {
      say .name;
      say .attribs;
      say .attribs<name>; #~ " " ~
      say .attribs<value>;
    }
  }
  say .elems;
  say .attribs;
}


my $name = 'Templates';
#my @asd = getElementsByTagName($name, :$xml)
#say @asd.elems;
say "there";
my $var;
for @items -> $var {
#  $var.say;
#  if $var ~~ '*Templates*' { say "here";}
}
#say $xml.nodes[4].elements();
#my $xml2 = from-xml-file('a.xml');

#my %h;

#say $xml.^methods;
#say $xml.gist;
#say $xml.doctype;
#say $xml.encoding;
#say $xml.version;

#say $xml2.root.^methods;
#say $xml2.root.firstChild;
#say $xml2.root.elements.^methods;
#say $xml2.root.elements.name;
#say $xml2.root.elements.gist;
#say $xml2.root.getElementById('PriceAdjustmentSet/')

#say $xml.previousSibling;
#say $xml.nextSibling;
#say $xml.nextSibling;
#say $xml.firstChild;
#say $xml[0];

#for 'ConstraintLogic/BusinessLogic8528.csv'.IO.lines -> $line {
    #my @t = $line.split(',');
    #%h.push: (@t[0] => @t[1]);
    #%h.push: (@t[1] => @t[0]);
#}

# JSON Format
#say "[";
#for %h.keys.sort -> $key {
#    say "\"$key\",\n [\"%h{$key}.join('", "')\"],";
#}
#say "]";

# Array Format
#say "var ConstraintLogic = \{";
#for %h.keys.sort -> $key {
#    say "\"$key\": [\"%h{$key}.join('", "')\"],";
#}
#say "\};";
