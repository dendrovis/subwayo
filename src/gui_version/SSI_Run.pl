% ------------------------------------------------------------------------------------------------
% Author :             Sam Jian Shen 
% Class :              TS4
% Assessment Title :   Subway Sandwich Interactor 
% Assignment Index :   Lab 3, Assignment - 3 
% Module Code :        CZ3005
% Version :            0.1 
% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
% Command Usage (for SSI_Run.pl)
% - 'run.' to execute the server (default:880) 
% - 'stop.' to stop the server
% - 'restart.' to restart the server
% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
% Server Initialize and Execution
% ------------------------------------------------------------------------------------------------
% Libraries needed to setup the server and web-based prolog
:- use_module(library(pengines)).				% Provides an infrastructure for creating Prolog engines in a (remote) pengine server and accessing these engines either from Prolog or JavaScript.
:- use_module(library(http/thread_httpd)).		% Threaded HTTP server
:- use_module(library(http/http_dispatch)).		% Dispatch requests in the HTTP server
:- use_module(library(http/http_path)).         % Abstract specification of HTTP server locations
:- use_module(library(http/http_server_files)). % Serve files needed by modules from the server 

% Root directory setup 
:- prolog_load_context(directory, Dir),
   asserta(user:file_search_path(app, Dir)).


user:file_search_path(apps, app(apps)).
http:location(apps, root(apps), []).

:- http_handler(apps(.), serve_files_in_directory(apps), [prefix]).

:- http_handler(/, http_redirect(moved, root(apps/'SSI.html')), []).

% Start the server
run :-
    http_server(http_dispatch,%
		[ port(880),  							 % using  port 8080 by default
		  workers(16) 							 % Defines the number of worker threads in the pool.
		]).

% Stop the server
stop :-
    http_stop_server(880, []).

% Restart the server
restart :-
    http_stop_server(880, []),
	consult(['SSI_Run']),
    http_server(http_dispatch,%
		[ port(880), 							 % using  port 8080 by default
		  workers(16)  							 % Defines the number of worker threads in the pool.
		]).