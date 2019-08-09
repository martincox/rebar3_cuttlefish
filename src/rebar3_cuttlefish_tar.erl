-module(rebar3_cuttlefish_tar).

-behaviour(provider).

-export([init/1,
         do/1,
         format_error/1]).

-define(PROVIDER, tar).
-define(NAMESPACE, default).

%% ===================================================================
%% Public API
%% ===================================================================

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    State1 = rebar_state:add_provider(State, 
                                      providers:create([{name, ?PROVIDER},
                                        {module, ?MODULE},
                                        {namespace, ?NAMESPACE},
                                        {bare, true},
                                        {example, "rebar3 tar"},
                                        {short_desc, "Tar archive of release built of project."},
                                        {desc, "Tar archive of release built of project."},
                                        {opts, relx:opt_spec_list()}])),
    {ok, State1}.

-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
    rebar_relx:do(rlx_prv_release, "tar", ?PROVIDER, State).

-spec format_error(any()) -> iolist().
format_error(Reason) ->
    io_lib:format("~p", [Reason]).

