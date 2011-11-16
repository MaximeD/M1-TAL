package Validate; # use package to declare a module

sub validate_date {
    my $val = shift;
    return() unless 
        $val =~ /^(\d{2})-(\d{2})-(\d{4})$/;
    return "$3-$1-$2";
}

sub validate_time {
    my $val = shift;
    return() unless 
        $val =~ /^(\d{2}):(\d{2}) (am|pm)$/i;
    return uc("$1:$2 $3");
}

1;
