# Modify site home page for dw-nonfree content (views/homepage/*.tt)
#
# Authors:
#     Jen Griffin <kareila@livejournal.com>
#
# Copyright (c) 2017 by Dreamwidth Studios, LLC.
#
# This program is NOT free software or open-source; you can use it as an
# example of how to implement your own site-specific extensions to the
# Dreamwidth Studios open-source code, but you cannot use it on your site
# or redistribute it, with or without modifications.
#

package DW::Hooks::HomePage;

use strict;

use LJ::Hooks;
use DW::InviteCodes;
use LJ::Faq;
use DW::Panel;

# for logged-out homepage
LJ::Hooks::register_hook( 'custom_homepage_anon', sub {
    my $rv = $_[0];  # controller variables
    # modify $rv as needed
    $rv->{invite_code_len} = DW::InviteCodes::CODE_LEN;
    $rv->{use_invites} = $LJ::USE_ACCT_CODES;
    $rv->{use_payments} = LJ::is_enabled( 'payments' );
    $rv->{codeshare_u} = LJ::load_user( 'dw_codesharing' );
    $rv->{news_u} = LJ::load_user( 'dw_news' );
    $rv->{faq_url} = sub { LJ::Faq->url( $_[0] ) };

    return $rv;
} );

# for logged-in homepage
LJ::Hooks::register_hook( 'custom_homepage_user', sub {
    my $rv = $_[0];  # controller variables
    # modify $rv as needed
    $rv->{panels} = DW::Panel->init( u => $rv->{remote} );

    return $rv;
} );


1;
