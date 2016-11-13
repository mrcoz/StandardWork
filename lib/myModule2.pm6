# lib/MyModule.pm

class MyModule2::Class { ... }

sub EXPORT {
    {
     '$var'   => 'one',
     '@array' => <one two three>,
     '%hash'  => { one => 'two', three => 'four' },
     '&doit'   => sub { ... },
     'ShortName' => MyModule::Class
    }
}
