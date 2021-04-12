use Test::More;
use Plack::Test;
use Plack::App::WWW;
use HTTP::Request::Common;

my $app = Plack::App::WWW->new(root => "t/www")->to_app;
ok $app;

test_psgi $app, sub {
    is $_[0]->(GET "/foo.pl")->content, 1;
    is $_[0]->(GET "/baz.cgi")->content, 2;
    like $_[0]->(GET "/bar.html")->content, qr/Ok/;
    is $_[0]->(GET "/test")->content, 'index';
    like $_[0]->(GET "/directory")->content, qr/Redirect/;
    like $_[0]->(GET "/directory/")->content, qr/Parent Directory/;
};

done_testing;
