use v6;
use lib 'lib';
use setDefaults;
use readOrderXML;
use readTaskCsv;
use createProdCycle;

say "Directory $vinDir exists: " ~ $vinDir.IO.e;
say "Directory $prodTackDir exists: " ~ $prodTackDir.IO.e;
say "Directory $prodScheduleDir exists: " ~ $prodScheduleDir.IO.e;
my $fh = open "prodSchedule.csv", :w;

for @ProductionCycle1 -> %h {
  my $xmlFileName = %h.keys.Str;
  my $csvFileName = %h.values.Str;
  #say "xml: " ~ $xmlFileName;
  #say "csv: " ~ $csvFileName;
  my %Order;
  my %standardWork;
  my @configOrder;

  my @xmlFileList = $vinDir.IO.dir(test => /^ $xmlFileName /)».Str;   # ^ - matches at start of string
  my @csvFileList = $prodTackDir.IO.dir(test => /^ $csvFileName /)».Str;   # ^ - matches at start of string

  if (@xmlFileList) { }
    else { say 'problems: ' ~ $xmlFileName; }

  if @xmlFileList[0].IO.f && @csvFileList[0].IO.f {
    %Order = readXMLFile(@xmlFileList);
    %standardWork = readProcessTasks(@csvFileList);
    @configOrder = createCsvFile(%standardWork, %Order, $xmlFileName);
    #$fh.say(@configOrder);
    #say @configOrder.elems;
    for @configOrder -> $rows {
        $fh.say($rows);
    }
    @configOrder = [];
  }
  else {
    say "xml file doesn't exist";
  }
}
$fh.close;
