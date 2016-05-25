package AppBootCamp::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use DDP;
use CGI;
use Amon2::Web::Dispatcher::RouterBoom;
use AppBootCamp::Repository::User;

use AppBootCamp::Web::C::Page;
base 'AppBootCamp::Web::C';

get '/signup' =>  'Page#get_signup';
post '/signup' => 'Page#post_signup';
get '/timeline'=> 'Page#get_timeline';
post '/message/new' =>  'Page#post_message_new';
post '/message/edit'  =>  'Page#post_edit';

1;
