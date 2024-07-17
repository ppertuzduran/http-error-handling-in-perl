sub _ValidateParameters {
    my ($Self, %Param) = @_;

    # Define required parameters with field names for error messages
    my %RequiredParams = (
        CustomerUserEmail  => 'CustomerUser.CustomerUserEmail',
        UserLogin          => 'UserLogin',
        Password           => 'Password',
    );

    # Iterate over required parameters and check if they exist (hash param version)
    foreach my $param (keys %RequiredParams) {

        #(hash param version)
        my @keys = split(/\./, $RequiredParams{$param});
        my $value = $Param{Data};
        
        for my $key (@keys) {
            $value = $value->{$key};
            last unless defined $value;
        }

        unless ( $value ) {

            $Self->_SimpleErrorResponse(
                ErrorCode    => 'WebCustomerSearch.BadRequest',
                Field        => $RequiredParams{$param},
                ErrorMessage => "$RequiredParams{$param} is required or is not valid!",
                StatusCode   => 400,
            );
        }
    }

    return 1;  # All required parameters are valid
}
