-module(pt_161).
-include("common.hrl").
-export([
    read/2,
    write/2
]).

read(16102, _) ->
    {ok, []};
read(16103, Bin0) ->
    <<IllusionId:32, _Bin1/binary>> = Bin0, 
    {ok, [IllusionId]};
read(16104, Bin0) ->
    <<Type:8, _Bin1/binary>> = Bin0, 
    {ok, [Type]};
read(16105, Bin0) ->
    <<TypeId:32, Bin1/binary>> = Bin0, 
    <<Auto:8, _Bin2/binary>> = Bin1, 
    {ok, [TypeId, Auto]};
read(16106, Bin0) ->
    <<Id:32, _Bin1/binary>> = Bin0, 
    {ok, [Id]};
read(16107, _) ->
    {ok, []};
read(16108, Bin0) ->
    <<Id:32, _Bin1/binary>> = Bin0, 
    {ok, [Id]};
read(16109, Bin0) ->
    <<Id:32, _Bin1/binary>> = Bin0, 
    {ok, [Id]};
read(16110, Bin0) ->
    <<TypeId:32, _Bin1/binary>> = Bin0, 
    {ok, [TypeId]};
read(16111, _) ->
    {ok, []};
read(_Cmd, _R) -> {error, no_match}.

write (16100,[
    Errcode
]) ->
    Data = <<
        Errcode:32
    >>,
    {ok, pt:pack(16100, Data)};

write (16101,[
    RoleId,
    FigureId
]) ->
    Data = <<
        RoleId:64,
        FigureId:32
    >>,
    {ok, pt:pack(16101, Data)};

write (16102,[
    Lv,
    Exp,
    IllusionId,
    AttrList,
    Combat,
    DisplayStatus,
    SkillList
]) ->
    BinList_AttrList = [
        item_to_bin_0(AttrList_Item) || AttrList_Item <- AttrList
    ], 

    AttrList_Len = length(AttrList), 
    Bin_AttrList = list_to_binary(BinList_AttrList),

    BinList_SkillList = [
        item_to_bin_1(SkillList_Item) || SkillList_Item <- SkillList
    ], 

    SkillList_Len = length(SkillList), 
    Bin_SkillList = list_to_binary(BinList_SkillList),

    Data = <<
        Lv:8,
        Exp:32,
        IllusionId:32,
        AttrList_Len:16, Bin_AttrList/binary,
        Combat:32,
        DisplayStatus:8,
        SkillList_Len:16, Bin_SkillList/binary
    >>,
    {ok, pt:pack(16102, Data)};

write (16103,[
    Errcode,
    IllusionId
]) ->
    Data = <<
        Errcode:32,
        IllusionId:32
    >>,
    {ok, pt:pack(16103, Data)};

write (16104,[
    Errcode,
    Type
]) ->
    Data = <<
        Errcode:32,
        Type:8
    >>,
    {ok, pt:pack(16104, Data)};

write (16105,[
    Errcode,
    Lv,
    Exp,
    ExpPlus
]) ->
    Data = <<
        Errcode:32,
        Lv:16,
        Exp:32,
        ExpPlus:32
    >>,
    {ok, pt:pack(16105, Data)};

write (16106,[
    Errcode,
    Star,
    Id
]) ->
    Data = <<
        Errcode:32,
        Star:8,
        Id:32
    >>,
    {ok, pt:pack(16106, Data)};

write (16107,[
    Errcode,
    FigureId,
    FigureList
]) ->
    BinList_FigureList = [
        item_to_bin_2(FigureList_Item) || FigureList_Item <- FigureList
    ], 

    FigureList_Len = length(FigureList), 
    Bin_FigureList = list_to_binary(BinList_FigureList),

    Data = <<
        Errcode:32,
        FigureId:32,
        FigureList_Len:16, Bin_FigureList/binary
    >>,
    {ok, pt:pack(16107, Data)};

write (16108,[
    Errcode,
    Id
]) ->
    Data = <<
        Errcode:32,
        Id:32
    >>,
    {ok, pt:pack(16108, Data)};

write (16109,[
    Errcode,
    Id,
    Star,
    AttrList,
    Combat
]) ->
    BinList_AttrList = [
        item_to_bin_3(AttrList_Item) || AttrList_Item <- AttrList
    ], 

    AttrList_Len = length(AttrList), 
    Bin_AttrList = list_to_binary(BinList_AttrList),

    Data = <<
        Errcode:32,
        Id:32,
        Star:8,
        AttrList_Len:16, Bin_AttrList/binary,
        Combat:32
    >>,
    {ok, pt:pack(16109, Data)};

write (16110,[
    Errcode,
    TypeId
]) ->
    Data = <<
        Errcode:32,
        TypeId:32
    >>,
    {ok, pt:pack(16110, Data)};

write (16111,[
    CounterList
]) ->
    BinList_CounterList = [
        item_to_bin_4(CounterList_Item) || CounterList_Item <- CounterList
    ], 

    CounterList_Len = length(CounterList), 
    Bin_CounterList = list_to_binary(BinList_CounterList),

    Data = <<
        CounterList_Len:16, Bin_CounterList/binary
    >>,
    {ok, pt:pack(16111, Data)};

write(_Cmd, _R) -> ?DEBUG("no_match:~p,~p~n", [_Cmd, _R]), {ok, pt:pack(0, <<>>)}.


item_to_bin_0 ({
    AttrId,
    AttrVal
}) ->
    Data = <<
        AttrId:8,
        AttrVal:32
    >>,
    Data.
item_to_bin_1 (
    SkillId
) ->
    Data = <<
        SkillId:32
    >>,
    Data.
item_to_bin_2 ({
    Id,
    Star
}) ->
    Data = <<
        Id:32,
        Star:8
    >>,
    Data.
item_to_bin_3 ({
    AttrId,
    AttrVal
}) ->
    Data = <<
        AttrId:8,
        AttrVal:32
    >>,
    Data.
item_to_bin_4 ({
    GoodsId,
    Times,
    TimesLim
}) ->
    Data = <<
        GoodsId:32,
        Times:16,
        TimesLim:16
    >>,
    Data.
