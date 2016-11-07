use v6;
use XML::Document;
use XML;
use Test;

my $text = slurp('ARV8528FB-17091.xml');

#my $text = slurp('205682.xml');
#my $text = slurp('205884.xml');
my $xml = XML::Element.new($text);
ok $xml ~~ XML::Element, 'Element parsed properly.';

my @items = $xml.elements();
is @items.elems, 5, 'elements() returns correct number.';

my %h1;
my @a;
my $t;
for @items {
  if .name ~~ 'Templates' {
    @a = .elements();
    #say @a.elems;
    for @a -> $t {
      if $t.attribs<value> && $t.attribs<name> {
        #say $t.attribs<name> ~ " = " ~ $t.attribs<value>;
        %h1.push: ($t.attribs<name> => $t.attribs<value>);
        if $t.attribs<value>.contains("Error") {
          say "You have an error in your xml: " ~ $t.attribs<name>;
        }
        #say $t.attribs<value>;
      }
    }
  }
}

#say %h1{"DW_FloodLight"};
say %h1{"w"} ~ "x" ~ %h1{"l"};
say %h1{"l"};
#say %h1{"h"};
say %h1{"Generator_Choices_ProdGenPlate"};

my $key;

for %h1.keys.sort -> $key {
  if $key.contains("_Choices") {
    if !%h1{$key}.contains("NONE") {
      #say $key ~ " => " ~ %h1{$key};
    }
  }
  if $key.contains("Prod") {
    if !%h1{$key}.contains("PREP") {
      # This is the information we need to process the order
      say $key ~ " => " ~ %h1{$key};
    }
  }
}
