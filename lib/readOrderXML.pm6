unit module readOrderXML;
use XML;
use Test;

sub readXMLFile (@xmlFileList) is export  {
  my $xmlFile = slurp(@xmlFileList[0]);
  my $xml = XML::Element.new($xmlFile);
  #ok $xml ~~ XML::Element, 'Element parsed properly.';

  my @items = $xml.elements();
  #is @items.elems, 5, 'elements() returns correct number.';

  my %Order;
  my @orderElements;
  my $orderElementAttributes;
  for @items {
    if .name ~~ 'Templates' {
      @orderElements = .elements();
      for @orderElements -> $orderElementAttributes {
        if $orderElementAttributes.attribs<value> && $orderElementAttributes.attribs<name> {
          if $orderElementAttributes.attribs<name>.contains("Prod") {
          %Order.push: ($orderElementAttributes.attribs<name> => $orderElementAttributes.attribs<value>);
          }
          if $orderElementAttributes.attribs<name>.contains("WidthSpec") {
          %Order.push: ($orderElementAttributes.attribs<name> => $orderElementAttributes.attribs<value>);
          }
          if $orderElementAttributes.attribs<value>.contains("Error") {
            say "You have an error in your xml: " ~ $orderElementAttributes.attribs<name>;
          }
        }
      }
    }
  }
  my @trailerWidth = %Order{"WidthSpec"}.split('x');

  if @trailerWidth[0] ~~ '8.5' { %Order.push: ("trailerWidth85" => '1'); }
  else                         { %Order.push: ("trailerWidth70" => '1'); }

  my $trailerSize = %Order{"WidthSpec"};
  if %Order{"Package_FrontBedroom_Choices_Prod"} != 0 {
    $trailerSize = $trailerSize ~ "FB";
  }

  %Order.push: ('trailerSize' => $trailerSize);
  #say 'trailer size: ' ~ %Order{'trailerSize'};
  %Order;
}
