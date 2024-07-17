sub _IsValidEmail {
    my $Email = shift;

    # Simple regex for basic email validation
    return $Email =~ /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
}
