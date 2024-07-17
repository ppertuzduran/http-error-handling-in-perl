sub _SimpleErrorResponse {
    my ($Self, %Param) = @_;

    # Ensure required parameters are provided
    for my $arg (qw(ErrorCode Field ErrorMessage StatusCode)) {
        die "Missing required parameter: $arg" unless defined $Param{$arg};
    }

    # Create the error message content
    my $Output = encode_json({
        Success      => 0,
        Data         => {
            Error => {
                ErrorCode    => $Param{ErrorCode},
                Field        => $Param{Field},
                ErrorMessage => $Param{ErrorMessage},
            },
        },
    });

    # Create the Plack response object with provided status code
    my $PlackResponse = Plack::Response->new(
        $Param{StatusCode},     # HTTP status code
        $Kernel::OM->Get('Kernel::System::Web::Response')->Headers(),  # Headers
        $Output  # Body content
    );

    # Log the error
    $Self->{DebuggerObject}->DebugLog(
        DebugLevel => 'info',
        Summary    => 'Bad Request',
        Data       => {
            ErrorCode    => $Param{ErrorCode},
            Field        => $Param{Field},
            ErrorMessage => $Param{ErrorMessage},
        }
    );

    # The exception is caught by Plack::Middleware::HTTPExceptions
    die Kernel::System::Web::Exception->new(
        PlackResponse => $PlackResponse
    );
}
