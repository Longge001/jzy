%% ---------------------------------------------------------------------------
%% @doc lib_node_model

%% @author  lzh
%% @email   lu13824949032@gmail.com
%% @since   2021/8/17 0017
%% @desc    改变模型
%% ---------------------------------------------------------------------------
-module(lib_node_model).

-behaviour(lib_node_action).

%% API
-export([action/5, re_action/5, action_call_back/6]).

-include("common.hrl").
-include("server.hrl").
-include("scene.hrl").
-include("scene_object_btree.hrl").

action(State, StateName, Node, _Now, _TickGap) when is_record(State, ob_act) ->
    #action_node{args = Args} = Node,
    case Args of
        [{model_id, ModelId}|_] ->
            #ob_act{object = SceneObj} = State,
            NewSceneObj = lib_scene_object_ai:change_model(SceneObj, ModelId),
            lib_scene_object:insert(NewSceneObj),
            {State#ob_act{object = NewSceneObj},StateName , ?BTREESUCCESS};
        _ ->
            {State,StateName , ?BTREEFAILURE}
    end.

re_action(State, StateName, _Node, _Now, _TickGap) ->
    {State,StateName , ?BTREESUCCESS}.

action_call_back(_State, _StateName, _Node, _NowTime, _, _) ->
    skip.
