unit module readTaskCsv;

sub readProcessTasks(@csvFileList,$xmlFileName,%Order) is export {
  my %standardWork;
  my $cnt = 0;
  my $colCnt = 0;
  my @columnName;

  for @csvFileList[0].IO.lines -> $line {
      my @standardWorkItem = $line.split(',');
      #say 'standard work: ' ~ @standardWorkItem[2];
      if @standardWorkItem[2] {
        if $cnt == 0 { # Set 1st Row as Key for column
          @columnName = @standardWorkItem;
          $cnt++;
        }
        for @columnName -> $standardWorkHeader {
          %standardWork.push: ($standardWorkHeader => @standardWorkItem[$colCnt]);
          $colCnt++;
        }
        $colCnt = 0;
      }
    }
  }
