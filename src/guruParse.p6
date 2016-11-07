use v6;
use XML;
use Test;

# Read standard work file: csvFile
# Read Hendrix Order Export: xmlFile

# Generate VIN Specific Standard Work File: csv Format

my $xmlFileName = "ARV.xml";

my $xmlFile = slurp($xmlFileName);
my $xml = XML::Element.new($xmlFile);
ok $xml ~~ XML::Element, 'Element parsed properly.';

my @items = $xml.elements();
is @items.elems, 5, 'elements() returns correct number.';

for @items {
  .say;
}
