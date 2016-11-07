use v6;
use XML;

my %dict;

say 'start IO';
my @lines = eager open('ARV.xml', :r).lines;
say 'done IO';

say 'start processing';
for @lines { say "."; }
say 'done processing';

my $xmlFileName = "ARV.xml";
my $xmlFile = slurp($xmlFileName);
say 'done processing2';
my $xml = XML::Element.new($xmlFile);
say 'done processing3';
my @items = $xml.elements();
abc(@items);
say 'done processing4';

sub abc(@a) {

    say "Number of Elements: " ~ @a.elems;
    for @a {
      say "Name: " ~ .name;
      say .attribs;
      say "Attribute Name: " ~ .attribs<name>; #~ " " ~
      say "Attribute Value: " ~ .attribs<value>;
      my @b = .elements();
      abc(@b);
    }
}
