package Zarn::Helper::Files {
    use strict;
    use warnings;
    use File::Find::Rule;

    our $VERSION = '0.0.2';

    sub new {
        my ($self, $source, $ignore) = @_;

        if ($source) {
            my $rule = File::Find::Rule -> new();

            $rule -> or (
                $rule -> new -> directory -> name(".git", $ignore) -> prune -> discard,
                $rule -> new
            );

            $rule -> file -> nonempty;
            $rule -> name("*.pm", "*.t", "*.pl");

            my @files = $rule -> in($source);

            return @files;
        }

        return 0;
    }
}

1;