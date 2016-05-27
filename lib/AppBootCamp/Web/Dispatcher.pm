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
get '/login'  =>  'Page#get_login';
post '/login'  =>  'Page#post_login';
get '/discover' =>  'Page#get_discover';
post '/message/new' =>  'Page#post_message_new';
post '/message/edit'  =>  'Page#post_edit';
post '/message/delete'  =>  'Page#post_delete';
get '/logout' => 'Page#get_logout';
get '/profile' => 'Page#get_profile';
post '/profile' => 'Page#post_profile';
get '/:screen_name'=> 'Page#get_timeline';
1;
